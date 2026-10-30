---
title: 算法设计与刷题实战手册 · Algorithms Practice
description: 经典数据结构实现、高频算法模板、动态规划、图论与前缀和双指针高频题型解题集
---

# <center>Algorithms</center>

<center>浙江大学 竺可桢学院 混合2504班 邓欢桐 3250102223</center>

---

<center>
<img src="/20260323101520_871_96.png" style="zoom: 60%;" />
<img src="/20260323101521_872_96.png" style="zoom: 20%;" />
<img src="/ckc.png" style="zoom: 25%;" />
</center>


---

[[toc]]

<div style="display: block !important; text-align: center !important; margin: 60px auto 20px !important; padding: 20px 0 !important; width: 85% !important; border-top: 1px dashed #b1c2ca !important; border-bottom: 1px dashed #b1c2ca !important; font-family: '钟齐志莽行书', cursive !important; font-size: 20px !important; line-height: 1.8 !important; letter-spacing: 2px !important; font-weight: normal !important; font-style: italic !important; color: #2d4856 !important;">“只要你敢不懦弱，凭什么我们要错过”<span style="display: block !important; text-align: right !important; margin-top: 10px !important; font-size: 18px !important;">—— 2026.7.20 龙佑街</span></div>

## Chapter 1：一些可用知识

### 1. 高精度乘法

C 语言描述：

```c
struct num {
	char a[41];
	int len;
};

typedef struct num Num;

Num timing(Num a, Num b) {
	Num res;
	memset(&res, 0, sizeof(Num));
	res.len = a.len + b.len;

	for (int i = 0; i < a.len; i++) {
		for (int j = 0; j < b.len; j++) {
			res.a[i + j] += a.a[i] * b.a[j];
			res.a[i + j + 1] += res.a[i + j] / 10;
			res.a[i + j] %= 10;
		}
	}

	while (res.len > 1 && res.a[res.len - 1] == 0) {
		res.len--;
	}
	return res;
}
```

### 2. 连续输入

C 语言描述：

```c
while (scanf("%d", &h) == 1) {
	a[i] = h;
	i++;
}
```

> [!NOTE]
>
> `while (scanf("%d", &h) == 1)` 写成 `while (scanf("%d", &h) != EOF)` 同样正确。

### 3. Dijkstra 算法

C 语言描述：

```c
#include <stdio.h>
#include <stdbool.h>

#define INF 999999
#define V 6 // 顶点数量

// 辅助函数：在未包含在最短路径树中的顶点中，找到距离值最小的顶点
int minDistance(int dist[], bool sptSet[]) {
    int min = INF, min_index;

    for (int v = 0; v < V; v++) {
        if (sptSet[v] == false && dist[v] <= min) {
            min = dist[v];
            min_index = v;
        }
    }
    return min_index;
}

// 辅助函数：打印计算结果
void printSolution(int dist[]) {
    printf("顶点 \t 到源点的最短距离\n");
    for (int i = 0; i < V; i++) {
        printf("%d \t %d\n", i, dist[i]);
    }
}

// 迪杰斯特拉算法主函数：接受一个图的邻接矩阵和源点 src
void dijkstra(int graph[V][V], int src) {
    int dist[V];     // dist[i] 保存源点到顶点 i 的最短距离
    bool sptSet[V];  // sptSet[i] 为 true 表示顶点 i 已经确定了最短路径

    // 1. 初始化所有距离为无穷大，sptSet[] 为 false
    for (int i = 0; i < V; i++) {
        dist[i] = INF;
        sptSet[i] = false;
    }

    // 源点自己到自己的距离始终为 0
    dist[src] = 0;

    // 找到所有顶点的最短路径
    for (int count = 0; count < V - 1; count++) {
        // 2. 从尚未确定的顶点中选出距离最小的顶点 u
        int u = minDistance(dist, sptSet);

        // 将该顶点标记为已确定
        sptSet[u] = true;

        // 3. 更新 u 的相邻顶点的距离值 (松弛操作)
        for (int v = 0; v < V; v++) {
            // 更新条件：
            // - v 尚未确定最短路径 (!sptSet[v])
            // - u 到 v 有直接的边 (graph[u][v] != 0)
            // - u 的距离不是无穷大
            // - 经过 u 到达 v 的距离，小于当前记录的到 v 的距离
            if (!sptSet[v] && graph[u][v] && dist[u] != INF 
                && dist[u] + graph[u][v] < dist[v]) {
                dist[v] = dist[u] + graph[u][v];
            }
        }
    }

    // 打印最终结果
    printSolution(dist);
}

int main() {
    /* 
       创建一个示例图的邻接矩阵表示
       0 表示两个顶点之间没有直接连接的边
       
       (0)---2---(1)---3---(2)
        |       / |       / |
        |      /  |      /  |
        1     2   5     1   5
        |    /    |    /    |
        |   /     |   /     |
       (3)---1---(4)---2---(5)
    */
    int graph[V][V] = {
        {0, 2, 0, 1, 0, 0},
        {2, 0, 3, 2, 5, 0},
        {0, 3, 0, 0, 1, 5},
        {1, 2, 0, 0, 1, 0},
        {0, 5, 1, 1, 0, 2},
        {0, 0, 5, 0, 2, 0}
    };

    printf("以顶点 0 为源点进行计算：\n");
    dijkstra(graph, 0);

    return 0;
}
```

> [!TIP]
>
> **核心思想**
>
> 1. **初始化**：创建一个距离数组 `dist[]`，将源点到自身的距离设为 `0`，到其他所有顶点的距离设为无穷大（`INF`）。维护一个布尔数组 `sptSet[]` 记录顶点是否已经确定最短路径。
> 2. **贪心选择**：每次从未确定的顶点中，挑出一个距离源点最近的顶点 `u`，将其标记为已确定（加入 `sptSet`）。
> 3. **松弛操作**：遍历顶点 `u` 的所有相邻顶点 `v`，如果通过 `u` 到达 `v` 的距离（`dist[u] + graph[u][v]`）比目前记录的 `dist[v]` 还要小，就更新 `dist[v]`。
> 4. 重复步骤 2 和 3，直到所有顶点都被处理完毕。



## Chapter 2：Luogu

### 1. P1004 [NOIP 2000 提高组] 方格取数

**题目背景：**

NOIP 2000 提高组 T4。

**题目描述：**

设有 $N \times N$ 的方格图（$N \le 9$），我们将其中的某些方格中填入正整数，而其他的方格中则放入数字 $0$。如下图所示（见样例）：

![](https://cdn.luogu.com.cn/upload/image_hosting/0bpummja.png)

某人从图的左上角的 $A$ 点出发，可以向下行走，也可以向右走，直到到达右下角的 $B$ 点。在走过的路上，他可以取走方格中的数（取走后的方格中将变为数字 $0$）。

此人从 $A$ 点到 $B$ 点共走两次，试找出 $2$ 条这样的路径，使得取得的数之和最大。

**输入格式：**

输入的第一行为一个整数 $N$，表示 $N \times N$ 的方格图。

接下来的若干行，每行有三个整数 $x,y,v$，表示第 $x$ 行第 $y$ 列的方格中所放的数为 $v$。

一行单独的 $0$ 表示输入结束。

**输出格式：**

输出一个整数，表示 $2$ 条路径上取得的数的最大总和。

**输入输出样例 #1：**

*输入 #1：*

```
8
2 3 13
2 6  6
3 5  7
4 4 14
5 2 21
5 6  4
6 3 15
7 2 14
0 0  0
```

*输出 #1：*

```
67
```

**说明/提示：**

对于全部测试数据，$1 \le N \le 9$，$1 \le x,y \le N$，$1 \le v \le 30$。

> [!TIP]
>
> 本题 N 最多是 9，因此可以大胆地使用多维数组。这里采用四维数组和二维数组进行动态规划，`PATH[i][j][k][h]` 表示两个人的行径路线下最大权值总和，即第一个人走到 `num[i][j]` 而另一个人走到 `num[k][h]`，两人走的步数永远相同。
>
> 每个人可以从上方来，也可以从左方来，因此每一步记录即可。也就是说，取四者之间的最大值 `max(PATH[i-1][j][k-1][h],PATH[i-1][h][k][h-1],PATH[i][j-1][k][h-1],PATH[i][j-1][k-1][h])`，再判断在此处两人是否重合，若重合就仅加上本格权值，不重合就各自加上自己的权值。最后的 `PATH[n][n][n][n]` 就是我们需要的答案。

```c
//#define _CRT_SECURE_NO_WARNINGS
#include<stdio.h>
#include<stdlib.h>
#include<string.h>
#include<math.h>
#define MAXN 100000
#define N 11

typedef int ElemType;

ElemType num[N][N];
ElemType path[N][N][N][N];

ElemType max(ElemType a, ElemType b, ElemType c, ElemType d) {
	ElemType max = 0;
	if (a > max) {
		max = a;
	}
	if (b > max) {
		max = b;
	}
	if (c > max) {
		max = c;
	}
	if (d > max) {
		max = d;
	}
	return max;
}

ElemType PATH(int n) {
	for (int i = 1; i <= n; i++) {
		for (int j = 1; j <= n; j++) {
			for (int k = 1; k <= n; k++) {
				for (int h = 1; h <= n; h++) {
					ElemType curr = max(path[i - 1][j][k - 1][h], path[i - 1][j][k][h - 1], path[i][j - 1][k - 1][h], path[i][j - 1][k][h - 1]);
					if (i == k && j == h) {
						path[i][j][k][h] = num[i][j] + curr;
					}
					else {
						path[i][j][k][h] = num[i][j] + num[k][h] + curr;
					}
				}
			}
		}
	}
	return path[n][n][n][n];
}

int main() {
	int n;
	scanf("%d", &n);
	while (1) {
		int a, b, c;
		scanf("%d %d %d", &a, &b, &c);
		if (a == 0 && b == 0 && c == 0) {
			break;
		}
		num[a][b] = c;
	}

	ElemType max_path = PATH(n);
	printf("%d", max_path);
}
```

### 2. P1005 [NOIP 2007 提高组] 矩阵取数游戏

**题目描述：**

帅帅经常跟同学玩一个矩阵取数游戏：对于一个给定的 $n \times m$ 的矩阵，矩阵中的每个元素 $a_{i,j}$ 均为非负整数。游戏规则如下：

1. 每次取数时须从每行各取走一个元素，共 $n$ 个。经过 $m$ 次后取完矩阵内所有元素。
2. 每次取走的各个元素只能是该元素所在行的行首或行尾。
3. 每次取数都有一个得分值，为每行取数的得分之和。每行取数的得分为被取走的元素值 $\times 2^i$，其中 $i$ 表示第 $i$ 次取数（从 $1$ 开始编号）。
4. 游戏结束总得分为 $m$ 次取数得分之和。

帅帅想请你帮忙写一个程序，对于任意矩阵，可以求出取数后的最大得分。

**输入格式：**

输入文件包括 $n+1$ 行。

第一行为两个用空格隔开的整数 $n,m$。

第 $2\sim n+1$ 行为 $n \times m$ 矩阵，其中每行有 $m$ 个用单个空格隔开的非负整数。

**输出格式：**

输出文件仅包含 $1$ 行，为一个整数，即输入矩阵取数后的最大得分。

**输入输出样例 #1**

*输入 #1*

```
2 3
1 2 3
3 4 2
```

*输出 #1*

```
82
```

**说明/提示：**

**【数据范围】**

对于 $60\%$ 的数据，满足 $1\le n,m\le 30$，答案不超过 $10^{16}$。  
对于 $100\%$ 的数据，满足 $1\le n,m\le 80$，$0\le a_{i,j}\le 1000$。

**【题目来源】**

NOIP 2007 提高第三题。

> [!TIP]
>
> 矩阵是 n 行 m 列，每次取 n 个数，共计 m 次，也就是说每一行取 1 个，不影响到下一行取什么，这就拆成了 n 个 1×m 的单行取数问题。
>
> 由于取数后每一行的区间都是连续的，我们使用 `dp[i][j]` 来表示余下从第 i 列到第 j 列的数列中取得的和的最大值，此时仅需比较 `dp[i+1][j]+2^k*number_i` 和 `dp[i][j-1]+2^k*number_j` 的大小，取最大值即可继续循环。
>
> `main` 函数里面的 `for` 循环，本质上先是长度为 1 的先更新 `dp`，然后是长度为 2 的，长度为 3 的，......，长度为 m 的。一步步更新完本行后，开始累加前面行的 `result` 和当前行的 `dp[1][m]`，这样就达到了最大值。
>
> <s>Gemini 的思路纯纯赤石</s>

```c
#define _CRT_SECURE_NO_WARNINGS
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

typedef struct {
    int num[40];
    int len;
} Sequence;

Sequence power2[85];
Sequence dp[85][85];
int number[85];

Sequence switching(int a) {
    Sequence tmp;
    memset(&tmp, 0, sizeof(tmp));
    if (a == 0) {
        tmp.len = 1;
        tmp.num[0] = 0;
        return tmp;
    }
    while (a > 0) {
        tmp.num[tmp.len++] = a % 10;
        a /= 10;
    }
    return tmp;
}

Sequence adding(Sequence A, Sequence B) {
    Sequence sum;
    memset(&sum, 0, sizeof(sum));

    int carry = 0;
    int max_len = A.len > B.len ? A.len : B.len;

    for (int i = 0; i < max_len || carry > 0; i++) {
        if (i < A.len) carry += A.num[i];
        if (i < B.len) carry += B.num[i];

        sum.num[sum.len++] = carry % 10; 
        carry /= 10;                     
    }
    return sum;
}

Sequence timing(Sequence A, int x) {
    Sequence timer;
    memset(&timer, 0, sizeof(timer));

    if (x == 0 || (A.len == 1 && A.num[0] == 0)) {
        return switching(0);
    }

    int carry = 0;
    for (int i = 0; i < A.len || carry > 0; i++) {
        if (i < A.len) {
            carry += A.num[i] * x;
        }
        timer.num[timer.len++] = carry % 10;
        carry /= 10;
    }
    return timer;
}

Sequence max_seq(Sequence A, Sequence B) {
    if (A.len > B.len) return A;
    if (A.len < B.len) return B;
    for (int i = A.len - 1; i >= 0; i--) {
        if (A.num[i] > B.num[i]) return A;
        if (A.num[i] < B.num[i]) return B;
    }
    return A;
}

void print_seq(Sequence A) {
    for (int i = A.len - 1; i >= 0; i--) {
        printf("%d", A.num[i]);
    }
}

int main() {
    int n, m;
    scanf("%d %d", &n, &m);
    power2[0] = switching(1);
    for (int i = 1; i <= m; i++) {
        power2[i] = timing(power2[i - 1], 2);
    }

    Sequence result = switching(0);

    for (int i = 1; i <= n; i++) {
        for (int j = 1; j <= m; j++) {
			scanf("%d", &number[j]);
        }
        for (int i = 1; i <= m; i++) {
            dp[i][i] = timing(power2[m], number[i]);
        }
        for (int len = 2; len <= m; len++) {
            for (int i = 1; i + len - 1 <= m; i++) {
                int k = m - len + 1;
				int j = i + len - 1;

                Sequence term_left=timing(power2[k], number[i]);
				Sequence take_left = adding(term_left, dp[i + 1][j]);
                Sequence term_right=timing(power2[k], number[j]);
				Sequence take_right = adding(term_right, dp[i][j - 1]);

				dp[i][j] = max_seq(take_left, take_right);
            }
        }

		result = adding(result, dp[1][m]);

    }
    print_seq(result);
    return 0;
}
```

### 3. P1006 [NOIP 2008 提高组] 传纸条

**题目描述：**

小渊和小轩是好朋友，也是同班同学，他们在一起总有谈不完的话题。一次素质拓展活动中，班上同学安排坐成一个 $m$ 行 $n$ 列的矩阵，而小渊和小轩被安排在矩阵对角线的两端，因此，他们就无法直接交谈了。幸运的是，他们可以通过传纸条来进行交流。纸条要经由许多同学传到对方手里。小渊坐在矩阵的左上角，坐标为 $(1,1)$；小轩坐在矩阵的右下角，坐标为 $(m,n)$。从小渊传到小轩的纸条只可以向下或者向右传递，从小轩传给小渊的纸条只可以向上或者向左传递。

在活动进行中，小渊希望给小轩传递一张纸条，同时希望小轩给他回复。班里每个同学都可以帮他们传递，但只会帮他们一次，也就是说，如果此人在小渊递给小轩纸条的时候帮忙，那么在小轩递给小渊的时候就不会再帮忙，反之亦然。

还有一件事情需要注意：全班每个同学愿意帮忙的好感度有高有低（注意：小渊和小轩的好心程度没有定义，输入时用 $0$ 表示），可以用一个 $[0,100]$ 内的自然数来表示，数越大表示越好心。小渊和小轩希望尽可能找好心程度高的同学来帮忙传纸条，即找到来回两条传递路径，使得这两条路径上同学的好心程度之和最大。现在，请你帮助小渊和小轩找到这样的两条路径。

**输入格式：**

第一行有两个用空格隔开的整数 $m,n$，表示班里有 $m$ 行 $n$ 列。

接下来的 $m$ 行是一个 $m \times n$ 的矩阵，矩阵中第 $i$ 行第 $j$ 列的整数表示坐在第 $i$ 行第 $j$ 列的学生的好心程度。每行的 $n$ 个整数之间用空格隔开。

**输出格式：**

输出共一行一个整数，表示来回两条路上参与传递纸条的学生的好心程度之和的最大值。

**输入输出样例 #1**

*输入 #1*

```
3 3
0 3 9
2 8 5
5 7 0
```

*输出 #1*

```
34
```

**说明/提示：**

**【数据范围】**

对于 $30\%$ 的数据，满足 $2 \le m,n \le 10$。  
对于 $100\%$ 的数据，满足 $2 \le m,n \le 50$。

**【题目来源】**

NOIP 2008 提高组第三题。

> [!TIP]
>
> 其实本质和第一题有相似之处，或者说基本一样吧，可以认为是两人走两条路线。

```c
#define _CRT_SECURE_NO_WARNINGS
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#define M 55
#define N 55

int peo[M][N];
int dp[M][N][M][N];

int max4(int a, int b, int c, int d) {
	int max = a;
	if (b > max) max = b;
	if (c > max) max = c;
	if (d > max) max = d;
	return max;
}

int main() {
	int m, n;
	scanf("%d %d", &m, &n);

	for (int i = 1; i <= m; i++) {
		for (int j = 1; j <= n; j++) {
			scanf("%d", &peo[i][j]);
		}
	}

	for(int i=1;i<=m;i++) {
		for (int j = 1; j <= n; j++) {
			for (int k = 1; k <= m; k++) {
				for (int l = 1; l <= n; l++) {
					dp[i][j][k][l] = max4(dp[i - 1][j][k - 1][l], dp[i][j - 1][k - 1][l], dp[i - 1][j][k][l - 1], dp[i][j - 1][k][l - 1]) + peo[i][j] + peo[k][l];
					if (i == k && j == l) dp[i][j][k][l] -= peo[i][j];
				}
			}
		}
	}

	printf("%d\n", dp[m][n][m][n]);

	return 0;
}
```

### 4. P1012 [NOIP 1998 提高组] 拼数

**题目描述：**

设有 $n$ 个正整数 $a_1 \dots a_n$，请将它们连接成一排，相邻数字首尾相接，组成一个最大的整数。

**输入格式：**

第一行有一个整数，表示数字个数 $n$。

第二行有 $n$ 个整数，表示给出的 $n$ 个整数 $a_i$。

**输出格式：**

一个正整数，表示最大的整数。

**输入输出样例 #1**

*输入 #1*

```
3
13 312 343
```

*输出 #1*

```
34331213
```

**输入输出样例 #2：**

*输入 #2*

```
4
7 13 4 246
```

*输出 #2*

```
7424613
```

**说明/提示：**

对于全部的测试点，保证 $1 \leq n \leq 20$，$1 \leq a_i \leq 10^9$。

NOIP1998 提高组 第二题

> [!TIP]
>
> 本题需要用字符串进行比较，而不是纯数字比较，那样容易出错。

```c
#define _CRT_SECURE_NO_WARNINGS
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int compare(const void* a, const void* b) {
    char ab[25], ba[25];

    strcpy(ab, (const char*)a);
    strcat(ab, (const char*)b);

    strcpy(ba, (const char*)b);
    strcat(ba, (const char*)a);

    return strcmp(ba, ab);
}

int main() {
    int n;
    if (scanf("%d", &n) != 1) return 0;

    char arr[25][15];

    for (int i = 0; i < n; i++) {
        scanf("%s", arr[i]);
    }

    qsort(arr, n, sizeof(arr[0]), compare);

    for (int i = 0; i < n; i++) {
        printf("%s", arr[i]);
    }
    printf("\n");

    return 0;
}
```

### 5. P1013 [NOIP 1998 提高组] 进制位

**题目描述：**

著名科学家卢斯为了检查学生对进位制的理解，给出了一张加法表，表中的字母代表数字。例如：

$$
\def\arraystretch{2}
\begin{array}{c||c|c|c|c}
\rm +  & \kern{.5cm} \rm \mathclap{L} \kern{.5cm}  &  \kern{.5cm} \rm \mathclap{K} \kern{.5cm} &  \kern{.5cm} \rm \mathclap{V} \kern{.5cm} & \kern{.5cm} \rm \mathclap{E} \kern{.5cm} \\ \hline\hline
\rm L  &  \rm L  &  \rm K  &  \rm V  & \rm E  \\ \hline
\rm K  &  \rm K  &  \rm V  &  \rm E  & \rm \mathclap{KL} \\ \hline
\rm V  &  \rm V  &  \rm E  &  \rm \mathclap{KL} & \rm \mathclap{KK} \\ \hline
\rm E  &  \rm E  &  \rm \mathclap{KL} &  \rm \mathclap{KK} & \rm \mathclap{KV} \\
\end{array}
$$

其含义为：

$L+L=L$，$L+K=K$，$L+V=V$，$L+E=E$。

$K+L=K$，$K+K=V$，$K+V=E$，$K+E=KL$。

$\cdots$

$E+E=KV$。

根据这些规则可推导出：$L=0$，$K=1$，$V=2$，$E=3$。

同时可以确定该表表示的是 $4$ 进制加法。

**输入格式：**

第一行一个整数 $n$（$3\le n\le 9$）表示行数。

以下 $n$ 行，每行包括 $n$ 个字符串，相邻两个字符串之间用一个空格隔开。字符串由大写英文字母和字符 `+` 组成。

若记 $s_{i,j}$ 表示第 $i$ 行第 $j$ 个字符串，数据保证 $s_{1,1}$ 为 `+`，$s_{i,1}=s_{1,i}$，$|s_{i,1}|=1$，$s_{i,1}\ne s_{j,1}$（$i\ne j$）。

保证至多有一组解。

**输出格式：**

第一行输出各个字母表示什么数，格式如 `L=0 K=1` $\cdots$，按给出的字母顺序排序。不同字母必须代表不同数字。

第二行输出加法运算是几进制的。

若不可能组成加法表，则应输出 `ERROR!`。

**输入输出样例 #1**

*输入 #1*

```
5
+ L K V E
L L K V E
K K V E KL
V V E KL KK
E E KL KK KV
```

*输出 #1*

```
L=0 K=1 V=2 E=3
4
```

**说明/提示：**

NOIP 1998 提高组第三题。

> [!TIP]
>
> 设这个加法表是 $B$ 进制（由题意可知，有一行表头和 $B$ 个数字，所以总行数 N = B + 1，即**进制数 B = N - 1**）。
>
> 在 $B$ 进制中，合法的一位数字范围是 $0, 1, 2, \dots, B-1$。
>
> - 只有当两数之和 **$\ge B$** 时，才会发生进位！
> - 也就是说，与 $X$ 相加能产生进位的数字 $Y$，必须满足：$X + Y \ge B$，即 **$Y \ge B - X$**。
>
> 在 $0$ 到 $B-1$ 这 $B$ 个数字中，满足 $Y \ge B - X$ 的数字一共正是：
> $$
> B - X, \ B - X + 1, \ \dots, \ B - 1
> $$
>
> 这样的数字共有几个：
>
> $$
> (B - 1) - (B - X) + 1 = X
> $$
>
> **正好是 $X$ 个！**
>
> 因此解法如下：
>
> **第一步：确定进制**
>
> 读取输入的行数 $N$。因为第一行是表头（`+` 和各个字母），所以真正的数字个数是 $N - 1$ 个。这必然是一个 **$N - 1$ 进制**的加法表。
>
> **第二步：破译数字（统计法）**
>
> 直接遍历矩阵的每一行：
>
> - 统计第 $i$ 行中，字符串长度 $\ge 2$ 的单元格有多少个。
>
> - 这个**数量**，就是第 $i$ 行行头那个字母所代表的数字。
>
>   *(到这一步，我们不需要任何猜测和推理，所有字母对应的数字直接就求出来了！)*
>
> **第三步：合法性初筛**
>
> 题目要求“不同字母必须代表不同数字”，并且有可能给出错误的表。所以我们要检查：
>
> - 求出来的数字集合，是不是刚好覆盖了 $0$ 到 $N - 2$ 且**没有重复**？
> - 如果有重复，或者出现了不在范围内的数字，说明该表矛盾，直接输出 `ERROR!`。
>
> **第四步：整表严格验证**
>
> 因为题目给的表格存在“骗人”的可能（即随便填一些乱码字符串，但长度刚好符合规律），我们必须把推导出来的数字**代入全表进行数学验算**。
>
> 对于表中的每一个单元格 $s_{i,j}$：
>
> 1. 取出第 $i$ 行字母代表的数 $X$，第 $j$ 列字母代表的数 $Y$，算出它们的十进制理论和：$Sum = X + Y$。
> 2. 将表格中实际填写的字符串，当作 **$N-1$ 进制数**，转换成十进制实际值：$Val$。
> 3. 比较 $Sum$ 是否等于 $Val$。只要有一个格子不相等，或者字符串里出现了没见过的非法字母，立刻输出 `ERROR!`。
>
> 如果全部通过验证，就可以按照题目要求的顺序，放心大胆地输出结果了。
>
> <s>其实这个法子不是非常的自然，特别是 `actrual = actrual * base + number_pos_dig;` 部分</s>，怎么说呢，其实应该是每一位乘上进制然后再 `power`，但其实本质上也一样。

```c
#define _CRT_SECURE_NO_WARNINGS
#include<stdio.h>
#include<stdlib.h>
#include<string.h>
#include<math.h>

int main() {
	int n;
	scanf("%d", &n);
	char str[10][10][5];
	for (int i = 0; i < n; i++) {
		for (int j = 0; j < n; j++) {
			scanf("%s", str[i][j]);
		}
	}

	int val[256];
	char letter[10];

	for (int i = 0; i < 256; i++) {
		val[i] = -1;
	}

	for (int i = 1; i < n; i++) {
		letter[i - 1] = str[0][i][0];
	}

	for (int i = 1; i < n; i++) {
		int cnt = 0;
		for (int j = 1; j < n; j++) {
			if (strlen(str[i][j]) >= 2) {
				cnt++;
			}
		}
		val[(unsigned char)str[i][0][0]] = cnt;
	}

	int found[10] = { 0 };
	for (int i = 1; i < n; i++) {
		int val_ = val[(unsigned char)letter[i - 1]];
		if (val_ < -1 || val_ >= n - 1 || found[val_] != 0) {
			printf("ERROR!\n");
			return 0;
		}
		found[val_] = 1;
	}

	int base = n - 1;
	for (int i = 1; i < n; i++) {
		for (int j = 1; j < n; j++) {
			int exp = val[(unsigned char)str[0][j][0]] + val[(unsigned char)str[i][0][0]];
			int actrual = 0;
			char* st = str[i][j];
			int len = strlen(st);
			for (int k = 0; k < len; k++) {
				int number_pos_dig = val[(unsigned char)st[k]];
				if (number_pos_dig == -1) {
					printf("ERROR!\n");
					return 0;
				}
				actrual = actrual * base + number_pos_dig;
			}
			if (actrual != exp) {
				printf("ERROR!\n");
				return 0;
			}
		}
	}

	for (int i = 0; i < n - 1; i++) {
		printf("%c=%d", letter[i], val[(unsigned char)letter[i]]);
		if (i < n - 2) {
			printf(" ");
		}
	}
	printf("\n%d\n", base);
    
    return 0;
}
```

### 6. P1018 [NOIP 2000 提高组] 乘积最大

**题目背景：**

NOIP2000 提高组 T2

**题目描述：**

今年是国际数学联盟确定的“2000——世界数学年”，又恰逢我国著名数学家华罗庚先生诞辰 90 周年。在华罗庚先生的家乡江苏金坛，组织了一场别开生面的数学智力竞赛的活动，你的一个好朋友 XZ 也有幸得以参加。活动中，主持人给所有参加活动的选手出了这样一道题目：


设有一个长度为 $N$ 的数字串，要求选手使用 $K$ 个乘号将它分成 $K+1$ 个部分，找出一种分法，使得这 $K+1$ 个部分的乘积能够为最大。


同时，为了帮助选手能够正确理解题意，主持人还举了如下的一个例子：


有一个数字串：$312$，当 $N=3,K=1$ 时会有以下两种分法：

1. $3  \times  12=36$ 
2. $31  \times   2=62$  


这时，符合题目要求的结果是：$31  \times  2 = 62$。


现在，请你帮助你的好朋友 XZ 设计一个程序，求得正确的答案。

**输入格式：**

程序的输入共有两行：

第一行共有 $2$ 个自然数 $N,K$。

第二行是一个长度为 $N$ 的数字串。

**输出格式：**

结果显示在屏幕上，相对于输入，应输出所求得的最大乘积（一个自然数）。

**输入输出样例 #1**

*输入 #1*

```
4 2
1231
```

*输出 #1*

```
62
```

**说明/提示：**

**数据范围与约定**

对于 $60\%$ 的测试数据满足 $6\le N\le20$。  
对于所有测试数据，$6\le N\le40,1\le K\le6,K<N$。

> [!TIP]
>
> 本题还是 dp 动态规划，本质是**化整为零，利用局部最优解推导全局最优解**。我们不需要穷举所有乘号的摆放组合，而是专注于“最后一刀切在哪里”。
>
> 1. **状态定义**
>
> 设 $dp[i][j]$ 表示：在原数字串的**前 $i$ 个数字**中，插入 **$j$ 个乘号**所能获得的最大乘积。
>
> 2. **状态转移方程**
>
> 假设第 $j$ 个乘号（最后一个乘号）放在了第 $p$ 个数字后面，那么整个序列被切分为两部分：
>
> - **左半部分（历史最优）：** 前 $p$ 个数字里已经放了 $j-1$ 个乘号，其最大乘积直接从账本上查取，即 $dp[p][j-1]$。
> - **右半部分（新鲜纯数）：** 第 $p+1$ 位到第 $i$ 位构成的独立数字，记作 $\text{number}(p+1, i)$。
>
> 通过枚举所有可能的切刀位置 $p$，打擂台取最大值：
> $$
> dp[i][j] = \max_{j \le p < i} \{ dp[p][j-1] \times \text{number}(p+1, i) \}
> $$
>
> 3. **初始边界**
>
> 当不加任何乘号（$j=0$）时，前 $i$ 个数字的最大乘积就是这 $i$ 个数字构成的原始数值本身：
> $$
> dp[i][0] = \text{number}(1, i)
> $$
> 整套代码的循环控制，底层全靠这一条数学铁律支撑：
>
> > **任何合法算式中，插入 $k$ 个乘号，至少需要 $k+1$ 个数字。**
>
> 为了保证“先算基础、再算进阶”（无后效性），循环顺序必须严格为：**外层乘号数 $\rightarrow$ 中层数字长度 $\rightarrow$ 内层切刀位置**。
>
> | **循环层级**    | **变量含义**   | **起点与终点** | **核心逻辑与边界原因**                                |
> | --------------- | -------------- | -------------- | ----------------------------------------------------- |
> | **第一层 (外)** | `j` (乘号数)   | `1` 到 `K`     | `0` 个乘号已在初始化填完，推导从 `1` 刀练到 `K` 刀    |
> | **第二层 (中)** | `i` (数字长度) | `j + 1` 到 `N` | 塞进 `j` 个乘号至少需 `j+1` 个数，最长为总长 `N`      |
> | **第三层 (内)** | `p` (切刀位置) | `j` 到 `i - 1` | 左边留 `j` 个数放前 `j-1` 刀；右边至少留 1 个数不悬空 |
>
> 
>
> 在最内层循环中，面对具体某一个切刀位置 $p$，程序每次只做四个标准动作：
>
> 1. **切下右边：** 截取第 $p+1$ 到第 $i$ 位的纯数字 $\rightarrow$ `right = number(A, p + 1, i)`
> 2. **结合左边：** 用高精度乘法，把右边纯数字乘以左边的历史最优解 $\rightarrow$ `temp = timing(right, dp[p][j - 1])`
> 3. **擂台比武：** 用高精度比较，拿新方案 `temp` 挑战旧擂主 $\rightarrow$ `if (compare(&temp, &dp[i][j]) > 0)`
> 4. **更新账本：** 如果新方案赢了，替换当前记录 $\rightarrow$ `dp[i][j] = temp`
>
> 本题数据范围 $N \le 40$，最终结果可达 $10^{40}$，必须手写高精度结构体（逆序存储数字每位）。在 C 语言实现中，有三个极其容易导致崩溃或失分的隐蔽陷阱：
>
> 1. 字符串提取时的下标逆转公式
>
> - **痛点：** C 语言字符串从左至右由下标 `0` 开始；高精度数组从右至左由下标 `0`（个位）开始。
> - **解法：** 提取第 `low` 到 `high`（从 1 开始计数）的数字时，高精度数组第 `i` 位对应的字符下标必须是 **`high - 1 - i`**。
>
> 2. 高精度乘法累加溢出
>
> - **痛点：** 如果结构体内部用 `char a[50]` 存数字，乘法核心累加 `res.a[i+j] += a[i] * b[j]` 会让单个数组元素承受 $81 + 81$ 等大数，直接超过有符号字符上限 **127** 变成负数。
> - **解法：** 结构体中存储数字的数组必须使用 `int a[50]`。
>
> 3. 高精度比较不可用 `strcmp`
>
> - **痛点：** 逆序存储时，下标 `0` 是个位。若用 `strcmp` 从头比，相当于“先比个位再比十位”（会误判 19 大于 21）；且遇到了数字 `0` 会被当成字符串结束符 `\0` 截断。
> - **解法：** 必须手写循环，严格从最高位 `len - 1` 向最末位 `0` 倒序逐位比较。

```c
#define _CRT_SECURE_NO_WARNINGS
#include<stdio.h>
#include<stdlib.h>
#include<string.h>
#include<math.h>
#define N_max 43

struct num {
	char a[41];
	int len;
};

typedef struct num Num;

int compare(const void* a, const void* b) {
	Num* x = (Num*)a;
	Num* y = (Num*)b;
	if (x->len != y->len) {
		return x->len - y->len;
	}
	for (int i = x->len; i >= 0; i--) {
		if (x->a[i] != y->a[i]) {
			return x->a[i] - y->a[i];
		}
	}
	return 0;
}

Num timing(Num a, Num b) {
	Num res;
	memset(&res, 0, sizeof(Num));
	res.len = a.len + b.len;

	for (int i = 0; i < a.len; i++) {
		for (int j = 0; j < b.len; j++) {
			res.a[i + j] += a.a[i] * b.a[j];
			res.a[i + j + 1] += res.a[i + j] / 10;
			res.a[i + j] %= 10;
		}
	}

	while (res.len > 1 && res.a[res.len - 1] == 0) {
		res.len--;
	}
	return res;
}

Num number(char* s, int low, int high) {
	Num res;
	memset(&res, 0, sizeof(Num));
	res.len = high - low + 1;
	for (int i = 0; i < res.len; i++) {
		res.a[i] = s[high - i - 1] - '0';
	}

	while (res.len > 1 && res.a[res.len - 1] == 0) {
		res.len--;
	}
	return res;
}

void printing(Num a) {
	int len = a.len;
	for (int i = len - 1; i >= 0; i--) {
		printf("%d", a.a[i]);
	}
}

int main() {
	int N, K;

	scanf("%d %d", &N, &K);
	char A[48];
	scanf("%s", A);

	Num dp[48][7] = { 0 };

	for (int i = 1; i <= N; i++) {
		dp[i][0] = number(A, 1, i);
	}

	for (int j = 1; j <= K; j++) {
		for (int i = j + 1; i <= N; i++) {
			for (int p = j; p < i; p++) {
				Num right = number(A, p + 1, i);
				Num temp = timing(right, dp[p][j - 1]);
				if (compare(&temp, &dp[i][j]) > 0) {
					dp[i][j] = temp;
				}
			}
		}
	}

	printing(dp[N][K]);

	return 0;
}
```

### 7. P1020 [NOIP 1999 提高组] 导弹拦截

**题目描述：**

某国为了防御敌国的导弹袭击，发展出一种导弹拦截系统。但是这种导弹拦截系统有一个缺陷：虽然它的第一发炮弹能够到达任意的高度，但是以后每一发炮弹都不能高于前一发的高度。某天，雷达捕捉到敌国的导弹来袭。由于该系统还在试用阶段，所以只有一套系统，因此有可能不能拦截所有的导弹。


输入导弹依次飞来的高度，计算这套系统最多能拦截多少导弹，如果要拦截所有导弹最少要配备多少套这种导弹拦截系统。

**输入格式：**

一行，若干个整数，中间由空格隔开。

**输出格式：**

两行，每行一个整数，第一个数字表示这套系统最多能拦截多少导弹，第二个数字表示如果要拦截所有导弹最少要配备多少套这种导弹拦截系统。

**输入输出样例 #1**

*输入 #1*

```
389 207 155 300 299 170 158 65
```

*输出 #1*

```
6
2
```

**说明/提示：**

对于前 $50\%$ 数据，满足导弹的个数不超过 $10^4$ 个。该部分数据总分共 $100$ 分。可使用 $\mathcal O(n^2)$ 做法通过。  
对于后 $50\%$ 的数据，满足导弹的个数不超过 $10^5$ 个。该部分数据总分也为 $100$ 分。请使用 $\mathcal O(n\log n)$ 做法通过。

对于全部数据，满足导弹的高度为正整数，且不超过 $5\times 10^4$。


此外本题开启 spj，每点两问，按问给分。

NOIP1999 提高组 第一题

$\text{upd 2022.8.24}$：新增加一组 Hack 数据。

> [!TIP]
>
> **第一问：这套系统最多能拦截多少导弹？**
>
> - **$O(n \log n)$ 做法（贪心 + 二分）：**
>
>   我们可以维护一个数组 `d1`，`d1[len]` 表示**长度为 `len` 的不上升子序列的末尾元素的最大值**。
>
>   （为什么是最大值？因为末尾元素越大，后面越容易接上新的导弹）。
>
>   遍历每一个导弹的高度 $x$：
>
>   1. 如果 $x \le d1$ 的最后一个元素（即目前最短的那个），说明 $x$ 可以直接接在后面，我们把 $x$ 追加到 `d1` 数组末尾，最长长度 `len` 加 1。
>
>   2. 如果 $x > d1$ 的最后一个元素，说明接不上。为了让以后的潜力更大，我们用二分查找在 `d1` 中找到**第一个小于 $x$** 的元素，并把它替换成 $x$。
>
>      （因为把较小的末尾换成较大的 $x$，长度虽然没变，但接纳后续导弹的能力变强了）。
>
>      *最终，`d1` 数组的长度就是最多能拦截的导弹数。*
>
> **第二问：最少要配备多少套系统？**
>
> - **问题本质：将原序列最少划分成多少个“不上升子序列”。**
>
> 这一问有两种理解方式，最终殊途同归：
>
> **理解角度 A：贪心模拟**
>
> 假设我们已经建好了几套系统，面对飞来的新导弹 $x$，我们该用哪套系统拦截？
>
> - **策略：** 应该找目前所有系统的最后一发炮弹高度中，**大于等于 $x$ 且尽量小**的那一个（也就是最接近 $x$ 的那一个，这样浪费的高度最少）。
>
> - **操作：** 维护一个数组 `d2`，记录目前每一套系统拦截的最后一发导弹的高度。
>
>   1. 如果所有的系统末尾高度都 $< x$，说明现有系统都拦截不了，必须**新开一套系统**，把 $x$ 加到 `d2` 结尾。
>
>   2. 否则，在 `d2` 中用二分查找找到**第一个大于等于 $x$** 的元素，更新它为 $x$。
>
>      *最终，`d2` 数组里元素的个数（即系统数量）就是答案。*
>
>      仔细观察你会发现，按照这个逻辑，`d2` 数组里的元素是**严格单调递增**的。
>
> **理解角度 B：数学定理（Dilworth's Theorem）**
>
> 偏序集相关的狄尔沃斯定理指出：**“最小反链划分数 = 最长链的长度”**。
>
> 在这道题翻译过来就是：**“把序列划分成最少个不上升子序列的个数 = 序列的最长严格上升子序列（LIS）的长度”**。
>
> 所以，第二问其实就是在求原序列的最长严格上升子序列（$>$）的长度！
>
> 而我们刚才推导的“角度 A”的贪心数组 `d2` 配合二分查找，恰好就是求最长上升子序列标准 $O(n \log n)$ 算法！两者完美契合。

```c
#define _CRT_SECURE_NO_WARNINGS 
#include<stdio.h>
#include<stdlib.h>
#include<string.h>
#include<math.h>
#define MAXN 100005

int a[MAXN];
int one[MAXN];
int two[MAXN];

int less(int* arr, int low, int high, int val) {
	int mid = 0;
	int ans = 0;
	while (low <= high) {
		mid = low + (high - low) / 2;
		if (arr[mid] < val) {
			ans = mid;
			high = mid - 1;
		}
		else  {
			low = mid + 1;
		}

	}
	return ans;
}

int higher(int* arr, int low, int high, int val) {
	int mid = 0;
	int ans = 0;
	while (low <= high) {
		mid = low + (high - low) / 2;
		if (arr[mid] >= val) {
			ans = mid;
			high = mid - 1;
		}
		else  {
			low = mid + 1;
		}

	}
	return ans;
}

int main() {
	memset(a, 0, sizeof(a));
	int h;
	int len = 1;
	while (scanf("%d", &h) == 1) {
		a[len] = h;
		len++;
	}
	int len1 = 0;
	int len2 = 0;
	for (int i = 1; i < len; i++) {
		int x = a[i];
		if (len1 == 0 || x <= one[len1]) {
			one[++len1] = x;
		}
		else {
			int pos = less(one, 1, len1, x);
			one[pos] = x;
		}
		if (len2 == 0 || x > two[len2]) {
			two[++len2] = x;
		}
		else {
			int pos = higher(two, 1, len2, x);
			two[pos] = x;
		}
	}
	printf("%d\n%d\n", len1, len2);
	return 0;
}
```

### 8. P1026 [NOIP 2001 提高组] 统计单词个数

**题目描述：**

给出一个长度不超过 $200$ 的由小写英文字母组成的字母串（该字串以每行 $20$ 个字母的方式输入，且保证每行一定为 $20$ 个）。要求将此字母串分成
 $k$ 份，且每份中包含的单词个数加起来总数最大。  

每份中包含的单词可以部分重叠。当选用一个单词之后，其第一个字母不能再用。例如字符串 `this` 中可包含 `this` 和 `is`，选用 `this` 之后就不能包含
 `th`。

单词在给出的一个不超过 $6$ 个单词的字典中。

要求输出最大的个数。

**输入格式：**

每组的第一行有两个正整数 $p,k$。
$p$ 表示字串的行数，$k$ 表示分为 $k$ 个部分。

接下来的 $p$ 行，每行均有 $20$ 个字符。

再接下来有一个正整数 $s$，表示字典中单词个数。
接下来的 $s$ 行，每行均有一个单词。

**输出格式：**

$1$个整数，分别对应每组测试数据的相应结果。

**输入输出样例 #1**

*输入 #1*

```
1 3
thisisabookyouareaoh
4
is
a
ok
sab
```

*输出 #1*

```
7
```

**说明/提示：**

**【数据范围】**

对于 $100\%$ 的数据，$2 \le k \le 40$，$1 \le s \le 6$。

**【样例解释】**

划分方案为 this / isabookyoua / reaoh

**【题目来源】**

NOIP 2001 提高组第三题

> [!TIP]
>
> 1. **规则理解**
>
> 题目中有一句非常关键的话：“**当选用一个单词之后，其第一个字母不能再用**”。
>
> 这意味着：在任意一段子串中，**每一个字符位置作为起点，最多只能贡献 1 个单词**。哪怕多个字典里的单词都在这个位置开头，我们也只能选一个；同时，这个单词的存在**不会消耗掉后续的字母**，后续字母依然可以作为新单词的起点（例如 `this` 选了 `this`，消耗了 `t`，但里面的 `i` 依然可以作为 `is` 的开头）。
>
> 因此，为了让某个子串 `str[i...j]` 里面能放下尽可能多的单词，我们只要在这个子串里寻找**以每个位置 $x$ 开头的最短合法单词**。只要这个最短单词的结尾不超过 $j$，位置 $x$ 就能贡献 1 个单词。
>
> 2. **预处理** `cost[i][j]`
>
> 定义 `cost[i][j]` 为子串 `str[i...j]` 中能找到的最多单词数。
>
> - 先求出 `match[i]`：表示以原字符串第 $i$ 个字符开头的字典单词中，**最早结束的那个字符的下标**。如果没有任何单词以第 $i$ 个字符开头，则设为无穷大。
>
> - 递推求 `cost[i][j]`：子串 `str[i...j]` 中的单词数，等于子串 `str[i+1...j]` 中的单词数，加上判断以 $i$ 开头的单词能否在 $j$ 之前（含 $j$）结束。
>
>   状态转移：`cost[i][j] = cost[i+1][j] + (match[i] <= j ? 1 : 0)`
>
> 3. **动态规划过程**
>
> 定义 `dp[i][j]` 表示把前 `i` 个字符划分成 `j` 份所能得到的最大单词数。
>
> - **状态转移方程**：
>
>   $$dp[i][j] = \max(dp[i][j], dp[m][j-1] + cost[m+1][i])$$
>
>   （其中 $m$ 是最后一个分割点，范围是 $j-1 \le m < i$）
>
> - **初始状态**：只分成 1 份时，`dp[i][1] = cost[1][i]`。
>
> - **最终答案**：`dp[L][k]`（其中 $L$ 是总字符串长度）。

```c
#define _CRT_SECURE_NO_WARNINGS 
#include<stdio.h>
#include<stdlib.h>
#include<string.h>
#include<math.h>
#define MAXN 100005

typedef int ElemType;

ElemType p, k, s;
char str[MAXN];
char words[10][MAXN];
ElemType match[MAXN];
ElemType cost[300][300];
ElemType dp[210][60];

int main() {
    if (scanf("%d %d", &p, &k) == EOF) {
        return 0;
    }
    str[0] = '*';
    str[1] = '\0';
    for (int i = 1; i <= p; i++) {
        char word[30];
        scanf("%s", word);
        strcat(str, word);
    }
    int len = strlen(str) - 1;
    scanf("%d", &s);
    for (int i = 0; i < s; i++) {
        scanf("%s", words[i]);
    }

    for (int i = 1; i <= len; i++) {
        match[i] = MAXN;
        for (int j = 0; j < s; j++) {
            int lenth = strlen(words[j]);
            if (i + lenth - 1 <= len) {        
                int is_match = 1;
                for (int x = 0; x < lenth; x++) {  
                    if (str[i + x] != words[j][x]) {
                        is_match = 0;
                        break;
                    }
                }
                if (is_match) {
                    if (i + lenth - 1 < match[i]) { 
                        match[i] = i + lenth - 1;   
                    }
                }
            }
        }
    }

    for (int j = 1; j <= len; j++) {
        for (int i = j; i >= 1; i--) {
            cost[i][j] = cost[i + 1][j];
            if (match[i] <= j) {
                cost[i][j]++;
            }
        }
    }

    memset(dp, -1, sizeof(dp));
    for (int i = 1; i <= len; i++) {
        dp[i][1] = cost[1][i];
    }

    for (int j = 2; j <= k; j++) {
        for (int i = 1; i <= len; i++) {
            for (int l = 1; l < i; l++) {
                if (dp[l][j - 1] != -1) {
                    if (dp[i][j] == -1 || dp[i][j] < dp[l][j - 1] + cost[l + 1][i]) {
                        dp[i][j] = dp[l][j - 1] + cost[l + 1][i];
                    }
                }
            }
        }
    }

    printf("%d\n", dp[len][k]);
    return 0;
}
```

### 9. P1027 [NOIP 2001 提高组] Car 的旅行路线

**题目描述：**

又到暑假了，住在城市 A 的 Car 想和朋友一起去城市旅游。  
她知道每个城市都有 $4$ 个飞机场，分别位于一个矩形的 $4$ 个顶点上，同一个城市中两个机场之间有一条笔直的高速铁路，第 $i$ 个城市中高速铁路的单位里程价格为 $T_i$，任意两个不同城市的机场之间均有航线，所有航线单位里程的价格均为 $t$。


![](https://cdn.luogu.com.cn/upload/image_hosting/odqxn9sz.png)

**注意**：图中并没有标出所有的铁路与航线。


那么 Car 应如何安排到城市 B 的路线才能尽可能的节省花费呢？她发现这并不是一个简单的问题，于是她来向你请教。


找出一条从城市 A 到 B 的旅游路线，出发和到达城市中的机场可以任意选取，要求总的花费最少。

**输入格式：**

第一行为一个正整数 $n$，表示有 $n$ 组测试数据。

每组的第一行有 $4$ 个正整数 $S,t,A,B$。

$S$ 表示城市的个数，$t$ 表示飞机单位里程的价格，$A$，$B$ 分别为城市 A，B 的序号。

接下来有 $S$ 行，其中第 $i$ 行均有 $7$ 个正整数 $x_{i1},y_{i1},x_{i2},y_{i2},x_{i3},y_{i3},T_i$，这当中的 $(x_{i1},y_{i1}), (x_{i2},y_{i2}), (x_{i3},y_{i3})$，分别是第 $i$ 个城市中任意 $3$ 个机场的坐标，$T_i$ 为第 $i$ 个城市高速铁路单位里程的价格。

**输出格式：**

共有 $n$ 行，每行 $1$ 个数据对应测试数据。  
保留一位小数。

**输入输出样例 #1**

*输入 #1*

```
1
3 10 1 3
1 1 1 3 3 1 30
2 5 7 4 5 2 1
8 6 8 8 11 6 3
```

*输出 #1*

```
47.5
```

**说明/提示：**

【数据范围】  
对于 $100\%$ 的数据，$1\le n \le 10$，$1\le S \le 100$，$1\le A,B \le S$，$0\leq t,x_{i1},y_{i1},x_{i2},y_{i2},x_{i3},y_{i3},T_i\leq 500$。

**【题目来源】**

NOIP 2001 提高组第四题

> [!TIP]
>
> 迪杰斯特拉算法，注意要先求第四个机场的坐标。

```c
#define _CRT_SECURE_NO_WARNINGS 
#include<stdio.h>
#include<stdlib.h>
#include<string.h>
#include<math.h>
#define MAXN 100005

typedef int ElemType;

typedef struct node {
    ElemType x;
    ElemType y;
    ElemType city;
} Node;

Node no_4(Node a, Node b, Node c) {
    Node d;
    ElemType ab = (b.x - a.x) * (b.x - a.x) + (b.y - a.y) * (b.y - a.y);
    ElemType bc = (b.x - c.x) * (b.x - c.x) + (b.y - c.y) * (b.y - c.y);
    ElemType ac = (c.x - a.x) * (c.x - a.x) + (c.y - a.y) * (c.y - a.y);

    if (ab + bc == ac) {
        d.x = a.x + c.x - b.x;
        d.y = a.y + c.y - b.y;
    }
    else if (ab + ac == bc) {
        d.x = b.x + c.x - a.x;
        d.y = b.y + c.y - a.y;
    }
    else {
        d.x = a.x + b.x - c.x;
        d.y = a.y + b.y - c.y;
    }
    return d;
}

double dis(Node a, Node b) {
    return sqrt((a.x - b.x) * (a.x - b.x) + (a.y - b.y) * (a.y - b.y));
}

int main() {
    ElemType test_num;
    if (scanf("%d", &test_num) == EOF) return 0;

    int cnt;
    for (cnt = 1; cnt <= test_num; cnt++) {
        ElemType S, t, A, B;
        scanf("%d %d %d %d", &S, &t, &A, &B);

        Node airports[405];  
        double T[105];       
        int num = 0;         

        for (int i = 1; i <= S; i++) {
            Node p1, p2, p3, p4;
            scanf("%d %d %d %d %d %d %lf", &p1.x, &p1.y, &p2.x, &p2.y, &p3.x, &p3.y, &T[i]);

            p1.city = i;
            p2.city = i;
            p3.city = i;

            p4 = no_4(p1, p2, p3);
            p4.city = i;

            airports[num++] = p1;
            airports[num++] = p2;
            airports[num++] = p3;
            airports[num++] = p4;
        }

        double adj[405][405];
        for (int i = 0; i < num; i++) {
            for (int j = 0; j < num; j++) {
                if (i == j) {
                    adj[i][j] = 0;
                }
                else {
                    double d = dis(airports[i], airports[j]);
                    if (airports[i].city == airports[j].city) {
                        adj[i][j] = d * T[airports[i].city]; 
                    }
                    else {
                        adj[i][j] = d * t; 
                    }
                }
            }
        }

        double min_cost[405];
        int visited[405];
        for (int i = 0; i < num; i++) {
            min_cost[i] = 1e15; 
            visited[i] = 0;
        }

        int start_idx = (A - 1) * 4;
        for (int i = 0; i < 4; i++) {
            min_cost[start_idx + i] = 0;
        }

        for (int i = 0; i < num; i++) {
            int u = -1;
            double min_d = 1e15;

            for (int j = 0; j < num; j++) {
                if (!visited[j] && min_cost[j] < min_d) {
                    min_d = min_cost[j];
                    u = j;
                }
            }

            if (u == -1) break;

            visited[u] = 1;

            for (int v = 0; v < num; v++) {
                if (!visited[v] && min_cost[u] + adj[u][v] < min_cost[v]) {
                    min_cost[v] = min_cost[u] + adj[u][v];
                }
            }
        }

        int end_idx = (B - 1) * 4;
        double ans = 1e15;
        for (int i = 0; i < 4; i++) {
            if (min_cost[end_idx + i] < ans) {
                ans = min_cost[end_idx + i];
            }
        }

        printf("%.1lf\n", ans);
    }

    return 0;
}
```

### 10. P1034 [NOIP 2002 提高组] 矩形覆盖

**题目描述：**

在平面上有 $n$ 个点，每个点用一对整数坐标表示。例如：当 $n=4$ 时，$4$ 个点的坐标分别为：$p_1(1,1)$，$p_2(2,2)$，$p_3(3,6)$，$p_4(0,7)$，见图一。

![](https://cdn.luogu.com.cn/upload/image_hosting/dxc1c5k9.png)

这些点可以用 $k$ 个矩形全部覆盖，矩形的边平行于坐标轴。当 $k=2$ 时，可用如图二的两个矩形 $s_1,s_2$ 覆盖，$s_1,s_2$ 面积和为 $4$。问题是当 $n$ 个点坐标和 $k$ 给出后，怎样才能使得覆盖所有点的 $k$ 个矩形的面积之和为最小呢？  
约定：覆盖一个点的矩形面积为 $0$；覆盖平行于坐标轴直线上点的矩形面积也为 $0$。各个矩形必须完全分开（边线与顶点也都不能重合）。

**输入格式：**

第一行共两个整数 $n,k$，含义如题面所示。

接下来 $n$ 行，其中第 $i+1$ 行有两个整数 $x_i,y_i$，表示平面上第 $i$ 个点的坐标。

**输出格式：**

共一行一个整数，为满足条件的最小的矩形面积之和。

**输入输出样例 #1：**

*输入 #1*

```
4 2
1 1
2 2
3 6
0 7

```

*输出 #1*

```
4
```

**说明/提示：**

对于 $100\%$ 数据，满足 $1\le n \le  50$，$1 \le k \le 4$，$0 \le x_i,y_i  \le 500$。

**【题目来源】**

NOIP 2002 提高组第四题

> [!TIP]
>
> 深度优先搜索

```c
#define _CRT_SECURE_NO_WARNINGS 
#include<stdio.h>
#include<stdlib.h>
#include<string.h>
#include<math.h>
#define MAXN 100005

typedef int ElemType;

ElemType MIN = 2222222222222100005;

ElemType max(ElemType a, ElemType b) {
	return a > b ? a : b;
}

ElemType min(ElemType a, ElemType b) {
	return a < b ? a : b;
}

typedef struct rect {
	ElemType xmin, xmax, ymin, ymax;
	ElemType active;
} R;

typedef struct point {
	ElemType x, y;
} P;

P p[MAXN];
R rect[5];
ElemType n, k;

ElemType cmp(const void* a, const void* b) {
	P* p1 = (P*)a;
	P* p2 = (P*)b;
	if (p1->x != p2->x) return p1->x - p2->x;
	return p1->y - p2->y;
}

void add(R* r, ElemType x, ElemType y) {
	if (r->active == 0) {
		r->xmin = x;
		r->xmax = x;
		r->ymin = y;
		r->ymax = y;
		r->active = 1;
	}
	else {
		r->xmin = min(r->xmin, x);
		r->xmax = max(r->xmax, x);
		r->ymin = min(r->ymin, y);
		r->ymax = max(r->ymax, y);
	}
}

ElemType area(R* r) {
	if (r->active == 0) return 0;
	return (r->xmax - r->xmin) * (r->ymax - r->ymin);
}

ElemType isValid() {
	for (int i = 0; i < k; i++) {
		if (rect[i].active == 0) continue;
		for (int j = i + 1; j < k; j++) {
			if (rect[j].active == 0) continue;
			if (rect[i].xmax < rect[j].xmin || rect[j].xmax < rect[i].xmin ||
				rect[i].ymax < rect[j].ymin || rect[j].ymax < rect[i].ymin) {
				continue;
			}
			else {
				return 0;
			}
		}
	}
	return 1;
}

ElemType get_all_area() {
	ElemType total_area = 0;
	for (int i = 0; i < k; i++) {
		total_area += area(&rect[i]);
	}
	return total_area;
}

void dfs(ElemType u) {
	ElemType curr = get_all_area();
	if (curr > MIN) {
		return;
	}
	if (u > n) {
		MIN = curr;
		return;
	}
	for (ElemType i = 0; i < k; i++) {
		R backup = rect[i];

		add(&rect[i], p[u].x, p[u].y);


		if (isValid() == 1) {
			dfs(u + 1);
		}

		rect[i] = backup;


		if (backup.active == 0) {
			break;
		}
	}
}

int main() {
	scanf("%d %d", &n, &k);
	if (n == k) {
		printf("0\n");
		return 0;
	}
	for (ElemType i = 0; i < MAXN; i++) {
		p[i].x = 0;
		p[i].y = 0;
	}
	for (ElemType i = 1; i <= n; i++) {
		scanf("%d %d", &p[i].x, &p[i].y);
	}
	for (ElemType i = 0; i < 5; i++) {
		rect[i].active = 0;
	}




	qsort(p + 1, n, sizeof(P), cmp);

	dfs(1);


	printf("%d\n", MIN);
	return 0;
}
```

### 11. P1038 [NOIP 2003 提高组] 神经网络

**题目背景：**

人工神经网络（Artificial Neural Network）是一种新兴的具有自我学习能力的计算系统，在模式识别、函数逼近及贷款风险评估等诸多领域有广泛的应用。对神经网络的研究一直是当今的热门方向，兰兰同学在自学了一本神经网络的入门书籍后，提出了一个简化模型，他希望你能帮助他用程序检验这个神经网络模型的实用性。

**题目描述：**

在兰兰的模型中，神经网络就是一张有向图，图中的节点称为神经元，而且两个神经元之间至多有一条边相连，下图是一个神经元的例子：

![](https://cdn.luogu.com.cn/upload/image_hosting/61qm40kj.png)

神经元（编号为 $i$）


图中，$X_1 \sim X_3$ 是信息输入渠道，$Y_1 \sim Y_2$ 是信息输出渠道，$C_i$ 表示神经元目前的状态，$U_i$ 是阈值，可视为神经元的一个内在参数。

神经元按一定的顺序排列，构成整个神经网络。在兰兰的模型之中，神经网络中的神经元分为几层；称为输入层、输出层，和若干个中间层。每层神经元只向下一层的神经元输出信息，只从上一层神经元接受信息。下图是一个简单的三层神经网络的例子。

![](https://cdn.luogu.com.cn/upload/image_hosting/4xd7f8yz.png)

兰兰规定，$C_i$ 服从公式：（其中 $n$ 是网络中所有神经元的数目）

$$
C_i=\left(\sum\limits_{(j,i) \in E} W_{ji}C_{j}\right)-U_{i}
$$

公式中的 $W_{ji}$（可能为负值）表示连接 $j$ 号神经元和 $i$ 号神经元的边的权值。当 $C_i$ 大于 $0$ 时，该神经元处于兴奋状态，否则就处于平静状态。当神经元处于兴奋状态时，下一秒它会向其他神经元传送信号，信号的强度为 $C_i$。

如此．在输入层神经元被激发之后，整个网络系统就在信息传输的推动下进行运作。现在，给定一个神经网络，及当前输入层神经元的状态（$C_i$），要求你的程序运算出最后网络输出层的状态。

**输入格式：**

输入文件第一行是两个整数 $n$（$1 \le n \le 100$）和 $p$。接下来 $n$ 行，每行 $2$ 个整数，第 $i+1$ 行是神经元 $i$ 最初状态和其阈值（$U_i$），非输入层的神经元开始时状态必然为 $0$。再下面 $p$ 行，每行有两个整数 $i,j$ 及一个整数 $W_{ij}$（$|W_{ij}|\leq 10^9$），表示连接神经元 $i,j$ 的边权值为 $W_{ij}$。

**输出格式：**

输出文件包含若干行，每行有 $2$ 个整数，分别对应一个神经元的编号，及其最后的状态，$2$ 个整数间以空格分隔。仅输出最后状态大于 $0$ 的输出层神经元状态，并且按照编号由小到大顺序输出。

若输出层的神经元最后状态均小于等于 $0$，则输出 `NULL`。

**输入输出样例 #1：**

*输入 #1*

```
5 6
1 0
1 0
0 1
0 1
0 1
1 3 1
1 4 1
1 5 1
2 3 1
2 4 1
2 5 1
```

*输出 #1*

```
3 1
4 1
5 1
```

**说明/提示：**

**【题目来源】**

NOIP 2003 提高组第一题

> [!TIP]
>
> 本质拓扑排序

```c
#define _CRT_SECURE_NO_WARNINGS 
#include<stdio.h>
#include<stdlib.h>
#include<string.h>
#include<math.h>
#define MAXN 100005
#define M 105

typedef int ElemType;

ElemType MIN = 100005;

ElemType max(ElemType a, ElemType b) {
	return a > b ? a : b;
}

ElemType min(ElemType a, ElemType b) {
	return a < b ? a : b;
}

ElemType n, p;
ElemType adj[M][M];
ElemType has_edge[M][M];
ElemType C[M];
ElemType U[M];

ElemType in_degree[M];
ElemType out_degree[M];

ElemType q[1005];
ElemType head, tail;

int main() {
	for (int i = 0; i < M; i++) {
		for (int j = 0; j < M; j++) {
			adj[i][j] = MIN;
		}
	}
	scanf("%d %d", &n, &p);
	for (int i = 1; i <= n; i++) {
		int u;
		scanf("%d", &C[i]);
		scanf("%d", &u);
		if (C[i] == 0) {
			C[i] = -u;
		}
	}
	for (int cnt = 0; cnt < p; cnt++) {
		int i, j, w;
		scanf("%d %d %d", &i, &j, &w);
		has_edge[i][j] = 1;
		adj[i][j] = w;
		in_degree[j]++;
		out_degree[i]++;
	}

	for (int i = 1; i <= n; i++) {
		if (in_degree[i] == 0) {
			q[tail++] = i;
		}
	}

	while (head < tail) {
		int u = q[head++];
		for (int v = 1; v <= n; v++) {
			if (has_edge[u][v] == 1) {
				if (C[u] > 0) {
					C[v] += C[u] * adj[u][v];
				}
				in_degree[v]--;
				if (in_degree[v] == 0) {
					q[tail++] = v;
				}
			}
		}
	}
	int flag = 0;
	for (int i = 1; i <= n; i++) {
		if (out_degree[i] == 0) {
			if (C[i] > 0) {
				printf("%d %d\n", i, C[i]);
				flag = 1;
			}
		}
	}
	if (flag == 0) {
		printf("NULL\n");

	}

	return 0;
}
```

### 12. P1040 [NOIP 2003 提高组] 加分二叉树

**题目描述：**

设一个 $n$ 个节点的二叉树 $\text{tree}$ 的中序遍历为$(1,2,3,\ldots,n)$，其中数字 $1,2,3,\ldots,n$ 为节点编号。每个节点都有一个分数（均为正整数），记第 $i$ 个节点的分数为 $d_i$，$\text{tree}$ 及它的每个子树都有一个加分，任一棵子树 $\text{subtree}$（也包含 $\text{tree}$ 本身）的加分计算方法如下：


$\text{subtree}$ 的左子树的加分 $\times$ $\text{subtree}$ 的右子树的加分 $+$ $\text{subtree}$ 的根的分数。

若某个子树为空，规定其加分为 $1$，叶子的加分就是叶节点本身的分数。不考虑它的空子树。

试求一棵符合中序遍历为 $(1,2,3,\ldots,n)$ 且加分最高的二叉树 $\text{tree}$。要求输出：

1. $\text{tree}$ 的最高加分。

2. $\text{tree}$ 的前序遍历。

**输入格式：**

第 $1$ 行 $1$ 个整数 $n$，为节点个数。

第 $2$ 行 $n$ 个用空格隔开的整数，为每个节点的分数。

**输出格式：**

第 $1$ 行 $1$ 个整数，为最高加分（$ Ans \le 4,000,000,000$）。

第 $2$ 行 $n$ 个用空格隔开的整数，为该树的前序遍历。

如果你输出的前序遍历不合法，可能会出现 UKE 的评测记录。

**输入输出样例 #1**

*输入 #1*

```
5
5 7 1 2 10
```

*输出 #1*

```
145
3 1 2 4 5
```

**说明/提示：**

*数据规模与约定：*

对于全部的测试点，保证 $1 \leq n< 30$，节点的分数是小于 $100$ 的正整数，答案不超过 $4 \times 10^9$。

> [!TIP]
>
> 动态规划

```c
#define _CRT_SECURE_NO_WARNINGS 
#include<stdio.h>
#include<stdlib.h>
#include<string.h>
#include<math.h>
#define MAXN 100005
#define M 35

typedef int ElemType;
typedef long long ll;

ElemType MIN = 100005;

ElemType max(ElemType a, ElemType b) {
	return a > b ? a : b;
}

ElemType min(ElemType a, ElemType b) {
	return a < b ? a : b;
}

ElemType n;
ll tree[M];
ll dp[M][M];
ElemType root[M][M];

void pre(ElemType l, ElemType r) {
	if (l > r) {
		return;
	}
	ElemType k = root[l][r];
	printf("%d ", k);
	pre(l, k - 1);
	pre(k + 1, r);
}

int main() {
	scanf("%d", &n);
	for (int i = 1; i <= n; i++) {
		scanf("%lld", &tree[i]);
	}
	for (int i = 0; i <= n + 1; i++) {
		for (int j = 0; j <= n + 1; ++j) {
			dp[i][j] = 1;
		}
	}
	for (int i = 1; i <= n; i++) {
		dp[i][i] = tree[i];
		root[i][i] = i;
	}
	for (int i = 2; i <= n; i++) {
		for(int j=1;j<= n - i + 1; j++) {
			int k = j + i - 1;
			dp[j][k] = 0;
			for (int m = j; m <= k; m++) {
				ll temp = dp[j][m - 1] * dp[m + 1][k] + tree[m];
				if (temp > dp[j][k]) {
					dp[j][k] = temp;
					root[j][k] = m;
				}
			}
		}
	}
	printf("%lld\n", dp[1][n]);
	pre(1, n);
	return 0;
}
```

### 13. P1043 [NOIP 2003 普及组] 数字游戏

**题目描述：**

丁丁最近沉迷于一个数字游戏之中。这个游戏看似简单，但丁丁在研究了许多天之后却发觉原来在简单的规则下想要赢得这个游戏并不那么容易。游戏是这样的，在你面前有一圈整数（一共 $n$ 个），你要按顺序将其分为 $m$ 个部分，各部分内的数字相加，相加所得的 $m$ 个结果对 $10$ 取模后再相乘，最终得到一个数 $k$。游戏的要求是使你所得的 $k$ 最大或者最小。


例如，对于下面这圈数字（$n=4$，$m=2$）：

![](https://cdn.luogu.com.cn/upload/image_hosting/gy407k49.png)

要求最小值时，$((2-1)\bmod10)\times ((4+3)\bmod10)=1\times 7=7$，要求最大值时，为 $((2+4+3)\bmod10)\times (-1\bmod10)=9\times 9=81$。特别值得注意的是，无论是负数还是正数，对 $10$ 取模的结果均为非负值。

丁丁请你编写程序帮他赢得这个游戏。

**输入格式：**

输入文件第一行有两个整数，$n$（$1\le n\le 50$）和 $m$（$1\le m\le 9$）。以下 $n$ 行每行有个整数，其绝对值 $\le10^4$，按顺序给出圈中的数字，首尾相接。

**输出格式：**

输出文件有 $2$ 行，各包含 $1$ 个非负整数。第 $1$ 行是按题目要求对 $10$ 取模后得到的最小值，第 $2$ 行是按题目要求对 $10$ 取模后得到的最大值。

**输入输出样例 #1**

*输入 #1*

```
4 2
4
3
-1
2
```

*输出 #1*

```
7
81
```

**说明/提示：**

**【题目来源】**

NOIP 2003 普及组第二题

> [!TIP]
>
> 依旧动态规划 + 破坏成链

```c
#define _CRT_SECURE_NO_WARNINGS 
#include<stdio.h>
#include<stdlib.h>
#include<string.h>
#include<math.h>
#define MAXN 100005
#define MAXNL 2000005
#define MM 35
#define INF 0x3f3f3f3f
#define MMM 105
#define MMMM 55

typedef int ElemType;
typedef long long ll;

ElemType MIN = 100005;

ElemType cmp(const void* a, const void* b) {
	return (*(ElemType*)a - *(ElemType*)b);
}

ElemType max(ElemType a, ElemType b) {
	return a > b ? a : b;
}

ElemType min(ElemType a, ElemType b) {
	return a < b ? a : b;
}

ElemType mod10(int x) {
	if (x < 0) {
		return (x % 10 + 10) % 10;
	}
	return x % 10;
}

ElemType n, m;
ElemType a[MAXN];
ElemType pref[MAXN];
ElemType dp_max[MMM][MMM][MMM];
ElemType dp_min[MMM][MMM][MMM];

int main() {
	scanf("%d %d", &n, &m);
	for (int i = 1; i <= n; i++) {
		scanf("%d", &a[i]);
		a[i + n] = a[i];
	}
	for (int i = 1; i <= 2 * n; i++) {
		pref[i] = pref[i - 1] + a[i];
	}
	for (int i = 1; i <= 2 * n; i++) {
		for (int j = 1; j <= 2 * n; j++) {
			for (int k = 1; k <= m; k++) {
				dp_max[i][j][k] = -1;
				dp_min[i][j][k] = INF;
			}
		}
	}
	for (int len = 1; len <= n; len++) {
		for (int i = 1; i + len - 1 <= 2 * n; i++) {
			int j = i + len - 1;
			dp_max[i][j][1] = dp_min[i][j][1] = mod10(pref[j] - pref[i - 1]);
		}
	}
	for (int k = 2; k <= m; k++) {
		for (int len = k; len <= n; len++) {
			for (int i = 1; i <= 2 * n - len + 1; i++) {
				int j = i + len - 1;

				for (int p = i + k - 2; p < j; p++) {
					ElemType val = mod10(pref[j] - pref[p]);

					dp_max[i][j][k] = max(dp_max[i][j][k], dp_max[i][p][k - 1] * val);
					dp_min[i][j][k] = min(dp_min[i][j][k], dp_min[i][p][k - 1] * val);
				}
			}
		}
	}
	ElemType ans_max = -1;
	ElemType ans_min = INF;
	for (int i = 1; i <= n; i++) {
		ans_max = max(ans_max, dp_max[i][i + n - 1][m]);
		ans_min = min(ans_min, dp_min[i][i + n - 1][m]);
	}
	printf("%d\n%d\n", ans_min, ans_max);
	return 0;
}
```

### 14. P1052 [NOIP 2005 提高组] 过河

**题目描述：**

在河上有一座独木桥，一只青蛙想沿着独木桥从河的一侧跳到另一侧。在桥上有一些石子，青蛙很讨厌踩在这些石子上。由于桥的长度和青蛙一次跳过的距离都是正整数，我们可以把独木桥上青蛙可能到达的点看成数轴上的一串整点：$0,1,\cdots,L$（其中 $L$ 是桥的长度）。坐标为 $0$ 的点表示桥的起点，坐标为 $L$ 的点表示桥的终点。青蛙从桥的起点开始，不停的向终点方向跳跃。一次跳跃的距离是 $S$ 到 $T$ 之间的任意正整数（包括 $S,T$）。当青蛙跳到或跳过坐标为 $L$ 的点时，就算青蛙已经跳出了独木桥。

题目给出独木桥的长度 $L$，青蛙跳跃的距离范围 $S,T$，桥上石子的位置。你的任务是确定青蛙要想过河，最少需要踩到的石子数。

**输入格式：**

输入共三行，

- 第一行有 $1$ 个正整数 $L$，表示独木桥的长度。
- 第二行有 $3$ 个正整数 $S,T,M$，分别表示青蛙一次跳跃的最小距离，最大距离及桥上石子的个数。
- 第三行有 $M$ 个不同的正整数分别表示这 $M$ 个石子在数轴上的位置（数据保证桥的起点和终点处没有石子）。所有相邻的整数之间用一个空格隔开。

**输出格式：**

一个整数，表示青蛙过河最少需要踩到的石子数。

**输入输出样例 #1**

*输入 #1*

```
10
2 3 5
2 3 5 6 7
```

*输出 #1*

```
2
```

**说明/提示：**

**【数据范围】**

- 对于 $30\%$ 的数据，$1\le L \le 10^4$；
- 对于 $100\%$ 的数据，$1\le L \le 10^9$，$1\le S\le T\le10$，$1\le M\le100$。

**【题目来源】**

NOIP 2005 提高组第二题

> [!TIP]
>
> 处理特例，路径压缩，动态规划。

```c
#define _CRT_SECURE_NO_WARNINGS 
#include<stdio.h>
#include<stdlib.h>
#include<string.h>
#include<math.h>
#define MAXN 100005
#define MAXNL 20005
#define MM 35
#define INF 0x3f3f3f3f
#define MMM 105

typedef int ElemType;
typedef long long ll;

ElemType MIN = 100005;

ElemType cmp(const void* a, const void* b) {
	return (*(ElemType*)a - *(ElemType*)b);
}

ElemType max(ElemType a, ElemType b) {
	return a > b ? a : b;
}

ElemType min(ElemType a, ElemType b) {
	return a < b ? a : b;
}

ll L, S, T, M;
ElemType stone[MMM];
ElemType mark[MAXN];
ElemType dp[MAXN];

ElemType equal(ElemType S, ElemType M) {
	ElemType num;
	for (int i = 1; i <= M; i++) {
		if (stone[i] % S == 0) {
			num++;
		}
	}
	return num;
}

ElemType compress(ElemType L, ElemType M) {
	qsort(stone + 1, M, sizeof(ElemType), cmp);
	ElemType last = 0;
	ElemType curr = 0;
	for (ElemType i = 1; i <= M; i++) {
		ElemType gap = stone[i] - stone[i - 1];
		if (gap > 100) {
			gap = gap % 90 + 90;
		}
		curr = last + gap;
		mark[curr] = 1;
		last = curr;
	}
	ElemType gapL = L - stone[M];
	if (gapL > 100) {
		gapL = gapL % 90 + 90;
	}
	return gapL + last;
}

ElemType DP(ElemType Lnew, ElemType S, ElemType T) {
	for (ElemType i = 1; i <= Lnew + T; i++) {
		dp[i] = INF;
	}
	dp[0] = 0;
	for(ElemType i = 1; i <= Lnew + T; i++) {
		for (ElemType j = S; j <= T; j++) {
			if (i >= j) {
				dp[i] = min(dp[i], dp[i - j] + mark[i]);
			}
		}
	}
	ElemType minStone = INF;
	for (int i = Lnew; i <= Lnew + T; i++) {
		minStone = min(minStone, dp[i]);
	}
	return minStone;
}

int main() {
	scanf("%lld %lld %lld %lld", &L, &S, &T, &M);
	for (int i = 1; i <= M; i++) {
		scanf("%d", &stone[i]);
	}
	if (S == T) {
		ElemType num = equal(S, M);
		printf("%d", num);
	}
	else {
		ElemType Lnew = compress(L, M);
		ElemType dp_f = DP(Lnew, S, T);
		printf("%d", dp_f);
	}
	return 0;
}
```

### 15. P1063 [NOIP 2006 提高组] 能量项链

**题目描述**

在 Mars 星球上，每个 Mars 人都随身佩带着一串能量项链。在项链上有 $N$ 颗能量珠。能量珠是一颗有头标记与尾标记的珠子，这些标记对应着某个正整数。并且，对于相邻的两颗珠子，前一颗珠子的尾标记一定等于后一颗珠子的头标记。因为只有这样，通过吸盘（吸盘是 Mars 人吸收能量的一种器官）的作用，这两颗珠子才能聚合成一颗珠子，同时释放出可以被吸盘吸收的能量。如果前一颗能量珠的头标记为 $m$，尾标记为 $r$，后一颗能量珠的头标记为 $r$，尾标记为 $n$，则聚合后释放的能量为 $m \times r \times n$（Mars 单位），新产生的珠子的头标记为 $m$，尾标记为 $n$。

需要时，Mars 人就用吸盘夹住相邻的两颗珠子，通过聚合得到能量，直到项链上只剩下一颗珠子为止。显然，不同的聚合顺序得到的总能量是不同的，请你设计一个聚合顺序，使一串项链释放出的总能量最大。

例如：设 $N=4$，$4$ 颗珠子的头标记与尾标记依次为 $(2,3)(3,5)(5,10)(10,2)$。我们用记号 $\oplus$ 表示两颗珠子的聚合操作，$(j \oplus k)$ 表示第 $j,k$ 两颗珠子聚合后所释放的能量。则第 $4$，$1$ 两颗珠子聚合后释放的能量为：

$(4 \oplus 1)=10 \times 2 \times 3=60$。

这一串项链可以得到最优值的一个聚合顺序所释放的总能量为：

$(((4 \oplus 1) \oplus 2) \oplus 3)=10 \times 2 \times 3+10 \times 3 \times 5+10 \times 5 \times 10=710$。

**输入格式：**

第一行是一个正整数 $N$（$4 \le N \le 100$），表示项链上珠子的个数。第二行是 $N$ 个用空格隔开的正整数，所有的数均不超过 $1000$。第 $i$ 个数为第 $i$ 颗珠子的头标记（$1 \le i \le N$），当 $i<N$ 时，第 $i$ 颗珠子的尾标记应该等于第 $i+1$ 颗珠子的头标记。第 $N$ 颗珠子的尾标记应该等于第 $1$ 颗珠子的头标记。

至于珠子的顺序，你可以这样确定：将项链放到桌面上，不要出现交叉，随意指定第一颗珠子，然后按顺时针方向确定其他珠子的顺序。

**输出格式：**

一个正整数 $E$（$E\le 2.1 \times 10^9$），为一个最优聚合顺序所释放的总能量。

**输入输出样例 #1**

*输入 #1*

```
4
2 3 5 10
```

*输出 #1*

```
710
```

**说明/提示：**

NOIP 2006 提高组 第一题

> [!TIP]
>
> 本质上是**圆形区间动态规划**，与第 13 题类似。
>
> 定义 `dp[i][j]` 表示将从第 `i` 颗珠子到第 `j` 颗珠子的一段项链完全聚合后释放的最大能量。
>
> 状态转移：枚举最后一次聚合的位置 `k`，即第一段从珠子 `i` 到 `k`，第二段从珠子 `k+1` 到 `j`。聚合后释放的能量为：`dp[i][k] + dp[k+1][j] + head[i] * head[k+1] * head[j+1]`。
>
> 由于是圆形的，需要**破坏成链**：将数组长度翻倍，分别从每个位置 `i` 开始，计算到 `i+n-1` 为止的最大能量，然后取所有情况的最大值。

```c
#define _CRT_SECURE_NO_WARNINGS
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <math.h>
#define MAXN 100005
#define MMM 105

typedef int ElemType;
typedef long long ll;

ElemType n;
ElemType chain_head[MMM];
ElemType chain[2 * MMM];
ElemType dp[2 * MMM][2 * MMM];

ElemType max(ElemType a, ElemType b) {
    return a > b ? a : b;
}

int main() {
    scanf("%d", &n);
    for (ElemType i = 1; i <= n; i++) {
        scanf("%d", &chain_head[i]);
    }
    
    for (ElemType i = 1; i <= n; i++) {
        chain[i] = chain_head[i];
        chain[i + n] = chain_head[i];
    }
    
    for (ElemType len = 2; len <= n; len++) {
        for (ElemType i = 1; i <= 2 * n - len + 1; i++) {
            ElemType j = i + len - 1;
            for (ElemType k = i; k < j; k++) {
                ElemType curr = dp[i][k] + dp[k + 1][j] + chain[i] * chain[k + 1] * chain[j + 1];
                dp[i][j] = max(dp[i][j], curr);
            }
        }
    }
    
    ll max_max = 0;
    for (ElemType i = 1; i <= n; i++) {
        max_max = max(max_max, dp[i][i + n - 1]);
    }
    printf("%lld\n", max_max);
    return 0;
}
```

### 16. P1064 [NOIP 2006 提高组] 金明的预算方案

**题目描述**

金明今天很开心，家里购置的新房就要领钥匙了，新房里有一间金明自己专用的很宽敞的房间。更让他高兴的是，妈妈昨天对他说："你的房间需要购买哪些物品，怎么布置，你说了算，只要不超过 $n$ 元钱就行"。今天一早，金明就开始做预算了，他把想买的物品分为两类：主件与附件，附件是从属于某个主件的，下表就是一些主件与附件的例子：

|  主件  |      附件      |
| :----: | :------------: |
|  电脑  | 打印机，扫描仪 |
|  书柜  |      图书      |
|  书桌  |   台灯，文具   |
| 工作椅 |       无       |

如果要买归类为附件的物品，必须先买该附件所属的主件。每个主件可以有 $0$ 个、$1$ 个或 $2$ 个附件。每个附件对应一个主件，附件不再有从属于自己的附件。金明想买的东西很多，肯定会超过妈妈限定的 $n$ 元。于是，他把每件物品规定了一个重要度，分为 $5$ 等：用整数 $1 \sim 5$ 表示，第 $5$ 等最重要。他还从因特网上查到了每件物品的价格（都是 $10$ 元的整数倍）。他希望在不超过 $n$ 元的前提下，使每件物品的价格与重要度的乘积的总和最大。

设第 $j$ 件物品的价格为 $v_j$，重要度为 $w_j$，共选中了 $k$ 件物品，编号依次为 $j_1,j_2,\dots,j_k$，则所求的总和为：

$$
v_{j_1} \times w_{j_1}+v_{j_2} \times w_{j_2}+ \dots +v_{j_k} \times w_{j_k}
$$

请你帮助金明设计一个满足要求的购物单。

**输入格式**

第一行有两个整数，分别表示总钱数 $n$ 和希望购买的物品个数 $m$。

第 $2$ 到第 $(m + 1)$ 行，每行三个整数，第 $(i + 1)$ 行的整数 $v_i$，$w_i$，$q_i$ 分别表示第 $i$ 件物品的价格、重要度以及它对应的的主件。如果 $q_i=0$，表示该物品本身是主件。

**输出格式**

输出一行一个整数表示答案。

**输入输出样例 #1**

*输入 #1*

```
1000 5
800 2 0
400 5 1
300 5 1
400 3 0
500 2 0
```

*输出 #1*

```
2200
```

**说明/提示**

NOIP 2006 提高组 第二题

> [!TIP]
>
> 这是一个**树形背包**问题。需要先按主件分组，每个主件最多有 2 个附件。
>
> **核心思想**：
>
> 1. **数据整理**：读入物品信息后，按主件编号分组。每个主件记录其编号，以及它最多 2 个附件的编号。
>
> 2. **状态定义**：设 `dp[i]` 表示花费 `i` 元时能获得的最大价值。
>
> 3. **对每个主件的处理**：
>    - 如果不买该主件，跳过。
>    - 如果只买主件本身（不买附件），则这个主件花费其价格。
>    - 如果买主件 + 附件 1，花费为主件价格 + 附件 1 价格。
>    - 如果买主件 + 附件 2，花费为主件价格 + 附件 2 价格。
>    - 如果买主件 + 附件 1 + 附件 2，花费为主件价格 + 附件 1 价格 + 附件 2 价格。
>
> 4. **滚动数组背包**：对于每个主件的所有购买方案，用**二维背包**处理，枚举该主件的 4 种购买选择（不买、只买主件、主件+附件1、主件+附件2、主件+两个附件），更新 `dp` 数组。

```c
// #define _CRT_SECURE_NO_WARNINGS
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <math.h>
#define MAXN 100005
#define MAXNL 20005
#define MM 35
#define INF 0x3f3f3f3f
#define MMM 105

typedef int ElemType;
typedef long long ll;

ElemType MIN = 100005;

ElemType cmp(const void *a, const void *b)
{
    return (*(ElemType *)a - *(ElemType *)b);
}

ElemType max(ElemType a, ElemType b)
{
    return a > b ? a : b;
}

ElemType min(ElemType a, ElemType b)
{
    return a < b ? a : b;
}

ElemType n, m;
ElemType v[2 * MAXNL];
ElemType w[2 * MAXNL];
ElemType q[2 * MAXNL];

struct node
{
    ElemType cost;
    ElemType val;
};

typedef struct node Item;

struct Node
{
    Item master;
    Item attach[2];
    ElemType attach_cnt;
};

typedef struct Node Group;

Group groups[65];
ElemType dp[3225];

int main()
{
    scanf("%d %d", &n, &m);
    n /= 10;
    for (ElemType i = 1; i <= m; i++)
    {
        ElemType a, b, c;
        scanf("%d %d %d", &a, &b, &c);
        v[i] = a;
        w[i] = b;
        q[i] = c;
        ElemType cost = a / 10;
        ElemType val = a * b;
        if (c == 0)
        {
            groups[i].master.cost = cost;
            groups[i].master.val = val;
        }
        else
        {
            ElemType cnt = groups[c].attach_cnt;
            groups[c].attach[cnt].cost = cost;
            groups[c].attach[cnt].val = val;
            groups[c].attach_cnt++;
        }
    }
    for (ElemType i = 1; i <= m; i++)
    {
        if (groups[i].master.cost == 0)
        {
            continue;
        }
        ElemType c = groups[i].master.cost;
        ElemType v = groups[i].master.val;
        ElemType c1 = groups[i].attach[0].cost;
        ElemType v1 = groups[i].attach[0].val;
        ElemType c2 = groups[i].attach[1].cost;
        ElemType v2 = groups[i].attach[1].val;
        for (int j = n; j >= c; j--)
        {
            dp[j] = max(dp[j], dp[j - c] + v);
            if (j >= c + c1)
            {
                dp[j] = max(dp[j], dp[j - c - c1] + v + v1);
            }
            if (j >= c + c2)
            {
                dp[j] = max(dp[j], dp[j - c - c2] + v + v2);
            }
            if (j >= c + c1 + c2)
            {
                dp[j] = max(dp[j], dp[j - c - c1 - c2] + v + v1 + v2);
            }
        }
    }
    printf("%d", dp[n]);
    return 0;
}
```

### 17. 

### 18. P1048 [NOIP 2005 普及组] 采药

**题目描述**

辰辰是个天资聪颖的孩子，他的梦想是成为世界上最伟大的医师。为此，他想拜附近最有威望的医师为师。医师为了判断他的资质，给他出了一个难题。医师把他带到一个到处都是草药的山洞里对他说：“孩子，这个山洞里有一些不同的草药，采每一株都需要一些时间，每一株也有它自身的价值。我会给你一段时间，在这段时间里，你可以采到一些草药。如果你是一个聪明的孩子，你应该可以让采到的草药的总价值最大。”


如果你是辰辰，你能完成这个任务吗？

**输入格式**

第一行有 $2$ 个整数 $T$（$1 \le T \le 1000$）和 $M$（$1 \le  M \le 100$），用一个空格隔开，$T$ 代表总共能够用来采药的时间，$M$ 代表山洞里的草药的数目。

接下来的 $M$ 行每行包括两个在 $1$ 到 $100$ 之间（包括 $1$ 和 $100$）的整数，分别表示采摘某株草药的时间和这株草药的价值。

**输出格式**

输出在规定的时间内可以采到的草药的最大总价值。

**输入输出样例 #1**

*输入 #1*

```
70 3
71 100
69 1
1 2

```

*输出 #1*

```
3
```

**说明/提示**

**【数据范围】**

- 对于 $30\%$ 的数据，$M \le 10$；
- 对于全部的数据，$M \le 100$。

**【题目来源】**

NOIP 2005 普及组第三题

```c
// #define _CRT_SECURE_NO_WARNINGS
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <math.h>
#define MAXN 100005
#define MAXNL 20005
#define MM 35
#define INF 0x3f3f3f3f
#define MMM 105
#define MINL -1

typedef int ElemType;
typedef long long ll;

ElemType cmp(const void *a, const void *b)
{
    return (*(ElemType *)a - *(ElemType *)b);
}

ElemType max(ElemType a, ElemType b)
{
    return a > b ? a : b;
}

ElemType min(ElemType a, ElemType b)
{
    return a < b ? a : b;
}

ElemType T, M;

typedef struct
{
    ElemType time;
    ElemType value;
} Med;

Med medicine[105];

ElemType dp[1005];

int main()
{
    scanf("%d %d", &T, &M);
    for (int i = 1; i <= M; i++)
    {
        ElemType time, value;
        scanf("%d %d", &time, &value);
        medicine[i].time = time;
        medicine[i].value = value;
    }
    for (int i = 1; i <= M; i++)
    {
        for (int j = T; j >= medicine[i].time; j--)
        {
            dp[j] = max(dp[j], dp[j - medicine[i].time] + medicine[i].value);
        }
    }
    printf("%d", dp[T]);
    return 0;
}
```

### 19. P1028 [NOIP 2001 普及组] 数的计算

**题目描述**

给出正整数 $n$，要求按如下方式构造数列：

1. 只有一个数 $n$ 的数列是一个合法的数列。
2. 在一个合法的数列的末尾加入一个正整数，但是这个正整数不能超过该数列最后一项的一半，可以得到一个新的合法数列。

请你求出，一共有多少个合法的数列。两个合法数列 $a, b$ 不同当且仅当两数列长度不同或存在一个正整数 $i \leq |a|$，使得 $a_i \neq b_i$。

**输入格式**

输入只有一行一个整数，表示 $n$。

**输出格式**

输出一行一个整数，表示合法的数列个数。

**输入输出样例 #1**

*输入 #1*

```
6

```

*输出 #1*

```
6

```

**说明/提示**

*样例 1 解释*

满足条件的数列为：
- $6$
- $6, 1$
- $6, 2$
- $6, 3$
- $6, 2, 1$
- $6, 3, 1$

*数据规模与约定*

对于全部的测试点，保证 $1 \leq n \leq 10^3$。

*说明*

本题数据来源是 NOIP 2001 普及组第一题，但是原题的题面描述和数据不符，故对题面进行了修改，使之符合数据。原题面如下，谨供参考：

> 我们要求找出具有下列性质数的个数（包含输入的正整数 $n$）。
>
> 先输入一个正整数 $n$（$n \le 1000$），然后对此正整数按照如下方法进行处理：
>
> 1. 不作任何处理；
> 2. 在它的左边拼接一个正整数，但该正整数不能超过原数，或者是上一个被拼接的数的一半；
> 3. 加上数后，继续按此规则进行处理，直到不能再加正整数为止。

感谢 @[dbxxx](https://www.luogu.com.cn/user/120868) 对本题情况的反馈，原题面的问题见[本贴](https://www.luogu.com.cn/discuss/526184)。

```c
// #define _CRT_SECURE_NO_WARNINGS
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <math.h>
#define MAXN 100005
#define MAXNL 20005
#define MM 35
#define INF 0x3f3f3f3f
#define MMM 105
#define MINL -1

typedef int ElemType;
typedef long long ll;

ElemType cmp(const void *a, const void *b)
{
    return (*(ElemType *)a - *(ElemType *)b);
}

ElemType max(ElemType a, ElemType b)
{
    return a > b ? a : b;
}

ElemType min(ElemType a, ElemType b)
{
    return a < b ? a : b;
}

ElemType n;

ElemType cal(ElemType n)
{
    ElemType sum = 1;
    while (n >= 1)
    {
        ElemType tmp = n / 2;
        sum += tmp;
        n /= 2;
    }
    return sum;
}

ElemType dp[100000];

int main()
{
    scanf("%d", &n);
    int sum = cal(n);
    dp[1] = 1;
    for (int i = 2; i <= n; i++)
    {
        dp[i] = 1;
        for (int j = 1; j <= i / 2; j++)
        {
            dp[i] += dp[j];
        }
    }
    printf("%d", dp[n]);
    return 0;
}
```

### 20. P1003 [NOIP 2011 提高组] 铺地毯

**题目描述**

为了准备一个独特的颁奖典礼，组织者在会场的一片矩形区域（可看做是平面直角坐标系的第一象限）铺上一些矩形地毯。一共有 $n$ 张地毯，编号从 $1$ 到 $n$。现在将这些地毯按照编号从小到大的顺序平行于坐标轴先后铺设，后铺的地毯覆盖在前面已经铺好的地毯之上。

地毯铺设完成后，组织者想知道覆盖地面某个点的最上面的那张地毯的编号。注意：在矩形地毯边界和四个顶点上的点也算被地毯覆盖。

**输入格式**

输入共 $n + 2$ 行。

第一行，一个整数 $n$，表示总共有 $n$ 张地毯。

接下来的 $n$ 行中，第 $i+1$ 行表示编号 $i$ 的地毯的信息，包含四个整数 $a ,b ,g ,k$，每两个整数之间用一个空格隔开，分别表示铺设地毯的左下角的坐标 $(a, b)$ 以及地毯在 $x$ 轴和 $y$ 轴方向的长度。

第 $n + 2$ 行包含两个整数 $x$ 和 $y$，表示所求的地面的点的坐标 $(x, y)$。

**输出格式**

输出共 $1$ 行，一个整数，表示所求的地毯的编号；若此处没有被地毯覆盖则输出 `-1`。

**输入输出样例 #1**

*输入 #1*

```
3
1 0 2 3
0 2 3 3
2 1 3 3
2 2

```

*输出 #1*

```
3

```

**输入输出样例 #2**

*输入 #2*

```
3
1 0 2 3
0 2 3 3
2 1 3 3
4 5
```

*输出 #2*

```
-1
```

**说明/提示**

**【样例解释 1】**

如下图，$1$ 号地毯用实线表示，$2$ 号地毯用虚线表示，$3$ 号用双实线表示，覆盖点 $(2,2)$ 的最上面一张地毯是 $3$ 号地毯。

![](https://cdn.luogu.com.cn/upload/image_hosting/q4izfzpb.png)

**【数据范围】**

对于 $30\%$ 的数据，有 $n \le 2$。  
对于 $50\%$ 的数据，$0 \le a, b, g, k \le 100$。  
对于 $100\%$ 的数据，有 $0 \le n \le 10^4$, $0 \le a, b, g, k \le {10}^5$。   

noip2011 提高组 day1 第 $1$ 题。

```c
// #define _CRT_SECURE_NO_WARNINGS
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <math.h>
#define MAXN 100005
#define MAXNL 20005
#define MM 35
#define INF 0x3f3f3f3f
#define MMM 105
#define MINL -1

typedef int ElemType;
typedef long long ll;

ElemType cmp(const void *a, const void *b)
{
    return (*(ElemType *)a - *(ElemType *)b);
}

ElemType max(ElemType a, ElemType b)
{
    return a > b ? a : b;
}

ElemType min(ElemType a, ElemType b)
{
    return a < b ? a : b;
}

typedef struct
{
    ElemType a, b, x_length, y_length;
} P;

ElemType n;
P p[MAXNL];

int main()
{
    scanf("%d", &n);
    for (int i = 1; i <= n; i++)
    {
        scanf("%d %d %d %d", &p[i].a, &p[i].b, &p[i].x_length, &p[i].y_length);
    }
    ElemType X, Y, result = -1;
    scanf("%d %d", &X, &Y);
    for (int i = n; i >= 1; i--)
    {
        ElemType x_left = p[i].a;
        ElemType y_down = p[i].b;
        ElemType x_right = p[i].a + p[i].x_length;
        ElemType y_up = p[i].b + p[i].y_length;
        if (X >= x_left && X <= x_right && Y >= y_down && Y <= y_up)
        {
            result = i;
            break;
        }
    }
    printf("%d", result);
    return 0;
}
```

### 21. P1007 独木桥

**题目背景**

战争已经进入到紧要时间。你是运输小队长，正在率领运输部队向前线运送物资。运输任务像做题一样的无聊。你希望找些刺激，于是命令你的士兵们到前方的一座独木桥上欣赏风景，而你留在桥下欣赏士兵们。士兵们十分愤怒，因为这座独木桥十分狭窄，只能容纳 $1$ 个人通过。假如有 $2$ 个人相向而行在桥上相遇，那么他们 $2$ 个人将无法绕过对方，只能有 $1$ 个人回头下桥，让另一个人先通过。但是，可以有多个人同时呆在同一个位置。

**题目描述**

突然，你收到从指挥部发来的信息，敌军的轰炸机正朝着你所在的独木桥飞来！为了安全，你的部队必须撤下独木桥。独木桥的长度为 $L$，士兵们只能呆在坐标为整数的地方。所有士兵的速度都为 $1$，但一个士兵某一时刻来到了坐标为 $0$ 或 $L+1$ 的位置，他就离开了独木桥。

每个士兵都有一个初始面对的方向，他们会以匀速朝着这个方向行走，中途不会自己改变方向。但是，如果两个士兵面对面相遇，他们无法彼此通过对方，于是就分别转身，继续行走。转身不需要任何的时间。

由于先前的愤怒，你已不能控制你的士兵。甚至，你连每个士兵初始面对的方向都不知道。因此，你想要知道你的部队最少需要多少时间就可能全部撤离独木桥。另外，总部也在安排阻拦敌人的进攻，因此你还需要知道你的部队最多需要多少时间才能全部撤离独木桥。

**输入格式**

第一行共一个整数 $L$，表示独木桥的长度。桥上的坐标为 $1, 2, \cdots, L$。

第二行共一个整数 $N$，表示初始时留在桥上的士兵数目。

第三行共有 $N$ 个整数，分别表示每个士兵的初始坐标。

**输出格式**

共一行，输出 $2$ 个整数，分别表示部队撤离独木桥的最小时间和最大时间。$2$ 个整数由一个空格符分开。

**输入输出样例 #1**

*输入 #1*

```
4
2
1 3

```

*输出 #1*

```
2 4
```

**说明/提示**

对于 $100\%$ 的数据，满足初始时，没有两个士兵同在一个坐标，$1\le  L\le5\times 10^3$，$0\le N\le5\times10^3$，且数据保证 $N\le L$。

```c
// #define _CRT_SECURE_NO_WARNINGS
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <math.h>
#define MAXN 100005
#define MAXNL 20005
#define MM 35
#define INF 0x3f3f3f3f
#define MMM 105
#define MINL -1

typedef int ElemType;
typedef long long ll;

ElemType cmp(const void *a, const void *b)
{
    return (*(ElemType *)a - *(ElemType *)b);
}

ElemType max(ElemType a, ElemType b)
{
    return a > b ? a : b;
}

ElemType min(ElemType a, ElemType b)
{
    return a < b ? a : b;
}

ElemType L, N;
ElemType sol[MAXNL];
ElemType maxn, minn;
ElemType sol_max[MAXNL];
ElemType sol_min[MAXNL];

int main()
{
    scanf("%d %d", &L, &N);
    for (int i = 1; i <= N; i++)
    {
        scanf("%d", &sol[i]);
    }
    for (int i = 1; i <= N; i++)
    {
        sol_max[i] += max(sol[i], L + 1 - sol[i]);
        sol_min[i] += min(sol[i], L + 1 - sol[i]);
    }
    for (int i = 1; i <= N; i++)
    {
        if (maxn < sol_max[i])
        {
            maxn = sol_max[i];
        }
        if (minn < sol_min[i])
        {
            minn = sol_min[i];
        }
    }
    printf("%d %d\n", minn, maxn);
    return 0;
}
```

### 22. P1008 [NOIP 1998 普及组] 三连击

**题目背景**

本题为提交答案题，您可以写程序或手算在本机上算出答案后，直接提交答案文本，也可提交答案生成程序。

**题目描述**

将 $1, 2, \ldots , 9$ 共 $9$ 个数分成 $3$ 组，分别组成 $3$ 个三位数，且使这 $3$ 个三位数构成 $1 : 2 : 3$ 的比例，试求出所有满足条件的 $3$ 个三位数。

**输入格式**

无

**输出格式**

若干行，每行 $3$ 个数字。按照每行第 $1$ 个数字升序排列。

**输入输出样例 #1**

*输入 #1*

```
无
```

*输出 #1*

```
192 384 576
* * *
...

* * *
（剩余部分不予展示）
```

**说明/提示**

NOIP1998 普及组 第一题

```c
// #define _CRT_SECURE_NO_WARNINGS
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <math.h>
#define MAXN 100005
#define MAXNL 20005
#define MM 35
#define INF 0x3f3f3f3f
#define MMM 105
#define MINL -1

typedef int ElemType;
typedef long long ll;

ElemType cmp(const void *a, const void *b)
{
    return (*(ElemType *)a - *(ElemType *)b);
}

ElemType max(ElemType a, ElemType b)
{
    return a > b ? a : b;
}

ElemType min(ElemType a, ElemType b)
{
    return a < b ? a : b;
}

int main()
{
    for (int i = 123; i <= 329; i++)
    {
        int a = i, b = 2 * i, c = 3 * i;
        int cnt[10] = {0};
        cnt[a / 100]++;
        cnt[a / 10 % 10]++;
        cnt[a % 10]++;
        cnt[b / 100]++;
        cnt[b / 10 % 10]++;
        cnt[b % 10]++;
        cnt[c / 100]++;
        cnt[c / 10 % 10]++;
        cnt[c % 10]++;
        int flag = 1;
        for (int j = 1; j <= 9; j++)
        {
            if (cnt[j] != 1)
            {
                flag = 0;
                break;
            }
        }
        if (flag)
        {
            printf("%d %d %d\n", a, b, c);
        }
    }
    return 0;
}
```

### 23. # P1009 [NOIP 1998 普及组] 阶乘之和

**题目描述**

用高精度计算出 $S = 1! + 2! + 3! + \cdots + n!$（$n \le 50$）。

其中 `!` 表示阶乘，定义为 $n!=n\times (n-1)\times (n-2)\times \cdots \times 1$。例如，$5! = 5 \times 4 \times 3 \times 2 \times 1=120$。

**输入格式**

一个正整数 $n$。

**输出格式**

一个正整数 $S$，表示计算结果。

**输入输出样例 #1**

*输入 #1*

```
3

```

*输出 #1*

```
9
```

**说明/提示**

**【数据范围】**

对于 $100 \%$ 的数据，$1 \le n \le 50$。

**【其他说明】**

注，《深入浅出基础篇》中使用本题作为例题，但是其数据范围只有 $n \le 20$，使用书中的代码无法通过本题。

如果希望通过本题，请继续学习第八章高精度的知识。

NOIP1998 普及组 第二题

```c
// #define _CRT_SECURE_NO_WARNINGS
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <math.h>
#define MAXN 100005
#define MAXNL 20005
#define MM 35
#define INF 0x3f3f3f3f
#define MMM 105
#define MINL -1

typedef int ElemType;
typedef long long ll;

ElemType cmp(const void *a, const void *b)
{
    return (*(ElemType *)a - *(ElemType *)b);
}

ElemType max(ElemType a, ElemType b)
{
    return a > b ? a : b;
}

ElemType min(ElemType a, ElemType b)
{
    return a < b ? a : b;
}

struct num {
    int a[100];  
    int len;
};

typedef struct num Num;

Num timing(Num a, Num b) {
    Num res;
    memset(&res, 0, sizeof(Num));
    res.len = a.len + b.len;

    for (int i = 0; i < a.len; i++) {
        for (int j = 0; j < b.len; j++) {
            res.a[i + j] += a.a[i] * b.a[j];
            res.a[i + j + 1] += res.a[i + j] / 10;
            res.a[i + j] %= 10;
        }
    }

    while (res.len > 1 && res.a[res.len - 1] == 0) {
        res.len--;
    }
    return res;
}

Num adding(Num a, Num b) {
    Num res;
    memset(&res, 0, sizeof(Num));
    res.len = max(a.len, b.len);
    
    for (int i = 0; i < res.len; i++) {
        res.a[i] += a.a[i] + b.a[i];
        res.a[i + 1] += res.a[i] / 10;
        res.a[i] %= 10;
    }
    
    // 处理最高位进位
    if (res.a[res.len] > 0) {
        res.len++;
    }
    return res;
}

Num toNum(int x) {
    Num res;
    memset(&res, 0, sizeof(Num));
    if (x == 0) {
        res.a[0] = 0;
        res.len = 1;
        return res;
    }
    while (x > 0) {
        res.a[res.len++] = x % 10;
        x /= 10;
    }
    return res;
}

int main()
{
    int number;
    if (scanf("%d", &number) != 1) return 0;
    
    Num sum = toNum(0);
    Num fact = toNum(1); 
    
    for (int i = 1; i <= number; i++) {
        Num current = toNum(i);
        fact = timing(fact, current); 
        sum = adding(sum, fact);      
    }
    
    for (int i = sum.len - 1; i >= 0; i--) {
        printf("%d", sum.a[i]);
    }
    printf("\n");
    
    return 0;
}
```

### 24. P1002 [NOIP 2002 普及组] 过河卒

**题目描述**

棋盘上 $A$ 点有一个过河卒，需要走到目标 $B$ 点。卒行走的规则：可以向下、或者向右。同时在棋盘上 $C$ 点有一个对方的马，该马所在的点和所有跳跃一步可达的点称为对方马的控制点。因此称之为“马拦过河卒”。

棋盘用坐标表示，$A$ 点 $(0, 0)$、$B$ 点 $(n, m)$，同样马的位置坐标是需要给出的。

![](https://cdn.luogu.com.cn/upload/image_hosting/ipmwl52i.png)

现在要求你计算出卒从 $A$ 点（不经过马的控制点）能够到达 $B$ 点的路径的条数，假设马的位置是固定不动的，并不是卒走一步马走一步。

**输入格式**

一行四个正整数，分别表示 $B$ 点坐标和马的坐标。

**输出格式**

一个整数，表示所有的路径条数。

**输入输出样例 #1**

*输入 #1*

```
6 6 3 3

```

*输出 #1*

```
6

```

**说明/提示**

对于 $100 \%$ 的数据，$1 \le n, m \le 20$，$0 \le$ 马的坐标 $\le 20$。

保证起点不是马的控制点。

**【题目来源】**

NOIP 2002 普及组第四题

```c
// #define _CRT_SECURE_NO_WARNINGS
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <math.h>
#define MAXN 100005
#define MAXNL 20005
#define MM 35
#define INF 0x3f3f3f3f
#define MMM 105
#define MINL -1

typedef int ElemType;
typedef long long ll;

ElemType cmp(const void *a, const void *b)
{
    return (*(ElemType *)a - *(ElemType *)b);
}

ElemType max(ElemType a, ElemType b)
{
    return a > b ? a : b;
}

ElemType min(ElemType a, ElemType b)
{
    return a < b ? a : b;
}

ElemType x_b, y_b, x_horse, y_horse;
ll dp[MM][MM];
ElemType block[MM][MM];
ElemType dx[] = {0, 2, 1, -1, -2, -2, -1, 1, 2};
ElemType dy[] = {0, 1, 2, 2, 1, -1, -2, -2, -1};

int main()
{
    scanf("%d %d %d %d", &x_b, &y_b, &x_horse, &y_horse);
    for (int i = 0; i < 9; i++)
    {
        ElemType x = x_horse + dx[i];
        ElemType y = y_horse + dy[i];
        if (x >= 0 && x <= x_b && y >= 0 && y <= y_b)
        {
            block[x][y] = 1;
        }
    }
    if (block[0][0] == 0)
    {
        dp[0][0] = 1;
    }
    for (int i = 0; i <= x_b; i++)
    {
        for (int j = 0; j <= y_b; j++)
        {
            if (i == 0 && j == 0)
            {
                continue;
            }
            if (block[i][j] != 0)
            {
                continue;
            }
            if (i > 0)
            {
                dp[i][j] += dp[i - 1][j];
            }
            if (j > 0)
            {
                dp[i][j] += dp[i][j - 1];
            }
        }
    }
    printf("%lld", dp[x_b][y_b]);
    return 0;
}
```

## Chapter 3：LeetCode

### 1. Two Sum

**Difficulty:** Easy

**Description**

You are given an array of integers `nums` and an integer `target`, return indices of the two numbers such that they add up to `target`.

You may assume that each input would have exactly one solution, and you may not use the same element twice.

You can return the answer in any order.

**Example 1**

**Input:**

```text
nums = [2,7,11,15], target = 9
```

**Output:**

```text
[0,1]
```

**Explanation:**

Because `nums[0] + nums[1] == 9`, we return `[0, 1]`.

**Example 2**

**Input:**

```text
nums = [3,2,4], target = 6
```

**Output:**

```text
[1,2]
```

**Example 3**

**Input:**

```text
nums = [3,3], target = 6
```

**Output:**

```text
[0,1]
```

**Constraints**

* `2 <= nums.length <= 10^4`
* `-10^9 <= nums[i] <= 10^9`
* `-10^9 <= target <= 10^9`
* Only one valid answer exists.

**Follow-up**

Can you come up with an algorithm that is less than `O(n^2)` time complexity?

**C++ Function**

```cpp
class Solution {
public:
    vector<int> twoSum(vector<int>& nums, int target) {
        
    }
};
```

**Solution**

```cpp
```

**Notes**

第二层循环不应该出现 `j = i` 这样的而应该是 `j = i + 1`，因为前者可能会导致一个数字重复使用。

**Complexity**

* **Time Complexity: $O(n^2)$**
* **Space Complexity:**

```c
/**
 * Note: The returned array must be malloced, assume caller calls free().
 */
#include <stdlib.h>

int* twoSum(int* nums, int numsSize, int target, int* returnSize) {
    int* ans = (int*)malloc(2 * sizeof(int));
    for (int i = 0; i < numsSize; i++) {
        for (int j = i + 1; j < numsSize; j++) {
            if (nums[i] + nums[j] == target) {
                ans[0] = i;
                ans[1] = j;
                *returnSize = 2;
                return ans;
            }
        }
    }
    return NULL;
}
```

**哈希表做法**

时间复杂度仅为 $O(n)$

```c
/**
 * Note: The returned array must be malloced, assume caller calls free().
 */
#include <stdlib.h>

int hash(int x)
{
    int h = x % 20011;
    if (h < 0)
    {
        h += 20011;
    }
    return h;
}

int *twoSum(int *nums, int numsSize, int target, int *returnSize)
{
    int keys[20011];
    int index[20011];
    int used[20011] = {0};

    for (int i = 0; i < numsSize; i++)
    {
        int need = target - nums[i];
        int pos = hash(need);
        while (used[pos])
        {
            if (keys[pos] == need)
            {
                int *ans = (int *)malloc(2 * sizeof(int));
                ans[0] = index[pos];
                ans[1] = i;
                *returnSize = 2;
                return ans;
            }
            pos = (pos + 1) % 20011;
        }
        pos = hash(nums[i]);
        while (used[pos])
        {
            pos = (pos + 1) % 20011;
        }
        used[pos] = 1;
        keys[pos] = nums[i];
        index[pos] = i;
    }
    *returnSize = 0;
    return NULL;
}
```

### 2. Add Two Numbers

**Difficulty:** Medium

**Description**

You are given two **non-empty** linked lists representing two non-negative integers. The digits are stored in **reverse order**, and each of their nodes contains a single digit. Add the two numbers and return the sum as a linked list.

You may assume the two numbers do not contain any leading zero, except the number 0 itself.

**Example 1**

![Example 1](https://assets.leetcode.com/uploads/2020/10/02/addtwonumber1.jpg)

**Input:**

```text
l1 = [2,4,3], l2 = [5,6,4]
```

**Output:**

```text
[7,0,8]
```

**Explanation:**

```text
342 + 465 = 807
```

**Example 2**

**Input:**

```text
l1 = [0], l2 = [0]
```

**Output:**

```text
[0]
```

**Example 3**

**Input:**

```text
l1 = [9,9,9,9,9,9,9], l2 = [9,9,9,9]
```

**Output:**

```text
[8,9,9,9,0,0,0,1]
```

**Constraints**

* The number of nodes in each linked list is in the range `[1, 100]`.
* `0 <= Node.val <= 9`
* It is guaranteed that the list represents a number that does not have leading zeros.

```c
/**
 * Definition for singly-linked list.
 * struct ListNode {
 *     int val;
 *     struct ListNode *next;
 * };
 */

#include <stdlib.h>

typedef struct ListNode Node;

int bigger(int a, int b)
{
    if (a < b)
    {
        return b;
    }
    return a;
}

struct ListNode *addTwoNumbers(struct ListNode *l1,
                               struct ListNode *l2)
{
    int nodes1 = 0;
    int nodes2 = 0;

    Node *first1 = l1;
    Node *first2 = l2;

    int *a = malloc(10000 * sizeof(int));
    int *b = malloc(10000 * sizeof(int));

    for (int i = 0; i < 10000; i++)
    {
        a[i] = 0;
        b[i] = 0;
    }

    while (first1 != NULL)
    {
        a[nodes1] = first1->val;
        first1 = first1->next;
        nodes1++;
    }

    while (first2 != NULL)
    {
        b[nodes2] = first2->val;
        first2 = first2->next;
        nodes2++;
    }

    int big = bigger(nodes1, nodes2);

    int num1 = 0;
    int num2 = 0;

    for (int i = big - 1; i >= 0; i--)
    {
        num1 = num1 * 10 + a[i];
        num2 = num2 * 10 + b[i];
    }

    int num = num1 + num2;

    Node *head = NULL;
    Node *tail = NULL;

    if (num == 0)
    {
        head = malloc(sizeof(Node));
        head->val = 0;
        head->next = NULL;
    }
    else
    {
        while (num > 0)
        {
            Node *newNode = malloc(sizeof(Node));
            newNode->val = num % 10;
            newNode->next = NULL;

            if (head == NULL)
            {
                head = newNode;
                tail = newNode;
            }
            else
            {
                tail->next = newNode;
                tail = newNode;
            }

            num /= 10;
        }
    }

    free(a);
    free(b);

    return head;
}
```

以上方法能满足三个测试用例但无法 AC，因为范围远超 `int` 和 `long long`，故提供以下做法：

```c
#include <stdlib.h>

typedef struct ListNode Node;

typedef long long ll;

ll bigger(ll a, ll b)
{
    if (a < b)
    {
        return b;
    }
    return a;
}

struct ListNode *addTwoNumbers(struct ListNode *l1, struct ListNode *l2)
{
    Node *head = NULL;
    Node *tail = NULL;
    int carry = 0;
    Node *first1 = l1;
    Node *first2 = l2;
    while (first1 != NULL || first2 != NULL || carry != 0)
    {
        int num1 = 0;
        int num2 = 0;
        if (first1 != NULL)
        {
            num1 = first1->val;
            first1 = first1->next;
        }
        if (first2 != NULL)
        {
            num2 = first2->val;
            first2 = first2->next;
        }
        int sum = num1 + num2 + carry;
        int digit = sum % 10;
        carry = sum / 10;
        Node *newNode = (Node *)malloc(sizeof(Node));
        newNode->val = digit;
        newNode->next = NULL;
        if (head == NULL)
        {
            head = newNode;
            tail = newNode;
        }
        else
        {
            tail->next = newNode;
            tail = newNode;
        }
    }
    return head;
}
```

### 3. Longest Substring Without Repeating Characters

**Difficulty:** Medium

**Description**

Given a string `s`, find the length of the **longest substring** without duplicate characters.

**Example 1**

**Input:**

```text id="3s5hjt"
s = "abcabcbb"
```

**Output:**

```text id="a5e9x4"
3
```

**Explanation:**

The answer is `"abc"`, with the length of `3`. Note that `"bca"` and `"cab"` are also correct answers.

**Example 2**

**Input:**

```text id="0lj9ze"
s = "bbbbb"
```

**Output:**

```text id="d0gt8w"
1
```

**Explanation:**

The answer is `"b"`, with the length of `1`.

**Example 3**

**Input:**

```text id="qs7jqd"
s = "pwwkew"
```

**Output:**

```text id="oa6eno"
3
```

**Explanation:**

The answer is `"wke"`, with the length of `3`.

Notice that the answer must be a substring, `"pwke"` is a subsequence and not a substring.

**Constraints**

* `0 <= s.length <= 10^5`
* `s` consists of English letters, digits, symbols and spaces.

```c
#include <string.h>

int lengthOfLongestSubstring(char *s)
{
    int count[10000] = {0};
    int len = strlen(s);
    int left = 0;
    int max = 0;
    for (int i = 0; i < len; i++)
    {
        count[s[i]]++;
        // max++;
        while (count[s[i]] >= 2)
        {
            count[s[left]]--;
            left++;
        }
        int now = i - left + 1;
        if (now > max)
        {
            max = now;
        }
    }
    return max;
}
```

### 4. Median of Two Sorted Arrays

**Difficulty:** Hard

**Description**

Given two sorted arrays `nums1` and `nums2` of size `m` and `n` respectively, return **the median** of the two sorted arrays.

The overall run time complexity should be `O(log (m+n))`.

**Example 1**

**Input:**

```text id="a1k4wz"
nums1 = [1,3], nums2 = [2]
```

**Output:**

```text id="9oq3gf"
2.00000
```

**Explanation:**

Merged array = `[1,2,3]` and median is `2`.

**Example 2**

**Input:**

```text id="r7b2kp"
nums1 = [1,2], nums2 = [3,4]
```

**Output:**

```text id="m6v8qc"
2.50000
```

**Explanation:**

Merged array = `[1,2,3,4]` and median is `(2 + 3) / 2 = 2.5`.

**Constraints**

* `nums1.length == m`
* `nums2.length == n`
* `0 <= m <= 1000`
* `0 <= n <= 1000`
* `1 <= m + n <= 2000`
* `-10^6 <= nums1[i], nums2[i] <= 10^6`

```c
double findMedianSortedArrays(int *nums1, int nums1Size, int *nums2, int nums2Size)
{
    int whole_num = nums1Size + nums2Size;

    if (nums1Size > nums2Size)
    {
        return findMedianSortedArrays(nums2, nums2Size, nums1, nums1Size);
    }
    int m = nums1Size;
    int n = nums2Size;
    int left = 0;
    int right = nums1Size;
    while (left <= right)
    {
        int i = (left + right) / 2;
        int j = (m + n + 1) / 2 - i;
        int left1, left2, right1, right2;
        if (i == 0)
        {
            left1 = -100000;
        }
        else
        {
            left1 = nums1[i - 1];
        }
        if (i == m)
        {
            right1 = 100000;
        }
        else
        {
            right1 = nums1[i];
        }
        if (j == 0)
        {
            left2 = -100000;
        }
        else
        {
            left2 = nums2[j - 1];
        }
        if (j == n)
        {
            right2 = 100000;
        }
        else
        {
            right2 = nums2[j];
        }
        if (left1 <= right2 && left2 <= right1)
        {
            if ((m + n) % 2 == 1)
            {
                return left1 > left2 ? left1 : left2;
            }
            else
            {
                int leftMax = left1 > left2 ? left1 : left2;
                int rightMin = right1 < right2 ? right1 : right2;

                return (leftMax + rightMin) / 2.0;
            }
        }
        else if (left1 > right2)
        {
            right = i - 1;
        }

        else
        {
            left = i + 1;
        }
    }

    return 0;
}
```

以上写法能够同时通过三个测试用例但无法 AC，其实只是因为正负无穷不够大罢了，改成以下做法：

```c
#include <limits.h>

double findMedianSortedArrays(int *nums1, int nums1Size, int *nums2, int nums2Size)
{
    int whole_num = nums1Size + nums2Size;

    if (nums1Size > nums2Size)
    {
        return findMedianSortedArrays(nums2, nums2Size, nums1, nums1Size);
    }
    int m = nums1Size;
    int n = nums2Size;
    int left = 0;
    int right = nums1Size;
    while (left <= right)
    {
        int i = (left + right) / 2;
        int j = (m + n + 1) / 2 - i;
        int left1, left2, right1, right2;
        if (i == 0)
        {
            left1 = INT_MIN;
        }
        else
        {
            left1 = nums1[i - 1];
        }
        if (i == m)
        {
            right1 = INT_MAX;
        }
        else
        {
            right1 = nums1[i];
        }
        if (j == 0)
        {
            left2 = INT_MIN;
        }
        else
        {
            left2 = nums2[j - 1];
        }
        if (j == n)
        {
            right2 = INT_MAX;
        }
        else
        {
            right2 = nums2[j];
        }
        if (left1 <= right2 && left2 <= right1)
        {
            if ((m + n) % 2 == 1)
            {
                return left1 > left2 ? left1 : left2;
            }
            else
            {
                int leftMax = left1 > left2 ? left1 : left2;
                int rightMin = right1 < right2 ? right1 : right2;

                return (leftMax + rightMin) / 2.0;
            }
        }
        else if (left1 > right2)
        {
            right = i - 1;
        }

        else
        {
            left = i + 1;
        }
    }

    return 0;
}
```
