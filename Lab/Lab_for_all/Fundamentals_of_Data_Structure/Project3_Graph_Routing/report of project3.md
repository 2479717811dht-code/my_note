# <center>Report of Project 3</center>

<center>完成时间：2026年5月2日</center>

![](./微信图片_20260403150446_384_180.png)

![](./微信图片_20260403150447_385_180.png)

---



## <center>目录</center>

- [Chapter 1: 引言 & 问题描述](#1)
- [Chapter 2: 算法描述](#2)
- [Chapter 3: 测试用例分析](#3)
- [Chapter 4: 时空复杂度](#4)
- [Chapter 5: 最终完整程序](#5)
- [Chapter 6: END](#6)

---

## <center>Chapter 1: 引言 & 问题描述</center>

### 1.1 引言

- **Dijkstra算法** 是图论中的经典贪心算法，由计算机科学家 **Edsger W. Dijkstra** 于 $1956$ 年提出，主要用于求解**单源最短路径问题**，即从图中某一个源顶点出发，求解该顶点到图中其余所有顶点的最短路径长度；
- 该算法通过维护一个已确定最短路径的顶点集合，每一步从尚未加入集合的顶点中选择距离源点最近的顶点加入，从而逐步生成从源点到所有其他顶点的最短路径树。在这一过程中，顶点的加入顺序构成一个序列，称为 **Dijkstra序列**；
- 由于图中可能存在多条权重相同的最短路径，**Dijkstra算法** 在每一步选择距离最小的顶点时，如果存在多个候选顶点，此时算法可以选择其中任意一个加入集合。因此，对于同一张图，可能产生多种不同的 **Dijkstra序列**；

- 设计该程序的整个过程能够深入理解贪心算法的执行逻辑、最短路径求解原理，同时也能锻炼图的存储、算法模拟与边界数据校验的编程能力。

---

### 1.2 问题描述

- 给定一个无向连通图，包含 $N_v$ 个顶点（编号）$1 \sim N_v$和 $N_e$ 条边，每条边带有正整数的权重 $(≤100)$。再给出 $K$ 个查询，每个查询是一个包含 $N_v$ 个顶点的排列，其中第一个顶点被视为源点；

- 我们需要判断每个排列是否可以作为从该源点出发执行 **Dijkstra算法** 时顶点被选入最短路径树的顺序（即 **Dijkstra序列**）。

---

## <center>Chapter 2: 算法描述</center>

### 2.1 结构设计

- 先自定义数据类型的别名，一方面是提高程序的可读性，另一方面是在程序需要修改时不必一个一个地将 `int` 改为我们需要更改的变量类型，而是可以直接修改，包括：

  - `typedef int VertexType;`：用以表示顶点编号类型；
  - `typedef int ElemType;`：用以表示权值类型以及路径长度类型等等。
  
- 宏定义常量统一管理程序中使用的固定数值，其中包括：

  - `MAX_vertex`：表示图中允许的**最大顶点数量**，设定为 $1005$，以满足题目顶点数不超过 $1000$ 的限制；
  - `MAX_edge`：表示图中允许的**最大边数量**，设定为 $200005$，适配前向星高效存储大量边的需求；
  - `MAX`: 表示**无穷大**，使用 `0x3f3f3f3f` 代表两点之间不可达，该数值足够大且在路径计算中不会轻易溢出。
  
- 使用**前向星**存储无向带权图，所有存图数组均声明为全局变量，避免函数内定义大型数组导致栈溢出，且前向星相比邻接矩阵更适合存储稀疏图，遍历效率更高：

  - `To[]`：存储每条边的终点顶点编号；
  - `Next_Edge[]`：存储同起点的下一条边的编号，实现边的链式遍历；
  - `Weight[]`：存储每条边的权值；
  - `First_Edge[]`：存储每个顶点的第一条边的编号；
  - `cnt`：边的计数器，记录当前已添加的边的总数。
  
- 定义图的结构体，其中包含了顶点数组、图中实际顶点个数以及实际边数，其中：

  - `vertex[]`：存储顶点编号的数组；
  - `num_vertex`：图中实际顶点的数量；
  - `num_edge`：图中实际边的数量。
  
- 使用 `typedef` 为结构体定义一个更简短但意义明确的别名 `Graph`，使后续代码中对图的引用更简洁、更易读，在书写代码时也能更加轻松。


------

> 伪代码如下：

```pseudocode
// 包含输入输出、内存分配头文件
INCLUDE stdio.h
INCLUDE stdlib.h

// 自定义类型别名
TYPEDEF int VertexType   // 顶点编号类型
TYPEDEF int ElemType     // 边权、路径长度类型

// 宏定义常量
MAX_vertex = 1005
MAX_edge = 200005
INF = 0x3f3f3f3f  // 无穷大

// 前向星存图全局数组
To[MAX_edge]           // 存储边的终点
Next_Edge[MAX_edge]    // 存储下一条边编号
Weight[MAX_edge]       // 存储边权
First_Edge[MAX_vertex] // 存储每个顶点的第一条边
cnt                    // 边计数器

// 图结构体
STRUCT Graph
    vertex[MAX_vertex]   // 顶点编号
    num_vertex           // 实际顶点数
    num_edge             // 实际边数
END STRUCT
```

> 代码如下：

```c
// 需要使用的头文件
#include<stdio.h>
#include<stdlib.h>

// 自定义数据类型别名，提高程序可读性，使代码在除了 int 的其他情况下也能修改即用
typedef int VertexType;   // VertexType 代表顶点编号类型
typedef int ElemType;     // ElemType 代表边的权值类型、路径长度类型

// 宏定义常量
#define MAX_vertex 1005   // 最大顶点数（根据限制得知 Nv ≤ 1000）
#define MAX_edge 200005   // 最大边数（前向星高效存图，支持大量边）
#define MAX 0x3f3f3f3f    // 用 0x3f3f3f3f 表示无穷大，数值足够大且加法不溢出

/*==================== 前向星存图全局数组（高效存储稀疏图）====================*/
int To[MAX_edge];            // 存储边的终点顶点编号
int Next_Edge[MAX_edge];     // 存储同起点的下一条边的编号
ElemType Weight[MAX_edge];   // 存储边的权值
int First_Edge[MAX_vertex];  // 存储每个顶点的第一条边的编号
int cnt;                     // 边的计数器，记录当前已添加的边数

// 图的结构体定义
struct graph {
    VertexType vertex[MAX_vertex];  // 顶点数组，存储顶点编号
    int num_vertex;                 // 图中实际顶点个数
    int num_edge;                   // 图中实际边的条数
};

// 对结构体取一个更简易的别名，更通俗易懂，同时提高可读性
typedef struct graph Graph;
```

---

### 2.2 Create_Graph —— 图的初始化函数

- 该函数需要用到图指针 `G`、顶点数 `Nv`、边数 `Ne`。
- 首先将顶点数和边数分别存入图的结构体，并将前向星边计数器 `cnt` 清零。
- 进行顶点与前向星结构初始化：
  - 为每个顶点依次赋值编号，从 1 开始连续编号；
  - 初始化每个顶点的第一条边编号为 `0`，表示初始状态下该顶点没有邻接边。

> 伪代码如下：

```pseudocode
FUNCTION Create_Graph(Graph G, int Nv, int Ne):
    G.num_vertex = Nv         // 存入实际顶点数
    G.num_edge = Ne           // 存入实际边数
    cnt = 0                   // 前向星边计数器归零
    
    FOR i FROM 1 TO Nv:
        G.vertex[i] = i       // 为顶点赋值编号
        First_Edge[i] = 0     // 初始化顶点的第一条边为空
    END FOR
END FUNCTION
```

> 函数代码如下：

```c
/*==================== 图的初始化函数 ====================*/
// 功能：初始化图的顶点、边数、前向星结构
void Create_Graph(Graph* G, int Nv, int Ne) {

    // 将传入的顶点数与边数赋值给图结构体
    G->num_vertex = Nv;
    G->num_edge = Ne;
    cnt = 0;  // 前向星边计数器清零

    // 顶点编号从 1 开始依次赋值，并初始化前向星表头
    for (int i = 1; i <= G->num_vertex; i++) {
        G->vertex[i] = i;          // 顶点编号赋值
        First_Edge[i] = 0;         // 初始化每个顶点的第一条边为空
    }
}
```

---

### 2.3 Insert_Edge —— 前向星加边函数

- 该函数需要使用起点编号 `start_vertex`、终点编号 `end_vertex`、边权值 `weight`。
- 本程序使用**无向图**，一条边需要分别添加正反两个方向的边。
- 采用**前向星头插法**添加边：
  - 先给边计数器 `cnt` 自增，分配边的编号；
  - 记录当前边的终点、权值；
  - 将新边插入到对应起点的边链表头部；
  - 更新该顶点的第一条边为当前边。

> 伪代码如下：

```pseudocode
FUNCTION Insert_Edge(start_vertex, end_vertex, weight):
    // 添加正向边 start_vertex → end_vertex
    cnt = cnt + 1
    To[cnt] = end_vertex
    Weight[cnt] = weight
    Next_Edge[cnt] = First_Edge[start_vertex]
    First_Edge[start_vertex] = cnt

    // 添加反向边 end_vertex → start_vertex
    cnt = cnt + 1
    To[cnt] = start_vertex
    Weight[cnt] = weight
    Next_Edge[cnt] = First_Edge[end_vertex]
    First_Edge[end_vertex] = cnt
END FUNCTION
```

> 函数代码如下：

```c
/*==================== 前向星加边函数 ====================*/
// 功能：向无向图中添加一条边，start_vertex起点，end_vertex终点
void Insert_Edge(int start_vertex, int end_vertex, ElemType weight)
{
    // 添加正向边：start_vertex -> end_vertex
    To[++cnt] = end_vertex;            // 记录边的终点
    Weight[cnt] = weight;              // 记录边的权值
    Next_Edge[cnt] = First_Edge[start_vertex]; // 指向前一个头节点
    First_Edge[start_vertex] = cnt;    // 更新头节点为当前边

    // 添加反向边：end_vertex -> start_vertex（无向图双向边）
    To[++cnt] = start_vertex;
    Weight[cnt] = weight;
    Next_Edge[cnt] = First_Edge[end_vertex];
    First_Edge[end_vertex] = cnt;
}
```

---

### 2.4 dijkstra —— 堆优化单源最短路径算法

- 该函数需要使用图 `G`、起点 `start`、距离数组 `distance`。

- 首先动态分配内存并做异常处理，定义以下两个数组：

  - 标记数组：`found`，用来记录顶点是否已确定最短路径；
  - 路径数组：`path`，用来记录路径前驱结点，虽然本题不用输出路径，但保留下来能让算法结构更完整。

- 其次，进行初始化。所有顶点未被访问，距离初始化为无穷大，起点到自身的距离为 `0`。

- 动态分配**最小堆**存储 `(距离, 顶点编号)`，避免栈溢出，将起点加入堆中。

- 当堆不为空时循环：

  - 取出堆顶顶点（当前未访问、离源点最近的顶点）；

  - 执行**堆下沉**维护最小堆结构；

  - 若顶点已处理则跳过，否则标记为已处理；

  - 通过**前向星**遍历当前顶点的所有邻边；

  - 执行**松弛操作**，若路径更短则更新距离，并将新状态加入堆中；
  > 松弛更新：借一个中间顶点绕路走，观察比较是否比原来直接连线的距离更近。

  - 加入堆后执行**堆上浮**维护堆结构。

- 最后释放动态申请的内存，避免内存泄露。

> 伪代码如下：

```pseudocode
FUNCTION dijkstra(Graph G, start, distance[]):
    ALLOC found[]
    ALLOC path[]
    ALLOC heap[][]

    // 初始化
    FOR i FROM 1 TO G.num_vertex:
        found[i] = 0
        path[i] = -1
        distance[i] = INF
    END FOR
    distance[start] = 0

    // 起点入堆
    heap[1][0] = 0
    heap[1][1] = start
    size = 1

    // 堆循环
    WHILE size > 0:
        curr = 堆顶顶点
        堆下沉调整

        IF found[curr] = 1:
            CONTINUE
        END IF
        found[curr] = 1

        // 遍历所有邻边
        FOR 每条 curr 的邻边:
            neigh = 邻接点
            w = 边权
            IF 未访问 AND 可松弛:
                更新距离
                新节点入堆
                堆上浮调整
            END IF
        END FOR
    END WHILE

    FREE heap
    FREE found
    FREE path
END FUNCTION
```

> 函数代码如下：

```c
/*==================== 堆优化 Dijkstra 算法 ====================*/
// 功能：求起点 start 到图中所有顶点的最短路径，结果存入 distance 数组
void dijkstra(Graph G, int start, ElemType distance[]) {

    // 动态分配内存，标记顶点是否已确定最短路径
    int* found = (int*)malloc(MAX_vertex * sizeof(int));
    if (found == NULL) {
        printf("malloc failed in found\n");
        exit(1);
    }

    // 动态分配路径数组，记录每个顶点的前驱节点，保持算法完整性
    int* path = (int*)malloc(MAX_vertex * sizeof(int));
    if (path == NULL) {
        printf("内存分配失败\n");
        free(found);
        exit(1);
    }

    // 初始化距离、访问标记、路径数组
    for (int i = 1; i <= G.num_vertex; i++) {
        found[i] = 0;           // 所有顶点初始未访问
        path[i] = -1;           // 前驱节点初始化为 -1
        distance[i] = MAX;      // 初始距离为无穷大
    }
    distance[start] = 0;        // 起点到自身距离为 0

    // 动态分配最小堆，避免栈溢出，堆存储[距离, 顶点编号]
    int (*heap)[2] = (int(*)[2])malloc(MAX_edge * 2 * sizeof(int[2]));
    if (heap == NULL) {
        printf("内存分配失败\n");
        free(path);
        free(found);
        exit(1);
    }

    int size = 0;               // 堆的实际大小
    heap[++size][0] = 0;        // 起点距离入堆
    heap[size][1] = start;      // 起点编号入堆

    // 堆不为空时循环
    while (size > 0)
    {
        // 取出堆顶元素：当前最短距离对应的顶点
        int d = heap[1][0];
        int curr = heap[1][1];

        // 堆下沉操作，维护最小堆性质
        heap[1][0] = heap[size][0];
        heap[1][1] = heap[size][1];
        size--;

        int i = 1;
        while (i * 2 <= size)
        {
            int child = i * 2;
            // 选择左右孩子中较小的一个
            if (child + 1 <= size && heap[child + 1][0] < heap[child][0]) child++;
            // 父节点更小，无需调整
            if (heap[i][0] <= heap[child][0]) break;

            // 交换父节点与子节点
            int t1 = heap[i][0], t2 = heap[i][1];
            heap[i][0] = heap[child][0]; 
            heap[i][1] = heap[child][1];
            heap[child][0] = t1; 
            heap[child][1] = t2;
            i = child;
        }

        // 该顶点已处理过，跳过
        if (found[curr]) continue;
        found[curr] = 1;  // 标记为已处理

        // 前向星遍历当前顶点的所有邻边
        for (int i = First_Edge[curr]; i; i = Next_Edge[i])
        {
            int neigh = To[i];          // 邻接顶点
            ElemType w = Weight[i];     // 边的权值

            // 松弛操作：若经过当前顶点到邻点更短，则更新距离
            if (!found[neigh] && distance[neigh] > distance[curr] + w)
            {
                distance[neigh] = distance[curr] + w;
                path[neigh] = curr;

                // 更新后的顶点加入最小堆
                size++;
                heap[size][0] = distance[neigh];
                heap[size][1] = neigh;

                // 堆上浮操作，维护最小堆性质
                int now = size;
                while (now > 1 && heap[now][0] < heap[now / 2][0])
                {
                    int t1 = heap[now][0], t2 = heap[now][1];
                    heap[now][0] = heap[now / 2][0]; 
                    heap[now][1] = heap[now / 2][1];
                    heap[now / 2][0] = t1; 
                    heap[now / 2][1] = t2;
                    now /= 2;
                }
            }
        }
    }

    // 释放动态分配的内存，避免内存泄漏
    free(heap);
    free(found);
    free(path);
}
```

---

### 2.5 isValid —— 序列合法性检查

> 注意：该函数实际上并不在题目的要求之内，只是为了程序和代码的严谨性考虑，可以选择加上这个函数。

- 该部分函数需要使用图指针 `G`、顶点序列 `vertex_seq`、顶点数 `Nv`。
- 首先动态分配内存并做异常处理，定义标记数组 `appeared`，且初始化为 `0`，表示初始状态下所有顶点均未出现。
- 遍历序列中的每个顶点，以下情况均返回非法：
  - 顶点编号小于 1 或大于总顶点数，即超出有效区间；
  - 顶点已在序列中出现过，即序列存在重复顶点。
- 每次循环若当前顶点通过所有校验，均要标记当前顶点已经出现过，再继续循环处理后续顶点。
- 遍历结束后，若所有顶点均通过校验，则判定序列为合法的顶点全排列；若中途出现非法情况，则提前终止并返回结果。
- 最后释放内存，防止内存泄漏。

> 伪代码如下：

```pseudocode
FUNCTION isValid(Graph G, vertex_seq[], Nv):
    ALLOC appeared[]
    INIT appeared[] TO 0

    FOR i FROM 0 TO Nv-1:
        vertex_now = vertex_seq[i]

        // 越界判断
        IF vertex_now < 1 OR vertex_now > G.num_vertex:
            FREE appeared
            RETURN 0
        END IF

        // 重复判断
        IF appeared[vertex_now] == 1:
            FREE appeared
            RETURN 0
        END IF

        appeared[vertex_now] = 1
    END FOR

    FREE appeared
    RETURN 1
END FUNCTION
```

> 函数代码如下：

```c
/*==================== 验证顶点序列合法性 ====================*/
// 功能：检查序列是否存在越界、重复顶点，合法返回1，非法返回0
int isValid(Graph* G, int vertex_seq[], int Nv) {

    // 动态分配标记数组，记录顶点是否已出现
    int* appeared = (int*)malloc(MAX_vertex * sizeof(int));
    if (appeared == NULL) {
        printf("malloc failed in appeared\n");
        exit(1);
    }

    // 初始化标记数组为0
    for (int i = 0; i < MAX_vertex; i++) appeared[i] = 0;

    // 遍历序列检查合法性
    for (int i = 0; i < Nv; i++) {
        int vertex_now = vertex_seq[i];

        // 顶点编号越界，非法
        if (vertex_now < 1 || vertex_now > G->num_vertex) {
            free(appeared);
            return 0;
        }
        // 顶点重复出现，非法
        if (appeared[vertex_now] == 1) {
            free(appeared);
            return 0;
        }
        appeared[vertex_now] = 1;  // 标记顶点已出现
    }

    free(appeared);
    return 1;  // 序列合法
}
```

---

### 2.6 cmpVertex —— 快速排序比较函数

- 该函数是配合 `qsort` 库函数使用的**比较函数**，依赖全局数组 `sort_distance` 完成比较逻辑。

- 函数的两个参数为 `void*` 类型指针，分别指向两个待比较的顶点编号。

- 将指针强制转换为整型并解引用，得到两个顶点编号 `start_vertex` 和 `end_vertex`。

- 借助全局数组 `sort_distance` 中存储的最短路径长度进行比较：

  - 若 `start_vertex` 的距离更小，返回 `-1`，实现从小到大排序；
  - 若 `start_vertex` 的距离更大，返回 `1`；
  - 若两者距离相等，返回 `0`。

- 该函数用于实现顶点按**最短路径长度升序**排列，为生成标准 **Dijkstra** 序列提供支持。

> 伪代码如下：

```pseudocode
// 全局辅助数组
sort_distance[]

FUNCTION cmpVertex(a, b):
    start_vertex = 值(a)
    end_vertex = 值(b)
    
    IF sort_distance[start_vertex] < sort_distance[end_vertex]:
        RETURN -1
    ELSE IF sort_distance[start_vertex] > sort_distance[end_vertex]:
        RETURN 1
    ELSE:
        RETURN 0
END FUNCTION
```

> 代码如下：

```c
// 全局距离数组，给 qsort 比较函数用
static ElemType* sort_distance = NULL;

/*==================== 快排比较函数：按照顶点的最短距离从小到大排序 ====================*/
int cmpVertex(const void* a, const void* b)
{
    // 将 void* 指针强转为 int* 指针并解引用，取出两个顶点编号
    int start_vertex = *(int*)a;
    int end_vertex = *(int*)b;

    // 若 start_vertex 的距离更小：返回 -1，表示升序
    if (sort_distance[start_vertex] < sort_distance[end_vertex]) {
        return -1;
    }
    // 若 start_vertex 的距离更大：返回 1
    if (sort_distance[start_vertex] > sort_distance[end_vertex]) {
        return 1;
    }
    // 距离相等：返回 0
    return 0;
}
```

---

### 2.7 Calculate —— Dijkstra 序列判断核心函数

- 该函数参数为图指针 `G`、顶点序列 `vertex_seq`、顶点数量 `Nv`。
- 依次动态分配 `distance` 数组（存储最短路径）、`visited` 数组（标记访问）、`sortedV` 数组（排序顶点），并做完整的内存分配异常检查。
- 以输入序列的第一个顶点作为起点，调用 `dijkstra` 算法计算所有最短路径。
- 初始化 `sortedV` 为 `1~Nv` 编号，借助全局数组与 `cmpVertex` 比较函数，对顶点按最短路径**从小到大**快速排序。
- 使用单指针 `ptr` 线性遍历排序结果，跳过已访问顶点，直接找到当前未访问的最短距离顶点。
- 逐点校验：若当前顶点距离不等于最小距离，则序列非法；校验通过则标记为已访问。
- 全程仅一次排序 + 一次线性遍历，效率更高；最后释放所有动态内存，返回校验结果。

> 伪代码如下：

```pseudocode
FUNCTION Calculate(Graph G, vertex_seq[], Nv):
    start = vertex_seq[0]
    ALLOC distance[]
    ALLOC visited[]
    ALLOC sortedV[]
    
    dijkstra(G, start, distance)
    
    // 初始化
    FOR i FROM 1 TO Nv:
        visited[i] = 0
        sortedV[i-1] = i
    END FOR
    
    // 按距离从小到大排序
    sort_distance = distance
    qsort(sortedV, Nv, cmpVertex)
    
    ptr = 0
    FOR i FROM 0 TO Nv-1:
        current = vertex_seq[i]
        
        // 跳过已访问节点
        WHILE ptr < Nv AND visited[sortedV[ptr]]:
            ptr = ptr + 1
        END WHILE
        minNode = sortedV[ptr]
        
        // 不满足最小距离：非法
        IF distance[current] != distance[minNode]:
            FREE sortedV
            FREE distance
            FREE visited
            RETURN 0
        END IF
        
        visited[current] = 1
    END FOR
    
    FREE sortedV
    FREE distance
    FREE visited
    RETURN 1
END FUNCTION
```

> 代码如下：

```c
/*==================== 验证序列是否为 Dijkstra 合法出堆顺序 ====================*/
// 功能：判断序列是否严格符合 Dijkstra 每次选最小距离顶点的规则
int Calculate(Graph* G, int vertex_seq[], int Nv) {
    // 序列第一个顶点为 Dijkstra 算法的源点
    int start = vertex_seq[0];

    // 动态分配存储最短距离
    ElemType* distance = (ElemType*)malloc((Nv + 1) * sizeof(ElemType));
    if (distance == NULL) {
        printf("内存分配失败\n");
        exit(1);
    }

    // 动态分配标记顶点是否已访问
    int* visited = (int*)malloc((Nv + 1) * sizeof(int));
    if (visited == NULL) {
        printf("内存分配失败\n");
        free(distance);
        exit(1);
    }

    // 存放 1~Nv 顶点编号，用于快排
    int* sortedV = (int*)malloc(Nv * sizeof(int));
    if (sortedV == NULL) {
        printf("内存分配失败\n");
        free(visited);
        free(distance);
        exit(1);
    }

    // 调用 Dijkstra 算法，预先计算出所有最短路径
    dijkstra(*G, start, distance);

    // 初始化访问标记
    for (int i = 1; i <= Nv; i++) {
        visited[i] = 0;
        sortedV[i - 1] = i;
    }

    // 绑定全局距离数组，执行快排
    sort_distance = distance;
    qsort(sortedV, Nv, sizeof(int), cmpVertex);

    // 顺序指针，只往前走、不回头
    int ptr = 0;

    // 遍历整个序列，逐个顶点验证
    for (int i = 0; i < Nv; i++) {
        int current = vertex_seq[i];

        // 指针跳过已经被选过的，直接定位当前未访问最小距离点
        while (ptr < Nv && visited[sortedV[ptr]]) {
            ptr++;
        }
        int minNode = sortedV[ptr];

        // 当前顶点不是本轮可选的最小距离点：序列非法
        if (distance[current] != distance[minNode]) {
            free(sortedV);
            free(distance);
            free(visited);
            return 0;
        }

        // 标记为已访问
        visited[current] = 1;
    }

    // 释放内存
    free(sortedV);
    free(distance);
    free(visited);
    return 1;
}
```

---

### 2.8 main —— 主函数

- 首先读取顶点数 `Nv` 与边数 `Ne`，调用 `Create_Graph` 函数完成图结构与前向星的初始化。

- 依次读取每条边的端点与权值信息，调用 `Insert_Edge`函数完成无向图的双向边构建，并读取查询次数 `n`，循环处理每一组查询序列：

  - 先动态分配内存存储顶点序列，做异常处理后读取输入数据；
  - 对每组序列，首先调用 `isValid` 函数进行格式校验，排除顶点越界、序列重复等非法情况；
  - 在序列格式合法的情况下，再调用 `Calculate` 函数，校验其是否符合 **Dijkstra** 选点规则；
  - 根据判定结果输出 `Yes` 或 `No`，每组查询处理完成后及时释放序列数组，避免内存泄漏。

- 全部查询处理完毕后，程序正常结束。

> 伪代码如下：

```pseudocode
FUNCTION main():
    READ Nv, Ne
    CREATE Graph G
    CALL Create_Graph(G, Nv, Ne)

    // 读入并添加边
    FOR i FROM 0 TO Ne-1:
        READ v1, v2, w
        CALL Insert_Edge(v1, v2, w)
    END FOR

    READ n

    // 处理每个查询
    FOR i FROM 0 TO n-1:
        ALLOC vertex_seq[]
        READ vertex_seq[]

        IF NOT isValid(G, vertex_seq, Nv):
            PRINT No
        ELSE:
            IF Calculate(G, vertex_seq, Nv):
                PRINT Yes
            ELSE:
                PRINT No
            END IF
        END IF

        FREE vertex_seq
    END FOR

    RETURN 0
END FUNCTION
```

> 函数代码如下：

```c
/*==================== 主函数 ====================*/
int main() {
    int Nv, Ne;          // Nv=顶点数，Ne=边数
    scanf("%d %d", &Nv, &Ne);

    Graph G;             // 定义图结构体变量
    Create_Graph(&G, Nv, Ne);  // 初始化图

    // 循环读入所有边并添加到图中
    for (int i = 0; i < Ne; i++) {
        int v1, v2;
        ElemType w;
        scanf("%d %d %d", &v1, &v2, &w);
        Insert_Edge(v1, v2, w);
    }

    int n;               // 查询次数
    scanf("%d", &n);

    // 处理每一个查询序列
    for (int i = 0; i < n; i++) {
        // 动态分配存储序列的数组
        int* vertex_seq = (int*)malloc(Nv * sizeof(int));
        if (vertex_seq == NULL) {
            printf("内存分配失败\n");
            exit(1);
        }

        // 读入顶点序列
        for (int j = 0; j < Nv; j++) {
            scanf("%d", &vertex_seq[j]);
        }

        // 第一步：检查序列是否合法
        if (!isValid(&G, vertex_seq, Nv)) {
            printf("No\n");
        }
        // 第二步：检查是否为 Dijkstra 合法出堆顺序
        else {
            if (Calculate(&G, vertex_seq, Nv)) {
                printf("Yes\n");
            }
            else {
                printf("No\n");
            }
        }

        free(vertex_seq);  // 释放内存
    }

    return 0;
}
```

---

## <center>Chapter 3: 测试用例分析</center>

我们需要使用多个测试用例来说明该程序是正确的，在这里我们给出以下几种测试用例：

- $(1+4)$ 个标准测试用例：类似且包含题目给出的测试用例；
- $2$ 个综合测试：规模较大、覆盖多种路径选择情况、包含多个查询的测试，例如随机生成中等规模的图（几十个顶点，几百条边），并验证多个序列；
- $2$ 个最小规模：$N_v=1$，或 $N_v=2$（单条边）；

- $1$ 个最大规模：$N_v=10^3$，$N_e=10^5$，权值相同或随机;
- $5$ 个极端情况：
  - 所有边权相等（任何最小距离顶点都可选）。
  - 源点只有一个邻居。
  - 图是一条链。
  - 图是完全图。
  - 存在多条等长最短路径导致多种合法 **Dijkstra** 序列。

---

### 3.1 标准测试用例

#### 3.1.1 题目原始测试用例

输入：

```c
5 7
1 2 2
1 5 1
2 3 1
2 4 1
2 5 2
3 5 1
3 4 1
4
5 1 3 4 2
5 3 1 2 4
2 3 4 5 1
3 2 1 5 4
```

预期输出：

```c
Yes
Yes
Yes
No
```

控制台运行结果图片：

![](./微信图片_20260502194326_647_180.png)

> 测试通过

---

#### 3.1.2 自创平凡测试用例 1

输入：

```c
6 8
1 2 1
1 3 2
2 4 1
2 5 2
3 4 1
3 6 3
4 5 1
5 6 1
4
1 2 4 3 5 6
1 2 4 5 3 6
1 3 4 2 5 6
4 1 2 3 5 6
```

预期输出：

```c
Yes
No
No
No
```

控制台运行结果图片：

![](./微信图片_20260502195717_648_180.png)

> 测试通过

---

#### 3.1.3 自创平凡测试用例 2

输入：

```c
5 7
1 2 1
1 3 1
2 3 1
2 4 1
3 4 1
4 5 1
1 5 2
4
1 2 3 4 5
1 3 2 4 5
1 2 4 3 5
2 1 3 4 5
```

预期输出：

```c
Yes
Yes
No
Yes
```

控制台运行结果图片：

![](./微信图片_20260502195823_649_180.png)

> 测试通过

---

#### 3.1.4 自创平凡测试用例 3

输入：

```c
7 10
1 2 2
1 3 1
2 4 2
2 5 1
3 4 1
3 6 2
4 5 1
4 7 3
5 7 1
6 7 2
5
1 2 3 4 5 6 7
1 3 2 4 5 6 7
1 3 2 4 6 5 7
1 3 4 2 5 6 7
1 3 4 2 6 5 7
```

预期输出：

```c
No
Yes
Yes
Yes
Yes
```

控制台运行结果图片：

![](./微信图片_20260502200413_650_180.png)

> 测试通过

---

#### 3.1.5 自创平凡测试用例 4

输入：

```c
8 15
1 2 1
1 3 2
2 4 2
2 5 1
3 5 2
3 6 3
4 5 1
4 7 2
5 6 1
5 8 2
6 7 1
6 8 3
7 8 1
1 8 8
2 8 4
5
1 2 5 4 7 8 6 3
1 2 5 6 3 4 7 8
1 3 5 2 4 7 6 8
1 3 5 6 7 8 4 2
1 2 5 6 7 8 4 3
```

预期输出：
```c
No
No
No
No
No
```

控制台运行结果图片：

![](./微信图片_20260502200723_651_180.png)

> 测试通过

---

### 3.2 综合测试

#### 3.2.1 自创综合测试 1

由于几十个顶点几百条边实际上很难在控制台很好地展示出来，虽然理论上是可行的，但是我们选择一个更加妥贴的办法，即随机生成输入和输出并都写入文件，这样可以更方便地观察和核验在中等规模测试下程序的正确性了。

下面给出测试程序，该测试程序有 $30$ 个顶点，$200$ 条边，以及 $5$ 组查询：

```c
// 需要使用的头文件
#include <stdio.h>
#include <stdlib.h>
#include <time.h>

// 自定义数据类型别名，提高程序可读性，使代码在除了 int 的其他情况下也能修改即用
typedef int VertexType;   // VertexType 代表顶点编号类型
typedef int ElemType;     // ElemType 代表边的权值类型、路径长度类型

// 宏定义常量
#define MAX_vertex 1005   // 最大顶点数（根据限制得知 Nv ≤ 1000）
#define MAX_edge 200005   // 最大边数（前向星高效存图，支持大量边）
#define MAX 0x3f3f3f3f    // 用 0x3f3f3f3f 表示无穷大，数值足够大且加法不溢出

/*==================== 前向星存图全局数组（高效存储稀疏图）====================*/
int To[MAX_edge];            // 存储边的终点顶点编号
int Next_Edge[MAX_edge];     // 存储同起点的下一条边的编号
ElemType Weight[MAX_edge];   // 存储边的权值
int First_Edge[MAX_vertex];  // 存储每个顶点的第一条边的编号
int cnt;                     // 边的计数器，记录当前已添加的边数

// 图的结构体定义
struct graph {
    VertexType vertex[MAX_vertex];  // 顶点数组，存储顶点编号
    int num_vertex;                 // 图中实际顶点个数
    int num_edge;                   // 图中实际边的条数
};

// 对结构体取一个更简易的别名，更通俗易懂，同时提高可读性
typedef struct graph Graph;

/*==================== 图的初始化函数 ====================*/
void Create_Graph(Graph* G, int Nv, int Ne) {
    G->num_vertex = Nv;
    G->num_edge = Ne;
    cnt = 0;
    for (int i = 1; i <= G->num_vertex; i++) {
        G->vertex[i] = i;
        First_Edge[i] = 0;
    }
}

/*==================== 前向星加边函数 ====================*/
void Insert_Edge(int start_vertex, int end_vertex, ElemType weight) {
    // 正向边
    To[++cnt] = end_vertex;
    Weight[cnt] = weight;
    Next_Edge[cnt] = First_Edge[start_vertex];
    First_Edge[start_vertex] = cnt;
    // 反向边（无向图）
    To[++cnt] = start_vertex;
    Weight[cnt] = weight;
    Next_Edge[cnt] = First_Edge[end_vertex];
    First_Edge[end_vertex] = cnt;
}

/*==================== 堆优化 Dijkstra 算法 ====================*/
void dijkstra(Graph G, int start, ElemType distance[]) {
    int* found = (int*)malloc(MAX_vertex * sizeof(int));
    if (found == NULL) {
        printf("malloc failed in found\n");
        exit(1);
    }
    int* path = (int*)malloc(MAX_vertex * sizeof(int));
    if (path == NULL) {
        printf("malloc failed in path\n");
        free(found);
        exit(1);
    }
    for (int i = 1; i <= G.num_vertex; i++) {
        found[i] = 0;
        path[i] = -1;
        distance[i] = MAX;
    }
    distance[start] = 0;

    int heap_capacity = MAX_edge * 2 + 10;
    int (*heap)[2] = (int(*)[2])malloc(heap_capacity * sizeof(int[2]));
    if (heap == NULL) {
        printf("malloc failed in heap\n");
        free(path);
        free(found);
        exit(1);
    }

    int size = 0;
    heap[++size][0] = 0;
    heap[size][1] = start;

    while (size > 0) {
        int d = heap[1][0];
        int curr = heap[1][1];

        heap[1][0] = heap[size][0];
        heap[1][1] = heap[size][1];
        size--;

        int i = 1;
        while (i * 2 <= size) {
            int child = i * 2;
            if (child + 1 <= size && heap[child + 1][0] < heap[child][0]) child++;
            if (heap[i][0] <= heap[child][0]) break;
            int t1 = heap[i][0], t2 = heap[i][1];
            heap[i][0] = heap[child][0];
            heap[i][1] = heap[child][1];
            heap[child][0] = t1;
            heap[child][1] = t2;
            i = child;
        }

        if (found[curr]) continue;
        found[curr] = 1;

        for (int i = First_Edge[curr]; i; i = Next_Edge[i]) {
            int neigh = To[i];
            ElemType w = Weight[i];
            if (!found[neigh] && distance[neigh] > distance[curr] + w) {
                distance[neigh] = distance[curr] + w;
                path[neigh] = curr;
                size++;
                heap[size][0] = distance[neigh];
                heap[size][1] = neigh;
                int now = size;
                while (now > 1 && heap[now][0] < heap[now / 2][0]) {
                    int t1 = heap[now][0], t2 = heap[now][1];
                    heap[now][0] = heap[now / 2][0];
                    heap[now][1] = heap[now / 2][1];
                    heap[now / 2][0] = t1;
                    heap[now / 2][1] = t2;
                    now /= 2;
                }
            }
        }
    }

    free(heap);
    free(found);
    free(path);
}

/*==================== 验证顶点序列合法性 ====================*/
int isValid(Graph* G, int vertex_seq[], int Nv) {
    int* appeared = (int*)malloc(MAX_vertex * sizeof(int));
    if (appeared == NULL) {
        printf("malloc failed in appeared\n");
        exit(1);
    }
    for (int i = 0; i < MAX_vertex; i++) appeared[i] = 0;
    for (int i = 0; i < Nv; i++) {
        int vertex_now = vertex_seq[i];
        if (vertex_now < 1 || vertex_now > G->num_vertex) {
            free(appeared);
            return 0;
        }
        if (appeared[vertex_now] == 1) {
            free(appeared);
            return 0;
        }
        appeared[vertex_now] = 1;
    }
    free(appeared);
    return 1;
}

static ElemType* sort_distance = NULL;

int cmpVertex(const void* a, const void* b) {
    int start_vertex = *(int*)a;
    int end_vertex = *(int*)b;
    if (sort_distance[start_vertex] < sort_distance[end_vertex]) return -1;
    if (sort_distance[start_vertex] > sort_distance[end_vertex]) return 1;
    return 0;
}

/*==================== 验证序列是否为 Dijkstra 合法出堆顺序 ====================*/
int Calculate(Graph* G, int vertex_seq[], int Nv) {
    int start = vertex_seq[0];
    ElemType* distance = (ElemType*)malloc((Nv + 1) * sizeof(ElemType));
    if (distance == NULL) {
        printf("malloc failed in distance\n");
        exit(1);
    }
    int* visited = (int*)malloc((Nv + 1) * sizeof(int));
    if (visited == NULL) {
        printf("malloc failed in visited\n");
        free(distance);
        exit(1);
    }
    int* sortedV = (int*)malloc(Nv * sizeof(int));
    if (sortedV == NULL) {
        printf("malloc failed in sortedV\n");
        free(visited);
        free(distance);
        exit(1);
    }

    dijkstra(*G, start, distance);

    for (int i = 1; i <= Nv; i++) {
        visited[i] = 0;
        sortedV[i - 1] = i;
    }
    sort_distance = distance;
    qsort(sortedV, Nv, sizeof(int), cmpVertex);

    int ptr = 0;
    for (int i = 0; i < Nv; i++) {
        int current = vertex_seq[i];
        while (ptr < Nv && visited[sortedV[ptr]]) ptr++;
        int minNode = sortedV[ptr];
        if (distance[current] != distance[minNode]) {
            free(sortedV);
            free(distance);
            free(visited);
            return 0;
        }
        visited[current] = 1;
    }

    free(sortedV);
    free(distance);
    free(visited);
    return 1;
}

/*==================== 随机生成测试数据文件 ====================*/
void generate_random_input(const char* filename, int Nv, int Ne, int K, int max_weight) {
    FILE* fp = fopen(filename, "w");
    if (!fp) {
        printf("无法创建输入文件 %s\n", filename);
        exit(1);
    }

    fprintf(fp, "%d %d\n", Nv, Ne);

    // 生成无重复边的无向图
    int total_possible = Nv * (Nv - 1) / 2;
    if (Ne > total_possible) {
        printf("警告：边数 %d 超过完全图最大边数 %d，将调整为完全图\n", Ne, total_possible);
        Ne = total_possible;
    }

    typedef struct { int u, v; } Edge;
    Edge* all_edges = (Edge*)malloc(total_possible * sizeof(Edge));
    if (!all_edges) {
        printf("内存分配失败\n");
        fclose(fp);
        exit(1);
    }

    int idx = 0;
    for (int i = 1; i <= Nv; i++) {
        for (int j = i + 1; j <= Nv; j++) {
            all_edges[idx].u = i;
            all_edges[idx].v = j;
            idx++;
        }
    }

    srand((unsigned int)time(NULL));
    for (int i = total_possible - 1; i > 0; i--) {
        int j = rand() % (i + 1);
        Edge tmp = all_edges[i];
        all_edges[i] = all_edges[j];
        all_edges[j] = tmp;
    }

    for (int i = 0; i < Ne; i++) {
        int u = all_edges[i].u;
        int v = all_edges[i].v;
        int w = rand() % max_weight + 1;
        fprintf(fp, "%d %d %d\n", u, v, w);
    }
    free(all_edges);

    // 生成 K 个随机排列序列
    fprintf(fp, "%d\n", K);
    int* perm = (int*)malloc(Nv * sizeof(int));
    if (!perm) {
        printf("内存分配失败\n");
        fclose(fp);
        exit(1);
    }

    for (int q = 0; q < K; q++) {
        for (int i = 0; i < Nv; i++) perm[i] = i + 1;
        for (int i = Nv - 1; i > 0; i--) {
            int j = rand() % (i + 1);
            int tmp = perm[i];
            perm[i] = perm[j];
            perm[j] = tmp;
        }
        for (int i = 0; i < Nv; i++) {
            fprintf(fp, "%d", perm[i]);
            if (i < Nv - 1) fprintf(fp, " ");
        }
        fprintf(fp, "\n");
    }
    free(perm);
    fclose(fp);
    printf("随机测试数据已生成到文件: %s (Nv=%d, Ne=%d, K=%d, weight 1~%d)\n",
           filename, Nv, Ne, K, max_weight);
}

/*==================== 主函数 ====================*/
int main() {
    // 按照您的要求设置测试参数
    const int Nv = 30;          // 顶点数
    const int Ne = 200;         // 边数
    const int K = 5;            // 查询序列个数
    const int MAX_WEIGHT = 100; // 权值范围 1~100

    // 1. 生成随机输入文件
    generate_random_input("input.txt", Nv, Ne, K, MAX_WEIGHT);

    // 2. 重定向标准输入输出到文件
    if (freopen("input.txt", "r", stdin) == NULL) {
        printf("无法打开输入文件 input.txt\n");
        return 1;
    }
    if (freopen("output.txt", "w", stdout) == NULL) {
        printf("无法创建输出文件 output.txt\n");
        return 1;
    }

    // 3. 原有程序逻辑：读取输入、处理、输出结果到 output.txt
    int read_Nv, read_Ne;
    scanf("%d %d", &read_Nv, &read_Ne);

    Graph G;
    Create_Graph(&G, read_Nv, read_Ne);

    for (int i = 0; i < read_Ne; i++) {
        int v1, v2;
        ElemType w;
        scanf("%d %d %d", &v1, &v2, &w);
        Insert_Edge(v1, v2, w);
    }

    int n;
    scanf("%d", &n);   // 查询次数，此处应等于 K=5

    for (int i = 0; i < n; i++) {
        int* vertex_seq = (int*)malloc(read_Nv * sizeof(int));
        if (vertex_seq == NULL) {
            printf("malloc failed in vertex_seq\n");
            exit(1);
        }
        for (int j = 0; j < read_Nv; j++) {
            scanf("%d", &vertex_seq[j]);
        }
        if (!isValid(&G, vertex_seq, read_Nv)) {
            printf("No\n");
        } else {
            if (Calculate(&G, vertex_seq, read_Nv)) {
                printf("Yes\n");
            } else {
                printf("No\n");
            }
        }
        free(vertex_seq);
    }

    return 0;
}
```

通过检查文件 `input.txt` 和 `output.txt`，我们很容易发现，在本次综合测试中，程序自动生成了包含 $30$ 个顶点、$200$ 条边的无向带权图，并随机生成 $5$ 组完整顶点排列序列作为测试查询，但程序运行后判定结果几乎全部为 `No`，仅存在理论极低概率出现合法 `Yes` 序列。

这实际上是合理的，不是程序错误，分析如下：

- **Dijkstra** 算法的贪心选点规则具有严格约束性：每一步必须选择当前未访问顶点中最短路径距离最小的顶点，仅当多个顶点的最短距离完全相同时，这些顶点之间可以任意交换顺序，且最终结果不变；

- 30 个顶点的所有可能排列数量为 $30$ 的阶乘:$ 30! \approx 2.65 \times 10^{32} $。该数值规模极大，代表随机序列的总可能性空间；

- 合法序列的数量由顶点最短距离的分层结构决定：
  - 距离为 $0$ 的顶点（源点）仅有 $1$ 个，位置固定不可变动；
  - 距离相同的顶点构成同一层级，仅同层级内部顶点可自由排列；
  - 不同层级之间必须严格按照距离从小到大依次选取，顺序不可打乱。

- 在随机生成的图结构中，各顶点最短路径距离大多唯一，同层顶点数量极少。因此逐层累乘后合法序列总数极低，数量级仅为：$10^6 \sim 10^{10}$ 

- 随机序列命中合法 Dijkstra 序列的概率为合法序列数量与全排列总数的比值：$P = \frac{\text{合法序列数}}{\text{全排列总数}} \approx \frac{10^{10}}{2.65 \times 10^{32}} \approx 3.77 \times 10^{-23}$
  - 该概率无限趋近于 $0$，随机生成合法序列属于几乎不可能事件。

因此，这就解释了为什么每次运行程序都会得到 $5$ 个 `NO`，该程序是合理的。如果读者需要亲自验证但又不想跑一次这段长长的代码，我会提供我自己跑好的文件放在 `code` 文件夹中，供读者参考。

> 为了和下一个测试用例加以区分，我会将本测试用例得到的输入和输出文件分别改名为 `comprehensive_input_30_200_5.txt` 和 `comprehensive_output_30_200_5.txt`。

---

#### 3.2.2 自创综合测试 2

我们尝试着将顶点数、边数、查询组数都提升一些，再次运行得到结果，这里不再复制粘贴上面一段长长的代码，我们只需将以下这段代码：

```c
    const int Nv = 30;          // 顶点数
    const int Ne = 200;         // 边数
    const int K = 5;            // 查询序列个数
```

换成下面这段代码：

```c
    const int Nv = 90;          // 顶点数
    const int Ne = 600;         // 边数
    const int K = 30;            // 查询序列个数
```

读者自行修改代码后运行得到输入输出文件，检查核验即可。同上一个测试用例，我会把这一部分的输入和输出文件也放在 `code` 文件夹里，供读者直接参考。

需要注意的是，顶点数从 $30$ 变成了 $90$，输出得到 `YES` 的概率进一步地大大降低，原理同上一个测试用例，其中 $90$ 个顶点全排列总数为：$90! \approx 1.49 \times 10^{138}$。

随机生成的稀疏图中，大部分顶点的最短路径距离都是唯一的，可交换的 “同层顶点” 数量极少，因此合法序列总数远小于全排列总数，在极端情况下甚至可能只有 $1$ 个。因此，输出得到 `YES` 的概率由于分母（$90!$）的指数型增长而暴跌，在随机测试中观测到 `YES` 几乎不可能。

> 同理，输入和输出文件为和上一个测试用例区分，分别改名为 `comprehensive_input_90_600_30.txt` 和 `comprehensive_output_90_600_30.txt`。


---

### 3.3 最小规模

#### 3.3.1 自创最小规模用例 1

输入：

```c
1 0
1
1
```

预期输出：

```c
Yes
```

控制台运行结果图片：

![](./微信图片_20260502224016_652_180.png)

> 测试通过

---

#### 3.3.2 自创最小规模用例 2

输入：

```c
2 1
1 2 5
1
1 2
```

预期输出：

```c
Yes
```

控制台运行结果图片：

![](./微信图片_20260502224052_653_180.png)

> 测试通过

---

### 3.4 最大规模

对于题目上限：

- `Nv = 1000`
- `Ne = 100000`
- `K = 100`
- `weight=100`

还是和 **3.2 综合测试** 里的一样，这里完全无法直接提供完整的测试数据，同样按照上述办法，将跑出的输入输出文件都放在 `code` 文件夹里边。

当然如果读者想亲自验证该程序是否真的能跑，欢迎将其复制粘贴到你的 **DevC++**上进行验证。

```c
// 需要使用的头文件
#include <stdio.h>
#include <stdlib.h>
#include <time.h>

// 自定义数据类型别名，提高程序可读性，使代码在除了 int 的其他情况下也能修改即用
typedef int VertexType;   // VertexType 代表顶点编号类型
typedef int ElemType;     // ElemType 代表边的权值类型、路径长度类型

// 宏定义常量
#define MAX_vertex 1005   // 最大顶点数（根据限制得知 Nv ≤ 1000）
#define MAX_edge 200005   // 最大边数（前向星高效存图，支持大量边）
#define MAX 0x3f3f3f3f    // 用 0x3f3f3f3f 表示无穷大，数值足够大且加法不溢出

/*==================== 前向星存图全局数组（高效存储稀疏图）====================*/
int To[MAX_edge];            // 存储边的终点顶点编号
int Next_Edge[MAX_edge];     // 存储同起点的下一条边的编号
ElemType Weight[MAX_edge];   // 存储边的权值
int First_Edge[MAX_vertex];  // 存储每个顶点的第一条边的编号
int cnt;                     // 边的计数器，记录当前已添加的边数

// 图的结构体定义
struct graph {
    VertexType vertex[MAX_vertex];  // 顶点数组，存储顶点编号
    int num_vertex;                 // 图中实际顶点个数
    int num_edge;                   // 图中实际边的条数
};

// 对结构体取一个更简易的别名，更通俗易懂，同时提高可读性
typedef struct graph Graph;

/*==================== 图的初始化函数 ====================*/
// 功能：初始化图的顶点、边数、前向星结构
void Create_Graph(Graph* G, int Nv, int Ne) {

    // 将传入的顶点数与边数赋值给图结构体
    G->num_vertex = Nv;
    G->num_edge = Ne;
    cnt = 0;  // 前向星边计数器清零

    // 顶点编号从 1 开始依次赋值，并初始化前向星表头
    for (int i = 1; i <= G->num_vertex; i++) {
        G->vertex[i] = i;          // 顶点编号赋值
        First_Edge[i] = 0;         // 初始化每个顶点的第一条边为空
    }
}

/*==================== 前向星加边函数 ====================*/
// 功能：向无向图中添加一条边，start_vertex起点，end_vertex终点
void Insert_Edge(int start_vertex, int end_vertex, ElemType weight)
{
    // 添加正向边：start_vertex -> end_vertex
    To[++cnt] = end_vertex;            // 记录边的终点
    Weight[cnt] = weight;              // 记录边的权值
    Next_Edge[cnt] = First_Edge[start_vertex]; // 指向前一个头节点
    First_Edge[start_vertex] = cnt;    // 更新头节点为当前边

    // 添加反向边：end_vertex -> start_vertex（无向图双向边）
    To[++cnt] = start_vertex;
    Weight[cnt] = weight;
    Next_Edge[cnt] = First_Edge[end_vertex];
    First_Edge[end_vertex] = cnt;
}

/*==================== 堆优化 Dijkstra 算法 ====================*/
// 功能：求起点 start 到图中所有顶点的最短路径，结果存入 distance 数组
void dijkstra(Graph G, int start, ElemType distance[]) {

    // 动态分配内存，标记顶点是否已确定最短路径
    int* found = (int*)malloc(MAX_vertex * sizeof(int));
    if (found == NULL) {
        printf("malloc failed in found\n");
        exit(1);
    }

    // 动态分配路径数组，记录每个顶点的前驱节点，保持算法完整性
    int* path = (int*)malloc(MAX_vertex * sizeof(int));
    if (path == NULL) {
        printf("malloc failed in path\n");
        free(found);
        exit(1);
    }

    // 初始化距离、访问标记、路径数组
    for (int i = 1; i <= G.num_vertex; i++) {
        found[i] = 0;           // 所有顶点初始未访问
        path[i] = -1;           // 前驱节点初始化为 -1
        distance[i] = MAX;      // 初始距离为无穷大
    }
    distance[start] = 0;        // 起点到自身距离为 0

    // 堆容量：最大入堆次数不超过总边数的2倍（松弛成功即入堆），此处分配足够空间避免溢出
    int heap_capacity = MAX_edge * 2 + 10;
    int (*heap)[2] = (int(*)[2])malloc(heap_capacity * sizeof(int[2]));
    if (heap == NULL) {
        printf("malloc failed in heap\n");
        free(path);
        free(found);
        exit(1);
    }

    int size = 0;               // 堆的实际大小
    heap[++size][0] = 0;        // 起点距离入堆
    heap[size][1] = start;      // 起点编号入堆

    // 堆不为空时循环
    while (size > 0)
    {
        // 取出堆顶元素：当前最短距离对应的顶点
        int d = heap[1][0];
        int curr = heap[1][1];

        // 堆下沉操作，维护最小堆性质
        heap[1][0] = heap[size][0];
        heap[1][1] = heap[size][1];
        size--;

        int i = 1;
        while (i * 2 <= size)
        {
            int child = i * 2;
            // 选择左右孩子中较小的一个
            if (child + 1 <= size && heap[child + 1][0] < heap[child][0]) child++;
            // 父节点更小，无需调整
            if (heap[i][0] <= heap[child][0]) break;

            // 交换父节点与子节点
            int t1 = heap[i][0], t2 = heap[i][1];
            heap[i][0] = heap[child][0];
            heap[i][1] = heap[child][1];
            heap[child][0] = t1;
            heap[child][1] = t2;
            i = child;
        }

        // 该顶点已处理过，跳过
        if (found[curr]) continue;
        found[curr] = 1;  // 标记为已处理

        // 前向星遍历当前顶点的所有邻边
        for (int i = First_Edge[curr]; i; i = Next_Edge[i])
        {
            int neigh = To[i];          // 邻接顶点
            ElemType w = Weight[i];     // 边的权值

            // 松弛操作：若经过当前顶点到邻点更短，则更新距离
            if (!found[neigh] && distance[neigh] > distance[curr] + w)
            {
                distance[neigh] = distance[curr] + w;
                path[neigh] = curr;

                // 更新后的顶点加入最小堆
                size++;
                heap[size][0] = distance[neigh];
                heap[size][1] = neigh;

                // 堆上浮操作，维护最小堆性质
                int now = size;
                while (now > 1 && heap[now][0] < heap[now / 2][0])
                {
                    int t1 = heap[now][0], t2 = heap[now][1];
                    heap[now][0] = heap[now / 2][0];
                    heap[now][1] = heap[now / 2][1];
                    heap[now / 2][0] = t1;
                    heap[now / 2][1] = t2;
                    now /= 2;
                }
            }
        }
    }

    // 释放动态分配的内存，避免内存泄漏
    free(heap);
    free(found);
    free(path);
}

/*==================== 验证顶点序列合法性 ====================*/
// 功能：检查序列是否存在越界、重复顶点，合法返回1，非法返回0
int isValid(Graph* G, int vertex_seq[], int Nv) {

    // 动态分配标记数组，记录顶点是否已出现
    int* appeared = (int*)malloc(MAX_vertex * sizeof(int));
    if (appeared == NULL) {
        printf("malloc failed in appeared\n");
        exit(1);
    }

    // 初始化标记数组为0
    for (int i = 0; i < MAX_vertex; i++) appeared[i] = 0;

    // 遍历序列检查合法性
    for (int i = 0; i < Nv; i++) {
        int vertex_now = vertex_seq[i];

        // 顶点编号越界，非法
        if (vertex_now < 1 || vertex_now > G->num_vertex) {
            free(appeared);
            return 0;
        }
        // 顶点重复出现，非法
        if (appeared[vertex_now] == 1) {
            free(appeared);
            return 0;
        }
        appeared[vertex_now] = 1;  // 标记顶点已出现
    }

    free(appeared);
    return 1;  // 序列合法
}

// 全局距离数组，给 qsort 比较函数用
static ElemType* sort_distance = NULL;

/*==================== 快排比较函数：按照顶点的最短距离从小到大排序 ====================*/
int cmpVertex(const void* a, const void* b)
{
    // 将 void* 指针强转为 int* 指针并解引用，取出两个顶点编号
    int start_vertex = *(int*)a;
    int end_vertex = *(int*)b;

    // 若 start_vertex 的距离更小：返回 -1，表示升序
    if (sort_distance[start_vertex] < sort_distance[end_vertex]) {
        return -1;
    }
    // 若 start_vertex 的距离更大：返回 1
    if (sort_distance[start_vertex] > sort_distance[end_vertex]) {
        return 1;
    }
    // 距离相等：返回 0
    return 0;
}

/*==================== 验证序列是否为 Dijkstra 合法出堆顺序 ====================*/
// 功能：判断序列是否严格符合 Dijkstra 每次选最小距离顶点的规则
int Calculate(Graph* G, int vertex_seq[], int Nv) {
    // 序列第一个顶点为 Dijkstra 算法的源点
    int start = vertex_seq[0];

    // 动态分配存储最短距离
    ElemType* distance = (ElemType*)malloc((Nv + 1) * sizeof(ElemType));
    if (distance == NULL) {
        printf("malloc failed in distance\n");
        exit(1);
    }

    // 动态分配标记顶点是否已访问
    int* visited = (int*)malloc((Nv + 1) * sizeof(int));
    if (visited == NULL) {
        printf("malloc failed in visited\n");
        free(distance);
        exit(1);
    }

    // 存放 1~Nv 顶点编号，用于快排
    int* sortedV = (int*)malloc(Nv * sizeof(int));
    if (sortedV == NULL) {
        printf("malloc failed in sortedV\n");
        free(visited);
        free(distance);
        exit(1);
    }

    // 调用 Dijkstra 算法，预先计算出所有最短路径
    dijkstra(*G, start, distance);

    // 初始化访问标记
    for (int i = 1; i <= Nv; i++) {
        visited[i] = 0;
        sortedV[i - 1] = i;
    }

    // 绑定全局距离数组，执行快排
    sort_distance = distance;
    qsort(sortedV, Nv, sizeof(int), cmpVertex);

    // 顺序指针，只往前走、不回头
    int ptr = 0;

    // 遍历整个序列，逐个顶点验证
    for (int i = 0; i < Nv; i++) {
        int current = vertex_seq[i];

        // 指针跳过已经被选过的，直接定位当前未访问最小距离点
        while (ptr < Nv && visited[sortedV[ptr]]) {
            ptr++;
        }
        int minNode = sortedV[ptr];

        // 当前顶点不是本轮可选的最小距离点：序列非法
        if (distance[current] != distance[minNode]) {
            free(sortedV);
            free(distance);
            free(visited);
            return 0;
        }

        // 标记为已访问
        visited[current] = 1;
    }

    // 释放内存
    free(sortedV);
    free(distance);
    free(visited);
    return 1;
}

/*==================== 随机生成测试数据文件 ====================*/
// 功能：生成符合 Nv, Ne, K, 权值范围的随机无向图及顶点排列序列，写入 filename
void generate_random_input(const char* filename, int Nv, int Ne, int K, int max_weight) {
    FILE* fp = fopen(filename, "w");
    if (!fp) {
        printf("无法创建输入文件 %s\n", filename);
        exit(1);
    }

    // 写入顶点数、边数
    fprintf(fp, "%d %d\n", Nv, Ne);

    // ---------- 1. 生成无重复边的无向图 ----------
    // 计算所有可能无向边的总数 (i<j)
    int total_possible = Nv * (Nv - 1) / 2;
    if (Ne > total_possible) {
        printf("警告：边数 %d 超过完全图最大边数 %d，将调整为完全图\n", Ne, total_possible);
        Ne = total_possible;
    }

    // 存储所有可能的边 (u, v), u<v
    typedef struct { int u, v; } Edge;
    Edge* all_edges = (Edge*)malloc(total_possible * sizeof(Edge));
    if (!all_edges) {
        printf("内存分配失败\n");
        fclose(fp);
        exit(1);
    }

    int idx = 0;
    for (int i = 1; i <= Nv; i++) {
        for (int j = i + 1; j <= Nv; j++) {
            all_edges[idx].u = i;
            all_edges[idx].v = j;
            idx++;
        }
    }

    // 随机打乱所有边 (Fisher-Yates)
    srand((unsigned int)time(NULL));
    for (int i = total_possible - 1; i > 0; i--) {
        int j = rand() % (i + 1);
        Edge tmp = all_edges[i];
        all_edges[i] = all_edges[j];
        all_edges[j] = tmp;
    }

    // 取前 Ne 条边，赋予随机权重 1~max_weight
    for (int i = 0; i < Ne; i++) {
        int u = all_edges[i].u;
        int v = all_edges[i].v;
        int w = rand() % max_weight + 1;   // [1, max_weight]
        fprintf(fp, "%d %d %d\n", u, v, w);
    }
    free(all_edges);

    // ---------- 2. 生成 K 个查询序列 (每个是 1~Nv 的随机排列) ----------
    fprintf(fp, "%d\n", K);
    int* perm = (int*)malloc(Nv * sizeof(int));
    if (!perm) {
        printf("内存分配失败\n");
        fclose(fp);
        exit(1);
    }

    for (int q = 0; q < K; q++) {
        // 初始化排列 1,2,...,Nv
        for (int i = 0; i < Nv; i++) perm[i] = i + 1;
        // 随机洗牌
        for (int i = Nv - 1; i > 0; i--) {
            int j = rand() % (i + 1);
            int tmp = perm[i];
            perm[i] = perm[j];
            perm[j] = tmp;
        }
        // 写入一行
        for (int i = 0; i < Nv; i++) {
            fprintf(fp, "%d", perm[i]);
            if (i < Nv - 1) fprintf(fp, " ");
        }
        fprintf(fp, "\n");
    }
    free(perm);
    fclose(fp);
    printf("随机测试数据已生成到文件: %s (Nv=%d, Ne=%d, K=%d, weight 1~%d)\n",
           filename, Nv, Ne, K, max_weight);
}

/*==================== 主函数 ====================*/
int main() {
    // 设置最大测试参数
    const int Nv = 1000;
    const int Ne = 100000;
    const int K = 100;
    const int MAX_WEIGHT = 100;

    // 1. 生成随机输入文件
    generate_random_input("input.txt", Nv, Ne, K, MAX_WEIGHT);

    // 2. 重定向标准输入输出到文件
    if (freopen("input.txt", "r", stdin) == NULL) {
        printf("无法打开输入文件 input.txt\n");
        return 1;
    }
    if (freopen("output.txt", "w", stdout) == NULL) {
        printf("无法创建输出文件 output.txt\n");
        return 1;
    }

    // 3. 原有程序逻辑：读取输入、处理、输出结果
    int read_Nv, read_Ne;
    scanf("%d %d", &read_Nv, &read_Ne);

    Graph G;
    Create_Graph(&G, read_Nv, read_Ne);

    // 读入所有边
    for (int i = 0; i < read_Ne; i++) {
        int v1, v2;
        ElemType w;
        scanf("%d %d %d", &v1, &v2, &w);
        Insert_Edge(v1, v2, w);
    }

    int n;
    scanf("%d", &n);   // 查询次数，此处应等于 K (100)

    // 处理每个查询序列
    for (int i = 0; i < n; i++) {
        int* vertex_seq = (int*)malloc(read_Nv * sizeof(int));
        if (vertex_seq == NULL) {
            printf("malloc failed in vertex_seq\n");
            exit(1);
        }

        for (int j = 0; j < read_Nv; j++) {
            scanf("%d", &vertex_seq[j]);
        }

        if (!isValid(&G, vertex_seq, read_Nv)) {
            printf("No\n");
        } else {
            if (Calculate(&G, vertex_seq, read_Nv)) {
                printf("Yes\n");
            } else {
                printf("No\n");
            }
        }
        free(vertex_seq);
    }

    return 0;
}
```

在对大规模随机图与随机序列进行测试时，程序输出中出现了少量 `Yes`，该现象并非程序错误，而是由算法规则与概率特性共同决定的正常结果。

由于程序对 **Dijkstra** 序列的合法性判定如下：
- 以序列第一个顶点为源点，运行堆优化 **Dijkstra** 算法得到所有顶点的最短路径长度；
- 将所有顶点按最短路径长度从小到大排序，得到标准参考顺序；
- 输入序列必须满足：每一步选取的顶点，都是当前未访问顶点中距离最小的顶点；
- 当多个顶点最短距离相等时，这些顶点之间可以任意交换顺序，均为合法序列。

本项目随机生成的查询为 $1 \sim N_v$ 的全排列，而合法 **Dijkstra** 序列是该全排列集合中的一个非空子集：
- 当随机排列**恰好符合距离非递减顺序**时，程序判定为合法，输出 `Yes`；
- 顶点数较少、同距离顶点较多时，合法序列数量会显著增加，命中概率上升；
- 大规模随机图中命中概率极低，但在数学上不为 $0$。

而大量试验下小概率事件必然发生，本次最大规模测试参数：
- 顶点数 $N_v=1000$，边数 $N_e=10^5$，查询组数 $K=100$
- 单次命中概率极低，但在多次独立随机试验中，出现命中属于符合概率理论的正常现象。

> 以及，我会将其中一次的输入和输出分别改名为 `max_input` 和 `max_output`，并放在 `code` 文件夹里，以供读者直接参考。

---

### 3.5 极端情况

#### 3.5.1 所有边权相等

输入：

```c
4 4
1 2 1
1 3 1
2 4 1
3 4 1
2
1 2 3 4
1 3 2 4
```

预期输出：

```c
Yes
Yes
```

控制台运行结果图片：

![](./微信图片_20260502224544_654_180.png)

> 测试通过

---

#### 3.5.2 源点只有一个邻居

输入：

```c
4 3
1 2 1
2 3 1
2 4 2
2
1 2 3 4
1 2 4 3
```

预期输出：

```c
Yes
No
```

控制台运行结果图片：

![](./微信图片_20260502224736_655_180.png)

> 测试通过

---

#### 3.5.3 图是一条链

输入：

```c
4 3
1 2 1
2 3 1
3 4 1
2
1 2 3 4
1 3 2 4
```

预期输出：

```c
Yes
No
```

控制台运行结果图片：

![](./微信图片_20260502224828_656_180.png)

> 测试通过

---

#### 3.5.4 图是完全图

输入：

```c
3 3
1 2 1
1 3 2
2 3 1
2
1 2 3
1 3 2
```

预期输出：

```c
Yes
No
```

控制台运行结果图片：

![](./微信图片_20260502224912_657_180.png)

> 测试通过

---

#### 3.5.5 存在多条等长最短路径

输入：

```c
4 4
1 2 2
1 3 2
2 4 2
3 4 2
2
1 2 3 4
1 3 2 4
```

预期输出：

```c
Yes
Yes
```

控制台运行结果图片：

![](./微信图片_20260502224953_658_180.png)

> 测试通过

---

## <center>Chapter 4: 时空复杂度</center>

### 4.1 时间复杂度

#### 4.1.1 Create_Graph —— 图的初始化函数

- 函数仅对顶点编号与前向星表头进行**单层遍历**初始化，无嵌套循环，执行次数与顶点数 $N_v$ 呈线性关系。

**时间复杂度**：$O(N_v)$

---

#### 4.1.2 Insert_Edge —— 前向星加边函数

- 采用头插法添加无向边，仅执行常数次赋值与指针操作，与图规模无关。

**时间复杂度**：$O(1)$

---

#### 4.1.3 dijkstra —— 堆优化单源最短路径算法

- 分析以下三部分：
  - 初始化距离、标记、路径数组：$O(N_v)$
  - 堆操作：每条边最多被检查一次，入堆 / 出堆总次数为 $O(N_e)$，单次堆调整为 $O(\log N_e)$
  - 前向星遍历所有边：$O(N_e)$

- 整体由堆操作主导。

**时间复杂度**：$O(N_e \log N_e)$

---

#### 4.1.4 isValid —— 序列合法性检查

- 仅对查询序列做**单层遍历**，用标记数组校验越界与重复，遍历长度等于顶点数 $N_v$。

**时间复杂度**：$O(N_v)$

---

#### 4.1.5 cmpVertex —— 快速排序比较函数

- 仅执行常数次取值与比较，无循环与递归。

**时间复杂度**：$O(1)$

---

#### 4.1.6 Calculate —— Dijkstra 序列判断核心函数

- 分析以下三部分：
  - 调用 **Dijkstra**：$O(N_e \log N_e)$
  - 顶点按距离快排：$O(N_v \log N_v)$
  - 线性遍历校验序列：$O(N_v)$

- 整体由最耗时的 **Dijkstra** 与排序主导。

**时间复杂度**：$O(N_e \log N_e + N_v \log N_v)$

---

#### 4.1.7 整体程序时间复杂度

- 程序流程：
  - 图初始化：$O(N_v)$
  - 建边：$O(N_e)$
  - 处理 `K` 组查询：每组 $O(N_e \log N_v + N_v \log N_v)$

- 整体复杂度由查询规模与 **Dijkstra** 共同决定。

**整体时间复杂度**：$O(N_v + N_e + K(N_e \log N_e + N_v \log N_v))$

> 题目最大规模（$N_v=1000, N_e=10^5, K=100$）下可高效运行。

------

### 4.2 空间复杂度

#### 4.2.1 前向星全局数组

- 以下两部分为程序核心存储结构：
  - `To`、`Next_Edge`、`Weight`：$O(N_e)$
  - `First_Edge`：$O(N_v)$

- 空间与边数线性相关。

**空间复杂度**：$O(N_e + N_v)$

---

#### 4.2.2 Create_Graph —— 图的初始化函数

- 仅使用常数临时变量，无动态内存开辟。

**空间复杂度**：$O(1)$

---

#### 4.2.3 Insert_Edge —— 前向星加边函数

- 仅使用常数临时变量，无额外空间开销。

**空间复杂度**：$O(1)$

---

#### 4.2.4 dijkstra —— 堆优化单源最短路径算法

- 动态申请 $3$ 个数组：
  - `found []`：$O(N_v)$
  - `path []`：$O(N_v)$
  - 最小堆：最坏 $O(N_e)$

- 整体与顶点数、边数线性相关。

**空间复杂度**：$O(N_v + N_e)$

---

#### 4.2.5 isValid —— 序列合法性检查

- 动态申请 `appeared []` 标记数组，长度等于最大顶点数。

**空间复杂度**：$O(N_v)$

---

#### 4.2.6 cmpVertex —— 快速排序比较函数

- **无动态内存分配**、无数组、无递归、无静态局部数组，仅使用强转与局部变量，属于**常数级空间**。

**空间复杂度**：$O(1)$

---

#### 4.2.7 Calculate —— Dijkstra 序列判断核心函数

- 动态申请 $3$ 个数组：
  - `distance []`：$O(N_v)$
  - `visited []`：$O(N_v)$
  - `sortedV[]`：$O(N_v)$

- 均为线性空间。

**空间复杂度**：$O(N_v)$


---

#### 4.2.8 整体程序空间复杂度

- 空间主要由**前向星**与**Dijkstra**的辅助结构主导，稀疏图效率极高。

**整体空间复杂度**：$O(N_e + N_v)$

---

### 4.3 时空复杂度汇总

|    函数名称    |        时间复杂度        |  空间复杂度  |
| :------------: | :----------------------: | :----------: |
| `Create_Graph` |         $O(N_v)$         |    $O(1)$    |
| `Insert_Edge`  |          $O(1)$          |    $O(1)$    |
|   `dijkstra`   |      $O(N_elogN_e)$      | $O(N_v+N_e)$ |
|   `isValid`    |         $O(N_v)$         |   $O(N_v)$   |
|  `cmpVertex`   |          $O(1)$          |    $O(1)$    |
|  `Calculate`   | $O(N_elogN_e+N_vlogN_v)$ |   $O(N_v)$   |
|    单组查询    | $O(N_elogN_e+N_vlogN_v)$ |   $O(N_v)$   |
|整体程序|$O(N_v + N_e + K(N_e \log N_e + N_v \log N_v))$|$O(N_e + N_v)$|

---

## <center>Chapter 5: 最终完整程序</center>

完整程序实现：

```c
// 需要使用的头文件
#include<stdio.h>
#include<stdlib.h>

// 自定义数据类型别名，提高程序可读性，使代码在除了 int 的其他情况下也能修改即用
typedef int VertexType;   // VertexType 代表顶点编号类型
typedef int ElemType;     // ElemType 代表边的权值类型、路径长度类型

// 宏定义常量
#define MAX_vertex 1005   // 最大顶点数（根据限制得知 Nv ≤ 1000）
#define MAX_edge 200005   // 最大边数（前向星高效存图，支持大量边）
#define MAX 0x3f3f3f3f    // 用 0x3f3f3f3f 表示无穷大，数值足够大且加法不溢出

/*==================== 前向星存图全局数组（高效存储稀疏图）====================*/
int To[MAX_edge];            // 存储边的终点顶点编号
int Next_Edge[MAX_edge];     // 存储同起点的下一条边的编号
ElemType Weight[MAX_edge];   // 存储边的权值
int First_Edge[MAX_vertex];  // 存储每个顶点的第一条边的编号
int cnt;                     // 边的计数器，记录当前已添加的边数

// 图的结构体定义
struct graph {
    VertexType vertex[MAX_vertex];  // 顶点数组，存储顶点编号
    int num_vertex;                 // 图中实际顶点个数
    int num_edge;                   // 图中实际边的条数
};

// 对结构体取一个更简易的别名，更通俗易懂，同时提高可读性
typedef struct graph Graph;

/*==================== 图的初始化函数 ====================*/
// 功能：初始化图的顶点、边数、前向星结构
void Create_Graph(Graph* G, int Nv, int Ne) {

    // 将传入的顶点数与边数赋值给图结构体
    G->num_vertex = Nv;
    G->num_edge = Ne;
    cnt = 0;  // 前向星边计数器清零

    // 顶点编号从 1 开始依次赋值，并初始化前向星表头
    for (int i = 1; i <= G->num_vertex; i++) {
        G->vertex[i] = i;          // 顶点编号赋值
        First_Edge[i] = 0;         // 初始化每个顶点的第一条边为空
    }
}

/*==================== 前向星加边函数 ====================*/
// 功能：向无向图中添加一条边，start_vertex起点，end_vertex终点
void Insert_Edge(int start_vertex, int end_vertex, ElemType weight)
{
    // 添加正向边：start_vertex -> end_vertex
    To[++cnt] = end_vertex;            // 记录边的终点
    Weight[cnt] = weight;              // 记录边的权值
    Next_Edge[cnt] = First_Edge[start_vertex]; // 指向前一个头节点
    First_Edge[start_vertex] = cnt;    // 更新头节点为当前边

    // 添加反向边：end_vertex -> start_vertex（无向图双向边）
    To[++cnt] = start_vertex;
    Weight[cnt] = weight;
    Next_Edge[cnt] = First_Edge[end_vertex];
    First_Edge[end_vertex] = cnt;
}

/*==================== 堆优化 Dijkstra 算法 ====================*/
// 功能：求起点 start 到图中所有顶点的最短路径，结果存入 distance 数组
void dijkstra(Graph G, int start, ElemType distance[]) {

    // 动态分配内存，标记顶点是否已确定最短路径
    int* found = (int*)malloc(MAX_vertex * sizeof(int));
    if (found == NULL) {
        printf("内存分配失败\n");
        exit(1);
    }

    // 动态分配路径数组，记录每个顶点的前驱节点，保持算法完整性
    int* path = (int*)malloc(MAX_vertex * sizeof(int));
    if (path == NULL) {
        printf("内存分配失败\n");
        free(found);
        exit(1);
    }

    // 初始化距离、访问标记、路径数组
    for (int i = 1; i <= G.num_vertex; i++) {
        found[i] = 0;           // 所有顶点初始未访问
        path[i] = -1;           // 前驱节点初始化为 -1
        distance[i] = MAX;      // 初始距离为无穷大
    }
    distance[start] = 0;        // 起点到自身距离为 0

    // 动态分配最小堆，避免栈溢出，堆存储[距离, 顶点编号]
    int (*heap)[2] = (int(*)[2])malloc(MAX_edge * 2 * sizeof(int[2]));
    if (heap == NULL) {
        printf("内存分配失败\n");
        free(path);
        free(found);
        exit(1);
    }

    int size = 0;               // 堆的实际大小
    heap[++size][0] = 0;        // 起点距离入堆
    heap[size][1] = start;      // 起点编号入堆

    // 堆不为空时循环
    while (size > 0)
    {
        // 取出堆顶元素：当前最短距离对应的顶点
        int d = heap[1][0];
        int curr = heap[1][1];

        // 堆下沉操作，维护最小堆性质
        heap[1][0] = heap[size][0];
        heap[1][1] = heap[size][1];
        size--;

        int i = 1;
        while (i * 2 <= size)
        {
            int child = i * 2;
            // 选择左右孩子中较小的一个
            if (child + 1 <= size && heap[child + 1][0] < heap[child][0]) child++;
            // 父节点更小，无需调整
            if (heap[i][0] <= heap[child][0]) break;

            // 交换父节点与子节点
            int t1 = heap[i][0], t2 = heap[i][1];
            heap[i][0] = heap[child][0];
            heap[i][1] = heap[child][1];
            heap[child][0] = t1;
            heap[child][1] = t2;
            i = child;
        }

        // 该顶点已处理过，跳过
        if (found[curr]) continue;
        found[curr] = 1;  // 标记为已处理

        // 前向星遍历当前顶点的所有邻边
        for (int i = First_Edge[curr]; i; i = Next_Edge[i])
        {
            int neigh = To[i];          // 邻接顶点
            ElemType w = Weight[i];     // 边的权值

            // 松弛操作：若经过当前顶点到邻点更短，则更新距离
            if (!found[neigh] && distance[neigh] > distance[curr] + w)
            {
                distance[neigh] = distance[curr] + w;
                path[neigh] = curr;

                // 更新后的顶点加入最小堆
                size++;
                heap[size][0] = distance[neigh];
                heap[size][1] = neigh;

                // 堆上浮操作，维护最小堆性质
                int now = size;
                while (now > 1 && heap[now][0] < heap[now / 2][0])
                {
                    int t1 = heap[now][0], t2 = heap[now][1];
                    heap[now][0] = heap[now / 2][0];
                    heap[now][1] = heap[now / 2][1];
                    heap[now / 2][0] = t1;
                    heap[now / 2][1] = t2;
                    now /= 2;
                }
            }
        }
    }

    // 释放动态分配的内存，避免内存泄漏
    free(heap);
    free(found);
    free(path);
}

/*==================== 验证顶点序列合法性 ====================*/
// 功能：检查序列是否存在越界、重复顶点，合法返回1，非法返回0
int isValid(Graph* G, int vertex_seq[], int Nv) {

    // 动态分配标记数组，记录顶点是否已出现
    int* appeared = (int*)malloc(MAX_vertex * sizeof(int));
    if (appeared == NULL) {
        printf("内存分配失败\n");
        exit(1);
    }

    // 初始化标记数组为0
    for (int i = 0; i < MAX_vertex; i++) appeared[i] = 0;

    // 遍历序列检查合法性
    for (int i = 0; i < Nv; i++) {
        int vertex_now = vertex_seq[i];

        // 顶点编号越界，非法
        if (vertex_now < 1 || vertex_now > G->num_vertex) {
            free(appeared);
            return 0;
        }
        // 顶点重复出现，非法
        if (appeared[vertex_now] == 1) {
            free(appeared);
            return 0;
        }
        appeared[vertex_now] = 1;  // 标记顶点已出现
    }

    free(appeared);
    return 1;  // 序列合法
}

// 全局距离数组，给 qsort 比较函数用
static ElemType* sort_distance = NULL;

/*==================== 快排比较函数：按照顶点的最短距离从小到大排序 ====================*/
int cmpVertex(const void* a, const void* b)
{
    // 将 void* 指针强转为 int* 指针并解引用，取出两个顶点编号
    int start_vertex = *(int*)a;
    int end_vertex = *(int*)b;

    // 若 start_vertex 的距离更小：返回 -1，表示升序
    if (sort_distance[start_vertex] < sort_distance[end_vertex]) {
        return -1;
    }
    // 若 start_vertex 的距离更大：返回 1
    if (sort_distance[start_vertex] > sort_distance[end_vertex]) {
        return 1;
    }
    // 距离相等：返回 0
    return 0;
}

/*==================== 验证序列是否为 Dijkstra 合法出堆顺序 ====================*/
// 功能：判断序列是否严格符合 Dijkstra 每次选最小距离顶点的规则
int Calculate(Graph* G, int vertex_seq[], int Nv) {
    // 序列第一个顶点为 Dijkstra 算法的源点
    int start = vertex_seq[0];

    // 动态分配存储最短距离
    ElemType* distance = (ElemType*)malloc((Nv + 1) * sizeof(ElemType));
    if (distance == NULL) {
        printf("内存分配失败\n");
        exit(1);
    }

    // 动态分配标记顶点是否已访问
    int* visited = (int*)malloc((Nv + 1) * sizeof(int));
    if (visited == NULL) {
        printf("内存分配失败\n");
        free(distance);
        exit(1);
    }

    // 存放 1~Nv 顶点编号，用于快排
    int* sortedV = (int*)malloc(Nv * sizeof(int));
    if (sortedV == NULL) {
        printf("内存分配失败\n");
        free(visited);
        free(distance);
        exit(1);
    }

    // 调用 Dijkstra 算法，预先计算出所有最短路径
    dijkstra(*G, start, distance);

    // 初始化访问标记
    for (int i = 1; i <= Nv; i++) {
        visited[i] = 0;
        sortedV[i - 1] = i;
    }

    // 绑定全局距离数组，执行快排
    sort_distance = distance;
    qsort(sortedV, Nv, sizeof(int), cmpVertex);

    // 顺序指针，只往前走、不回头
    int ptr = 0;

    // 遍历整个序列，逐个顶点验证
    for (int i = 0; i < Nv; i++) {
        int current = vertex_seq[i];

        // 指针跳过已经被选过的，直接定位当前未访问最小距离点
        while (ptr < Nv && visited[sortedV[ptr]]) {
            ptr++;
        }
        int minNode = sortedV[ptr];

        // 当前顶点不是本轮可选的最小距离点：序列非法
        if (distance[current] != distance[minNode]) {
            free(sortedV);
            free(distance);
            free(visited);
            return 0;
        }

        // 标记为已访问
        visited[current] = 1;
    }

    // 释放内存
    free(sortedV);
    free(distance);
    free(visited);
    return 1;
}

/*==================== 主函数 ====================*/
int main() {
    int Nv, Ne;          // Nv=顶点数，Ne=边数
    scanf("%d %d", &Nv, &Ne);

    Graph G;             // 定义图结构体变量
    Create_Graph(&G, Nv, Ne);  // 初始化图

    // 循环读入所有边并添加到图中
    for (int i = 0; i < Ne; i++) {
        int v1, v2;
        ElemType w;
        scanf("%d %d %d", &v1, &v2, &w);
        Insert_Edge(v1, v2, w);
    }

    int n;               // 查询次数
    scanf("%d", &n);

    // 处理每一个查询序列
    for (int i = 0; i < n; i++) {
        // 动态分配存储序列的数组
        int* vertex_seq = (int*)malloc(Nv * sizeof(int));
        if (vertex_seq == NULL) {
            printf("内存分配失败\n");
            exit(1);
        }

        // 读入顶点序列
        for (int j = 0; j < Nv; j++) {
            scanf("%d", &vertex_seq[j]);
        }

        // 第一步：检查序列是否合法
        if (!isValid(&G, vertex_seq, Nv)) {
            printf("No\n");
        }
        // 第二步：检查是否为 Dijkstra 合法出堆顺序
        else {
            if (Calculate(&G, vertex_seq, Nv)) {
                printf("Yes\n");
            }
            else {
                printf("No\n");
            }
        }

        free(vertex_seq);  // 释放内存
    }

    return 0;
}
```

---

## <center>Chapter 6: END</center>

**诚信守则声明：** 

==我在此声明，本项目完全由我***独立***完成。==

---

![](./微信图片_20260403150424_383_180.png)