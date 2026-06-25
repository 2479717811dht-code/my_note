# <center>数据结构基础</center> 

---

<center>浙江大学 竺可桢学院 混合2504班 邓欢桐</center>

---

<center>
<img src="./public/20260323101520_871_96.png" style="zoom: 60%;" />
<img src="./public/20260323101521_872_96.png" style="zoom: 20%;" /><img src="./public/20260324164217_269_180.jpg" style="zoom: 25%;" />


</center>

---

[TOC]

---

## <center>Part 1: Gemini / ChatGPT / Claude 总结版</center>

### 总览：数据结构课程完整笔记

#### 1. 使用说明

这份笔记按照你上传的课件内容整理，目标是“像重新学一遍一样”系统梳理知识点。代码以 C 语言风格为主，变量命名尽量贴近课件。

#### 2. 总体学习路线

这些课件实际上构成了一条典型的数据结构学习路线：

1. 先学习算法分析：知道一个程序“快不快”“占多少空间”应该怎样衡量。
2. 学习线性结构：线性表、链表、栈、队列。
3. 学习树结构：一般树、二叉树、表达式树、遍历、线索二叉树。
4. 学习搜索树：二叉搜索树及其查找、插入、删除。
5. 学习堆：优先队列与二叉堆。
6. 学习并查集：动态等价关系、Union/Find、路径压缩。
7. 学习线段树：区间查询与单点更新。
8. 学习图：图的定义、存储、邻接矩阵、邻接表、拓扑排序。

#### 3. 代码统一约定

很多课件使用 `ElementType`、`Position`、`SearchTree`、`PriorityQueue` 等抽象类型。下面是本笔记中常用的基础约定：

```c
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <limits.h>

#define TRUE 1
#define FALSE 0
#define ERROR -1

typedef int ElementType;

static void FatalError(const char *msg) {
    fprintf(stderr, "%s\n", msg);
    exit(EXIT_FAILURE);
}
```

### 第 01 章：算法分析基础（Algorithm Analysis I）

#### 1. 算法的定义

算法是一个有限的指令集合，如果按照这些指令执行，就能完成某个特定任务。一个算法必须满足以下五个条件：

1. 输入 Input：算法可以有零个或多个外部输入。
2. 输出 Output：算法至少产生一个输出。
3. 确定性 Definiteness：每一步指令必须清楚、无歧义。
4. 有穷性 Finiteness：对任何合法输入，算法都必须在有限步后终止。
5. 有效性 Effectiveness：每一步必须足够基本，原则上能由人用纸笔执行。

要特别区分算法和程序：

- 算法必须有限终止。
- 程序是某种编程语言写出的实现，不一定必须终止，例如操作系统理论上会一直运行。
- 算法可以用自然语言、流程图、伪代码、程序语言来描述。

#### 2. 选择排序 Selection Sort

选择排序的基本思想：

> 在当前未排序部分中找到最小元素，把它交换到未排序部分的开头。

伪代码：

```text
for i = 0 to n - 1:
    在 list[i] 到 list[n-1] 中找到最小元素 list[min]
    交换 list[i] 和 list[min]
```

C 语言实现：

```c
void SelectionSort(int list[], int n) {
    for (int i = 0; i < n - 1; ++i) {
        int min = i;
        for (int j = i + 1; j < n; ++j) {
            if (list[j] < list[min]) {
                min = j;
            }
        }
        if (min != i) {
            int tmp = list[i];
            list[i] = list[min];
            list[min] = tmp;
        }
    }
}
```

复杂度分析：

- 外层循环执行约 `N` 次。
- 第 `i` 次外层循环中，内层需要扫描约 `N - i` 个元素。
- 总比较次数约为

```text
(N - 1) + (N - 2) + ... + 1 = N(N - 1) / 2
```

所以时间复杂度为：

```text
T(N) = Θ(N^2)
```

空间复杂度为：

```text
S(N) = Θ(1)
```

#### 3. 算法分析到底分析什么

实际运行时间会受到很多因素影响：

- 机器硬件性能；
- 编译器优化；
- 编程语言；
- 操作系统；
- 缓存和内存访问；
- 输入数据分布。

为了得到更通用的分析，通常分析：

1. 时间复杂度：输入规模变大时，运行时间如何增长。
2. 空间复杂度：输入规模变大时，额外空间如何增长。

课件中常见假设：

1. 指令顺序执行。
2. 每条简单指令耗时一个单位。
3. 整数大小固定。
4. 内存足够大。

常分析两个函数：

```text
Tavg(N)    平均情况时间复杂度
Tworst(N)  最坏情况时间复杂度
```

如果输入规模不止一个，可以写成多变量函数，例如矩阵加法是：

```text
T(rows, cols)
```

#### 4. 矩阵加法复杂度

矩阵加法代码：

```c
#define MAX_SIZE 1000

void add(int a[][MAX_SIZE],
         int b[][MAX_SIZE],
         int c[][MAX_SIZE],
         int rows,
         int cols) {
    int i, j;
    for (i = 0; i < rows; i++) {
        for (j = 0; j < cols; j++) {
            c[i][j] = a[i][j] + b[i][j];
        }
    }
}
```

分析：

- 外层循环执行 `rows` 次。
- 每次外层循环，内层循环执行 `cols` 次。
- 核心赋值语句执行 `rows * cols` 次。

所以：

```text
T(rows, cols) = Θ(rows * cols)
```

如果精确计数，可以得到类似：

```text
T(rows, cols) = 2 * rows * cols + 2 * rows + 1
```

但在渐进复杂度中，常数项和低阶项不重要，因此写成：

```text
Θ(rows * cols)
```

#### 5. 顺序求和与递归求和

顺序版本：

```c
float sum(float list[], int n) {
    float tempsum = 0;
    int i;
    for (i = 0; i < n; i++) {
        tempsum += list[i];
    }
    return tempsum;
}
```

递归版本：

```c
float rsum(float list[], int n) {
    if (n) {
        return rsum(list, n - 1) + list[n - 1];
    }
    return 0;
}
```

两者的渐进时间复杂度都是：

```text
Θ(N)
```

但是递归版本通常有额外函数调用开销：

- 需要保存返回地址；
- 需要维护调用栈；
- 每层递归都有栈帧；
- 若 `n` 很大可能栈溢出。

所以不要只看 `2n+2` 和 `2n+3` 这样的精确步数，渐进增长趋势更重要。

#### 6. 为什么不总是精确计数

精确计数的问题：

1. 很复杂，容易出错。
2. 常数差异经常被机器、编译器、语言实现掩盖。
3. 当 `N` 足够大时，增长阶决定主要趋势。
4. 算法分析的核心是比较增长率。

比如：

```text
T1(N) = c1*N^2 + c2*N
T2(N) = c3*N
```

不管常数 `c1, c2, c3` 是多少，当 `N` 足够大时，`N^2` 级算法一定会比 `N` 级算法增长更快。

#### 7. 大 O 记号 Big-O

定义：

```text
T(N) = O(f(N))
```

表示存在正常数 `c` 和 `n0`，使得对所有 `N >= n0`，都有：

```text
T(N) <= c * f(N)
```

含义：`f(N)` 是 `T(N)` 的渐进上界。

例子：

```text
2N + 3 = O(N)
2N + 3 = O(N^2)
2N + 3 = O(2^N)
```

但我们通常取最紧的上界，所以写：

```text
2N + 3 = O(N)
```

#### 8. 大 Ω 记号 Big-Omega

定义：

```text
T(N) = Ω(g(N))
```

表示存在正常数 `c` 和 `n0`，使得对所有 `N >= n0`，都有：

```text
T(N) >= c * g(N)
```

含义：`g(N)` 是 `T(N)` 的渐进下界。

例子：

```text
2N + N^2 = Ω(N^2)
2N + N^2 = Ω(N)
2N + N^2 = Ω(1)
```

我们通常取最紧的下界：

```text
2N + N^2 = Ω(N^2)
```

#### 9. 大 Θ 记号 Big-Theta

定义：

```text
T(N) = Θ(h(N))
```

当且仅当：

```text
T(N) = O(h(N)) 且 T(N) = Ω(h(N))
```

含义：`h(N)` 是 `T(N)` 的渐进紧确界。

例子：

```text
3N^2 + 10N + 5 = Θ(N^2)
100N + 7 = Θ(N)
log N + 5 = Θ(log N)
```

#### 10. 小 o 记号 little-o

定义：

```text
T(N) = o(p(N))
```

表示 `T(N)` 的增长严格慢于 `p(N)`。

课件定义为：

```text
T(N) = O(p(N)) 且 T(N) != Θ(p(N))
```

例子：

```text
N = o(N^2)
log N = o(N)
N^2 = o(N^3)
```

但：

```text
N 不是 o(N)
N^2 不是 o(N)
```

#### 11. 渐进记号的运算规则

如果：

```text
T1(N) = O(f(N))
T2(N) = O(g(N))
```

则：

```text
T1(N) + T2(N) = O(max(f(N), g(N)))
T1(N) * T2(N) = O(f(N) * g(N))
```

如果 `T(N)` 是 `k` 次多项式：

```text
T(N) = ak*N^k + ... + a1*N + a0
```

且最高次项系数非零，则：

```text
T(N) = Θ(N^k)
```

对任意常数 `k`：

```text
log^k N = O(N)
```

这说明对数增长非常慢。

#### 12. 常见复杂度增长顺序

从慢到快一般为：

```text
O(1)
O(log N)
O(N)
O(N log N)
O(N^2)
O(N^3)
O(2^N)
O(N!)
O(N^N)
```

理解方式：

- `O(1)`：输入变大，耗时基本不变。
- `O(log N)`：每一步把问题规模按比例缩小，例如二分查找。
- `O(N)`：每个元素处理一次。
- `O(N log N)`：常见于高效排序、分治算法。
- `O(N^2)`：双重循环遍历所有二元组合。
- `O(N^3)`：三重循环。
- `O(2^N)`：指数爆炸，通常只能处理很小输入。

#### 13. for 循环分析规则

单层循环：

```c
for (int i = 0; i < n; ++i) {
    // O(1)
}
```

复杂度：

```text
O(N)
```

嵌套循环：

```c
for (int i = 0; i < n; ++i) {
    for (int j = 0; j < n; ++j) {
        // O(1)
    }
}
```

复杂度：

```text
O(N^2)
```

非等长嵌套循环：

```c
for (int i = 0; i < n; ++i) {
    for (int j = 0; j <= i; ++j) {
        // O(1)
    }
}
```

执行次数：

```text
1 + 2 + ... + N = N(N + 1)/2 = Θ(N^2)
```

#### 14. while 循环分析规则

如果每次循环将规模减半：

```c
while (n > 1) {
    n = n / 2;
}
```

则执行次数约为：

```text
log2 N
```

复杂度：

```text
O(log N)
```

如果每次只减 1：

```c
while (n > 0) {
    n--;
}
```

复杂度：

```text
O(N)
```

如果每次乘 2：

```c
for (int i = 1; i < n; i *= 2) {
    // O(1)
}
```

复杂度：

```text
O(log N)
```

#### 15. 递归复杂度：斐波那契

课件中给出递归 Fibonacci：

```c
long int Fib(int N) {
    if (N <= 1) {
        return 1;
    } else {
        return Fib(N - 1) + Fib(N - 2);
    }
}
```

递推式：

```text
T(N) = T(N - 1) + T(N - 2) + O(1)
```

这是指数级复杂度，大约为：

```text
O(φ^N)
```

其中 `φ ≈ 1.618`。递归树会产生大量重复计算。

改进方法：动态规划或迭代：

```c
long int FibIter(int N) {
    if (N <= 1) return 1;
    long int a = 1, b = 1, c = 0;
    for (int i = 2; i <= N; ++i) {
        c = a + b;
        a = b;
        b = c;
    }
    return b;
}
```

复杂度：

```text
T(N) = O(N)
S(N) = O(1)
```

### 第 02 章：算法比较与典型问题（Algorithm Analysis II）

#### 1. 最大子列和问题 Maximum Subsequence Sum

问题：给定可能含有负数的整数序列：

```text
A1, A2, ..., AN
```

求所有连续子列中元素和的最大值。

课件约定：如果所有整数都是负数，最大子列和为 0。

例如：

```text
A = [-1, 3, -2, 4, -6, 1, 6, -1]
```

最大子列可以是：

```text
3 + (-2) + 4 + (-6) + 1 + 6 = 6
```

也可以根据具体数组分析，目标是找连续区间 `[i, j]` 使得：

```text
A[i] + A[i+1] + ... + A[j]
```

最大。

#### 2. 算法 1：三重循环 O(N^3)

思想：枚举起点 `i`，枚举终点 `j`，再从 `i` 到 `j` 累加。

```c
int MaxSubsequenceSum1(const int A[], int N) {
    int ThisSum, MaxSum, i, j, k;
    MaxSum = 0;

    for (i = 0; i < N; i++) {
        for (j = i; j < N; j++) {
            ThisSum = 0;
            for (k = i; k <= j; k++) {
                ThisSum += A[k];
            }
            if (ThisSum > MaxSum) {
                MaxSum = ThisSum;
            }
        }
    }
    return MaxSum;
}
```

复杂度分析：

- `i` 有 `N` 种。
- `j` 对每个 `i` 最多有 `N` 种。
- `k` 对每对 `(i, j)` 最多扫描 `N` 个。

所以：

```text
T(N) = O(N^3)
```

缺点：大量重复求和。例如 `[i, j]` 和 `[i, j+1]` 的和只差一个元素，但算法 1 每次重新从头加。

#### 3. 算法 2：二重循环 O(N^2)

思想：固定起点 `i` 后，终点 `j` 从 `i` 向右扩展，`ThisSum` 累加即可，不必每次重新求和。

```c
int MaxSubsequenceSum2(const int A[], int N) {
    int ThisSum, MaxSum, i, j;
    MaxSum = 0;

    for (i = 0; i < N; i++) {
        ThisSum = 0;
        for (j = i; j < N; j++) {
            ThisSum += A[j];
            if (ThisSum > MaxSum) {
                MaxSum = ThisSum;
            }
        }
    }
    return MaxSum;
}
```

复杂度：

```text
T(N) = O(N^2)
```

比算法 1 快的原因是：

- 算法 1 每个区间都重新求和。
- 算法 2 利用上一个区间和递推：

```text
sum(i, j) = sum(i, j - 1) + A[j]
```

#### 4. 算法 3：分治法 O(N log N)

最大子列和只可能在三种位置：

1. 完全在左半部分。
2. 完全在右半部分。
3. 跨越中间位置。

递归求左半、右半，然后线性扫描求跨越中点的最大和。

核心递推式：

```text
T(N) = 2T(N/2) + O(N)
```

由主定理或展开可得：

```text
T(N) = O(N log N)
```

代码：

```c
static int Max3(int a, int b, int c) {
    int max = a;
    if (b > max) max = b;
    if (c > max) max = c;
    return max;
}

static int MaxSubSumDivide(const int A[], int Left, int Right) {
    if (Left == Right) {
        return A[Left] > 0 ? A[Left] : 0;
    }

    int Center = (Left + Right) / 2;

    int MaxLeftSum = MaxSubSumDivide(A, Left, Center);
    int MaxRightSum = MaxSubSumDivide(A, Center + 1, Right);

    int MaxLeftBorderSum = 0, LeftBorderSum = 0;
    for (int i = Center; i >= Left; --i) {
        LeftBorderSum += A[i];
        if (LeftBorderSum > MaxLeftBorderSum) {
            MaxLeftBorderSum = LeftBorderSum;
        }
    }

    int MaxRightBorderSum = 0, RightBorderSum = 0;
    for (int i = Center + 1; i <= Right; ++i) {
        RightBorderSum += A[i];
        if (RightBorderSum > MaxRightBorderSum) {
            MaxRightBorderSum = RightBorderSum;
        }
    }

    return Max3(MaxLeftSum, MaxRightSum,
                MaxLeftBorderSum + MaxRightBorderSum);
}

int MaxSubsequenceSum3(const int A[], int N) {
    if (N <= 0) return 0;
    return MaxSubSumDivide(A, 0, N - 1);
}
```

#### 5. 算法 4：在线算法 / Kadane 算法 O(N)

课件称为 On-line Algorithm。

核心思想：

- 从左到右扫描数组。
- `ThisSum` 维护当前正在考虑的子列和。
- 若 `ThisSum` 变成负数，则它不可能帮助后面的子列变大，直接丢弃，重置为 0。
- 每一步都能给出目前读入数据的正确答案，所以是在线算法。

```c
int MaxSubsequenceSum4(const int A[], int N) {
    int ThisSum, MaxSum, j;
    ThisSum = MaxSum = 0;

    for (j = 0; j < N; j++) {
        ThisSum += A[j];

        if (ThisSum > MaxSum) {
            MaxSum = ThisSum;
        } else if (ThisSum < 0) {
            ThisSum = 0;
        }
    }
    return MaxSum;
}
```

复杂度：

```text
T(N) = O(N)
S(N) = O(1)
```

在线算法特点：

- 只扫描一次输入。
- 输入可以边读边处理。
- 任意时刻都能给出当前已读数据的最优答案。

#### 6. 四种最大子列和算法对比

| 算法 | 核心思想 | 时间复杂度 | 空间复杂度 | 优缺点 |
|:-:|:-:|:--:|:--:|:-:|
| 算法 1 | 枚举起点、终点、逐项求和 | $O(N^3)$ | $O(1)$ | 最直观但最慢 |
| 算法 2 | 固定起点后累加终点 | $O(N^2)$ | $O(1)$ | 避免重复求和 |
| 算法 3 | 分治 | $O(N log N)$ | $O(log N)$ | 思想重要，代码稍复杂 |
| 算法 4 | 在线扫描 | $O(N)$ | $O(1)$ | 最优，适合实际使用 |

#### 7. 二分查找 Binary Search

前提：数组已经有序：

```text
A[0] <= A[1] <= ... <= A[N-1]
```

任务：查找 `X`。

输出：

- 若找到，返回下标 `i`。
- 若没找到，返回 `-1`。

代码：

```c
int BinarySearch(const ElementType A[], ElementType X, int N) {
    int Low = 0;
    int High = N - 1;

    while (Low <= High) {
        int Mid = (Low + High) / 2;

        if (A[Mid] < X) {
            Low = Mid + 1;
        } else if (A[Mid] > X) {
            High = Mid - 1;
        } else {
            return Mid;
        }
    }
    return -1;
}
```

更安全的中点写法：

```c
int Mid = Low + (High - Low) / 2;
```

这样可以避免 `Low + High` 整数溢出。

复杂度：

每次查找把范围缩小一半：

```text
N, N/2, N/4, ..., 1
```

执行次数约为：

```text
log2 N
```

所以：

```text
T(N) = O(log N)
S(N) = O(1)
```

#### 8. 用运行时间倍增法检查复杂度

课件中给出一种实验检查方法：

- 若 `T(N) = O(N)`，则 `T(2N) / T(N) ≈ 2`。
- 若 `T(N) = O(N^2)`，则 `T(2N) / T(N) ≈ 4`。
- 若 `T(N) = O(N^3)`，则 `T(2N) / T(N) ≈ 8`。
- 若 `T(N) = O(log N)`，则比值增长很慢。
- 若 `T(N) = O(N log N)`，则 `T(2N) / T(N)` 略大于 2。

这是一种经验方法，不是严格证明，但很适合做实验报告或性能测试。

### 第 03 章：抽象数据类型与线性表（ADT & Lists）

#### 1. 抽象数据类型 ADT

数据类型可以看成：

```text
Data Type = Objects ∪ Operations
```

例如 `int`：

```text
Objects: 0, ±1, ±2, ..., INT_MAX, INT_MIN
Operations: +, -, *, /, %, ...
```

抽象数据类型 ADT 的关键思想：

> 把“对象是什么、能做什么操作”与“对象如何表示、操作如何实现”分离。

也就是说：

- 用户只需要知道接口。
- 实现者负责内部存储和算法。
- 同一个 ADT 可以有不同实现。

例如线性表 ADT 可以用数组实现，也可以用链表实现。

#### 2. 线性表 List ADT

对象：

```text
(item0, item1, ..., itemN-1)
```

常见操作：

1. 求表长 `Length`。
2. 打印所有元素。
3. 创建空表。
4. 查找第 `k` 个元素。
5. 在第 `k` 个元素后插入新元素。
6. 删除某个元素。
7. 找当前元素的下一个元素。
8. 找当前元素的前一个元素。

#### 3. 数组实现线性表

数组实现：

```text
array[i] = item_i
```

优点：

- 顺序映射，地址连续。
- 第 `k` 个元素可直接访问。
- `Find_Kth` 时间复杂度为 `O(1)`。

缺点：

- 最大容量 `MaxSize` 需要预估。
- 插入和删除需要移动大量元素。
- 插入、删除最坏复杂度为 `O(N)`。

代码示例：

```c
#define MAX_LIST_SIZE 1000

typedef struct {
    ElementType data[MAX_LIST_SIZE];
    int size;
} ArrayList;

void InitArrayList(ArrayList *L) {
    L->size = 0;
}

int Length(ArrayList *L) {
    return L->size;
}

ElementType FindKth(ArrayList *L, int k) {
    if (k < 0 || k >= L->size) {
        FatalError("Index out of range");
    }
    return L->data[k];
}

void InsertAfter(ArrayList *L, int k, ElementType x) {
    if (L->size >= MAX_LIST_SIZE) {
        FatalError("List is full");
    }
    if (k < -1 || k >= L->size) {
        FatalError("Invalid position");
    }

    for (int i = L->size; i > k + 1; --i) {
        L->data[i] = L->data[i - 1];
    }
    L->data[k + 1] = x;
    L->size++;
}

void DeleteAt(ArrayList *L, int k) {
    if (k < 0 || k >= L->size) {
        FatalError("Invalid position");
    }

    for (int i = k; i < L->size - 1; ++i) {
        L->data[i] = L->data[i + 1];
    }
    L->size--;
}
```

#### 4. 单链表 Linked List

链表由若干节点构成，每个节点包含：

1. 数据域；
2. 指向下一个节点的指针。

节点定义：

```c
typedef struct ListNode *ListPtr;

struct ListNode {
    ElementType Element;
    ListPtr Next;
};
```

链表示意：

```text
head -> node1 -> node2 -> node3 -> NULL
```

优点：

- 不需要预估最大长度。
- 插入和删除只需要修改指针，若已知位置则为 `O(1)`。

缺点：

- 不支持随机访问。
- 查找第 `k` 个元素需要从头扫描，复杂度 `O(N)`。
- 每个节点需要额外指针空间。

#### 5. 单链表插入

在 `node` 后插入 `temp`：

```text
1. temp->Next = node->Next
2. node->Next = temp
```

顺序不能反。若先执行：

```c
node->Next = temp;
temp->Next = node->Next;
```

则 `temp->Next` 会指向自己，原来 `node` 后面的链表丢失。

代码：

```c
void InsertAfterNode(ListPtr node, ElementType x) {
    if (node == NULL) {
        FatalError("node is NULL");
    }

    ListPtr temp = (ListPtr)malloc(sizeof(struct ListNode));
    if (temp == NULL) {
        FatalError("Out of space");
    }

    temp->Element = x;
    temp->Next = node->Next;
    node->Next = temp;
}
```

#### 6. 单链表删除

删除 `pre` 后面的节点 `node`：

```text
1. pre->Next = node->Next
2. free(node)
```

代码：

```c
void DeleteAfterNode(ListPtr pre) {
    if (pre == NULL || pre->Next == NULL) {
        FatalError("No node to delete");
    }

    ListPtr node = pre->Next;
    pre->Next = node->Next;
    free(node);
}
```

删除第一个节点不方便，因为需要修改头指针。常见解决方案是加一个 dummy head node（头结点）。

#### 7. 带头结点的链表

带头结点的链表：

```text
Header -> first -> second -> ... -> NULL
```

头结点不存有效数据，只统一操作。

好处：

- 插入第一个节点和插入中间节点统一。
- 删除第一个节点和删除中间节点统一。
- 很多边界条件更简单。

代码：

```c
typedef ListPtr List;

typedef ListPtr Position;

List CreateList(void) {
    List L = (List)malloc(sizeof(struct ListNode));
    if (L == NULL) FatalError("Out of space");
    L->Next = NULL;
    return L;
}

int IsEmptyList(List L) {
    return L->Next == NULL;
}

Position Find(ElementType X, List L) {
    Position P = L->Next;
    while (P != NULL && P->Element != X) {
        P = P->Next;
    }
    return P;
}

Position FindPrevious(ElementType X, List L) {
    Position P = L;
    while (P->Next != NULL && P->Next->Element != X) {
        P = P->Next;
    }
    return P;
}

void Insert(ElementType X, List L, Position P) {
    Position TmpCell = (Position)malloc(sizeof(struct ListNode));
    if (TmpCell == NULL) FatalError("Out of space");

    TmpCell->Element = X;
    TmpCell->Next = P->Next;
    P->Next = TmpCell;
}

void Delete(ElementType X, List L) {
    Position P = FindPrevious(X, L);
    if (P->Next != NULL) {
        Position TmpCell = P->Next;
        P->Next = TmpCell->Next;
        free(TmpCell);
    }
}
```

#### 8. 双向循环链表 Doubly Linked Circular List

普通单链表找前驱节点不方便。双向链表每个节点包含：

1. 左指针 `llink`；
2. 数据；
3. 右指针 `rlink`。

定义：

```c
typedef struct DNode *DNodePtr;

struct DNode {
    DNodePtr LLink;
    ElementType Element;
    DNodePtr RLink;
};
```

双向循环链表通常带头结点：

```text
H <-> node1 <-> node2 <-> ... <-> H
```

空表：

```text
H->LLink = H
H->RLink = H
```

性质：

```c
ptr == ptr->LLink->RLink;
ptr == ptr->RLink->LLink;
```

初始化：

```c
DNodePtr CreateDList(void) {
    DNodePtr H = (DNodePtr)malloc(sizeof(struct DNode));
    if (H == NULL) FatalError("Out of space");
    H->LLink = H;
    H->RLink = H;
    return H;
}
```

在 `P` 之后插入：

```c
void DInsertAfter(DNodePtr P, ElementType X) {
    DNodePtr NewNode = (DNodePtr)malloc(sizeof(struct DNode));
    if (NewNode == NULL) FatalError("Out of space");

    NewNode->Element = X;

    NewNode->RLink = P->RLink;
    NewNode->LLink = P;
    P->RLink->LLink = NewNode;
    P->RLink = NewNode;
}
```

删除节点 `P`：

```c
void DDelete(DNodePtr P) {
    if (P == NULL) return;
    P->LLink->RLink = P->RLink;
    P->RLink->LLink = P->LLink;
    free(P);
}
```

#### 9. 多项式 ADT Polynomial ADT

多项式：

```text
P(x) = a1*x^e1 + a2*x^e2 + ... + an*x^en
```

每一项可以表示为有序对：

```text
<exponent, coefficient>
```

操作：

1. 求次数 degree，即最大指数。
2. 多项式加法。
3. 多项式减法。
4. 多项式乘法。
5. 求导。

#### 10. 多项式数组表示

数组表示：

```c
#define MaxDegree 1000

typedef struct {
    int CoeffArray[MaxDegree + 1];
    int HighPower;
} *Polynomial;
```

含义：

```text
CoeffArray[i] 表示 x^i 的系数
HighPower 表示最高次数
```

优点：实现简单。

缺点：稀疏多项式浪费严重。例如：

```text
P1(x) = 10x^1000 + 5x^14 + 1
P2(x) = 3x^1990 - 2x^1492 + 11x + 5
```

用数组需要存很多系数为 0 的项。

#### 11. 多项式链表表示

每个非零项一个节点：

```c
typedef struct PolyNode *PolyPtr;

struct PolyNode {
    int Coefficient;
    int Exponent;
    PolyPtr Next;
};
```

通常按指数递减或递增排序。

多项式加法：

```c
PolyPtr CreatePolyHeader(void) {
    PolyPtr H = (PolyPtr)malloc(sizeof(struct PolyNode));
    if (H == NULL) FatalError("Out of space");
    H->Next = NULL;
    return H;
}

// 尾指针移动，所以需要使用二级指针
static void AttachTerm(int coeff, int exp, PolyPtr *Rear) {
    if (coeff == 0) return;

    PolyPtr NewNode = (PolyPtr)malloc(sizeof(struct PolyNode));
    if (NewNode == NULL) FatalError("Out of space");

    NewNode->Coefficient = coeff;
    NewNode->Exponent = exp;
    NewNode->Next = NULL;

    (*Rear)->Next = NewNode;
    *Rear = NewNode;
}

PolyPtr AddPolynomial(PolyPtr A, PolyPtr B) {
    PolyPtr PA = A->Next;
    PolyPtr PB = B->Next;
    PolyPtr C = CreatePolyHeader();
    PolyPtr Rear = C;

    while (PA != NULL && PB != NULL) {
        if (PA->Exponent > PB->Exponent) {
            AttachTerm(PA->Coefficient, PA->Exponent, &Rear);
            PA = PA->Next;
        } else if (PA->Exponent < PB->Exponent) {
            AttachTerm(PB->Coefficient, PB->Exponent, &Rear);
            PB = PB->Next;
        } else {
            int sum = PA->Coefficient + PB->Coefficient;
            AttachTerm(sum, PA->Exponent, &Rear);
            PA = PA->Next;
            PB = PB->Next;
        }
    }

    while (PA != NULL) {
        AttachTerm(PA->Coefficient, PA->Exponent, &Rear);
        PA = PA->Next;
    }
    while (PB != NULL) {
        AttachTerm(PB->Coefficient, PB->Exponent, &Rear);
        PB = PB->Next;
    }

    return C;
}
```

#### 12. 多重链表 Multilist

课件例子：

> 40000 个学生、2500 门课程。既要按课程打印学生名单，又要按学生打印已选课程。

若用二维数组：

```c
int Array[40000][2500];
```

空间巨大，而且选课矩阵通常很稀疏。

多重链表思想：

- 每个选课关系是一个节点。
- 节点同时挂在“学生链表”和“课程链表”上。
- 因而可以从学生方向遍历，也可以从课程方向遍历。

节点可设计为：

```c
typedef struct EnrollNode *EnrollPtr;

struct EnrollNode {
    int StudentID;
    int CourseID;
    EnrollPtr NextStudentCourse;  // 同一个学生选的下一门课
    EnrollPtr NextCourseStudent;  // 同一门课的下一个学生
};
```

优点：适合稀疏关系，避免巨大二维数组。

#### 13. 游标实现 Cursor Implementation

游标实现用于没有指针的语言，或希望避免频繁 `malloc/free` 的场景。

思想：

- 用数组模拟内存。
- 数组下标充当“指针”。
- 每个节点保存数据和下一个节点下标。
- `CursorSpace[0]` 常作为空闲链表头。

定义：

```c
#define SpaceSize 1000

typedef int PtrToNode;
typedef PtrToNode ListCursor;
typedef PtrToNode PositionCursor;

struct CursorNode {
    ElementType Element;
    PtrToNode Next;
};

struct CursorNode CursorSpace[SpaceSize];
```

初始化空闲链表：

```c
void InitializeCursorSpace(void) {
    for (int i = 0; i < SpaceSize - 1; ++i) {
        CursorSpace[i].Next = i + 1;
    }
    CursorSpace[SpaceSize - 1].Next = 0;
}
```

模拟 `malloc`：

```c
PtrToNode CursorAlloc(void) {
    PtrToNode P = CursorSpace[0].Next;
    if (P == 0) {
        FatalError("Out of cursor space");
    }
    CursorSpace[0].Next = CursorSpace[P].Next;
    return P;
}
```

模拟 `free`：

```c
void CursorFree(PtrToNode P) {
    CursorSpace[P].Next = CursorSpace[0].Next;
    CursorSpace[0].Next = P;
}
```

优点：

- 避免系统 `malloc/free` 开销。
- 内存局部性可能更好。

缺点：

- 空间大小固定。
- 实现较抽象，容易写错下标。

### 第 04 章：栈与队列（Stacks & Queues）

#### 1. 栈 Stack ADT

栈是后进先出 LIFO 的线性表：

```text
Last In, First Out
```

插入和删除都只发生在栈顶 `top`。

对象：有限有序表。

操作：

```c
int IsEmpty(Stack S);
Stack CreateStack(void);
void DisposeStack(Stack S);
void MakeEmpty(Stack S);
void Push(ElementType X, Stack S);
ElementType Top(Stack S);
void Pop(Stack S);
```

注意：

- 对空栈执行 `Pop` 或 `Top` 是 ADT 错误。
- 对满栈执行 `Push` 是具体实现错误，不是栈 ADT 本身的逻辑错误。

#### 2. 栈的链表实现

使用带头结点链表，头结点后第一个元素就是栈顶。

定义：

```c
typedef struct StackNode *Stack;

struct StackNode {
    ElementType Element;
    Stack Next;
};
```

创建栈：

```c
Stack CreateStack(void) {
    Stack S = (Stack)malloc(sizeof(struct StackNode));
    if (S == NULL) FatalError("Out of space");
    S->Next = NULL;
    return S;
}
```

判空：

```c
int IsEmptyStack(Stack S) {
    return S->Next == NULL;
}
```

入栈：

```c
void Push(ElementType X, Stack S) {
    Stack TmpCell = (Stack)malloc(sizeof(struct StackNode));
    if (TmpCell == NULL) FatalError("Out of space");

    TmpCell->Element = X;
    TmpCell->Next = S->Next;
    S->Next = TmpCell;
}
```

取栈顶：

```c
ElementType Top(Stack S) {
    if (IsEmptyStack(S)) {
        FatalError("Empty stack");
    }
    return S->Next->Element;
}
```

出栈：

```c
void Pop(Stack S) {
    if (IsEmptyStack(S)) {
        FatalError("Empty stack");
    }

    Stack FirstCell = S->Next;
    S->Next = S->Next->Next;
    free(FirstCell);
}
```

链式栈缺点：频繁 `malloc/free` 比较慢。课件提到可以维护一个“回收栈”作为 recycle bin，重复利用节点。

#### 3. 栈的数组实现

定义：

```c
typedef struct StackRecord *ArrayStack;

struct StackRecord {
    int Capacity;
    int TopOfStack;
    ElementType *Array;
};
```

约定：

- 空栈时 `TopOfStack = -1`。
- 入栈时先 `++TopOfStack`。
- 出栈时 `--TopOfStack`。

创建：

```c
ArrayStack CreateArrayStack(int MaxElements) {
    ArrayStack S = (ArrayStack)malloc(sizeof(struct StackRecord));
    if (S == NULL) FatalError("Out of space");

    S->Array = (ElementType *)malloc(sizeof(ElementType) * MaxElements);
    if (S->Array == NULL) FatalError("Out of space");

    S->Capacity = MaxElements;
    S->TopOfStack = -1;
    return S;
}
```

判空和判满：

```c
int IsEmptyArrayStack(ArrayStack S) {
    return S->TopOfStack == -1;
}

int IsFullArrayStack(ArrayStack S) {
    return S->TopOfStack == S->Capacity - 1;
}
```

入栈：

```c
void PushArray(ElementType X, ArrayStack S) {
    if (IsFullArrayStack(S)) {
        FatalError("Full stack");
    }
    S->Array[++S->TopOfStack] = X;
}
```

出栈和取顶：

```c
ElementType TopArray(ArrayStack S) {
    if (IsEmptyArrayStack(S)) {
        FatalError("Empty stack");
    }
    return S->Array[S->TopOfStack];
}

void PopArray(ArrayStack S) {
    if (IsEmptyArrayStack(S)) {
        FatalError("Empty stack");
    }
    S->TopOfStack--;
}

ElementType TopAndPopArray(ArrayStack S) {
    if (IsEmptyArrayStack(S)) {
        FatalError("Empty stack");
    }
    return S->Array[S->TopOfStack--];
}
```

封装原则：除了栈操作函数，不应直接访问 `Array` 和 `TopOfStack`。

#### 4. 栈应用：括号匹配 Balancing Symbols

目标：检查表达式中的括号是否匹配，包括：

```text
(), [], {}
```

算法：

1. 建立空栈。
2. 从左到右读取字符。
3. 遇到左括号则入栈。
4. 遇到右括号：
   - 如果栈空，错误。
   - 否则检查栈顶左括号是否匹配。
   - 匹配则弹栈，不匹配则错误。
5. 扫描结束后，如果栈不空，错误。

代码：

```c
static int IsOpening(char c) {
    return c == '(' || c == '[' || c == '{';
}

static int IsClosing(char c) {
    return c == ')' || c == ']' || c == '}';
}

static int Match(char left, char right) {
    return (left == '(' && right == ')') ||
           (left == '[' && right == ']') ||
           (left == '{' && right == '}');
}

int CheckBalanced(const char *expr) {
    char stack[1000];
    int top = -1;

    for (int i = 0; expr[i] != '\0'; ++i) {
        char c = expr[i];

        if (IsOpening(c)) {
            stack[++top] = c;
        } else if (IsClosing(c)) {
            if (top == -1) return FALSE;
            if (!Match(stack[top], c)) return FALSE;
            top--;
        }
    }

    return top == -1;
}
```

复杂度：

```text
T(N) = O(N)
S(N) = O(N)
```

这也是在线算法，因为扫描过程中可以随时发现错误。

#### 5. 后缀表达式求值 Postfix Evaluation

中缀表达式：

```text
a + b * c - d / e
```

前缀表达式：

```text
- + a * b c / d e
```

后缀表达式：

```text
a b c * + d e / -
```

后缀表达式又叫逆波兰表达式 Reverse Polish Notation。

求值规则：

1. 从左到右读 token。
2. 操作数入栈。
3. 运算符出现时，弹出所需操作数，计算结果，再压回栈。
4. 最后栈中唯一元素就是结果。

例子：

```text
6 2 / 3 - 4 2 * +
```

计算：

```text
6 2 / => 3
3 3 - => 0
4 2 * => 8
0 8 + => 8
```

代码：

```c
int EvalPostfix(const char *tokens[], int n) {
    int stack[1000];
    int top = -1;

    for (int i = 0; i < n; ++i) {
        const char *t = tokens[i];

        if (strcmp(t, "+") == 0 || strcmp(t, "-") == 0 ||
            strcmp(t, "*") == 0 || strcmp(t, "/") == 0) {
            if (top < 1) FatalError("Invalid postfix expression");

            int b = stack[top--];
            int a = stack[top--];
            int r = 0;

            if (strcmp(t, "+") == 0) r = a + b;
            else if (strcmp(t, "-") == 0) r = a - b;
            else if (strcmp(t, "*") == 0) r = a * b;
            else {
                if (b == 0) FatalError("Division by zero");
                r = a / b;
            }
            stack[++top] = r;
        } else {
            stack[++top] = atoi(t);
        }
    }

    if (top != 0) FatalError("Invalid postfix expression");
    return stack[top];
}
```

复杂度：

```text
T(N) = O(N)
```

优点：不需要处理优先级和括号。

#### 6. 中缀转后缀 Infix to Postfix

核心规则：

1. 操作数直接输出。
2. 运算符进入栈前，要弹出栈中优先级更高或相等的运算符。
3. 左括号入栈，但不被普通运算符弹出。
4. 遇到右括号，弹出直到左括号。
5. 扫描结束后弹出栈中所有运算符。

注意：

- 中缀和后缀中，操作数相对顺序不变。
- 高优先级运算符在后缀表达式中更早出现。
- `a - b - c` 转为 `a b - c -`，因为减法左结合。
- `2^2^3` 应转为 `2 2 3 ^ ^`，因为指数运算右结合。

简化代码：

```c
int Precedence(char op) {
    switch (op) {
        case '+': case '-': return 1;
        case '*': case '/': return 2;
        case '^': return 3;
        default: return 0;
    }
}

int IsRightAssociative(char op) {
    return op == '^';
}

int IsOperator(char c) {
    return c == '+' || c == '-' || c == '*' || c == '/' || c == '^';
}

void InfixToPostfix(const char *infix, char *postfix) {
    char stack[1000];
    int top = -1;
    int k = 0;

    for (int i = 0; infix[i] != '\0'; ++i) {
        char c = infix[i];

        if (c == ' ') continue;

        if ((c >= 'a' && c <= 'z') ||
            (c >= 'A' && c <= 'Z') ||
            (c >= '0' && c <= '9')) {
            postfix[k++] = c;
            postfix[k++] = ' ';
        } else if (c == '(') {
            stack[++top] = c;
        } else if (c == ')') {
            while (top >= 0 && stack[top] != '(') {
                postfix[k++] = stack[top--];
                postfix[k++] = ' ';
            }
            if (top < 0) FatalError("Mismatched parentheses");
            top--; // pop '('
        } else if (IsOperator(c)) {
            while (top >= 0 && IsOperator(stack[top])) {
                char s = stack[top];
                int shouldPop = 0;

                if (!IsRightAssociative(c) && Precedence(s) >= Precedence(c)) {
                    shouldPop = 1;
                }
                if (IsRightAssociative(c) && Precedence(s) > Precedence(c)) {
                    shouldPop = 1;
                }

                if (!shouldPop) break;
                postfix[k++] = stack[top--];
                postfix[k++] = ' ';
            }
            stack[++top] = c;
        }
    }

    while (top >= 0) {
        if (stack[top] == '(') FatalError("Mismatched parentheses");
        postfix[k++] = stack[top--];
        postfix[k++] = ' ';
    }

    postfix[k] = '\0';
}
```

复杂度：

```text
T(N) = O(N)
S(N) = O(N)
```

#### 7. 函数调用与系统栈

函数调用时系统栈会保存：

1. 返回地址；
2. 局部变量；
3. 参数；
4. 旧的帧指针；
5. 当前栈帧。

递归本质上依赖系统栈。

例子：

```c
void PrintListRecursive(List L) {
    if (L != NULL) {
        printf("%d\n", L->Element);
        PrintListRecursive(L->Next);
    }
}
```

这是尾递归，但若链表有一百万个节点，可能栈溢出。

迭代版本更安全：

```c
void PrintListIterative(List L) {
    while (L != NULL) {
        printf("%d\n", L->Element);
        L = L->Next;
    }
}
```

结论：

- 递归程序通常更简洁、更容易理解。
- 非递归程序通常更快，且不会产生大量函数调用栈开销。
- 有些尾递归可由编译器优化成循环，但不能完全依赖。

#### 8. 队列 Queue ADT

队列是先进先出 FIFO 的线性表：

```text
First In, First Out
```

插入在队尾 `Rear`，删除在队头 `Front`。

操作：

```c
int IsEmpty(Queue Q);
Queue CreateQueue(void);
void DisposeQueue(Queue Q);
void MakeEmpty(Queue Q);
void Enqueue(ElementType X, Queue Q);
ElementType Front(Queue Q);
void Dequeue(Queue Q);
```

#### 9. 队列的数组实现与循环队列

如果普通数组队列每次出队后不移动元素，那么队头会不断向右走，造成前面空间浪费。

解决方法：循环队列。

定义：

```c
typedef struct QueueRecord *Queue;

struct QueueRecord {
    int Capacity;
    int Front;
    int Rear;
    int Size;
    ElementType *Array;
};
```

创建：

```c
Queue CreateQueue(int MaxElements) {
    Queue Q = (Queue)malloc(sizeof(struct QueueRecord));
    if (Q == NULL) FatalError("Out of space");

    Q->Array = (ElementType *)malloc(sizeof(ElementType) * MaxElements);
    if (Q->Array == NULL) FatalError("Out of space");

    Q->Capacity = MaxElements;
    Q->Front = 0;
    Q->Rear = -1;
    Q->Size = 0;
    return Q;
}
```

循环下标：

```c
static int Succ(int Value, Queue Q) {
    if (++Value == Q->Capacity) {
        Value = 0;
    }
    return Value;
}
```

判空、判满：

```c
int IsEmptyQueue(Queue Q) {
    return Q->Size == 0;
}

int IsFullQueue(Queue Q) {
    return Q->Size == Q->Capacity;
}
```

入队：

```c
void Enqueue(ElementType X, Queue Q) {
    if (IsFullQueue(Q)) {
        FatalError("Full queue");
    }
    Q->Rear = Succ(Q->Rear, Q);
    Q->Array[Q->Rear] = X;
    Q->Size++;
}
```

出队：

```c
void Dequeue(Queue Q) {
    if (IsEmptyQueue(Q)) {
        FatalError("Empty queue");
    }
    Q->Front = Succ(Q->Front, Q);
    Q->Size--;
}

ElementType Front(Queue Q) {
    if (IsEmptyQueue(Q)) {
        FatalError("Empty queue");
    }
    return Q->Array[Q->Front];
}

ElementType FrontAndDequeue(Queue Q) {
    ElementType X = Front(Q);
    Dequeue(Q);
    return X;
}
```

#### 10. 不使用 Size 字段的循环队列

如果不用 `Size` 字段，常用方法是浪费一个空位置：

```text
空：Front == Rear
满：(Rear + 1) % Capacity == Front
```

这样做可以区分空和满，否则两者都可能表现为 `Front == Rear`。

课件指出：加入 `Size` 字段可以避免浪费一个空位置。

---

### 第 05 章：树与二叉树（Trees & Binary Trees）

#### 1. 树的定义

树是节点的集合。树可以为空；非空树由以下部分组成：

1. 一个特殊节点 `r`，称为根 root。
2. 零个或多个非空子树 `T1, T2, ..., Tk`，每棵子树的根都由一条从 `r` 出发的边连接。

重要性质：

- 子树之间不能相交。
- 树中每个节点都是某棵子树的根。
- 有 `N` 个节点的树有 `N - 1` 条边。
- 树通常把根画在上方。

#### 2. 树的基本术语

节点的度 degree：某节点的子树个数。

树的度：树中所有节点度的最大值。

叶节点 leaf / terminal node：度为 0 的节点。

父节点 parent：有子树的节点。

孩子 children：某节点子树的根。

兄弟 siblings：同一个父节点的孩子。

祖先 ancestors：从某节点向上到根路径上的所有节点。

后代 descendants：某节点子树中的所有节点。

深度 depth：从根到该节点路径长度。根深度为 0。

高度 height：从该节点到叶节点的最长路径长度。叶节点高度为 0。

树的高度：根节点高度，也等于最深叶节点深度。

路径 path：节点序列 `n1, n2, ..., nk`，其中 `ni` 是 `n(i+1)` 的父节点。

路径长度：路径上的边数。

#### 3. 树的链表式表示问题

若每个节点直接存所有孩子指针：

```text
A(B, C, D)
```

那么不同节点孩子个数不同，节点大小不统一。

例如：

```text
(A)
(A(B, C, D))
(A(B(E, F), C(G), D(H, I, J)))
```

这种表示对一般树不方便。

#### 4. FirstChild-NextSibling 表示法

每个节点只保存两个指针：

1. `FirstChild`：第一个孩子。
2. `NextSibling`：下一个兄弟。

定义：

```c
typedef struct TreeNode *Tree;

struct TreeNode {
    ElementType Element;
    Tree FirstChild;
    Tree NextSibling;
};
```

优点：

- 每个节点大小固定。
- 任意度数的一般树都可以表示。
- 与二叉树结构天然对应。

注意：一般树中孩子之间本来无顺序，因此这种表示不唯一。

#### 5. 二叉树 Binary Tree

二叉树是每个节点最多有两个孩子的树。

二叉树节点区分左孩子和右孩子，因此：

```text
A 的左孩子是 B
```

和：

```text
A 的右孩子是 B
```

是两棵不同的二叉树。

定义：

```c
typedef struct BinaryTreeNode *BinaryTree;

struct BinaryTreeNode {
    ElementType Element;
    BinaryTree Left;
    BinaryTree Right;
};
```

FirstChild-NextSibling 表示法可以通过旋转理解为二叉树：

- 左指针表示第一个孩子。
- 右指针表示下一个兄弟。

#### 6. 表达式树 Expression Tree

表达式树是一种语法树。

例如中缀表达式：

```text
A + B * C / D
```

对应表达式树根可能是 `+`，左子树是 `A`，右子树是 `/`。

表达式树特点：

- 叶节点通常是操作数。
- 内部节点通常是运算符。
- 中序遍历可得到中缀表达式。
- 前序遍历可得到前缀表达式。
- 后序遍历可得到后缀表达式。

由后缀表达式构造表达式树：

1. 扫描后缀表达式。
2. 操作数生成单节点树并入栈。
3. 运算符出现时，弹出两棵树作为左右子树，生成新树入栈。
4. 最后栈顶为表达式树。

代码：

```c
typedef struct ExprNode *ExprTree;

struct ExprNode {
    char Token;
    ExprTree Left;
    ExprTree Right;
};

ExprTree NewExprNode(char token) {
    ExprTree T = (ExprTree)malloc(sizeof(struct ExprNode));
    if (T == NULL) FatalError("Out of space");
    T->Token = token;
    T->Left = T->Right = NULL;
    return T;
}

int IsExprOperator(char c) {
    return c == '+' || c == '-' || c == '*' || c == '/';
}

ExprTree BuildExprTreeFromPostfix(const char *postfix) {
    ExprTree stack[1000];
    int top = -1;

    for (int i = 0; postfix[i] != '\0'; ++i) {
        char c = postfix[i];
        if (c == ' ') continue;

        if (!IsExprOperator(c)) {
            stack[++top] = NewExprNode(c);
        } else {
            ExprTree right = stack[top--];
            ExprTree left = stack[top--];
            ExprTree root = NewExprNode(c);
            root->Left = left;
            root->Right = right;
            stack[++top] = root;
        }
    }
    return stack[top];
}
```

#### 7. 树的遍历 Traversal

遍历：每个节点恰好访问一次。

常见遍历：

1. 前序 preorder；
2. 后序 postorder；
3. 层序 levelorder；
4. 二叉树中序 inorder。

#### 8. 一般树前序遍历

先访问根，再访问各子树：

```c
void Preorder(Tree T) {
    if (T != NULL) {
        printf("%d ", T->Element);
        for (Tree C = T->FirstChild; C != NULL; C = C->NextSibling) {
            Preorder(C);
        }
    }
}
```

复杂度：

```text
T(N) = O(N)
```

#### 9. 一般树后序遍历

先访问各子树，再访问根：

```c
void Postorder(Tree T) {
    if (T != NULL) {
        for (Tree C = T->FirstChild; C != NULL; C = C->NextSibling) {
            Postorder(C);
        }
        printf("%d ", T->Element);
    }
}
```

复杂度：

```text
T(N) = O(N)
```

#### 10. 层序遍历

层序遍历使用队列：

1. 根入队。
2. 队列非空时出队访问。
3. 把该节点的所有孩子入队。

伪代码：

```text
enqueue(root)
while queue is not empty:
    T = dequeue()
    visit(T)
    for each child C of T:
        enqueue(C)
```

代码：

```c
void LevelOrderTraversal(BinaryTree root) {
    if (root == NULL) {
        return;
    }

    Queue Q;
    InitQueue(&Q);

    EnQueue(&Q, root);

    while (!IsEmpty(&Q)) {
        BinaryTree T = DeQueue(&Q);

        printf("%c ", T->Element);

        // 遍历 T 的所有孩子
        BinaryTree child = T->Left;

        while (child != NULL) {
            EnQueue(&Q, child);
            child = child->Right;
        }
    }
}
```

复杂度：

```text
T(N) = O(N)
S(N) = O(W)
```

其中 `W` 是树的最大宽度。

#### 11. 二叉树中序遍历

中序遍历：左子树、根、右子树。

递归代码：

```c
void Inorder(BinaryTree T) {
    if (T != NULL) {
        Inorder(T->Left);
        printf("%d ", T->Element);
        Inorder(T->Right);
    }
}
```

如果是表达式树，中序遍历得到中缀表达式。

#### 12. 二叉树前序、后序

前序：根、左、右。

```c
void BinaryPreorder(BinaryTree T) {
    if (T != NULL) {
        printf("%d ", T->Element);
        BinaryPreorder(T->Left);
        BinaryPreorder(T->Right);
    }
}
```

后序：左、右、根。

```c
void BinaryPostorder(BinaryTree T) {
    if (T != NULL) {
        BinaryPostorder(T->Left);
        BinaryPostorder(T->Right);
        printf("%d ", T->Element);
    }
}
```

#### 13. 非递归中序遍历

使用栈模拟递归：

```c
void IterInorder(BinaryTree T) {
    BinaryTree stack[1000];
    int top = -1;

    while (T != NULL || top != -1) {
        while (T != NULL) {
            stack[++top] = T;
            T = T->Left;
        }

        T = stack[top--];
        printf("%d ", T->Element);
        T = T->Right;
    }
}
```

复杂度：

```text
T(N) = O(N)
S(N) = O(h)
```

其中 `h` 是树高。

#### 14. 目录树应用：打印目录

层级文件系统天然是树。

打印目录时，用深度控制缩进：

```c
void PrintTabs(int Depth) {
    for (int i = 0; i < Depth; ++i) {
        printf("\t");
    }
}

void ListDir(Tree D, int Depth) {
    if (D != NULL) {
        PrintTabs(Depth);
        printf("%d\n", D->Element);

        for (Tree C = D->FirstChild; C != NULL; C = C->NextSibling) {
            ListDir(C, Depth + 1);
        }
    }
}

void ListDirectory(Tree D) {
    ListDir(D, 0);
}
```

课件强调：`Depth` 是内部变量，不应暴露给用户，所以提供外层接口 `ListDirectory(D)`。

#### 15. 目录大小计算

计算目录大小本质是后序遍历：

```c
int SizeDir(Tree D) {
    if (D == NULL) return 0;

    int TotalSize = D->Element; // 假设 Element 是当前文件大小

    for (Tree C = D->FirstChild; C != NULL; C = C->NextSibling) {
        TotalSize += SizeDir(C);
    }
    return TotalSize;
}
```

复杂度：

```text
T(N) = O(N)
```

每个文件或目录访问一次。

#### 16. 线索二叉树 Threaded Binary Tree

普通二叉树中，有很多空指针。

对于有 `n` 个节点的二叉树：

- 每个节点有两个指针，总共 `2n` 个指针。
- 实际边数是 `n - 1`。
- 空指针数为：

```text
2n - (n - 1) = n + 1
```

线索二叉树利用这些空指针保存遍历前驱/后继，方便不用栈进行遍历。

中序线索规则：

1. 若 `Tree->Left` 为空，用它指向中序前驱。
2. 若 `Tree->Right` 为空，用它指向中序后继。
3. 必须有头结点，避免悬空线索。

定义：

```c
typedef struct ThreadedTreeNode *ThreadedTree;

struct ThreadedTreeNode {
    int LeftThread;
    ThreadedTree Left;
    ElementType Element;
    int RightThread;
    ThreadedTree Right;
};
```

含义：

- `LeftThread == TRUE` 表示 `Left` 不是左孩子，而是线索。
- `RightThread == TRUE` 表示 `Right` 不是右孩子，而是线索。

### 第 06 章：二叉树性质与二叉搜索树（BST）

#### 1. 斜二叉树 Skewed Binary Tree

斜二叉树是一种退化二叉树：

- 所有节点都只有左孩子：左斜树。
- 所有节点都只有右孩子：右斜树。

它的高度接近 `N - 1`，很多操作退化为线性复杂度。

#### 2. 完全二叉树 Complete Binary Tree

课件中描述：所有叶节点在相邻的两层上。

更常见定义：除了最后一层外，其余层都满，最后一层从左到右连续填充。

完全二叉树非常适合数组存储，因此堆通常使用完全二叉树。

#### 3. 二叉树性质 1：第 i 层最大节点数

若根在第 1 层，则第 `i` 层最多有：

```text
2^(i - 1)
```

个节点。

#### 4. 二叉树性质 2：深度为 k 的最大节点数

若根层为第 1 层，深度/层数为 `k`，最大节点数为：

```text
2^k - 1
```

这是满二叉树的节点数。

#### 5. 二叉树性质 3：叶节点数与二度节点数

对任意非空二叉树：

```text
n0 = n2 + 1
```

其中：

- `n0` 是叶节点数；
- `n2` 是度为 2 的节点数。

证明：

设：

```text
n = n0 + n1 + n2
```

其中 `n1` 是度为 1 的节点数。

树有 `n` 个节点，因此边数：

```text
B = n - 1
```

另一方面，边从有孩子的节点发出：

```text
B = n1 + 2n2
```

所以：

```text
n - 1 = n1 + 2n2
n0 + n1 + n2 - 1 = n1 + 2n2
n0 - 1 = n2
n0 = n2 + 1
```

#### 6. 二叉搜索树 Binary Search Tree, BST

二叉搜索树可以为空。非空时满足：

1. 每个节点有一个 key，课件中假设 key 是整数且互异。
2. 左子树所有 key 小于根节点 key。
3. 右子树所有 key 大于根节点 key。
4. 左右子树本身也是二叉搜索树。

重要推论：BST 的中序遍历会得到递增序列。

定义：

```c
typedef struct TreeNode *Position;
typedef struct TreeNode *SearchTree;

struct TreeNode {
    ElementType Element;
    SearchTree Left;
    SearchTree Right;
};
```

#### 7. BST ADT

常见操作：

```c
SearchTree MakeEmpty(SearchTree T);
Position Find(ElementType X, SearchTree T);
Position FindMin(SearchTree T);
Position FindMax(SearchTree T);
SearchTree Insert(ElementType X, SearchTree T);
SearchTree Delete(ElementType X, SearchTree T);
ElementType Retrieve(Position P);
```

复杂度一般与树高 `h` 有关：

```text
查找、插入、删除：O(h)
```

若树平衡：

```text
h = O(log N)
```

若树退化为链：

```text
h = O(N)
```

#### 8. BST 查找 Find

递归版本：

```c
Position FindBST(ElementType X, SearchTree T) {
    if (T == NULL) {
        return NULL;
    }

    if (X < T->Element) {
        return FindBST(X, T->Left);
    } else if (X > T->Element) {
        return FindBST(X, T->Right);
    } else {
        return T;
    }
}
```

这是尾递归，可以改成迭代。

迭代版本：

```c
Position IterFindBST(ElementType X, SearchTree T) {
    while (T != NULL) {
        if (X == T->Element) {
            return T;
        } else if (X < T->Element) {
            T = T->Left;
        } else {
            T = T->Right;
        }
    }
    return NULL;
}
```

复杂度：

```text
T(N) = O(d)
```

其中 `d` 是目标节点深度；最坏为 `O(h)`。

#### 9. BST FindMin 和 FindMax

最小元素在最左节点。

```c
Position FindMinBST(SearchTree T) {
    if (T == NULL) {
        return NULL;
    } else if (T->Left == NULL) {
        return T;
    } else {
        return FindMinBST(T->Left);
    }
}
```

最大元素在最右节点。

```c
Position FindMaxBST(SearchTree T) {
    if (T != NULL) {
        while (T->Right != NULL) {
            T = T->Right;
        }
    }
    return T;
}
```

复杂度：

```text
O(h)
```

#### 10. BST 插入 Insert

插入思想：

1. 像查找一样向下走。
2. 若 `X < 当前节点`，进入左子树。
3. 若 `X > 当前节点`，进入右子树。
4. 走到空位置时创建新节点。
5. 若 key 已存在，课件默认什么都不做。

代码：

```c
SearchTree InsertBST(ElementType X, SearchTree T) {
    if (T == NULL) {
        T = (SearchTree)malloc(sizeof(struct TreeNode));
        if (T == NULL) {
            FatalError("Out of space");
        }
        T->Element = X;
        T->Left = T->Right = NULL;
    } else if (X < T->Element) {
        T->Left = InsertBST(X, T->Left);
    } else if (X > T->Element) {
        T->Right = InsertBST(X, T->Right);
    }

    return T;
}
```

为什么最后必须 `return T`：

- 递归插入可能改变子树根指针。
- 返回根指针后，父节点才能正确接回子树。

重复 key 的处理方法：

1. 忽略重复 key。
2. 增加计数字段 `Count`。
3. 把相同 key 的记录存在链表中。
4. 规定重复 key 放左边或右边，但要保持一致。

#### 11. BST 删除 Delete

删除分三种情况。

第一种：删除叶节点。

```text
直接把父节点对应指针置 NULL
```

第二种：删除度为 1 的节点。

```text
用它唯一的孩子替代它
```

第三种：删除度为 2 的节点。

做法：

1. 用左子树最大节点替代它；
2. 用右子树最小节点替代它。
3. 然后在原子树中删除那个替代节点。

替代节点一定至多只有一个孩子，因此删除会转化为前两种情况。

代码：

```c
SearchTree DeleteBST(ElementType X, SearchTree T) {
    Position TmpCell;

    if (T == NULL) {
        fprintf(stderr, "Element not found\n");
    } else if (X < T->Element) {
        T->Left = DeleteBST(X, T->Left);
    } else if (X > T->Element) {
        T->Right = DeleteBST(X, T->Right);
    } else {
        // found element to be deleted
        if (T->Left != NULL && T->Right != NULL) {
            // two children: replace with smallest in right subtree
            TmpCell = FindMinBST(T->Right);
            T->Element = TmpCell->Element;
            T->Right = DeleteBST(T->Element, T->Right);
        } else {
            // one or zero child
            TmpCell = T;
            if (T->Left == NULL) {
                T = T->Right;
            } else if (T->Right == NULL) {
                T = T->Left;
            }
            free(TmpCell);
        }
    }
    return T;
}
```

复杂度：

```text
T(N) = O(h)
```

#### 12. Lazy Deletion 懒惰删除

如果删除操作不多，可以使用懒惰删除：

- 在每个节点增加 `Deleted` 标记。
- 删除时不释放节点，只标记为 deleted。
- 查找时跳过 deleted 节点。
- 若同一 key 重新插入，可以取消 deleted 标记，不用重新 `malloc`。

节点定义：

```c
struct LazyTreeNode {
    ElementType Element;
    int Deleted;
    struct LazyTreeNode *Left;
    struct LazyTreeNode *Right;
};
```

优点：删除快，避免频繁释放和重新分配。

缺点：

- 树中无效节点变多会影响效率。
- 空间不释放。
- 需要定期重建或清理。

#### 13. BST 高度与插入顺序

同样的元素，不同插入顺序会得到不同高度。

例如插入：

```text
4, 2, 1, 3, 6, 5, 7
```

树比较平衡，高度小。

若按顺序插入：

```text
1, 2, 3, 4, 5, 6, 7
```

BST 会退化为右斜链，高度为 `N - 1`。

因此 BST 的性能依赖树形。为保证 `O(log N)`，需要平衡搜索树，如 AVL 树、红黑树等。

### 第 07 章：优先队列与堆（Priority Queues & Heaps）

#### 1. 优先队列 ADT

优先队列支持删除最高优先级或最低优先级元素。

课件主要讨论最小堆，因此操作为：

```c
PriorityQueue Initialize(int MaxElements);
void Insert(ElementType X, PriorityQueue H);
ElementType DeleteMin(PriorityQueue H);
ElementType FindMin(PriorityQueue H);
```

对象：有限有序表。

优先队列不是普通队列：

- 普通队列按进入顺序删除。
- 优先队列按优先级删除。

#### 2. 简单实现方式比较

| 实现 | 插入 | 删除最小/最大 | 特点 |
|:-:|:--:|:--:|:-:|
| 无序数组 | $Θ(1)$ | $Θ(N)$ | 插入快，删除慢 |
| 无序链表 | $Θ(1)$ | $Θ(N)$ | 插入快，删除要查找 |
| 有序数组 | $O(N)$ | $Θ(1)$ | 删除快，插入要移动 |
| 有序链表 | $O(N)$ | $Θ(1)$ | 删除快，插入要找位置 |
| BST | 平均 $O(log N)$ | 平均 $O(log N)$ | 但删除总偏向最小值，且指针开销大 |
| 二叉堆 | $O(log N)$ | $O(log N)$ | 优先队列最常用实现 |

课件指出：虽然平衡树可用，但优先队列不需要那么多 BST 操作，而且指针实现复杂，堆更合适。

#### 3. 二叉堆的结构性质

二叉堆是一棵完全二叉树。

完全二叉树适合数组存储，通常数组下标从 1 开始，`Elements[0]` 用作哨兵。

若节点下标为 `i`：

```text
parent(i) = i / 2       i != 1
leftChild(i) = 2i
rightChild(i) = 2i + 1
```

高度：

```text
h = floor(log N)
```

数组实现不需要显式指针。

#### 4. 最小堆的堆序性质

最小树：每个节点的 key 不大于其孩子 key。

最小堆：既是完全二叉树，又满足最小树性质。

因此最小元素一定在根：

```text
Elements[1]
```

最大堆类似，只是每个节点 key 不小于孩子 key。

#### 5. 堆结构定义

```c
#define MinPQSize 1
#define MinData INT_MIN

typedef struct HeapStruct *PriorityQueue;

struct HeapStruct {
    int Capacity;
    int Size;
    ElementType *Elements;
};
```

初始化：

```c
PriorityQueue Initialize(int MaxElements) {
    PriorityQueue H;

    if (MaxElements < MinPQSize) {
        FatalError("Priority queue size is too small");
    }

    H = (PriorityQueue)malloc(sizeof(struct HeapStruct));
    if (H == NULL) FatalError("Out of space");

    H->Elements = (ElementType *)malloc((MaxElements + 1) * sizeof(ElementType));
    if (H->Elements == NULL) FatalError("Out of space");

    H->Capacity = MaxElements;
    H->Size = 0;
    H->Elements[0] = MinData; // sentinel

    return H;
}
```

判空判满：

```c
int IsEmptyHeap(PriorityQueue H) {
    return H->Size == 0;
}

int IsFullHeap(PriorityQueue H) {
    return H->Size == H->Capacity;
}
```

#### 6. 堆插入 Insert：上滤 Percolate Up

插入步骤：

1. 新元素先放在完全二叉树的下一个空位。
2. 与父节点比较。
3. 若比父节点小，则父节点下移。
4. 重复直到找到合适位置。

课件代码使用哨兵 `Elements[0]`，可避免额外边界判断。

```c
void InsertHeap(ElementType X, PriorityQueue H) {
    int i;

    if (IsFullHeap(H)) {
        FatalError("Priority queue is full");
    }

    for (i = ++H->Size; H->Elements[i / 2] > X; i /= 2) {
        H->Elements[i] = H->Elements[i / 2];
    }

    H->Elements[i] = X;
}
```

复杂度：

```text
T(N) = O(log N)
```

因为最多从叶子上滤到根，高度为 `O(log N)`。

为什么不是每次交换：

- 代码先把父节点向下挪，最后一次性放入 `X`。
- 这样比频繁 swap 更快。

#### 7. FindMin

最小堆的最小值就在根节点：

```c
ElementType FindMin(PriorityQueue H) {
    if (IsEmptyHeap(H)) {
        FatalError("Priority queue is empty");
    }
    return H->Elements[1];
}
```

复杂度：

```text
O(1)
```

#### 8. DeleteMin：下滤 Percolate Down

删除最小元素步骤：

1. 保存根节点，即最小元素。
2. 取最后一个元素 `LastElement`。
3. 删除最后位置，保持完全二叉树结构。
4. 从根开始，让较小的孩子上移。
5. 找到 `LastElement` 合适位置。

代码：

```c
ElementType DeleteMin(PriorityQueue H) {
    int i, Child;
    ElementType MinElement, LastElement;

    if (IsEmptyHeap(H)) {
        FatalError("Priority queue is empty");
    }

    MinElement = H->Elements[1];
    LastElement = H->Elements[H->Size--];

    for (i = 1; i * 2 <= H->Size; i = Child) {
        Child = i * 2;

        if (Child != H->Size &&
            H->Elements[Child + 1] < H->Elements[Child]) {
            Child++;
        }

        if (LastElement > H->Elements[Child]) {
            H->Elements[i] = H->Elements[Child];
        } else {
            break;
        }
    }

    H->Elements[i] = LastElement;
    return MinElement;
}
```

复杂度：

```text
T(N) = O(log N)
```

#### 9. DecreaseKey

`DecreaseKey(P, Δ, H)`：降低位置 `P` 的 key。

在最小堆中，key 变小后可能破坏与父节点的关系，需要上滤。

```c
void DecreaseKey(int P, ElementType Delta, PriorityQueue H) {
    if (P < 1 || P > H->Size) {
        FatalError("Invalid position");
    }

    ElementType X = H->Elements[P] - Delta;
    int i;

    for (i = P; H->Elements[i / 2] > X; i /= 2) {
        H->Elements[i] = H->Elements[i / 2];
    }
    H->Elements[i] = X;
}
```

复杂度：

```text
O(log N)
```

#### 10. IncreaseKey

`IncreaseKey(P, Δ, H)`：增加位置 `P` 的 key。

在最小堆中，key 变大后可能破坏与孩子的关系，需要下滤。

```c
void PercolateDown(int P, PriorityQueue H) {
    int i, Child;
    ElementType Tmp = H->Elements[P];

    for (i = P; i * 2 <= H->Size; i = Child) {
        Child = i * 2;
        if (Child != H->Size &&
            H->Elements[Child + 1] < H->Elements[Child]) {
            Child++;
        }

        if (H->Elements[Child] < Tmp) {
            H->Elements[i] = H->Elements[Child];
        } else {
            break;
        }
    }
    H->Elements[i] = Tmp;
}

void IncreaseKey(int P, ElementType Delta, PriorityQueue H) {
    if (P < 1 || P > H->Size) {
        FatalError("Invalid position");
    }
    H->Elements[P] += Delta;
    PercolateDown(P, H);
}
```

#### 11. Delete 任意位置

删除位置 `P` 的元素：

课件思路：

```text
DecreaseKey(P, infinity, H)
DeleteMin(H)
```

即先把该元素降低到极小，使它上滤到根，再删除根。

代码示意：

```c
void DeleteAtHeap(int P, PriorityQueue H) {
    if (P < 1 || P > H->Size) {
        FatalError("Invalid position");
    }
    H->Elements[P] = MinData;
    // 上滤到根
    ElementType X = H->Elements[P];
    int i;
    for (i = P; H->Elements[i / 2] > X; i /= 2) {
        H->Elements[i] = H->Elements[i / 2];
    }
    H->Elements[i] = X;
    DeleteMin(H);
}
```

复杂度：

```text
O(log N)
```

#### 12. BuildHeap 建堆

如果一个一个插入 `N` 个元素：

```text
O(N log N)
```

更好的方法：从最后一个非叶节点开始下滤。

```c
void BuildHeap(PriorityQueue H) {
    for (int i = H->Size / 2; i > 0; --i) {
        PercolateDown(i, H);
    }
}
```

课件定理：完全二叉树所有节点高度之和为 `O(N)`，因此：

```text
BuildHeap = O(N)
```

理解：

- 很多节点是叶子，高度 0，不需要下滤。
- 只有少数靠近根的节点高度大。
- 总成本加起来是线性的。

#### 13. 优先队列应用：第 k 大元素

问题：给定 `N` 个元素和整数 `k`，找第 `k` 大元素。

方法 1：排序。

```text
O(N log N)
```

方法 2：建最大堆，执行 `DeleteMax` k 次。

```text
O(N + k log N)
```

方法 3：维护大小为 `k` 的最小堆。

步骤：

1. 前 `k` 个元素建最小堆。
2. 对后续元素 `x`：
   - 若 `x <= heapMin`，忽略。
   - 若 `x > heapMin`，删除堆顶，插入 `x`。
3. 最后堆顶就是第 `k` 大。

复杂度：

```text
O(N log k)
```

适合 `k` 远小于 `N` 的情况。

#### 14. d-Heap

二叉堆是每个节点 2 个孩子。d-heap 是每个节点有 `d` 个孩子。

数组下标若从 1 开始：

```text
parent(i) = (i + d - 2) / d
children(i) = d*(i - 1) + 2 到 d*(i - 1) + d + 1
```

特点：

- 树高变为 `log_d N`。
- `DeleteMin` 每层需要在 `d` 个孩子中找最小，需要 `d - 1` 次比较。
- 所以删除复杂度约为：

```text
O(d log_d N)
```

课件提醒：

- `*2`、`/2` 可用位移优化。
- `*d`、`/d` 不一定能。
- 当优先队列太大，不能完全放入内存时，d-heap 可能有意义，因为它降低树高，减少磁盘访问层数。

### 第 08 章：并查集（Disjoint Set ADT）

#### 1. 关系 Relation

集合 `S` 上的关系 `R`：对任意 `a, b ∈ S`，`a R b` 要么为真，要么为假。

如果 `a R b` 为真，则称 `a` 与 `b` 有关系。

#### 2. 等价关系 Equivalence Relation

关系 `~` 是等价关系，当且仅当它满足：

1. 自反性 Reflexive：`a ~ a`。
2. 对称性 Symmetric：若 `a ~ b`，则 `b ~ a`。
3. 传递性 Transitive：若 `a ~ b` 且 `b ~ c`，则 `a ~ c`。

若 `x ~ y`，则 `x` 和 `y` 属于同一个等价类。

#### 3. 动态等价问题 Dynamic Equivalence Problem

问题：不断读入关系 `a ~ b`，动态合并集合，并查询任意两个元素是否等价。

算法框架：

```text
Initialize N disjoint sets
while read a ~ b:
    if Find(a) != Find(b):
        Union(a, b)

while read query a, b:
    if Find(a) == Find(b): true
    else false
```

动态含义：关系是逐渐输入的，算法在线处理。

#### 4. 并查集的森林表示

集合表示为树，多个集合构成森林。

特点：

- 每个节点指向父节点。
- 根节点代表集合名。
- `Find(i)` 找 `i` 所在树的根。
- `Union(i, j)` 合并两棵树。

基本操作：

```text
Union(i, j): 用 Si ∪ Sj 替代 Si 和 Sj
Find(i): 找包含 i 的集合
```

#### 5. 数组表示

课件数组表示：

```text
S[element] = element 的父节点
S[root] = 0
```

更常用的优化表示：

```text
S[root] = -size 或 -height/rank
S[x] = parent index, if x is not root
```

基础定义：

```c
typedef int DisjSet[10000];
typedef int SetType;
```

初始化：

```c
void InitializeDisjSet(DisjSet S, int N) {
    for (int i = 1; i <= N; ++i) {
        S[i] = 0;
    }
}
```

基础 Find：

```c
SetType FindBasic(ElementType X, DisjSet S) {
    for (; S[X] > 0; X = S[X]) {
        ;
    }
    return X;
}
```

基础 Union：

```c
void SetUnionBasic(DisjSet S, SetType Root1, SetType Root2) {
    S[Root2] = Root1;
}
```

#### 6. 基础并查集的最坏情况

若总是把旧树挂到新节点下面，可能形成长链：

```text
N -> N-1 -> ... -> 1
```

例如：

```text
union(2, 1), find(1)
union(3, 2), find(1)
...
union(N, N-1), find(1)
```

每次 `find(1)` 越来越慢，总复杂度可达：

```text
Θ(N^2)
```

所以需要 smart union。

#### 7. 按大小合并 Union-by-Size

思想：总是把小树挂到大树下面。

数组中根节点保存负的集合大小：

```text
S[root] = -size
```

初始化：

```c
void InitializeBySize(DisjSet S, int N) {
    for (int i = 1; i <= N; ++i) {
        S[i] = -1;
    }
}
```

代码：

```c
void UnionBySize(DisjSet S, SetType Root1, SetType Root2) {
    if (S[Root1] > S[Root2]) {
        // Root1 size smaller because -2 > -5
        S[Root2] += S[Root1];
        S[Root1] = Root2;
    } else {
        S[Root1] += S[Root2];
        S[Root2] = Root1;
    }
}
```

课件引理：若树由 union-by-size 产生，含 `N` 个节点，则树高不超过：

```text
log2 N + 1
```

因此 `N` 次 Union 和 `M` 次 Find 的复杂度：

```text
O(N + M log N)
```

#### 8. 按高度合并 Union-by-Height / Union-by-Rank

思想：把矮树挂到高树下面。

如果高度相等，任选一个作为根，并把高度加 1。

代码：

```c
void InitializeByHeight(DisjSet S, int N) {
    for (int i = 1; i <= N; ++i) {
        S[i] = -1; // negative height or rank
    }
}

void UnionByHeight(DisjSet S, SetType Root1, SetType Root2) {
    if (S[Root1] < S[Root2]) {
        // Root1 has larger height/rank because value is more negative
        S[Root2] = Root1;
    } else {
        if (S[Root1] == S[Root2]) {
            S[Root2]--;
        }
        S[Root1] = Root2;
    }
}
```

#### 9. 路径压缩 Path Compression

思想：执行 `Find(X)` 时，把路径上的节点都直接挂到根上。

递归版本：

```c
SetType FindPathCompression(ElementType X, DisjSet S) {
    if (S[X] <= 0) {
        return X;
    } else {
        return S[X] = FindPathCompression(S[X], S);
    }
}
```

迭代版本：

```c
SetType FindPathCompressionIter(ElementType X, DisjSet S) {
    ElementType root, trail, lead;

    for (root = X; S[root] > 0; root = S[root]) {
        ;
    }

    for (trail = X; trail != root; trail = lead) {
        lead = S[trail];
        S[trail] = root;
    }

    return root;
}
```

单次 `Find` 可能稍慢，因为要改指针；但对一系列操作而言会极大加速。

注意：路径压缩会改变真实高度，因此不适合严格 union-by-height。通常把 height 看成估计的 rank，即 union-by-rank。

#### 10. Tarjan 复杂度结论

课件给出 Tarjan 引理：

对 `M >= N` 次 Find 和 `N - 1` 次 Union 的混合操作，使用 union-by-rank 和 path compression，复杂度为：

```text
T(M, N) = Θ(M * α(M, N))
```

其中 `α` 是反 Ackermann 函数，增长极慢。

实际中：

```text
α(M, N) <= 4
```

因此并查集优化后几乎可以视为均摊常数时间。

#### 11. 完整并查集模板

```c
#define MAXN 10000

typedef int DSU[MAXN + 1];

void DSU_Init(DSU parent, int n) {
    for (int i = 1; i <= n; ++i) {
        parent[i] = -1;
    }
}

int DSU_Find(DSU parent, int x) {
    if (parent[x] < 0) return x;
    return parent[x] = DSU_Find(parent, parent[x]);
}

void DSU_Union(DSU parent, int a, int b) {
    int ra = DSU_Find(parent, a);
    int rb = DSU_Find(parent, b);

    if (ra == rb) return;

    // union by size: more negative means larger set
    if (parent[ra] > parent[rb]) {
        int tmp = ra;
        ra = rb;
        rb = tmp;
    }

    parent[ra] += parent[rb];
    parent[rb] = ra;
}

int DSU_Same(DSU parent, int a, int b) {
    return DSU_Find(parent, a) == DSU_Find(parent, b);
}

int DSU_Size(DSU parent, int x) {
    int r = DSU_Find(parent, x);
    return -parent[r];
}
```

### 第 09 章：线段树（Segment Tree）

#### 1. 线段树动机

给定大数组：

```text
A[1000000]
```

需要频繁查询任意区间 `[L, R]` 的和。

朴素做法：

```c
ElementType QueryNaive(ElementType A[], int L, int R) {
    ElementType sum = 0;
    for (int i = L; i <= R; ++i) {
        sum += A[i];
    }
    return sum;
}
```

复杂度：

```text
T(N) = O(N)
```

如果查询非常频繁，这会很慢。

#### 2. 线段树结构

线段树是一棵二叉树，每个节点表示一个区间。

例如数组：

```text
A = [7, 2, 5, 8, 3]
```

根节点表示：

```text
[0, 4]
```

左右子树分别表示：

```text
[0, 2]
[3, 4]
```

继续递归直到叶节点 `[i, i]`。

每个节点保存该区间的聚合值，例如区间和。

#### 3. 线段树空间复杂度

如果有 `N` 个元素，线段树大约有：

```text
2N - 1
```

个有效节点。

实际数组实现常开：

```c
int tree[4 * MAXN];
```

因为非 2 的幂时，`4N` 足够安全。

#### 4. 建树 Build

代码：

```c
#define MAX_SEG_N 100000

int A_seg[MAX_SEG_N];
int tree_seg[4 * MAX_SEG_N];

void Build(int node, int start, int end) {
    if (start == end) {
        tree_seg[node] = A_seg[start];
        return;
    }

    int mid = (start + end) / 2;
    Build(2 * node, start, mid);
    Build(2 * node + 1, mid + 1, end);

    tree_seg[node] = tree_seg[2 * node] + tree_seg[2 * node + 1];
}
```

调用：

```c
Build(1, 0, n - 1);
```

复杂度：

```text
T(N) = O(N)
```

因为每个节点只计算一次。

#### 5. 区间查询 Query

查询 `[L, R]` 时，当前节点区间 `[start, end]` 与查询区间有三种关系：

1. No Overlap：完全不相交，返回 0。
2. Total Overlap：当前区间完全包含在查询区间内，直接返回节点值。
3. Partial Overlap：部分重叠，递归查询左右子树并合并。

代码：

```c
int Query(int node, int start, int end, int L, int R) {
    // Case 1: no overlap
    if (R < start || end < L) {
        return 0;
    }

    // Case 2: total overlap
    if (L <= start && end <= R) {
        return tree_seg[node];
    }

    // Case 3: partial overlap
    int mid = (start + end) / 2;
    int left_sum = Query(2 * node, start, mid, L, R);
    int right_sum = Query(2 * node + 1, mid + 1, end, L, R);

    return left_sum + right_sum;
}
```

复杂度：

```text
T(N) = O(log N)
```

严格来说，区间查询最多访问 `O(log N)` 层上的相关节点，常写作 `O(log N)` 或 `O(log N + k)`，对标准区间和查询为 `O(log N)` 量级。

#### 6. 单点更新 Update

把 `A[idx]` 改成 `val`。

步骤：

1. 从根开始，根据 `idx` 位于左半还是右半递归。
2. 找到叶节点后修改。
3. 回溯时重新计算祖先节点的区间和。

代码：

```c
void Update(int node, int start, int end, int idx, int val) {
    if (start == end) {
        tree_seg[node] = val;
        A_seg[idx] = val;
        return;
    }

    int mid = (start + end) / 2;

    if (start <= idx && idx <= mid) {
        Update(2 * node, start, mid, idx, val);
    } else {
        Update(2 * node + 1, mid + 1, end, idx, val);
    }

    tree_seg[node] = tree_seg[2 * node] + tree_seg[2 * node + 1];
}
```

复杂度：

```text
T(N) = O(log N)
```

#### 7. 线段树不仅能求和

线段树可用于任何满足区间合并的聚合操作：

1. 区间和 sum；
2. 区间最小值 min；
3. 区间最大值 max；
4. 区间 gcd；
5. 区间乘积；
6. 某些自定义统计值。

关键是定义合并函数：

```c
int Merge(int leftValue, int rightValue) {
    return leftValue + rightValue;
}
```

求最小值时：

```c
int MergeMin(int a, int b) {
    return a < b ? a : b;
}
```

No Overlap 的返回值要改成对应单位元：

- sum 的单位元是 0；
- min 的单位元是 `+∞`；
- max 的单位元是 `-∞`；
- gcd 的单位元可用 0。

#### 8. 区间更新与懒惰标记 Lazy Propagation

课件提到：若要做更一般的 RangeUpdate，例如：

```text
把下标 2 到 1000 的所有数都加 10
```

可以使用 lazy propagation。

核心思想：

- 若当前节点区间完全被更新区间覆盖，不立刻递归更新所有子节点。
- 只更新当前节点的值，并记录一个 lazy 标记。
- 等以后需要访问子节点时，再把标记下传。

区间加、区间和的简化模板：

```c
int lazy[4 * MAX_SEG_N];

void PushDown(int node, int start, int end) {
    if (lazy[node] == 0 || start == end) return;

    int mid = (start + end) / 2;
    int left = 2 * node;
    int right = 2 * node + 1;

    tree_seg[left] += lazy[node] * (mid - start + 1);
    tree_seg[right] += lazy[node] * (end - mid);

    lazy[left] += lazy[node];
    lazy[right] += lazy[node];

    lazy[node] = 0;
}

void RangeAdd(int node, int start, int end, int L, int R, int val) {
    if (R < start || end < L) return;

    if (L <= start && end <= R) {
        tree_seg[node] += val * (end - start + 1);
        lazy[node] += val;
        return;
    }

    PushDown(node, start, end);

    int mid = (start + end) / 2;
    RangeAdd(2 * node, start, mid, L, R, val);
    RangeAdd(2 * node + 1, mid + 1, end, L, R, val);

    tree_seg[node] = tree_seg[2 * node] + tree_seg[2 * node + 1];
}
```

### 第 10 章：图的定义与存储（Graph Definitions & Representation）

#### 1. 图 Graph

图记为：

```text
G(V, E)
```

其中：

- `G` 是图；
- `V = V(G)` 是有限非空顶点集合；
- `E = E(G)` 是有限边集合。

#### 2. 无向图 Undirected Graph

无向边：

```text
(vi, vj) = (vj, vi)
```

即边没有方向。

在无向图中，若有边 `(vi, vj)`：

- `vi` 和 `vj` 邻接 adjacent；
- 该边 incident on `vi` 和 `vj`。

#### 3. 有向图 Directed Graph / Digraph

有向边：

```text
<vi, vj> != <vj, vi>
```

其中：

- `vi` 是 tail；
- `vj` 是 head。

若有边 `<vi, vj>`：

- `vi` adjacent to `vj`；
- `vj` adjacent from `vi`。

#### 4. 课件限制

课件中对图有两个限制：

1. 不允许自环 self loop。
2. 不考虑重图 multigraph。

自环：

```text
(vi, vi) 或 <vi, vi>
```

重图：两个顶点之间有多条边。

#### 5. 完全图 Complete Graph

完全图是边数达到最大值的图。

无向简单图有 `n` 个顶点时，最多边数：

```text
n(n - 1) / 2
```

有向简单图若不允许自环，最多有向边数：

```text
n(n - 1)
```

#### 6. 子图 Subgraph

`G'` 是 `G` 的子图，当且仅当：

```text
V(G') ⊆ V(G)
E(G') ⊆ E(G)
```

#### 7. 路径 Path

从 `vp` 到 `vq` 的路径是顶点序列：

```text
vp, vi1, vi2, ..., vin, vq
```

并且相邻顶点之间的边都属于 `E(G)`。

路径长度：路径上的边数。

简单路径：除起点和终点外，中间顶点互不相同；更常见定义是路径中所有顶点互不重复。

回路/环 Cycle：起点等于终点的简单路径。

#### 8. 连通性 Connectivity

无向图中，若 `vi` 到 `vj` 有路径，则称 `vi` 和 `vj` 连通。

无向图连通：任意两个不同顶点都连通。

连通分量 Connected Component：无向图的极大连通子图。

树也可以从图角度定义为：

```text
connected and acyclic graph
```

即连通且无环的图。

#### 9. 有向图强连通与弱连通

强连通有向图：对任意顶点 `vi` 和 `vj`，都有：

```text
vi -> vj 的有向路径
vj -> vi 的有向路径
```

强连通分量：极大强连通子图。

弱连通：忽略边方向后，图是连通的。

#### 10. 顶点度 Degree

无向图中：

```text
Degree(v) = incident on v 的边数
```

有向图中：

- 入度 in-degree：进入 `v` 的边数。
- 出度 out-degree：从 `v` 发出的边数。
- 总度 degree：入度 + 出度。

DAG：Directed Acyclic Graph，有向无环图。

拓扑排序只适用于 DAG。

#### 11. 邻接矩阵 Adjacency Matrix

对 `n` 个顶点的图，用二维数组：

```c
int adj_mat[n][n];
```

定义：

```text
adj_mat[i][j] = 1, if (vi, vj) or <vi, vj> in E(G)
adj_mat[i][j] = 0, otherwise
```

带权图可存权重：

```text
adj_mat[i][j] = weight
```

若无边，可用：

```text
0, INF, -1
```

视具体问题而定。

优点：

- 判断两点是否相邻为 `O(1)`。
- 实现简单。

缺点：

- 空间复杂度 `O(n^2)`。
- 对稀疏图浪费空间。
- 遍历所有边也可能要扫描整个矩阵，时间 `O(n^2)`。

无向图邻接矩阵对称，可只存一半。课件给出一维数组技巧：

```text
adj_mat[n(n+1)/2] = {a11, a21, a22, ..., an1, ..., ann}
```

若用 1-based 且只存下三角，`aij` 的索引：

```text
i * (i - 1) / 2 + j
```

#### 12. 邻接表 Adjacency List

把矩阵每一行换成一个链表。

每个顶点有一个链表，存它的邻接点。

无向图中，每条边 `(u, v)` 会出现两次：

- `v` 在 `u` 的链表中；
- `u` 在 `v` 的链表中。

空间：

```text
n heads + 2e nodes
```

有向图中，每条边 `<u, v>` 通常只在 `u` 的出边表中出现一次。

遍历所有边：

```text
O(n + e)
```

适合稀疏图。

#### 13. 邻接表代码

定义：

```c
#define MAXV 1000

typedef struct AdjNode *PtrToAdjNode;

struct AdjNode {
    int AdjV;
    int Weight;
    PtrToAdjNode Next;
};

typedef struct VNode {
    PtrToAdjNode FirstEdge;
} AdjList[MAXV];

typedef struct GraphRecord *LGraph;

struct GraphRecord {
    int Nv;
    int Ne;
    AdjList G;
};
```

创建图：

```c
LGraph CreateGraph(int VertexNum) {
    LGraph Graph = (LGraph)malloc(sizeof(struct GraphRecord));
    if (Graph == NULL) FatalError("Out of space");

    Graph->Nv = VertexNum;
    Graph->Ne = 0;

    for (int v = 0; v < VertexNum; ++v) {
        Graph->G[v].FirstEdge = NULL;
    }

    return Graph;
}
```

插入有向边：

```c
void InsertDirectedEdge(LGraph Graph, int u, int v, int weight) {
    PtrToAdjNode NewNode = (PtrToAdjNode)malloc(sizeof(struct AdjNode));
    if (NewNode == NULL) FatalError("Out of space");

    NewNode->AdjV = v;
    NewNode->Weight = weight;
    NewNode->Next = Graph->G[u].FirstEdge;
    Graph->G[u].FirstEdge = NewNode;

    Graph->Ne++;
}
```

插入无向边：

```c
void InsertUndirectedEdge(LGraph Graph, int u, int v, int weight) {
    InsertDirectedEdge(Graph, u, v, weight);

    PtrToAdjNode NewNode = (PtrToAdjNode)malloc(sizeof(struct AdjNode));
    if (NewNode == NULL) FatalError("Out of space");

    NewNode->AdjV = u;
    NewNode->Weight = weight;
    NewNode->Next = Graph->G[v].FirstEdge;
    Graph->G[v].FirstEdge = NewNode;

    // 因为 InsertDirectedEdge 已经 Ne++，这里若按无向边计数，不再加 Ne
}
```

#### 14. 有向图入度问题

邻接表天然容易得到出度：

```text
out-degree(v) = graph[v] 链表长度
```

但入度需要扫描所有链表。

解决方法：

1. 增加逆邻接表 inverse adjacency list。
2. 用十字链表/多重链表等更复杂结构。
3. 建图时同时维护 `indegree[v]` 数组。

维护入度：

```c
int indegree[MAXV];

void InsertDirectedEdgeWithIndegree(LGraph Graph, int u, int v, int weight) {
    InsertDirectedEdge(Graph, u, v, weight);
    indegree[v]++;
}
```

#### 15. 邻接多重表 Adjacency Multilist

无向图邻接表中，每条边存两次。有时需要“标记边是否访问过”，例如遍历边而不是遍历顶点。

邻接多重表把一条无向边作为一个节点，同时挂在两个顶点的边表中。

边节点包含：

1. `v1`；
2. `v2`；
3. `next_v1`；
4. `next_v2`；
5. `mark`。

优点：

- 每条边只有一个节点。
- 方便标记边。

缺点：

- 实现复杂。
- 指针更多。

#### 16. 带权图 Weighted Edges

邻接矩阵：

```text
adj_mat[i][j] = weight
```

邻接表：节点中增加 `Weight` 字段。

```c
struct AdjNode {
    int AdjV;
    int Weight;
    PtrToAdjNode Next;
};
```

### 第 11 章：AOV 网络与拓扑排序（Topological Sort）

#### 1. AOV Network

AOV 网络：Activity On Vertex network。

定义：

```text
G 是有向图
V(G) 表示活动，例如课程
E(G) 表示先后关系，例如 C1 是 C3 的先修课
```

若有边：

```text
<C1, C3>
```

表示 `C1` 必须在 `C3` 之前完成。

#### 2. 前驱与后继

若从 `i` 到 `j` 有路径，则：

```text
i 是 j 的 predecessor
j 是 i 的 successor
```

若直接有边 `<i, j>`，则：

```text
i 是 j 的 immediate predecessor
j 是 i 的 immediate successor
```

#### 3. 偏序 Partial Order

偏序关系必须满足：

1. 传递性 transitive：若 `i -> k`，`k -> j`，则 `i -> j`。
2. 反自反 irreflexive：`i -> i` 不可能。

课程先修关系必须是反自反的，因为不可能要求一门课必须在自己之前完成。

可行的 AOV 网络必须是 DAG。

如果有环，例如：

```text
C1 -> C2 -> C3 -> C1
```

则表示每门课都依赖另一门课，项目不可行。

#### 4. 拓扑序 Topological Order

拓扑序是图中顶点的一个线性排列，使得：

```text
如果 i 是 j 的前驱，则 i 必须出现在 j 前面
```

换句话说，对每条有向边 `<u, v>`：

```text
u 在拓扑序中出现在 v 前面
```

拓扑序不一定唯一。

只有 DAG 才存在拓扑序。

#### 5. 拓扑排序基本算法

基本思想：

1. 找一个入度为 0 的顶点。
2. 输出该顶点。
3. 删除该顶点及其所有出边。
4. 重复直到所有顶点输出。
5. 若中途找不到入度为 0 的顶点但仍有顶点未输出，说明有环。

朴素版本每次扫描所有顶点找入度 0，复杂度可能较高。

#### 6. 拓扑排序改进：队列保存入度为 0 的顶点

课件改进：把所有未分配且入度为 0 的顶点放入特殊容器（队列或栈）。

算法：

1. 计算所有顶点入度。
2. 所有入度为 0 的顶点入队。
3. 当队列非空：
   - 出队顶点 `v`，输出。
   - 对 `v` 的每条出边 `v -> w`，令 `indegree[w]--`。
   - 若 `indegree[w] == 0`，则 `w` 入队。
4. 若输出顶点数小于 `Nv`，则有环。

#### 7. 拓扑排序代码

基于邻接表：

```c
int TopSort(LGraph Graph, int TopOrder[]) {
    int Indegree[MAXV] = {0};
    int QueueArr[MAXV];
    int front = 0, rear = 0;
    int cnt = 0;

    // 1. compute indegree
    for (int v = 0; v < Graph->Nv; ++v) {
        for (PtrToAdjNode P = Graph->G[v].FirstEdge; P != NULL; P = P->Next) {
            Indegree[P->AdjV]++;
        }
    }

    // 2. enqueue vertices with indegree 0
    for (int v = 0; v < Graph->Nv; ++v) {
        if (Indegree[v] == 0) {
            QueueArr[rear++] = v;
        }
    }

    // 3. process
    while (front < rear) {
        int v = QueueArr[front++];
        TopOrder[cnt++] = v;

        for (PtrToAdjNode P = Graph->G[v].FirstEdge; P != NULL; P = P->Next) {
            int w = P->AdjV;
            Indegree[w]--;
            if (Indegree[w] == 0) {
                QueueArr[rear++] = w;
            }
        }
    }

    // 4. if cnt < Nv, graph has a cycle
    return cnt == Graph->Nv;
}
```

复杂度：

```text
T(N, E) = O(N + E)
S(N) = O(N)
```

其中 `N` 是顶点数，`E` 是边数。

#### 8. 用栈还是队列

拓扑排序中，保存入度为 0 的顶点可以用：

- 队列；
- 栈；
- 优先队列。

不同容器会得到不同的拓扑序。

若要求字典序最小拓扑序，可以用最小堆/优先队列，每次取编号最小的入度为 0 顶点。

#### 9. 拓扑排序判环

如果图有环，则环内每个顶点至少有一个来自环内的前驱，因此它们不会变成入度 0。

所以算法结束时：

```text
输出顶点数 < 总顶点数
```

说明有环。

代码中：

```c
if (cnt != Graph->Nv) {
    printf("Graph has a cycle\n");
}
```

#### 10. 拓扑排序应用

1. 课程先修关系安排。
2. 工程任务调度。
3. 编译依赖分析。
4. 包管理器安装顺序。
5. 有向无环图上的动态规划。

### 附录 A：综合复杂度速查表

#### 1. 线性结构

| 数据结构/操作 | 时间复杂度 | 说明 |
|---|---:|---|
| 数组按下标访问 | O(1) | 随机访问 |
| 数组插入/删除 | O(N) | 需要移动元素 |
| 单链表已知位置插入/删除 | O(1) | 只改指针 |
| 单链表查找 | O(N) | 需要顺序扫描 |
| 栈 Push/Pop/Top | O(1) | 数组或链表均可 |
| 队列 Enqueue/Dequeue/Front | O(1) | 循环数组或链表 |

#### 2. 树结构

| 操作 | 时间复杂度 | 说明 |
|---|---:|---|
| 树遍历 | O(N) | 每个节点访问一次 |
| 二叉树中序遍历 | O(N) | 递归或栈 |
| BST 查找 | O(h) | h 是树高 |
| BST 插入 | O(h) | 平衡时 O(log N) |
| BST 删除 | O(h) | 退化时 O(N) |
| 堆 FindMin | O(1) | 根节点 |
| 堆 Insert | O(log N) | 上滤 |
| 堆 DeleteMin | O(log N) | 下滤 |
| BuildHeap | O(N) | 自底向上下滤 |

#### 3. 并查集与线段树

| 数据结构/操作 | 时间复杂度 | 说明 |
|---|---:|---|
| 普通 Find | O(h) | 最坏可 O(N) |
| Union-by-size Find | O(log N) | 树高受控 |
| 路径压缩 + 按秩合并 | 近似 O(1) | 均摊 O(α(N)) |
| 线段树 Build | O(N) | 每个节点一次 |
| 线段树区间查询 | O(log N) | 标准区间聚合 |
| 线段树单点更新 | O(log N) | 更新根到叶路径 |
| 懒惰线段树区间更新 | O(log N) | lazy propagation |

#### 4. 图结构

| 图表示/算法 | 时间复杂度 | 空间复杂度 | 说明 |
|---|---:|---:|---|
| 邻接矩阵判断边 | O(1) | O(N^2) | 适合稠密图 |
| 邻接表遍历边 | O(N + E) | O(N + E) | 适合稀疏图 |
| 拓扑排序 | O(N + E) | O(N) | 只适用于 DAG |

### 附录 B：常见考试与作业易错点

#### 1. 大 O 不等于精确时间

`O(N)` 只表示增长上界，不表示程序一定比 `O(N^2)` 在所有输入规模下快。若 `N` 很小，常数项可能主导。

但当 `N` 足够大时，低阶复杂度通常更优。

#### 2. 递归复杂度要写递推式

例如分治最大子列和：

```text
T(N) = 2T(N/2) + O(N)
```

不能只看代码有递归就写 `O(log N)`，还要看每层做了多少工作。

#### 3. 链表插入顺序不能反

正确：

```c
temp->Next = node->Next;
node->Next = temp;
```

错误顺序会丢失原链表后半部分。

#### 4. 链表删除必须先保存被删节点

正确：

```c
Tmp = P->Next;
P->Next = Tmp->Next;
free(Tmp);
```

如果先断链但没有保存节点地址，就无法释放该节点。

#### 5. 栈空时不能 Top/Pop

一定先判空：

```c
if (IsEmpty(S)) Error;
```

#### 6. 中缀转后缀要注意括号和结合性

特别注意：

```text
2^2^3 => 2 2 3 ^ ^
```

因为指数运算通常右结合。

#### 7. BST 删除两个孩子节点时不是直接删除

要先找替代节点：

- 左子树最大；或
- 右子树最小。

再删除替代节点。

#### 8. 堆不是完全有序

最小堆只保证：

```text
父节点 <= 子节点
```

不保证左子树所有节点都小于右子树，也不支持快速查找任意元素。查找非最小元素通常是 `O(N)`。

#### 9. BuildHeap 是 O(N)，不是 O(N log N)

虽然每次下滤最多 `O(log N)`，但大多数节点高度很小，总高度和是 `O(N)`。

#### 10. 并查集路径压缩会改变树高

因此与 union-by-height 严格意义不兼容。实际常使用 union-by-rank，把 rank 看成估计高度。

#### 11. 线段树查询的三种重叠关系必须分清

```text
No Overlap      返回单位元
Total Overlap   直接返回 tree[node]
Partial Overlap 递归左右儿子
```

#### 12. 拓扑排序不能处理有环图

若输出顶点数不足 `N`，说明图中有环，不存在拓扑序。

### 附录 C：综合演示代码

#### 1. 包含最大子列和、二分查找、并查集、线段树、堆的简化主程序

```c
#include <stdio.h>
#include <stdlib.h>
#include <limits.h>

#define MAXN 1000
#define TRUE 1
#define FALSE 0

typedef int ElementType;

void FatalError(const char *msg) {
    fprintf(stderr, "%s\n", msg);
    exit(EXIT_FAILURE);
}

int MaxSubsequenceSum(const int A[], int N) {
    int ThisSum = 0, MaxSum = 0;
    for (int i = 0; i < N; ++i) {
        ThisSum += A[i];
        if (ThisSum > MaxSum) MaxSum = ThisSum;
        else if (ThisSum < 0) ThisSum = 0;
    }
    return MaxSum;
}

int BinarySearch(const int A[], int X, int N) {
    int low = 0, high = N - 1;
    while (low <= high) {
        int mid = low + (high - low) / 2;
        if (A[mid] < X) low = mid + 1;
        else if (A[mid] > X) high = mid - 1;
        else return mid;
    }
    return -1;
}

int parent[MAXN + 1];

void DSU_Init(int n) {
    for (int i = 1; i <= n; ++i) parent[i] = -1;
}

int DSU_Find(int x) {
    if (parent[x] < 0) return x;
    return parent[x] = DSU_Find(parent[x]);
}

void DSU_Union(int a, int b) {
    int ra = DSU_Find(a), rb = DSU_Find(b);
    if (ra == rb) return;
    if (parent[ra] > parent[rb]) {
        int tmp = ra; ra = rb; rb = tmp;
    }
    parent[ra] += parent[rb];
    parent[rb] = ra;
}

int A[MAXN];
int seg[4 * MAXN];

void Build(int node, int l, int r) {
    if (l == r) {
        seg[node] = A[l];
        return;
    }
    int mid = (l + r) / 2;
    Build(node * 2, l, mid);
    Build(node * 2 + 1, mid + 1, r);
    seg[node] = seg[node * 2] + seg[node * 2 + 1];
}

int Query(int node, int l, int r, int L, int R) {
    if (R < l || r < L) return 0;
    if (L <= l && r <= R) return seg[node];
    int mid = (l + r) / 2;
    return Query(node * 2, l, mid, L, R) +
           Query(node * 2 + 1, mid + 1, r, L, R);
}

void Update(int node, int l, int r, int idx, int val) {
    if (l == r) {
        seg[node] = val;
        A[idx] = val;
        return;
    }
    int mid = (l + r) / 2;
    if (idx <= mid) Update(node * 2, l, mid, idx, val);
    else Update(node * 2 + 1, mid + 1, r, idx, val);
    seg[node] = seg[node * 2] + seg[node * 2 + 1];
}

typedef struct HeapStruct *PriorityQueue;
struct HeapStruct {
    int Capacity;
    int Size;
    int *Elements;
};

PriorityQueue HeapInit(int cap) {
    PriorityQueue H = malloc(sizeof(struct HeapStruct));
    H->Elements = malloc(sizeof(int) * (cap + 1));
    H->Capacity = cap;
    H->Size = 0;
    H->Elements[0] = INT_MIN;
    return H;
}

void HeapInsert(int x, PriorityQueue H) {
    if (H->Size == H->Capacity) FatalError("heap full");
    int i;
    for (i = ++H->Size; H->Elements[i / 2] > x; i /= 2) {
        H->Elements[i] = H->Elements[i / 2];
    }
    H->Elements[i] = x;
}

int HeapDeleteMin(PriorityQueue H) {
    if (H->Size == 0) FatalError("heap empty");
    int min = H->Elements[1];
    int last = H->Elements[H->Size--];
    int i, child;
    for (i = 1; i * 2 <= H->Size; i = child) {
        child = i * 2;
        if (child != H->Size && H->Elements[child + 1] < H->Elements[child]) {
            child++;
        }
        if (last > H->Elements[child]) {
            H->Elements[i] = H->Elements[child];
        } else break;
    }
    H->Elements[i] = last;
    return min;
}

int main(void) {
    int arr[] = {-1, 3, -2, 4, -6, 1, 6, -1};
    int n = sizeof(arr) / sizeof(arr[0]);
    printf("MaxSubsequenceSum = %d\n", MaxSubsequenceSum(arr, n));

    int sorted[] = {1, 3, 5, 7, 9};
    printf("BinarySearch 7 = %d\n", BinarySearch(sorted, 7, 5));

    DSU_Init(10);
    DSU_Union(1, 2);
    DSU_Union(2, 3);
    printf("1 and 3 same? %d\n", DSU_Find(1) == DSU_Find(3));

    for (int i = 0; i < 5; ++i) A[i] = i + 1;
    Build(1, 0, 4);
    printf("Query [1,3] = %d\n", Query(1, 0, 4, 1, 3));
    Update(1, 0, 4, 2, 10);
    printf("Query [1,3] after update = %d\n", Query(1, 0, 4, 1, 3));

    PriorityQueue H = HeapInit(10);
    HeapInsert(5, H);
    HeapInsert(2, H);
    HeapInsert(9, H);
    printf("DeleteMin = %d\n", HeapDeleteMin(H));

    return 0;
}
```

### 附录 D：最后一轮复习建议

#### 1. 必须能手写的代码

1. 最大子列和在线算法。
2. 二分查找。
3. 单链表插入和删除。
4. 数组栈 Push/Pop。
5. 循环队列 Enqueue/Dequeue。
6. 二叉树递归遍历。
7. BST Find/Insert/Delete。
8. 堆 Insert/DeleteMin。
9. 并查集 Find/Union。
10. 线段树 Build/Query/Update。
11. 拓扑排序。

#### 2. 必须能解释的概念

1. ADT 为什么要分离接口和实现。
2. 大 O、Ω、Θ 的区别。
3. 为什么 `O(N log N)` 通常优于 `O(N^2)`。
4. 递归为何可能导致栈溢出。
5. 链表和数组的取舍。
6. 栈为什么能做括号匹配和表达式转换。
7. 队列为什么适合层序遍历和拓扑排序。
8. BST 为什么可能退化。
9. 堆为什么适合优先队列。
10. 并查集为什么要按大小合并和路径压缩。
11. 线段树为什么能把区间查询从 `O(N)` 降到 `O(log N)`。
12. 图的邻接矩阵和邻接表如何选择。
13. DAG 和拓扑排序的关系。

#### 3. 遇到题目时的判断方法

看到“频繁区间查询”：优先考虑线段树或前缀和。若有修改，线段树更合适。

看到“动态判断两个元素是否属于同一类”：考虑并查集。

看到“每次取最小/最大”：考虑堆或优先队列。

看到“先修关系/任务依赖”：考虑拓扑排序。

看到“括号、表达式、递归模拟”：考虑栈。

看到“层序遍历、广度优先、排队”：考虑队列。

看到“有序数据查找”：考虑二分查找或搜索树。

看到“需要按 key 插入、删除、查找”：考虑 BST 或平衡树。

### 第 12 章：最短路径算法（Shortest Path Algorithms）

本文件按你上传的第二批课件整理，覆盖：最短路径、网络流、最小生成树、DFS 应用、插入排序、Shellsort、Heapsort、Mergesort、Quicksort、表排序、桶排序、基数排序、散列。所有章节标题统一使用三级标题 `###`。

#### 1. 记号与阅读方法

常用记号：

| 记号 | 含义 |
|:-:|:-:|
| `G = (V, E)` | 图，`V` 是顶点集合，`E` 是边集合 |
| `|V|` | 顶点数，常写作 `V` 或 `n` |
| `|E|` | 边数，常写作 `E` 或 `m` |
| `s` | 源点 source |
| `t` | 汇点 sink |
| `Dist[v]` | 从源点到顶点 `v` 的当前最短距离估计 |
| `Path[v] / prev[v]` | 最短路径中 `v` 的前驱顶点 |
| `Known[v] / visited[v]` | 顶点是否已经确定或访问 |
| `Infinity` | 正无穷，表示当前不可达 |
| `Num[v]` | DFS 访问序号 |
| `Low[v]` | DFS 树中通过树边和一条返祖边能到达的最小 DFS 序号 |
| `λ` | 散列表装填因子，常写作 loading density |

本笔记里的代码以 C 语言为主，尽量写成可直接改成作业代码的形式。课件中很多代码是伪代码，本笔记补全了类型、辅助函数和边界判断。

#### 2. 最短路径问题总览

最短路径问题的输入通常是一个带权图 `G = (V, E)`，每条边 `e` 有权值 `c(e)`。路径长度等于路径上所有边权之和。

单源最短路径问题：给定源点 `s`，求 `s` 到所有其他顶点的最短路径。

全源最短路径问题：对每一对顶点 `(i, j)`，求 `i` 到 `j` 的最短路径。

必须特别注意负权边和负权环：

1. 如果存在从源点可达的负权环，那么某些最短路径没有定义，因为绕负权环越多次路径越短，可以趋向负无穷。
2. 如果没有负权环，则通常规定 `s` 到 `s` 的最短距离为 `0`。
3. Dijkstra 算法不能处理负权边。
4. 对有向无环图 DAG，可以按拓扑序做最短路径，即使有负边也可以处理。

#### 3. 图的邻接表代码模板

很多图算法都建议使用邻接表。邻接矩阵适合稠密图，邻接表适合稀疏图。最短路径、DFS、MST 等算法用邻接表能避免扫描不存在的边。

```c
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <limits.h>
#include <stdbool.h>

#define MAXV 1005
#define MAXE 200005
#define INF  0x3f3f3f3f

typedef struct Edge {
    int to;
    int weight;
    int next;
} Edge;

Edge edges[MAXE];
int head[MAXV];
int edgeCnt;
int n, m;

void InitGraph(int vertexCount) {
    n = vertexCount;
    edgeCnt = 0;
    for (int i = 0; i <= n; ++i) {
        head[i] = -1;
    }
}

void AddDirectedEdge(int u, int v, int w) {
    edges[edgeCnt].to = v;
    edges[edgeCnt].weight = w;
    edges[edgeCnt].next = head[u];
    head[u] = edgeCnt++;
}

void AddUndirectedEdge(int u, int v, int w) {
    AddDirectedEdge(u, v, w);
    AddDirectedEdge(v, u, w);
}
```

#### 4. 路径恢复代码模板

很多算法只算距离是不够的，还要输出具体路径。做法是维护 `prev[v]`，表示最短路径中 `v` 的前驱。最后从终点往前追溯到源点，再反向输出。

```c
void PrintPathRecursive(int s, int v, int prev[]) {
    if (v == s) {
        printf("%d", s);
        return;
    }
    if (prev[v] == -1) {
        printf("No path");
        return;
    }
    PrintPathRecursive(s, prev[v], prev);
    printf(" -> %d", v);
}

void PrintPathIterative(int s, int v, int prev[]) {
    int stack[MAXV], top = 0;
    int cur = v;
    while (cur != -1) {
        stack[top++] = cur;
        if (cur == s) break;
        cur = prev[cur];
    }
    if (top == 0 || stack[top - 1] != s) {
        printf("No path\n");
        return;
    }
    for (int i = top - 1; i >= 0; --i) {
        printf("%d", stack[i]);
        if (i) printf(" -> ");
    }
    printf("\n");
}
```

#### 5. 无权图最短路径：BFS

无权图最短路径可以看成所有边权都是 `1`。从源点 `s` 开始，一层一层向外扩展：

1. 第 `0` 层是源点 `s`。
2. 第 `1` 层是从 `s` 一条边能到达的点。
3. 第 `2` 层是从 `s` 两条边能到达、且之前没访问过的点。
4. 如此类推。

这正是广度优先搜索 BFS。

课件先给出一种按 `CurrDist = 0, 1, 2, ...` 扫全图的写法，最坏复杂度是 `O(|V|^2)`；改进方法是用队列，每个点入队一次，每条边最多扫描一次，复杂度为 `O(|V| + |E|)`。

#### 6. BFS 最短路径代码

```c
#define QUEUE_MAX MAXV

typedef struct Queue {
    int data[QUEUE_MAX];
    int front, rear;
} Queue;

void InitQueue(Queue *q) {
    q->front = q->rear = 0;
}

bool IsEmptyQueue(Queue *q) {
    return q->front == q->rear;
}

void Enqueue(Queue *q, int x) {
    q->data[q->rear++] = x;
}

int Dequeue(Queue *q) {
    return q->data[q->front++];
}

void UnweightedShortestPath(int s, int dist[], int prev[]) {
    Queue q;
    InitQueue(&q);

    for (int i = 1; i <= n; ++i) {
        dist[i] = INF;
        prev[i] = -1;
    }

    dist[s] = 0;
    Enqueue(&q, s);

    while (!IsEmptyQueue(&q)) {
        int v = Dequeue(&q);
        for (int e = head[v]; e != -1; e = edges[e].next) {
            int w = edges[e].to;
            if (dist[w] == INF) {
                dist[w] = dist[v] + 1;
                prev[w] = v;
                Enqueue(&q, w);
            }
        }
    }
}
```

#### 7. BFS 的关键理解

BFS 第一次访问到某个顶点时，得到的一定是最短边数路径。原因是队列保证了距离小的顶点先出队，距离大的顶点后出队。

BFS 适用场景：

1. 无权图最短路径。
2. 所有边权相同的图。
3. 层次遍历。
4. 网络流中寻找最短增广路。
5. 判断二分图。
6. 迷宫最短步数问题。

#### 8. Dijkstra 算法

Dijkstra 用于处理非负边权的单源最短路径。它是贪心算法。

维护集合 `S`，表示最短路径已经确定的顶点集合。对任意 `u ∉ S`，`dist[u]` 表示从 `s` 出发，中间只经过 `S` 中顶点，到达 `u` 的最短长度估计。

每一步：

1. 从未知顶点中选择 `dist` 最小的顶点 `v`。
2. 把 `v` 加入 `S`，此时 `dist[v]` 已经是最终答案。
3. 用 `v` 的出边松弛邻居 `w`：如果 `dist[v] + weight(v,w) < dist[w]`，就更新 `dist[w]` 和 `prev[w]`。

#### 9. 为什么 Dijkstra 不能有负权边

Dijkstra 的正确性依赖这个事实：当未知顶点中 `dist[v]` 最小时，任何绕到其他未知顶点再回来形成的路径都不会更短。这个结论依赖边权非负。

如果有负边，可能先确定了一个顶点，之后通过某条负边又找到更短路径，破坏了“确定后不再改变”的性质。

错误想法：给所有边加同一个常数，让负边变正。

这个做法不正确，因为不同路径边数不同。假设路径 `P1` 有 2 条边，路径 `P2` 有 10 条边。每条边都加 `Δ` 后，`P2` 会额外多加 `10Δ`，相对顺序可能改变。

#### 10. Dijkstra 朴素版本：适合稠密图

朴素版本每次扫描所有顶点找最小未知 `dist`，找点 `O(|V|)`，一共找 `|V|` 次，总体 `O(|V|^2 + |E|)`。稠密图中 `|E|` 接近 `|V|^2`，这种写法简单且常用。

```c
void DijkstraSimple(int s, int dist[], int prev[]) {
    bool known[MAXV];

    for (int i = 1; i <= n; ++i) {
        dist[i] = INF;
        prev[i] = -1;
        known[i] = false;
    }
    dist[s] = 0;

    for (;;) {
        int v = -1;
        int best = INF;
        for (int i = 1; i <= n; ++i) {
            if (!known[i] && dist[i] < best) {
                best = dist[i];
                v = i;
            }
        }

        if (v == -1) break;
        known[v] = true;

        for (int e = head[v]; e != -1; e = edges[e].next) {
            int w = edges[e].to;
            int c = edges[e].weight;
            if (!known[w] && dist[v] != INF && dist[v] + c < dist[w]) {
                dist[w] = dist[v] + c;
                prev[w] = v;
            }
        }
    }
}
```

#### 11. Dijkstra 堆优化版本：适合稀疏图

使用优先队列维护当前最小距离，可以把找最小点降到 `O(log |V|)`。理论上如果支持 `DecreaseKey`，复杂度为 `O(|E| log |V|)`。实际写 C 代码时常用“重复插入”的技巧：每次发现更短距离，就把新 `(dist, vertex)` 插入堆；出堆时如果距离不是当前最新值，就跳过。

```c
typedef struct HeapNode {
    int v;
    int dist;
} HeapNode;

HeapNode heap[MAXE];
int heapSize;

void HeapSwap(HeapNode *a, HeapNode *b) {
    HeapNode t = *a;
    *a = *b;
    *b = t;
}

void HeapPush(int v, int dist) {
    int i = ++heapSize;
    heap[i].v = v;
    heap[i].dist = dist;
    while (i > 1 && heap[i].dist < heap[i / 2].dist) {
        HeapSwap(&heap[i], &heap[i / 2]);
        i /= 2;
    }
}

HeapNode HeapPop(void) {
    HeapNode minNode = heap[1];
    heap[1] = heap[heapSize--];

    int i = 1;
    while (true) {
        int child = i * 2;
        if (child > heapSize) break;
        if (child + 1 <= heapSize && heap[child + 1].dist < heap[child].dist) {
            child++;
        }
        if (heap[child].dist < heap[i].dist) {
            HeapSwap(&heap[child], &heap[i]);
            i = child;
        } else {
            break;
        }
    }
    return minNode;
}

bool HeapEmpty(void) {
    return heapSize == 0;
}

void DijkstraHeap(int s, int dist[], int prev[]) {
    bool known[MAXV];

    for (int i = 1; i <= n; ++i) {
        dist[i] = INF;
        prev[i] = -1;
        known[i] = false;
    }

    heapSize = 0;
    dist[s] = 0;
    HeapPush(s, 0);

    while (!HeapEmpty()) {
        HeapNode cur = HeapPop();
        int v = cur.v;

        if (known[v]) continue;
        if (cur.dist != dist[v]) continue;

        known[v] = true;

        for (int e = head[v]; e != -1; e = edges[e].next) {
            int w = edges[e].to;
            int c = edges[e].weight;
            if (!known[w] && dist[v] != INF && dist[v] + c < dist[w]) {
                dist[w] = dist[v] + c;
                prev[w] = v;
                HeapPush(w, dist[w]);
            }
        }
    }
}
```

#### 12. Dijkstra 复杂度比较

| 实现方式 | 找最小未知顶点 | 松弛边 | 总复杂度 | 适合场景 |
|---|---:|---:|---:|---|
| 扫描数组 | `O(|V|)` 每次 | `O(|E|)` | `O(|V|^2 + |E|)` | 稠密图 |
| 二叉堆 + DecreaseKey | `O(log |V|)` | `O(|E| log |V|)` | `O(|E| log |V|)` | 稀疏图 |
| 二叉堆 + 重复插入 | 可能多次出堆 | `O(|E| log |E|)`，通常写作 `O(|E| log |V|)` | 稀疏图，代码简单 |

#### 13. 含负权边的最短路径

当图中有负权边但没有负权环时，可以用基于队列的反复松弛算法。课件中给出的 `WeightedNegative` 思路与常见 SPFA 写法接近：

1. 初始源点入队。
2. 出队一个顶点 `v`。
3. 用 `v` 的所有出边松弛邻居 `w`。
4. 如果 `w` 的距离被更新，并且 `w` 不在队列中，则入队。
5. 如果有负权环，可能无限更新，因此要检测入队次数或松弛次数。

最坏复杂度可达 `O(|V| |E|)`。

#### 14. 队列松弛算法代码（带负环检测）

```c
void WeightedNegativeSPFA(int s, int dist[], int prev[]) {
    Queue q;
    bool inQueue[MAXV];
    int pushCount[MAXV];

    InitQueue(&q);
    for (int i = 1; i <= n; ++i) {
        dist[i] = INF;
        prev[i] = -1;
        inQueue[i] = false;
        pushCount[i] = 0;
    }

    dist[s] = 0;
    Enqueue(&q, s);
    inQueue[s] = true;
    pushCount[s]++;

    while (!IsEmptyQueue(&q)) {
        int v = Dequeue(&q);
        inQueue[v] = false;

        for (int e = head[v]; e != -1; e = edges[e].next) {
            int w = edges[e].to;
            int c = edges[e].weight;

            if (dist[v] != INF && dist[v] + c < dist[w]) {
                dist[w] = dist[v] + c;
                prev[w] = v;

                if (!inQueue[w]) {
                    Enqueue(&q, w);
                    inQueue[w] = true;
                    pushCount[w]++;
                    if (pushCount[w] > n) {
                        printf("Negative-cost cycle detected.\n");
                        return;
                    }
                }
            }
        }
    }
}
```

#### 15. Bellman-Ford 思想补充

Bellman-Ford 的经典形式是对所有边做 `|V| - 1` 轮松弛。因为一条不含环的最短路径最多包含 `|V| - 1` 条边。第 `k` 轮之后，所有最多经过 `k` 条边的最短路径都会被正确考虑。

再额外做一轮，如果还能松弛，说明存在负权环。

```c
typedef struct SimpleEdge {
    int u, v, w;
} SimpleEdge;

SimpleEdge edgeList[MAXE];
int simpleEdgeCnt;

bool BellmanFord(int s, int dist[], int prev[]) {
    for (int i = 1; i <= n; ++i) {
        dist[i] = INF;
        prev[i] = -1;
    }
    dist[s] = 0;

    for (int round = 1; round <= n - 1; ++round) {
        bool changed = false;
        for (int i = 0; i < simpleEdgeCnt; ++i) {
            int u = edgeList[i].u;
            int v = edgeList[i].v;
            int w = edgeList[i].w;
            if (dist[u] != INF && dist[u] + w < dist[v]) {
                dist[v] = dist[u] + w;
                prev[v] = u;
                changed = true;
            }
        }
        if (!changed) break;
    }

    for (int i = 0; i < simpleEdgeCnt; ++i) {
        int u = edgeList[i].u;
        int v = edgeList[i].v;
        int w = edgeList[i].w;
        if (dist[u] != INF && dist[u] + w < dist[v]) {
            return false;
        }
    }
    return true;
}
```

#### 16. DAG 最短路径与拓扑序

如果图是有向无环图 DAG，那么可以先做拓扑排序，然后按拓扑序依次松弛出边。

关键原因：拓扑序保证所有指向当前顶点的边都来自更早处理的顶点。当一个顶点被处理时，不会再有未知顶点通过回边或环影响它的距离。

优点：

1. 复杂度 `O(|V| + |E|)`。
2. 不需要优先队列。
3. 可以处理负权边。
4. 不能处理有环图。

#### 17. DAG 最短路径代码

```c
int indegree[MAXV];
int topo[MAXV];

bool TopologicalSort(int topo[], int *topoCount) {
    Queue q;
    InitQueue(&q);
    *topoCount = 0;

    for (int i = 1; i <= n; ++i) {
        if (indegree[i] == 0) Enqueue(&q, i);
    }

    while (!IsEmptyQueue(&q)) {
        int v = Dequeue(&q);
        topo[(*topoCount)++] = v;

        for (int e = head[v]; e != -1; e = edges[e].next) {
            int w = edges[e].to;
            indegree[w]--;
            if (indegree[w] == 0) Enqueue(&q, w);
        }
    }

    return *topoCount == n;
}

void DAGShortestPath(int s, int dist[], int prev[]) {
    int topoCount = 0;
    if (!TopologicalSort(topo, &topoCount)) {
        printf("The graph is not a DAG.\n");
        return;
    }

    for (int i = 1; i <= n; ++i) {
        dist[i] = INF;
        prev[i] = -1;
    }
    dist[s] = 0;

    for (int i = 0; i < topoCount; ++i) {
        int v = topo[i];
        if (dist[v] == INF) continue;
        for (int e = head[v]; e != -1; e = edges[e].next) {
            int w = edges[e].to;
            int c = edges[e].weight;
            if (dist[v] + c < dist[w]) {
                dist[w] = dist[v] + c;
                prev[w] = v;
            }
        }
    }
}
```

#### 18. AOE 网络与关键路径 CPM

AOE 网络是 Activity On Edge Network，即活动在边上，顶点表示事件。它常用于项目调度。

每条边 `<v, w>` 表示一个活动，边权表示该活动需要的时间。若活动 `<v, w>` 要开始，必须先完成事件 `v`。完成活动后到达事件 `w`。

常用量：

| 符号 | 含义 |
|---|---|
| `EC[j]` | 事件 `vj` 最早完成时间，即 earliest completion time |
| `LC[j]` | 事件 `vj` 最晚完成时间，即 latest completion time |
| `slack` | 松弛时间，表示某活动可以推迟多久而不影响总工期 |

计算方法：

1. 按拓扑序从前往后计算 `EC`。
2. 从终点开始按逆拓扑序计算 `LC`。
3. 对边 `<v, w>`，活动最早开始时间是 `EC[v]`，最晚开始时间是 `LC[w] - duration(v,w)`。
4. 若二者相等，即 `slack = 0`，该活动在关键路径上。
5. 关键路径由所有零松弛活动组成，项目总工期等于终点事件的 `EC`。

#### 19. AOE 关键路径代码

```c
void CriticalPathAOE(int start, int finish) {
    int topoCount = 0;
    if (!TopologicalSort(topo, &topoCount)) {
        printf("AOE network must be a DAG.\n");
        return;
    }

    int EC[MAXV], LC[MAXV];
    for (int i = 1; i <= n; ++i) EC[i] = -INF;
    EC[start] = 0;

    for (int i = 0; i < topoCount; ++i) {
        int v = topo[i];
        if (EC[v] == -INF) continue;
        for (int e = head[v]; e != -1; e = edges[e].next) {
            int w = edges[e].to;
            int duration = edges[e].weight;
            if (EC[v] + duration > EC[w]) {
                EC[w] = EC[v] + duration;
            }
        }
    }

    for (int i = 1; i <= n; ++i) LC[i] = EC[finish];

    for (int i = topoCount - 1; i >= 0; --i) {
        int v = topo[i];
        for (int e = head[v]; e != -1; e = edges[e].next) {
            int w = edges[e].to;
            int duration = edges[e].weight;
            if (LC[w] - duration < LC[v]) {
                LC[v] = LC[w] - duration;
            }
        }
    }

    printf("Project duration = %d\n", EC[finish]);
    printf("Critical activities:\n");

    for (int v = 1; v <= n; ++v) {
        for (int e = head[v]; e != -1; e = edges[e].next) {
            int w = edges[e].to;
            int duration = edges[e].weight;
            int earliestStart = EC[v];
            int latestStart = LC[w] - duration;
            int slack = latestStart - earliestStart;
            if (slack == 0) {
                printf("%d -> %d, duration = %d\n", v, w, duration);
            }
        }
    }
}
```

#### 20. 全源最短路径

全源最短路径要对所有 `(vi, vj)` 求最短路径。

两类方法：

1. 对每个顶点运行一次单源最短路径。
   - 如果用朴素 Dijkstra，每次 `O(|V|^2)`，总复杂度 `O(|V|^3)`。
   - 对稀疏图，堆优化 Dijkstra 可能更好。
2. 使用 Floyd-Warshall。
   - 复杂度 `O(|V|^3)`。
   - 适合稠密图和邻接矩阵。
   - 可以处理负权边，但不能有负权环。

#### 21. Floyd-Warshall 代码

```c
int distMat[MAXV][MAXV];
int nextMat[MAXV][MAXV];

void FloydWarshall(void) {
    for (int k = 1; k <= n; ++k) {
        for (int i = 1; i <= n; ++i) {
            if (distMat[i][k] == INF) continue;
            for (int j = 1; j <= n; ++j) {
                if (distMat[k][j] == INF) continue;
                if (distMat[i][k] + distMat[k][j] < distMat[i][j]) {
                    distMat[i][j] = distMat[i][k] + distMat[k][j];
                    nextMat[i][j] = nextMat[i][k];
                }
            }
        }
    }
}

void PrintFloydPath(int u, int v) {
    if (nextMat[u][v] == -1) {
        printf("No path\n");
        return;
    }
    printf("%d", u);
    while (u != v) {
        u = nextMat[u][v];
        printf(" -> %d", u);
    }
    printf("\n");
}
```

### 第 13 章：网络流（Network Flow）

网络流模型中有：

1. 源点 `s`，流量从这里产生。
2. 汇点 `t`，流量流向这里。
3. 每条有向边有容量 `capacity(u, v)`。
4. 每条边上的实际流量 `flow(u, v)` 不能超过容量。
5. 对中间顶点 `v`，流入量等于流出量，即流量守恒。

目标：求从 `s` 到 `t` 的最大流量。

#### 1. 增广路思想

最基本思路：

1. 在残量网络 `Gr` 中找一条从 `s` 到 `t` 的路径，叫增广路。
2. 这条路径上容量最小的边决定本次能增加多少流量。
3. 把这部分流量加入当前流网络 `Gf`。
4. 更新残量网络。
5. 若残量网络中没有 `s -> t` 路径，则当前流就是最大流。

为什么要有反向边？

因为早期选择的路径可能不是最优路径的一部分。反向边允许算法“撤销”之前的决策。例如某条边已经流了 `f`，就在残量网络中加入反向容量 `f`，表示可以把这部分流量退回去重新分配。

#### 2. Ford-Fulkerson 与 Edmonds-Karp

Ford-Fulkerson 是“不断找增广路”的总框架。若容量是整数，每次至少增加 `1`，会终止。

如果每次用 BFS 找边数最少的增广路，就得到 Edmonds-Karp 算法。课件中给出的复杂度是 `O(|E|^2 |V|)`，也常写作 `O(|V| |E|^2)`。

#### 3. Edmonds-Karp 最大流代码

为了便于理解，这里用容量矩阵写法。适合顶点数不是特别大的情况。

```c
#define FLOW_MAXV 505

int capacity[FLOW_MAXV][FLOW_MAXV];
int flowAdj[FLOW_MAXV][FLOW_MAXV];
int parentFlow[FLOW_MAXV];
int flowN;

int BFSFindAugmentingPath(int s, int t) {
    Queue q;
    InitQueue(&q);

    for (int i = 1; i <= flowN; ++i) parentFlow[i] = -1;
    parentFlow[s] = -2;
    Enqueue(&q, s);

    int pathCap[FLOW_MAXV];
    for (int i = 1; i <= flowN; ++i) pathCap[i] = 0;
    pathCap[s] = INF;

    while (!IsEmptyQueue(&q)) {
        int u = Dequeue(&q);
        for (int v = 1; v <= flowN; ++v) {
            int residual = capacity[u][v] - flowAdj[u][v];
            if (parentFlow[v] == -1 && residual > 0) {
                parentFlow[v] = u;
                pathCap[v] = pathCap[u] < residual ? pathCap[u] : residual;
                if (v == t) return pathCap[t];
                Enqueue(&q, v);
            }
        }
    }
    return 0;
}

int EdmondsKarp(int s, int t) {
    int maxFlow = 0;
    memset(flowAdj, 0, sizeof(flowAdj));

    while (true) {
        int add = BFSFindAugmentingPath(s, t);
        if (add == 0) break;

        maxFlow += add;
        int v = t;
        while (v != s) {
            int u = parentFlow[v];
            flowAdj[u][v] += add;
            flowAdj[v][u] -= add;
            v = u;
        }
    }
    return maxFlow;
}
```

#### 4. 最大流易错点

1. 残量网络中必须有反向边，否则无法撤销错误决策。
2. 找任意增广路可能效率很差；找最短增广路更稳定。
3. 容量是整数时，Ford-Fulkerson 会终止；容量是有理数也可以通过适当表示终止。
4. 若存在浮点容量，朴素 Ford-Fulkerson 可能有精度和收敛问题。
5. 最大流不等于“每次选最大容量路径”这样简单贪心。
6. 最小费用最大流是在所有最大流中选择费用最小的流，属于更复杂问题。

### 第 14 章：最小生成树（Minimum Spanning Tree, MST）

给定一个无向连通带权图，生成树是包含所有顶点且边数为 `|V| - 1` 的树。最小生成树 Minimum Spanning Tree，简称 MST，是总边权最小的生成树。

MST 的性质：

1. MST 一定有 `|V| - 1` 条边。
2. MST 一定无环。
3. MST 覆盖所有顶点。
4. 图连通时才存在生成树。
5. 向生成树中加入一条非树边，一定形成一个环。
6. MST 可以不唯一，但最小总权值相同。

两个经典贪心算法：

1. Prim：从一个点出发，不断把最近的外部顶点加入树。
2. Kruskal：把所有边按权值排序，从小到大选不成环的边。

#### 1. Prim 算法

Prim 类似 Dijkstra，但含义不同：

| 算法 | `dist[v]` 的含义 |
|---|---|
| Dijkstra | 源点 `s` 到 `v` 的当前最短路径长度 |
| Prim | 当前生成树到 `v` 的最便宜连接边权 |

Prim 步骤：

1. 任取一个起点。
2. 维护集合 `T`，表示已经在生成树中的顶点。
3. 每次选择一个不在 `T` 中、但连接 `T` 的边权最小的顶点加入。
4. 更新其他外部顶点到 `T` 的最小边权。

#### 2. Prim 朴素代码

```c
int PrimSimple(int start) {
    bool inMST[MAXV];
    int lowCost[MAXV];
    int parent[MAXV];

    for (int i = 1; i <= n; ++i) {
        inMST[i] = false;
        lowCost[i] = INF;
        parent[i] = -1;
    }

    lowCost[start] = 0;
    int total = 0;

    for (int cnt = 1; cnt <= n; ++cnt) {
        int v = -1;
        int best = INF;
        for (int i = 1; i <= n; ++i) {
            if (!inMST[i] && lowCost[i] < best) {
                best = lowCost[i];
                v = i;
            }
        }

        if (v == -1) {
            printf("No spanning tree.\n");
            return -1;
        }

        inMST[v] = true;
        total += lowCost[v];

        if (parent[v] != -1) {
            printf("Choose edge %d - %d, cost = %d\n", parent[v], v, lowCost[v]);
        }

        for (int e = head[v]; e != -1; e = edges[e].next) {
            int w = edges[e].to;
            int c = edges[e].weight;
            if (!inMST[w] && c < lowCost[w]) {
                lowCost[w] = c;
                parent[w] = v;
            }
        }
    }
    return total;
}
```

复杂度：朴素 Prim 是 `O(|V|^2 + |E|)`，适合稠密图；用堆优化可以做到 `O(|E| log |V|)`。

#### 3. Kruskal 算法

Kruskal 把边按权值从小到大排序，然后依次尝试加入。若加入某条边会形成环，就丢弃。判断是否成环可以用并查集：如果边 `(u, v)` 的两个端点已经在同一集合，说明加入会形成环；否则合并集合并选入这条边。

步骤：

1. 初始化 MST 为空。
2. 所有边按权值升序排序。
3. 扫描每条边 `(u, v, w)`。
4. 若 `Find(u) != Find(v)`，选这条边并 `Union(u, v)`。
5. 直到选满 `|V| - 1` 条边。

复杂度：排序 `O(|E| log |E|)`，并查集操作近似常数，因此总复杂度 `O(|E| log |E|)`。

#### 4. Kruskal 代码

```c
typedef struct WEdge {
    int u, v, w;
} WEdge;

WEdge mstEdges[MAXE];
int mstEdgeCnt;
int parentUF[MAXV];
int sizeUF[MAXV];

int CmpEdge(const void *a, const void *b) {
    const WEdge *x = (const WEdge *)a;
    const WEdge *y = (const WEdge *)b;
    return x->w - y->w;
}

void InitUF(int n) {
    for (int i = 1; i <= n; ++i) {
        parentUF[i] = i;
        sizeUF[i] = 1;
    }
}

int FindUF(int x) {
    if (parentUF[x] != x) {
        parentUF[x] = FindUF(parentUF[x]);
    }
    return parentUF[x];
}

bool UnionUF(int a, int b) {
    int ra = FindUF(a);
    int rb = FindUF(b);
    if (ra == rb) return false;

    if (sizeUF[ra] < sizeUF[rb]) {
        int t = ra;
        ra = rb;
        rb = t;
    }
    parentUF[rb] = ra;
    sizeUF[ra] += sizeUF[rb];
    return true;
}

int Kruskal(int vertexCount, WEdge edgeList[], int edgeCount) {
    qsort(edgeList, edgeCount, sizeof(WEdge), CmpEdge);
    InitUF(vertexCount);

    int chosen = 0;
    int total = 0;

    for (int i = 0; i < edgeCount && chosen < vertexCount - 1; ++i) {
        int u = edgeList[i].u;
        int v = edgeList[i].v;
        int w = edgeList[i].w;

        if (UnionUF(u, v)) {
            printf("Choose edge %d - %d, cost = %d\n", u, v, w);
            total += w;
            chosen++;
        }
    }

    if (chosen < vertexCount - 1) {
        printf("No spanning tree.\n");
        return -1;
    }
    return total;
}
```

#### 5. Prim 与 Kruskal 对比

| 项目 | Prim | Kruskal |
|---|---|---|
| 核心思想 | 从一个点开始长成一棵树 | 维护森林，逐步合并 |
| 需要排序边吗 | 不一定 | 需要 |
| 依赖并查集吗 | 不需要 | 需要 |
| 适合图 | 稠密图常用 Prim | 稀疏图常用 Kruskal |
| 复杂度 | 朴素 `O(V^2)`，堆优化 `O(E log V)` | `O(E log E)` |

### 第 15 章：深度优先搜索应用（DFS Applications）

DFS 是树的先序遍历在图上的推广。

基本模板：

```c
bool visited[MAXV];

void DFS(int v) {
    visited[v] = true;
    for (int e = head[v]; e != -1; e = edges[e].next) {
        int w = edges[e].to;
        if (!visited[w]) {
            DFS(w);
        }
    }
}
```

若使用邻接表，DFS 复杂度是 `O(|V| + |E|)`。

DFS 可以解决：

1. 连通分量。
2. 双连通性。
3. 割点 articulation point。
4. 双连通分量 biconnected component。
5. 欧拉回路 Euler circuit。
6. 拓扑排序。
7. 强连通分量。
8. 图搜索与回溯问题。

#### 1. 无向图连通分量

一个无向图可能不连通。为了列出所有连通分量，需要从每个尚未访问的点启动一次 DFS。

```c
void ListComponents(void) {
    for (int i = 1; i <= n; ++i) visited[i] = false;

    for (int v = 1; v <= n; ++v) {
        if (!visited[v]) {
            printf("Component: ");
            DFS(v);
            printf("\n");
        }
    }
}
```

如果需要打印顶点，可以把 DFS 改成：

```c
void DFSPrint(int v) {
    visited[v] = true;
    printf("%d ", v);
    for (int e = head[v]; e != -1; e = edges[e].next) {
        int w = edges[e].to;
        if (!visited[w]) DFSPrint(w);
    }
}
```

#### 2. 割点 articulation point

割点定义：无向连通图中，如果删除顶点 `v` 以及与它关联的边后，图的连通分量数增加，则 `v` 是割点。

判断规则：

1. DFS 树的根是割点，当且仅当它至少有两个 DFS 子树。
2. 非根顶点 `u` 是割点，当且仅当存在某个子节点 `child`，使得 `Low[child] >= Num[u]`。

`Low[x]` 的含义：从 `x` 出发，沿着若干树边向下，再最多经过一条返祖边，能够到达的最小 `Num`。

如果 `Low[child] >= Num[u]`，说明 `child` 子树不能通过返祖边绕到 `u` 的祖先；删除 `u` 后，`child` 子树就和上方断开，所以 `u` 是割点。

#### 3. 割点代码

```c
int dfsTime;
int numDFS[MAXV], lowDFS[MAXV];
bool isArticulation[MAXV];

void FindArticulationDFS(int u, int parent) {
    numDFS[u] = lowDFS[u] = ++dfsTime;
    int childCount = 0;

    for (int e = head[u]; e != -1; e = edges[e].next) {
        int v = edges[e].to;

        if (!numDFS[v]) {
            childCount++;
            FindArticulationDFS(v, u);

            if (lowDFS[v] < lowDFS[u]) lowDFS[u] = lowDFS[v];

            if (parent != -1 && lowDFS[v] >= numDFS[u]) {
                isArticulation[u] = true;
            }
        } else if (v != parent) {
            if (numDFS[v] < lowDFS[u]) lowDFS[u] = numDFS[v];
        }
    }

    if (parent == -1 && childCount >= 2) {
        isArticulation[u] = true;
    }
}

void FindArticulationPoints(void) {
    dfsTime = 0;
    for (int i = 1; i <= n; ++i) {
        numDFS[i] = 0;
        lowDFS[i] = 0;
        isArticulation[i] = false;
    }

    for (int i = 1; i <= n; ++i) {
        if (!numDFS[i]) {
            FindArticulationDFS(i, -1);
        }
    }

    printf("Articulation points: ");
    for (int i = 1; i <= n; ++i) {
        if (isArticulation[i]) printf("%d ", i);
    }
    printf("\n");
}
```

#### 4. 双连通图与双连通分量

双连通图 biconnected graph：连通且没有割点的无向图。

双连通分量 biconnected component：极大的双连通子图。

重要性质：

1. 一个割点可以属于多个双连通分量。
2. 一条边只能属于一个双连通分量。
3. 因此，双连通分量会划分边集合，而不是简单划分顶点集合。

求双连通分量通常在 Tarjan DFS 过程中维护一个边栈。当发现 `low[child] >= num[u]` 时，从边栈中不断弹边直到弹出 `(u, child)`，这些边组成一个双连通分量。

#### 5. 双连通分量代码

```c
typedef struct PairEdge {
    int u, v;
} PairEdge;

PairEdge edgeStack[MAXE];
int edgeTop;

void PrintBiconnectedComponentUntil(int u, int v) {
    printf("Biconnected component: ");
    while (edgeTop > 0) {
        PairEdge e = edgeStack[--edgeTop];
        printf("(%d,%d) ", e.u, e.v);
        if (e.u == u && e.v == v) break;
    }
    printf("\n");
}

void BiconnectedDFS(int u, int parent) {
    numDFS[u] = lowDFS[u] = ++dfsTime;

    for (int e = head[u]; e != -1; e = edges[e].next) {
        int v = edges[e].to;

        if (!numDFS[v]) {
            edgeStack[edgeTop++] = (PairEdge){u, v};
            BiconnectedDFS(v, u);

            if (lowDFS[v] < lowDFS[u]) lowDFS[u] = lowDFS[v];

            if (lowDFS[v] >= numDFS[u]) {
                PrintBiconnectedComponentUntil(u, v);
            }
        } else if (v != parent && numDFS[v] < numDFS[u]) {
            edgeStack[edgeTop++] = (PairEdge){u, v};
            if (numDFS[v] < lowDFS[u]) lowDFS[u] = numDFS[v];
        }
    }
}

void FindBiconnectedComponents(void) {
    dfsTime = 0;
    edgeTop = 0;
    for (int i = 1; i <= n; ++i) {
        numDFS[i] = 0;
        lowDFS[i] = 0;
    }

    for (int i = 1; i <= n; ++i) {
        if (!numDFS[i]) {
            BiconnectedDFS(i, -1);
        }
    }
}
```

#### 6. 欧拉回路与欧拉路径

欧拉路径 Euler tour：经过图中每条边恰好一次，但起点和终点可以不同。

欧拉回路 Euler circuit：经过图中每条边恰好一次，并且最后回到起点。

无向图判断条件：

1. 欧拉回路存在的必要条件：图连通，且每个顶点度数都是偶数。对于无向图，这也是充分条件。
2. 欧拉路径存在条件：图连通，且恰好有两个奇度顶点。必须从其中一个奇度顶点出发，到另一个奇度顶点结束。
3. 若奇度顶点数为 `0`，存在欧拉回路。
4. 若奇度顶点数为 `2`，存在欧拉路径但不一定有欧拉回路。
5. 其他情况不存在欧拉路径。

#### 7. Hierholzer 算法代码

Hierholzer 算法可以在线性时间 `O(|V| + |E|)` 构造欧拉回路或欧拉路径。这里给出无向图版本。由于每条无向边存两条有向边，判断一条边是否用过时要用 `edgeId`。

```c
#define EULER_MAXE 200005

typedef struct EulerEdge {
    int to;
    int next;
    int id;
} EulerEdge;

EulerEdge eulerEdges[2 * EULER_MAXE];
int eulerHead[MAXV], eulerCnt;
bool usedEuler[EULER_MAXE];
int degreeEuler[MAXV];
int eulerPath[2 * EULER_MAXE];
int eulerPathCnt;

void InitEulerGraph(int n) {
    eulerCnt = 0;
    for (int i = 1; i <= n; ++i) {
        eulerHead[i] = -1;
        degreeEuler[i] = 0;
    }
    memset(usedEuler, false, sizeof(usedEuler));
}

void AddEulerUndirectedEdge(int u, int v, int id) {
    eulerEdges[eulerCnt] = (EulerEdge){v, eulerHead[u], id};
    eulerHead[u] = eulerCnt++;
    eulerEdges[eulerCnt] = (EulerEdge){u, eulerHead[v], id};
    eulerHead[v] = eulerCnt++;
    degreeEuler[u]++;
    degreeEuler[v]++;
}

void EulerDFS(int u) {
    for (int *pe = &eulerHead[u]; *pe != -1; ) {
        int e = *pe;
        *pe = eulerEdges[e].next;

        int id = eulerEdges[e].id;
        if (usedEuler[id]) continue;
        usedEuler[id] = true;

        int v = eulerEdges[e].to;
        EulerDFS(v);
    }
    eulerPath[eulerPathCnt++] = u;
}

void PrintEulerPath(int start) {
    eulerPathCnt = 0;
    EulerDFS(start);

    for (int i = eulerPathCnt - 1; i >= 0; --i) {
        printf("%d", eulerPath[i]);
        if (i) printf(" -> ");
    }
    printf("\n");
}
```

### 第 16 章：排序总览与插入排序（Sorting & Insertion Sort）

课件讨论的是内部排序，即所有数据都能放在主存中。排序函数常写成：

```c
void X_Sort(ElementType A[], int N);
```

如果只允许用 `<` 和 `>` 比较关键字，这类排序叫 comparison-based sorting，比较排序。

比较排序的理论下界：任何只通过比较来排序 `N` 个互异元素的算法，最坏时间复杂度都至少是 `Ω(N log N)`。

非比较排序，如桶排序、计数排序、基数排序，可以利用关键字的特殊范围或结构，在某些情况下做到线性时间。

#### 1. 排序算法对比表

| 算法 | 最好 | 平均 | 最坏 | 额外空间 | 稳定性 | 备注 |
|---|---:|---:|---:|---:|---|---|
| 插入排序 | `O(N)` | `O(N^2)` | `O(N^2)` | `O(1)` | 稳定 | 近乎有序时很好 |
| Shellsort | 依增量而定 | 依增量而定 | Shell 增量 `Θ(N^2)` | `O(1)` | 不稳定 | 中等规模效果好 |
| Heapsort | `O(N log N)` | `O(N log N)` | `O(N log N)` | `O(1)` | 不稳定 | 最坏情况很好 |
| Mergesort | `O(N log N)` | `O(N log N)` | `O(N log N)` | `O(N)` | 稳定 | 外部排序常用 |
| Quicksort | `O(N log N)` | `O(N log N)` | `O(N^2)` | 递归栈 | 不稳定 | 实践中很快 |
| Bucket Sort | `O(N+M)` | `O(N+M)` | 依桶内排序 | `O(N+M)` | 可稳定 | 关键字范围小 |
| Radix Sort | `O(P(N+B))` | `O(P(N+B))` | `O(P(N+B))` | `O(N+B)` | 可稳定 | 多关键字/多位数 |

#### 2. 插入排序

插入排序的思想类似整理扑克牌。维护前面一段有序区，每次取出下一个元素 `Tmp`，在有序区中从后往前移动比 `Tmp` 大的元素，给 `Tmp` 腾出位置。

性质：

1. 最好情况：数组已经有序，每一轮只比较一次，复杂度 `O(N)`。
2. 最坏情况：数组逆序，每个元素都要移动到最前，复杂度 `O(N^2)`。
3. 对近乎有序的数据很快。
4. 是稳定排序，因为相等元素不会被反向交换。
5. 适合作为快速排序小数组 cutoff 后的辅助排序。

#### 3. 插入排序代码

```c
typedef int ElementType;

void InsertionSort(ElementType A[], int N) {
    int j, p;
    ElementType tmp;

    for (p = 1; p < N; ++p) {
        tmp = A[p];
        for (j = p; j > 0 && A[j - 1] > tmp; --j) {
            A[j] = A[j - 1];
        }
        A[j] = tmp;
    }
}
```

#### 4. 逆序对 inversion

逆序对定义：数组中一对下标 `(i, j)` 满足 `i < j` 但 `A[i] > A[j]`。

例：`34, 8, 64, 51, 32, 21` 有 9 个逆序对。

插入排序的移动次数与逆序对数量有关。相邻交换每次只能消除一个逆序对，所以只通过相邻交换完成排序的算法，平均需要 `Ω(N^2)` 时间。

平均逆序对数：`N` 个互异元素的随机排列中，平均逆序对数是：

`N(N - 1) / 4`

因此，只做相邻交换的简单排序平均复杂度不可能突破 `Ω(N^2)`。

#### 5. 用归并排序统计逆序对代码

```c
long long MergeCount(int A[], int tmp[], int left, int mid, int right) {
    int i = left;
    int j = mid + 1;
    int k = left;
    long long inv = 0;

    while (i <= mid && j <= right) {
        if (A[i] <= A[j]) {
            tmp[k++] = A[i++];
        } else {
            tmp[k++] = A[j++];
            inv += (mid - i + 1);
        }
    }

    while (i <= mid) tmp[k++] = A[i++];
    while (j <= right) tmp[k++] = A[j++];

    for (i = left; i <= right; ++i) A[i] = tmp[i];
    return inv;
}

long long CountInversionsRec(int A[], int tmp[], int left, int right) {
    if (left >= right) return 0;
    int mid = (left + right) / 2;
    long long inv = 0;
    inv += CountInversionsRec(A, tmp, left, mid);
    inv += CountInversionsRec(A, tmp, mid + 1, right);
    inv += MergeCount(A, tmp, left, mid, right);
    return inv;
}

long long CountInversions(int A[], int N) {
    int *tmp = (int *)malloc(sizeof(int) * N);
    long long ans = CountInversionsRec(A, tmp, 0, N - 1);
    free(tmp);
    return ans;
}
```

### 第 17 章：Shellsort、Heapsort 与 Mergesort

Shellsort 是插入排序的推广。它允许相隔较远的元素先进行比较和移动，从而一次交换或移动可以消除多个逆序对。

核心概念：增量序列 `h1 < h2 < ... < ht`，并且 `h1 = 1`。排序时从大增量到小增量：

1. 先做 `ht`-sort。
2. 再做 `h(t-1)`-sort。
3. 最后做 `1`-sort，即普通插入排序。

`h`-sort 的意思是：把下标相差 `h` 的元素分成若干组，每组做插入排序。

重要性质：一个已经 `hk`-sorted 的文件，在后续做 `h(k-1)`-sort 后仍然保持 `hk`-sorted。

#### 1. Shell 增量序列

Shell 原始增量：

`h = floor(N / 2), floor(h / 2), ..., 1`

这种增量序列简单，但最坏复杂度是 `Θ(N^2)`。原因是相邻增量之间可能有公因子，较小增量可能不能充分修复较大增量留下的问题。

#### 2. Shellsort 代码

```c
void Shellsort(ElementType A[], int N) {
    int increment, i, j;
    ElementType tmp;

    for (increment = N / 2; increment > 0; increment /= 2) {
        for (i = increment; i < N; ++i) {
            tmp = A[i];
            for (j = i; j >= increment && tmp < A[j - increment]; j -= increment) {
                A[j] = A[j - increment];
            }
            A[j] = tmp;
        }
    }
}
```

#### 3. Hibbard 与 Sedgewick 增量

Hibbard 增量：

`hk = 2^k - 1`

特点：连续增量没有公因子。使用 Hibbard 增量时，Shellsort 最坏复杂度为 `Θ(N^(3/2))`，平均复杂度有 `O(N^(5/4))` 的结果。

Sedgewick 增量示例：

`1, 5, 19, 41, 109, ...`

其项形如：

1. `9 * 4^i - 9 * 2^i + 1`
2. `4^i - 3 * 2^i + 1`

这种序列实践表现很好，课件给出平均 `O(N^(7/6))`，最坏 `O(N^(4/3))`。

#### 4. 使用 Hibbard 增量的 Shellsort 代码

```c
void ShellsortHibbard(ElementType A[], int N) {
    int gaps[64];
    int count = 0;

    for (int h = 1; h < N; h = 2 * h + 1) {
        gaps[count++] = h;
    }

    for (int g = count - 1; g >= 0; --g) {
        int increment = gaps[g];
        for (int i = increment; i < N; ++i) {
            ElementType tmp = A[i];
            int j;
            for (j = i; j >= increment && tmp < A[j - increment]; j -= increment) {
                A[j] = A[j - increment];
            }
            A[j] = tmp;
        }
    }
}
```

#### 5. Heapsort

Heapsort 使用堆来排序。若要升序排序，通常使用最大堆：

1. 先把数组建成最大堆。
2. 最大元素在堆顶 `A[0]`。
3. 将堆顶与最后一个元素交换，最大元素归位。
4. 堆大小减一，对堆顶执行下滤 `PercDown`。
5. 重复直到堆大小为 `1`。

复杂度：

1. 建堆 `O(N)`。
2. 每次删除最大元素 `O(log N)`，共 `N - 1` 次。
3. 总复杂度 `O(N log N)`。
4. 额外空间 `O(1)`。
5. 不稳定。

#### 6. Heapsort 代码

```c
void Swap(ElementType *a, ElementType *b) {
    ElementType t = *a;
    *a = *b;
    *b = t;
}

void PercDown(ElementType A[], int i, int N) {
    int child;
    ElementType tmp = A[i];

    for (; 2 * i + 1 < N; i = child) {
        child = 2 * i + 1;
        if (child + 1 < N && A[child + 1] > A[child]) {
            child++;
        }

        if (A[child] > tmp) {
            A[i] = A[child];
        } else {
            break;
        }
    }
    A[i] = tmp;
}

void Heapsort(ElementType A[], int N) {
    for (int i = N / 2 - 1; i >= 0; --i) {
        PercDown(A, i, N);
    }

    for (int i = N - 1; i > 0; --i) {
        Swap(&A[0], &A[i]);
        PercDown(A, 0, i);
    }
}
```

#### 7. 堆排序易错点

1. 课件中的堆排序数组从下标 `0` 开始，左孩子是 `2*i+1`，右孩子是 `2*i+2`。
2. 优先队列章节中堆通常从下标 `1` 开始，左孩子是 `2*i`，右孩子是 `2*i+1`。
3. 两种写法不要混用。
4. 升序排序用最大堆，降序排序用最小堆。
5. 建堆不是 `O(N log N)`，自底向上下滤建堆是 `O(N)`。

#### 8. Mergesort

归并排序采用分治：

1. 把数组分成左右两半。
2. 分别递归排序左右两半。
3. 合并两个有序数组。

递推式：

`T(N) = 2T(N/2) + O(N)`

所以：

`T(N) = O(N log N)`

性质：

1. 最好、平均、最坏都是 `O(N log N)`。
2. 稳定。
3. 需要 `O(N)` 额外空间。
4. 复制数组有开销，所以内部排序中不一定最快。
5. 外部排序中非常重要，因为归并可以顺序读写磁盘文件。

#### 9. 合并两个有序区间代码

```c
void Merge(ElementType A[], ElementType tmp[], int leftStart, int rightStart, int rightEnd) {
    int leftEnd = rightStart - 1;
    int tmpPos = leftStart;
    int numElements = rightEnd - leftStart + 1;
    int originalRightEnd = rightEnd;

    while (leftStart <= leftEnd && rightStart <= rightEnd) {
        if (A[leftStart] <= A[rightStart]) {
            tmp[tmpPos++] = A[leftStart++];
        } else {
            tmp[tmpPos++] = A[rightStart++];
        }
    }

    while (leftStart <= leftEnd) {
        tmp[tmpPos++] = A[leftStart++];
    }

    while (rightStart <= rightEnd) {
        tmp[tmpPos++] = A[rightStart++];
    }

    for (int i = 0; i < numElements; ++i, --originalRightEnd) {
        A[originalRightEnd] = tmp[originalRightEnd];
    }
}
```

#### 10. 递归归并排序代码

```c
void MSort(ElementType A[], ElementType tmp[], int left, int right) {
    if (left < right) {
        int center = (left + right) / 2;
        MSort(A, tmp, left, center);
        MSort(A, tmp, center + 1, right);
        Merge(A, tmp, left, center + 1, right);
    }
}

void Mergesort(ElementType A[], int N) {
    ElementType *tmp = (ElementType *)malloc(sizeof(ElementType) * N);
    if (tmp == NULL) {
        fprintf(stderr, "No space for tmp array.\n");
        return;
    }
    MSort(A, tmp, 0, N - 1);
    free(tmp);
}
```

#### 11. 迭代归并排序代码

迭代版本从长度为 `1` 的有序段开始，两两合并成长度为 `2`、`4`、`8` 的有序段。

```c
void MergePass(ElementType A[], ElementType tmp[], int N, int length) {
    int i;
    for (i = 0; i + 2 * length <= N; i += 2 * length) {
        Merge(A, tmp, i, i + length, i + 2 * length - 1);
    }

    if (i + length < N) {
        Merge(A, tmp, i, i + length, N - 1);
    }
}

void IterativeMergesort(ElementType A[], int N) {
    ElementType *tmp = (ElementType *)malloc(sizeof(ElementType) * N);
    if (!tmp) return;

    for (int length = 1; length < N; length *= 2) {
        MergePass(A, tmp, N, length);
    }

    free(tmp);
}
```

### 第 18 章：Quicksort、表排序、桶排序与基数排序

快速排序实践中非常快。核心步骤：

1. 选择一个枢轴 pivot。
2. 把数组划分为小于等于 pivot 的部分和大于等于 pivot 的部分。
3. pivot 放到最终位置。
4. 递归排序左右两边。

递推式：

`T(N) = T(i) + T(N - i - 1) + cN`

如果 pivot 每次都刚好居中：

`T(N) = 2T(N/2) + cN = O(N log N)`

如果 pivot 每次都是最小或最大：

`T(N) = T(N - 1) + cN = O(N^2)`

平均情况：`O(N log N)`。

#### 1. pivot 选择

错误方法：总是选择 `A[0]`。若输入已经有序，快速排序退化为 `O(N^2)`。

随机选择：理论上很好，但随机数生成有开销。

三数中值 median-of-three：取左端、中间、右端三个元素的中值作为 pivot。

优点：

1. 避免有序输入的最坏情况。
2. 通常能减少约 5% 运行时间。
3. 可以顺便把三个位置排好。

#### 2. 小数组 cutoff

快速排序在小数组上不如插入排序，因为递归和划分开销比较大。常用策略：当子数组长度小于某个阈值，如 `10` 或 `20` 时，改用插入排序。

#### 3. 快速排序完整代码

```c
#define Cutoff 10

void InsertionSortRange(ElementType A[], int left, int right) {
    for (int p = left + 1; p <= right; ++p) {
        ElementType tmp = A[p];
        int j;
        for (j = p; j > left && A[j - 1] > tmp; --j) {
            A[j] = A[j - 1];
        }
        A[j] = tmp;
    }
}

ElementType Median3(ElementType A[], int left, int right) {
    int center = (left + right) / 2;

    if (A[left] > A[center]) Swap(&A[left], &A[center]);
    if (A[left] > A[right]) Swap(&A[left], &A[right]);
    if (A[center] > A[right]) Swap(&A[center], &A[right]);

    Swap(&A[center], &A[right - 1]);
    return A[right - 1];
}

void Qsort(ElementType A[], int left, int right) {
    int i, j;
    ElementType pivot;

    if (left + Cutoff <= right) {
        pivot = Median3(A, left, right);
        i = left;
        j = right - 1;

        for (;;) {
            while (A[++i] < pivot) {}
            while (A[--j] > pivot) {}

            if (i < j) {
                Swap(&A[i], &A[j]);
            } else {
                break;
            }
        }

        Swap(&A[i], &A[right - 1]);
        Qsort(A, left, i - 1);
        Qsort(A, i + 1, right);
    } else {
        InsertionSortRange(A, left, right);
    }
}

void Quicksort(ElementType A[], int N) {
    Qsort(A, 0, N - 1);
}
```

#### 4. 相等关键字的处理

课件强调：如果遇到等于 pivot 的关键字，左右指针都停下来并交换。这样会有一些无意义交换，但对于全部元素相等的数组，能把数组划分成接近相等的两半，避免退化成 `O(N^2)`。

如果左右指针遇到等于 pivot 都不停，全部相等时可能导致极端不平衡划分，时间退化。

#### 5. 快速选择 Quickselect：第 k 大或第 k 小

课件提到“给定 N 个元素和整数 k，找第 k 大元素”。可用快速排序的 partition 思想，但每轮只递归一边。

下面代码求第 `k` 小元素，`k` 从 `1` 开始。第 `k` 大可以转成第 `N-k+1` 小。

```c
int PartitionSimple(ElementType A[], int left, int right) {
    ElementType pivot = A[right];
    int i = left;

    for (int j = left; j < right; ++j) {
        if (A[j] <= pivot) {
            Swap(&A[i], &A[j]);
            i++;
        }
    }
    Swap(&A[i], &A[right]);
    return i;
}

ElementType QuickSelectKthSmallest(ElementType A[], int left, int right, int k) {
    while (left <= right) {
        int p = PartitionSimple(A, left, right);
        int rank = p - left + 1;

        if (rank == k) return A[p];
        if (k < rank) {
            right = p - 1;
        } else {
            k -= rank;
            left = p + 1;
        }
    }
    return -1;
}
```

平均复杂度 `O(N)`，最坏复杂度 `O(N^2)`。

#### 6. 大结构排序与表排序

如果待排序元素是大结构体，直接交换整个结构体很慢。解决方法是间接排序：

1. 建立索引表 `table[i] = i`。
2. 排序时只比较 `list[table[i]]`，交换 `table` 中的整数。
3. 排序结果逻辑上是 `list[table[0]], list[table[1]], ...`。
4. 如果必须物理重排结构体，最后再按置换环进行移动。

这样可以避免排序过程中大量移动大对象。

#### 7. 间接排序代码

```c
typedef struct Record {
    int key;
    char name[64];
    char otherData[256];
} Record;

Record records[10000];
int tableIndex[10000];

int CompareIndexByRecordKey(const void *a, const void *b) {
    int ia = *(const int *)a;
    int ib = *(const int *)b;
    return records[ia].key - records[ib].key;
}

void TableSort(int N) {
    for (int i = 0; i < N; ++i) tableIndex[i] = i;
    qsort(tableIndex, N, sizeof(int), CompareIndexByRecordKey);
}

void PrintSortedRecords(int N) {
    for (int i = 0; i < N; ++i) {
        Record *r = &records[tableIndex[i]];
        printf("key=%d, name=%s\n", r->key, r->name);
    }
}
```

#### 8. 按置换环物理重排

任意置换都可以分解为若干不相交的环。若确实要把 `records` 物理移动到排序后顺序，可以沿环移动。

课件提到最坏情况下有 `floor(N/2)` 个环，需要约 `floor(3N/2)` 次记录移动，若每个结构体大小为 `m`，物理移动总代价为 `O(mN)`。

```c
void RearrangeByTable(Record list[], int table[], int N) {
    bool done[10000] = {false};

    for (int i = 0; i < N; ++i) {
        if (done[i] || table[i] == i) {
            done[i] = true;
            continue;
        }

        Record tmp = list[i];
        int current = i;

        while (!done[current]) {
            done[current] = true;
            int next = table[current];
            if (done[next]) {
                list[current] = tmp;
                break;
            }
            list[current] = list[next];
            current = next;
        }
    }
}
```

注意：表排序中的 `table` 表示方式有多种。上面代码需要保证 `table[i]` 表示排序后位置 `i` 应该放原数组哪个位置的记录。实际使用时要先明确置换方向。

#### 9. 比较排序下界

比较排序只能通过比较两个关键字来获得信息。排序 `N` 个互异元素时，可能的输出排列有 `N!` 种。

任何比较排序都可以看成一棵决策树：

1. 每个内部节点是一次比较。
2. 每条边表示比较结果。
3. 每个叶子表示一种最终排列。

为了区分 `N!` 种排列，决策树至少需要 `N!` 个叶子。高度为 `k` 的二叉树最多有 `2^k` 个叶子，所以：

`2^k >= N!`

因此：

`k >= log2(N!) = Ω(N log N)`

结论：任何只靠比较的排序算法，最坏时间复杂度至少是 `Ω(N log N)`。

这说明 `Mergesort`、`Heapsort`、平均情况下的 `Quicksort` 已经达到了比较排序的数量级最优。

#### 10. Bucket Sort 桶排序

桶排序适用于关键字范围有限的情况。例如学生成绩在 `0 ~ 100`，共有 `M = 101` 个可能值。若有 `N` 个学生，按成绩排序可用 101 个桶。

步骤：

1. 初始化桶。
2. 读入每条记录，根据关键字放入对应桶。
3. 从小到大扫描桶，依次输出桶内记录。

复杂度：`O(N + M)`。

如果 `M` 远大于 `N`，桶排序可能浪费空间和时间。

#### 11. 成绩桶排序代码

```c
typedef struct Student {
    char name[32];
    int grade;
    struct Student *next;
} Student;

Student *buckets[101];

void BucketSortStudents(Student students[], int N) {
    for (int i = 0; i <= 100; ++i) buckets[i] = NULL;

    for (int i = 0; i < N; ++i) {
        int g = students[i].grade;
        students[i].next = buckets[g];
        buckets[g] = &students[i];
    }

    for (int g = 0; g <= 100; ++g) {
        for (Student *p = buckets[g]; p != NULL; p = p->next) {
            printf("grade=%d name=%s\n", p->grade, p->name);
        }
    }
}
```

上面写法不稳定，因为同一桶中采用头插法。若要求稳定，可以每个桶维护队尾，或者从后往前插入。

#### 12. 计数排序代码

对于整数关键字，计数排序是桶排序的一种常用形式。下面代码稳定排序范围 `[0, maxKey]` 的整数。

```c
void CountingSort(int A[], int N, int maxKey) {
    int *count = (int *)calloc(maxKey + 1, sizeof(int));
    int *output = (int *)malloc(sizeof(int) * N);

    for (int i = 0; i < N; ++i) count[A[i]]++;

    for (int i = 1; i <= maxKey; ++i) {
        count[i] += count[i - 1];
    }

    for (int i = N - 1; i >= 0; --i) {
        output[--count[A[i]]] = A[i];
    }

    for (int i = 0; i < N; ++i) A[i] = output[i];

    free(count);
    free(output);
}
```

#### 13. Radix Sort 基数排序

基数排序适用于记录由多个关键字组成，或者数字可以拆成多位。

例如整数 `0 ~ 999` 可以拆成个位、十位、百位。若用十进制，桶数 `B = 10`，位数 `P = 3`。

复杂度：

`O(P(N + B))`

其中：

1. `P` 是处理轮数，即位数或关键字个数。
2. `N` 是记录数。
3. `B` 是桶数。

#### 14. LSD 与 MSD

LSD：Least Significant Digit，最低位优先。

1. 先按最低位排序。
2. 再按次低位排序。
3. 最后按最高位排序。
4. 每一轮必须使用稳定排序，否则之前低位的顺序会被破坏。

MSD：Most Significant Digit，最高位优先。

1. 先按最高位分桶。
2. 每个桶内部再按下一位递归排序。
3. 适合字符串排序、字典序排序。
4. 不一定所有数据都要处理完整长度。

LSD 不一定总比 MSD 快，取决于数据分布、关键字长度、是否能提前停止等。

#### 15. LSD 基数排序代码

```c
void RadixSortLSD(int A[], int N) {
    int *output = (int *)malloc(sizeof(int) * N);
    int maxVal = A[0];
    for (int i = 1; i < N; ++i) {
        if (A[i] > maxVal) maxVal = A[i];
    }

    for (int exp = 1; maxVal / exp > 0; exp *= 10) {
        int count[10] = {0};

        for (int i = 0; i < N; ++i) {
            int digit = (A[i] / exp) % 10;
            count[digit]++;
        }

        for (int i = 1; i < 10; ++i) {
            count[i] += count[i - 1];
        }

        for (int i = N - 1; i >= 0; --i) {
            int digit = (A[i] / exp) % 10;
            output[--count[digit]] = A[i];
        }

        for (int i = 0; i < N; ++i) A[i] = output[i];
    }

    free(output);
}
```

#### 16. 多关键字记录的 LSD 思想

如果一张扑克牌有两个关键字：花色和点数。假设主要排序关键字是花色，次要排序关键字是点数。

LSD 的做法：

1. 先按点数稳定排序。
2. 再按花色稳定排序。
3. 最终花色有序，同花色内部点数也有序。

若每个记录有 `r` 个关键字 `Ki0, Ki1, ..., Ki(r-1)`，其中 `Ki0` 是最高优先级，`Ki(r-1)` 是最低优先级，那么 LSD 要从 `Ki(r-1)` 排到 `Ki0`。

### 第 19 章：散列基础（Hashing）

散列用于快速查找。理想情况下，查找、插入、删除都可以达到 `O(1)` 平均时间。

符号表 Symbol Table，也叫 Dictionary：

`{ <name, attribute> }`

例子：

1. 字典中，`name` 是单词，`attribute` 是释义列表。
2. 编译器符号表中，`name` 是标识符，`attribute` 可能是类型、作用域、出现行号等信息。

符号表基本操作：

1. `Create(TableSize)` 创建表。
2. `IsIn(symtab, name)` 判断是否存在。
3. `Find(symtab, name)` 查找属性。
4. `Insert(symtab, name, attr)` 插入。
5. `Delete(symtab, name)` 删除。

#### 1. 散列表基本概念

散列表 `ht[]` 有 `b` 个 bucket，每个 bucket 有 `s` 个 slot。

哈希函数：

`f(x) = position of x in ht[]`

重要概念：

| 概念 | 含义 |
|---|---|
| `T` | 关键字可能取值总数 |
| `n` | 当前表中实际存放的关键字个数 |
| identifier density | `n / T` |
| loading density `λ` | `n / (s b)` |
| collision | 两个不同关键字映射到同一 bucket |
| overflow | 新关键字要放入一个已经满的 bucket |

当 `s = 1` 时，collision 和 overflow 同时发生。

如果没有溢出，理论上查找、插入、删除都是 `O(1)`。

#### 2. 哈希函数要求

一个好的哈希函数应该满足：

1. 容易计算。
2. 尽量减少冲突。
3. 尽量均匀，即对任意关键字 `x` 和任意桶 `i`，都有 `P(f(x)=i) = 1/b`。
4. 对输入模式不敏感。

整数关键字常用：

`f(x) = x % TableSize`

`TableSize` 通常选素数。若 `TableSize = 10`，而所有关键字都以 `0` 结尾，就会大量冲突。

字符串关键字不能简单相加，因为字符和的范围太小、分布太差。

#### 3. 字符串哈希函数代码

课件给出形式：

`HashVal = (HashVal << 5) + *x++`

这相当于不断乘以 32 再加新字符，比乘以 27 更快。

```c
unsigned int HashString(const char *key, int tableSize) {
    unsigned int hashVal = 0;
    while (*key != '\0') {
        hashVal = (hashVal << 5) + (unsigned char)(*key++);
    }
    return hashVal % tableSize;
}
```

注意：若字符串很长，早期字符可能因整数溢出被移出影响范围。实际工程中可以使用更成熟的字符串哈希，或者选择关键位置字符参与计算。

#### 4. Separate Chaining 分离链接法

分离链接法：每个桶对应一个链表，所有哈希到同一个桶的关键字都放进这个链表。

优点：

1. 实现简单。
2. 装填因子可以接近甚至超过 1。
3. 删除容易。
4. 对冲突比较宽容。

建议：`TableSize` 大约取预计关键字个数，使 `λ ≈ 1`。

缺点：

1. 需要指针，空间开销较大。
2. 动态分配 `malloc/free` 有开销。
3. 缓存局部性不如开放定址法。

#### 5. 分离链接法完整代码

```c
typedef struct HashNode {
    char *key;
    char *value;
    struct HashNode *next;
} HashNode;

typedef struct ChainHashTable {
    int tableSize;
    HashNode **lists;
} ChainHashTable;

char *StrDupSafe(const char *s) {
    size_t len = strlen(s);
    char *p = (char *)malloc(len + 1);
    if (p == NULL) return NULL;
    strcpy(p, s);
    return p;
}

bool IsPrime(int x) {
    if (x <= 1) return false;
    if (x == 2) return true;
    if (x % 2 == 0) return false;
    for (int i = 3; i * i <= x; i += 2) {
        if (x % i == 0) return false;
    }
    return true;
}

int NextPrime(int x) {
    while (!IsPrime(x)) ++x;
    return x;
}

ChainHashTable *CreateChainHashTable(int tableSize) {
    ChainHashTable *H = (ChainHashTable *)malloc(sizeof(ChainHashTable));
    if (!H) return NULL;

    H->tableSize = NextPrime(tableSize);
    H->lists = (HashNode **)calloc(H->tableSize, sizeof(HashNode *));
    if (!H->lists) {
        free(H);
        return NULL;
    }
    return H;
}

HashNode *ChainFind(ChainHashTable *H, const char *key) {
    unsigned int index = HashString(key, H->tableSize);
    HashNode *p = H->lists[index];

    while (p != NULL && strcmp(p->key, key) != 0) {
        p = p->next;
    }
    return p;
}

void ChainInsert(ChainHashTable *H, const char *key, const char *value) {
    HashNode *pos = ChainFind(H, key);
    if (pos != NULL) {
        free(pos->value);
        pos->value = StrDupSafe(value);
        return;
    }

    unsigned int index = HashString(key, H->tableSize);
    HashNode *newNode = (HashNode *)malloc(sizeof(HashNode));
    if (!newNode) return;

    newNode->key = StrDupSafe(key);
    newNode->value = StrDupSafe(value);
    newNode->next = H->lists[index];
    H->lists[index] = newNode;
}

bool ChainDelete(ChainHashTable *H, const char *key) {
    unsigned int index = HashString(key, H->tableSize);
    HashNode *p = H->lists[index];
    HashNode *prev = NULL;

    while (p != NULL && strcmp(p->key, key) != 0) {
        prev = p;
        p = p->next;
    }

    if (p == NULL) return false;

    if (prev == NULL) H->lists[index] = p->next;
    else prev->next = p->next;

    free(p->key);
    free(p->value);
    free(p);
    return true;
}

void DestroyChainHashTable(ChainHashTable *H) {
    if (!H) return;
    for (int i = 0; i < H->tableSize; ++i) {
        HashNode *p = H->lists[i];
        while (p) {
            HashNode *next = p->next;
            free(p->key);
            free(p->value);
            free(p);
            p = next;
        }
    }
    free(H->lists);
    free(H);
}
```

#### 6. Open Addressing 开放定址法

开放定址法不使用链表。当冲突发生时，在数组中寻找另一个空位置。

通用探测公式：

`index = (hash(key) + f(i)) % TableSize`

其中 `i` 是探测次数，`f(0) = 0`。

开放定址法特点：

1. 不需要指针。
2. 缓存局部性好。
3. 删除较麻烦，需要懒惰删除 tombstone。
4. 装填因子不能太高，通常要求 `λ < 0.5`。

#### 7. 线性探测 Linear Probing

线性探测使用：

`f(i) = i`

即冲突后依次尝试下一个位置。

优点：简单、局部性好。

缺点：会产生 primary clustering，一段连续占用区会越来越长，查找代价变大。

课件示例中装填因子 `λ = 11/26 = 0.42`，虽然平均装填不高，但最坏搜索时间仍可能很大。

#### 8. 开放定址线性探测代码

```c
typedef enum EntryState {
    EMPTY,
    ACTIVE,
    DELETED
} EntryState;

typedef struct OpenEntry {
    char *key;
    char *value;
    EntryState state;
} OpenEntry;

typedef struct OpenHashTable {
    int tableSize;
    int size;
    OpenEntry *cells;
} OpenHashTable;

OpenHashTable *CreateOpenHashTable(int tableSize) {
    OpenHashTable *H = (OpenHashTable *)malloc(sizeof(OpenHashTable));
    if (!H) return NULL;

    H->tableSize = NextPrime(tableSize);
    H->size = 0;
    H->cells = (OpenEntry *)calloc(H->tableSize, sizeof(OpenEntry));
    if (!H->cells) {
        free(H);
        return NULL;
    }

    for (int i = 0; i < H->tableSize; ++i) {
        H->cells[i].state = EMPTY;
    }
    return H;
}

int OpenFindPosition(OpenHashTable *H, const char *key) {
    int current = HashString(key, H->tableSize);
    int firstDeleted = -1;

    for (int i = 0; i < H->tableSize; ++i) {
        int pos = (current + i) % H->tableSize;

        if (H->cells[pos].state == ACTIVE) {
            if (strcmp(H->cells[pos].key, key) == 0) {
                return pos;
            }
        } else if (H->cells[pos].state == DELETED) {
            if (firstDeleted == -1) firstDeleted = pos;
        } else {
            return firstDeleted != -1 ? firstDeleted : pos;
        }
    }
    return firstDeleted;
}

char *OpenFind(OpenHashTable *H, const char *key) {
    int start = HashString(key, H->tableSize);

    for (int i = 0; i < H->tableSize; ++i) {
        int pos = (start + i) % H->tableSize;

        if (H->cells[pos].state == EMPTY) {
            return NULL;
        }
        if (H->cells[pos].state == ACTIVE && strcmp(H->cells[pos].key, key) == 0) {
            return H->cells[pos].value;
        }
    }
    return NULL;
}

bool OpenInsert(OpenHashTable *H, const char *key, const char *value) {
    if (H->size * 2 >= H->tableSize) {
        printf("Load factor too high; rehash is needed.\n");
        return false;
    }

    int pos = OpenFindPosition(H, key);
    if (pos == -1) return false;

    if (H->cells[pos].state == ACTIVE) {
        free(H->cells[pos].value);
        H->cells[pos].value = StrDupSafe(value);
        return true;
    }

    H->cells[pos].key = StrDupSafe(key);
    H->cells[pos].value = StrDupSafe(value);
    H->cells[pos].state = ACTIVE;
    H->size++;
    return true;
}

bool OpenDelete(OpenHashTable *H, const char *key) {
    int start = HashString(key, H->tableSize);

    for (int i = 0; i < H->tableSize; ++i) {
        int pos = (start + i) % H->tableSize;

        if (H->cells[pos].state == EMPTY) return false;
        if (H->cells[pos].state == ACTIVE && strcmp(H->cells[pos].key, key) == 0) {
            free(H->cells[pos].key);
            free(H->cells[pos].value);
            H->cells[pos].key = NULL;
            H->cells[pos].value = NULL;
            H->cells[pos].state = DELETED;
            H->size--;
            return true;
        }
    }
    return false;
}
```

#### 9. 散列易错点总结

1. `TableSize` 最好取素数，尤其是使用取模法时。
2. 字符串哈希不能只把字符简单相加，否则冲突很多。
3. 分离链接法中，查找字符串要用 `strcmp`，不能直接用 `!=` 比较指针。
4. 插入字符串时要复制内容，不能只保存局部数组指针。
5. 开放定址法删除不能直接置为 `EMPTY`，否则会截断探测链，导致后面的元素找不到。应置为 `DELETED`。
6. 开放定址法装填因子太高时性能会急剧下降，通常要 rehash。
7. 线性探测容易形成聚集。
8. 分离链接更容易实现删除，开放定址更省指针且缓存友好。

### 附录 E：本批课件代码清单

| 主题 | 核心代码 |
|---|---|
| 无权最短路径 | `UnweightedShortestPath` |
| Dijkstra 朴素版 | `DijkstraSimple` |
| Dijkstra 堆优化 | `DijkstraHeap` |
| 含负权边 | `WeightedNegativeSPFA`, `BellmanFord` |
| DAG 最短路径 | `DAGShortestPath` |
| AOE 关键路径 | `CriticalPathAOE` |
| 全源最短路径 | `FloydWarshall` |
| 最大流 | `EdmondsKarp` |
| MST Prim | `PrimSimple` |
| MST Kruskal | `Kruskal` |
| 连通分量 | `ListComponents`, `DFSPrint` |
| 割点 | `FindArticulationPoints` |
| 双连通分量 | `FindBiconnectedComponents` |
| 欧拉路径 | `PrintEulerPath` |
| 插入排序 | `InsertionSort` |
| 逆序对统计 | `CountInversions` |
| Shellsort | `Shellsort`, `ShellsortHibbard` |
| 堆排序 | `Heapsort` |
| 归并排序 | `Mergesort`, `IterativeMergesort` |
| 快速排序 | `Quicksort` |
| 快速选择 | `QuickSelectKthSmallest` |
| 表排序 | `TableSort`, `RearrangeByTable` |
| 桶/计数排序 | `BucketSortStudents`, `CountingSort` |
| 基数排序 | `RadixSortLSD` |
| 散列函数 | `HashString` |
| 分离链接散列表 | `CreateChainHashTable`, `ChainFind`, `ChainInsert`, `ChainDelete` |
| 开放定址散列表 | `CreateOpenHashTable`, `OpenFind`, `OpenInsert`, `OpenDelete` |

### 附录 F：高频考试与作业考点

1. BFS 为什么能求无权最短路径：因为队列按层扩展，第一次到达即最短。
2. Dijkstra 为什么不能有负边：已确定顶点可能被后续负边改小。
3. 稠密图 Dijkstra 用扫描数组，稀疏图用优先队列。
4. DAG 最短路径按拓扑序松弛，复杂度 `O(V+E)`，可以有负边但不能有环。
5. AOE 网络中 `EC` 正向算，`LC` 反向算，零松弛边构成关键路径。
6. 最大流必须维护残量网络，反向边代表撤销流量。
7. Kruskal 必须用并查集判断是否成环。
8. Prim 的 `dist` 是连接生成树的最小边权，不是源点到顶点的路径长度。
9. DFS 割点根节点和非根节点判断条件不同。
10. `Low[child] >= Num[u]` 是非根割点判断核心。
11. 欧拉回路要求无向图连通且所有顶点度数为偶数。
12. 插入排序移动次数与逆序对数量有关，近乎有序时很快。
13. 相邻交换每次只消除一个逆序对，因此平均下界 `Ω(N^2)`。
14. Shellsort 通过远距离移动一次消除多个逆序对。
15. Heapsort 建堆是 `O(N)`，不是 `O(N log N)`。
16. Mergesort 稳定但需要 `O(N)` 额外空间。
17. Quicksort 三数中值可以避免有序输入的坏情况。
18. Quicksort 小数组 cutoff 后用插入排序更快。
19. 比较排序最坏下界是 `Ω(N log N)`。
20. Bucket/Radix 不是纯比较排序，因此可以突破比较排序下界。
21. LSD 基数排序每轮必须稳定。
22. 哈希函数要均匀，表长常取素数。
23. Separate chaining 装填因子可接近 1，open addressing 一般要求小于 0.5。
24. 开放定址删除要用 tombstone，不能直接清空。

### 附录 G：一页速记版

图算法：

| 问题 | 算法 | 复杂度 | 条件 |
|---|---|---:|---|
| 无权单源最短路 | BFS | `O(V+E)` | 无权或等权 |
| 非负权单源最短路 | Dijkstra | `O(V^2)` 或 `O(E log V)` | 不能有负边 |
| 含负权单源最短路 | Bellman-Ford/SPFA 思想 | `O(VE)` 最坏 | 不能有负权环 |
| DAG 单源最短路 | 拓扑序松弛 | `O(V+E)` | DAG |
| 全源最短路 | Floyd | `O(V^3)` | 可有负边，无负环 |
| 最大流 | Edmonds-Karp | `O(VE^2)` | 容量网络 |
| MST | Prim/Kruskal | `O(V^2)` / `O(E log E)` | 无向连通图 |

排序：

| 算法 | 关键思想 | 最坏复杂度 |
|---|---|---:|
| 插入排序 | 插入到前方有序区 | `O(N^2)` |
| Shellsort | 多增量插入排序 | 依增量，Shell 为 `Θ(N^2)` |
| Heapsort | 最大堆反复删最大 | `O(N log N)` |
| Mergesort | 分治 + 合并 | `O(N log N)` |
| Quicksort | pivot + partition | `O(N^2)`，平均 `O(N log N)` |
| Bucket Sort | 按范围分桶 | `O(N+M)` |
| Radix Sort | 按位稳定排序 | `O(P(N+B))` |

散列：

| 冲突处理 | 方法 | 关键限制 |
|---|---|---|
| 分离链接 | 每个桶挂链表 | 指针开销，平均链长约 `λ` |
| 开放定址 | 冲突后探测空位 | 装填因子不能高，删除要 tombstone |
| 线性探测 | `f(i)=i` | 容易 primary clustering |

### 附录 H：复习建议

先按“图算法”和“排序/散列”分两条线复习。

图算法建议顺序：BFS 最短路 → Dijkstra → 负权边 → DAG 最短路 → AOE 关键路径 → 最大流 → MST → DFS 割点/欧拉路径。这样能把“松弛”“贪心”“拓扑序”“残量网络”“low 值”几个核心思想串起来。

排序建议顺序：插入排序与逆序对 → Shellsort 为什么能快 → Heapsort 的数组堆 → Mergesort 分治递推 → Quicksort pivot 与 partition → 比较排序下界 → Bucket/Radix 为什么能突破下界 → Hashing 为什么能做到平均 `O(1)`。

真正写题时，先判断问题属于哪类：

1. 边权全 1：优先 BFS。
2. 非负边权：Dijkstra。
3. 有负边：Bellman-Ford/SPFA 或 DAG 拓扑序。
4. 需要项目最短工期/关键活动：AOE/CPM。
5. 求最大通过量：最大流。
6. 无向连通图选最便宜连接所有点：MST。
7. 找割点/双连通：DFS + low。
8. 数据几乎有序：插入排序。
9. 要稳定且最坏 `O(N log N)`：归并排序。
10. 实践中通用快速排序：三数中值 + cutoff。
11. 关键字范围小：桶/计数排序。
12. 多位数字或多关键字：基数排序。
13. 要平均快速查找：散列表。

### 第 20 章：开放定址、二次探测、双散列与再散列（Open Addressing & Rehashing）

本章是散列表 `Hashing` 的最后补充部分，重点解决一个实际问题：**当散列表越来越满，或者开放定址法发生很多冲突、删除后留下很多“墓碑”时，应该如何继续保证查找和插入接近平均 `O(1)`？**

本章核心内容包括：

- 开放定址法 `Open Addressing` 的二次探测 `Quadratic Probing`。
- 二次探测为什么要求表长通常取素数。
- 二次探测的查找代码为什么写成 `CurrentPos += 2 * ++CollisionNum - 1`。
- 开放定址法下删除为什么不能直接把单元格设为空。
- 双散列 `Double Hashing` 的思想与第二散列函数选择。
- 再散列 `Rehashing` 的触发时机、步骤、复杂度与代码实现。

#### 1. 开放定址法 Open Addressing 的基本思想

开放定址法的特点是：**所有元素都直接存放在散列表数组本身中**。当 `Hash(Key)` 算出的初始位置已经被占用时，不使用链表，而是继续按照某个探测序列在表中寻找下一个候选位置。

设关键字 `x` 的原始散列地址为：

```text
h(x) = Hash(x) % TableSize
```

冲突后的第 `i` 次探测位置通常写成：

```text
pos_i = (h(x) + f(i)) % TableSize
```

其中 `f(i)` 决定冲突解决策略：

| 方法 | 探测函数 | 特点 |
|---|---|---|
| 线性探测 | `f(i)=i` | 简单，但容易产生 primary clustering |
| 二次探测 | `f(i)=i^2` | 减轻 primary clustering，但仍有 secondary clustering |
| 双散列 | `f(i)=i*hash2(x)` | 探测序列更接近随机，效果通常最好 |

开放定址法的每个表格单元一般需要保存两部分：

```c
ElementType Element;   /* 实际关键字 */
EntryType Info;        /* 单元状态 */
```

其中 `Info` 至少有三种状态：

```c
typedef enum { Empty, Legitimate, Deleted } EntryType;
```

含义如下：

| 状态 | 含义 |
|---|---|
| `Empty` | 从未使用过，是一个真正空位置 |
| `Legitimate` | 当前保存一个有效元素 |
| `Deleted` | 原来有元素，但已经被删除，是一个“墓碑” |

#### 2. 二次探测 Quadratic Probing 的定义

二次探测使用二次函数作为探测增量：

```text
f(i) = i^2
```

因此探测序列为：

```text
h(x), h(x)+1^2, h(x)+2^2, h(x)+3^2, ...
```

实际数组下标要对 `TableSize` 取模：

```text
(h(x) + i^2) % TableSize
```

例如，若 `TableSize = 11`，`h(x)=3`，则二次探测序列为：

```text
i=0: (3+0)  % 11 = 3
i=1: (3+1)  % 11 = 4
i=2: (3+4)  % 11 = 7
i=3: (3+9)  % 11 = 1
i=4: (3+16) % 11 = 8
...
```

它不会像线性探测那样连续扫描 `3,4,5,6,7...`，所以可以明显缓解线性探测的 primary clustering。

#### 3. 二次探测的重要定理

课件中的定理是：

> 如果使用二次探测，并且散列表大小 `TableSize` 是素数，那么只要散列表至少还有一半是空的，就一定能够插入一个新元素。

也就是说，如果：

```text
TableSize 是素数
已占用位置数 <= floor(TableSize / 2)
```

那么对任意新元素，前 `floor(TableSize/2)` 个候选探测位置一定都是互不相同的，因此一定能找到一个空位。

#### 4. 二次探测定理证明思路

要证明“前一半探测位置互不相同”，只需证明对于：

```text
0 < i != j <= floor(TableSize / 2)
```

有：

```text
(h(x) + i^2) % TableSize != (h(x) + j^2) % TableSize
```

反证法：假设两者相等，则：

```text
h(x) + i^2 ≡ h(x) + j^2       (mod TableSize)
```

消去 `h(x)` 得：

```text
i^2 ≡ j^2                     (mod TableSize)
```

移项分解：

```text
i^2 - j^2 ≡ 0                 (mod TableSize)
(i + j)(i - j) ≡ 0             (mod TableSize)
```

因为 `TableSize` 是素数，所以若它整除乘积 `(i+j)(i-j)`，则它必须整除其中某一个因子：

```text
TableSize | (i + j)   或   TableSize | (i - j)
```

但由于：

```text
0 < i, j <= floor(TableSize/2)
```

所以：

```text
0 < i + j < TableSize
-(TableSize/2) < i - j < TableSize/2
```

因此 `i+j` 不可能被 `TableSize` 整除，`i-j` 也不可能被 `TableSize` 整除，矛盾。

所以前一半候选位置互不相同。只要表至少半空，就一定有空位可以插入。

#### 5. 二次探测为什么常要求表长为素数

如果表长不是素数，二次探测可能很快陷入重复位置，无法覆盖足够多的候选位置。

例如 `TableSize = 8`，`h(x)=0`，探测位置为：

```text
0^2 % 8 = 0
1^2 % 8 = 1
2^2 % 8 = 4
3^2 % 8 = 1
4^2 % 8 = 0
5^2 % 8 = 1
...
```

会反复在 `0,1,4` 等位置之间循环，很多位置永远探测不到。

因此开放定址法中经常让 `TableSize` 取素数，尤其是二次探测和双散列时，这一点非常重要。

课件还补充了一个特殊结论：如果表长是形如 `4k+3` 的素数，那么使用：

```text
f(i) = ± i^2
```

可以探测整个散列表。

#### 6. 二次探测中增量公式的优化

如果每次直接计算：

```c
CurrentPos = (Hash(Key) + CollisionNum * CollisionNum) % TableSize;
```

会涉及乘法和取模。课件给出了更快的增量写法：

```c
CurrentPos += 2 * ++CollisionNum - 1;
if (CurrentPos >= H->TableSize)
    CurrentPos -= H->TableSize;
```

原因是平方数之间的差为：

```text
i^2 - (i-1)^2 = 2i - 1
```

因此：

```text
1^2 = 0^2 + 1
2^2 = 1^2 + 3
3^2 = 2^2 + 5
4^2 = 3^2 + 7
...
```

探测偏移量可以通过不断加奇数得到，而不是每次重新平方。

课件中的代码：

```c
CurrentPos += 2 * ++CollisionNum - 1;
```

含义是：

1. 先让 `CollisionNum` 加 1。
2. 本轮增量为 `2 * CollisionNum - 1`。
3. 把这个增量加到当前位置。

例如：

| 第几次冲突 | `CollisionNum` | 增量 `2i-1` | 累计偏移 |
|---:|---:|---:|---:|
| 1 | 1 | 1 | 1 |
| 2 | 2 | 3 | 4 |
| 3 | 3 | 5 | 9 |
| 4 | 4 | 7 | 16 |

累计偏移正好是 `i^2`。

#### 7. 二次探测 Find 函数的课件版本

课件中的查找核心如下：

```c
Position Find(ElementType Key, HashTable H)
{
    Position CurrentPos;
    int CollisionNum;

    CollisionNum = 0;
    CurrentPos = Hash(Key, H->TableSize);

    while (H->TheCells[CurrentPos].Info != Empty &&
           H->TheCells[CurrentPos].Element != Key) {
        CurrentPos += 2 * ++CollisionNum - 1;
        if (CurrentPos >= H->TableSize)
            CurrentPos -= H->TableSize;
    }

    return CurrentPos;
}
```

这个函数返回的 `CurrentPos` 有两种可能：

1. `H->TheCells[CurrentPos].Element == Key`：说明找到了该关键字。
2. `H->TheCells[CurrentPos].Info == Empty`：说明探测到真正空位，关键字不存在；如果要插入，可以插在这里。

#### 8. Find 函数中条件顺序为什么不能随便换

课件中特别问：下面两个条件能不能交换？

```c
H->TheCells[CurrentPos].Info != Empty &&
H->TheCells[CurrentPos].Element != Key
```

不能随便交换。

原因是：如果当前位置是 `Empty`，那么这个单元格中 `Element` 字段可能没有被初始化。若先判断：

```c
H->TheCells[CurrentPos].Element != Key
```

就可能读取未定义数据，导致错误行为。

所以必须先确认单元格不是空的，再去比较其中的 `Element`。

正确顺序是：

```c
while (Info != Empty && Element != Key)
```

而不是：

```c
while (Element != Key && Info != Empty)
```

#### 9. 二次探测 Insert 函数

插入的基本逻辑是：

1. 先调用 `Find(Key, H)`。
2. 如果返回位置已经是 `Legitimate`，说明关键字已存在，不重复插入。
3. 如果返回位置不是 `Legitimate`，说明可以插入。

课件版本：

```c
void Insert(ElementType Key, HashTable H)
{
    Position Pos;

    Pos = Find(Key, H);

    if (H->TheCells[Pos].Info != Legitimate) {
        H->TheCells[Pos].Info = Legitimate;
        H->TheCells[Pos].Element = Key;
    }
}
```

这个版本适合说明思想，但实际工程中还要考虑：

- 表是否超过半满。
- 是否有太多 `Deleted` 单元。
- 插入失败时是否要再散列。
- 是否要维护有效元素数量 `Size`。
- 是否要维护非空位置数量 `Occupied`。

#### 10. 开放定址法中的删除问题

开放定址法中删除不能简单地把单元格设置成 `Empty`。

原因是：开放定址的查找依赖探测路径。若把中间某个位置直接设为 `Empty`，后面本来因为冲突而放到更远位置的元素就可能再也找不到。

举例：

```text
TableSize = 11
h(A)=3, A 放在 3
h(B)=3, B 冲突后放在 4
h(C)=3, C 冲突后放在 7
```

如果删除 `A` 后把位置 `3` 直接设成 `Empty`，之后查找 `B` 或 `C` 时：

```text
先看位置 3，发现 Empty，于是认为关键字不存在
```

这样就破坏了查找路径。

正确做法是使用懒惰删除 `Lazy Deletion`，把单元格标记为：

```c
Deleted
```

也就是所谓 tombstone，中文可理解为“墓碑”。

删除代码：

```c
void Delete(ElementType Key, HashTable H)
{
    Position Pos = Find(Key, H);

    if (H->TheCells[Pos].Info == Legitimate &&
        H->TheCells[Pos].Element == Key) {
        H->TheCells[Pos].Info = Deleted;
    }
}
```

#### 11. Deleted 标记的副作用

`Deleted` 可以保证查找路径不断裂，但它也会带来副作用：

- 查找时不能遇到 `Deleted` 就停止，必须继续探测。
- 插入时可以复用 `Deleted` 位置，但仍要确认后续探测路径上没有同样的 key。
- 如果删除和插入混合很多次，表中可能有大量 `Deleted`。
- 大量 `Deleted` 会让探测序列变长，导致插入和查找变慢。

因此开放定址法通常需要再散列 `Rehashing` 来清理墓碑。

#### 12. 更健壮的 FindPosition 写法

课件代码用于讲解很清楚，但在支持 `Deleted` 状态时，更健壮的写法是：记录第一个遇到的 `Deleted` 位置，同时继续查找 key 是否已经存在。

```c
Position FindPosition(ElementType Key, HashTable H)
{
    Position CurrentPos = Hash(Key, H->TableSize);
    Position FirstDeleted = -1;
    int CollisionNum = 0;

    while (H->TheCells[CurrentPos].Info != Empty) {
        if (H->TheCells[CurrentPos].Info == Legitimate &&
            H->TheCells[CurrentPos].Element == Key) {
            return CurrentPos;   /* 找到已有 key */
        }

        if (H->TheCells[CurrentPos].Info == Deleted && FirstDeleted == -1) {
            FirstDeleted = CurrentPos;  /* 记住第一个墓碑，可能用于插入 */
        }

        CurrentPos += 2 * ++CollisionNum - 1;
        while (CurrentPos >= H->TableSize)
            CurrentPos -= H->TableSize;
    }

    if (FirstDeleted != -1)
        return FirstDeleted;      /* key 不存在，可复用墓碑 */
    else
        return CurrentPos;        /* key 不存在，可插入真正空位 */
}
```

这里要注意：

- 查找是否存在 key 时，只能把 `Legitimate && Element == Key` 当作找到。
- `Deleted` 位置不能说明 key 存在。
- 插入时优先复用第一个 `Deleted`，可以减少墓碑数量。

#### 13. 二次探测的 primary clustering 与 secondary clustering

线性探测容易产生 primary clustering，即一大片连续被占用区域会越来越大。二次探测通过跳跃式探测缓解了这个问题。

但是二次探测仍然有 secondary clustering。

所谓 secondary clustering 是：

> 如果两个不同 key 的初始散列位置相同，即 `Hash(x) == Hash(y)`，那么它们之后的二次探测序列也完全相同。

因为二次探测序列只由 `h(x)` 和 `i^2` 决定。如果 `h(x)` 一样，那么候选位置序列一样。

所以二次探测解决了 primary clustering，但没有彻底解决冲突聚集问题。

#### 14. 双散列 Double Hashing 的思想

双散列用第二个散列函数决定每次探测的步长：

```text
f(i) = i * hash2(x)
```

探测序列为：

```text
h1(x),
h1(x) + 1 * h2(x),
h1(x) + 2 * h2(x),
h1(x) + 3 * h2(x),
...
```

取模后：

```text
pos_i = (h1(x) + i * h2(x)) % TableSize
```

由于 `hash2(x)` 与 key 本身有关，即使两个 key 的 `h1(x)` 相同，它们的 `h2(x)` 也可能不同，于是后续探测路径就不同。

这可以显著减轻 secondary clustering。

#### 15. 双散列中第二散列函数的要求

双散列最重要的要求是：**必须确保所有单元都有可能被探测到**。

为此，`hash2(x)` 必须满足：

```text
hash2(x) != 0
```

并且最好：

```text
gcd(hash2(x), TableSize) = 1
```

如果 `hash2(x)` 与 `TableSize` 不互素，探测序列可能只在表的一部分位置里循环。

课件给出的经验公式是：

```text
hash2(x) = R - (x % R)
```

其中：

```text
R 是一个小于 TableSize 的素数
```

如果 `TableSize` 本身也是素数，并且 `1 <= hash2(x) < TableSize`，则 `hash2(x)` 与 `TableSize` 必然互素。

#### 16. 双散列示例

假设：

```text
TableSize = 13
R = 7
h1(x) = x % 13
h2(x) = 7 - (x % 7)
```

对于 `x = 18`：

```text
h1(18) = 18 % 13 = 5
h2(18) = 7 - (18 % 7) = 7 - 4 = 3
```

探测序列为：

```text
5
(5 + 1*3) % 13 = 8
(5 + 2*3) % 13 = 11
(5 + 3*3) % 13 = 1
(5 + 4*3) % 13 = 4
...
```

如果另一个 key 也有 `h1=5`，但 `h2` 不同，那么它的后续探测位置就会不同。

#### 17. 二次探测与双散列的比较

| 方法 | 优点 | 缺点 | 适用情况 |
|---|---|---|---|
| 二次探测 | 实现简单，不需要第二散列函数，速度快 | 有 secondary clustering；表超过半满时可能失败 | 实践中常用，尤其表能控制在半满以下时 |
| 双散列 | 探测序列更接近随机，冲突效果好 | 需要设计第二散列函数，计算略复杂 | 对冲突性能要求高时 |

课件指出：如果双散列正确实现，模拟结果显示它的期望探测次数几乎和随机冲突解决策略相同。但二次探测不需要第二散列函数，因此通常更简单、更快。

#### 18. 再散列 Rehashing 的动机

再散列解决的是：**散列表变得不适合继续使用时，重新建立一个更大的散列表**。

开放定址法特别需要再散列，因为：

1. 二次探测在表超过半满后，插入可能失败。
2. 装填因子过高时，探测次数会显著增加。
3. 删除产生的 `Deleted` 墓碑过多，会拖慢查找和插入。
4. 原表大小可能不再合适，需要扩容。

再散列的基本思想是：

```text
建立一个更大的新表，把旧表中所有有效元素重新插入新表。
```

注意：不能直接把旧数组复制到新数组，因为表长变了，`Hash(Key) % TableSize` 的结果也会变。

#### 19. 再散列的三个步骤

课件给出的步骤是：

1. 建立另一个大约两倍大的散列表。
2. 扫描整个原散列表，找到所有非删除的有效元素。
3. 使用新的表长和新的散列函数，把这些元素重新插入新表。

用伪代码表示：

```text
Rehash(H):
    OldTable = H->TheCells
    OldSize = H->TableSize

    Create new table with size about 2 * OldSize

    for each cell in OldTable:
        if cell.Info == Legitimate:
            Insert(cell.Element, NewTable)

    free OldTable
    return NewTable
```

#### 20. 什么时候需要 Rehash

课件列出了三种常见触发时机：

1. 表一半满时立即 rehash。
2. 插入失败时 rehash。
3. 表达到某个装填因子时 rehash。

实际写程序时最常见的策略是：

```c
if (H->Occupied * 2 >= H->TableSize)
    H = Rehash(H);
```

这里的 `Occupied` 可以理解为：

```text
Legitimate + Deleted
```

也就是所有不能被当作真正空位直接停止查找的格子数量。

如果只看 `Size`，也就是有效元素数，可能忽略大量 `Deleted` 墓碑造成的性能下降。

#### 21. Rehash 的时间复杂度与摊还分析

一次再散列要扫描整个旧表，并重新插入所有有效元素，所以：

```text
T(N) = O(N)
```

这里 `N` 可以理解为旧表大小或旧表中元素数量的同阶量。

课件指出：通常在 rehash 前已经发生了大约 `N/2` 次插入，因此这一次 `O(N)` 的再散列成本可以摊还到之前很多次插入上。

因此平均来看，每次插入额外承担的 rehash 成本是常数级：

```text
摊还复杂度：O(1)
```

但在交互式系统中，触发 rehash 的那一次插入会明显变慢，因为它独自承担了一次 `O(N)` 的重建过程。

#### 22. 完整 C 语言代码：二次探测 + Lazy Deletion + Rehash

下面代码是一个完整的整数散列表模板，支持：

- 初始化散列表。
- 二次探测查找位置。
- 插入。
- 删除。
- 查询。
- 自动再散列。

```c
#include <stdio.h>
#include <stdlib.h>
#include <stdbool.h>

#define MinTableSize 11

typedef int ElementType;
typedef int Position;

typedef enum {
    Empty,
    Legitimate,
    Deleted
} EntryType;

typedef struct HashEntry {
    ElementType Element;
    EntryType Info;
} Cell;

typedef struct HashTbl {
    int TableSize;     /* 表长，通常取素数 */
    int Size;          /* Legitimate 元素个数 */
    int Occupied;      /* Legitimate + Deleted 个数 */
    Cell *TheCells;
} *HashTable;

static void FatalError(const char *msg)
{
    fprintf(stderr, "%s\n", msg);
    exit(EXIT_FAILURE);
}

static bool IsPrime(int n)
{
    if (n <= 1) return false;
    if (n == 2 || n == 3) return true;
    if (n % 2 == 0) return false;

    for (int i = 3; i * i <= n; i += 2) {
        if (n % i == 0)
            return false;
    }
    return true;
}

static int NextPrime(int n)
{
    if (n <= 2) return 2;
    if (n % 2 == 0) n++;
    while (!IsPrime(n))
        n += 2;
    return n;
}

static Position Hash(ElementType Key, int TableSize)
{
    int h = Key % TableSize;
    if (h < 0) h += TableSize;   /* 处理负数 key */
    return h;
}

HashTable InitializeTable(int TableSize)
{
    HashTable H;

    if (TableSize < MinTableSize)
        TableSize = MinTableSize;

    H = malloc(sizeof(struct HashTbl));
    if (H == NULL)
        FatalError("Out of space for hash table!");

    H->TableSize = NextPrime(TableSize);
    H->Size = 0;
    H->Occupied = 0;

    H->TheCells = malloc(sizeof(Cell) * H->TableSize);
    if (H->TheCells == NULL)
        FatalError("Out of space for cells!");

    for (int i = 0; i < H->TableSize; i++) {
        H->TheCells[i].Info = Empty;
    }

    return H;
}

void DestroyTable(HashTable H)
{
    if (H != NULL) {
        free(H->TheCells);
        free(H);
    }
}

/*
 * 返回值含义：
 * 1. 如果 Key 已存在，返回它所在的位置。
 * 2. 如果 Key 不存在，返回可插入的位置。
 *    优先返回第一个 Deleted 位置，否则返回 Empty 位置。
 */
Position FindPosition(ElementType Key, HashTable H)
{
    Position CurrentPos = Hash(Key, H->TableSize);
    Position FirstDeleted = -1;
    int CollisionNum = 0;

    while (H->TheCells[CurrentPos].Info != Empty) {
        if (H->TheCells[CurrentPos].Info == Legitimate &&
            H->TheCells[CurrentPos].Element == Key) {
            return CurrentPos;
        }

        if (H->TheCells[CurrentPos].Info == Deleted && FirstDeleted == -1) {
            FirstDeleted = CurrentPos;
        }

        /* 二次探测：累计加 1,3,5,7,... */
        CurrentPos += 2 * ++CollisionNum - 1;

        /* 避免取模；但为了安全，用 while 处理极端情况 */
        while (CurrentPos >= H->TableSize)
            CurrentPos -= H->TableSize;

        /* 理论上表保持半空即可找到位置；这里做防御式保护 */
        if (CollisionNum > H->TableSize)
            FatalError("Quadratic probing failed: table is too full!");
    }

    if (FirstDeleted != -1)
        return FirstDeleted;

    return CurrentPos;
}

bool Contains(ElementType Key, HashTable H)
{
    Position Pos = FindPosition(Key, H);
    return H->TheCells[Pos].Info == Legitimate &&
           H->TheCells[Pos].Element == Key;
}

HashTable Rehash(HashTable H);

HashTable Insert(ElementType Key, HashTable H)
{
    Position Pos;

    /* 如果 Legitimate + Deleted 超过半表，先 rehash */
    if (H->Occupied * 2 >= H->TableSize) {
        H = Rehash(H);
    }

    Pos = FindPosition(Key, H);

    if (H->TheCells[Pos].Info != Legitimate) {
        if (H->TheCells[Pos].Info == Empty)
            H->Occupied++;

        H->TheCells[Pos].Info = Legitimate;
        H->TheCells[Pos].Element = Key;
        H->Size++;
    }

    return H;
}

bool Delete(ElementType Key, HashTable H)
{
    Position Pos = FindPosition(Key, H);

    if (H->TheCells[Pos].Info == Legitimate &&
        H->TheCells[Pos].Element == Key) {
        H->TheCells[Pos].Info = Deleted;
        H->Size--;
        return true;
    }

    return false;
}

HashTable Rehash(HashTable H)
{
    int OldSize = H->TableSize;
    Cell *OldCells = H->TheCells;

    HashTable NewH = InitializeTable(2 * OldSize);

    for (int i = 0; i < OldSize; i++) {
        if (OldCells[i].Info == Legitimate) {
            NewH = Insert(OldCells[i].Element, NewH);
        }
    }

    free(OldCells);
    free(H);

    return NewH;
}

void PrintTable(HashTable H)
{
    printf("TableSize=%d, Size=%d, Occupied=%d\n",
           H->TableSize, H->Size, H->Occupied);

    for (int i = 0; i < H->TableSize; i++) {
        printf("[%2d] ", i);
        if (H->TheCells[i].Info == Empty)
            printf("Empty\n");
        else if (H->TheCells[i].Info == Deleted)
            printf("Deleted\n");
        else
            printf("%d\n", H->TheCells[i].Element);
    }
}

int main(void)
{
    HashTable H = InitializeTable(11);

    int data[] = {10, 21, 32, 43, 54, 65, 76};
    int n = sizeof(data) / sizeof(data[0]);

    for (int i = 0; i < n; i++) {
        H = Insert(data[i], H);
    }

    PrintTable(H);

    printf("Contains 32? %s\n", Contains(32, H) ? "yes" : "no");
    printf("Delete 32: %s\n", Delete(32, H) ? "success" : "fail");
    printf("Contains 32? %s\n", Contains(32, H) ? "yes" : "no");

    H = Insert(87, H);
    H = Insert(98, H);

    PrintTable(H);

    DestroyTable(H);
    return 0;
}
```

#### 23. 代码细节解释

上面代码中最重要的几个变量是：

```c
int Size;
int Occupied;
```

它们不是同一个东西。

`Size` 表示当前有效元素数量：

```text
Size = Legitimate 的数量
```

`Occupied` 表示不能被当作真正空位的数量：

```text
Occupied = Legitimate + Deleted 的数量
```

为什么要使用 `Occupied` 触发 rehash？

因为 `Deleted` 虽然可以被插入复用，但在查找过程中不能使探测停止。大量 `Deleted` 会让表看起来还有很多空间，但实际查找很慢。

因此更稳妥的触发条件是：

```c
if (H->Occupied * 2 >= H->TableSize)
    H = Rehash(H);
```

这表示只要有效元素加墓碑数量达到表的一半，就重建表。

#### 24. 双散列版本的核心代码

下面是把探测策略换成双散列的核心写法。

```c
static Position Hash1(ElementType Key, int TableSize)
{
    int h = Key % TableSize;
    if (h < 0) h += TableSize;
    return h;
}

static int Hash2(ElementType Key, int TableSize)
{
    /* R 必须是小于 TableSize 的素数。
       为了演示，这里简单选择一个固定值；实际可根据 TableSize 选择。 */
    int R = 7;
    int h = Key % R;
    if (h < 0) h += R;
    return R - h;     /* 范围为 1 到 R，永不为 0 */
}

Position FindPositionDoubleHash(ElementType Key, HashTable H)
{
    Position CurrentPos = Hash1(Key, H->TableSize);
    int Step = Hash2(Key, H->TableSize);
    Position FirstDeleted = -1;
    int Probes = 0;

    while (H->TheCells[CurrentPos].Info != Empty) {
        if (H->TheCells[CurrentPos].Info == Legitimate &&
            H->TheCells[CurrentPos].Element == Key) {
            return CurrentPos;
        }

        if (H->TheCells[CurrentPos].Info == Deleted && FirstDeleted == -1) {
            FirstDeleted = CurrentPos;
        }

        CurrentPos += Step;
        CurrentPos %= H->TableSize;

        if (++Probes > H->TableSize)
            FatalError("Double hashing failed: table is too full or step is invalid!");
    }

    if (FirstDeleted != -1)
        return FirstDeleted;

    return CurrentPos;
}
```

要让这个双散列版本真正可靠，需要保证：

```text
TableSize 是素数
R 是小于 TableSize 的素数
hash2(Key) != 0
```

这样 `Step` 与 `TableSize` 互素，探测序列才能覆盖整张表。

#### 25. 字符串关键字的 Hash 函数补充

如果关键字不是整数，而是字符串，可以使用上一讲 Hashing 中常见的字符串散列函数：

```c
#include <string.h>

typedef const char *StringKey;

unsigned int HashString(const char *Key, int TableSize)
{
    unsigned int HashVal = 0;

    while (*Key != '\0') {
        HashVal = (HashVal << 5) + (unsigned char)(*Key++);
    }

    return HashVal % TableSize;
}
```

其中：

```c
HashVal = (HashVal << 5) + *Key;
```

等价于：

```c
HashVal = HashVal * 32 + *Key;
```

位移通常比乘法更快。这个函数的思想是把字符串看成一个以 `32` 为基数的数，再对表长取模。

如果字符串很长，例如地址、文章标题等，早期字符可能因为溢出被移出有效位。实际应用中可以考虑：

- 选取部分代表性字符。
- 使用更成熟的字符串 hash 函数。
- 使用无符号整数自然溢出。

#### 26. 开放定址法完整操作复杂度

在散列函数足够均匀、装填因子控制得当时：

| 操作 | 平均复杂度 | 最坏复杂度 | 说明 |
|---|---:|---:|---|
| 查找成功 | `O(1)` | `O(N)` | 极端冲突时退化 |
| 查找失败 | `O(1)` | `O(N)` | 装填因子越高，失败查找越慢 |
| 插入 | 摊还 `O(1)` | 单次可能 `O(N)` | 触发 rehash 时为 `O(N)` |
| 删除 | `O(1)` | `O(N)` | 使用 lazy deletion |
| Rehash | `O(N)` | `O(N)` | 扫描旧表并重插有效元素 |

注意：`O(1)` 是平均意义上的，不是保证每一次操作都一定常数时间。

#### 27. 散列表装填因子 Load Factor

装填因子通常记作：

```text
λ = n / TableSize
```

其中 `n` 是当前存储的元素数量。

对于开放定址法，装填因子非常重要。一般来说：

- `λ` 较小时，冲突少，操作接近 `O(1)`。
- `λ` 接近 1 时，空位很少，探测次数急剧增加。
- 对于二次探测，通常希望 `λ <= 0.5`。

如果考虑墓碑，实际更应该看：

```text
λ_occupied = (Legitimate + Deleted) / TableSize
```

当 `λ_occupied` 过高时，即使 `Size` 不大，也应该 rehash。

#### 28. 考试常见判断题与易错点

常见易错点如下：

1. **二次探测不是一定能探测全表。** 课件定理保证的是：表长为素数且表至少半空时，一定能插入。
2. **表长最好取素数。** 尤其在二次探测和双散列中，表长不是素数会导致探测位置重复严重。
3. **Find 中必须先判断 `Info != Empty`，再比较 `Element != Key`。** 因为空单元的 key 可能未定义。
4. **开放定址法删除不能直接设为 Empty。** 否则会断开后续元素的探测路径。
5. **Deleted 太多会降低效率。** 所以需要 rehash 清理墓碑。
6. **二次探测解决 primary clustering，但仍有 secondary clustering。** 因为相同初始 hash 的 key 探测序列完全相同。
7. **双散列的第二 hash 不能为 0。** 否则探测位置永远不变。
8. **双散列步长要和表长互素。** 否则无法探测所有位置。
9. **Rehash 不能直接复制数组。** 新表长改变后，元素位置必须重新计算。
10. **Rehash 单次是 `O(N)`，但摊还到多次插入上是 `O(1)`。**

#### 29. 本章核心代码模板速记

二次探测核心：

```c
CurrentPos = Hash(Key, TableSize);
CollisionNum = 0;

while (cell is occupied and cell key is not Key) {
    CurrentPos += 2 * ++CollisionNum - 1;
    if (CurrentPos >= TableSize)
        CurrentPos -= TableSize;
}
```

双散列核心：

```c
CurrentPos = Hash1(Key, TableSize);
Step = Hash2(Key);

while (cell is occupied and cell key is not Key) {
    CurrentPos = (CurrentPos + Step) % TableSize;
}
```

再散列核心：

```c
NewTable = InitializeTable(2 * OldTableSize);

for each cell in OldTable:
    if cell.Info == Legitimate:
        Insert(cell.Element, NewTable);

free OldTable;
return NewTable;
```

懒惰删除核心：

```c
if (Find(Key) is Legitimate)
    cell.Info = Deleted;
```

#### 30. 本章知识点总表

| 知识点 | 关键结论 |
|---|---|
| 开放定址法 | 所有元素都存在数组里，冲突后继续探测 |
| 二次探测 | `f(i)=i^2`，用平方偏移解决冲突 |
| 二次探测定理 | 表长为素数且至少半空时，一定能插入 |
| 增量优化 | `i^2-(i-1)^2=2i-1`，避免重复平方 |
| 条件顺序 | 先判断 `Info != Empty`，再比较 `Element` |
| Lazy deletion | 删除时标记 `Deleted`，不能直接设 `Empty` |
| Secondary clustering | 相同初始 hash 的 key 探测序列相同 |
| 双散列 | `f(i)=i*hash2(x)`，减轻 secondary clustering |
| 第二 hash | 必须非 0，最好与表长互素 |
| Rehash | 新建更大表，重新插入所有有效元素 |
| Rehash 时机 | 半满、插入失败、装填因子过高、墓碑过多 |
| Rehash 复杂度 | 单次 `O(N)`，摊还到插入上为 `O(1)` |

#### 31. 和前面 Hashing 内容的衔接

前面散列部分已经说明：散列表的目标是让查找、插入、删除在平均意义上达到 `O(1)`。但这个目标依赖两个条件：

1. hash 函数足够均匀。
2. 冲突解决策略足够合理。

本章补充的二次探测、双散列和再散列，正是为了在开放定址法中维持这两个条件。

可以把本章放进整个 Hashing 复习框架中：

```text
Hashing
├── Symbol Table ADT
├── Hash Function
│   ├── 整数 hash: x % TableSize
│   └── 字符串 hash: shift + add
├── Collision Resolution
│   ├── Separate Chaining
│   └── Open Addressing
│       ├── Linear Probing
│       ├── Quadratic Probing
│       └── Double Hashing
└── Rehashing
    ├── 扩容
    ├── 清理 Deleted
    └── 恢复低装填因子
```

复习时应把“散列函数”“冲突处理”“装填因子”“再散列”连成一个整体，而不是分开死记。

---

## <center>Part 2：课堂内容总结笔记</center>

### 一、算法分析

#### 1. 算法定义与标准
- **算法**：一个有穷的指令集，满足以下 $5$ 个标准：
  1. **输入**：有零个或多个外部提供的量
  2. **输出**：至少产生一个量
  3. **确定性**：每条指令清晰无歧义
  4. **有穷性**：对所有情况，算法在有限步后终止
  5. **有效性**：每条指令足够基本，可被纸笔执行

- **程序** vs **算法**：程序用编程语言编写，可以不满足有穷性（如操作系统）；算法可用自然语言、流程图、伪代码或编程语言描述。

---

#### 2. 选择排序示例（伪代码）

```
for (i = 0; i < n; i++) {
    在 list[i] 到 list[n-1] 中找到最小元素的位置 min;
    交换 list[i] 和 list[min];
}
```

---

#### 3. 时间复杂度分析

- **$T_{avg}(N)$**：平均情况时间复杂度
- **$T_{worst}(N)$**：最坏情况时间复杂度

##### 3.1 示例 1：矩阵加法
```c
for (i = 0; i < rows; i++)
    for (j = 0; j < cols; j++)
        C[i][j] = A[i][j] + B[i][j];
```
- 时间复杂度：$T(rows, cols) = 2·rows·cols + 2·rows + 1$

##### 3.2 示例 2：迭代求列表和
```c
int Sum(int A[], int n) {
    int i, sum = 0;
    for (i = 0; i < n; i++)
        sum += A[i];
    return sum;
}
```
- $T(n) = 2n + 3$

##### 3.3 示例 3：递归求列表和
```c
int Rsum(int A[], int n) {
    if (n == 0) return 0;
    else return Rsum(A, n-1) + A[n-1];
}
```
- $T(n) = 2n + 2$（但每一步实际耗时更多）

---

#### 4. 渐近表示法（Asymptotic Notation）

- **$O(f(N))$**：存在正常数 $c$ 和 $n_0$，使 $T(N) ≤ c·f(N)$ 对所有 $N ≥ n₀$ 成立（上界）
- **$Ω(g(N))$**：存在正常数 $c$ 和 $n_0$，使 $T(N) ≥ c·g(N)$ 对所有 $N ≥ n_0$ 成立（下界）
- **$Θ(h(N))$**：$T(N) = O(h(N))$ 且 $T(N) = Ω(h(N))$（紧界）
- **$o(p(N))$**：$T(N) = O(p(N))$ 且 $T(N) ≠ Θ(p(N))$

---

##### 4.1 常用性质

- 若 $T_1(N) = O(f(N))$，$T_2(N) = O(g(N))$，则：
  - $T_1(N) + T_2(N) = max(O(f(N)), O(g(N)))$
  - $T_1(N) × T_2(N) = O(f(N) × g(N))$
- 若 $T(N)$ 是 $k$ 次多项式，则 $T(N) = Θ(N^k)$
- 对任意常数 $k$，$log^kN = O(N)$（对数增长非常缓慢）

---

##### 4.2 示例比较

- $2N + 3 = O(N) = O(Nᵏ) = O(2^N)$（取最小的 $f(N)$）
- $2^N + N^2 = Ω(2^N) = Ω(N^2) = Ω(N) = Ω(1)$（取最大的 $g(N)$）

---

#### 5. 复杂度分析规则

- **`for` 循环**：循环内语句运行时间 × 迭代次数
- **嵌套 `for` 循环**：内层语句运行时间 × 所有循环大小的乘积
- **顺序语句**：取最大的运行时间
- **`if` / `else`**：条件判断时间 + 较大分支的运行时间

---

#### 6. 递归复杂度示例：斐波那契数列

```c
// 纯递归
long int Fib(int N) {
    if (N <= 1) return 1;
    else return Fib(N-1) + Fib(N-2);
}
```

```c
// 递推迭代
long int Fib(int N) {
    f[1]=1,f[2]=1;
    for(int i=3;i<=n;i++) f[i]=f[i-1]+f[i-2];
}
```

```c
// 滚动变量迭代
long int Fib(int N) {
    a=1,b=1;
    for(int i=3;i<=n;i++){
        c=a+b;
        a=b;
        b=c;
    }
}
```

- $T(N) = T(N-1) + T(N-2) + 2 ≥ Fib(N)$，非常低效
- 暴力递归时间复杂度为 $O(2^n)$，空间复杂度为 $O(n)$
- 普通递推时间复杂度为 $O(n)$，空间复杂度为 $O(n)$（记忆化递归或动态优化）或 $O(1)$（迭代优化）
- 矩阵快速幂时间复杂度为 $O(logn)$，空间复杂度为 $O(1)$

---

#### 7. 最大子序列和问题（4种算法）

##### 7.1 算法 1：三重循环（$O(N³)$）
```c
int MaxSubsequenceSum(const int A[], int N) {
    int ThisSum, MaxSum, i, j, k;
    MaxSum = 0;
    for (i = 0; i < N; i++)
        for (j = i; j < N; j++) {
            ThisSum = 0;
            for (k = i; k <= j; k++)
                ThisSum += A[k];
            if (ThisSum > MaxSum)
                MaxSum = ThisSum;
        }
    return MaxSum;
}
```

---

##### 7.2 算法 2：两重循环（$O(N²)$）

```c
int MaxSubsequenceSum(const int A[], int N) {
    int ThisSum, MaxSum, i, j;
    MaxSum = 0;
    for (i = 0; i < N; i++) {
        ThisSum = 0;
        for (j = i; j < N; j++) {
            ThisSum += A[j];
            if (ThisSum > MaxSum)
                MaxSum = ThisSum;
        }
    }
    return MaxSum;
}
```

---

##### 7.3 算法 3：分治法（$O(N log N)$）

- 将数组分成两半，分别求左半最大子序列和、右半最大子序列和、跨越中间的最大子序列和
- 递推式：$T(N) = 2T(N/2) + cN$，解得 $T(N) = O(N log N)$

---

##### 7.4 算法 4：在线算法（$O(N)$）

```c
int MaxSubsequenceSum(const int A[], int N) {
    int ThisSum = 0, MaxSum = 0, j;
    for (j = 0; j < N; j++) {
        ThisSum += A[j];
        if (ThisSum > MaxSum)
            MaxSum = ThisSum;
        else if (ThisSum < 0)
            ThisSum = 0;
    }
    return MaxSum;
}
```
- 特点：只需扫描一次数据，任何时刻都能给出当前已读数据的正确答案

---

#### 8. 对数运行时间示例：二分查找

```c
int BinarySearch(const ElementType A[], ElementType X, int N) {
    int Low = 0, Mid, High = N - 1;
    while (Low <= High) {
        Mid = (Low + High) / 2;
        if (A[Mid] < X)
            Low = Mid + 1;
        else if (A[Mid] > X)
            High = Mid - 1;
        else
            return Mid;
    }
    return NotFound;
}
```
- 最坏时间复杂度：$T_{worst}(N) = O(log N)$
- 适用条件：数据静态且已排序

---

#### 9. 验证分析方法

- 若 $T(N) = O(N)$，检查 $T(2N)/T(N) ≈ 2$
- 若 $T(N) = O(N²)$，检查 $T(2N)/T(N) ≈ 4$
- 若 $T(N) = O(N³)$，检查 $T(2N)/T(N) ≈ 8$

---

### 二、列表（List）

#### 1. 抽象数据类型（ADT）定义
- **数据类型** = {对象} ∪ {操作}
- **抽象数据类型**：对象的规约与操作的规约，与对象的表示和操作的实现相分离

---

#### 2. 列表ADT

- **对象**：($item_0, item_1, ..., item_{N-1}$)
- **操作**：
  - 求长度 $N$
  - 打印所有项
  - 置空
  - 找第 $k$ 项（$0 ≤ k < N$）
  - 在第 $k$ 项后插入新项
  - 删除某项
  - 找当前项的下一个
  - 找当前项的前一个

---

#### 3. 简单数组实现

- `array[i] = item_i`
- **Find_Kth**：$O(1)$
- **插入与删除**：$O(N)$，涉及大量数据移动
- **缺点**：需预估 `MaxSize`

---

#### 4. 链表实现

##### 4.1 节点结构定义
```c
typedef struct list_node *list_ptr;
typedef struct list_node {
    char data[4];
    list_ptr next;
} list_node;
```

---

##### 4.2 插入操作

```c
temp->next = node->next;
node->next = temp;
```
- 时间复杂度：$O(1)$
- 注意：两步顺序不可颠倒，否则会丢失原链表

---

##### 4.3 删除操作

```c
pre->next = node->next;
free(node);
```
- 时间复杂度：$O(1)$

---

##### 4.4 处理首节点问题

- 可添加一个哑头节点（`dummy head node`）

---

#### 5. 双向循环链表

##### 5.1 节点结构
```c
typedef struct node *node_ptr;
typedef struct node {
    node_ptr llink;
    element item;
    node_ptr rlink;
} node;
```

---

##### 5.2 性质

- `ptr = ptr->llink->rlink = ptr->rlink->llink`
- 带头的空双向循环链表：头节点的llink和rlink都指向自身

---

#### 6. 多项式ADT

##### 6.1 对象
- $P(x) = a_1x^{e_1} + ... + a_nx^{e_n}$，其中 $e_i$ 为非负整数，$a_i$ 为系数

---

##### 6.2 操作

- 求多项式次数（最大指数）
- 加法、减法、乘法、求导

---

##### 6.3 表示法1：数组

```c
typedef struct {
    int CoeffArray[MaxDegree + 1];
    int HighPower;
} *Polynomial;
```
- 乘法时间复杂度：$O(N_1 × N_2)$
- 缺点：稀疏多项式浪费空间

---

##### 6.4 表示法2：链表

```c
struct poly_node {
    int Coefficient;
    int Exponent;
    poly_ptr Next;
};
```
- 节点按指数排序

---

#### 7. 多重链表（Multilists）

- 示例：$40000$ 名学生，$2500$ 门课程
  - 表示法1：`int Array[40000][2500]` 空间过大
  - 表示法2：链表节省空间

---

#### 8. 游标实现链表（无指针）

##### 8.1 模拟 `malloc` 和 `free`
```c
// malloc
p = CursorSpace[0].Next;
CursorSpace[0].Next = CursorSpace[p].Next;

// free(p)
CursorSpace[p].Next = CursorSpace[0].Next;
CursorSpace[0].Next = p;
```
- 游标实现通常比指针实现更快（无内存管理开销）

---

### 三、栈（Stack）

#### 1. ADT定义
- **对象**：有零个或多个元素的有序列表
- **特性**：后进先出（LIFO）
- **操作**：
  - `int IsEmpty(Stack S)`
  - `Stack CreateStack()`
  - `void DisposeStack(Stack S)`
  - `void MakeEmpty(Stack S)`
  - `void Push(ElementType X, Stack S)`
  - `ElementType Top(Stack S)`
  - `void Pop(Stack S)`
- **注意**：对空栈执行 `Pop` 或 `Top` 是 ADT 错误；对满栈执行 `Push` 是实现错误，非 ADT 错误

---

#### 2. 链表实现（不带头节点）

##### 2.1 链表结构体

```c
// 链表节点结构
typedef struct Node {
    int data;
    struct Node *next;
} Node;

// 栈结构（只需保存栈顶指针）
typedef struct {
    Node *top;
} LinkedStack;
```

---

##### 2.2 `Push` 操作
```c
TmpCell->Next = S->Next;
S->Next = TmpCell;
```

```c
int linkedPush(LinkedStack *s, int value) {
    Node *newNode = (Node*)malloc(sizeof(Node));
    if (newNode == NULL) {
        printf("错误：内存分配失败，无法压入 %d\n", value);
        return 0;
    }
    newNode->data = value;
    newNode->next = s->top;
    s->top = newNode;
    return 1;
}
```

---

##### 2.3 `Pop` 操作

```c
FirstCell = S->Next;
S->Next = S->Next->Next;
free(FirstCell);
```

```c
int linkedPop(LinkedStack *s, int *value) {
    if (isLinkedEmpty(s)) {
        printf("错误：栈为空，无法弹出元素\n");
        return 0;
    }
    Node *temp = s->top;
    *value = temp->data;
    s->top = temp->next;
    free(temp);
    return 1;
}
```

---

##### 2.4 `Top` 操作

- 返回 `S->Next->Element`

```c
int linkedTop(LinkedStack *s, int *value) {
    if (isLinkedEmpty(s)) {
        printf("错误：栈为空，无栈顶元素\n");
        return 0;
    }
    *value = s->top->data;
    return 1;
}
```

---

#### 3. 数组实现

##### 3.1 栈结构体
```c
struct StackRecord {
    int Capacity;      // 栈的大小
    int TopOfStack;    // 栈顶指针（++为push，--为pop，-1为空）
    ElementType *Array;
};
```
- **封装要求**：除栈操作函数外，其他代码不能访问 `Array` 或 `TopOfStack` 变量
- **错误检查**：`Push` / `Pop` / `Top` 前必须检查栈是否满 / 空

---

##### 3.2 `push` 操作

```c
int push(Stack *s, int value) {
    if (isFull(s)) {
        printf("错误：栈已满，无法压入 %d\n", value);
        return 0;
    }
    s->data[++(s->top)] = value;
    return 1;
}
```

---

##### 3.3 `pop` 操作

```c
int pop(Stack *s, int *value) {
    if (isEmpty(s)) {
        printf("错误：栈为空，无法弹出元素\n");
        return 0;
    }
    *value = s->data[(s->top)--];
    return 1;
}
```

---

##### 3.4 `top` 操作

```c
int top(Stack *s, int *value) {
    if (isEmpty(s)) {
        printf("错误：栈为空，无栈顶元素\n");
        return 0;
    }
    *value = s->data[s->top];
    return 1;
}
```

---

#### 4. 栈的应用

##### 4.1 符号平衡检查
```c
MakeEmpty(S);
while (read in a character c) {
    if (c是开符号) Push(c, S);
    else if (c是闭符号) {
        if (IsEmpty(S)) ERROR;
        else if (Top(S)不匹配c) ERROR;
        else Pop(S);
    }
}
if (!IsEmpty(S)) ERROR;
```
- 时间复杂度：$O(N)$，$N$ 为表达式长度
- 特点：在线算法

---

##### 4.2 后缀表达式求值

- 示例：`6 2 / 3 - 4 2 * +` $= 8$
- 操作：遇到操作数压栈；遇到运算符弹出两个操作数，运算结果压栈
- 时间复杂度：$O(N)$，无需知道优先级规则

---

##### 4.3 中缀转后缀

- 操作数顺序不变，直接输出
- 左括号直接压栈，永远不输出
- 右括号就弹出栈里的运算符并输出该运算符，直到遇到左括号，左括号弹出后和右括号一并消失
- 操作符看栈顶：
  - 栈空 / 栈顶是 `(`，则直接压栈
  - 栈顶运算符比当下手上的这个待处置的运算符优先级高或优先级相同，则弹出栈顶并输出栈顶运算符，继续将手上的运算符和栈顶的运算符比较
  - 栈顶运算符比当下手上的这个待处置的运算符优先级低，直接压栈

---

##### 4.4 函数调用与系统栈

- 递归可能导致栈溢出（如尾递归）
- 递归程序通常更简单易懂，但非递归程序通常更快
- 编译器可移除尾递归

---

### 四、队列（Queue）

#### 1. ADT 定义
- **对象**：有零个或多个元素的有序列表
- **特性**：先进先出（FIFO）
- **操作**：
  - `int IsEmpty(Queue Q)`
  - `Queue CreateQueue()`
  - `void DisposeQueue(Queue Q)`
  - `void MakeEmpty(Queue Q)`
  - `void Enqueue(ElementType X, Queue Q)`
  - `ElementType Front(Queue Q)`
  - `void Dequeue(Queue Q)`

---

#### 2. 数组实现

##### 2.1 队列结构体
```c
struct QueueRecord {
    int Capacity;      // 最大大小
    int Front;         // 前指针
    int Rear;          // 后指针
    int Size;          // 当前大小（可选）
    ElementType *Array;
};
```

---

##### 2.2 循环队列

- 问题：线性数组中，`Rear` 移到最后时 `Front` 前可能有空位，但队列被报告满
- 解决：使用循环队列（Circular Queue）
- 通过 `Size` 字段可避免浪费一个空位来区分“空”和“满”
- 其他区分方法：保留一个空位，约定 `Front == Rear + 1`（模 `Capacity`）为满

---

### 五、树（Tree）

#### 1. 基本术语
- **树**：节点的集合。可为空；非空时包含一个根节点和零个或多个非空子树，子树之间不相连
- **边的数量**：有 $N$ 个节点的树有 $N-1$ 条边
- **节点的度**：该节点的子树个数
- **叶子**：度为 $0$ 的节点（无子节点）
- **父节点**：有子树的节点
- **子节点**：父节点子树的根
- **兄弟节点**：同一父节点的子节点
- **祖先**：从该节点到根路径上的所有节点
- **后代**：该节点子树中的所有节点
- **深度**：从根到该节点的路径长度（根深度为 $1$）
- **高度**：从该节点到最远叶子的路径长度（叶子高度为 $1$）
  - 完全二叉树高度：$h=⌊log_2n⌋+1$
- **树的深度 / 高度**：根的高度 = 最深叶子的深度
- **路径**：从 $n_1$ 到 $n_k$ 的唯一节点序列，满足 $n_i$ 是 $n_{i+1}$ 的父节点
- **路径长度**：路径上的边数
- **总结点数**：$n=n_0+n_1+n_2+n_3+···+n_k$
  - 普通二叉树：$n_0=n_2+1$
  - 满二叉树总节点数：$n=2^h-1$
  - $m=n-1=Σi·n_i$（$m$ 是边数，$n$ 是总节点数，$i$ 是度数，$n_i$ 是度数为 $i$ 的节点个数）

---

#### 2. 树的表示方法

##### 2.2 列表表示
- 示例：`(A (B (E (K, L), F), C (G), D (H (M), I, J)))`
- 问题：节点大小依赖于分支数

---

##### 2.3 长子-兄弟表示法（FirstChild-NextSibling）

- 每个节点包含：数据、指向第一个子节点的指针、指向下一个兄弟节点的指针
- 表示不唯一（子节点顺序可变）
- 旋转 $45°$ 后得到二叉树

---

#### 3. 二叉树（Binary Tree）

##### 3.1 定义
- 每个节点最多有两个子节点的树

---

##### 3.2 表达式树（语法树）

- 叶子节点为操作数，内部节点为运算符
- 可从后缀表达式构造表达式树

---

#### 4. 树的遍历

所有遍历的时间复杂度都是 $O(N)$

---

##### 4.1 前序遍历

```c
void preorder(tree_ptr tree) {
    if (tree) {
        visit(tree);
        for (each child C of tree)
            preorder(C);
    }
}
```

```c
void preorder(TreeNode *root) {
    if (root == NULL) return;
    printf("%d ", root->val);
    preorder(root->left);
    preorder(root->right);
}
```

---

##### 4.2 后序遍历

```c
void postorder(tree_ptr tree) {
    if (tree) {
        for (each child C of tree)
            postorder(C);
        visit(tree);
    }
}
```

```c
oid postorder(TreeNode *root) {
    if (root == NULL) return;
    postorder(root->left);
    postorder(root->right);
    printf("%d ", root->val);
}
```

---

##### 4.3 层序遍历

```c
void levelorder(tree_ptr tree) {
    enqueue(tree);
    while (queue is not empty) {
        T = dequeue();
        visit(T);
        for (each child C of T)
            enqueue(C);
    }
}
```

```c
void levelOrder(TreeNode *root) {
    if (root == NULL) return;
    Queue q;
    initQueue(&q);
    enqueue(&q, root);
    while (!isEmpty(&q)) {
        TreeNode *cur = dequeue(&q);
        printf("%d ", cur->val);
        if (cur->left) enqueue(&q, cur->left);
        if (cur->right) enqueue(&q, cur->right);
    }
}
```

---

##### 4.4 中序遍历（二叉树）

```c
void inorder(tree_ptr tree) {
    if (tree) {
        inorder(tree->Left);
        visit(tree->Element);
        inorder(tree->Right);
    }
}
```

```c
void inorder(TreeNode *root) {
    if (root == NULL) return;
    inorder(root->left);
    printf("%d ", root->val);
    inorder(root->right);
}
```

---

##### 4.5 中序遍历迭代版本

```c
void iter_inorder(tree_ptr tree) {
    Stack S = CreateStack(MAX_SIZE);
    for (;;) {
        for (; tree; tree = tree->Left)
            Push(tree, S);
        tree = Top(S); Pop(S);
        if (!tree) break;
        visit(tree->Element);
        tree = tree->Right;
    }
}
```

```c
void inorderIterative(TreeNode *root) {
    Stack s;
    initStack(&s);
    TreeNode *cur = root;
    
    while (cur != NULL || !isStackEmpty(&s)) {
        // 一路向左，把节点压栈
        while (cur != NULL) {
            push(&s, cur);
            cur = cur->left;
        }
        // 到达最左，弹出并访问
        cur = pop(&s);
        printf("%d ", cur->val);
        // 转向右子树
        cur = cur->right;
    }
}
```

---

##### 4.6 示例

- 表达式 $A + B * C / D$

  - 中序遍历：$A + B * C / D$
  - 后序遍历：$A B C * D / +$
  - 前序遍历：$+ A / * B C D$

---

#### 5. 二叉树的属性

##### 5.1 性质
- 第i层的最大节点数：$2^{i-1}（i ≥ 1）$
- 深度为k的二叉树的最大节点数：$2^k - 1（k ≥ 1）$
- 对任意非空二叉树：$n_0 = n_2 + 1$
  - $n_0$：叶子节点数（度0）
  - $n_2$：度为2的节点数
  - 证明：设n₁为度1节点数，总节点数 $n = n_0+ n_1 + n_2$；总分支数 $B = n_1 + 2n_2 = n - 1 ⇒ n_0 = n_2 + 1$

---

##### 5.2 倾斜二叉树

- 左倾斜（Skewed to the left）
- 右倾斜（Skewed to the right）

---

##### 5.3 完全二叉树

- 所有叶子节点位于相邻两层

---

#### 6. 目录列表示例

```c
static void ListDir(DirOrFile D, int Depth) {
    if (D is a legitimate entry) {
        PrintName(D, Depth);
        if (D is a directory)
            for (each child C of D)
                ListDir(C, Depth + 1);
    }
}
void ListDirectory(DirOrFile D) {
    ListDir(D, 0);
}
```
- 时间复杂度：O(N)

---

#### 7. 计算目录大小示例

```c
static int SizeDir(DirOrFile D) {
    int TotalSize = 0;
    if (D is a legitimate entry) {
        TotalSize = FileSize(D);
        if (D is a directory)
            for (each child C of D)
                TotalSize += SizeDir(C);
    }
    return TotalSize;
}
```
- 时间复杂度：$O(N)$

---

#### 8. 线索二叉树（Threaded Binary Trees）

- 目的：利用空的 `null` 链接（$n$ 个节点的二叉树有 $n+1$ 个 `null` 链接）
- **规则1**：若 `Tree->Left` 为 `null`，则指向中序前驱
- **规则2**：若 `Tree->Right` 为 `null`，则指向中序后继
- **规则3**：必须有头节点，头节点的左子指向第一个节点
- 优点：使遍历更容易
- 提出者：$A. J. Perlis$ 和 $C. Thornton$

---

### 六、二叉搜索树（Binary Search Tree）

#### 1. 定义
- 是一棵二叉树，可为空
- 非空时满足：
  1. 每个节点有一个整数键值，所有键值互异
  2. 左子树中所有键值小于根节点键值
  3. 右子树中所有键值大于根节点键值
  4. 左右子树也都是二叉搜索树

---

#### 2. ADT 操作

- `SearchTree MakeEmpty(SearchTree T)`
- `Position Find(ElementType X, SearchTree T)`
- `Position FindMin(SearchTree T)`
- `Position FindMax(SearchTree T)`
- `SearchTree Insert(ElementType X, SearchTree T)`
- `SearchTree Delete(ElementType X, SearchTree T)`
- `ElementType Retrieve(Position P)`

---

#### 3. 查找操作

##### 3.1 递归版本
```c
Position Find(ElementType X, SearchTree T) {
    if (T == NULL) return NULL;
    if (X < T->Element)
        return Find(X, T->Left);
    else if (X > T->Element)
        return Find(X, T->Right);
    else
        return T;
}
```
- 时间复杂度：$O(d)$，`d` 为 `X` 的深度

---

##### 3.2 迭代版本

```c
Position Iter_Find(ElementType X, SearchTree T) {
    while (T) {
        if (X == T->Element) return T;
        if (X < T->Element)
            T = T->Left;
        else
            T = T->Right;
    }
    return NULL;
}
```

---

##### 3.3 FindMin（递归）

```c
Position FindMin(SearchTree T) {
    if (T == NULL) return NULL;
    else if (T->Left == NULL) return T;
    else return FindMin(T->Left);
}
```

---

##### 3.4 FindMax（迭代）

```c
Position FindMax(SearchTree T) {
    if (T != NULL)
        while (T->Right != NULL)
            T = T->Right;
    return T;
}
```

---

#### 4. 插入操作

```c
SearchTree Insert(ElementType X, SearchTree T) {
    if (T == NULL) {
        T = malloc(sizeof(struct TreeNode));
        if (T == NULL) FatalError("Out of space!!!");
        else {
            T->Element = X;
            T->Left = T->Right = NULL;
        }
    } else if (X < T->Element)
        T->Left = Insert(X, T->Left);
    else if (X > T->Element)
        T->Right = Insert(X, T->Right);
    // 若X已存在，不做任何操作
    return T;
}
```
- 时间复杂度：$O(d)$

---

#### 5. 删除操作

- **删除叶子节点**：将父节点对应指针设为 `NULL`
- **删除度为1的节点**：用该节点的唯一子节点替换它
- **删除度为2的节点**：
  1. 用左子树中最大节点或右子树中最小节点替换该节点
  2. 删除替换节点（从相应子树中）

```c
SearchTree Delete(ElementType X, SearchTree T) {
    Position TmpCell;
    if (T == NULL) Error("Element not found");
    else if (X < T->Element)
        T->Left = Delete(X, T->Left);
    else if (X > T->Element)
        T->Right = Delete(X, T->Right);
    else {
        if (T->Left && T->Right) {
            TmpCell = FindMin(T->Right);
            T->Element = TmpCell->Element;
            T->Right = Delete(T->Element, T->Right);
        } else {
            TmpCell = T;
            if (T->Left == NULL) T = T->Right;
            else if (T->Right == NULL) T = T->Left;
            free(TmpCell);
        }
    }
    return T;
}
```
- 时间复杂度：$O(h)$，$h$ 为树的高度

---

#### 6. 懒惰删除（Lazy Deletion）

- 为每个节点添加标志位，标记是否被删除
- 若被删除节点再次插入，无需调用 `malloc`
- 缺点：大量删除节点可能影响操作效率

---

#### 7. 平均情况分析

- 树的高度取决于插入顺序
- 示例：元素 1,2,3,4,5,6,7（单节点树高度为 0）
  - 按 4,2,1,3,6,5,7 插入：高度 = 2
  - 按 1,2,3,4,5,6,7 插入：高度 = 6（倾斜树）

---

### 七、优先队列（堆）

#### 1. ADT定义
- **对象**：有零个或多个元素的有序列表
- 下标：
  - 第 $m$ 个孩子：$k·(i-1)+1+m$
  - 父节点：$⌊\frac{i+k-2}{k}⌋$
- **操作**：
  - `PriorityQueue Initialize(int MaxElements)`
  - `void Insert(ElementType X, PriorityQueue H)`
  - `ElementType DeleteMin(PriorityQueue H)`（删除优先级最高的元素）
  - `ElementType FindMin(PriorityQueue H)`

---

#### 2. 简单实现方式比较

|  实现方式  |    插入    |  删除最小  |
| :--------: | :--------: | :--------: |
|  无序数组  |   $Θ(1)$   |   $O(n)$   |
|  无序链表  |   $Θ(1)$   |   $Θ(n)$   |
|  有序数组  |   $O(n)$   |   $Θ(1)$   |
|  有序链表  |   $O(n)$   |   $Θ(1)$   |
| 二叉搜索树 | $O(log N)$ | $O(log N)$ |

- 缺点：BST有额外指针开销，且删除总是发生在左子树

---

#### 3. 二叉堆（Binary Heap）

##### 3.1 结构性质
- **完全二叉树**：高度为 $h$ 的二叉树，节点对应完美二叉树中编号1到n的节点
- 完全二叉树节点数范围：$2^h$ 到 $2^{h+1} - 1$
- **数组表示**：`BT[n+1]`，`BT[0]`不使用
- **索引关系**（$1 ≤ i ≤ n$）：
  - 左子：$2i$
  - 右子：$2i + 1$
  - 父：$⌊i/2⌋$

---

##### 3.2 初始化

```c
PriorityQueue Initialize(int MaxElements) {
    PriorityQueue H;
    if (MaxElements < MinPQSize) return Error("Priority queue size is too small");
    H = malloc(sizeof(struct HeapStruct));
    if (H == NULL) return FatalError("Out of space!!!");
    H->Elements = malloc((MaxElements + 1) * sizeof(ElementType));
    if (H->Elements == NULL) return FatalError("Out of space!!!");
    H->Capacity = MaxElements;
    H->Size = 0;
    H->Elements[0] = MinData;  // 哨兵
    return H;
}
```

---

##### 3.3 堆序性质

- **最小堆**：每个节点的键值不大于其子节点的键值
- **最大堆**：每个节点的键值不小于其子节点的键值

#### 4. 基本堆操作

##### 4.1 插入（上滤）
```c
void Insert(ElementType X, PriorityQueue H) {
    int i;
    if (IsFull(H)) { Error("Priority queue is full"); return; }
    for (i = ++H->Size; H->Elements[i/2] > X; i /= 2)
        H->Elements[i] = H->Elements[i/2];
    H->Elements[i] = X;
}
```
- 时间复杂度：$O(log N)$
- `H->Elements[0]`作为哨兵，值不大于堆中最小值

---

##### 4.2 删除最小（下滤）

```c
ElementType DeleteMin(PriorityQueue H) {
    int i, Child;
    ElementType MinElement, LastElement;
    if (IsEmpty(H)) { Error("Priority queue is empty"); return H->Elements[0]; }
    MinElement = H->Elements[1];
    LastElement = H->Elements[H->Size--];
    for (i = 1; i * 2 <= H->Size; i = Child) {
        Child = i * 2;
        if (Child != H->Size && H->Elements[Child+1] < H->Elements[Child])
            Child++;
        if (LastElement > H->Elements[Child])
            H->Elements[i] = H->Elements[Child];
        else
            break;
    }
    H->Elements[i] = LastElement;
    return MinElement;
}
```
- 时间复杂度：$O(log N)$

---

#### 5. 其他堆操作

- `DecreaseKey(P, Δ, H)`：降低位置 `P` 处的键值，上滤（提高优先级）

- `IncreaseKey(P, Δ, H)`：增加位置 `P` 处的键值，下滤（降低优先级）
- `Delete(P, H)`：删除位置 `P` 处的节点 = `DecreaseKey(P, ∞, H)` + `DeleteMin(H)`
- `BuildHeap(H)`：将 `N` 个输入键值构建成堆

---

#### 6. 构建堆（BuildHeap）

- 从最后一个非叶子节点开始，对每个节点执行下滤
- 示例：150, 80, 40, 30, 10, 70, 110, 100, 20, 90, 60, 50, 120, 140, 130
- **定理**：对高度为 $h$ 的完美二叉树（$2^{h+1} - 1$个节点），所有节点的总高度为 $2^{h+1} - 1 - (h+1)$
- 构建堆的时间复杂度：$O(N)$
- 解析：本质上就是对于给定的数组进行元素的调换位置，使得其满足最大堆 / 最小堆的要求，最后得到的数组实际上是一个层序的遍历

---

#### 7. 应用：找第 k 大的元素

- 多种方法及其复杂度

| 方法               | 平均时间复杂度 | 最坏时间复杂度 | 空间复杂度 | 是否原地 |
|:-------------------:|:--------------:|:--------------:|:-----------:|:---------:|
| 最小堆（大小 $k$）    | $O(n log k) $  |$ O(n log k) $  |$ O(k)  $    | 否      |
| 最大堆（大小 $n$）    |$ O(n + k log n)$| $O(n + k log n)$| $O(n)$     | 否（可原地建堆）||
| 快速选择           |$ O(n)  $       |$ O(n²)    $    |$ O(1)   $   | 是      |
| 排序法（快排/堆排）|$ O(n log n)$   | $O(n log n) $  | $O(log n) \sim O(n)$| 视算法 |
| 计数排序（范围 R） | $O(n + R)  $   |$ O(n + R)  $   |$ O(R)  $    | 否      |

---

#### 8. d-堆（d-Heaps）

- 每个节点有 $d$ 个子节点
- `DeleteMin` 需要 $d-1$ 次比较找最小子节点，时间复杂度：$O(d log_d N)$
- $d=2$ 时乘除 $2$ 可用位运算
- 当堆太大无法完全放入内存时，d-堆更有优势

---

### 八、线段树（Segment Tree）

#### 1. 动机
- 问题：需要频繁计算任意范围 $[L, R]$ 的和
- 简单方法：循环求和，时间复杂度 $O(N)$ → 对于频繁操作不可接受

---

#### 2. 结构

- 完全二叉树
- 每个节点存储对应区间内的聚合值（如和）
- 可存储在数组中：空间复杂度 $O(2N - 1)$

---

#### 3. 构建（Build）

```c
void Build(int node, int start, int end) {
    if (start == end) {
        tree[node] = A[start];
        return;
    }
    int mid = (start + end) / 2;
    Build(2 * node, start, mid);
    Build(2 * node + 1, mid + 1, end);
    tree[node] = tree[2 * node] + tree[2 * node + 1];
}
```
- 时间复杂度：$O(N)$（只运行一次）

---

#### 4. 查询（Query）

```c
int Query(int node, int start, int end, int L, int R) {
    if (R < start || end < L) return 0;           // 无重叠
    if (L <= start && end <= R) return tree[node]; // 完全重叠
    int mid = (start + end) / 2;
    int left_sum = Query(2 * node, start, mid, L, R);
    int right_sum = Query(2 * node + 1, mid + 1, end, L, R);
    return left_sum + right_sum;
}
```
- 时间复杂度：$O(log N)$

---

#### 5. 更新（Update）

```c
void Update(int node, int start, int end, int idx, int val) {
    if (start == end) {
        tree[node] = val;
        return;
    }
    int mid = (start + end) / 2;
    if (start <= idx && idx <= mid)
        Update(2 * node, start, mid, idx, val);
    else
        Update(2 * node + 1, mid + 1, end, idx, val);
    tree[node] = tree[2 * node] + tree[2 * node + 1];
}
```
- 时间复杂度：$O(log N)$

---

#### 6. 备注

- 不限于求和，适用于任何范围聚合操作（min、max、average等）
- 对于范围更新（如区间加常数），需要懒惰传播（lazy propagation）策略

---

### 九、图（Graph）与拓扑排序

#### 1. 图的基本定义
- **图 `G(V, E)`**：`V` 是有限非空顶点集，`E` 是有限边集
- **无向图**：边 `(v_i, v_j) = (v_j, v_i)`
- **限制**：不允许自环，不考虑多重图
- **完全图**：具有最大可能边数的图
- **子图 `G'`**：$V(G') ⊆ V(G)$ 且 $E(G') ⊆ E(G)$
- **路径**：从 `v_p`到 `v_q` 的顶点序列，相邻顶点间有边
- **路径长度**：路径上的边数
- **简单路径**：顶点不重复（除首尾可能相同）
- **环（Cycle）**：`v_p = v_q` 的简单路径

---

#### 2. 连通性

- **连通**：无向图中两个顶点之间存在路径
- **连通图**：任意两个不同顶点都连通
- **连通分量**：最大连通子图
- **树**：连通且无环的图

---

#### 3. 有向图

- **强连通**：任意两个顶点之间存在双向有向路径
- **弱连通**：忽略方向后连通
- **强连通分量**：最大强连通子图
- **DAG**：有向无环图

---

#### 4. 度

- **度(deg(v))**：与v关联的边数
- **入度(in-degree)**：指向v的边数
- **出度(out-degree)**：从v出发的边数
- **握手定理**：无向图中，所有顶点度数之和等于边数的两倍

---

#### 5. 图的表示方法

##### 5.1 邻接矩阵（Adjacency Matrix）
- 定义：`adj_mat[n][n]`
- 无向图矩阵对称，可只存一半
- 一维存储：`adj_mat[n(n+1)/2]`，$a_{ij}$ 的索引为 $i*(i-1)/2 + j$
- 时间与空间复杂度：$O(n²)$

---

##### 5.2 邻接表（Adjacency List）

- 每行用一个链表表示
- 无向图：n个头节点 + 2e个节点，存储量 = (n+2e)个指针 + 2e个整数
- 求度：度(i) = graph[i]中的节点数
- 时间复杂度：O(n+e)

---

##### 5.3 逆向邻接表

- 用于求有向图的入度

---

##### 5.4 邻接多重表（Adjacency Multilists）

- 将无向图中的两个方向节点合并为一个
- 优点：便于标记已检查的边并找到下一条边

---

##### 5.5 带权边

- 邻接矩阵：adj_mat[i][j] = 权值
- 邻接表/多重表：节点增加权值字段

---

#### 6. 拓扑排序

##### 6.1 概念
- **前驱**：存在从i到j的路径
- **直接前驱**：存在边<i, j>
- **后继/直接后继**：对称定义
- **偏序**：传递且反自反的优先关系
- **可行AOV网络**：必须是DAG（不可有环）

---

##### 6.2 定义

- **拓扑序**：顶点的线性排序，若i是j的前驱，则i在j之前

---

##### 6.3 简单算法（O(|V|²)）

```c
void Topsort(Graph G) {
    int Counter;
    Vertex V, W;
    for (Counter = 0; Counter < NumVertex; Counter++) {
        V = FindNewVertexOfDegreeZero();  // O(|V|)
        if (V == NotAVertex) { Error("Graph has a cycle"); break; }
        TopNum[V] = Counter;
        for (each W adjacent to V)
            Indegree[W]--;
    }
}
```

---

##### 6.4 改进算法（O(|V|+|E|)）

- 使用队列存放所有入度为0的顶点

```c
void Topsort(Graph G) {
    Queue Q;
    int Counter = 0;
    Vertex V, W;
    Q = CreateQueue(NumVertex); MakeEmpty(Q);
    for (each vertex V)
        if (Indegree[V] == 0) Enqueue(V, Q);
    while (!IsEmpty(Q)) {
        V = Dequeue(Q);
        TopNum[V] = ++Counter;
        for (each W adjacent to V)
            if (--Indegree[W] == 0) Enqueue(W, Q);
    }
    if (Counter != NumVertex) Error("Graph has a cycle");
    DisposeQueue(Q);
}
```

---

### 十、并查集（Disjoint Set）

#### 1. 等价关系
- **关系R**：定义在集合S上，对任意(a,b)，aRb为真或假
- **等价关系**：满足自反性、对称性、传递性
- **等价类**：所有满足 x ~ y 的元素构成的集合

---

#### 2. 动态等价问题

- 示例：给定S={1,...,12}和9个等价关系，求等价类
- 算法：
  1. 读入关系，若Find(a) ≠ Find(b)则Union
  2. 回答查询：若Find(a)=Find(b)则true

---

#### 3. 基本数据结构

- 元素编号1~N，可用作数组索引
- 森林表示：子节点指向父节点
- 数组 `S[element]` = 父节点索引，根节点 `S[root]` = 0

---

##### 3.1 Union操作

```c
// 将S2的根指向S1的根
S[root2] = root1;
```

---

##### 3.2 Find操作

```c
int Find(ElementType X, DisjSet S) {
    if (S[X] <= 0) return X;
    else return Find(S[X], S);
}
```

---

##### 3.3 最坏情况

- 连续Union：union(2,1), union(3,2), ..., union(N,N-1)后，Find(1)需O(N)

---

#### 4. 智能合并算法

##### 4.1 按大小合并（Union-by-Size）
- 总是将小树合并到大树
- 数组 `S[root] = -size`（初始化为-1）
- **引理**：按大小合并的 $N$ 个节点的树，任意节点深度 $≤ log_2 N$
- 时间复杂度：$N$ 次 `Union` + $M$ 次 `Find` = $O(N + M log N)$
- 两棵树高度相等，合并之后高度才会 + $1$

---

##### 4.2 按高度合并（Union-by-Height）

- 总是将浅树合并到深树
- 注意：与路径压缩不兼容（路径压缩会改变高度）
- 两棵树高度相等，合并之后高度才会 + $1$

---

#### 5. 路径压缩（Path Compression）

##### 5.1 递归版本
```c
SetType Find(ElementType X, DisjSet S) {
    if (S[X] <= 0) return X;
    else return S[X] = Find(S[X], S);
}
```

---

##### 5.2 迭代版本

```c
SetType Find(ElementType X, DisjSet S) {
    ElementType root, trail, lead;
    for (root = X; S[root] > 0; root = S[root]);
    for (trail = X; trail != root; trail = lead) {
        lead = S[trail];
        S[trail] = root;
    }
    return root;
}
```
- 特点：单个 `Find` 变慢，但序列 `Find` 总时间更快
- 与按高度合并不兼容，改用“按秩合并”

---

#### 6. 最坏情况分析（Tarjan引理）

- 处理 $M≥N$ 次 `Find` 和 $N-1$ 次 `Union` 的最大时间 $T(M,N)$满足：
  - $k_1·M·α(M,N) ≤ T(M,N) ≤ k_2·M·α(M,N)$
- **Ackermann函数** 及其逆函数 `α(M,N)` $≤ log* N ≤ 4$
  - $log* N =$ 对 $N$ 反复取对数直到结果 $≤1$ 的次数
  - 示例：$log* 2^{65536} = 5$，因为 $logloglogloglog(2^{65536})=1$

---

### 十一、插入排序 (Insertion Sort)

#### 11.1 基本思想
插入排序将数组分为已排序部分和未排序部分，每次从未排序部分取出一个元素，插入到已排序部分的适当位置。

---

#### 11.2 算法实现
```c
void InsertionSort(ElementType A[], int N) {
    int j, P;
    ElementType Tmp;
    for (P = 1; P < N; P++) {
        Tmp = A[P];                     // 待插入元素
        for (j = P; j > 0 && A[j-1] > Tmp; j--)
            A[j] = A[j-1];              // 向后移动元素
        A[j] = Tmp;                     // 插入正确位置
    }
}
```

---

#### 11.3 复杂度分析

- **最坏情况**（逆序）：$T(N) = O(N^2)$
- **最好情况**（已有序）：$T(N) = O(N)$
- **平均情况**：$O(N^2)$

---

#### 11.4 逆序与下界

- **逆序**：满足 $i < j$ 且 $A[i] > A[j]$ 的有序对 $(i, j)$。插入排序每次交换相邻元素恰好消除一个逆序。
- **定理**：任意只交换相邻元素的排序算法平均时间复杂度为 $Ω(N^2)$。

---

### 十二、希尔排序 (Shellsort)

#### 12.1 基本思想
希尔排序通过比较相距一定间隔的元素来工作，每趟排序使用逐渐减小的间隔（增量），最后一趟间隔为1（即普通插入排序）。增量序列的选取直接影响性能。

---

#### 12.2 Shell 原始增量序列

增量序列：$h_t = ⌊N/2⌋$, $h_k = ⌊h_{k+1}/2⌋$

```c
void Shellsort(ElementType A[], int N) {
    int i, j, Increment;
    ElementType Tmp;
    for (Increment = N/2; Increment > 0; Increment /= 2) {
        for (i = Increment; i < N; i++) {
            Tmp = A[i];
            for (j = i; j >= Increment; j -= Increment) {
                if (Tmp < A[j - Increment])
                    A[j] = A[j - Increment];
                else
                    break;
            }
            A[j] = Tmp;
        }
    }
}
```

---

#### 12.3 增量序列与性能

- **Shell 增量**：最坏情况 $Θ(N^2)$
- **Hibbard 增量**：$h_k = 2^k - 1$，最坏情况 $Θ(N^{\frac{3}{2}})$，平均 $O(N^{\frac{5}{4}})$
- **Sedgewick 增量**：{$1, 5, 19, 41, 109, …$}，最坏 $O(N^{\frac{4}{3}})$，平均 $O(N^{\frac{7}{6}})$

希尔排序适用于中等规模输入（数万个元素）。

---

### 十三、堆排序 (Heapsort)

#### 13.1 算法思想
利用最大堆（或最小堆）性质，先建堆，然后反复取出堆顶元素并调整剩余元素成为新堆。

---

#### 13.2 原地堆排序（不使用额外数组）

```c
void PercDown(ElementType A[], int i, int N) {
    /* 下滤操作，将A[i]向下调整 */
    int Child;
    ElementType Tmp;
    for (Tmp = A[i]; 2*i+1 < N; i = Child) {
        Child = 2*i + 1;                 // 左孩子
        if (Child != N-1 && A[Child+1] > A[Child])
            Child++;                     // 右孩子更大
        if (Tmp < A[Child])
            A[i] = A[Child];
        else
            break;
    }
    A[i] = Tmp;
}

void Heapsort(ElementType A[], int N) {
    int i;
    // 建堆：从最后一个非叶子节点开始下滤
    for (i = N/2 - 1; i >= 0; i--)
        PercDown(A, i, N);
    // 依次取出最大值
    for (i = N-1; i > 0; i--) {
        Swap(&A[0], &A[i]);              // 将堆顶放到末尾
        PercDown(A, 0, i);               // 调整剩余部分为堆
    }
}
```

---

#### 13.3 复杂度

- 建堆：$O(N)$
- 每次删除最大：$O(log N)$，共 $N$ 次
- 总时间：$O(N log N)$
- 额外空间：$O(1)$

---

#### 13.4 性能特点

虽然堆排序平均比较次数为 $2N log N - O(N log log N)$，但在实际中比使用 Sedgewick 增量的希尔排序要慢。

---

### 十四、归并排序 (Mergesort)

#### 14.1 合并两个有序表
```c
void Merge(ElementType A[], ElementType TmpArray[],
           int Lpos, int Rpos, int RightEnd) {
    int i, LeftEnd, NumElements, TmpPos;
    LeftEnd = Rpos - 1;
    TmpPos = Lpos;
    NumElements = RightEnd - Lpos + 1;
    
    while (Lpos <= LeftEnd && Rpos <= RightEnd) {
        if (A[Lpos] <= A[Rpos])
            TmpArray[TmpPos++] = A[Lpos++];
        else
            TmpArray[TmpPos++] = A[Rpos++];
    }
    while (Lpos <= LeftEnd)
        TmpArray[TmpPos++] = A[Lpos++];
    while (Rpos <= RightEnd)
        TmpArray[TmpPos++] = A[Rpos++];
    // 拷贝回原数组
    for (i = 0; i < NumElements; i++, RightEnd--)
        A[RightEnd] = TmpArray[RightEnd];
}
```

---

#### 14.2 递归实现

```c
void MSort(ElementType A[], ElementType TmpArray[],
           int Left, int Right) {
    int Center;
    if (Left < Right) {
        Center = (Left + Right) / 2;
        MSort(A, TmpArray, Left, Center);
        MSort(A, TmpArray, Center+1, Right);
        Merge(A, TmpArray, Left, Center+1, Right);
    }
}

void Mergesort(ElementType A[], int N) {
    ElementType *TmpArray = malloc(N * sizeof(ElementType));
    if (TmpArray != NULL) {
        MSort(A, TmpArray, 0, N-1);
        free(TmpArray);
    }
}
```

---

#### 14.3 复杂度分析

- 递推式：$T(N) = 2T(N/2) + O(N)$
- 解：$T(N) = O(N log N)$
- 额外空间：$O(N)$（临时数组）

归并排序需要线性额外内存，主要用于外部排序。

---

### 十五、快速排序 (Quicksort)

#### 15.1 基本算法
```c
void Quicksort(ElementType A[], int N) {
    if (N < 2) return;
    pivot = 选取枢纽元;
    将A划分为 A1 = {a ≤ pivot}, A2 = {a ≥ pivot};
    A = Quicksort(A1, N1) ∪ {pivot} ∪ Quicksort(A2, N2);
}
```

---

#### 15.2 枢纽元选择

- **错误方法**：直接取A[0]（已有序时退化为O(N²)）
- **安全方法**：随机选择（随机数生成开销大）
- **三数中值分割法**：取左端、右端和中心位置的中值。可消除已有序的坏情形，并减少约5%的运行时间。

```c
ElementType Median3(ElementType A[], int Left, int Right) {
    int Center = (Left + Right) / 2;
    if (A[Left] > A[Center]) Swap(&A[Left], &A[Center]);
    if (A[Left] > A[Right])  Swap(&A[Left], &A[Right]);
    if (A[Center] > A[Right]) Swap(&A[Center], &A[Right]);
    // 将枢纽元藏到Right-1位置
    Swap(&A[Center], &A[Right-1]);
    return A[Right-1];
}
```

---

#### 15.3 分割策略

- 使用 `i` 和 `j` 分别从左、右扫描
- `i` 遇到大于等于 `pivot` 的元素停止，`j` 遇到小于等于 `pivot` 的元素停止
- 当 `i < j` 时交换，继续扫描
- 处理等于 `pivot` 的关键字：若 `i` 和 `j` 都停止，则交换；若不停（只移动一方），则会导致最坏情况 $O(N^2)$

---

#### 15.4 小数组优化

对于 $N ≤ 20$，快速排序不如插入排序快，因此设置截止点（如 $N=10$）转而使用插入排序。

---

#### 15.5 完整实现

```c
void Qsort(ElementType A[], int Left, int Right) {
    int i, j;
    ElementType Pivot;
    if (Left + Cutoff <= Right) {
        Pivot = Median3(A, Left, Right);
        i = Left; j = Right - 1;
        for (;;) {
            while (A[++i] < Pivot) {}
            while (A[--j] > Pivot) {}
            if (i < j)
                Swap(&A[i], &A[j]);
            else
                break;
        }
        Swap(&A[i], &A[Right-1]);   // 恢复枢纽元
        Qsort(A, Left, i-1);
        Qsort(A, i+1, Right);
    } else {
        InsertionSort(A + Left, Right - Left + 1);
    }
}

void Quicksort(ElementType A[], int N) {
    Qsort(A, 0, N-1);
}
```

---

#### 15.6 复杂度分析

- 最坏情况：$T(N) = O(N^2)$
- 最好情况：$T(N) = O(N log N)$
- 平均情况：$T(N) = O(N log N)$

---

### 十六、表排序 (间接排序)

#### 16.1 问题背景
当待排序元素是大型结构时，直接交换结构开销巨大。解决方案：使用指针数组（或索引表）进行间接排序。

---

#### 16.2 算法步骤

1. 创建一个指针（或索引）数组 `table`，初始 `table[i] = i`
2. 根据关键码对指针数组排序（交换指针而非结构本身）
3. 最终物理重排（若必要）：利用循环分解

```c
// 指针比较函数示例（qsort风格）
int compare(const void *a, const void *b) {
    int ia = *(int*)a, ib = *(int*)b;
    return key[ia] - key[ib];
}
```

---

#### 16.3 物理重排

每个置换由若干个互不相交的环组成。对每个环进行循环移动，最坏情况下需要 $⌊N/2⌋$ 个环，移动次数 $≤ ⌊3N/2⌋$。

---

### 十七、排序下界

#### 17.1 比较排序的决策树模型
- 对 $N$ 个不同元素排序，有 $N!$ 种可能结果
- 决策树至少需要 $N!$ 个叶子
- 树高至少为 $⌈log_2(N!)⌉$

---

#### 17.2 下界结论

- 由斯特林公式，$log_2(N!) = Θ(N log N)$
- 任何基于比较的排序算法最坏情况时间复杂度为 $Ω(N log N)$

---

### 十八、桶排序与基数排序

#### 18.1 桶排序 (Bucket Sort)
- **适用**：关键码范围较小（例如0~100）
- **算法**：创建 $M$ 个桶，遍历数据放入对应桶，然后按顺序输出
- **时间复杂度**：$T(N, M) = O(M + N)$
- **问题**：当 $M >> N$ 时空间浪费大

```c
// 成绩在0~100的桶排序示意
void BucketSort(Record A[], int N) {
    List buckets[101];
    for (int i = 0; i < N; i++)
        insert(buckets[A[i].grade], A[i]);
    for (int i = 0; i <= 100; i++)
        output(buckets[i]);
}
```

#### 18.2 基数排序 (Radix Sort)
- **LSD (Least Significant Digit First)**：从最低位到最高位依次进行稳定排序
- **MSD (Most Significant Digit First)**：先按最高位分桶，再递归排序每个桶
- **复杂度**：$O(P(N + B))$，其中 $P$ 为关键字位数，$B$ 为基数（桶数）

```c
// LSD基数排序（基于计数排序的稳定版本）
void RadixSort(int A[], int N, int maxDigits) {
    int B = 10;  // 十进制，桶数10
    for (int d = 0, exp = 1; d < maxDigits; d++, exp *= 10) {
        int count[B] = {0};
        int *output = malloc(N * sizeof(int));
        for (int i = 0; i < N; i++)
            count[(A[i] / exp) % B]++;
        for (int i = 1; i < B; i++)
            count[i] += count[i-1];
        for (int i = N-1; i >= 0; i--) {
            int digit = (A[i] / exp) % B;
            output[--count[digit]] = A[i];
        }
        for (int i = 0; i < N; i++)
            A[i] = output[i];
        free(output);
    }
}
```

---

### 十九、深度优先搜索 (DFS)

#### 19.1 基本框架
```c
void DFS(Vertex V) {
    visited[V] = true;
    for (each W adjacent to V)
        if (!visited[W])
            DFS(W);
}
// 时间复杂度：O(|E| + |V|)（使用邻接表）
```

---

#### 19.2 寻找连通分量

```c
void ListComponents(Graph G) {
    for (each V in G)
        if (!visited[V]) {
            DFS(V);
            printf("\n");   // 每个连通分量一行
        }
}
```

---

#### 19.3 双连通性 (Biconnectivity)

- **关节点 (Articulation Point)**：删除该顶点及其关联边后，图不再连通
- **双连通图**：连通且无关节点的图
- **双连通分量**：极大的双连通子图，边集被划分

---

#### 19.4 使用DFS找关节点

- DFS生成树，记录每个顶点的深度优先编号 $Num(v)$
- 定义 $Low(v) = min \{ Num(v)$, 所有回边能到达的最祖先的 $Num$, 所有孩子 $w$ 的 $Low(w) \}$
- **判定**：
  - 根节点：有 $≥ 2$ 个孩子则是关节点
  - 非根节点：存在孩子 $w$ 使得 $Low(w) ≥ Num(v)$

---

#### 19.5 欧拉回路 (Euler Circuit)

- **条件**：连通且每个顶点度数为偶数
- **欧拉路径**：恰有两个顶点度数为奇数，从其中一个奇数度顶点出发
- **算法**：使用 DFS 并维护路径链表，每条边仅遍历一次，时间复杂度 $O(|E| + |V|)$

---

### 二十、网络流问题 (Network Flow)

#### 20.1 基本概念
- 源点 $s$，汇点 $t$，每条边有容量
- 最大流：从 $s$ 到 $t$ 能输送的最大流量

---

#### 20.2 Ford-Fulkerson 算法（增广路径法）

```c
// 伪代码
int max_flow = 0;
while (存在从 s 到 t 的增广路径 path) {
    令 flow = path 上最小剩余容量；
    max_flow += flow;
    沿 path 正向边减少 flow，反向边增加 flow；
}
```

---

#### 20.3 增广路径选择策略

- **普通 BFS（Edmonds-Karp）**：每次找最短路径（边数最少），$T = O(|E|^2|V|)$
- **容量最大优先**：修改 **Dijkstra**，$T = O(|E|^2 log |V|)$
- **注意**：当容量为无理数时算法可能不终止；对于整数容量，算法一定终止

---

#### 20.4 最小费用最大流

每条边有单位流量成本，在所有最大流中找总成本最小的流。

---

### 二十一、最小生成树 (Minimum Spanning Tree)

#### 21.1 定义
- 生成树：包含所有顶点的树，边数为 $|V|-1$
- 最小生成树：边权和最小的生成树（当且仅当图连通时存在）

---

#### 21.2 Prim 算法

- 从任意顶点开始，逐步将离当前树最近的点加入
- 类似 `Dijkstra`，使用优先队列
```c
// 伪代码
void Prim(Graph G) {
    for (each v) { dist[v] = INF; parent[v] = -1; }
    dist[0] = 0;
    while (存在未加入树的顶点) {
        v = 未加入且dist最小的顶点;
        将v加入树;
        for (每个邻接点 w)
            if (!inTree[w] && cost(v,w) < dist[w]) {
                dist[w] = cost(v,w);
                parent[w] = v;
            }
    }
}
// 时间复杂度：O(|E| log |V|)（二叉堆）
```

---

#### 21.3 Kruskal 算法

- 将边按权重从小到大排序
- 依次取边，若加入后不形成环则保留（使用并查集检测环）
```c
void Kruskal(Graph G) {
    T = {};
    while (|T| < |V|-1 && 边集非空) {
        选择最小边 (v, w);
        if (Find(v) != Find(w)) { // 不形成环
            Union(v, w);
            将边加入T;
        }
    }
}
// 时间复杂度：O(|E| log |E|)（排序+并查集）
```

---

## <center>Part 3：网课补充内容</center>

### 一、复杂度

#### 1. 时间复杂度 
>时间复杂度并不是程序的实际运行时间。

---
##### (1) 定义 
- **大 $O$ 表示法（Big-O Notation）**
   - 若存在正的常数 $c$ and $n_0$ 使得对于所有的 $N \ge n_0$，都有：
    $T(N) \le c \cdot f(N)$
   - 则记为：
    $( T(N) = \mathcal{O}(f(N))$

---
- **大 $\Omega$ 表示法（Big-Omega Notation）**
  
   - 若存在正的常数 $c$ and $n_0$ 使得对于所有的 $N \ge n_0$，都有：
    $T(N) \ge c \cdot g(N) \quad$
   - 则记为：
    $T(N) = \Omega(g(N))$
   
---
- **大 $\Theta$ 表示法（Big-Theta Notation）**
   - 当且仅当： 
    $T(N) = \mathcal{O}(h(N))$ 且 $T(N) = \Omega(h(N))$
   - 记为：
    $T(N) = \Theta(h(N))$
   
---

- **小 $o$ 表示法（Little-o Notation）**
   - 若：
    $T(N) = \mathcal{O}(p(N))$ 
   - 且： 
    $T(N) \neq \Theta(p(N))$.
   - 则记为：
    $T(N) = o(p(N))$

---

**提示**

-   对于函数 $T(N)= 2N + 3$:
    $2N + 3 = \mathcal{O}(N)$
     - 取增长最慢的低阶项 $\mathcal{O}(N)$.
    
-   对于函数 $T(N)= 2^N + N^2$:
    $2^N + N^2 = \Omega(2^N)$
     - 取增长最快的高阶项 $\Omega(2^N)$.

---

##### (2) 例题
**例1** 
- [2022]以下程序的时间复杂度是多少？

```c
int sum=0;
for(int i=1;i<n;i*=2){
    for(int j=0;j<i;j++){
        sum++;
    }
}
```
- 答案：$O(n)$.

---
**例2** 
- 以下程序的时间复杂度是多少？

```c

```
答案：$$.

---
#### 2. 空间复杂度 

---

### 二、线性表 
#### 1. 顺序表 
>逻辑上相邻的元素，在物理逻辑上也存储在连续的位置。

---
##### (0) 结构
```c
#define MAXSIZE=100
typedef int ElemType;
typedef strcut{
    ElemType data[MAXSIZE];
    int lenth;
}SeqList;
```
---
##### (1) 初始化
```c
void initList(SeqList *L){
    L->length=0;
}
```
---
##### (2) 尾插法
```c
int appendElem(SeqList *L,ElemType e){
    if(L->length>=MAXSIZE){
        printf("SeqList is full.");
        return 0;
    }

    L->data[L->length]=e;
    L->length++;
    return 1;
}
```
---
##### (3) 遍历
```c
void listElem(SeqList *L){
    
    for(int i=0;i<L->length;i++){
        if(i!=0){
            printf(" ");
        }
        printf("%d",L->data[i]);
    }

    printf("\n");
}
```
---
##### (4) 插入元素
```c
int insertElem(SeqList *L,int pos,ElemType e){
    if(pos<=L->length){
        for(int i=L->length-1;i>=0;i--){
            L->data[i+1]=L->data[i];
        }
        L->data[pos-1]=e;
        L->length++;
    }
    return 1;   
}
```
---
##### (5) 删除元素
```c
int deleteElem(SeqList *L,int pos,ElemType *e){
    *e=L->data[pos-1];                //保存被删除的程序
    if(pos<L->length){
        for(int i=pos;i<L->length;i++){
            L->data[i-1]=L->data[i];
        }
    }
    L->length--;
    return 1;
}
```
---
##### (6) 查找元素
```c
int findElem(SeqList *L,ElemType e){

    for(int i=0;i<L->length;i++){
        if(L->data[i]==e){
            return i+1;
        }
    
    }
    return 0;
}
```
---
##### (7) 动态顺序表初始化
```c
SeqList *initList(){
    SeqList *L=(SeqList *)malloc(sizeof(SeqList));
    L->data=(ElemType *)malloc(sizeof(ElemType)*MAXSIZE);
    L->length=0;
    return L;
}
```
---
#### 2. 链表
##### (0) 结构
```c
typedef int ElemType

typedef struct node{
    ElemType data;
    struct node* next;
}Node;
```
---
##### (1) 初始化
```c
Node* InitList(){
    Node *head=(Node *)malloc(sizeof(Node));
    head->data=0;
    head->next=NULL;
    return head;
}

int main(){
    Node *list=InitList();
    return 1;
}
```
---
##### (2) 头插法
```c
int insertHead(Node *L,ElemType e){
    Node *p=(Node*)malloc(sizeof(Node));
    p->data=e;
    p->next=L->next;
    L->next=p;
}

int main(){
    Node *list=initList();
    insertHead(list,10);
    insertHead(list,20);
}
```
---
##### (3) 尾插法
```c
Node *Tailinsert(Node *L,ElemType e){
    Node *p=(Node *)malloc(sizeof(Node));
    p->data=e;
    p->next=NULL;

    if(L==NULL){
        return p;
    }

    Node *q=L;
    while(q->next!=NULL){
        q=q->next;
    }

    q->next=p;
    return L;
}
```
---
##### (4) 遍历
```c
void listNode(Node *L){
    Node* p=L->next;
    
    int first=1;
    while(p!=NULL){
        if(first==0){
            printf(" ");
        }else{
            printf("%d",p->data);
            first=0;
        }
        p=p->next;
    }

    printf("\n");
}
```
---
##### (5) 在特定位置插入元素
```c
int InsertAtPosition(Node *L,int pos,ElemType e){
    Node* p=L;
    int i=0;

    while(i<pos-1){
        p=p->next;
        i++;
        if(p==NULL){
            return 0;
        }
    }

    Node *q=(Node *)malloc(sizeof(Node));
    q->data=e;
    q->next=p->next;
    p->next=q;

    return 1;
}
```
---
##### (6) 删除节点
```c
int DeleteNode(Node *L,int pos){
    Node *p=L;
    int i=0;

    while(i<pos-1){
        p=p->next;
        i++;
        if(p==NULL){
            return 0;
        }
    }

    if(p->next==NULL){
        return 0;
    }

    Node *q=p->next;
    p->next=q->next;
    free(q);
    return 1;
}
```
---
##### (7) 获取长度
```c
int ListLength(Node *L){
    Node *p=L;
    int len=0;

    while(p!=NULL){
        p=p->next;
        len++;
    }

    return len;
}
```
---
##### (8) 释放链表
```c
void FreeList(Node* L){
    Node* p=L->next;
    Node* q;

    while(p!=NULL){
        q=p->next;
        free(p);
        p=q;
    }

    L->next=NULL;
}
```
---
##### (9) 删除相同元素的节点
```c
void removeNode(Node *L,int n){
    Node *p=L;
    int index;
    int *q=(int *)malloc(sizeof(int)*(n+1));

    for(int i=0;i<n+1;i++){
        *(q+i)=0;
    }

    while(p->next!=NULL){
        index=abs(p->next->data);  /*Remember to add "#include<stdlib.h>"*/

        if(*(q+index)==0){
            *(q+index)=1;
            p=p->next;
        }else{
            Node *temp=p->next;
            p->next=temp->next;
            free(temp);
        }

    }

    free(q);
}
```
---
##### (10) 反转链表
```c
Node *reverseList(Node *head){
    Node *first=NULL;
    Node *second=head->next;
    Node *third;

    while(second!=NULL){
        third=second->next;
        second->next=first;
        first=second;
        second=third;
    }

    Node *hd=initList();  /*Create a new node.*/
    hd->next=first;

    return hd;
}
```
---
##### (11) 链表是否有环
```c
int isCycle(Node *head){

    Node *fsat=head;
    Node *slow=head;

    while(fast!=NULL&&fast->next!=NULL){
        fast=fast->next->next;
        slow=slow->next;

        if(fast==slow){
            return 1;
        }
    }

    return 0;
}
```
---
##### (12) 找出链表的环的入口
 ```c
Node *findBegin(Node *head){
    Node *fast=head;
    Node *slow=head;

    while(fast!=NULL&&fast->next!=NULL){
        
        fast=fast->next->next;
        slow=slow->next;

        if(fast==slow){

            Node *p=fast;
            int cnt=1;

            while(p->next!=slow){
                cnt++;
                p=p->next;
            }

            fast=head;
            slow=head;

            for(int i=0;i<cnt;i++){
                fast=fast->next;
            }

            while(fast!=slow){
                fast=fast->next;
                slow=slow->next;
            }

            return slow;
        }
    }

    return NULL;
}
 ```

---
#### 3. 双向链表 
##### (0) 结构
```c
typedef int ElemType;

typedef struct node{
    ElemType data;
    struct node *prev,*next;
}Node;
```
---
##### (1) 头插法
```c
int insertHead(Node *L,ElemType e){
    Node *p=(Node*)malloc(sizeof(Node));
    p-data=e;
    p->prev=L;
    p->next=L->next;
    if(L->next!=NULL){
        L->next->prev=p;
    }
    L-next=p;
    return 1;
}
```
---
##### (2) 尾插法
```c
Node *insertTail(Node *tail,ElemType e){
    Node *p=(Node*)malloc(sizeof(Node));
    p->data=e;
    p->prev=tail;
    tail->next=p;
    p->next=NULL;
    return p; 
}
```
---
##### (3) 在特定位置插入元素
```c
int insertNode(Node *L,int pos,ElemType e){
    Node *p=L;
    int i=0;
    while(i<pos-1){
        p=p->next;
        i++;
        if(p==NULL){
            return 0;
        }
    }
    Node *q=(Node*)malloc(sizeof(Node));
    q->data=e;
    q->prev=p;
    q->next=p->next;
    p->next->prev=q;
    p->next=q;
    return 1;
}
```
---
##### (4) 删除节点
```c
int deleteNode(Node *L,int pos){
    Node *p=L;
    int i=0;
    while(i<pos-1){
        p=p->next;
        i++;
        if(p==NULL){
            return 0;
        }
    }
    if(p->next==NULL){
        return 0;
    }
    Node *q=p->next;
    p->next=q->next;
    q->next->prev=p;
    free(q);
    return 1;
}
```

---
#### 4. 双指针
##### (1) 用双指针找到倒数第$K$个元素
```c
int findNodeFS(Node *L,int k){
    Node *fast=L->next;
    Node *slow=L->next;

    for(int i=0;i<k;i++){
        fast=fast->next;
    }

    while(fast!=NULL){
        fast=fast->next;
        slow=slow->next;
    }

    printf("%d\n",slow->data);
}
```
---
##### (2) 查找公共存储的起始位置
```c
Node *findIntersectionNode(Node *headA,Node *headB){
    if(headA==NULL||headB==NULL){
        return NULL;
    }

    int lenA=0;
    int lenB=0;
    
    Node* p=headA;
    while(p!=NULL){
        lenA++;
    }

    Node* q=headB;
    while(q!=NULL){
        lenB++;
    }

    int delta;
    Node *fast;
    Node *slow;
    if(lenA>lenB){
        delta=lenA-lenB;
        fast=headA;
        slow=headB;
    }else{
        delta=lenB-lenA;
        fast=headB;
        slow=headA;
    }

    for(int i=0;i<delta;i++){
        fast=fast->next;
    }

    while(fast!=slow){
        fast=fast->next;
        slow=slow->next;
    }

    return fast;     /*写"return slow"也是可以的*/
}
```
---
##### (3) 删除中间节点
```c
int deleteMiddleNode(Node *head){
    Node *first=head->next;
    Node *slow=head;

    while(fast!=NULL&&fast->next!=NULL){
        fast=fast->next->next;
        slow=slow->next;
    }

    Node *q=slow->next;
    slow->next=q->next;
    free(q);

    return 1;
}
```
---
#### 5. 中间节点 
##### (1) 重排链表
```c
void reOrderList(Node *head){
    Node *fast=head->next;
    Node *slow=head;

    while(fast!=NULL&&fast->next!=NULL){
        fast=fast->next->next;
        slow=slow->next;
    }

    Node *first=NULL;
    Node *second=slow->next;
    slow->next=NULL;
    Node *third=NULL;

    while(second!=NULL){
        third=second->next;
        second->next=first;
        first=second;
        second=fist;
    }

    Node *p1=head->next;
    Node *q1=first;
    Node *p2,*q2;

    while(p1!=NULL&&q1!=NULL){
        p2=p1->next;
        q2=q1->next;

        p1->next=q1;
        q1->next=p2;

        p1=p2;
        q1=q2;
    }

}
```
---
### 三、栈和队列 
#### 1. 顺序栈 
##### (0) 结构
```c
#define MAXNSIZE = 100
typedef int ElemType;

typedef struct{
    ElemType data[MAXNSIZE];
    int top;
}Stack;
```
---
##### (1) 初始化
```c
void initStack(Stack *s){
    s->top=-1;
}
```
---
##### (2) 检查栈是否为空
```c
int isEmpty(Stack *s){
    if(s->top==-1){
        printf("Empty!");
        return 1;
    }else{
        return 0;
    }
}
```
---
##### (3) 入栈
```c
int push(Stack *s,ElemType e){
    if(s->top>=MAXNSIZE-1){
        printf("Full!");
        return 0;
    }
    s->top++;
    s->data[s->top]=e;
    return 1;
}
```
---
##### (4) 出栈
```c
ElemType pop(Stack *s,ElemType *e){
    if(t->top==-1){
        printf("Empty!");
        return 0;
    }
    *e=s->data[s->top];
    s->top--;
    return 1;
}
```
---
##### (5) 获取栈顶元素
```c
int getTop(Stack *s,ElemType *e){
    if(s->top==1){
        printf("Empty!");
        return 0;
    }
    *e=s->data[s->top];
    return 1;
}
```
---
##### (6) 动态内存分配
```c
Stack *initStack(){
    Stack *s=(Stack*)malloc(sizeof(Stack));
    s->data=(ElemType*)malloc(MAXNSZIE*sizeof(ElemType));
    s->top=-1;
    return s;
}
```
---
#### 2. 链式栈 
##### (0) 结构
```c
typedef int ElemType;

typedef struct stack{
    ElemType data;
    struct stack *next;
}Stack;
```
---
##### (1) 初始化 
```c
Stack *initStack(){
    Stack *s=(Stack*)malloc(sizeof(Stack));
    s->data=0;
    s->naet=NULL;
    return s;
}
```
---
##### (2) 检查栈是否为空
```c
int isEmpty(Stack *s){
    if(s->next==NULL){
        printf("Empty!");
        return 1;
    }else{
        return 0;
    }
}
```
---
##### (3) 入栈
```c
int push(Stack *s,ElemType e){
    Stack *p=(Stack*)mallic(sizeof(Stack));
    p->data=e;
    p->next=s->next;
    s->next=p;
    return 1;
}
```
---
##### (4) 出栈
```c
int pop(Stack *s,ElemType *e){
    if(s->next=NULL){
        printf("Empty!");
        return 0;
    }
    *e=s->next->data;
    Stack *q=s->next;
    s->next=q->next;
    free(q);
    return 1;
}
```
---
##### (5) 获取栈顶元素
```c
int getTop(Stack *s,ElemType *e){
    if(s->next==NULL){
        printf("Empty!");
        return 0;
    }
    *e=s->next->data;
    return 1;
}
```
---
##### 3. 顺序队列 
##### (0)结构
```c
#define MAXNSIZE 100
typedef int ElemType
typedef struct{
    ElemType data[MAXNSIZE];
    int front;
    int rear;
}Queue;
```
---
##### (1) 初始化
```c
void initQueue(Queue *Q){
    Q->front=0;
    Q->rear=0;
}
```
---
##### (2) 检查队列是否为空
```c
int isEmpty(Queue *Q){
    if(Q->front==Q->rear){
        printf("Empty!");
        return 1;
    }else{
        return 0;
    }
}
```
---
##### (3) 出队
```c
ElemType dequeue(Queue *Q){
    if(Q->front==Q->rear){
        printf("Empty!");
        return 0;
    }
    ElemType e=Q->data[Q->front];
    Q->front++;
    return e;
}
```
---
##### (4) 入队
```c
int queueFull(Queue *Q){
    if(Q->front>0){
        int step=Q->front;
        for(int i=Q->front;i<=Q->rear;i++){
            Q->data[i-step]=Q->data[i];
        }
        Q->front=0;
        Q->rear=Q->rear-step;
        return 1;
    }else{
        printf("Really Full");
        return 0;
    }
}

int enqueue(Queue *Q,ElemType e){
    if(Q->rear>=MAXNSIZE){
        if(!queueFull(Q)){
            return 0;
        }
    }
    Q->data[Q->rear]=e;
    Q->rear++;
    return 1;
}
```
---
##### (5) 取得队列首元素
```c
int getHead(Queue *Q,ElemType *e){
    if(Q->front==Q->rear){
        printf("Empty!");
        return 0;
    }
    *e=Q->data[Q->front];
    return 1;
}
```
---
##### (6) 动态内存分配
```c
Queue *initQueue(){
    Queue *q=(Queue*)malloc(sizeof(Queue));
    q->data=(ElemType*)malloc(sizeof(ElemType)*MAXNSIZE);
    q->front=0;
    q->rear=0;
    return q;
}
```
---
#### 4.循环队列 
##### (0) 结构
```c
typedef int ElemType;

typedef struct{
    ElemType *data;
    int front;
    int rear;
}Queue;
```
---
##### (1) 入队
```c
int equeue(Queue *Q,ElemType e){
    if((Q->rear+1)%MAXNSIZE==Q->front){
        printf("Full!\n");
        return 0;
    }
    Q->data[Q->rear]=e;
    Q->rear=(Q->rear+1)%MAXNSIZE;
    return 1;
}
```
---
##### (2) 出队
```c
int dequeue(Queue *Q,ElemType *e){
    if(Q->front==Q->rear){
        printf("Empty!\n");
        return 0;
    }
    *e=Q->data[Q->front];
    Q->front=(Q->front+1)%MAXNSIZE;
    return 1;
}
```
---
##### (3) 初始化
```c
Queue *initQueue(){
    Queue *q=(Queue*)malloc(sizeof(Queue));
    q->data=(ElemType*)malloc(sizeof(ElemType));
    q->front=0;
    q->rear=0;
    return q;
}
```
---
#####  (4) 检查队列是否为空
```c
int isEmpty(Queue *Q){
    if(Q->front==Q->rear){
        printf("Empty!\n");
        return 1;
    }else{
        return 0;
    }
}
```
---
##### (5) 取得队列首元素
```c
int getHead(Queue *Q,ElemType *e){
    if(Q->front==Q->rear){
        printf("Empty!\n");
        return 0;
    }
    *e=Q->data[Q->front];
    return 1;
}
```
---
#### 5. 链式队列 
##### (0) 结构
```c
typedef struct QueueNode{
    ElemType data;
    struct QueueNode *next;
}QueueNode;

typedef struct{
    QueueNode *front;
    QueueNode *rear;
}Queue;
```
---
##### (1) 初始化
```c
Queue *initQueue(){
    Queue *q=(Queue*)malloc(sizeof(Queue));
    QueueNode *node=(QueueNode*)malloc(sizeof(QueueNode));
    node->data=0;
    node->next=NULL;
    q->front=node;
    q->rear=node;
    return q;
}
```
---

##### (2) 检查队列是否为空
```c
int isEmpty(Queue *q){
    if(q->front==q->rear){
        return 1;
    }else{
        return 0;
    }
}
```
---
##### (3) 入队
```c
void equeue(Queue *q,ElemType e){
    QueueNode *node=(QueueNode*)malloc(sizeof(QueueNode));
    node->data=e;
    node->next=NULL;
    q->rear->next=node;
    q->rear=node;
}
```
---
##### (4) 出队
```c
int dequeue(Queue *q,ElemType *e){
    QueueNode *node=q->front->next;
    *e=node->data;
    q->front->next=node->next;
    if(q->rear==node){
        q->rear=q->front;
    }
    free(node);
    return 1;
}
```
---
##### (5) 取得队列首元素
```c
int isEmpty(Queue *q){
    if(q->front==q->rear){
        return 1;
    }else{
        return 0;
    }
}                       /*See it in "(2) Check if the Queue Is Empty" */

ElemType getFront(Queue *q){
    if(isEmpty(q)){
        printf("Empty!\n");
        return 0;
    }
    return q->front->next->data;
}
```
---
### 四、递归
#### 1. 一些数列
##### (1) 等差数列
```c
/*Non-recursive Way*/
int fun(int n){
    int sum=0;
    for(int i=1;i<=n;i++){
        sum+=i;
    }
    return sum;
}

/*Recursive Way*/
int fun(int n){
    if(n==1){
        return 1;
    }else{
        return fun(n-1)+n;
    }
}
```
---
##### (2) 斐波那契数列
```c
/*Non-recursive Way*/
int fibonacci(int n){
    int last1=1;
    int last2=1;
    int result=0;
    for(int i=3;i<=n;i++){
        result=last1+last2;
        last2=last1;
        last1=result;
    }
    return result;
}

/*Recuersive Way*/
int fibonacci(int n){
    if(n==1||n==2){
        return 1;
    }else{
        return fibonacci(n-1)+fibonacci(n-2);
    }
}
```
---
### 五、枚举 
#### 1. 基本部分
##### (0) 结构
```c
/*Core Syntax Framework*/
enum EnumName {
    Constant1,  // Default value: 0
    Constant2   // Default value: 1 (auto-increment)
};

/*Custom version*/
enum EnumName {
    Constant1 = 1,  // Default value: 1
    Constant2   // Default value: 2 (auto-increment)
};
```
---
### 六、树和二叉树 
#### 1. 树

> 包含 $n \ge 0$ 个节点的有限集合，空树也是树。

##### (1) 定义
- **节点 (Node):** 树中的独立基本单元。
- **节点的度 (Degree of a node):** 一个节点拥有的子树数量。
- **树的度 (Degree of a tree):** 树中所有节点的度的最大值。
- **叶子节点 (Leaf):** 度为 $0$ 的节点，也称为终端节点。
- **非终端节点 (Non-terminal node):** 度不为 $0$ 的节点。
- **双亲与孩子 (Parent and child):** 一个结点的子树的根被称为该节点的孩子；相应地，该节点被称为其孩子的双亲。
- **层次 (Level):** 节点的层次从根节点开始定义。根节点处于第 $1$ 层，根节点的孩子处于第 $2$ 层，以此类推。

---
##### (2) 性质
- **性质 $1$:** 树中节点的总述等于所有节点的度数之和加 $1$。

- **性质 $2$:** 对于度为 $m$ 的树, 第 $i$ 层最多有 $m^{i−1}$ 个节点。

- **性质 $3$:** 对于高度为 $h$，度为 $m$ 的树, 其最大节点数为 $\frac{m^h - 1}{m - 1}$。

---
#### 2. 二叉树
##### (1)定义
二叉树是由 $n$（$n \ge 0$）个结点组成的集合。它要么是空树（$n = 0$），要么是非空树。对于一棵非空树 $T$：

>**1.** 有且仅有一个结点称为根结点。

>**2.** 除根结点外的其余结点被划分为两个互不相交的子集 $T_1$ 和 $T_2$，分别称为 $T$ 的左子树和右子树，且 $T_1$ 和 $T_2$ 本身也都是二叉树。

>**3.** 二叉树中的每个结点至多有两棵子树。

>**4.** 二叉树的子树有左右之分，次序不能任意颠倒。

---
##### (2) 性质
>**性质 1：** 二叉树的第 $i$ 层上至多有 $2^{i-1}$ 个结点，其中 $i \ge 1$。

>**性质 2：** 深度为 $k$ 的二叉树至多有 $2^k - 1$ 个结点，其中 $k \ge 1$。

>**性质 3：** 对于任何一棵非空二叉树 $T$，若叶子结点数为 $n_0$，度为 2 的结点数为 $n_2$，则 $n_0 = n_2 + 1$。

> **性质 4：**具有 $n$ 个节点的 **完全二叉树** 深度为 $\lfloor \log_2 n \rfloor + 1$。

---
##### (3) 满二叉树
> 深度为 $k$ 且有 $2^k - 1$ 个结点的二叉树。

- 所有叶子结点只能出现在最下一层。
- 在相同深度的所有二叉树中，满二叉树的结点总数最多，叶子结点数也最多。
- 若对满二叉树的结点从根结点开始自上而下、自左至右依次从 $1$ 开始编号，则对于编号为 $i$ 的结点：
  - 若其有左孩子，则左孩子编号为 $2i$。
  - 若其有右孩子，则右孩子编号为 $2i + 1$。

---
##### (4) 完全二叉树
> 一棵深度为 $k$、有 $n$ 个结点的二叉树，当且仅当其每个结点都与深度为 $k$ 的满二叉树中编号从 $1$ 到 $n$ 的结点一一对应时，称为完全二叉树。

完全二叉树的特点：
- **性质 1：** 叶子结点只能出现在层次最大的两层上。
- **性质 2：** 对任一结点，若其右子树中子孙结点的最大层次为 $l$，则其左子树中子孙结点的最大层次必为 $l$ 或 $l+1$。
- **性质 3：** 若无左子树，则必无右子树；若上一层未填满，则不会出现下一层结点。
- **性质 4：** 具有 $n$ 个结点的完全二叉树的深度为 $\lfloor \log_2 n \rfloor + 1$（向下取整）。
- **性质 5：** 若对一棵有 $n$ 个结点的完全二叉树（深度为 $\lfloor \log_2 n \rfloor + 1$）的结点按层序编号（从第 1 层到第 $\lfloor \log_2 n \rfloor + 1$ 层，每层内从左到右），则对任一结点 $i$（$1 \le i \le n$），有以下结论：
   - 若 $i = 1$，则结点 $i$ 是二叉树的根，无双亲；若 $i > 1$，则其双亲结点为 $\lfloor i/2 \rfloor$（向下取整）。
   - 若 $2i > n$，则结点 $i$ 无左孩子（结点 $i$ 为叶子结点）；否则其左孩子为结点 $2i$。
   - 若 $2i + 1 > n$，则结点 $i$ 无右孩子；否则其右孩子为结点 $2i + 1$。

总结为以下三点：
- 除最后一层以外都是满的；
- 最后一层节点靠左连续排列；
- 满足满二叉树的编号对应关系。

---

#### 3. 二叉树的链式存储结构
##### (0) 结构
- 二叉树的**链式存储结构**使用链表来表示一棵二叉树。
- 每个结点包含：
   - 数据域
   - 指向左孩子的指针
   - 指向右孩子的指针

>该结构称为**二叉链表**。

```c
typedef char ElemType;

typedef struct TreeNode{
    ElemType data;
    TreeNode *lchild;
    TreeNode *rchild;
}TreeNode;

typedef TreeNode *BiTree;
```

---

##### (1) 先序遍历

>先访问根结点，再依次访问左分支上遇到的每个结点，直到遇到空结点为止。此时回溯到最近一个存在右孩子的祖先结点，并从该结点的右孩子开始继续遍历。


```c  
void preOrder(BiTree T){
    if(T==NULL){
        return;
    }
    printf("%c",T->data);
    preOrder(T->lchild);
    preOrder(T->rchild);
}
```

---

##### (2) 中序遍历

>先从根结点出发向左下遍历，直到遇到空结点，然后访问该空结点的父结点，接着继续遍历该结点的右子树。若右子树已无分支可遍历，则继续向上一层寻找最后一个未访问的结点并遍历。

```c
void inOrder(BiTree T){
    if(T==NULL){
        return;
    }
    inOrder(T->lchild);
    printf("%c",T->data);
    inOrder(T->rchild);
}
```

---

##### (3) 后序遍历

>从根结点开始，先访问结点的左、右孩子，再访问结点本身。即一个结点的孩子会先于该结点被输出。

```c  
void postOrder(BiTree T){
    if(T==NULL){
        return;
    }
    postOrder(T->lchild);
    postOrder(T->rchild);
    printf("%c",T->data);
}
```

---

##### (4) 非递归先序遍历（栈实现）

```c  
void iterPreOrder(Stack *s,BiTree T){
    while(T!=NULL||isEmpty(s)!=0){
        while(T!=NULL){
            printf("%c",T->data);
            push(s,T);
            T=T->lchild;
        }
        pop(s,&T);
        T=T->rchild;
    }
}
```

---

#### 4. 二叉搜索树（BST）

##### (1) 性质

- 左子树所有节点 $<$ 根； 
- 右子树所有节点 $>$ 根；
- 左右子树都是 BST；
- 中序遍历的结果是递增有序的。

---

##### (2) 二叉树节点定义

```c
typedef struct TreeNode{
    int data;
    struct TreeNode *lchild;
    struct TreeNode *rchild;
}TreeNode;

typedef TreeNode *Position;

typedef TreeNode *SearchTree;
```

---

##### (3) BST 查找

```c
Position Find(int X, SearchTree T) {
	if (T == NULL) {
		return NULL;
	}
	if (X < T->data) {
		return Find(X, T->lchild);
	}
	else if (X > T->data) {
		return Find(X, T->rchild);
	}
	else {
		return T;
	}
}
```

---

##### (4) BST 插入

```c
SearchTree Insert(int X, SearchTree T) {
	if (T == NULL) {
		T = (SearchTree)malloc(sizeof(TreeNode));
		T->data = X;
		T->lchild = NULL;
		T->rchild = NULL;
	}
	else if (X < T->data) {
		T->lchild = Insert(X, T->lchild);
	}
	else if (X > T->data) {
		T->rchild = Insert(X, T->rchild);
	}
	return T;
}
```

---

##### (5) BST 删除

> - **叶子节点：**直接删；
> - **只有一个孩子：**孩子顶替；
> - **两个孩子**：用右子树最小 / 左子树最大顶替，再删除顶替节点

```c
SearchTree Delete(int X, SearchTree T) {
	Position tmp;
	if (T == NULL) {
		return NULL;
	}
	if (X < T->data) {
		T->lchild = Delete(X, T->lchild);
	}
	else if (X > T->data) {
		T->rchild = Delete(X, T->rchild);
	}
	else {
		if (T->lchild && T->rchild) {
			tmp = FindMIN(T->rchild);
			T->data = tmp->data;
			T->rchild = Delete(T->data, T->rchild);
		}
		else {
			tmp = T;
			if (T->lchild == NULL) {
				T = T->lchild;
			}
			else if (T->rchild == NULL) {
				T = T->rchild;
			}
			free(tmp);
		}
	}
	return T;
}
```

---

### 七、优先队列（堆）

#### 1. 堆的本质

- 完全二叉树；
- 用数组存储，小标从 $1$ 开始；
- 分小顶堆和大顶堆。

#### 2. 堆结构定义

```c
typedef int ElementType;

typedef struct HeadStruct {
	ElementType* Elements;
	int Capacity;
	int Size;
}*PriorityQueue;
```

---

#### 3. 堆的插入（上滤 Percolate Up）

> - 放到数组最后；
> - 不断和父节点比较；
> - 比父节点小就交换，直到满足堆序。

```c
void Insert(ElementType X, PriorityQueue H) {
	int i;
	if (IsFull(H)) {
		return;
	}
	for (i = ++H->Size; H->Elements[i / 2] > X; i /= 2) {
		H->Elements[i] = H->Elements[i / 2];
	}
	H->Elements[i] = X;
}
```

- 复杂度：$O(logN)$

---

#### 4. 删除最小值（下滤 Percolate Down）

> - 删掉堆顶；
> - 最后一个元素放到栈顶；
> - 不断和较小孩子比较，下沉。

```c
ElementType DeleteMin(PriorityQueue H) {
	int i;
	int child;
	ElementType minElement, lastElement;
	minElement = H->Elements[0];
	lastElement = H->Elements[H->Size--];
	for (i = 1; i * 2 <= H->Size; i = child) {
		child = i * 2;
		if (child != H->Size && H->Elements[child + 1] < H->Elements[child]) {
			child++;
		}
		if (lastElement > H->Elements[child]) {
			H->Elements[i] = H->Elements[child];
		}
		else {
			break;
		}
	}
	H->Elements[i] = lastElement;
	return minElement;
}
```

- 复杂度：$O(logN)$

---

#### 5. 建堆（BuildHeap）

- 从最后一个非叶子节点开始，逐个下滤；
- 复杂度：$O(N)$。

---

#### 6. 堆的其他操作

- **DecreaseKey：**减小值 $\to$ 上滤

- **IncreaseKey：**增加值 $\to$ 下滤

- **Delete：**先 DecreaseKey 到最小哦啊，再 DeleteMin
- **FindMin：**$O(1)$ 直接返回栈顶

#### 7. d-堆

- 每个节点有 $d$ 个孩子
- 查找最小孩子需要 $d-1$ 次比较
- 复杂度：$O(dlog_dN)$

---

## <center>Part 4：习题</center>

### 1. 编程题 && 函数题 && 程序填空题 (PTA)

#### (1) Reverse a Singly Linked List (PTA)

> 反转单链表

This problem requires implementing a function to reverse the given singly linked list.

> 本题要求实现一个函数，将给定的单链表进行反转。

```c
#include <stdio.h>
#include <stdlib.h>

typedef int ElementType;
typedef struct Node *PtrToNode;
struct Node {
    ElementType Data;
    PtrToNode   Next;
};
typedef PtrToNode List;

List Read(); /* The details are omitted here. */
void Print( List L ); /* The details are omitted here. */

List Reverse( List L );

int main()
{
    List L1, L2;
    L1 = Read();
    L2 = Reverse(L1);
    Print(L1);
    Print(L2);
    return 0;
}

/* Your code will be embedded here. */

List Reverse( List L ){
    List p=L;
    List q=NULL;
    List temp;
    while(p!=NULL){
        temp=p->Next;
        p->Next=q;
        q=p;
        p=temp;
    }
    return q;
}
```
---
#### (2) Calculate the length of a linked list (PTA)

> 计算链表长度

This problem requires implementing a function to calculate the length of a linked list.

> 本题要求实现一个函数，用于计算链表的长度。

```c
#include <stdio.h>
#include <stdlib.h>

typedef int ElementType;
typedef struct LNode *PtrToLNode;
struct LNode {
    ElementType Data;
    PtrToLNode Next;
};
typedef PtrToLNode List;

List Read(); /* The details are omitted here. */

int Length( List L );

int main()
{
    List L = Read();
    printf("%d\n", Length(L));
    return 0;
}

/* Your code will be embedded here. */

int Length( List L ){
    int len=0;
    List p=L;
    while(p!=NULL){
        p=p->Next;
        len++;
    }
    return len;
}
```
---
#### (3) Search a linked list by index (PTA)

> 按索引查找链表

This problem requires implementing a function to find and return the K-th element of a linked list.

> 本题要求实现一个函数，查找并返回链表的第 $K$ 个元素。

```c
#include <stdio.h>
#include <stdlib.h>

#define ERROR -1
typedef int ElementType;
typedef struct LNode *PtrToLNode;
struct LNode {
    ElementType Data;
    PtrToLNode Next;
};
typedef PtrToLNode List;

List Read(); /* The details are omitted here. */

ElementType FindKth( List L, int K );

int main()
{
    int N, K;
    ElementType X;
    List L = Read();
    scanf("%d", &N);
    while ( N-- ) {
        scanf("%d", &K);
        X = FindKth(L, K);
        if ( X!= ERROR )
            printf("%d ", X);
        else
            printf("NA ");
    }
    return 0;
}

/* Your code will be embedded here */

ElementType FindKth( List L, int K ){
    if(L==NULL||K<=0){
        return ERROR;
    }
    List p=L;
    int i=0;
    while(p!=NULL&&i<K-1){
        p=p->Next;
        i++;
    }
    if(p==NULL){
        return ERROR;
    }
    ElementType x=p->Data;
    return x;
}
```
---
#### (4) Balloon Popping (PTA)

> 戳气球

![](https://images.ptausercontent.com/6b53b1a2-7325-4de6-8dd5-bc403552b751.jpg)

Balloon popping is a fun game for kids.  Now $n$ balloons are positioned in a line. The goal of the game is very simple: to pop as many balloons as possible.  Here we add a special rule to this game -- that is, you can only make $ONE$ jump.  Assume that a smart baby covers his/her body by thorns（刺）, jumps to some position and lies down (as shown by the figures below), so that the balloons will be popped as soon as they are touched by any part of the baby's body.  Now it is your job to tell the baby at which position he/she must jump to pop the most number of balloons.

>戳气球是一款儿童趣味游戏。现有 n 个气球排成一条直线。游戏目标很简单：戳破尽可能多的气球。本局增设特殊规则：**仅允许跳跃一次**。
>
>假设聪明的孩子全身带刺，跳到某个位置后躺下（如下图所示），只要气球碰到身体任意部位就会被戳破。你的任务是：帮孩子算出应该跳到哪个位置，才能戳破最多气球。

![](https://images.ptausercontent.com/8ac137cc-1253-42d6-ba2f-3da93df331bc.jpg)
![](https://images.ptausercontent.com/7a0b9adf-ee5a-45ed-81e3-4ad970784ff2.jpg)

**Input Specification:**

Each input file contains one test case. For each case, two positive integers are given in the first line: $n (≤$$10^5$), the number of balloons in a line, and $h (≤$$10^3)$, the height of the baby with his/her arms stretched up.  Then $n$ integers are given in the next line, each corresponds to the coordinate of a balloon on the axis of the line.  It is guaranteed that the coordinates are given in ascending order, and are all in the range $[−10^6,10^6]$.

>**输入说明**：
>
>每组数据包含一个测试用例：
>
>- 第一行输入两个正整数：
>
>- $n(≤10^5)$：直线上的气球总数；
>
>- $h(≤10^3)$：孩子双臂伸直躺下后的覆盖宽度。
>
>第二行给出 $n$ 个整数，依次表示每个气球在数轴上的坐标；坐标保证**升序给出**，范围 $[−10^6,10^6]$。

**Output Specification:**

Output in a line the coordinate at which the baby shall jump, so that if the baby jumps at this position and then lie down, the maximum number of the balloons can be popped beneath his/her body.  Then also print the maximum number of balloons that can be popped.  If the coordinate is not unique, output the smallest one.

The numbers must be separated by $1$ space, and there must be no extra space at the beginning or the end of the line.

>**输出说明**：
>
>输出一行：
>
>- 孩子需要跳到的坐标（在此位置躺下，能戳破最多气球）；
>
>- 能戳破的最大气球数量。
>
>- 若存在多个最优坐标，输出**最小**的那个。
>
>- 两数之间用单个空格分隔，行首、行尾不得有多余空格。

*Answer*:

>**答案**：

```c
#define _CRT_SECURE_NO_WARNINGS
#include<stdio.h>
#include<string.h>
#include<stdlib.h>
#include<time.h>
#include<math.h>
#define MAXN 10000

int main() {
	int n, h;
	scanf("%d %d", &n, &h);
	long long* b = (long long*)malloc(n * sizeof(long long));
	for (int i = 0; i < n; i++) {
		scanf("%lld", &b[i]);
	}
	int L = 0;
	int R = 0;
	long long Mpos = 0;
	int Mcnt = 0;
	while (R < n) {
		int cnt = 0;
		long long pos = 0;
		if (b[R] - b[L] > h) {
			L += 1;
		}
		else {
			cnt = R - L + 1;
			pos = b[R] - h;
			if (Mcnt < cnt) {
				Mcnt = cnt;
				Mpos = pos;
			}
			else if (Mcnt == cnt) {
				if (Mpos > pos) {
					Mpos = pos;
				}
			}
		}
		R += 1;
	}
	printf("%lld %d", Mpos, Mcnt);
	return 0;
}
```
---
#### (5) Add Two Polynomials (PTA)

> 两个多项式相加

Write a function to add two polynomials.  Do not destroy the input.  Use a linked list implementation with a dummy head node.

> 编写一个函数实现两个多项式相加。**不得破坏输入的原多项式**。采用带 **哑头结点（哨兵头节点）** 的链表方式实现。

**Note:** 
The zero polynomial is represented by an empty list with only the dummy head node.

>**说明：**零多项式仅用只包含哑头结点的空链表来表示。

**Format of functions:**

> **函数格式**：

```c
Polynomial Add( Polynomial a, Polynomial b );
```
where `Polynomial` is defined as the following:

> 多项式结构体定义如下：

```c
typedef struct Node *PtrToNode;
struct Node {
    int Coefficient;
    int Exponent;
    PtrToNode Next;
};
typedef PtrToNode Polynomial;
/* Nodes are sorted in decreasing order of exponents.*/  
```
The function `Add` is supposed to return a polynomial which is the sum of `a` and `b`.

> 函数 `Add` 需要返回多项式 `a` 与多项式 `b` 相加后的和多项式。

**Sample program of judge:**

> **评测样例程序**：

```c
#include <stdio.h>
#include <stdlib.h>
typedef struct Node *PtrToNode;
struct Node  {
    int Coefficient;
    int Exponent;
    PtrToNode Next;
};
typedef PtrToNode Polynomial;

Polynomial Read(); /* details omitted */
void Print( Polynomial p ); /* details omitted */
Polynomial Add( Polynomial a, Polynomial b );

int main()
{
    Polynomial a, b, s;
    a = Read();
    b = Read();
    s = Add(a, b);
    Print(s);
    return 0;
}

/* Your function will be put here */
```

**Sample Input:**

> **输入样例**：

```c
4
3 4 -5 2 6 1 -2 0
3
5 20 -7 4 3 1
```

**Sample Output:**

> **输出样例**：

```c
5 20 -4 4 -5 2 9 1 -2 0
```
*Answer*:

> **答案**：

```c
Polynomial Add(Polynomial a, Polynomial b) {
    Polynomial p = a;
    Polynomial q = b;
    Polynomial real = (Polynomial)malloc(sizeof(struct Node));
    Polynomial tail = real;
    while (p != NULL && q != NULL) {
        if (p->Exponent > q->Exponent) {
            Polynomial node = (Polynomial)malloc(sizeof(struct Node));
            node->Coefficient = p->Coefficient;
            node->Exponent = p->Exponent;
            node->Next = NULL;
            tail->Next = node;
            tail = node;
            p = p->Next;
        }
        else if (p->Exponent < q->Exponent) {
            Polynomial node = (Polynomial)malloc(sizeof(struct Node));
            node->Coefficient = q->Coefficient;
            node->Exponent = q->Exponent;
            node->Next = NULL;
            tail->Next = node;
            tail = node;
            q = q->Next;
        }
        else {
            int sum = p->Coefficient + q->Coefficient;
            if (sum != 0) {
                Polynomial node = (Polynomial)malloc(sizeof(struct Node));
                node->Coefficient = sum;
                node->Exponent = p->Exponent;
                node->Next = NULL;
                tail->Next = node;
                tail = node;
            }
            p = p->Next;
            q = q->Next;
        }
    }
    while (p != NULL) {
        Polynomial node_ = (Polynomial)malloc(sizeof(struct Node));
        node_->Coefficient = p->Coefficient;
        node_->Exponent = p->Exponent;
        node_->Next = NULL;
        tail->Next = node_;
        tail = node_;
        p = p->Next;
    }
    while (q != NULL) {
        Polynomial node__ = (Polynomial)malloc(sizeof(struct Node));
        node__->Coefficient = q->Coefficient;
        node__->Exponent = q->Exponent;
        node__->Next = NULL;
        tail->Next = node__;
        tail = node__;
        q = q->Next;
    }
    return real;
}
```
---
#### (6) Reverse Linked List (PTA)

> 反转链表

Write a nonrecursive procedure to reverse a singly linked list in $O(N)$ time using constant extra space.

> 编写一个**非递归**函数，在 $O(N)$ 时间复杂度、常数额外空间内，实现单链表的反转。

**Format of functions:**

> **函数格式**：

```c
List Reverse( List L );
```
where `List` is defined as the following:

> 其中 `List` 定义如下：

```c
typedef struct Node *PtrToNode;
typedef PtrToNode List;
typedef PtrToNode Position;
struct Node {
    ElementType Element;
    Position Next;
};
```
The function `Reverse` is supposed to return the reverse linked list of `L`, with a dummy header.

> 函数 `Reverse` 需要返回带**哑头结点**的反转后链表。

```c
#include <stdio.h>
#include <stdlib.h>

typedef int ElementType;
typedef struct Node *PtrToNode;
typedef PtrToNode List;
typedef PtrToNode Position;
struct Node {
    ElementType Element;
    Position Next;
};

List Read(); /* details omitted */
void Print( List L ); /* details omitted */
List Reverse( List L );

int main()
{
    List L1, L2;
    L1 = Read();
    L2 = Reverse(L1);
    Print(L1);
    Print(L2);
    return 0;
}

/* Your function will be put here */
```
**Sample Input:**

> **输入样例**：

```c
5
1 3 4 5 2
```
**Sample Output:**

> **输出样例**：

```c
2 5 4 3 1
2 5 4 3 1
```
*Answer*:

> **答案**：

```c
List Reverse(List L) {
    List p = L->Next;
    List q = NULL;
    List temp;
    while (p != NULL) {
        temp = p->Next;
        p->Next = q;
        q = p;
        p = temp;
    }
    L->Next = q;
    return L;
}
```
---
#### (7) Queue Using Two Stacks (PTA)

>用两个栈实现队列

A queue (FIFO structure) can be implemented by two stacks (LIFO structure) in the following way:
- Start from two empty stacks $s_1$ and $s_2$.
- When element $e$ is enqueued, it is actually pushed onto $s_1$.
- When we are supposed to dequeue, $s_2$ is checked first. If $s_2$ is empty, everything in $s_1$ will be transferred to $s_2$ by popping from $s_1$ and immediately pushing onto $s_2$ . Then we just pop from $s_2$ —— the top element of $s_2$ must be the first one to enter $s_1$ thus is the first element that was enqueued.

>队列（先进先出结构）可以通过两个栈（后进先出结构）按照以下方式实现：
>- 初始状态为两个空栈 `s1` 和 `s2`。
>- 当元素 `e` 入队时，实际将其压入栈 `s1`。
>- 当需要执行出队操作时，首先检查栈 `s2`。如果 `s2` 为空，则将 `s1` 中的所有元素依次弹出并立即压入 `s2` 完成转移。随后直接从 `s2` 弹出元素 —— `s2` 的栈顶元素一定是最先进入 `s1` 的元素，也就是最早入队的元素。

Assume that each operation of push or pop takes $1$ unit of time.  You job is to tell the time taken for each dequeue.

>假设**压栈**和**弹栈**操作各耗时 **1 个时间单位**。你的任务是计算每一次出队操作所消耗的时间。

**Input Specification:**
Each input file contains one test case. For each case, the first line gives a positive integer $(N \le 10^3)$, which are the number of operations. Then $N$ lines follow, each gives an operation in the format
```Operation Element```
where `Operation` being `I` represents enqueue and `O` represents dequeue.  For each `I`, Element is a positive integer that is no more than $10^6$. No Element is given for `O` operations.
It is guaranteed that there is at least one `O` operation.

>**输入格式**：
>
>- 每个输入文件包含一组测试用例。
>- 第一行给出一个正整数 $N (N≤103)$，表示操作的总数。
>- 接下来 $N$ 行，每行给出一个操作，格式为：
```c
操作符 元素
```
>   - 操作符 `I` 表示**入队**
>   - 操作符 `O` 表示**出队**
>   - 对于 `I` 操作，元素是一个不超过 106 的正整数
>   - 对于 `O` 操作，无元素输入
题目保证至少存在一个出队操作。

**Output Specification:**
For each dequeue operation, print in a line the dequeued element and the unites of time taken to do this dequeue.  The numbers in a line must be separated by $1$ space, and there must be no extra space at the beginning or the end of the line.
In case that the queue is empty when dequeue is called, output in a line `ERROR` instead.

>**输出格式**：
>对于每一次出队操作：
>
>- 在一行中输出**出队元素**和**本次出队消耗的时间单位数**，两个数字用一个空格分隔，行首和行尾不得有多余空格。
>- 如果执行出队时队列为空，则输出一行 `ERROR`。

**Sample Input:**

> **输入样例**：

```c
10
I 20
I 32
O
I 11
O
O
O
I 100
I 66
O
```

**Sample Output:**

> **输出样例**：

```c
20 5
32 1
11 3
ERROR
100 5
```

*Answer*:

> **答案**

```c
#define _CRT_SECURE_NO_WARNINGS
#include<stdio.h>
#include<stdlib.h>

int main() {
	int N;
	scanf("%d", &N);
	int i = 0;
	int flag_el = 0;
	int front = 0;
	int end = 0;
	int* a = (int*)malloc(N * sizeof(int));
	int* b = (int*)malloc(N * sizeof(int));
	while (i < N) {
		char c[2];
		scanf("%s", c);
		int num;
		if (c[0] == 'I') {
			scanf("%d", &num);
			a[front++] = num;
		}
		else {
			int time = 0;
			if (end == 0) {
				while (front > 0) {
					front--;
					time++;
					b[end++] = a[front];
					time++;
				}
			}
			if (end > 0) {
				end--;
				int num = b[end];
				time++;
				printf("%d %d\n", num, time);
			}
			else {
				printf("ERROR\n");
			}
		}
		i++;
	}
	free(a);
	free(b);
	return 0;
}
```
---
#### (8) Isomorphic (PTA)

> 同构树

Two trees, `T1` and `T2`, are isomorphic if `T1` can be transformed into `T2` by swapping left and right children of (some of the) nodes in `T1`.  For instance, the two trees in Figure $1$ are isomorphic because they are the same if the children of $A$, $B$, and $G$, but not the other nodes, are swapped.
Give a polynomial time algorithm to decide if two trees are isomorphic.

>如果两棵树 `T1` 和 `T2` 可以**通过交换 `T1` 中部分节点的左孩子和右孩子**，从而将 `T1` 转换为 `T2`，那么这两棵树就是**同构**的。
例如，图 $1$ 中的两棵树是同构的 —— 只需要交换节点 $A$、$B$、$G$ 的孩子（其他节点不交换），两棵树就完全相同。
请设计一个**多项式时间复杂度**的算法，判断两棵树是否同构。

![](https://images.ptausercontent.com/37)

**Format of functions**:

> 函数格式

```c
int Isomorphic( Tree T1, Tree T2 );
```

**where `Tree` is defined as the following**:

>树的结构定义

```c
typedef struct TreeNode *Tree;
struct TreeNode {
    ElementType Element;
    Tree  Left;
    Tree  Right;
};
```

The function is supposed to return $1$ if `T1` and `T2` are indeed isomorphic, or $0$ if not.

>**函数要求**:
>
>- 若 `T1` 和 `T2` 同构，返回 $1$；
>- 若 `T1` 和 `T2` 不同构，返回 $0$。

**Sample program of judge**:

>裁判程序说明：系统会自动调用 `BuildTree()` 构建两棵树，再调用你实现的 `Isomorphic` 函数，最终输出结果。

```c
#include <stdio.h>
#include <stdlib.h>

typedef char ElementType;

typedef struct TreeNode *Tree;
struct TreeNode {
    ElementType Element;
    Tree  Left;
    Tree  Right;
};

Tree BuildTree(); /* details omitted */

int Isomorphic( Tree T1, Tree T2 );

int main()
{
    Tree T1, T2;
    T1 = BuildTree();
    T2 = BuildTree();
    printf(“%d\n”, Isomorphic(T1, T2));
    return 0;
}

/* Your function will be put here */
```
**Sample Output 1 (for the trees shown in Figure 1)**:

> **样例输出 $1$**（对应图 $1$ 的两棵树）：`1`（同构）

```c
1
```
**Sample Output 2 (for the trees shown in Figure 2)**:

> **样例输出 $2$**（对应图 $2$ 的两棵树）：`0`（不同构）

```c
0
```

![](https://images.ptausercontent.com/38)

*Answer*:

> 答案

```c
int Isomorphic( Tree T1, Tree T2 ){
    if(T1==NULL&&T2==NULL){
        return 1;
    }
    if(T1==NULL||T2==NULL){
        return 0;
    }
    if(T1->Element!=T2->Element){
        return 0;
    }
    if(Isomorphic(T1->Left,T2->Left)&&Isomorphic(T1->Right,T2->Right)){
        return 1;
    }
    if(Isomorphic(T1->Right,T2->Left)&&Isomorphic(T1->Left,T2->Right)){
        return 1;
    }
    return 0;
}
```
---
#### (9) ZigZagging on a Tree (PTA)

>二叉树的锯齿形层序遍历

Suppose that all the keys in a binary tree are distinct positive integers.  A unique binary tree can be determined by a given pair of postorder and inorder traversal sequences.  And it is a simple standard routine to print the numbers in level-order.  However, if you think the problem is too simple, then you are too naive.  This time you are supposed to print the numbers in "zigzagging order" -- that is, starting from the root, print the numbers level-by-level, alternating between left to right and right to left.

For example, for the following tree you must output: $1$ $11$ $5$ $8$ $17$ $12$ $20$ $15$.

>假设二叉树中所有键值都是互不相同的正整数。给定一棵二叉树的中序遍历序列和后序遍历序列，可以唯一确定这棵二叉树。按层序遍历输出节点数值是一个标准的简单操作。
但是，如果你觉得这道题太过简单，那就太天真了。这一次你需要按照 **“锯齿形顺序”** 输出节点数值 —— 从根节点开始，逐层输出节点，奇数层从左向右打印，偶数层从右向左打印（交替方向）。
例如，针对样例中的树，你必须输出：`1 11 5 8 17 12 20 15`。

![](https://images.ptausercontent.com/337cbfb0-a7b2-4500-9664-318e9ffc870e.jpg)

**Input Specification**:

Each input file contains one test case.  For each case, the first line gives a positive integer $N (≤30)$, the total number of nodes in the binary tree.  The second line gives the inorder sequence and the third line gives the postorder sequence.  All the numbers in a line are separated by a space.

>**输入格式**
>每个输入文件包含一个测试用例：
>
>1. 第一行：一个正整数 $N（N≤30）$，表示二叉树的总节点数
>2. 第二行：二叉树的**中序遍历序列**
>3. 第三行：二叉树的**后序遍历序列**，同一行的所有数字用空格分隔

**Output Specification**:

For each test case, print the zigzagging sequence of the tree in a line.  All the numbers in a line must be separated by exactly one space, and there must be no extra space at the end of the line.

>**输出格式**
>- 对于每个测试用例，在一行中输出二叉树的**锯齿形遍历序列**。
>- 所有数字用**一个空格**分隔，**行尾不能有多余空格**。

**Sample Input**:

>**样例输入**

```c
8
12 11 20 17 1 15 8 5
12 20 17 11 15 8 5 1
```

**Sample Output**:

>**样例输出**

```c
1 11 5 8 17 12 20 15
```

*Answer*

>**答案**

```c
#include<stdio.h>
#include<stdlib.h>
#define MAXN 10000
#define MAX 40

int le[MAX][MAX];
int cnt[MAX];
int max1 = 0;


typedef struct node {
	int element;
	struct node* left;
	struct node* right;
}*Trees;

int zhongxu[MAXN];
int houxu[MAXN];

Trees fun(int zhoL, int zhoR, int houL, int houR) {
	if (zhoL > zhoR) {
		return NULL;
	}
	Trees gen = (Trees)malloc(sizeof(struct node));
	gen->element = houxu[houR];
	int i;
	for (i = zhoL; i <= zhoR; i++) {
		if (zhongxu[i] == gen->element) {
			break;
		}
	}
	int left = i - zhoL;
	gen->left = fun(zhoL, i - 1, houL, houL + left - 1);
	gen->right = fun(i + 1, zhoR, houL + left, houR - 1);
	return gen;
}

void fun_1(Trees gen) {
	Trees q[MAXN];
	int de[MAXN];
	int f = 0;
	int r = 0;
	q[r] = gen;
	de[r++] = 0;
	while (f < r) {
		Trees cur = q[f];
		int d = de[f++];
		le[d][cnt[d]++] = cur->element;
		if (d > max1) {
			max1 = d;
		}
        if (cur->right) {
			q[r] = cur->right;
			de[r++] = d + 1;
		}
		if (cur->left) {
			q[r] = cur->left;
			de[r++] = d + 1;
		}

	}
}





int main() {
	int n;
	scanf("%d", &n);
	for (int i = 0; i < n; i++) {
		scanf("%d", &zhongxu[i]);
	}
	for (int i = 0; i < n; i++) {
		scanf("%d", &houxu[i]);
	}
	Trees gen = fun(0, n - 1, 0, n - 1);
	fun_1(gen);
	int flag = 1;
	for (int i = 0; i <= max1; i++) {
		if (i % 2 == 0) {
			for (int j = 0; j < cnt[i]; j++) {
				if (flag != 1) {
					printf(" ");
				}
				printf("%d", le[i][j]);
				flag = 0;
			}
		}
		else {
			for (int j = cnt[i] - 1; j >= 0; j--) {
				if (flag != 1) {
					printf(" ");
				}
				printf("%d", le[i][j]);
				flag = 0;
			}
		}
	}
	return 0;
}
```
---

#### (10) Tree Traversals Again (PTA)

>再谈树的遍历

An inorder binary tree traversal can be implemented in a non-recursive way with a stack.  For example, suppose that when a $6$-node binary tree (with the keys numbered from $1$ to $6$) is traversed, the stack operations are: push$(1)$; push$(2)$; push$(3)$; pop$()$; pop$()$; push$(4)$; pop$()$; pop$()$; push$(5)$; push$(6)$; pop$()$; pop$()$.  Then a unique binary tree (shown in Figure $1$) can be generated from this sequence of operations.  Your task is to give the postorder traversal sequence of this tree.

>二叉树的中序遍历可以用栈以非递归的方式实现。
例如，对一棵包含 $6$ 个节点（节点编号为 $1$~$6$）的二叉树进行遍历时，栈操作序列为：`push(1); push(2); push(3); pop(); pop(); push(4); pop(); pop(); push(5); push(6); pop(); pop()`。
从这个操作序列可以唯一确定一棵二叉树（如图 $1$ 所示）。你的任务是：输出这棵树的后序遍历序列。

![](https://images.ptausercontent.com/30)

**Input Specification**:

Each input file contains one test case.  For each case, the first line contains a positive integer $N (≤30)$ which is the total number of nodes in a tree (and hence the nodes are numbered from $1$ to $N$).  Then $2N$ lines follow, each describes a stack operation in the format: "`Push X`" where `X` is the index of the node being pushed onto the stack; or "Pop" meaning to pop one node from the stack.

>**输入格式**
>每个输入文件包含一个测试用例：
>
>- 第一行：一个正整数 $N（N≤30）$，表示二叉树的**总节点数**（节点编号为 $1∼N$）
>- 接下来 $2N$ 行：每行描述一个栈操作
>  - `Push X`：将编号为 `X` 的节点压入栈
>  - `Pop`：从栈中弹出一个节点

**Output Specification**:

For each test case, print the postorder traversal sequence of the corresponding tree in one line.  A solution is guaranteed to exist.  All the numbers must be separated by exactly one space, and there must be no extra space at the end of the line.

>输出格式
>在一行中输出对应二叉树的**后序遍历序列**。
>题目保证有解，数字之间用**一个空格**分隔，**行尾不能有多余空格**。

**Sample Input**:

>**样例输入**

```c
6
Push 1
Push 2
Push 3
Pop
Pop
Push 4
Pop
Pop
Push 5
Push 6
Pop
Pop
```

**Sample Output**:

>**样例输出**

```c
3 4 2 6 5 1
```

*Answer*:

>**答案**

```c
#include<stdio.h>
#include<stdlib.h>
#define MAXN 10000
#define MAX 40
#include<string.h>

int qian[MAX];
int zhong[MAX];
int hou[MAX];

int qian_ = 0;
int zhong_ = 0;
int hou_ = 0;

int N;

void position(int qianL, int qianR, int zhongL, int zhongR) {
	if (qianL > qianR) {
		return;
	}
	int gen = qian[qianL];
	int i;
	for (i = zhongL; i <= zhongR; i++) {
		if (zhong[i] == gen) {
			break;
		}
		
	}
	int left = i - zhongL;
	position(qianL + 1, qianL + left, zhongL, i - 1);
	position(qianL + 1 + left, qianR, i + 1, zhongR);
	hou[hou_++] = gen;
}

int main() {
	char letter[10];
	int stack[MAX];
	int top = -1;
	scanf("%d", &N);
	for (int i = 0; i < N * 2; i++) {
		scanf("%s", letter);
		if (strcmp(letter, "Push") == 0) {
			int num;
			scanf("%d", &num);
			stack[++top] = num;
			qian[qian_++] = num;
		}
		else {
			zhong[zhong_++] = stack[top--];
		}
	}
	position(0, N - 1, 0, N - 1);
	for (int i = 0; i < N; i++) {
		if (i > 0) {
			printf(" ");
		}
		printf("%d", hou[i]);
	}
	return 0;
}
```
---

#### (11) Percolate Up and Down (PTA)

>上滤与下滤

Write the routines to do a "percolate up" and a "percolate down" in a binary min-heap.

>编写函数实现二叉最小堆的「上滤」和「下滤」操作。

Format of functions:

>函数格式：

```c
void PercolateUp( int p, PriorityQueue H );
void PercolateDown( int p, PriorityQueue H );
```

where `int p` is the position of the element, and `PriorityQueue` is defined as the following:

>`int p`：元素所在的位置
>`PriorityQueue` 定义如下：


```c
typedef struct HeapStruct *PriorityQueue;
struct HeapStruct {
    ElementType  *Elements;
    int Capacity;
    int Size;
};
```


Sample program of judge:

裁判样例程序：

```c
#include <stdio.h>
{
    int p = ++H->Size;
    H->Elements[p] = X;
    PercolateUp( p, H );
}

ElementType DeleteMin( PriorityQueue H ) 
{ 
    ElementType MinElement; 
    MinElement = H->Elements[1];
    H->Elements[1] = H->Elements[H->Size--];
    PercolateDown( 1, H );
    return MinElement; 
}

int main()
{
    int n, i, op, X;
    PriorityQueue H;

    scanf("%d", &n);
    H = Initialize(n);
    for ( i=0; i<n; i++ ) {
        scanf("%d", &op);
        switch( op ) {
        case 1:
            scanf("%d", &X);
            Insert(X, H);
            break;
        case 0:
            printf("%d ", DeleteMin(H));
            break;
        }
    }
    printf("\nInside H:");
    for ( i=1; i<=H->Size; i++ )
        printf(" %d", H->Elements[i]);
    return 0;
}

/* Your function will be put here */
```

**Sample Input**:

>输入样例：

```c
9
1 10
1 5
1 2
0
1 9
1 1
1 4
0
0
```

**Sample Output**:

>输出样例：

```c
2 1 4 
Inside H: 5 10 9
```

*Answer*:

>答案：

```c
void PercolateUp(int p, PriorityQueue H) {
	ElementType temp = H->Elements[p];
	while (p > 1 && temp < H->Elements[p / 2]) {
		H->Elements[p] = H->Elements[p / 2];
		p = p / 2;
	}
	H->Elements[p] = temp;
}
void PercolateDown(int p, PriorityQueue H) {
	ElementType temp0 = H->Elements[p];
	ElementType temp1;
	while (2 * p <= H->Size) {

		temp1 = 2 * p;

		if (temp1 != H->Size && H->Elements[temp1 + 1] < H->Elements[temp1]){
            temp1 =2*p+1;
        }
			

		
		if (temp0 > H->Elements[temp1]) {
			H->Elements[p] = H->Elements[temp1];
			p = temp1;
		}
		else {
			break;
		}
		
	}
H->Elements[p] = temp0;
}
```

---

#### (12) Complete Binary Search Tree (PTA)

>完全二叉搜索树

A Binary Search Tree (BST) is recursively defined as a binary tree which has the following properties:

>二叉搜索树（BST）递归定义为具有以下性质的二叉树：

- The left subtree of a node contains only nodes with keys less than the node's key.
- The right subtree of a node contains only nodes with keys greater than or equal to the node's key.
- Both the left and right subtrees must also be binary search trees.

>- 节点的左子树仅包含键值小于该节点键值的节点。
>- 节点的右子树仅包含键值大于或等于该节点键值的节点。
>- 左、右子树也必须是二叉搜索树。

A Complete Binary Tree (CBT) is a tree that is completely filled, with the possible exception of the bottom level, which is filled from left to right.

>完全二叉树（CBT）是指除了最底层外，每一层都被完全填满，且最底层的节点都从左到右依次填充。

Now given a sequence of distinct non-negative integer keys, a unique BST can be constructed if it is required that the tree must also be a CBT.  You are supposed to output the level order traversal sequence of this BST.

>现给定一个由**不同的非负整数**组成的序列，如果要求这棵树必须同时是一棵**完全二叉树（CBT）**，那么可以唯一构造出一棵二叉搜索树（BST）。
你需要输出这棵树的**层序遍历序列**。

**Input Specification**:

>输入格式：

Each input file contains one test case.  For each case, the first line contains a positive integer $N(≤1000)$.  Then $N$ distinct non-negative integer keys are given in the next line.  All the numbers in a line are separated by a space and are no greater than $2000$.

>- 每个输入文件包含一个测试用例。
>- 第一行包含一个正整数 $N(≤1000)$。
>- 接下来一行给出 $N$ 个互不相同的非负整数键值。
>- 一行中所有数字用空格分隔，且数值不超过 $2000$。

**Output Specification**:

>输出格式：

For each test case, print in one line the level order traversal sequence of the corresponding complete binary search tree.  All the numbers in a line must be separated by a space, and there must be no extra space at the end of the line.

>对于每个测试用例，在一行中输出对应完全二叉搜索树的层序遍历序列。
>所有数字用空格分隔，行尾不得有多余空格。

**Sample Input**:

>输入样例：

```c
10
1 2 3 4 5 6 7 8 9 0
```

**Sample Output**:

>输出样例：

```c
6 3 8 1 5 7 9 0 2 4
```

*Answer*:

>答案：

```c
#define _CRT_SECURE_NO_WARNINGS
#include<stdio.h>
#include<stdlib.h>
#define MAXN 1005

int tree[MAXN];

int part(int arr[], int low, int high) {
	int pivot = arr[high];
	int i = low - 1;
	for (int j = low; j <= high; j++) {
		if (arr[j] < pivot) {
			i++;
			int temp = arr[i];
			arr[i] = arr[j];
			arr[j] = temp;
		}
	}
	int temp = arr[i + 1];
	arr[i + 1] = arr[high];
	arr[high] = temp;
	return i + 1;
}

void QuickSort(int arr[], int low, int high) {
	if (low < high) {
		int pi = part(arr, low, high);
		QuickSort(arr, low, pi - 1);
		QuickSort(arr, pi + 1, high);
	}
}

int getLeftSize(int len) {
    if (len == 0) return 0;
    int h = 0, temp = len + 1;
    while (temp > 1) {
        temp /= 2;
        h++;
    }
    int max = (1 << h) - 1;
    int le = len - max;
    int max_ = 1 << (h - 1);
    if (le <= max_)
        return (max / 2) + le;
    else
        return (max / 2) + max_;
}

void build(int n, int low, int high, int a[]) {
	if (low > high) return;
	int len = high - low + 1;
	int left_ = getLeftSize(len);
	int mid = low + left_;
	tree[n] = a[mid];

	build(2 * n + 1, low, low + left_ - 1, a);
	build(2 * n + 2, low + left_ + 1, high, a);
}

int main() {
	int n;
	scanf("%d", &n);
	int* a = (int*)malloc(n * sizeof(int));
	for (int i = 0; i < n; i++) {
		scanf("%d", &a[i]);
	}
	QuickSort(a, 0, n - 1);
	build(0, 0, n - 1, a);
	for (int i = 0; i < n; i++) {
		if (i > 0) {
			printf(" ");
		}
		printf("%d", tree[i]);
	}
    free(a);
}
```

---

#### (13) File Transfer (PTA)

> 文件传输

We have a network of computers and a list of bi-directional connections. Each of these connections allows a file transfer from one computer to another. Is it possible to send a file from any computer on the network to any other?

>我们有一个由多台计算机组成的网络以及一组双向连接。每条连接都允许文件在两台计算机之间相互传输。请问：能否将文件从网络中的任意一台计算机发送到另一台任意计算机？

**Input Specification:**

>**输入格式：**

Each input file contains one test case.  For each test case, the first line contains $N(2≤N≤10^4)$, the total number of computers in a network.  Each computer in the network is then represented by a positive integer between $1$ and $N$.  Then in the following lines, the input is given in the format:

> 每个输入文件包含一个测试用例。对于每个测试用例，第一行给出整数 $N(2≤N≤10⁴)$，表示网络中的计算机总数。网络中的每台计算机用 $1$ 到 $N$ 之间的一个正整数表示。接下来若干行，输入按以下格式给出：

```c
I c1 c2  
```

where `I` stands for inputting a connection between `c1` and `c2`; or

> 其中 `I` 表示在计算机 `c1` 和 `c2` 之间建立一条连接；

```c
C c1 c2    
```

where `C` stands for checking if it is possible to transfer files between `c1` and `c2`; or

> 其中 `C` 表示检查是否可以在 `c1` 和 `c2` 之间传输文件；

```c
S
```

where `S` stands for stopping this case. 

> 其中 `S` 表示结束当前用例。

**Output Specification:**

>**输出格式：**

For each `C` case, print in one line the word "yes" or "no" if it is possible or impossible to transfer files between `c1` and `c2`, respectively.  At the end of each case, print in one line:

`The network is connected.` 

If there is a path between any pair of computers; or:

`There are k components.` 

where `k` is the number of connected components in this network.

>对于每个 `C` 指令，如果 `c1` 和 `c2` 之间可以传输文件，则在一行中输出 `yes`，否则输出 `no`。
>
>在每个用例的最后，如果网络中任意两台计算机之间都存在通路，则在一行中输出：
>
>```
>The network is connected.
>```
>
>否则输出：
>
>```
>There are k components.
>```
>
>其中 `k` 是网络中的连通分量个数。

**Sample Input 1:**

>输入样例 $1$：

```
5
C 3 2
I 3 2
C 1 5
I 4 5
I 2 4
C 3 5
S
```

**Sample Output 1:**

>输出样例 $1$：

```c
no
no
yes
There are 2 components.
```

**Sample Input 2:**

>输入样例 $2$：

```c
5
C 3 2
I 3 2
C 1 5
I 4 5
I 2 4
C 3 5
I 1 3
C 1 5
S
```

**Sample Output 2:**

>输出样例 2$：

```c
no
no
yes
yes
The network is connected.
```

*Answer:*

> *答案：*

```c
#define _CRT_SECURE_NO_WARNINGS
#include<stdio.h>
#include<stdlib.h>
#define MAXN 10010

int n;
int cnt;
int i = 0;

int root[MAXN];

void formal(int root[], int n) {
    for (int i = 1; i <= n; i++) {
        root[i] = i;   
    }
    cnt = n;
}

void dad(int a1, int a2) {

    int r1 = find(a1);
    int r2 = find(a2);
    if (r1 != r2) {
        root[r2] = r1;    cnt--;
    }

}

int find(int a) {
    if (a != root[a]) {
        root[a] = find(root[a]);
        //cnt--;
    }
    return root[a];
}

void order() {
    char ch;
    int a1, a2;
    while (1) {
scanf(" %c", &ch);
    if (ch == 'S') {
        return;
    }
    scanf("%d %d", &a1, &a2);
    if (ch == 'C') {
        check(a1, a2);
    }
    if (ch == 'I') {
        dad(a1, a2);
    }
    }
    
}

void check(int a1, int a2) {
    if (find(a1) ==find(a2)) {
        printf("yes\n");
    }
    else {
        printf("no\n");
    }
}

int main() {
    scanf("%d", &n);
    formal(root, n);
    order();
    if (cnt == 1) {
        printf("The network is connected.\n");
    }
    else {
        printf("There are %d components.", cnt);
    }
    return 0;

}
```

---

#### (14) Union / Find (PTA)

>并查集

Please fill in the blanks in the program which performs `Find` as a Union / Find operation with path compression.

>请补全程序中的空白部分，该程序通过路径压缩实现并查集操作中的查找（Find）功能。

```c
SetType Find ( ElementType X, DisjSet S )
{   
   ElementType root, trail, lead;

   for ( root = X; S[root] > 0; @@ ) ;     // root=S[root]
   for ( trail = X; trail != root; trail = lead ) {
      lead = S[trail] ;   
      @@;      // S[trail]=root
   } 
   return root;
}
```

---

### 2. 判断题 && 选择题 (PTA)

#### 2.1 判断题

###### (1) HW 1.1

The major task of algorithm analysis is to analyze the time complexity and the space complexity.

>算法分析的主要任务是分析算法的时间复杂度和空间复杂度。

*Answer*：**T**

---

###### (2) HW 1.2

The Fibonacci number sequence $\{F_N\}$ is defined as: $F_0 = 0$, $F_1 = 1$, $F_N = F_{N-1} + F_{N-2}$, $N=2, 3, ....$ The time complexity of the function which calculates $F_N$ recursively is $\Theta(N!)$.

>斐波那契数列 ${F_N}$ 定义为：$F_0=0$，$F_1=1$，$F_N=F_{N−1}+F_{N−2}（N=2,3,…）$。递归计算 $F_N$ 的函数的时间复杂度为 $Θ(N!)$。

*Answer*：**F**

---

###### (3) HW 1.3

$O(N^2)$ is the same as $O(1 + 2 + 3 + \dots + N)$.

> 时间复杂度 $O(N_2)$ 与 $O(1+2+3+⋯+N)$ 等价。

*Answer*：**T**

---

###### :star: (4) HW 1.4

For the following piece of code, the lowest upper bound of the time complexity is $O(N^3)$.

> 对于下面这段代码，其时间复杂度的最小上界为 $O(N^3)$。

```c
if ( A > B ){     
  for ( i=0; i<N*2; i++ )         
    for ( j=N*N; j>i; j-- )             
      C += A; 
}
else {     
  for ( i=0; i<N*N/100; i++ )         
    for ( j=N; j>i; j-- ) 
      for ( k=0; k<N*3; k++)
        C += B; 
} 
```

*Initial Answer*：**F**  :x:

*Answer*：**T**  :white_check_mark:

---

###### (5) HW 1.5

$(logn)^{100}$ is $O(n^{0.01})$.

>$(logn)^{100}$ 的时间复杂度为 $O(n^{0.01})$。

*Answer*：**T**

---

###### (6) HW 2.1

For a sequentially stored linear list of length $N$, the time complexities for deleting the first element and inserting the last element are $O(1)$ and $O(N)$, respectively.

> 对于一个长度为 $N$ 的顺序存储线性表，删除第一个元素的时间复杂度为 $O(1)$，在表尾插入元素的时间复杂度为 $O(N)$。

*Answer*：**F**

---

###### (7) HW 2.2

If a linear list is represented by a linked list, the addresses of the elements in the memory must be consecutive.

>如果线性表采用链表表示，则其元素在内存中的地址必须是连续的。

*Answer*：**F**

---

###### (8) HW 3.1

In most restaurants, we follow one principle called "First come, first served". This principle can be implemented by a stack.

>在大多数餐厅，我们遵循“先到先服务”的原则。该原则可以用栈来实现。

*Answer*：**F**

---

###### (9) HW 3.2

When *n* elements are pushed into a stack, they may be popped in a different order.  But if they are inserted into a queue, they will always be deleted in the same order as the insertions.

>当 $n$ 个元素入栈时，它们出栈的顺序可能不同。 但如果将它们插入队列中，则删除顺序一定与插入顺序相同。

*Answer*：**T**

---

###### (10) HW 4.1

It is always possible to represent a tree by a one-dimensional integer array.  

>总是可以用一维整数数组来表示一棵树。

*Answer*：**T**

---

###### (11) HW 4.2

There exists a binary tree with $2016$ nodes in total, and with $16$ nodes having only one child.

>存在一棵总共有 $2016$ 个结点的二叉树，其中有 $16$ 个结点只有一个孩子。

*Answer*：**F**

---

###### (12) HW 5.1

In a binary search tree, the keys on the same level from left to right must be in sorted (non-decreasing) order.

> 在二叉搜索树中，同一层上从左到右的关键字必须呈有序（非递减）顺序。

*Answer*：**T**

---

###### (13) HW 5.2

Given a binary search tree with 20 integer keys which include 4, 5, and 6, if 4 and 6 are on the same level, then 5 must be their parent. 

>给定一棵包含 $20$ 个整数关键字的二叉搜索树，其中包含 $4$、$5$、$6$。 如果 $4$ 和 $6$ 在同一层，那么 $5$ 一定是它们的父结点。

*Answer*：**F**

---

###### (14) HW 5.3

The time complexity of searching in a binary search tree is the same as that of binary search.

> 在二叉搜索树中查找的时间复杂度与二分查找相同。

*Answer*：**F**

---

###### (15) HW 6.1

The inorder traversal sequence of any min-heap must be in sorted order.

>任意最小堆的中序遍历序列一定是有序的。

*Answer*：**F**

---

###### :star:(16) HW 6.2

If a complete binary tree with 136 nodes is stored in an array (root at position 1), then the node at position 12 precedes the node at position 95 in its preorder traversal sequence.

>如果一棵有136个结点的完全二叉树按数组存储（根结点在位置1），那么在前序遍历序列中，位置12的结点出现在位置95的结点之前。

*Answer*：**F**

---

###### (17) HW 7.1

A segment tree can be used to find the greatest common divisor (GCD) of any index range.

>线段树可用于求解任意下标区间的最大公约数（GCD）。

*Answer*：**T**

---

###### (18) HW 7.2

In *Union / Find* algorithm, if *Unions* are done by size, the depth of any node must be no more than $N/2$, but not $O(logN)$. 

>在并查集算法中，如果按大小执行合并操作，则任意结点的深度一定不超过 $N/2$，而不是 $O (logN)$。

*Answer*：**F**

---

#### 2.2 选择题

###### (1) HW 1.1

Let $n$ be a non-negative integer representing the size of input.  The time complexity of the following piece of code is:

>设 $n$ 为表示输入规模的非负整数，则下面这段代码的时间复杂度为：

```c
x = 0;
while ( n >= (x+1)*(x+1) )
    x = x+1;
```

**A**. $O(\log n)$

**B**. $O(n^{1/2})$  :white_check_mark:

**C**. $O(n)$

**D**. $O(n^2)$

---

###### (2) HW 1.2

The recurrent equations for the time complexities of programs P1 and P2 are:

>程序 P1 和 P2 的时间复杂度的递推方程如下：

- P1: $T(1) = 1, T(N) = T(N/3) + 1$
- P2: $T(1) = 1, T(N) = 3T(N/3) + 1$

Then the correct conclusion about their time complexities is:

> 则关于它们时间复杂度的正确结论是：

**A. they are both $O(\log N)$**

**B. $O(\log N)$ for P1, $O(N)$ for P2**  :white_check_mark:

**C. they are both $O(N)$**

**D. $O(\log N)$ for P1, $O(N \log N)$ for P2**

---

###### (3) HW 1.3

Which of the following pairs of functions has the same speed of growth:

>下列哪一对函数的增长速度相同？

**A**. $2^N$ and $N^N$

**B**. $N$ and $2/N$

**C**. $N^2 logN$ and $N logN^2$

**D**. $N logN^2$ and $N logN$  :white_check_mark:

---

###### (4) HW 1.4

To judge an integer $N$ ($> 10$) is prime or not, we need to check if it is divisible by any odd number from $3$ to $\sqrt{N}$. The time complexity of this algorithm is __.

>要判断一个大于 $10$ 的整数 $N$ 是否为素数，我们需要检查它能否被 $3$ 到 $\sqrt{N}$ 之间的任意奇数整除。该算法的时间复杂度为：

**A**. $O(N/2)$

**B**. $O(\sqrt{N})$  :white_check_mark:

**C**. $O(\sqrt{N} logN)$

**D**. $O(0.5logN)$

---

###### (5) HW 1.5

The Fibonacci number sequence $\{F_N\}$ is defined as: $F_0 = 0, F_1 = 1, F_N = F_{N-1} + F_{N-2}, N$$=$$2$, $3$, .... The space complexity of the function which calculates $F_N$ recursively is:

> 斐波那契数列 $\{F_N\}$ 定义为： $F_0 = 0, F_1 = 1, F_N = F_{N-1} + F_{N-2}, N$$=$$2$, $3$, ...。递归计算 $F_N$ 的函数的空间复杂度为：

**A**. $O(logN)$

**B**. $O(N)$  :white_check_mark:

**C**. $O(F_N)$

**D**. $O(N!)$

---

###### (6) HW 1.6

Given the following four algorithms with their runtimes for problem size $100$ and their time complexities:

>给定下面四个算法，它们在问题规模为 $100$ 时的运行时间及其时间复杂度如下：

| Algorithm | Runtime | Time Complexity |
| :---: | :---: | :---: |
| $A$ | $100$ | **$O(N)$** |
| $B$ | $30$ | **$O(N^2)$** |
| $C$ | $30$ | **$O(N^3)$** |
| $D$ | $10$ | **$O(N^4)$** |

Which algorithm is the fastest for problem size $200$?

>对于问题规模为 $200$ 的情况，哪个算法最快？

**A**. **A**

**B**. **B**  :white_check_mark:

**C**. **C**

**D**. **D**

---

###### (7) HW 2.1

If the most commonly used operations are to visit a random position and to insert and delete the last element in a linear list, then which of the following data structures is the most efficient?

>如果线性表中最常用的操作是访问随机位置，以及在表尾插入和删除元素，那么下列哪种数据结构效率最高？

**A. doubly linked list (双向链表)**

**B. singly linked circular list (单向循环链表)**

**C. doubly linked circular list with a dummy head node (带头结点的双向循环链表)**

**D. sequential list (顺序表)**  :white_check_mark:

---

###### (8) HW 2.2

To merge two singly linked ascending lists, both with $N$ nodes, into one singly linked ascending list, the minimum possible number of comparisons is:

> 将两个各有 N 个结点的**递增单链表**归并为一个递增单链表，最少需要进行的比较次数是：

**A**. $1$

**B**. $N$  :white_check_mark:

**C**. $2N$

**D**. $NlogN$

---

###### (9) HW 2.3

Given a doubly linked list `L` with $n (n≥3)$ nodes and a dummy header. Each node has the structure where `p₂` and `p₁` are pointers to its immediate predecessor and immediate successor, respectively. The pointer head points to the head node, and the pointer `cur = head`. Now you are supposed to change `p₂` of every node in `L` to the immediate successor of `p₁`. If the node does not exist, the pointer must be `NULL`. Then among the following statements, which one can get the job done correctly?

> 给定一个带有头结点、包含 $n(n≥3)$ 个结点的双向链表 `L`。每个结点包含指针 `p₂` 和 `p₁`，分别指向其直接前驱和直接后继。指针 `head` 指向头结点，且 `cur = head`。现要求将链表中每个结点的 `p₂` 修改为：`p₁` 的直接后继。若该结点不存在，则指针必须置为 `NULL`。以下哪段代码可以正确完成该操作？

**A**. `while(cur!=NULL){cur->p2=cur->p1->p1; cur=cur->p1;}`

**B**. `while(cur!=NULL&&cur->p2!=NULL){cur->p2=cur->p1->p1; cur=cur->p1;}`

**C**. `while(cur!=NULL){if(cur->p1!=NULL){cur->p2=cur->p1->p1; cur=cur->p1;}}`

**D**. `while(cur!=NULL){if(cur->p1!=NULL) cur->p2=cur->p1->p1; else cur->p2=NULL; cur=cur->p1;}`  :white_check_mark:

---

###### :star:(10) HW 3.1

Push $5$ characters `ooops` onto a stack. In how many different ways that we can pop these characters and still obtain `ooops` ?

> 将 $5$ 个字符 `ooops` 压入栈中，有多少种不同的出栈方式可以仍然得到 `ooops`？

**A**. **1**

**B**. **3**

**C**. **5**  :white_check_mark:（卡塔兰数：1，1，2，5，14，42，132，429）

**D**. **6**

------

###### (11) HW 3.2

Represent a queue by a singly linked list. Given the current status of the linked list as `1->2->3` where `x->y` means `y` is linked after ``x. Now if $4$ is enqueued and then a dequeue is done, the resulting status must be:

> 用单链表表示一个队列，当前链表状态为 `1->2->3`（`x->y` 表示 `y` 接在 `x` 后面）。现将 $4$ 入队，然后执行一次出队，最终状态一定是：

**A**. **1->2->3**

**B**. **2->3->4**  :white_check_mark:

**C**. **4->1->2**

**D**. **the solution is not unique**

------

###### (12) HW 3.3

Suppose that an array of size $6$ is used to store a circular queue, and the values of `front` and `rear` are $0 $and $4$, respectively. Now after $2$ dequeues and $2$ enqueues, what will the values of `front` and `rear` be?

> 假设用大小为 6 的数组存储一个循环队列，`front` 和 `rear` 分别为 0 和 4。现执行 2 次出队、2 次入队后，`front` 和 `rear` 的值为？

**A**. **2 and 0**  :white_check_mark:

**B**. **2 and 2**

**C**. **2 and 4**

**D**. **2 and 6**

------

###### (14) HW 3.4

Suppose that all the integer operands are stored in the stack $S_1$, and all the operators in the other stack $S_2$. The function `F()` does the following operations sequentially:

(1) Pop two operands a and b from $S_1$;

(2) Pop one operator op from $S_2$;

(3) Calculate `b` `op` `a`; and

(4) Push the result back to $S_1$.

Now given { $5$, $8$, $3$, $2$ } in $S_1$ (where $2$ is at the top), and { `*`, `-`, `+` } in $S_2$ (where `+` is at the top). What is remained at the top of $S_1$ after `F()` is executed $3$ times?

> 整数操作数存在栈 $S₁$，运算符存在栈 $S₂$。函数 `F()` 依次执行：
>
> (1) 从 $S₁$ 弹出两个操作数 `a`、`b`
>
> (2) 从 $S₂$ 弹出一个运算符 `op`
>
> (3) 计算 `b` `op` `a`
>
> (4) 结果压回 $S₁$
>
> 已知 $S₁$：{$5$, $8$, $3$, $2$}（$2$ 在栈顶），$S₂$：{`*`, ` -`, `+`}（`+` 在栈顶）。`F()` 执行 $3$ 次后，$S₁$ 栈顶为？

**A**. **-15**

**B**. **15**  :white_check_mark:

**C**. **-20**

**D**. **20**

------

###### :star: (15) HW 3.5

Push and pop { $1$, $2$, $3$, $4$, $5$, $6$, $7$ } sequentially into then out of a stack. Suppose that each number is pushed into a queue right after it gets out of the stack, which of the following dequeue sequences is **possible**? **Note: making $4$ consecutive pops are NOT allowed in this stack.**

> 将 {$1$, $2$, $3$, $4$, $5$, $6$, $7$} 依次入栈、出栈，每个数字一出栈就立刻进入队列。下列哪个出队序列是可能的？注意：该栈**不允许连续 4 次出栈**。

**A**. **2, 6, 5, 4, 7, 3, 1**   :white_check_mark:

**B**. **1, 2, 3, 6, 7, 4, 5**   :x: （先 $5$ 后 $4$，本项错）

**C**. **3, 6, 5, 4, 7, 1, 2**

**D**. **1, 4, 7, 6, 5, 3, 2**  :x:  （本项错，连续 $4$ 次出栈，选择 $D$ 是错的）

---

###### (16) HW 4.1

Given a tree of degree $3$. Suppose that there are $3$ nodes of degree $2$ and $2$ nodes of degree $3$. Then the number of leaf nodes must be ____.

> 给定一棵度为 $3$ 的树。已知有 $3$ 个度为 $2$ 的结点和 $2$ 个度为 $3$ 的结点，则叶子结点的个数一定是：

**A**. **5**

**B**. **6**

**C**. **7**

**D**. **8**  :white_check_mark:

------

###### (17) HW 4.2

If a general tree $T$ is converted into a binary tree $BT$, then which of the following $BT$ traversals gives the same sequence as that of the post-order traversal of $T$?

> 若将一棵普通树 $T$ 转换为二叉树 $BT$，则 $BT$ 的哪种遍历序列与 $T$ 的后序遍历序列相同？

**A. Pre-order traversal** (前序遍历)

**B. In-order traversal** (中序遍历)  :white_check_mark:

**C. Post-order traversal** (后序遍历)

**D. Level-order traversal** (层序遍历)

------

###### (18) HW 4.3

Given the shape of a binary tree shown by the figure below. If its inorder traversal sequence is { $E$, $A$, $D$, $B$, $F$, $H$, $C$, $G$ }, then the node on the same level of $C$ must be:

> 给定下图所示形状的二叉树，若其中序遍历序列为 {$E$, $A$, $D$, $B$, $F$, $H$, $C$, $G$}，则与结点 $C$ 在同一层的结点是：

![](https://images.ptausercontent.com/19185355-2b08-4b74-9bb7-8262720437bd.jpg)

**A. D and G**

**B. E ** :white_check_mark:

**C. B**

**D. A and H**

------

###### (19) HW 4.4

Among the following threaded binary trees (the threads are represented by dotted curves), which one is the postorder threaded tree?

> 在下列线索二叉树中（线索用虚线表示），哪一棵是**后序线索二叉树**？

**A**. ![](https://images.ptausercontent.com/64)

**B**.![](https://images.ptausercontent.com/65)  :white_check_mark:

**C**. ![](https://images.ptausercontent.com/66)

**D**. ![](https://images.ptausercontent.com/67)

---

###### (20) HW 5.1

Given a binary search tree as shown in the following figure. Which of the following relationships is correct with respect to the given tree?

> 给定下图所示的一棵二叉搜索树，关于这棵树下列哪个关系是正确的？

![](https://images.ptausercontent.com/c303e1c2-3dff-4e7b-8386-b2af45a52e02.JPG)

**A**. **x1<x2<x5**

**B**. **x1<x4<x5**

**C**. **x3<x5<x4**  :white_check_mark:

**D**. **x4<x3<x5**

------

###### (21) HW 5.2

Given the structure of a binary search tree (as shown in the figure), which one of the following insertion sequences is impossible?

> 给定一棵二叉搜索树的结构（如图所示），下列哪个插入序列是不可能的？

![](https://images.ptausercontent.com/84984823-130d-462a-ad9e-ee6457b1ce56.jpg)

**A**. **83 67 91 98 20 75**

**B**. **83 67 75 91 20 98**

**C**. **83 91 75 67 20 98**  :white_check_mark:

**D**. **83 91 98 67 75 20**

------

###### (22) HW 5.3

Given a binary search tree with its preorder traversal sequence { $8$, $2$, $15$, $10$, $12$, $21$ }. If $8$ is deleted from the tree, which one of the following statements is FALSE?

> 给定一棵二叉搜索树，其先序遍历序列为  { $8$, $2$, $15$, $10$, $12$, $21$ }。若从树中删除 $8$，则下列哪个叙述是**错误**的？

**A**. **One possible preorder traversal sequence of the resulting tree may be { 2, 15, 10, 12, 21 } (得到的树的一种可能先序遍历序列可以是 {2, 15, 10, 12, 21})**

**B**. **One possible preorder traversal sequence of the resulting tree may be { 10, 2, 15, 12, 21 } (得到的树的一种可能先序遍历序列可以是 {10, 2, 15, 12, 21})**

**C**. **One possible preorder traversal sequence of the resulting tree may be { 15, 10, 2, 12, 21 } (得到的树的一种可能先序遍历序列可以是 {15, 10, 2, 12, 21})**  :white_check_mark:

**D**. **It is possible that the new root may have 2 children (新的根结点有可能有两个孩子)**

------

###### (23) HW 5.4

Among the following binary trees, which one can possibly be the decision tree (the external nodes are excluded) for binary search?

> 在下列二叉树中，哪一棵可能是二分查找的判定树（不含外部结点）？

**A**. ![](https://images.ptausercontent.com/282)  :white_check_mark:

**B**. ![](https://images.ptausercontent.com/283)

**C**. ![](https://images.ptausercontent.com/284)

**D**. ![](https://images.ptausercontent.com/285)

------

###### (24) HW 5.5

For a binary search tree, in which order of traversal that we can obtain a non-decreasing sequence?

> 对于一棵二叉搜索树，按哪种遍历次序可以得到一个非递减序列？

**A**. **preorder traversal (前序遍历)**

**B**. **postorder traversal (后序遍历)**

**C**. **inorder traversal (中序遍历)**  :white_check_mark:

**D**. **level-order traversal (层序遍历)**

------

###### (25) HW 5.6

Consider the following operations performed on an initially empty Binary Search Tree (BST):

Insert: $100$, $50$, $150$, $25$, $75$, $125$, $175$

Delete: $100$ (replaced with its in-order successor)

Insert: $110$

After these operations, which node will be the in-order successor of $75$ in the final BST?

> 对一棵初始为空的二叉搜索树执行以下操作：
>
> 插入：$100$, $50$, $150$, $25$, $75$, $125$, $175$
>
> 删除：$100$（用其中序后继替代）
>
> 插入：$110$
>
> 操作结束后，最终 BST 中 $75$ 的中序后继结点是？

**A**. **125.**

**B**. **110.**  :white_check_mark:

**C**. **50.**

**D**. **The in-order successor does not exist for 75. (75 不存在中序后继)**

------

###### (26) HW 5.7

The following figure shows a binary search tree, with `k1`, `k2` and `k3` being the keys saved at the corresponding nodes. In the subtree `T`, the key `x` of any node must satisfy the inequality

> 下图为一棵二叉搜索树，`k1`、`k2`、`k3` 为对应结点的关键字。在子树 `T` 中，任意结点的关键字 `x` 必须满足不等式：

![](https://images.ptausercontent.com/1b0e6d01-0205-4f49-8f63-024797be79e7.jpg)

**A**. **x < k1**

**B**. **x > k2**

**C**. **k1 < x < k3**

**D**. **k3 < x < k2**  :white_check_mark:

---

###### (27) HW 6.1

In a max-heap with $n(>1)$ elements, the array index of the minimum key may be .

> 在含有 $n(n>1)$ 个元素的最大堆中，最小关键字的数组下标可能是__。

**A. $1$**

**B. $⌊n/2⌋−1$**

**C. $⌊n/2⌋$**

**D. $⌊n/2⌋+2$**  :white_check_mark:

------

###### (28) HW 6.2

Using the linear algorithm to build a min-heap from the sequence {$15$, $26$, $32$, $8$, $7$, $20$, $12$, $13$, $5$, $19$}, and then insert $6$. Which one of the following statements is **FALSE** ?

> 使用线性建堆算法将序列 {$15$, $26$, $32$, $8$, $7$, $20$, $12$, $13$, $5$, $19$} 建成最小堆，然后插入 $6$。下列叙述中 **错误** 的是？

**A. The root is 5 (根结点是 5)**

**B. The path from the root to 26 is {5, 6, 8, 26} (从根到 26 的路径是 {5, 6, 8, 26})**

**C. 32 is the left child of 12 (32 是 12 的左孩子)**  :white_check_mark:

**D. 7 is the parent of 19 and 15 (7 是 19 和 15 的父结点)**

------

###### (29) HW 6.3

If a $d$-heap is stored as an array, for an entry located in position $i$, the parent, the first child and the last child are at:

> 如果一个 $d$ 叉堆采用数组存储，对于位于位置 $i$ 的结点，其父结点、第一个孩子结点和最后一个孩子结点的下标分别是：

**A. $⌈(i+d−2)/d⌉$, $(i−2)d+2$, and $(i−1)d+1$**

**B. $⌈(i+d−1)/d⌉$, $(i−2)d+1$, and $(i−1)d$**

**C. $⌊(i+d−2)/d⌋$, $(i−1)d+2$, and $id+1$**  :white_check_mark:

**D. $⌊(i+d−1)/d⌋$, $(i−1)d+1$, and $id$**

------

###### (30) HW 6.4

Insert {$28$, $15$, $42$, $18$, $22$, $5$, $40$} one by one into an initially empty min-heap. The preorder traversal sequence of the resulting tree is:

> 将 {$28$, $15$, $42$, $18$, $22$, $5$, $40$} 逐个插入初始为空的最小堆。最终树的先序遍历序列是：

**A. 5, 18, 15, 28, 22, 42, 40**

**B. 5, 15, 18, 22, 28, 42, 40**

**C. 5, 18, 28, 22, 15, 42, 40**  :white_check_mark:

**D. 5, 15, 28, 18, 22, 42, 40**

------

###### (31) HW 6.5

For a binary tree, if its pre-order travel sequence is {$4$, $2$, $1$, $3$, $6$, $5$, $7$}, and its in-order travel sequence is { $1$, $2$, $3$, $4$, $5$, $6$, $7$ }, then which of the following statement is **FALSE**?

> 已知一棵二叉树的先序遍历序列为 {$4$, $2$, $1$, $3$, $6$, $5$, $7$}，中序遍历序列为 { $1$, $2$, $3$, $4$, $5$, $6$, $7$ }。下列叙述中 **错误** 的是？

**A. This is a complete binary tree. (这是一棵完全二叉树)**

**B. 4 is the parent of 3. (4 是 3 的父结点)**  :white_check_mark:

**C. All the odd numbers are at leaf nodes. (所有奇数都位于叶结点)**

**D. This is a binary search tree. (这是一棵二叉搜索树)**

------

###### (32) HW 6.6

If a binary search tree of $N$ nodes is complete, which one of the following statements is **FALSE**?

> 如果一棵包含 $N$ 个结点的二叉搜索树是完全二叉树，下列叙述中 **错误** 的是？

**A. the average search time for all nodes is $O (logN)$ (所有结点的平均查找时间为 $O (logN)$)**

**B. the minimum key must be at a leaf node (最小关键字一定在叶结点上)**

**C. the maximum key must be at a leaf node (最大关键字一定在叶结点上)**  :white_check_mark:

**D. the median node must either be the root or in the left subtree (中位数结点一定是根结点或在左子树中)**

---

###### (33) HW 7.1

The array representation of a disjoint set containing numbers $0$ to $8$ is given by { $1$, $-4$, $1$, $1$, $-3$, $4$, $4$, $8$, $-2$ }.

> 包含数字 $0$ 到 $8$ 的不相交集合的数组表示为 { $1$, $-4$, $1$, $1$, $-3$, $4$, $4$, $8$, $-2$ }。

Then to union the two sets which contain $6$ and $8$ (with union-by-size), the index of the resulting root and the value stored at the root are:

> 现按大小合并，将包含 $6$ 和 $8$ 的两个集合合并，合并后根结点的下标及其存储的值分别是：

**A. 1 and -6（1 和 -6）**

**B. 4 and -5（4 和 -5）**  :white_check_mark:

**C. 8 and -5（8 和 -5）**

**D. 8 and -6（8 和 -6）**

------

###### (34) HW 7.2

A relation $R$ is defined on a set $S$.

> 集合 $S$ 上定义了一个关系 $R$。

If for every element $e$ in $S$, "$e$ $R$ $e$" is always true, then $R$ is said to be __ over $S$.

> 如果对 $S$ 中的每个元素 $e$，都有 “$e$ $R$ $e$” 恒成立，则称 $R$ 在 $S$ 上是 ____。

**A. consistent（相容的 / 一致的）**

**B. symmetric（对称的）**

**C. transitive（传递的）**

**D. reflexive（自反的）**  :white_check_mark:

------

###### (35) HW 7.3

Let T be a tree created by union-by-size with N nodes, then the height of T can be  .

> 设 T 是一棵由 N 个结点通过**按大小合并**得到的树，则 T 的高度可以是：

**A. at most log₂(N)+1（至多 log₂(N)+1）**  :white_check_mark:

**B. at least log₂(N)+1（至少 log₂(N)+1）**

**C. as large as N（最大可以达到 N）**

**D. anything that is greater than 1（任何大于 1 的值）**

------

###### (36) HW 7.4

What is a segment tree primarily used for?

> 线段树主要用途是什么？

**A. Sorting elements（对元素排序）**

**B. Finding minimum/maximum in a range（区间查询最小值 / 最大值）**  :white_check_mark:

**C. Finding the sum of a given set of integers（求一组整数的和）**

**D. Finding a given string from a set of strings（在字符串集合中查找指定字符串）**

---

### 3. 编程题 && 函数题 (Others)

#### (1) Stone Age Problem (Luogu)

> 石器时代问题

You are given an array $ a $ of $ n $ integers. You are also given $ q $ queries of two types:

- Replace $ i $ -th element in the array with integer $ x $ .
- Replace each element in the array with integer $ x $ .

After performing each query you have to calculate the sum of all elements in the array.

> 数组 $a$ 有 $n$ 个元素，需要进行 $q$ 次操作。
> - 操作 1：将第 $i$ 号元素改为 $x$
> - 操作 2：将数组中所有元素改为 $x$
> 
>每次操作完成后，输出当前数组中所有元素的总和。

**Input Format:**

>**输入格式：**

The first line contains two integers $ n $ and $ q $ ( $ 1 \le n, q \le 2 \cdot 10^5 $ ) — the number of elements in the array and the number of queries, respectively.

The second line contains $ n $ integers $ a_1, \ldots, a_n $ ( $ 1 \le a_i \le 10^9 $ ) — elements of the array $ a $ .

Each of the following $ q $ lines contains a description of the corresponding query. Description begins with integer $ t $ ( $ t \in \{1, 2\} $ ) which denotes a type of the query:

- If $ t = 1 $ , then two integers $ i $ and $ x $ are following ( $ 1 \le i \le n $ , $ 1 \le x \le 10^9 $ ) — position of replaced element and it's new value.
- If $ t = 2 $ , then integer $ x $ is following ( $ 1 \le x \le 10^9 $ ) — new value of each element in the array.

>第一行两个整数 $n,q(1\le n,q \le2\times 10^5)$
>
>第二行 $n$ 个整数，表示 $a$ 中的元素 $(1\le a_i\le10^9)$
>
>接下来有 $q$ 行，首先输入一个整数 $t(t\in {1,2})$
>
>- 若 $t=1$，接着输入两个整数 $i,x(1\le i \le n, 1\le x \le 10^9)$
>- 若 $t=2$，接着输入一个整数 $x(1\le x \le 10^9)$

**Output Format:**

>**输出格式：**

Print $ q $ integers, each on a separate line. In the $ i $ -th line print the sum of all elements in the array after performing the first $ i $ queries.

>共 $q$ 行，每行一个整数，表示当前数组 $a$ 中所有元素的和。

**Input Sample $1$**

>**输入样例 $1$**

```c
5 5
1 2 3 4 5
1 1 5
2 10
1 5 11
1 4 1
2 1
```

**Output Sample $1$**

>**输出样例 $1$**

```c
19
50
51
42
5
```

**Note / Hint:**

> **注意 / 提示：**

Consider array from the example and the result of performing each query:

>考虑样例中的数组以及执行每个查询后的结果：

1. Initial array is $ [1, 2, 3, 4, 5] $ .
2. After performing the first query, array equals to $ [5, 2, 3, 4, 5] $ . The sum of all elements is $ 19 $ .
3. After performing the second query, array equals to $ [10, 10, 10, 10, 10] $ . The sum of all elements is $ 50 $ .
4. After performing the third query, array equals to $ [10, 10, 10, 10, 11 $ \]. The sum of all elements is $ 51 $ .
5. After performing the fourth query, array equals to $ [10, 10, 10, 1, 11] $ . The sum of all elements is $ 42 $ .
6. After performing the fifth query, array equals to $ [1, 1, 1, 1, 1] $ . The sum of all elements is $ 5 $ .

>1. 初始数组为 $[1,2,3,4,5]$。
>2. 执行第一个查询后，数组变为 $[5,2,3,4,5]$。所有元素的和为 $19$。
>3. 执行第二个查询后，数组变为 $[10,10,10,10,10]$。所有元素的和为 $50$。
>4. 执行第三个查询后，数组变为 $[10,10,10,10,11]$。所有元素的和为 $51$。
>5. 执行第四个查询后，数组变为 $[10,10,10,1,11]$。所有元素的和为 $42$。
>6. 执行第五个查询后，数组变为 $[1,1,1,1,1]$。所有元素的和为 $5$。

*Answer:*

> *答案：*

```c
#define _CRT_SECURE_NO_WARNINGS
#include<stdio.h>
#include<stdlib.h>
#define MAXN 10010

typedef long long ll;

int main() {
    int n;
    scanf("%d", &n);
    int q;
    scanf("%d", &q);
    ll* a = (ll*)malloc((n + 1) * sizeof(ll));
    ll sum = 0;
    for (int i = 1; i <= n; i++) {
        scanf("%lld", &a[i]);
        sum += a[i];
    }
    int flag = 0;
    ll all_val = 0;
    while (q > 0) {
        int ju;
        scanf("%d", &ju);
        if (ju == 1) {
            ll i, x;
            scanf("%lld %lld", &i, &x);
            ll delta;
            if (flag == 0) {
                delta = a[i];
            }
            else {
                delta = all_val;
                a[i] = all_val;
            }

            sum += x - delta;
            a[i] = x;
        }
        else if (ju == 2) {
            ll x;
            scanf("%lld", &x);
            sum = n * x;
            all_val = x;
            /*for (int i = 1; i <= n; i++) {
                a[i] = x;
            }*/
            flag = 1;
        }
        printf("%lld\n", sum);
        q--;
    }
    return 0;
}
```

---

#### (2) New Binary Tree (Luogu)

>新二叉树

Given a binary tree, output its preorder traversal.

>输入一串二叉树，输出其前序遍历。

**Input Format:**

>**输入格式：**

The first line contains the number of nodes $n$ ($1 \leq n \leq 26$).

Each of the next $n$ lines contains three characters: the first character is the node, and the next two characters are its left and right children, respectively. In particular, the testdata guarantees that the node appearing on the first of these $n$ lines is the root node.

A null child is denoted by `*`.

> 第一行为二叉树的节点数 $n$。($1≤n≤26$)
>后面 $n$ 行，第一个字母为节点，后两个字母分别为其左右儿子。特别地，数据保证第一行读入的节点必为根节点。
>空节点用 `*` 表示

**Output Format:**

>**输出格式：**

The preorder traversal of the binary tree.

>二叉树的前序遍历。

**Sample Input $1$**

>**输入样例 $1$**

```c
6
abc
bdi
cj*
d**
i**
j**
```

**Sample Input $2$**

>**输出样例 $2$**

```c
abdicj
```

*Answer:*

>*答案：*

```c
#define _CRT_SECURE_NO_WARNINGS
#include<stdio.h>
#include<stdlib.h>
#define MAXN 30

int n;

typedef struct TreeNode {
    char data;
    struct TreeNode* left;
    struct TreeNode* right;
}TreeNode, * BiTree;

char s[30][3];

void create(BiTree* T,char j) {

    if (j == '*') {
        *T = NULL;
        return;
    }
    *T = (BiTree)malloc(sizeof(TreeNode));
    (*T)->data = j;

    char l = 0;
    char r = 0;
    for (int i = 0; i < n; i++) {
        if (s[i][0] == j) {
            l = s[i][1];
            r = s[i][2];
        }
    }
    create(&(*T)->left,l);
    create(&(*T)->right,r);
}

void preorder(BiTree T) {
    if (T == NULL) {
        return;
    }
    printf("%c", T->data);
    preorder(T->left);
    preorder(T->right);
}

int main() {
    BiTree T;
    scanf("%d", &n);
    for (int i = 0; i < n; i++) {
        scanf("%s", s[i]);
    }
    create(&T,s[0][0]);
    
    preorder(T);
}
```

---

#### (3) Cutting Trees (Luogu)

>砍树

Lumberjack Mirko needs to cut $M$ meters of wood. This is easy for Mirko because he has a shiny new woodcutting machine that can cut through a forest like wildfire. However, Mirko is allowed to cut only one row of trees.

>伐木工人 Mirko 需要砍 $M$ 米长的木材。对 Mirko 来说这是很简单的工作，因为他有一个漂亮的新伐木机，可以如野火一般砍伐森林。不过，Mirko 只被允许砍伐一排树。

The machine works as follows: Mirko sets a height parameter $H$ (in meters), the machine raises a huge saw blade to height $H$, and it cuts off the part of every tree that is higher than $H$ (of course, trees not higher than $H$ remain unchanged). Mirko then collects the cut-off parts. For example, if a row of trees has heights $20, 15, 10$ and $17$, and Mirko raises the blade to $15$ meters, after cutting the remaining heights will be $15, 15, 10$ and $15$, and Mirko will get $5$ meters from the $1$st tree and $2$ meters from the $4$th tree, $7$ meters in total.

>Mirko 的伐木机工作流程如下：Mirko 设置一个高度参数 $H$（米），伐木机升起一个巨大的锯片到高度 $H$，并锯掉所有树比 $H$ 高的部分（当然，树木不高于 $H$ 米的部分保持不变）。Mirko 就得到树木被锯下的部分。例如，如果一排树的高度分别为 $20,15,10$ 和 $17$，Mirko 把锯片升到 $15$ 米的高度，切割后树木剩下的高度将是 $15,15,10$ 和 $15$，而 Mirko 将从第 $1$ 棵树得到 $5$ 米，从第 $4$ 棵树得到 $2$ 米，共得到 $7$ 米木材。

Mirko cares about the environment, so he will not cut more wood than necessary. This is why he sets the saw blade as high as possible. Help Mirko find the maximum integer height $H$ such that the amount of wood he obtains is at least $M$ meters. In other words, if he raised it by $1$ meter more, he would not obtain $M$ meters of wood.

>Mirko 非常关注生态保护，所以他不会砍掉过多的木材。这也是他尽可能高地设定伐木机锯片的原因。请帮助 Mirko 找到伐木机锯片的最大的整数高度 $H$，使得他能得到的木材至少为 $M$ 米。换句话说，如果再升高 $1$ 米，他将得不到 $M$ 米木材。

**Input Format:**

>**输入格式：**

The first line contains two integers $N$ and $M$, where $N$ is the number of trees and $M$ is the required total length of wood.

>第 $1$ 行 $2$ 个整数 $N$ 和 $M$，$N$ 表示树木的数量，$M$ 表示需要的木材总长度。

The second line contains $N$ integers, the heights of the trees.

>第 $2$ 行 $N$ 个整数表示每棵树的高度。

**Output Format:**

>**输出格式：**

Output a single integer, the highest possible blade height.

>$1$ 个整数，表示锯片的最高高度。

**Sample Input $1$**

>**输入样例 $1$**

```c
4 7
20 15 10 17
```

**Sample Output $1$**

**输出样例 $1$**

```c
15
```

**Sample Input $2$**

>**输入样例 $2$**

```c
5 20
4 42 40 26 46
```

**Sample Output $2$**

>**输出样例 $2$**

```c
36
```

**Note / Hint:**

>**说明 / 提示：**

For $100\%$ of the testdata, $1 \le N \le 10^6$, $1 \le M \le 2 \times 10^9$, tree height $\le 4 \times 10^5$, and the sum of all tree heights $> M$.

>对于 $100\%$ 的测试数据，$1\le N\le10^6$，$1\le M\le2\times10^9$，树的高度 $\le 4\times 10^5$，所有树的高度总和 $>M$。

*Answer:*

>*答案：*

```c
#define _CRT_SECURE_NO_WARNINGS
#include<stdio.h>
#include<stdlib.h>
#define MAXN 10010

typedef long long ll;

ll height(ll a[], ll N, ll h) {
    ll sum = 0;
    for (ll i = 0; i < N; i++) {
        if (a[i] < h) {
            continue;
        }
        else {
            ll delta = a[i] - h;
            sum += delta;
        }
    }
    return sum;
}

int main() {
    ll N, M;
    scanf("%lld %lld", &N, &M);
    ll* tr = (ll*)malloc(N * sizeof(ll));
    ll max = 0;
    for (ll i = 0; i < N; i++) {
        scanf("%lld", &tr[i]);
        if (max < tr[i]) {
            max = tr[i];
        }
    }
    ll m = 0;
    ll left = 0;
    ll right = max;
    while (left <= right) {
        ll mid = left + (right - left) / 2;
        ll sum = height(tr, N, mid);
        if (sum < M) {
            right = mid - 1;
        }
        else {
            left = mid + 1;
            m = mid;
        }
        
    }
    printf("%lld\n", m);
    return 0;
}
```

---

## <center>Part 5：Projects</center>

### (1) Normal-1 Performance Measurement (Search)
Given a list of ordered $N$ integers, numbered from $0$ to $N−1$, checking to see that $N$ is not in this list provides a worst case for many search algorithms.

Consider two algorithms: one is called “sequential search” which scans through the list from left to right; and the other is “binary search” which is introduced in your textbook.  Your tasks are:

- Implement an iterative version and a recursive version of binary search, together with an iterative version and a recursive version of sequential search;
- Analyze the worst case complexities of the above four versions of searching methods;
- Measure and compare the worst case performances of the above four functions for $N = 100, 500, 1000, 2000, 4000, 6000, 8000, 10000$.

To measure the performance of a function, we may use C's standard library `time.h` as the following:

![time.jpg](https://images.ptausercontent.com/a99ccc3a-f9a1-47db-8cb4-bb02f976a722.jpg)

**Note:** 
If a function runs so quickly that it takes less than a tick to finish, we may repeat the function calls for $K$ times to obtain a total run time, and then divide the total time by $K$ to obtain a more accurate duration for a single run of the function.  The repetition factor must be large enough so that the number of elapsed ticks is at least $10$ if we want an accuracy of at least $10$%.

The test results must be listed in the following table:

![table0.jpg](https://images.ptausercontent.com/fab66b35-ffaf-4ab9-932a-afcd1e588ac0.jpg)

The performances of the four functions must be plotted in the same $N$–run_time coordinate system for illustration.

**Grading Policy:**
- Programmer: Implement the four functions ($30$ pts.) and a testing program ($20$ pts.) with sufficient comments.

- Tester: Decide the iteration number $K$ for each test case and fill in the table of results ($8$ pts.).  Plot the run times of the functions ($12$ pts.).  Write analysis and comments ($10$ pts.).

- Report Writer: Write Chapter $1$ ($6$ pts.), Chapter $2$ ($12$ pts.), and finally a complete report ($2$ pts. for overall style of documentation).

**Code:**

```c
#include<stdio.h>
#include<math.h>
#include<time.h>
#include<stdlib.h>

/*设置栈大小为16MB*/
#pragma comment(linker, "/STACK:33554432")

typedef int ElemType;

/*顺序查找迭代版*/
int Sequential_Search_Iterative_(int a[], int n, int element) {
    /*从第一个元素开始遍历，如果找到，返回下标 + 1，并退出改函数*/
    for (int i = 0; i < n; i++) {
        if (a[i] == element) {
            return i + 1;
        }
    }
    /*如果没有找到，返回 - 1*/
    return -1;
}

/*顺序查找递归版*/
int Sequential_Search_Recursive(int a[], int n, int element, int index) {
    /*如果当前下标已经超过了数组长度，说明没有查找到所求元素，返回-1*/
    if (index >= n) {
        return -1;
    }
    /*如果找到了所需元素，返回下标+1*/
    if (a[index] == element) {
        return index + 1;
    }
    /*如果暂时未找到所需元素，则下标 + 1，继续查找*/
    return Sequential_Search_Recursive(a, n, element, index + 1);
}


/*二分查找迭代版*/
int Binary_Search_Iterative_(int a[], int n, int element) {
    //定义左、右边界*/
    int left = 0;
    int right = n - 1;
    /*将当前数组分成两个区间，取得中间坐标，减半查找*/
    while (left <= right) {
        int mid = (left + right) / 2;
        /*当前数组中间下标对应元素即为所需元素，返回下标 + 1，退出*/
        if (element == a[mid]) {
            return mid + 1;
        }
        /*所需元素在当前数组的右半区间*/
        else if (a[mid] < element) {
            left = mid + 1;
        }
        /*所需元素在当前数组的左半区间*/
        else {
            right = mid - 1;
        }
    }
    /*循环结束仍未找到，说明该、所需元素不在该数组内，返回-1*/
    return -1;
}

/*二分查找递归版*/
int Binary_Search_Recursive(int a[], int left, int right, int element) {
    /*检查边界条件是否满足，不满足返回-1*/
    if (left > right) {
        return -1;
    }
    /*将当前数组分半，取得中间坐标，折半查找*/
    int mid = (left + right) / 2;
    /*如果中间坐标对应元素即为所求，返回下标+1，退出该函数*/
    if (a[mid] == element) {
        return mid + 1;
    }
    /*如果所求元素大于当前数组中间下标值所对应的元素，说明所求元素在右半区间*/
    else if (a[mid] < element) {
        return Binary_Search_Recursive(a, mid + 1, right, element);
    }
    /*如果所求元素小于当前数组中间下标值所对应的元素，说明所求元素在左半区间*/
    else {
        return Binary_Search_Recursive(a, left, mid - 1, element);
    }
}

/*对两个递归版函数进行封装,统一接口更好地测量时间*/
int Sequential_Search_Recursive_(int a[], int n, int element) {
    return Sequential_Search_Recursive(a, n, element, 0);
}

int Binary_Search_Recursive_(int a[], int n, int element) {
    return Binary_Search_Recursive(a, 0, n - 1, element);
}
/*测试用例结构体：包含算法名称、函数指针、储存测量结果的数组*/
typedef struct {
    const char* name;     /*算法名称*/
    int (*fun)(int[], int, int);     /*函数指针*/
    double* results;     /*储存测量结果的数组*/
}test;

/*测量结果结构体：包含单次执行时间、循环次数K、时钟滴答数*/
typedef struct {
    double duration;     /*单次执行时间*/
    int K;     /*循环次数K*/
    long ticks;     /*时钟滴答数*/
}Measurement;

Measurement Measure(int (*fun)(int[], int, int), int a[], int n, int element) {
    int K = 1;
    clock_t begin;
    clock_t end;
    double ticks;
    const int target = 20;     /*目标时钟滴答数，用于确定合适的K*/
    do {
        K *= 2;
        begin = clock();
        for (int i = 0; i < K; i++) {
            fun(a, n, element);
        }
        end = clock();
        ticks = (double)(end - begin);
    } while (ticks < target && K < 100000000);     /*防止无限循环*/

    int dummy = 0;     /*用于累加返回值*/
    begin = clock();
    for (int i = 0; i < K; i++) {
        dummy += fun(a, n, element);     /*累加返回值*/
    }
    end = clock();
    long ticks_ = end - begin;     /*实际测量的总时钟滴答数*/
    double second = (double)(end - begin) / CLOCKS_PER_SEC;     /*转换为秒*/
    Measurement Data;
    Data.duration = second / K;     /*平均每次执行时间*/
    Data.K = K;
    Data.ticks = ticks_;
    return Data;
}

int main() {
    /*待测试的数组大小列表*/
    int N_element[] = { 100,500,1000,2000,4000,6000,8000,10000 };
    int N_number = sizeof(N_element) / (sizeof(N_element[0]));

    /*为四种算法分别分配存储时间的数组*/
    double* TimeSeqIter = (double*)malloc(N_number * sizeof(double));
    double* TimeSeqRecur = (double*)malloc(N_number * sizeof(double));
    double* TimeBinIter = (double*)malloc(N_number * sizeof(double));
    double* TimeBinRecur = (double*)malloc(N_number * sizeof(double));

    /*定义四种测试，每个包含名称、函数指针和对应的时间存储数组*/
    test tests[4] = {
        {"SeqIter",Sequential_Search_Iterative_,TimeSeqIter},
        {"SeqRecur",Sequential_Search_Recursive_,TimeSeqRecur},
        {"BinIter",Binary_Search_Iterative_,TimeBinIter},
        {"BinRecur",Binary_Search_Recursive_,TimeBinRecur}
    };

    /*对每个数组大小进行测试*/
    for (int i = 0; i < N_number; i++) {
        int N = N_element[i];
        int* a = (int*)malloc(N * sizeof(int));
        if (a == NULL) {
            return 1;     /*内存分配失败，退出*/
        }
        /*初始化数组为0,1,2,...,N-1，确保有序，便于二分查找*/
        for (int j = 0; j < N; j++) {
            a[j] = j;
        }
        int value = N;     /*查找一个不存在的元素（值为N），以模拟最坏情况（查找失败）*/
        printf("数组大小 N = %d:\n", N);
        /*对四种算法分别进行测量*/
        for (int k = 0; k < 4; k++) {
            Measurement Value = Measure(tests[k].fun, a, N, value);
            tests[k].results[i] = Value.duration;     /*保存平均时间*/
            printf("  %s: duration=%.10f sec  (K=%d, ticks=%ld, total=%.6f sec)\n", tests[k].name, Value.duration, Value.K, Value.ticks, (double)Value.ticks / CLOCKS_PER_SEC);
        }
        free(a);     /*释放当前数组*/
    }

    /*释放动态分配的内存*/
    free(TimeBinIter);
    free(TimeBinRecur);
    free(TimeSeqIter);
    free(TimeSeqRecur);
    return 0;
}
```

---

### (2) Normal-2 A+B with Binary Search Trees

A Binary Search Tree (BST) is recursively defined as a binary tree which has the following properties:
- The left subtree of a node contains only nodes with keys less than the node's key.
- The right subtree of a node contains only nodes with keys greater than or equal to the node's key.
- Both the left and right subtrees must also be binary search trees.

Given two binary search trees `T1` and `T2`, and an integer $N$, you are supposed to find a number $A$ from `T1` and $B$ from `T2` such that `A + B = N`.

**Input Specification**:
Each input file contains one test case. Each case gives the information of `T1`, `T2` and $N$, in the following format:
The first line contains a positive integer $n_1$ ($\le 2\times10^5$ ), which is the number of nodes in T1. Then $n_1$ lines follow, where the $i$-th line contains the key value $k$ ($-2\times10^9 \le k \le 2\times10^9$ ) and the parent node index of the $i$-th node ($0\le i<n_1$ ). Since the root has no parent, its parent index is defined to be $-1$.

After `T1`, `T2` is given in the same format of `T1`.

Finally the last line gives the target $N$ (with the same range of $k$).

**Output Specification**:
For each test case, print in a line `true` if at least one solution does exist, then output all the solutions in the following lines, each in the format `N = A + B`. In case the solution is not unique, you must output them in ascending order of the values of $A$. Note: the same equation should be printed only once. If there is no solution, simply print `false`.

Then print in the last two lines the preorder traversal sequences of `T1` and `T2`, respectively. The values in each line are separated by $1$ space, and there must be no extra space at the beginning or the end of the line.

**Sample Input 1:**

```c
8
12 2
16 5
13 4
18 5
15 -1
17 4
14 2
18 3
7
20 -1
16 0
25 0
13 1
18 1
21 2
28 2
36
```

**Sample Output 1:**

```c
true
36 = 15 + 21
36 = 16 + 20
36 = 18 + 18
15 13 12 14 17 16 18 18
20 16 13 18 25 21 28
```

**Sample Input 2:**

```c
5
10 -1
5 0
15 0
2 1
7 1
3
15 -1
10 0
20 0
40
```

**Sample Output 2:**

```c
false
10 5 2 7 15
15 10 20
```

**Grading Policy:**

- Chapter $1$: Introduction ($6$ pts.)
- Chapter $2$: Algorithm Specification ($12$ pts.)
- Chapter $3$: Testing Results ($20$ pts.)
- Chapter $4$: Analysis and Comments ($10$ pts.)
- Write the program ($50$ pts.) with sufficient comments.
- Overall style of documentation ($2$ pts.)

**Code:**

```c
#include <stdio.h>
#include <stdlib.h>

#define MAXN 200050   // 定义最大节点数（ 2e5 + 50） 

// 节点值及目标 N 的范围是 [-2×10^9, 2×10^9]，可能溢出 int，故使用 long long
typedef long long ElemType;   // 将 long long 自定义为 ElemType，可以方便地更改 data 的类型 

// 树节点结构 
typedef struct TreeNode {
    ElemType data;   // 节点值，类型为 long long，自定义为 ElemType 
    int lchild;   // 左孩子索引，-1 表示为空 
    int rchild;   // 右孩子索引，-1 表示为空 
} TreeNode;

// 静态分配全局存储两棵树节点的数组，其大小固定为 MAXN
TreeNode tree1[MAXN];
TreeNode tree2[MAXN];

// 通过中序遍历得到的升序序列，用于后续双指针查找和配对 
ElemType seq1[MAXN];
ElemType seq2[MAXN];
int len1, len2;   // 序列实际长度，即为节点数

// 用于存储所有配对的 A 和 B，其中 A 来自 tree1，B 来自 tree2，满足 A + B = N 
ElemType pair_A[MAXN], pair_B[MAXN];
int num_pair;   // 配对的数量

int stack[MAXN];   // 存储节点索引的栈，使用全局栈

// 构建树，返回根节点索引
int Build_Trees(int n, TreeNode tree[]) {
    // 临时存储每个节点的父索引，该数组大小为 n，用完立即释放
    int *parent = (int*)malloc(n * sizeof(int));
    if (parent == NULL) {
        exit(1);   // 若内存分配失败，直接退出程序
    }
    
    // 读取所有节点数据 
    for (int i = 0; i < n; ++i) {
        ElemType key;
        int father;
        scanf("%lld %d", &key, &father);   // 读取节点值、父索引
        tree[i].data = key;   // 存储节点值 
        parent[i] = father;   // 存储父索引 
        tree[i].lchild = -1;   // 初始化左孩子为空 
        tree[i].rchild = -1;   // 初始化右孩子为空 
    }
    
    // 建立父子关系 
    int root = -1;   // 根节点索引，初始化为 -1 
    for (int i = 0; i < n; ++i) {
        int father = parent[i];
        if (father == -1) {
            root = i;   // 依据题意，父索引为 -1 的节点是根 
        } else {
            if (tree[i].data < tree[father].data) {
                tree[father].lchild = i;   // 若小于父节点，则为左孩子 
            } else {
                tree[father].rchild = i;   // 若大于等于父节点，则为右孩子 
            }
        }
    }
    free(parent);   // 释放临时内存，防止内存泄漏 
    return root;
}

// 迭代中序遍历（升序）
void inorder(int root, TreeNode tree[], ElemType a[], int *len) {
    int top = -1;      // 栈顶指针 
    int cur = root;      // 当前遍历节点 
    
    while (top >= 0 || cur != -1) {
        // 一直向左走，并将经过的节点压栈 
        while (cur != -1) {
            stack[++top] = cur;
            cur = tree[cur].lchild;
        }
        // 弹出栈顶节点，访问，并将其存入结果数组 
        cur = stack[top--];
        a[(*len)++] = tree[cur].data; 
        // 转向右子树，继续循环 
        cur = tree[cur].rchild;
    }
}

// 双指针查找配对
void findPairs(ElemType target) {
    num_pair = 0;   // 初始化符合要求的对数为 0 
    int i = 0, j = len2 - 1;   // 双指针，i 在 seq1 头部，j 在 seq2 尾部
    
    while (i < len1 && j >= 0) {
        ElemType a = seq1[i];
        ElemType b = seq2[j];
        ElemType sum = a + b;
        
        if (sum == target) {
            // 找到一组有效解 
            pair_A[num_pair] = a;
            pair_B[num_pair] = b;
            num_pair++;
            
            // 跳过 seq1 中与当前 a 相等的所有值，避免重复输出 
            while (i + 1 < len1 && seq1[i + 1] == a) {
                i++;
            }
            // 跳过 seq2 中与当前 b 相等的所有值，避免重复输出
            while (j - 1 >= 0 && seq2[j - 1] == b) {
                j--;
            }
            
            // 继续移动指针至下一个不同的值 
            i++;
            j--;
        } else if (sum < target) {
            i++;   // 总和太小，增大 A 
        } else {
            j--;   // 总和太大，减小 B 
        }
    }
}

// 迭代前序遍历输出
void preorderPrint(int root, TreeNode tree[]) {
    if (root == -1) {
        printf("\n");   // 空树输出空行
        return;
    } 
    int top = -1;
    stack[++top] = root;
    int first = 1;   // 控制空格的标志 
    
    while (top >= 0) {
        int node = stack[top--];
        if (!first) {
            printf(" ");   // 若不是第一个节点，输出空格 
        } else {
            first = 0;
        }
        printf("%lld", tree[node].data);
        // 注意：先压右孩子，再压左孩子，保证左孩子先弹出（前序）
        if (tree[node].rchild != -1) {
            stack[++top] = tree[node].rchild;
        }
        if (tree[node].lchild != -1) {
            stack[++top] = tree[node].lchild;
        }
    }
    printf("\n");
}

int main() {
    int n1, n2;   // 两棵树的节点个数
    ElemType N;   // 目标值 

    // 读入第一棵树 
    scanf("%d", &n1);
    int rt1 = Build_Trees(n1, tree1);   

    // 读入第二棵树 
    scanf("%d", &n2);
    int rt2 = Build_Trees(n2, tree2);

    // 读入目标值 
    scanf("%lld", &N);

    // 中序遍历获取升序的序列 
    len1 = 0;
    inorder(rt1, tree1, seq1, &len1);
    len2 = 0;
    inorder(rt2, tree2, seq2, &len2);

    // 寻找所有符合要求的配对 
    findPairs(N);

    // 输出配对结果 
    if (num_pair == 0) {
        printf("false\n");
    } else {
        printf("true\n");
        for (int i = 0; i < num_pair; ++i) {
            printf("%lld = %lld + %lld\n", N, pair_A[i], pair_B[i]);
        }
    }

    // 依次输出两棵树的前序遍历的序列 
    preorderPrint(rt1, tree1);
    preorderPrint(rt2, tree2);

    return 0;
}
```

**Largest-Scale Test:**

```c
#include <stdio.h>
#include <stdlib.h>
#include <time.h>

#define MAXN 200050                     // 最大节点数（200000 + 50，留有余量）
#define data_MIN -1000000000LL          // 节点键值的最小值
#define data_MAX 1000000000LL           // 节点键值的最大值
#define N_MIN   -2000000000LL           // 目标值 N 的最小值
#define N_MAX   2000000000LL            // 目标值 N 的最大值

// 节点值及目标 N 的范围是 [-2×10^9, 2×10^9]，可能溢出 int，故使用 long long
typedef long long ElemType;             // 元素类型，保证 64 位

// 树节点结构
typedef struct TreeNode {
    ElemType data;      // 节点存储的键值
    int lchild;         // 左孩子索引，-1 表示空
    int rchild;         // 右孩子索引，-1 表示空
} TreeNode;

// 静态分配全局存储两棵树节点的数组，大小固定为 MAXN
TreeNode tree1[MAXN];
TreeNode tree2[MAXN];

// 中序遍历得到的升序序列，用于双指针查找
ElemType seq1[MAXN];
ElemType seq2[MAXN];
int len1, len2;          // 序列实际长度，等于节点数

// 存储所有解 (A, B)，其中 A 来自 tree1，B 来自 tree2，满足 A + B = N
ElemType pair_A[MAXN], pair_B[MAXN];
int num_pair;            // 解的个数

int stack[MAXN];         // 全局栈，用于非递归遍历（避免局部大数组导致栈溢出）

typedef unsigned long long unElemType;   // 无符号 64 位整数，用于随机数生成

// 生成 [min, max] 范围内的随机整数（均匀分布）
ElemType rand_range(ElemType min, ElemType max) {
    // 使用三次 rand() 组合成 60 位随机数，覆盖整个 64 位范围
    unElemType random = (unElemType)rand();
    random = (random << 30) ^ ((unElemType)rand() << 15) ^ (unElemType)rand();
    // 映射到指定区间
    return min + (ElemType)(random % (unElemType)(max - min + 1));
}

// 生成一棵具有 n 个节点的 BST，返回 keys 和 parents 数组（不输出，直接存入内存）
void generate_bst_data(int n, ElemType keys[], int parents[]) {
    // left 和 right 临时记录每个节点的左右孩子索引，用于建树过程
    int *left = (int*)malloc(n * sizeof(int));
    int *right = (int*)malloc(n * sizeof(int));
    if (!left || !right) {
        exit(1);   // 内存分配失败则退出
    }
    
    // 根节点（索引 0）
    keys[0] = rand_range(data_MIN, data_MAX);
    parents[0] = -1;        // 根节点没有父节点
    left[0] = right[0] = -1;
    
    // 依次插入节点 1..n-1
    for (int i = 1; i < n; ++i) {
        ElemType key_new = rand_range(data_MIN, data_MAX);
        int cur = 0, parent_node = -1, is_left = 0;
        // 寻找插入位置
        while (cur != -1) {
            parent_node = cur;
            if (key_new < keys[cur]) {
                cur = left[cur];
                is_left = 1;
            } else {
                cur = right[cur];
                is_left = 0;
            }
        }
        // 插入新节点
        keys[i] = key_new;
        parents[i] = parent_node;
        left[i] = right[i] = -1;
        if (is_left) {
        	left[parent_node] = i;
		}  
        else {
        	right[parent_node] = i;
		} 
    }
    // 释放动态分配的内存 
    free(left);
    free(right);
}

// 根据给定的 keys 和 parents 数组构建树
int Build_Trees(int n, TreeNode tree[], ElemType keys[], int parents[]) {
    // 初始化所有节点的左右孩子为 -1
    for (int i = 0; i < n; ++i) {
        tree[i].data = keys[i];
        tree[i].lchild = -1;
        tree[i].rchild = -1;
    }
    int root = -1;
    // 根据父索引建立左右孩子关系
    for (int i = 0; i < n; ++i) {
        int father = parents[i];
        if (father == -1) {
            root = i;                     // 父索引为 -1 的是根
        } else {
            if (tree[i].data < tree[father].data) {
            	tree[father].lchild = i;       // 小于父节点，成为左孩子
			}
            else {
            	tree[father].rchild = i;       // 大于等于父节点，成为右孩子
			}
        }
    }
    return root;
}

// 非递归中序遍历（升序），结果存入 a 数组，长度由 len 返回
void inorder(int root, TreeNode tree[], ElemType a[], int *len) {
    int top = -1, cur = root;
    while (top >= 0 || cur != -1) {
        // 一直向左走，并将经过的节点压栈
        while (cur != -1) {
            stack[++top] = cur;
            cur = tree[cur].lchild;
        }
        // 弹出栈顶节点，访问并将其值存入数组
        cur = stack[top--];
        a[(*len)++] = tree[cur].data;
        // 转向右子树，继续循环
        cur = tree[cur].rchild;
    }
}

// 双指针查找所有满足 A + B = target 的数对（去重），结果存入全局 pair_A / pair_B
void findPairs(ElemType target) {
    num_pair = 0;
    int i = 0, j = len2 - 1;          // i 指向 seq1 头部，j 指向 seq2 尾部
    while (i < len1 && j >= 0) {
        ElemType a = seq1[i], b = seq2[j], sum = a + b;
        if (sum == target) {
            // 找到一组解
            pair_A[num_pair] = a;
            pair_B[num_pair] = b;
            num_pair++;
            // 跳过 seq1 中所有等于 a 的值（避免重复输出）
            while (i + 1 < len1 && seq1[i + 1] == a) {
            	i++;
			} 
            // 跳过 seq2 中所有等于 b 的值
            while (j - 1 >= 0 && seq2[j - 1] == b) {
            	j--;
			}
            i++; 
			j--;
        } else if (sum < target) {
            i++;        // 总和太小，增大 A
        } else {
            j--;        // 总和太大，减小 B
        }
    }
}

// 非递归前序遍历，结果写入文件流 out
void preorderPrint(FILE *out, int root, TreeNode tree[]) {
    if (root == -1) {
        fprintf(out, "\n");   // 空树输出空行
        return;
    }
    int top = -1;
    stack[++top] = root;
    int first = 1;   // 控制空格输出，避免行首多余空格
    while (top >= 0) {
        int node = stack[top--];
        if (!first) {
        	fprintf(out, " ");
        	first = 0;
		}
        else {
            fprintf(out, "%lld", tree[node].data);
		}
        // 注意：先压右孩子，再压左孩子，保证左孩子先弹出，以满足前序遍历的要求
        if (tree[node].rchild != -1) {
        	stack[++top] = tree[node].rchild;
		}
        if (tree[node].lchild != -1) {
        	stack[++top] = tree[node].lchild;
		}
    }
    fprintf(out, "\n");
}

int main() {
    // 设置随机种子（使用当前时间，确保每次运行结果不同）
    srand((unsigned)time(NULL));
    const int n1 = 200000, n2 = 200000;   // 两棵树各 20 万个节点

    // 分配临时数组存储 keys 和 parents
    ElemType *keys1 = (ElemType*)malloc(n1 * sizeof(ElemType));
    int *parents1 = (int*)malloc(n1 * sizeof(int));
    ElemType *keys2 = (ElemType*)malloc(n2 * sizeof(ElemType));
    int *parents2 = (int*)malloc(n2 * sizeof(int));
    if (!keys1 || !parents1 || !keys2 || !parents2) {
    	return 1;
	}

    // 生成两棵随机 BST
    generate_bst_data(n1, keys1, parents1);
    generate_bst_data(n2, keys2, parents2);
    // 随机生成目标 N
    ElemType N = rand_range(N_MIN, N_MAX);

    // 原始输入写入 input.txt 文件 
    FILE *fin = fopen("input.txt", "w");
    if (!fin) {
    	return 1;
	}
    fprintf(fin, "%d\n", n1);
    for (int i = 0; i < n1; ++i) {
    	fprintf(fin, "%lld %d\n", keys1[i], parents1[i]);
	}
    fprintf(fin, "%d\n", n2);
    for (int i = 0; i < n2; ++i) {
    	fprintf(fin, "%lld %d\n", keys2[i], parents2[i]);
	}
    fprintf(fin, "%lld\n", N);
    fclose(fin);

    // 构建树并求解
    int rt1 = Build_Trees(n1, tree1, keys1, parents1);
    int rt2 = Build_Trees(n2, tree2, keys2, parents2);
    len1 = 0; inorder(rt1, tree1, seq1, &len1);
    len2 = 0; inorder(rt2, tree2, seq2, &len2);
    findPairs(N);

    // 结果写入 output.txt 文件 
    FILE *fout = fopen("output.txt", "w");
    if (!fout) return 1;
    if (num_pair == 0) {
        fprintf(fout, "false\n");
    } else {
        fprintf(fout, "true\n");
        for (int i = 0; i < num_pair; ++i)
            fprintf(fout, "%lld = %lld + %lld\n", N, pair_A[i], pair_B[i]);
    }
    preorderPrint(fout, rt1, tree1);
    preorderPrint(fout, rt2, tree2);
    fclose(fout);

    // 释放动态分配的内存
    free(keys1); 
	free(parents1);
    free(keys2); 
	free(parents2);
    return 0;
}
```

---

**Verify the Correctness of  `A + B = N`**:

```c
#include <stdio.h>
#include <stdlib.h>

#define MAXN 200050   // 定义最大节点数（ 2e5 + 50） 

// 节点值及目标 N 的范围是 [-2×10^9, 2×10^9]，可能溢出 int，故使用 long long
typedef long long ElemType;   // 将 long long 自定义为 ElemType，可以方便地更改 data 的类型 

// 树节点结构 
typedef struct TreeNode {
    ElemType data;   // 节点值，类型为 long long，自定义为 ElemType 
    int lchild;   // 左孩子索引，-1 表示为空 
    int rchild;   // 右孩子索引，-1 表示为空 
} TreeNode;

// 静态分配全局存储两棵树节点的数组，其大小固定为 MAXN
TreeNode tree1[MAXN];
TreeNode tree2[MAXN];

// 通过中序遍历得到的升序序列，用于后续双指针查找和配对 
ElemType seq1[MAXN];
ElemType seq2[MAXN];

// 通过中序遍历得到的升序序列，用于后续查找配对的测试程序 
ElemType seq1_test[MAXN];
ElemType seq2_test[MAXN];

int len1, len2;   // 序列实际长度，即为节点数

// 用于存储所有配对的 A 和 B，其中 A 来自 tree1，B 来自 tree2，满足 A + B = N 
ElemType pair_A[MAXN];
ElemType pair_B[MAXN];

// 用于存储所有配对的 A 和 B，其中 A 来自 tree1，B 来自 tree2，满足 A + B = N，用于测试 
ElemType pair_A_test[MAXN];
ElemType pair_B_test[MAXN];

int num_pair;   // 配对的数量

int num_test;   // 测试配对的数量 

int stack[MAXN];   // 存储节点索引的栈，使用全局栈

// 构建树，返回根节点索引
int Build_Trees(int n, TreeNode tree[]) {
    // 临时存储每个节点的父索引，该数组大小为 n，用完立即释放
    int *parent = (int*)malloc(n * sizeof(int));
    if (parent == NULL) {
        exit(1);   // 若内存分配失败，直接退出程序
    }
    
    // 读取所有节点数据 
    for (int i = 0; i < n; ++i) {
        ElemType key;
        int father;
        scanf("%lld %d", &key, &father);   // 读取节点值、父索引
        tree[i].data = key;   // 存储节点值 
        parent[i] = father;   // 存储父索引 
        tree[i].lchild = -1;   // 初始化左孩子为空 
        tree[i].rchild = -1;   // 初始化右孩子为空 
    }
    
    // 建立父子关系 
    int root = -1;   // 根节点索引，初始化为 -1 
    for (int i = 0; i < n; ++i) {
        int father = parent[i];
        if (father == -1) {
            root = i;   // 依据题意，父索引为 -1 的节点是根 
        } else {
            if (tree[i].data < tree[father].data) {
                tree[father].lchild = i;   // 若小于父节点，则为左孩子 
            } else {
                tree[father].rchild = i;   // 若大于等于父节点，则为右孩子 
            }
        }
    }
    free(parent);   // 释放临时内存，防止内存泄漏 
    return root;
}

// 迭代中序遍历（升序）
void inorder(int root, TreeNode tree[], ElemType a[], int *len) {
    int top = -1;      // 栈顶指针 
    int cur = root;      // 当前遍历节点 
    
    while (top >= 0 || cur != -1) {
        // 一直向左走，并将经过的节点压栈 
        while (cur != -1) {
            stack[++top] = cur;
            cur = tree[cur].lchild;
        }
        // 弹出栈顶节点，访问，并将其存入结果数组 
        cur = stack[top--];
        a[(*len)++] = tree[cur].data; 
        // 转向右子树，继续循环 
        cur = tree[cur].rchild;
    }
}

// 双指针查找配对
void findPairs(ElemType target) {
    num_pair = 0;   // 初始化符合要求的对数为 0 
    int i = 0, j = len2 - 1;   // 双指针，i 在 seq1 头部，j 在 seq2 尾部
    
    while (i < len1 && j >= 0) {
        ElemType a = seq1[i];
        ElemType b = seq2[j];
        ElemType sum = a + b;
        
        if (sum == target) {
            // 找到一组有效解 
            pair_A[num_pair] = a;
            pair_B[num_pair] = b;
            num_pair++;
            
            // 跳过 seq1 中与当前 a 相等的所有值，避免重复输出 
            while (i + 1 < len1 && seq1[i + 1] == a) {
                i++;
            }
            // 跳过 seq2 中与当前 b 相等的所有值，避免重复输出
            while (j - 1 >= 0 && seq2[j - 1] == b) {
                j--;
            }
            
            // 继续移动指针至下一个不同的值 
            i++;
            j--;
        } else if (sum < target) {
            i++;   // 总和太小，增大 A 
        } else {
            j--;   // 总和太大，减小 B 
        }
    }
}

// 暴力查找，双重循环，用于测试 
void Test_findPairs(ElemType goal) {
	num_test = 0;   // 初始化符合条件的对数为 0 
    for (int i = 0; i < len1; i++) {
        seq1_test[i] = seq1[i];   // 复制数组 
    }
    for (int i = 0; i < len2; i++) {
        seq2_test[i] = seq2[i];   // 复制数组 
    }
    for (int i = 0; i < len1; i++) {
        if (i >= 1 && seq1_test[i] == seq1_test[i-1]) {
            continue;   // 重复，往下一个 
        }
        for (int j = 0; j < len2; j++) {
            if (j >= 1 && seq2_test[j] == seq2_test[j - 1]) {
                continue;   // 重复，往下一个 
            }
            if (seq1_test[i] + seq2_test[j] == goal) {
                pair_A_test[num_test] = seq1_test[i];
                pair_B_test[num_test] = seq2_test[j];
                num_test++;   // 找到一组解 
            }
        }
    }
}

// 迭代前序遍历输出
void preorderPrint(int root, TreeNode tree[]) {
    if (root == -1) {
        printf("\n");   // 空树输出空行
        return;
    } 
    int top = -1;
    stack[++top] = root;
    int first = 1;   // 控制空格的标志 
    
    while (top >= 0) {
        int node = stack[top--];
        if (!first) {
            printf(" ");   // 若不是第一个节点，输出空格 
        } else {
            first = 0;
        }
        printf("%lld", tree[node].data);
        // 注意：先压右孩子，再压左孩子，保证左孩子先弹出（前序）
        if (tree[node].rchild != -1) {
            stack[++top] = tree[node].rchild;
        }
        if (tree[node].lchild != -1) {
            stack[++top] = tree[node].lchild;
        }
    }
    printf("\n");
}

int main() {
    int n1, n2;   // 两棵树的节点个数
    ElemType N;   // 目标值 

    // 读入第一棵树 
    scanf("%d", &n1);
    int rt1 = Build_Trees(n1, tree1);   

    // 读入第二棵树 
    scanf("%d", &n2);
    int rt2 = Build_Trees(n2, tree2);

    // 读入目标值 
    scanf("%lld", &N);

    // 中序遍历获取升序的序列 
    len1 = 0;
    inorder(rt1, tree1, seq1, &len1);
    len2 = 0;
    inorder(rt2, tree2, seq2, &len2);

    // 寻找所有符合要求的配对 
    findPairs(N);

    // 输出配对结果 
    if (num_pair == 0) {
        printf("false\n");
    } else {
        printf("true\n");
        for (int i = 0; i < num_pair; ++i) {
            printf("%lld = %lld + %lld\n", N, pair_A[i], pair_B[i]);
        }
    }

    // 寻找所有符合要求的配对，用于测试 
    Test_findPairs(N);

    // 输出测试结果
    printf("Test Result:\n");
	if (num_test == 0) {
        printf("false\n");
    } else {
        printf("true\n");
        for (int i = 0; i < num_test; ++i) {
            printf("%lld = %lld + %lld\n", N, pair_A_test[i], pair_B_test[i]);
        }
    }

    // 依次输出两棵树的前序遍历的序列 
    preorderPrint(rt1, tree1);
    preorderPrint(rt2, tree2);

    return 0;
}
```

*Large-scale Data*:

```c
#include <stdio.h>
#include <stdlib.h>
#include <time.h>

#define MAXN 200050                     // 最大节点数（200000 + 50，留有余量）
#define data_MIN -1000000000LL          // 节点键值的最小值
#define data_MAX 1000000000LL           // 节点键值的最大值
#define N_MIN   -2000000000LL           // 目标值 N 的最小值
#define N_MAX   2000000000LL            // 目标值 N 的最大值

// 节点值及目标 N 的范围是 [-2×10^9, 2×10^9]，可能溢出 int，故使用 long long
typedef long long ElemType;             // 元素类型，保证 64 位

// 树节点结构
typedef struct TreeNode {
    ElemType data;      // 节点存储的键值
    int lchild;         // 左孩子索引，-1 表示空
    int rchild;         // 右孩子索引，-1 表示空
} TreeNode;

// 静态分配全局存储两棵树节点的数组，大小固定为 MAXN
TreeNode tree1[MAXN];
TreeNode tree2[MAXN];

// 中序遍历得到的升序序列，用于双指针查找
ElemType seq1[MAXN];
ElemType seq2[MAXN];
int len1, len2;          // 序列实际长度，等于节点数

// 存储所有解 (A, B)，其中 A 来自 tree1，B 来自 tree2，满足 A + B = N
ElemType pair_A[MAXN], pair_B[MAXN];
int num_pair;            // 解的个数

int stack[MAXN];         // 全局栈，用于非递归遍历（避免局部大数组导致栈溢出）

typedef unsigned long long unElemType;   // 无符号 64 位整数，用于随机数生成

// 生成 [min, max] 范围内的随机整数（均匀分布）
ElemType rand_range(ElemType min, ElemType max) {
    // 使用三次 rand() 组合成 60 位随机数，覆盖整个 64 位范围
    unElemType random = (unElemType)rand();
    random = (random << 30) ^ ((unElemType)rand() << 15) ^ (unElemType)rand();
    // 映射到指定区间
    return min + (ElemType)(random % (unElemType)(max - min + 1));
}

// 生成一棵具有 n 个节点的 BST，返回 keys 和 parents 数组（不输出，直接存入内存）
void generate_bst_data(int n, ElemType keys[], int parents[]) {
    // left 和 right 临时记录每个节点的左右孩子索引，用于建树过程
    int *left = (int*)malloc(n * sizeof(int));
    int *right = (int*)malloc(n * sizeof(int));
    if (!left || !right) {
        exit(1);   // 内存分配失败则退出
    }
    
    // 根节点（索引 0）
    keys[0] = rand_range(data_MIN, data_MAX);
    parents[0] = -1;        // 根节点没有父节点
    left[0] = right[0] = -1;
    
    // 依次插入节点 1..n-1
    for (int i = 1; i < n; ++i) {
        ElemType key_new = rand_range(data_MIN, data_MAX);
        int cur = 0, parent_node = -1, is_left = 0;
        // 寻找插入位置
        while (cur != -1) {
            parent_node = cur;
            if (key_new < keys[cur]) {
                cur = left[cur];
                is_left = 1;
            } else {
                cur = right[cur];
                is_left = 0;
            }
        }
        // 插入新节点
        keys[i] = key_new;
        parents[i] = parent_node;
        left[i] = right[i] = -1;
        if (is_left) {
        	left[parent_node] = i;
		}  
        else {
        	right[parent_node] = i;
		} 
    }
    // 释放动态分配的内存 
    free(left);
    free(right);
}

// 根据给定的 keys 和 parents 数组构建树
int Build_Trees(int n, TreeNode tree[], ElemType keys[], int parents[]) {
    // 初始化所有节点的左右孩子为 -1
    for (int i = 0; i < n; ++i) {
        tree[i].data = keys[i];
        tree[i].lchild = -1;
        tree[i].rchild = -1;
    }
    int root = -1;
    // 根据父索引建立左右孩子关系
    for (int i = 0; i < n; ++i) {
        int father = parents[i];
        if (father == -1) {
            root = i;                     // 父索引为 -1 的是根
        } else {
            if (tree[i].data < tree[father].data) {
            	tree[father].lchild = i;       // 小于父节点，成为左孩子
			}
            else {
            	tree[father].rchild = i;       // 大于等于父节点，成为右孩子
			}
        }
    }
    return root;
}

// 非递归中序遍历（升序），结果存入 a 数组，长度由 len 返回
void inorder(int root, TreeNode tree[], ElemType a[], int *len) {
    int top = -1, cur = root;
    while (top >= 0 || cur != -1) {
        // 一直向左走，并将经过的节点压栈
        while (cur != -1) {
            stack[++top] = cur;
            cur = tree[cur].lchild;
        }
        // 弹出栈顶节点，访问并将其值存入数组
        cur = stack[top--];
        a[(*len)++] = tree[cur].data;
        // 转向右子树，继续循环
        cur = tree[cur].rchild;
    }
}

// 双指针查找所有满足 A + B = target 的数对（去重），结果存入全局 pair_A / pair_B
void findPairs(ElemType target) {
    num_pair = 0;
    int i = 0, j = len2 - 1;          // i 指向 seq1 头部，j 指向 seq2 尾部
    while (i < len1 && j >= 0) {
        ElemType a = seq1[i], b = seq2[j], sum = a + b;
        if (sum == target) {
            // 找到一组解
            pair_A[num_pair] = a;
            pair_B[num_pair] = b;
            num_pair++;
            // 跳过 seq1 中所有等于 a 的值（避免重复输出）
            while (i + 1 < len1 && seq1[i + 1] == a) {
            	i++;
			} 
            // 跳过 seq2 中所有等于 b 的值
            while (j - 1 >= 0 && seq2[j - 1] == b) {
            	j--;
			}
            i++; 
			j--;
        } else if (sum < target) {
            i++;        // 总和太小，增大 A
        } else {
            j--;        // 总和太大，减小 B
        }
    }
}

// 非递归前序遍历，结果写入文件流 out
void preorderPrint(FILE *out, int root, TreeNode tree[]) {
    if (root == -1) {
        fprintf(out, "\n");   // 空树输出空行
        return;
    }
    int top = -1;
    stack[++top] = root;
    int first = 1;   // 控制空格输出，避免行首多余空格
    while (top >= 0) {
        int node = stack[top--];
        if (!first) {
        	fprintf(out, " ");
        	first = 0;
		}
        else {
            fprintf(out, "%lld", tree[node].data);
		}
        // 注意：先压右孩子，再压左孩子，保证左孩子先弹出，以满足前序遍历的要求
        if (tree[node].rchild != -1) {
        	stack[++top] = tree[node].rchild;
		}
        if (tree[node].lchild != -1) {
        	stack[++top] = tree[node].lchild;
		}
    }
    fprintf(out, "\n");
}

int main() {
    // 设置随机种子（使用当前时间，确保每次运行结果不同）
    srand((unsigned)time(NULL));
    const int n1 = 200000, n2 = 200000;   // 两棵树各 20 万个节点

    // 分配临时数组存储 keys 和 parents
    ElemType *keys1 = (ElemType*)malloc(n1 * sizeof(ElemType));
    int *parents1 = (int*)malloc(n1 * sizeof(int));
    ElemType *keys2 = (ElemType*)malloc(n2 * sizeof(ElemType));
    int *parents2 = (int*)malloc(n2 * sizeof(int));
    if (!keys1 || !parents1 || !keys2 || !parents2) {
    	return 1;
	}

    // 生成两棵随机 BST
    generate_bst_data(n1, keys1, parents1);
    generate_bst_data(n2, keys2, parents2);
    // 随机生成目标 N
    ElemType N = rand_range(N_MIN, N_MAX);

    // 原始输入写入 input.txt 文件 
    FILE *fin = fopen("input.txt", "w");
    if (!fin) {
    	return 1;
	}
    fprintf(fin, "%d\n", n1);
    for (int i = 0; i < n1; ++i) {
    	fprintf(fin, "%lld %d\n", keys1[i], parents1[i]);
	}
    fprintf(fin, "%d\n", n2);
    for (int i = 0; i < n2; ++i) {
    	fprintf(fin, "%lld %d\n", keys2[i], parents2[i]);
	}
    fprintf(fin, "%lld\n", N);
    fclose(fin);

    // 构建树并求解
    int rt1 = Build_Trees(n1, tree1, keys1, parents1);
    int rt2 = Build_Trees(n2, tree2, keys2, parents2);
    len1 = 0; inorder(rt1, tree1, seq1, &len1);
    len2 = 0; inorder(rt2, tree2, seq2, &len2);
    findPairs(N);

    // 结果写入 output.txt 文件 
    FILE *fout = fopen("output.txt", "w");
    if (!fout) return 1;
    if (num_pair == 0) {
        fprintf(fout, "false\n");
    } else {
        fprintf(fout, "true\n");
        for (int i = 0; i < num_pair; ++i)
            fprintf(fout, "%lld = %lld + %lld\n", N, pair_A[i], pair_B[i]);
    }
    preorderPrint(fout, rt1, tree1);
    preorderPrint(fout, rt2, tree2);
    fclose(fout);

    // 释放动态分配的内存
    free(keys1); 
	free(parents1);
    free(keys2); 
	free(parents2);
    return 0;
}
```


---

### (3) Normal-3 Dijkstra Sequence

Dijkstra's algorithm is one of the very famous greedy algorithms.
It is used for solving the single source shortest path problem which gives the shortest paths from one particular source vertex to all the other vertices of the given graph.  It was conceived by computer scientist Edsger W. Dijkstra in $1956$ and published three years later.

In this algorithm, a set contains vertices included in shortest path tree is maintained.  During each step, we find one vertex which is not yet included and has a minimum distance from the source, and collect it into the set.  Hence step by step an ordered sequence of vertices, let's call it **Dijkstra sequence**, is generated by **Dijkstra's algorithm**.

On the other hand, for a given graph, there could be more than one Dijkstra sequence. Your job is to check whether a given sequence is Dijkstra sequence or not.

**Input Specification:**

Each input file contains one test case. For each case, the first line contains two positive integers $N_v(≤10^3)$ and $N_e(≤10^5)$, which are the total numbers of vertices and edges, respectively.  Hence the vertices are numbered from $1$ to $Nv$.

Then $N_e$ lines follow, each describes an edge by giving the indices of the vertices at the two ends, followed by a positive integer weight $(≤100)$ of the edge.  It is guaranteed that the given graph is connected.

Finally the number of queries, $K$, is given as a positive integer no larger than $100$, followed by $K$ lines of sequences, each contains a permutationof the $N_v$ vertices.  It is assumed that the first vertex is the source for each sequence.

All the inputs in a line are separated by a space.

**Output Specification:**

For each of the $K$ sequences, print in a line `Yes` if it is a Dijkstra sequence, or `No` if not.

**Sample Input:**

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

**Sample Output:**

```c
Yes
Yes
Yes
No
```

**Grading Policy:**

- Chapter $1$: Introduction ($6$ pts.)
- Chapter $2$: Algorithm Specification ($12$ pts.)
- Chapter $3$: Testing Results ($20$ pts.)
- Chapter $4$: Analysis and Comments ($10$ pts.)
- Write the program ($50$ pts.) with sufficient comments.
- Overall style of documentation ($2$ pts.)

**Code:**

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

**Largest-Scale Test:**

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

---

### (4) Hard-1 Performance Measurement (A+B)

Given $S$ as a collection of $N$ positive integers that are no more than $V$. For any given number $c$, you are supposed to find two integers $a$ and $b$ from $S$, so that $a+b=c$.

Your tasks are:

- (1) Implement at least two different algorithms to solve this problem;
- (2) Analyze the complexities of the two algorithms;
- (3) Measure and compare the performances of the two algorithms for $V$ and $N$ = $1000$, $5000$, $10000$, $20000$, $40000$, $60000$, $80000$, $100000$.

To measure the performance of a function, we may use C's standard library `time.h` as the following:

![time.jpg](https://images.ptausercontent.com/a99ccc3a-f9a1-47db-8cb4-bb02f976a722.jpg)

**Note:** If a function runs so quickly that it takes less than a tick to finish, we may repeat the function calls for $K$ times to obtain a total run time, and then divide the total time by $K$ to obtain a more accurate duration for a single run of the function.  The repetition factor must be large enough so that the number of elapsed ticks is at least $10$ if we want an accuracy of at least $10\%$.

The test results must be listed in the following table (for each value of $V$):

![table1.jpg](https://images.ptausercontent.com/6c8f6717-8488-4eb1-a1c4-617f1b950907.jpg)

The performances of the two functions must be **plotted** in the **same** $N$–run_time coordinate system for illustration.

**Grading Policy:**

- **Programmer:** Implement the two functions ($30$ pts.) and a testing program ($20$ pts.) **with sufficient comments**.
- **Tester:** Decide the iteration number $K$ for each test case and fill in the table of results ($8$ pts.).  Plot the run times of the functions ($12$ pts.).  Write analysis and comments ($10$ pts.).
- **Report Writer:** Write Chapter 1 ($6$ pts.), Chapter 2 ($12$ pts.), and finally a complete report ($2$ pts. for overall style of documentation).

---

















![](./public/20260322115501_236_180.jpg)

![](./public/20260325141247_275_180.jpg)

