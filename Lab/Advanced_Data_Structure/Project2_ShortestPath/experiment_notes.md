# 实验说明与算法深度解析：Shortest Path Algorithm with Heaps

**浙江大学《高级数据结构与算法分析》（Advanced Data Structures and Algorithm Analysis）课程 Project 8-1**

---

## 目录

1. [项目背景与核心目标](#1-项目背景与核心目标)
2. [算法与数据结构深度解析](#2-算法与数据结构深度解析)
   - [2.1 Dijkstra 最短路径算法](#21-dijkstra-最短路径算法)
   - [2.2 二叉最小堆（Binary Min-Heap）](#22-二叉最小堆binary-min-heap)
   - [2.3 真正的斐波那契堆（Fibonacci Heap）](#23-真正的斐波那契堆fibonacci-heap)
3. [核心谜题：为什么斐波那契堆理论更快，实测却更慢？](#3-核心谜题为什么斐波那契堆理论更快实测却更慢)
4. [工程架构与关键代码实现细节](#4-工程架构与关键代码实现细节)
   - [4.1 图的前向星（链式前向星）邻接表](#41-图的前向星链式前向星邻接表)
   - [4.2 循环双向链表与指针安全性](#42-循环双向链表与指针安全性)
   - [4.3 级联剪枝（Cascading Cut）与度数合并（Consolidate）](#43-级联剪枝cascading-cut与度数合并consolidate)
   - [4.4 公平计时与高精度时钟](#44-公平计时与高精度时钟)
5. [实验流程与测试指南](#5-实验流程与测试指南)
6. [英文正式报告（report.md）导读](#6-英文正式报告reportmd导读)

---

## 1. 项目背景与核心目标

在单源最短路径（Single-Source Shortest Path, SSSP）问题中，Dijkstra 算法是最基础且应用最广泛的经典算法之一。它的时间复杂度高度依赖于底层**优先队列（Priority Queue）**的选择：

- **朴素数组实现**：每次扫描所有未确定顶点寻找最小值，时间复杂度为 $O(V^2)$。当顶点规模达到数十万（如真实的城市道路网）时，单次查询需要数分钟甚至更久，完全无法实用。
- **二叉最小堆（Binary Min-Heap）**：将提取最小值和降低键值（Decrease-Key）的时间均优化为 $O(\log V)$，算法总体时间复杂度为 $O((V + E) \log V)$。
- **斐波那契堆（Fibonacci Heap）**：利用惰性合并（Lazy Merging）与级联剪枝机制，将插入、降低键值的摊还复杂度降至 $O(1)$，仅提取最小值需要 $O(\log V)$ 摊还时间，将 Dijkstra 的理论总体时间复杂度推进到理论极限 **$O(E + V \log V)$**。

本项目的核心目标是：
1. **用纯 C 语言（C11 标准）自行实现真正的斐波那契堆**，严禁使用二叉堆包装或现成第三方库；
2. 实现二叉最小堆及带位置追踪的 $O(\log V)$ Decrease-Key 操作；
3. 基于美国真实道路网络（9th DIMACS Implementation Challenge）进行大规模基准测试（至少 1000 对随机起终点查询）；
4. 通过理论与实测数据的对比，深入剖析**渐近复杂度（Asymptotic Complexity）与实际运行常数（Constant Factors / Hardware Locality）之间的现实脱节现象**。

---

## 2. 算法与数据结构深度解析

### 2.1 Dijkstra 最短路径算法

Dijkstra 算法基于贪心策略（Greedy Strategy）与距离标号松弛（Relaxation）。

#### 前提条件与正确性保证
**边权必须非负（$w(u, v) \ge 0$）**。
- 若存在负权边，贪心选择的最短距离性质不再成立，已经确定（settled）的最短路顶点可能会被后续更负的路径更新。
- 在本工程中，读取 `.gr` 文件时会对边权进行严格非负检查（$w < 0$ 立即报错退出）。

#### 松弛操作（Edge Relaxation）
对于边 $(u, v)$，若：
$$\text{dist}[u] + w(u, v) < \text{dist}[v]$$
则更新 $\text{dist}[v] = \text{dist}[u] + w(u, v)$。
- 若顶点 $v$ 已在优先队列中，触发堆的 **`Decrease-Key`** 操作；
- 若顶点 $v$ 尚未入队且未确定最短路，将 $v$ 插入堆中。

---

### 2.2 二叉最小堆（Binary Min-Heap）

二叉堆是一棵完全二叉树，本项目采用 1-based 数组实现：
- 节点 $i$ 的父节点为 $\lfloor i / 2 \rfloor$；
- 左孩子为 $2i$，右孩子为 $2i + 1$。

#### 为什么需要 `pos[]` 数组？
标准二叉堆如果不知道元素在数组中的下标，定位某个顶点需要 $O(V)$ 的线性查找，导致 `Decrease-Key` 退化为 $O(V)$。
本项目引入 `pos[vertex]` 映射表：
- `pos[v] == -1`：顶点 $v$ 当前不在堆中；
- `pos[v] >= 1`：顶点 $v$ 位于 `heap[pos[v]]`。
每次在堆中发生元素交换（`heap_swap`）或移动时，必须**原子化同步更新 `pos` 数组**：
```c
static void heap_swap(BinaryHeap *h, int i, int j) {
    int u = h->heap[i];
    int v = h->heap[j];
    h->heap[i] = v;
    h->heap[j] = u;
    h->pos[u] = j;
    h->pos[v] = i;
}
```
这使得二叉堆的 `Decrease-Key` 能够在 $O(1)$ 时间定位节点，并在 $O(\log V)$ 时间完成向上调整（`sift_up`）。

---

### 2.3 真正的斐波那契堆（Fibonacci Heap）

斐波那契堆是由 Michael L. Fredman 与 Robert E. Tarjan 于 1987 年提出的一种由一组树构成的集合（森林）。其树结构不一定是二项树，节点度数（degree）与孩子数量受到标记（mark）与剪枝规则的约束。

#### 节点结构体设计
```c
typedef struct FibNode {
    int vertex;                 /* 顶点编号 */
    long long key;              /* 键值（Dijkstra 当前距离） */
    int degree;                 /* 子节点数量 */
    int mark;                   /* 标记位：自成为子节点后是否失去过孩子 */
    struct FibNode *parent;     /* 父节点指针 */
    struct FibNode *child;      /* 指向任意一个子节点的指针 */
    struct FibNode *left;       /* 循环双向链表中的左兄弟 */
    struct FibNode *right;      /* 循环双向链表中的右兄弟 */
} FibNode;
```

#### 关键操作机制

1. **Insert（惰性插入）**：
   新节点直接作为一个孤立的单节点树加入根链表，更新最小节点指针 `min_node`。时间复杂度仅为 $O(1)$。

2. **Decrease-Key 与 Cut / Cascading Cut（级联剪枝）**：
   - 减小节点 $x$ 的键值为 `new_key`；
   - 若 $x$ 不是根且 $x\text{->key} < x\text{->parent->key}$（违反了最小堆性质），则执行 `cut(fh, x, y)`：
     - 将 $x$ 从父节点 $y$ 的孩子链表中切除；
     - 将 $x$ 加入根链表，清空标记 `x->mark = 0`，`x->parent = NULL`；
     - 触发父节点 $y$ 的级联剪枝 `cascading_cut(fh, y)`：
       - 若 $y$ 是根节点，直接返回；
       - 若 $y\text{->mark} == 0$，将其标记置为 1（表示失去了一个孩子）；
       - 若 $y\text{->mark} == 1$（此前已失去过孩子），则将 $y$ 也切下并加入根链表，递归向上对 $y\text{->parent}$ 进行级联剪枝！
   正是这种机制保证了任何包含 $k$ 个孩子的节点所对应的子树规模至少是斐波那契数 $F_{k+2}$，从而限制了最大度数不超过 $O(\log N)$。

3. **Extract-Min 与 Consolidate（合并清理）**：
   - 将当前最小根节点 `min_node` 移除，其所有子节点被“提升”并入根链表；
   - **Consolidate**：将根链表中度数相同的树两两配对合并，使较小根成为较大根的父节点，直到所有根的度数互不相同；
   - 维护一个度数数组 `A[0..63]`。在遍历根链表前，**必须先将根指针提取到数组中**，防止在修改双向链表时发生循环指针失效（Dangling/Invalidated pointer dereference）。

---

## 3. 核心谜题：为什么斐波那契堆理论更快，实测却更慢？

在理论分析中：
- 二叉堆松弛 $E$ 条边的总开销为 $O(E \log V)$；
- 斐波那契堆松弛 $E$ 条边的总开销仅为 $O(E \times 1) = O(E)$；
在 $E \gg V$ 的密集图中，斐波那契堆理论上具备显著优势。

**但在美国道路网络（USA Road Networks）的实测中，二叉堆通常比斐波那契堆快 2 到 4 倍！** 造成这一现象的原因包含以下四个工程与体系结构核心维度：

### 维度 1：现代 CPU 缓存局部性（Cache Locality）
- **二叉堆**存储在连续的线性数组 `heap[]` 和 `pos[]` 中。在 `sift_up` 和 `sift_down` 过程中，连续内存能够充分利用 CPU L1/L2 Cache 行（Cache Line Prefetching），缓存命中率极高。
- **斐波那契堆**由大量独立的堆内存节点（`malloc` 分配的 `FibNode`）和错综复杂的指针构成（每个节点包含 4 个指针：`left`, `right`, `parent`, `child`）。每次指针跳转都会引发一次潜在的 CPU Cache Miss，访存延迟（DRAM Access Latency）远远抵消了计算指令节省的开销。

### 维度 2：动态内存管理（Dynamic Memory Allocation Overhead）
- 在单次 Dijkstra 查询中，访问成千上万个节点意味着成千上万次 `malloc()` 和 `free()` 调用。系统内存分配器的元数据维护、锁竞争和堆管理成本高昂。
- 二叉堆在整个算法执行期间**仅分配一次固定大小的数组**，运行期间无任何动态内存申请。

### 维度 3：道路网络的平面图稀疏性（Planar Sparsity）
- 美国道路网络本质上是近乎平面图的物理路网，平均顶点度数非常低（纽约路网平均出度仅为 $E / V \approx 733846 / 264346 \approx 2.78$）。
- 由于每个顶点的出边极少，引发有效的 `Decrease-Key` 的次数远远少于密集图。
- 斐波那契堆 $O(1)$ `Decrease-Key` 的优势无从发挥，却必须为每次 `Extract-Min` 承受极其沉重的 `Consolidate` 度数合并与链表维护负担。

### 维度 4：常数因子（Constant Factors）
- 二叉堆上滤/下滤操作只涉及简单的整数比较和数组交换，指令条数极少；
- 斐波那契堆在插入、提取、级联剪枝和重构根链表时涉及大量分支判断、指针重连和结构体维护，常数因子显著大于二叉堆。

---

## 4. 工程架构与关键代码实现细节

### 4.1 图的前向星（链式前向星）邻接表
针对 DIMACS `.gr` 格式，我们采用向前星数组：
- `head[u]` 存储顶点 $u$ 第一条出边在 `edges` 数组中的下标；
- `edges[i].next` 指向同一条邻接链中的下一条出边下标；
- 空间复杂度严格为 $O(V + E)$，相比指针链表连续性好得多，且没有顶点指针开销。

### 4.2 循环双向链表与指针安全性
斐波那契堆中的同级兄弟节点均组织为双向循环链表：
- 节点自环：单个节点时 `node->left = node; node->right = node;`；
- 插入兄弟：
  ```c
  node->right = min_node->right;
  node->left = min_node;
  min_node->right->left = node;
  min_node->right = node;
  ```
- 切除节点：
  ```c
  x->left->right = x->right;
  x->right->left = x->left;
  ```
在 `fib_heap_free` 时，必须先切断环路成普通单向链表，然后递归释放所有子树，杜绝内存泄漏（Zero Leaks）。

### 4.3 级联剪枝（Cascading Cut）与度数合并（Consolidate）
在 `fib_heap_consolidate` 中，由于链接操作会不断修改根链表中的 `left` 和 `right` 指针，如果直接在原循环链表上 `while(curr != min)` 遍历，指针被修改会导致无限循环或段错误。
**我们的解决方案**：
先遍历一轮，将当前根链表的所有根指针拷贝到局部动态数组 `roots[]` 中，然后遍历该数组执行配对合并，彻底消除指针失效隐患。

### 4.4 公平计时与高精度时钟
- Windows 平台使用 `QueryPerformanceCounter` 与 `QueryPerformanceFrequency`，计时精度达到亚微秒级（< 0.1 $\mu$s）；
- 图数据与查询文件在基准测试循环外只加载一次；
- 两种堆面对完全相同的起点和终点，采用完全一致的终止条件（目标顶点确定即可提前终止）；
- 每次查询后，对两种堆得到的最短距离进行逐一比对（`binary_results[i] == fib_results[i]`），一旦出现不一致立即告警并标记失败。

---

## 5. 实验流程与测试指南

### 5.1 自动化全套单元测试
执行：
```powershell
powershell -ExecutionPolicy Bypass -File build/test.ps1
```
涵盖：
1. `test_graph`：图加载、DIMACS 语法检查、负权拦截、格式容错；
2. `test_binary_heap`：二叉堆插入、排序提取、位置同步 `pos[]`、堆性质自检；
3. `test_fibonacci_heap`：双向链表完整性、`Cut`、`Cascading Cut`、度数合并、与参考模型比对随机压力测试；
4. `test_dijkstra`：已知图答案核验（$1 \to 5$ 距离 10，$5 \to 1$ 不可达）、自环为 0、多路径同长；
5. `test_heap_comparison`：随机生成稠密/稀疏/零权图，比较朴素 Dijkstra、二叉堆、斐波那契堆，三者答案必须 100% 相同。

### 5.2 运行大规模性能评估
```bash
# 1. 编译
powershell -ExecutionPolicy Bypass -File build/build.ps1

# 2. 生成 1000 对随机查询
python scripts/generate_queries.py --vertices 264346 --count 1000 --seed 42 --output data/queries/NY_random.p2p

# 3. 运行 Benchmark 测试
./shortest_path.exe benchmark data/road/USA-road-d.NY.gr data/queries/NY_random.p2p results/benchmark_raw.csv 1

# 4. 统计与分析
python scripts/analyze_results.py

# 5. 生成 300 DPI 论文级图表
python scripts/plot_results.py
```

---

## 6. 英文正式报告（report.md）导读

项目英文正式实验报告位于 `report/report.md`，严格遵循学术论文格式撰写，主要章节如下：

- **Chapter 1: Introduction**  
  阐述最短路径问题（SSSP）的定义、道路导航与网络路由背景、优先队列在 Dijkstra 算法中的瓶颈角色以及对比研究动机。
- **Chapter 2: Algorithm Design and Complexity Analysis**  
  形式化图论模型、前向星邻接表结构、松弛不变量推导、二叉堆与斐波那契堆的势能分析（Potential Function Analysis）与摊还复杂度证明。
- **Chapter 3: Implementation**  
  工程模块职责分离、双向循环链表设计、级联剪枝触发条件、度数合并防回环设计、内存防泄漏与防御性编程实践。
- **Chapter 4: Experimental Setup and Results**  
  真实硬件配置（AMD Ryzen AI 7 H 350, 32GB RAM, Windows 11）、编译优化参数、DIMACS USA 道路网络规模参数、1000 次查询真实运行时间表及对比柱状图与扩展曲线。
- **Chapter 5: Discussion**  
  理论复杂度与实测性能的背离原因剖析，从 CPU 缓存局部性、动态分配开销、道路网稀疏性及指令常数四方面展开深入探讨。
- **Chapter 6: Conclusion**  
  总结项目工程成果、正确性检验结果与对算法工程实践的启示。
- **References**  
  收录 Dijkstra (1959)、Fredman & Tarjan (1987)、CLRS 经典教材及 DIMACS 第九届评测官方权威文献。
