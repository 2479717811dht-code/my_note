# <span class="note-center">高级数据结构与算法分析</span>

<div class="note-center">浙江大学 竺可桢学院 混合2504班 邓欢桐 3250102223</div>

---

<div class="note-center">
<img src="/20260323101520_871_96.png" style="zoom: 60%;" />
<img src="/20260323101521_872_96.png" style="zoom: 20%;" />
<img src="/6a3f74ac4e6d4eiq3mp2la2263.png" style="zoom: 25%;" />
</div>

---

[TOC]

<div style="display: block !important; text-align: center !important; margin: 60px auto 20px !important; padding: 20px 0 !important; width: 85% !important; border-top: 1px dashed #b1c2ca !important; border-bottom: 1px dashed #b1c2ca !important; font-family: '钟齐志莽行书', cursive !important; font-size: 20px !important; line-height: 1.8 !important; letter-spacing: 2px !important; font-weight: normal !important; font-style: italic !important; color: #2d4856 !important;">" 我终于, 自由了!"<span style="display: block !important; text-align: right !important; margin-top: 10px !important; font-size: 18px !important;">-- 2026.7.4 玉湖七幢</span></div>

## Chapter 1: Trees

### 1.1 AVL Trees

#### 1.1.1 为什么需要 AVL Trees

> **目标**
>
> 普通 BST 的查找时间虽然是 $O(h)$, 但无法保证 $h$ 小到一个类似 $\log N$ 的值.
>
> 我们需要快速查找, 包括插入和删除, 即在这三个过程中始终让树保持足够平衡, 从而保证树高为 $O(\log N)$ 量级.

显然, 其需要一个 Binary Search Trees (BST)

> **问题**
>
> 当退化成一个链表的时候, 时间复杂度直接变成 $O(N)$.

换句话说, BST 很好, 但是在极端情况下, 它又不是那么好, 这就需要一个新的工具 / 算法了.

<details style="--wi-box-color:var(--wi-question);--wi-box-bg:var(--wi-question-bg)"><summary>那么到底需要用什么算法?</summary><p>cyll: 你看现在我们在讲 AVL Trees. </p></details>

#### 1.1.2 AVL Trees 的基本定义和思想

AVL Trees 的思想是典型的工程师思维:

1. 先当它"坏的";
2. "坏了"再修好就是了.

我们希望的是 $O(\log N)$ 情况, 超过此情况的包括但不限于 $O(N)$ 这样的复杂度, 我们都认为它是"坏的".

> [!IMPORTANT]
>
> 我们首先记一棵二叉树为 $T$:
>
> 1. 显然, 一个空的二叉树是高度平衡 (Height Balanced) 的;
> 2. 对于一个非空的二叉树, 记其左子树和右子树分别为 $T_L$ 和 $T_R$, 高度分别记为 $h_L$ 和 $h_R$, $T$ 是平衡的当且仅当:
>    - $T_L$ 和 $T_R$ 均为高度平衡的, 即 $T$ 的左子树和右子树均为 AVL 树;
>    - $|h_R-h_L| \leq 1$.

#### 1.1.3 树高和平衡因子

首先, 我们引入一个概念: 平衡因子--Balance Factor (BF(node)), 记 BF(node) $= h_L-h_R$, 在满足 AVL 性质时, BF(node) 只能为 $-1$, $0$, $1$;插入或删除后的修复过程中可能暂时出现 $\pm2$.

> [!CAUTION]
>
> 定义是左高减右高, 因此 BF 为正数表示左重, 为负数表示右重.

那么这里涉及到一个问题:

<details style="--wi-box-color:var(--wi-question);--wi-box-bg:var(--wi-question-bg)"><summary>BF 是从上往下更新还是从下往上更新?</summary><p>答案: 从下往上</p><p>这里其实是一个递归的过程, 从最底下插入, 递归到节点的 parent, 一层层往上计数. </p></details>

其次, 我们再来澄清一下树高这个概念

> **Height**
>
> 节点的高度是从该节点到其后代叶节点的最长路径的边数;树高就是根节点的高度.
>
> 本节统一约定: 空树高度为 $-1$, 叶节点高度为 $0$, 向上一层再 $+1$.
>
> 从根向下数的是深度, 根的深度为 $0$. 高度与深度不要混用.

```c
// code:
int getHeight(AVLNode *root)
{
    if (root == NULL)
    {
        return -1;
    }
    return root->height;
}
```

> [!NOTE]
>
> 值得注意的是, cyll 的 PPT 里面每个节点顶上的数字有些是负数, 那指的其实并不是节点的高度, 而是该节点的 BF.

另外, 我们记 $n_h$ 为高为 $h$ 的高度平衡树的最小节点数, 那么会有公式:

$$
n_h=n_{h-1}+n_{h-2}+1
$$

我们由此极容易联想到斐波那契数列.

> [!CAUTION]
>
> 这不是真正传统意义上的斐波那契数列, 需要进行甄别.

#### 1.1.4 AVL Trees 的基本插入过程

1. 首先, 按照普通的 BST 插入;

2. 沿着插入路径向上:
   - 更新每个节点的高度;

   - 计算 BF;

   - 找到第一个失衡的祖先节点, 即 $|BF|=2$ 的点($BF=2$ 或 $BF=-2$);

   - 对该结构进行局部的旋转.

     > 一般该节点称为 trouble finder

#### 1.1.5 失衡情况

> [!IMPORTANT]
>
> 引理: Trouble Maker 和 Trouble Finder
>
> Trouble Maker: 导致树产生失衡的新插入节点;
>
> Trouble Finder: 从 trouble maker 向上找,遇到的最近的失衡节点.

失衡主要分为以下几种:

1. LL 型失衡, 例如:

   ```c
         30
        /
       20
      /
     10
   ```

   失衡路径为: 30 → 左边 20 → 左边 10

2. RR 型失衡, 例如:

   ```c
   10
     \
      20
        \
         30
   ```

   失衡路径为: 10 → 右边 20 → 右边 30

3. LR 型失衡, 例如:

   ```c
         30
        /
       10
         \
          20
   ```

   失衡路径为: 30 → 左边 10 → 右边 20

4. RL 型失衡

   ```c
   10
     \
      30
      /
     20
   ```

   失衡路径为: 10 → 右边 30 → 左边 20

> [!TIP]
>
> 其实可以不必死记硬背, 以下是大概的样子:
>
> 1. LL 型: 长成单链 `/` 型;
> 2. RR 型: 长成单链 `\` 型;
> 3. LR 型: 顾名思义先左后右, 长成 `《` 型;
> 4. RL 型, 显而易见先右后左, 长成 `》` 型.
>
> 下面开始讲这些失衡的修正.

#### 1.1.6 旋转修正

先定义结构体:

```c
typedef struct AVLNode
{
    int key;
    struct AVLNode *left;
    struct AVLNode *right;
    int height;
} AVLNode;
```

> [!WARNING]
>
> LL / RR / LR / RL 描述的是失衡路径, 左旋 / 右旋描述的是修复动作. 本文统一采用: LL 用右旋, RR 用左旋, LR 先左后右, RL 先右后左. 不要把 LL 失衡和"向左旋转"混为一谈.

可分为 LL 旋,LR 旋,RL 旋,RR 旋, 只需知道其如何旋转即可, 名称其实并不太重要.

下面是四种失衡的修正方法:

1. 对于 **LL** 型失衡, 我们只需将 `/` 的状态掰成 `^` 即可, 也就是说, 对该链的根节点做一个**右**旋, 中间节点为顶点;

   ```c
        【旋转前】                【右旋后】
            30 (A)                    20
           /                         /  \
          20 (B)       --->         10   30
         /
        10

   // code:
   AVLNode *rotateRight(AVLNode *A)
   {
       AVLNode *B = A->left;
       A->left = B->right; // 保住 B 的右子树
       B->right = A;
       A->height = max(getHeight(A->left), getHeight(A->right)) + 1;
       B->height = max(getHeight(B->left), getHeight(B->right)) + 1;
       return B;
   }
   ```

2. 对于 **RR** 型失衡, 我们只需将 `\` 的状态掰成 `^` 即可, 也就是说, 对该链的根节点做一个**左**旋, 中间节点为顶点;

   ```c
      【旋转前】                  【左旋后】
          10                          20
            \                        /  \
             20        --->         10   30
               \
                30
   // code:
   AVLNode *rotateLeft(AVLNode *A)
   {
       AVLNode *B = A->right;
       A->right = B->left;
       B->left = A;
       A->height = max(getHeight(A->left), getHeight(A->right)) + 1;
       B->height = max(getHeight(B->left), getHeight(B->right)) + 1;
       return B;
   }
   ```

3. 对于 **LR** 型失衡, 我们将最低节点变成根节点, 中间节点作为左孩子, 原来的根节点作为右孩子即可, 化成一个 `^` 的形状;

   ```c
        【旋转前】               【局部左旋后】             【右旋后】
            30                         30                       20
           /                          /                        /  \
          10           --->          20          --->         10   30
            \                       /
             20                    10
   // code:
   AVLNode *rotateLeftRight(AVLNode *A)
   {
       A->left = rotateLeft(A->left);
       return rotateRight(A);
   }
   ```

4. 对于 **RL** 型失衡, 我们将最低节点变为根节点, 中间节点作为右孩子, 原来的根节点作为左孩子即可, 化成一个 `^` 的形状.

   ```c
        （旋转前）               （局部右旋后）             （最终结果）
            10                         10                       20
              \                         \                     /  \
               30          --->          20          --->     10   30
              /                            \
             20                             30
   // code:
   AVLNode *rotateRightLeft(AVLNode *A)
   {
       A->right = rotateRight(A->right);
       return rotateLeft(A);
   }
   ```

这里给到 AVL Trees 的结构体定义以及四种旋转修正的核心代码:

```c
// From Gemini

#include <stdio.h>
#include <stdlib.h>

// AVL树节点结构
typedef struct AVLNode
{
    int key;
    struct AVLNode *left;
    struct AVLNode *right;
    int height;
} AVLNode;

// 获取节点高度
int getHeight(AVLNode *node)
{
    if (node == NULL)
        return -1;
    return node->height;
}

// 获取两个数中的较大值
int max(int a, int b)
{
    return (a > b) ? a : b;
}

// ---------------------------------------------------
// 1. 右旋 (对应 LL 型失衡)
// ---------------------------------------------------
AVLNode *rotateRight(AVLNode *y)
{
    AVLNode *x = y->left;
    AVLNode *T2 = x->right;

    // 执行旋转
    x->right = y;
    y->left = T2;

    // 更新高度（必须先更新 y, 再更新 x）
    y->height = max(getHeight(y->left), getHeight(y->right)) + 1;
    x->height = max(getHeight(x->left), getHeight(x->right)) + 1;

    // 返回新的根节点
    return x;
}

// ---------------------------------------------------
// 2. 左旋 (对应 RR 型失衡)
// ---------------------------------------------------
AVLNode *rotateLeft(AVLNode *x)
{
    AVLNode *y = x->right;
    AVLNode *T2 = y->left;

    // 执行旋转
    y->left = x;
    x->right = T2;

    // 更新高度（必须先更新 x, 再更新 y）
    x->height = max(getHeight(x->left), getHeight(x->right)) + 1;
    y->height = max(getHeight(y->left), getHeight(y->right)) + 1;

    // 返回新的根节点
    return y;
}

// ---------------------------------------------------
// 3. 左右旋 LR (先左旋左孩子, 再右旋根节点)
// ---------------------------------------------------
AVLNode *rotateLeftRight(AVLNode *node)
{
    node->left = rotateLeft(node->left); // 先对左孩子左旋
    return rotateRight(node);            // 再对当前根右旋
}

// ---------------------------------------------------
// 4. 右左旋 RL (先右旋右孩子, 再左旋根节点)
// ---------------------------------------------------
AVLNode *rotateRightLeft(AVLNode *node)
{
    node->right = rotateRight(node->right); // 先对右孩子右旋
    return rotateLeft(node);                // 再对当前根左旋
}
```

#### 1.1.7 为什么旋转不会破坏 BST 性质

> [!IMPORTANT]
>
> 这是一个极其牛逼的思想, 局部有问题就调整局部, 完全影响不到全局.

因为旋转仅仅改变了谁当父亲, 谁当孩子, 以及树的形状, 并没有改变这棵树的中序遍历, 这是极巧妙的点, 没有改变中序遍历的顺序, 也就是说并没有破坏 BST 的中序严格递增的性质.

> [!CAUTION]
>
> 另外, 值得注意的是, 一般在插入后只需要修正最低失衡点, 在这小部分旋转修正完成后, 一般来说该部分子树会恢复到原来的高度, 所以整棵树也将自动恢复了.
>
> 还需要注意的是, 虽然只需要修正最低失衡点有关部分, 但是平衡因子 (BF) 依旧需要沿插入路径回溯更新, 以及树的高度也需要更新.

#### 1.1.8 为什么 AVL Trees 一定只有 $O(\log N)$ 高

想要证明这个问题, 我们首先设树高为 $h$ 的 AVL Trees 的节点数为 $n_h$;

为了整棵树的节点数尽可能少, 我们设左子树和右子树的差距足够大, 以满足单边字数和根节点一起满足 $h$ 的树高即可, 也就是说, 我们可以设左子树高度为 $h-1$, 右子树高度为 $h-2$, 这样两边的差距达到最大, 节点数最少;

此时我们记左子树最少节点数为 $n_{h-1}$, 右子树同理为 $n_{h-2}$, 因此我们得到了如下关系:

$$
n_h=n_{h-1}+n_{h-2}+1
$$

想起来了吗, 此前我们提到过这个公式, 并提及我们很容易联想到斐波那契数列.


**WARNING:**

这个证明有点不容易, 这里给出 ChatGPT 的示例:

**证明过程**

由于空树高度为 -1:

$$
n_{-1}=0
$$

叶结点高度为 0:

$$
n_0=1
$$

继续计算:

$$
n_1=n_0+n_{-1}+1=2
$$

$$
n_2=n_1+n_0+1=4
$$

$$
n_3=n_2+n_1+1=7
$$

$$
n_4=n_3+n_2+1=12
$$

得到:

```
高度        -1   0   1   2   3   4
最少结点     0   1   2   4   7  12
```

---

斐波那契数列满足:

$$
F_0=0,\quad F_1=1
$$

$$
F_i=F_{i-1}+F_{i-2}
$$

AVL 最少结点数满足:

$$
n_h=F_{h+3}-1
$$

而斐波那契数大约按照黄金比例的指数增长:

$$
F_k\approx \frac{\varphi^k}{\sqrt{5}}
$$

其中:

$$
\varphi=\frac{1+\sqrt{5}}{2}
$$

所以:

$$
N\geq n_h\approx C\varphi^h
$$

两边取对数:

$$
h=O(\log N)
$$

因此 AVL 树的:

$$
\text{查找}=O(\log N)
$$

$$
\text{插入}=O(\log N)
$$

PPT 这一部分证明的核心不是求某个特别精确的常数, 而是证明:

AVL Trees 的高度不会接近 $N$, 而只会随着结点数按对数增长.


个人认为只需知道即可, 怎么证的其实不太重要, 只需记住 AVL Trees 的树高就是 $O(\log N)$ 即可吧~

```c
// create a node:
AVLNode *newNode(int key)
{
    AVLNode *node = (AVLNode *)malloc(sizeof(AVLNode));
    node->key = key;
    node->left = NULL;
    node->right = NULL;
    node->height = 0; // the height of a single node is 0
    return node;
}

// calculate BF:
int getBalance(AVLNode *root)
{
    if (root == NULL)
    {
        return 0;
    }
    return getHeight(root->left) - getHeight(root->right);
}

// insert the tree:
AVLNode *insert(AVLNode *root, int key)
{
    if (root == NULL)
    {
        return newNode(key);
    }
    if (key < root->key)
    {
        root->left = insert(root->left, key);
    }
    else if (key > root->key)
    {
        root->right = insert(root->right, key);
    }
    else
    {
        return root;
    }
    root->height = max(getHeight(root->left), getHeight(root->right)) + 1;
    int balance = getBalance(root);
    // LL
    if (balance > 1 && key < root->left->key)
    {
        return rotateRight(root);
    }
    if (balance < -1 && key > root->right->key)
    {
        return rotateLeft(root);
    }
    // LR
    if (balance > 1 && key > root->left->key)
    {
        root->left = rotateLeft(root->left);
        return rotateRight(root);
    }
    // RL
    if (balance < -1 && key < root->right->key)
    {
        root->right = rotateRight(root->right);
        return rotateLeft(root);
    }
    return root;
}
```

#### 1.1.9 删除与插入的区别

AVL 删除先按普通 BST 规则处理: 无孩子直接删除, 一个孩子直接接替, 两个孩子则用前驱或后继替代后再删除相应节点.

然后沿删除路径向上更新高度, 对失衡节点旋转. 判断方向时应查看孩子的 BF, 不能继续套用插入时"比较新 key"的条件:

| 当前节点 BF | 较高孩子的 BF | 修复 |
| :---: | :---: | :--- |
| $>1$ | 左孩子 $\ge0$ | 右旋 |
| $>1$ | 左孩子 $<0$ | 先左旋左孩子, 再右旋 |
| $<-1$ | 右孩子 $\le0$ | 左旋 |
| $<-1$ | 右孩子 $>0$ | 先右旋右孩子, 再左旋 |

> [!IMPORTANT]
>
> 插入修复最低失衡节点后, 该子树恢复到插入前的高度, 不需要继续向上旋转;删除修复后高度仍可能降低, 因而可能触发更高祖先的失衡. 删除最坏需要 $O(\log N)$ 次旋转, 总时间仍为 $O(\log N)$.

### 1.2 Splay Trees

#### 1.2.1 背景

> 首先, 它是一棵 BST, 毋庸置疑.

我们首先做一个引入:

<div class="note-center">Why Splay Trees ?</div>

> 我们回看 AVL Trees, 可以发现其每一次操作都是 $O(\log N)$, 但代价同样<s>可观</s>比较大:
>
> 1.  每个节点需要保存 Height 和 BF;
> 2.  插入和删除都要检查平衡问题, 否则需要调整修正;
> 3.  需识别 LL,RR,LR,RL;
> 4.  某次删除可能需要多次回溯向上调平衡.

此时 Splay Trees 应运而生, 它的基本思想是:

> 不要求树在每次操作都要极度平衡, 只需要糟糕操作的次数在总样本中足够小.

#### 1.2.2 定义

> [!IMPORTANT]
>
> AVL Trees 和 Splay Trees 都是 BST, 但维护规则不同, 没有"AVL 是 Splay 的特例"这一包含关系. AVL 维护高度平衡, Splay 则在访问后把相关节点伸展到根.

我们因此说些人话, Splay Trees 的基本要求是, 从空树开始执行任意 $M$ 次查找,插入或删除, 设过程中最多有 $N$ 个节点, 总时间为 $O(M\log(N+1))$. 即 Splay 不保证单次 $O(\log N)$.

> **引理: 摊还时间**
>
> 可以简单地理解为平均时间, 但是它并不是标准意义上的平均时间, 这里的"平均"是对任意操作序列的总成本按操作次数平摊, 不需要假定输入的概率分布.
>
> 单次最坏界,摊还界和平均界的分析对象不同. 课件中的大小关系要在相同操作模型下理解, 不能把不同概率分布或不同初始状态下的界直接拿来比较.

因此每次的摊还时间为 $O(\log N)$, 但并不意味着每一次的操作时间均为严格的 $O(\log N)$.

也就是说, 某次操作可能是 O(N), 但多次操作后总时间成本仍然受控制.

简单来说, 一个或几个操作很糟糕, 也无所谓, 反正最终平均是 $O(\log N)$ 就可以了.

定义结构体, 以及基本操作:

```c
typedef struct SplayNode
{
    int key;
    struct SplayNode *left;
    struct SplayNode *right;
} SplayNode;

// rotateRight
SplayNode *rotateRight(SplayNode *root)
{
    SplayNode *newNode = root->left;
    root->left = newNode->right;
    newNode->right = root;
    return newNode;
}

// rotateLeft
SplayNode *rotateLeft(SplayNode *root)
{
    SplayNode *newNode = root->right;
    root->right = newNode->left;
    newNode->left = root;
    return newNode;
}
```

#### 1.2.3 核心 Splay 操作

> **Splay Trees 的核心**
>
> 每次访问一个节点 X 后, 通过旋转将 X 旋转到根, 这是 Splay Trees 自适应访问规律的其中一点.

下面有一种需要注意的情况, 即不能将节点一路单旋到根:


**WARNING:**

依次插入 1,2,3,...,N, 再依次访问 1,2,3,...,N;

显然, 若不断地单旋会产生极大的操作成本, 这个序列的总成本可达到 $\Theta(N^2)$, 不能得到所需的摊还保证.

因此, 这种方法如 cyll 的课件所说:

<div class="note-center">Does NOT work</div>


<details style="--wi-box-color:var(--wi-question);--wi-box-bg:var(--wi-question-bg)"><summary>正确的伸展操作是什么?</summary><p>正确的伸展操作必须根据: </p><ol><li>当前节点 X;</li><li>父节点 P;</li><li>祖父节点 G;</li></ol><p>之间的位置关系进行处理. </p></details>

此时, 按照这个前提, 我们设:

- X 为当前节点;
- P 为 X 的父节点;
- G 为 X 的祖父节点;


分为三种情况讨论:

**Zig**

P 是根节点时, 只剩最后一层, 只需 X 与 P 旋转一次即可

(1) 情况一: X 为左孩子(单右旋)

```c
      P                    X
   /       ---->          \
X                        P
```

(2) 情况二: X 为右孩子(单左旋)

```c
P                        X
   \       ---->          /
      X                    P
```

**Zig-zig**

当 X 与 P 位于同一方向, 先旋 P 和 G, 再旋 X 和 P

(1) 情况一: 左左情况(先右旋 P-G, 再右旋 X-P)

```c
       G
      /                      P
     P        ---->         / \
    /                      X   G        ---->   X
 X                                               \
                                                  P
                                                   \
                                                    G
```

(2) 情况二: 右右情况(先左旋 P-G, 再左旋 X-P)

```c
 G
    \                        P
     P        ---->         / \
      \                    G   X        ---->       X
       X                                           /
                                                  P
                                                 /
                                                G
```

**Zig-zag**

当 X 和 P 位于相反方向时, 先旋 X 和 P, 再旋 X 和 G

(1) 情况一: 左右情况(先左旋 X-P, 再右旋 X-G)

```c
     G
   /                      X
 P        ---->         / \
   \                    P   G
     X
```

(2) 情况二: 右左情况(先右旋 X-P, 再左旋 X-G)

```c
 G
   \                      X
     P        ---->       / \
   /                    G   P
 X
```


看看 Splay 的代码:

```c
SplayNode *splay(SplayNode *root, int key)
{
    if (root == NULL || root->key == key)
    {
        return root;
    }

    // left
    if (key < root->key)
    {
        if (root->left == NULL)
        {
            return root;
        }
        // zig-zig
        if (key < root->left->key)
        {
            root->left->left = splay(root->left->left, key);
            root = rotateRight(root);
        }
        // zig-zag
        else if (key > root->left->key)
        {
            root->left->right = splay(root->left->right, key);
            if (root->left->right != NULL)
            {
                root->left = rotateLeft(root->left);
            }
        }
        if (root->left == NULL)
        {
            return root;
        }
        return rotateRight(root);
    }
    // right
    else
    {
        if (root->right == NULL)
        {
            return root;
        }
        // zig-zig
        if (key > root->right->key)
        {
            root->right->right = splay(root->right->right, key);
            root = rotateLeft(root);
        }
        // zig-zag
        else if (key < root->right->key)
        {
            root->right->left = splay(root->right->left, key);
            if (root->right->left != NULL)
            {
                root->right = rotateRight(root->right);
            }
        }
        if (root->right == NULL)
        {
            return root;
        }
        return rotateLeft(root);
    }
}
```

#### 1.2.4 Splay 的效果

如上可知, Zig-zig 和 Zig-zag 都能让 X 直接上升两层, 还会重新组织整条访问路径.

因此 cyll 给出了直观的结论:

> 伸展不仅把访问结点移到根, 还会使访问路径上大多数结点的深度大致减半.

其正是"摊还"操作的底层逻辑, 即一次的昂贵操作换来了后续多次的便宜操作.

#### 1.2.5 Splay Trees 的查找,插入和删除

> **一点约定**
>
> 这里我们为表区分, 查找的元素设为 X, 插入的元素设为 X', 删除的元素设为 X''

1. 查找:
   - 先按普通的 BST 寻找到 X;

   - 对其 Splay, 将其伸展到根;

     > [!WARNING]
     >
     > 若查找失败, 通常依旧会 Splay 最后访问的节点, 使整棵树依然得到调整

     ```c
     SplayNode *search(SplayNode *root, int key)
     {
     return splay(root, key);
     }
     ```

2. 插入:
   - 先按普通 BST 的规则插入节点 X';

   - 再对插入的节点进行 Splay;下方代码采用等价的"先 Splay 查找位置, 再分开左右子树并接到新根"写法.

     > [!IMPORTANT]
     >
     > 最后, 插入的节点 X' 会成为根

     ```c
     SplayNode *newNode(int key)
     {
         SplayNode *node = (SplayNode *)malloc(sizeof(SplayNode));
         node->key = key;
         node->left = NULL;
         node->right = NULL;
         return node;
     }
     
     SplayNode *insert(SplayNode *root, int key)
     {
         if (root == NULL)
         {
             return newNode(key);
         }
         root = splay(root, key);
         if (root->key == key)
         {
             return root;
         }
         SplayNode *node = newNode(key);
         if (key < root->key)
         {
             node->right = root;
             node->left = root->left;
             root->left = NULL;
         }
         else
         {
             node->left = root;
             node->right = root->right;
             root->right = NULL;
         }
         return node;
     }
     ```
   
3. 删除:
   - 首先查找 X'', 找到后对其进行 Splay, 成为根;

   - 删除 X'', 剩下左右两颗子树, 记为 $T_L$ 和 $T_R$, 显然 $T_L$ 中所有元素小于 X'', $T_R$ 中所有元素大于 X'';

   - 寻找 $T_L$ 中的最大元素 M, 显然 M 一定没有右孩子, 对 M 进行 Splay, 伸展到 $T_L$ 的根;

   - 容易发现这有点类似于 Zig, 此时 M 依旧没有右孩子, 即顺理成章地将 $T_R$ 连接到 M 上;

     > [!CAUTION]
     >
     > - 此情况下仍然满足 $T_L\setminus\{M\}$ 中的所有元素 $<M<$ $T_R$ 中的所有元素
     > - 而 $T_L$ 和 $T_R$ 本身就是 BST, 因此整棵树仍满足 BST 的基本性质
     
     ```c
     SplayNode *deleteNode(SplayNode *root, int key)
     {
         if (root == NULL)
         {
             return NULL;
         }
         root = splay(root, key);
         if (root->key != key)
         {
             return root;
         }
         SplayNode *temp;
         if (root->left == NULL)
         {
             temp = root;
             root = root->right;
             free(temp);
         }
         else
         {
             temp = root;
             SplayNode *leftTree = root->left;
             SplayNode *rightTree = root->right;
             free(temp);
             SplayNode *p = leftTree;
             while (p->right != NULL)
             {
                 p = p->right;
             }
             leftTree = splay(leftTree, p->key);
             leftTree->right = rightTree;
             root = leftTree;
         }
         return root;
     }
     ```

#### 1.2.6 泛谈摊还

摊还不等同于传统意义上的平均值 / 随机平均, 其分析的是:

> 连续执行一系列操作时, 每次操作平均需要承担多少成本.

相比随机平均, 其不需要假设:

- 输入随机;
- 操作等概率;
- 数据服从某种概率分布.

其分析的是最坏操作序列的总成本, 不依赖输入随机性.

<details style="--wi-box-color:var(--wi-question);--wi-box-bg:var(--wi-question-bg)"><summary>由此, "摊还"拥有了一个极为神准的定义</summary><p>cyll: 摊还, 可理解为平均值的上界. </p></details>

基于此, 我们拥有了三种不同含义的复杂度:

1. 单次最坏复杂度;
2. 平均复杂度;
3. 摊还复杂度.

#### 1.2.7 摊还分析方法

这里介绍三种分析方法:

1. 聚合法 (Aggregate Analysis)

2. 记账法 (Accounting Method)

3. 势能法 (Potential Method)

<div class="note-center">↓下面进行一一解读↓,</div>


**Aggregate Analysis**

本质是直接分析整个序列

假设连续 n 次操作的总时间成本是 T(n), 那么每一次的时间成本就是 T(n)/n

**典型例子**

压栈和弹栈的操作, 每一次都是 O(1), 那么连续弹出 k 个元素, 成本为 O(min{|S|, k})

压栈和弹栈的总次数最多均为 n, 因此 T(n) = O(n), 每次摊还成本仍为 T(n)/n = O(1)

**WARNING:**

:x: **Wrong Thinking**: 如果认为有 n 次操作, 一次连续弹栈最坏是 n 次操作, 认为时间成本是 O(n²).

该结论过于坏, 导致实际情况中根本不会发生, 因为除非重新压栈, 否则一个元素不可能弹出两次.

**Accounting Method**

本质是摊还成本高于实际成本时, 多出的成本存储起来以供下一次的复杂操作消耗

- 记第 i 次的实际成本为 $c_i$
- 记第 i 次的摊还成本为 $c_i'$

为保证分析有效, 需要满足:

$$
\sum c_i' \ge \sum c_i
$$

我们以**栈操作**为例:

**IMPORTANT:**

1. 实际成本:
   - Push: 1;
   - Pop: 1;
   - MultiPop: 实际多少元素就是多少;
2. 摊还分析:
   - Push: 2;
   - Pop: 0;
   - MultiPop: 0;

此时每一次 Push 收取 2, 该元素被 Pop 时, 自动消耗其 Push 时留下的信用, 这样栈中有几个元素, 就至少有几份信用, 由此可知每个元素:

- 被 Push 时获得信用;
- 被弹出时消耗信用;
- 不会被无支付地重复弹出.

即总摊还成本最多是 2n, 每次成本依然为 O(1).

其中, Pop 为 0 不代表其真的不运行, 而是其成本已由 Push 预支付了.

**Potential Method**

**TIP:**

可以认为是记账法的数学化版本

记 $D_i$ 表示第 i 次完成后的数据结构状态, 定义势能函数 $\Phi(D_i)$, 表示积累的"潜在工作 / 存储"

由此我们有:

$$
c_i'=c_i+\Phi(D_i)-\Phi(D_{i-1})=c_i+\Delta \Phi_i
$$

那么对于总的操作, 我们有:

$$
\sum c_i'=\sum c_i+\sum \Delta \Phi_i=\sum c_i+\Phi(D_n)-\Phi(D_0)
$$

若保证 $\Phi(D_n) \ge \Phi(D_0)$, 则有 $\sum c_i' \ge \sum c_i$, 即摊还成本为实际总成本的上界.

因此一个好的势能函数通常要满足:

- 势能非负;
- 初始状态势能最小;
- 数据结构越"危险"或未来可能越贵, 势能越高.

**势能法分析栈**

我们定义一个势能函数, 即 $\Phi(D_i)$ 表示栈中元素个数, 即 $\Phi(D_i)=|S_i|$;

那么任何时候都有 $\Phi(D_i) \ge 0$;

1. Push
   - 实际成本 $c_i=1$;
   - 入栈, 势能增加: $\Delta \Phi=1$;
   - 即 $c_i'=2$;
2. Pop
   - 实际成本 $c_i=1$;
   - 弹栈, 势能减少: $\Delta \Phi=-1$;
   - 即 $c_i'=0$;
3. MultiPop
   - 假设弹出 k' 个元素, 即 k' = min{k, |S|}
   - 实际成本 $c_i=k'$;
   - 势能减少: $\Delta \Phi=-k'$;
   - 即 $c_i'=0$;

故三种操作的摊还成本均为 O(1), 与记账法结论一致.


#### 1.2.8 Potential Method 分析 Splay Trees

> 感觉是最<s>恶心</s>难的部分

我们需要证明将树中任意结点 X 伸展(Splay)到根结点的摊还时间复杂度为 $O(\log N)$.


**引理: Rank**

对伸展树中的任意结点 $i$, 作如下定义:

- **子树大小 S(i)**: 以结点 $i$ 为根的子树中的结点总数(包含 $i$ 自身).
- 范围界限: $1 \leq S(i) \leq N$
- **结点秩 R(i)**: 子树大小以 2 为底的对数值, 即: $R(i) = \log S(i)$
- 范围界限: $0 \leq R(i) \leq \log N$

**NOTE:**

这里的"Rank"不是树的高度. 由于伸展树可能极度不平衡(高度可能达到 N), 直接用高度无法得到对数界, 必须借助子树大小的对数来进行势能分析.


1. 整棵树的势能函数 (Potential Function)

整棵伸展树 $T$ 的总势能 $\Phi(T)$ 定义为树中所有结点的秩之和:

$$
\Phi(T) = \sum_{i \in T} R(i) = \sum_{i \in T} \log S(i)
$$

- **物理意义**: 一棵极度不平衡的树(如退化成链的树), 底部结点子树较小, 但顶部存在大量较大的子树, 整体势能较高.
- **分摊机制**: 虽然某些旋转操作会花费较高的实际成本, 但它们会显著降低整棵树的总势能, 从而释放势能来"支付"实际开销.

2. 旋转成本与摊还成本分析

设某次旋转操作前结点 $X$ 的秩为 $R_1(X)$, 旋转后的秩为 $R_2(X)$. 由于 $X$ 在旋转中向上移动, 其子树大小必然增加或不变, 因此始终有 $R_2(X) \geq R_1(X)$.

根据势能法公式, 某步操作的**摊还成本** $\hat{c}_i = \text{实际成本} + \Delta\Phi$.

3. 分析三种旋转修正的势能

> **3.1 Zig**(单旋)
>
> - 实际成本: $1$
> - 势能变化: 只有 $X$ 和其父结点 $P$ 的子树大小发生改变. 由于旋转后 $P$ 成了 $X$ 的孩子, 其子树变小或不变, 即 $R_2(P) - R_1(P) \leq 0$.
> - 摊还成本:
>   $$
>   \hat{c}_{\text{zig}} = 1 + R_2(X) - R_1(X) + R_2(P) - R_1(P) \leq 1 + R_2(X) - R_1(X)
>   $$

> **3.2 Zig-zag**(双旋: 一左一右 或 一右一左)
>
> - 实际成本: $2$
> - 摊还成本: 涉及 $X$,父结点 $P$ 和祖父结点 $G$ 的秩变化. 利用对数函数的凹凸性及子树大小关系可以证明:
>   $$
>   \hat{c}_{\text{zig-zag}} \leq 2(R_2(X) - R_1(X)) \leq 3(R_2(X) - R_1(X))
>   $$

> **3.3 Zig-zig**(双旋: 同左 或 同右)
>
> - 实际成本: $2$
> - 摊还成本: 同样通过代数放缩和秩的变化关系, 可以证明:
>   $$
>   \hat{c}_{\text{zig-zig}} \leq 3(R_2(X) - R_1(X))
>   $$

> **统一结论 (Access Lemma)**: 无论哪种双旋(Zig-zag 或 Zig-zig), 其单步摊还成本都可以被放宽并严格界定为:
>
> $$
> \hat{c}_i \leq 3(R_2(X) - R_1(X))
> $$

4. 望远镜消去与最终复杂度证明

将结点 $X$ 从底端伸展至根结点, 整个过程由若干次双旋(Zig-zig / Zig-zag)以及至多一次单旋(Zig, 仅在最后一步可能发生)组成.

将所有步骤的摊还成本累加时, $X$ 在各步的秩变化 $(R_2 - R_1) + (R_3 - R_2) + \dots$ 会发生**望远镜消去(Telescoping Sum)**:

$$
\sum \hat{c}_i \leq 3(R_{\text{最终}}(X) - R_{\text{最初}}(X)) + 1
$$

- **最终状态**: $X$ 成为整棵树的根, 包含全部 $N$ 个结点, 故 $R_{\text{最终}}(X) = \log N$.
- **初始状态**: $X$ 至少包含自身一个结点, 故 $R_{\text{最初}}(X) \geq 0$.

代入公式即可得到整个伸展过程的总摊还时间 $\hat{T}_{\text{splay}}$ 的上界:

$$
\hat{T}_{\text{splay}} \leq 3\log N + 1
$$

$$
\boxed{T_{\text{amortized}} = O(\log N)}
$$

> [!IMPORTANT]
> 单次操作实际可能需要 $O(N)$, 而单次摊还界为 $O(\log N)$. 从任意已有树开始分析 $M$ 次访问时, 总成本还要计入初始势能 $\Phi(T_0)$, 得到 $O(M\log N+\Phi(T_0))$;不能把"单次摊还界"误读为"任意一次实际访问都是对数时间".

#### 1.2.9 Amortized Analysis 总览

前面已经推过公式, 这里放一个便于复习的对照:

| Method | 核心问题 | 本节的例子 |
| :--- | :--- | :--- |
| Aggregate Analysis | 整个序列一共做了多少工作? | 每个入栈元素最多被弹出一次 |
| Accounting Method | 便宜操作留下的钱够不够支付以后? | Push 预付将来 Pop 的费用 |
| Potential Method | 当前状态还存着多少已支付的工作? | 栈取元素数, Splay 取各节点 Rank 之和 |

$$
\hat c_i=c_i+\Phi(D_i)-\Phi(D_{i-1})
$$

$$
\sum_{i=1}^{m}c_i=\sum_{i=1}^{m}\hat c_i+\Phi(D_0)-\Phi(D_m)
$$

> [!CAUTION]
>
> 要把总摊还成本用作总实际成本的上界, 应保证每个前缀都有 $\Phi(D_i)\ge\Phi(D_0)$, 通常取初始势能 0,后续非负. 若从任意已有状态开始, 别丢掉初始势能项.
>
> 平均情况依赖概率分布, 摊还分析依赖一串操作的总成本界;"摊还"不意味着输入随机, 也不保证每次实际成本都小.

栈例子中的 Pop / MultiPop 摊还记为 0, 是只计元素入栈,出栈工作的简化模型;加上空栈检查,循环判断等固定开销后, 仍然是 $O(1)$ 摊还成本.

### 1.3 Red-Black Trees

依旧经典问题起手:

<div class="note-center">Why Not AVL but Red-Black ?</div>

AVL Trees 要求任意节点左右子树得高度差不能超过 1, 实际上该要求是比较严格的.

对于 AVL Trees 来说, 其优势显而易见, 就是矮, 查找稳定. 插入和删除都要检查平衡, 但并非每次都需要旋转;删除时则可能需要沿祖先路径多次修复.

此时, 红黑树就拥有了存在的必要性.

#### 1.3.1 基本思想

> [!IMPORTANT]
>
> 红黑树不追求严格的高度平衡, 而是通过结点颜色约束, 保证最长路径不会比最短路径长太多.

且红黑树仍能保证树高的基本性质 h = $O(\log N)$.

#### 1.3.2 Red-Black Trees 定义

1. **每个节点非红即黑:** 显然, 每个节点拥有一个颜色字段, 其为 Red 或者 Black, 当然其无真正的实际意义, 只是用来维持平衡.

2. **根节点是黑色:** 插入的过程可能会使根暂时变红, 但最后插入完毕后将根染黑即可.

3. **所有的 NIL 叶节点均为黑色:** 我们把空孩子看作特殊的外部节点, 称为 NIL, 也就是说, 存储真实键值的是内部节点, 而空指针是外部 NIL 节点.

4. **红节点的孩子必须是黑色:** 也就是说, 连续两个红色孩子相连是违法的.

5. **从任意节点到其所有后代的 NIL 的路径中, 黑节点数必须相同:** 这里给个示例, 从节点

   x 出发, 到它下面任意一个 NIL 结点, 路径中经过的黑结点数量必须相同.

   > [!WARNING]
   >
   > 这里并没有要求路径长度相同, 也没有要求红节点数相同, 仅黑节点做了要求.

   ```c
                黑 x
               /    \
             红      黑
            /  \     / \
          黑   黑   红  红
   ```

结构体定义:

```c
typedef enum
{
    RED,
    BLACK
} Color;

typedef struct RBNode
{
    int key;
    Color color;
    struct RBNode *left;
    struct RBNode *right;
    struct RBNode *parent;
} RBNode;

RBNode *NIL;
```

#### 1.3.3 黑高 Black Height

定义: 从 x 向下到任意 NIL 叶结点的简单路径中, 不含 x 自身,但包含终点 NIL 的黑结点数量, 记为 $bh(x)$;约定 $bh(NIL)=0$.

> 由红黑树的第五条定义, x 到其所有后代的 NIL 路径中黑节点数相同, 因此 bh(x) 是良定义的.
>
> 注意: x is not included.

- 例一: 黑高是 0
  - 则仅有一个 NIL 节点

- 例二: 黑高是 1

```c
  1.       x
          / \
        NIL NIL


  2.       x
          / \
         R  NIL
        / \
      NIL NIL


  3.       x
          / \
        NIL  R
            / \
          NIL NIL


  4.       x
        /      \
       R        R
     /   \    /   \

    NIL  NIL NIL  NIL
```

#### 1.3.4 Red-Black Trees 树高

先说结论, 其树高满足以下不等式:

$$
h\le 2\log_2(N+1)
$$

其中 h 是红黑树的高度, N 为红黑树的内部节点数. 下面给出一个简单的证明.


**证明红黑树的树高**

首先证明每个以 x 为根的子树至少有 $2^{bh(x)}-1$ 个内部真实节点, 这里需要归纳假设.

**引理: 证明子树节点数公式**

1. 若 x 是 NIL, 则 bh(x) 显然是 0, 注意黑高不把 x 自身算在内;
2. 归纳假设, 若 x 是平凡内部节点, 其孩子的黑高至少是 bh(x) - 1, 根据归纳假设, 其孩子的子树拥有至少 $2^{bh(x)-1}-1$ 个内部真实节点;
3. 此时有 $size(x) \ge 1+2(2^{bh(x)-1}-1) = 2^{bh(x)}-1$.

由此, 假设成立.

其次, 根据红黑树的第四条性质, 我们知道红色的节点相连是违法的, 因此每一条路径中黑节点数必须大于等于该路径节点数的一半, 即 bh(x) ≥ h/2.

最后, 合并两个结论有:

$$
h\le 2\log_2(N+1)
$$

这就说明虽然 Red-Black Trees 没有 AVL Trees 那样严格的平衡, 但其树高依然满足 $O(\log N)$, 因此查找时间依旧为 $O(\log N)$.


#### 1.3.5 查找,插入和删除

```c
// 初始化
void initNIL(void)
{
    NIL = (RBNode *)malloc(sizeof(RBNode));
    NIL->color = BLACK;
    NIL->left = NIL;
    NIL->right = NIL;
    NIL->parent = NIL;
    NIL->key = 0;
}

// 创建新节点
RBNode *newNode(int key)
{
    RBNode *node = (RBNode *)malloc(sizeof(RBNode));
    node->key = key;
    node->color = RED;
    node->left = NIL;
    node->right = NIL;
    node->parent = NIL;
    return node;
}
```


**查找**

极易理解, 因为和 BST 完全一致, 不多赘述.

由于树高为 $O(\log N)$, 因此查找的时间复杂度同为 $O(\log N)$.

```c
RBNode *search(RBNode *root, int key)
{
    while (root != NIL && root->key != key)
    {
        if (key < root->key)
        {
            root = root->left;
        }
        else
        {
            root = root->right;
        }
    }
    return root;
}
```

**插入**

Red-Black Trees 的插入主要分为两步, 首先是按照普通的 BST 规则插入, 其次是修复节点颜色. 在此我们直接略过 BST 插入部分.

1. 新插入的元素, 默认是红色;

**WARNING:**

如果是黑色, 直接破坏了相关路径的 bh(x), 很容易直接违反不同路径黑高相同的经典性质.

**引理: 四个关键元素**

1. G: 祖父结点 Grandparent
2. P: 父结点 Parent
3. U: 叔叔结点 Uncle
4. x: 当前结点

以下给出一个示例:

```c
          G
         / \
        P   U
       /
      x
```

2. 不需要修复的情况如下:
   - 新节点成为根, 无脑将其染成黑色, 因为根节点永远是黑色;
   - 父节点是黑色, 那么直接插入即可, 因为如果染黑就会破坏 bh(x).
3. 插入总体有三种 Case, 如下:

**Case 1: 叔叔节点是红色**

```c
          黑 G                            红 G
         /    \                          /    \
       红 P   红 U        ---->        黑 P   黑 U
       /                               /
     红 x                            红 x
```

此时我们需要 P 染黑, U 染黑, G 染红即可.

**Case 2: 叔叔黑色, 形成折线**

```c
         黑 G                            黑 G
         /                               /
       红 P           ---->            红 x
         \                             /
         红 x                        红 P
```

现在当然是不合法的状态, 因此顺势转入 Case 3.

**Case 3: 叔叔黑色, 形成直线**

```c
          黑 G
         /                           黑 P
       红 P          ---->           /   \
       /                          红 x   红 G
     红 x
```

将 P 染黑, 将 G 染红, 然后 G 右旋.

我们将其汇总起来即为:

|  情况  | 叔叔颜色 |     结构      |              操作              |
| :----: | :------: | :-----------: | :----------------------------: |
| Case 1 |   红色   |     任意      | 父,叔染黑, 祖父染红, 继续向上 |
| Case 2 |   黑色   | 折线 LR 或 RL |    旋转父结点, 转成 Case 3     |
| Case 3 |   黑色   | 直线 LL 或 RR |    父黑,祖父红, 再旋转祖父    |

这里我们给到 cyll 的一个例子:

<div class="note-center">11,2,14,1,7,15,5,8,4</div>

插入 4 之前, 树长成如下的状态↓

```c
            11黑
           /    \
         2红    14黑
        /  \       \
      1黑  7黑     15红
          /  \
        5红  8红
```

插入 4 之后, 树长成如下的状态↓

```c
            11黑
           /    \
         2红    14黑
        /  \       \
      1黑  7黑     15红
          /  \
        5红  8红
       /
      4红
```

此时 x = 4, 5 和 8 均为红色, 故为 Case 1, 即 5 和 8 染黑, 7 染红后结果如下↓

```c
            11黑
           /    \
         2红    14黑
        /  \       \
      1黑  7红     15红
          /  \
        5黑  8黑
       /
      4红
```

现在 7 和 2 同为红色, 令 x = 7, 此时 2 为父亲, 11 为祖父, 14 为叔叔, 2 为 11 的左孩子, 7 是 2 的右孩子, 符合 Case 2 的条件;

对 2 左旋, 形成 Case 3, 将 7 染黑, 将 11染红, 最后对 11 右旋, 最终根为 7.

```c
             7黑
           /     \
         2红     11红
        /  \     /  \
      1黑  5黑  8黑 14黑
           /          \
         4红          15红
```

**时间复杂度**

查找插入位置为 O(h) = $O(\log N)$

颜色修复可能沿祖先路径上移, 故依然为 $O(\log N)$

注意旋转次数最多只有 2 次.

```c
void leftRotate(RBNode **root, RBNode *x)
{
    RBNode *y = x->right;

    x->right = y->left;

    if (y->left != NIL)
        y->left->parent = x;

    y->parent = x->parent;

    if (x->parent == NIL)
    {
        *root = y;
    }
    else if (x == x->parent->left)
    {
        x->parent->left = y;
    }
    else
    {
        x->parent->right = y;
    }

    y->left = x;
    x->parent = y;
}

void rightRotate(RBNode **root, RBNode *y)
{
    RBNode *x = y->left;

    y->left = x->right;

    if (x->right != NIL)
        x->right->parent = y;

    x->parent = y->parent;

    if (y->parent == NIL)
    {
        *root = x;
    }
    else if (y == y->parent->left)
    {
        y->parent->left = x;
    }
    else
    {
        y->parent->right = x;
    }

    x->right = y;
    y->parent = x;
}

RBNode *bstInsert(RBNode **root, int key)
{
    RBNode *z = newNode(key);

    RBNode *y = NIL;
    RBNode *x = *root;

    while (x != NIL)
    {
        y = x;

        if (key < x->key)
        {
            x = x->left;
        }
        else if (key > x->key)
        {
            x = x->right;
        }
        else
        {
            free(z);
            return NIL;
        }
    }

    z->parent = y;

    if (y == NIL)
    {
        *root = z;
    }
    else if (z->key < y->key)
    {
        y->left = z;
    }
    else
    {
        y->right = z;
    }

    return z;
}

void insertFixup(RBNode **root, RBNode *z)
{
    while (z->parent->color == RED)
    {
        if (z->parent ==
            z->parent->parent->left)
        {
            RBNode *uncle =
                z->parent->parent->right;

            /* Case 1：叔叔是红色 */
            if (uncle->color == RED)
            {
                z->parent->color = BLACK;
                uncle->color = BLACK;

                z->parent->parent->color = RED;

                z = z->parent->parent;
            }

            else
            {
                /* Case 2：LR */
                if (z == z->parent->right)
                {
                    z = z->parent;

                    leftRotate(root, z);
                }

                /* Case 3：LL */
                z->parent->color = BLACK;

                z->parent->parent->color = RED;

                rightRotate(
                    root,
                    z->parent->parent);
            }
        }

        /* 完全对称 */
        else
        {
            RBNode *uncle =
                z->parent->parent->left;

            /* Case 1 */
            if (uncle->color == RED)
            {
                z->parent->color = BLACK;
                uncle->color = BLACK;

                z->parent->parent->color = RED;

                z = z->parent->parent;
            }

            else
            {
                /* Case 2：RL */
                if (z == z->parent->left)
                {
                    z = z->parent;

                    rightRotate(root, z);
                }

                /* Case 3：RR */
                z->parent->color = BLACK;

                z->parent->parent->color = RED;

                leftRotate(
                    root,
                    z->parent->parent);
            }
        }
    }

    (*root)->color = BLACK;
}

void rbInsert(RBNode **root, int key)
{
    RBNode *z = bstInsert(root, key);

    if (z != NIL)
        insertFixup(root, z);
}
```

**删除**

先进行普通的 BST 删除规则

1. 删除叶节点: 直接使用指针断开其与父节点的连接即可;
2. 删除只有一个孩子的节点: 直接用它唯一的孩子替代它;
3. 删除有两个孩子的节点: 取用左子树的最大值节点(中序前驱)或右子树的最小节点(中序后继)进行替代, 复制到目标节点后删除该替代节点. (Keep the color)

删除的一些情况:

1. 删除红色叶子节点, 直接删除即可;
2. 删除黑色节点, 且其有一个红色孩子, 即将其孩子替代它后染成黑色;
3. 最困难的情况莫过于, 删除了一个黑色的节点, 而替代它的是一个黑色的节点或者 NIL, 这样直接删除的话会使得该路径直接少一个黑色节点.

**IMPORTANT:**

为了表述这种状态, 常把替代位置 x 表示为"双黑节点", 是一种分析状态, 表示该路径目前缺少一个黑色节点, 需要补偿.

为了做到真正的删除, 我们需要首先定义其节点的角色

**节点角色**

- x: 当前缺少一个黑色的结点, 可能是 NIL;
- p: x 的父结点;
- w: x 的兄弟结点 sibling;

对于其他的节点我们也一起做定义:

```c
          p
         / \
        x   w
           / \
         near far
```

w 的左孩子离 x 较近, 成为 near child, 同理离得远的叫 far child.

删除的**四种情况**:

1. **Case 1**: 兄弟 w 是红色
   - 则将 w 染黑, 将 p 染红, 再对 p 左旋

   ```c
             黑 p                             黑 w
            /    \                           /
         双黑 x  红 w      ---->          红 p
                 / \                     /    \
               黑   黑               双黑 x      新兄弟
   ```

   一般来说 Case 1 不会直接解决问题, 而是转换后进入 Case 2 或者 Case 3 或者 Case 4.

2. **Case 2**: 兄弟是黑色, 两个孩子也都是黑色
   - 将兄弟 w 染红, 这样相当于从兄弟那条路径中拿走一个黑色, 使左右两边在当前层重新相等.

   ```c
              p                             p
            /   \                          / \
         双黑 x  黑 w      ---->      双黑 x  红 w
                 / \
               黑   黑
   ```

   **子情况 2.1(父结点是红色):**  把父结点染黑(父红 → 父黑). 缺少的黑色由父结点补上, 问题解决.

   **子情况 2.2(父结点也是黑色):**  当前局部虽然平衡了, 但整个子树相对于更高层仍然缺少一个黑色. 所以将 x ← p(把"双黑"问题向上移动), 继续检查. 如果 x 最终成为根, 则可以直接停止, 因为整棵树所有路径同时少一个黑色, 并不会导致路径之间不一致.

3. **Case 3**: 兄弟黑, 近孩子红, 远孩子黑
   - 将近孩子染黑, w 染红, 再对 w 右旋;
   - 得到的新兄弟具有红色远孩子, 从而转成 Case 4.

   ```c
             p                              p
            / \                            / \
         双黑 x  黑 w      ---->       双黑 x  黑 near
                 / \                             \
               红   黑                           红 w
              near  far                           \
                                                   黑 far
   ```

   Case 3 的目的与插入中的折线调整类似, 是把结构转换成 Case 4.

4. **Case 4**: 兄弟黑, 远孩子红
   - 将 w 染成原父结点 p 的颜色, 将 p 染黑, 将远孩子染黑, 再对 p 左旋;
   - 旋转后, 两侧路径的黑结点数量恢复一致, 双黑问题彻底解决.

   ```c
             p                             w (原 p 颜色)
            / \                                / \
         双黑 x  黑 w      ---->          黑 p  黑 far
                 / \                         /   \
                ?   红 far                 黑 x   ?
   ```

   补充: 如果 x 在右侧, 则全部处理左右对称:
   - Case 1 对父结点右旋;
   - Case 3 对兄弟左旋;
   - Case 4 对父结点右旋.

红黑树删除复杂度:

查找与普通删除需要 $O(\log N)$, Case 2 可能不断地向上推, 所以颜色修正可能也是 $O(\log N)$, 但旋转次数最多只有 3 次(Case 1,3,4 各一次), 因此删除总时间仍为 $O(\log N)$.

```c
RBNode *minimum(RBNode *root)
{
    while (root->left != NIL)
        root = root->left;

    return root;
}


void transplant(RBNode **root, RBNode *u, RBNode *v)
{
    if (u->parent == NIL)
    {
        *root = v;
    }
    else if (u == u->parent->left)
    {
        u->parent->left = v;
    }
    else
    {
        u->parent->right = v;
    }

    v->parent = u->parent;
}


void deleteFixup(RBNode **root, RBNode *x)
{
    while (x != *root && x->color == BLACK)
    {
        /* x 是左孩子 */
        if (x == x->parent->left)
        {
            RBNode *w = x->parent->right;

            /* Case 1: sibling 是 RED */
            if (w->color == RED)
            {
                w->color = BLACK;
                x->parent->color = RED;

                leftRotate(root, x->parent);

                w = x->parent->right;
            }

            /* Case 2: sibling 黑，两个孩子都黑 */
            if (w->left->color == BLACK &&
                w->right->color == BLACK)
            {
                w->color = RED;

                x = x->parent;
            }
            else
            {
                /* Case 3:
                   sibling 黑
                   近孩子红
                   远孩子黑
                */
                if (w->right->color == BLACK)
                {
                    w->left->color = BLACK;
                    w->color = RED;

                    rightRotate(root, w);

                    w = x->parent->right;
                }

                /* Case 4:
                   sibling 黑
                   远孩子红
                */
                w->color = x->parent->color;

                x->parent->color = BLACK;
                w->right->color = BLACK;

                leftRotate(root, x->parent);

                x = *root;
            }
        }

        /* x 是右孩子，完全左右对称 */
        else
        {
            RBNode *w = x->parent->left;

            /* Case 1 */
            if (w->color == RED)
            {
                w->color = BLACK;
                x->parent->color = RED;

                rightRotate(root, x->parent);

                w = x->parent->left;
            }

            /* Case 2 */
            if (w->right->color == BLACK &&
                w->left->color == BLACK)
            {
                w->color = RED;

                x = x->parent;
            }
            else
            {
                /* Case 3 */
                if (w->left->color == BLACK)
                {
                    w->right->color = BLACK;
                    w->color = RED;

                    leftRotate(root, w);

                    w = x->parent->left;
                }

                /* Case 4 */
                w->color = x->parent->color;

                x->parent->color = BLACK;
                w->left->color = BLACK;

                rightRotate(root, x->parent);

                x = *root;
            }
        }
    }

    x->color = BLACK;
}


void rbDelete(RBNode **root, int key)
{
    RBNode *z = search(*root, key);

    if (z == NIL)
        return;

    RBNode *y = z;
    Color originalColor = y->color;

    RBNode *x;

    /* 情况 1：没有左孩子 */
    if (z->left == NIL)
    {
        x = z->right;

        transplant(root, z, z->right);
    }

    /* 情况 2：没有右孩子 */
    else if (z->right == NIL)
    {
        x = z->left;

        transplant(root, z, z->left);
    }

    /* 情况 3：左右孩子都有 */
    else
    {
        /* 找右子树最小节点，即 successor */
        y = minimum(z->right);

        originalColor = y->color;

        x = y->right;

        if (y->parent == z)
        {
            x->parent = y;
        }
        else
        {
            transplant(root, y, y->right);

            y->right = z->right;
            y->right->parent = y;
        }

        transplant(root, z, y);

        y->left = z->left;
        y->left->parent = y;

        y->color = z->color;
    }

    free(z);

    /* 只有真正移走的是 BLACK 才需要修复 */
    if (originalColor == BLACK)
    {
        deleteFixup(root, x);
    }
}
```


#### 1.3.6 中序遍历

```c
void inorder(RBNode *root)
{
    if (root == NIL)
        return;

    inorder(root->left);

    printf("%d(%c) ",
           root->key,
           root->color == RED
               ? 'R'
               : 'B');

    inorder(root->right);
}
```

#### 1.3.7 最终表格

这里给出一个删除对比表, 来自 ChatGPT, 也许有用:

| 操作  |       AVL 树        |    红黑树     |
| :---: | :-----------------: | :-----------: |
| 插入  |    最多 2 次旋转    | 最多 2 次旋转 |
| 删除  | 最坏 $O(\log N)$ 次旋转 | 最多 3 次旋转 |

再给出一个对比表:

|   特点   |     AVL 树     |         红黑树         |
| :------: | :------------: | :--------------------: |
| 平衡要求 |     更严格     |         更宽松         |
|   树高   |    通常更低    | 最多约为理想高度的两倍 |
|   查找   |    通常稍快    |      也是 $O(\log N)$      |
| 插入删除 |    调整较多    |      旋转通常较少      |
| 额外信息 | 高度或平衡因子 |        1 位颜色        |
| 典型用途 |  查找特别频繁  |    动态插入删除频繁    |

### 1.4 B+ Trees

我们希望一个结点一次存放很多关键字和很多孩子指针, 因此 B+ Trees 就是来干这个的;


**引理: B+ Trees 的阶(Order)**

我们记一棵 B+ Trees 的阶为 M, 也就是说, 内部节点最多有 M 个孩子.

**NOTE:**

另外, 这也意味着一个内部节点最多拥有 M - 1 个分隔关键字.


#### 1.4.1 B+ Trees 的结构性质

1. 对于任何根节点, 其可以本身就是叶子节点, 也可以拥有 2 ~ M 个孩子;

2. 对于任意内部非根节点, 其拥有 ⌈M/2⌉ ~ M 个孩子, 即至少半满.

另外, B+ 树所有叶节点都处在同一层, 即所有真实数据**叶结点**都处在同一层, 所以 B+ 树是一棵严格的高度平衡树.

同时, 按本课件的容量约定, 每个**非根叶节点中的记录数**在 $\lceil M/2\rceil$ 到 $M$ 之间. 这里说的是一个叶节点里有多少条记录, 不是整棵树有多少个叶节点;根本身为叶时可少于该下限.

> [!NOTE]
>
> 有些教材另用 $L$ 表示叶容量. 本节沿用 PPT 的 $L=M$, 因此内部节点最多 $M-1$ 个分隔键, 叶节点最多 $M$ 条记录.

#### 1.4.2 节点存储值

1. **内部节点**

假如一个内部节点有四个孩子: P0,P1,P2,P3, 那么该节点存储 3 个分隔关键字, 记为 K1,K2,K3, 这三个分隔关键字和 P0,P1,P2,P3 的对应关系如下:

- P0: key < K1;
- P1: K1 ≤ key < K2;
- P2: K2 ≤ key < K3;
- P3: key ≥ K3

2. **叶子节点**

> [!IMPORTANT]
>
> B+ Trees 的所有完整的数据记录都存放在叶结点中, 内部节点只存分隔关键字和子树指针.

叶子节点之间的链表类似 叶1 → 叶2 → 叶3 → 叶4 → ... 或 叶1 ⇄ 叶2 ⇄ 叶3 ⇄ 叶4;

例如查找 20≤key≤80 时, 只需要:

- 从根查找到第一个不小于 20 的叶结点;
- 沿叶子链表顺序向右扫描;
- 扫描到关键字大于 80 时停止.

#### 1.4.3 B+ Trees 的查找,插入和删除


1. **查找**

一般步骤是: 根 → 根据分隔关键字选择一个孩子 → 继续向下 → 到达叶结点 → 查找真实记录

2. **插入**

**(1) 基本过程**--插入关键字 X:

- 从根向下查找;
- 找到 X 应该进入的叶结点;
- 按顺序插入;
- 如果结点未溢出, 结束;
- 如果结点溢出, 将它分裂;
- 把新的分隔关键字插入父结点;
- 如果父结点也溢出, 继续向上分裂;
- 如果根溢出, 产生一个新根.

**(2) 未溢出的插入:** 

假设一个叶结点为:

<div class="note-center">10 | 20 | 40</div>

插入 30:

<div class="note-center">10 | 20 | 30 | 40</div>

如果叶结点最大允许 4 条记录, 那么没有溢出, 插入完成, 可能需要更新父结点中的分隔关键字, 但不需要分裂.

**(3) 叶结点分裂:** 

假设四阶 B+ 树的叶结点最多存放 4 条记录.

原叶结点:

<div class="note-center">10 | 20 | 30 | 40</div>

插入 25:

<div class="note-center">10 | 20 | 25 | 30 | 40</div>

出现 5 条记录, 超过容量, 需要分裂.

可以平分为:

<div class="note-center">左叶: 10 | 20</div>

<div class="note-center">右叶: 25 | 30 | 40</div>

然后把右叶中的最小关键字 25 **复制**到父结点中作为分隔值:

```
                                  25
                                 /  \
                          10 | 20    25 | 30 | 40
```

注意:

25 仍然保留在右叶中.

因为真实数据必须存放在叶结点中, 所以叶结点分裂时, 分隔关键字通常是复制到父结点而不是从叶子中彻底移走.

同时还要维护叶子链表:

<div class="note-center">左叶 → 右叶 → 原来的下一个叶</div>

**(4) 内部结点分裂:** 

如果向父结点插入新分隔值后, 父结点也超过最大容量, 就必须分裂内部结点.

例如某内部结点最多有 4 个孩子, 现在变成 5 个孩子:

<div class="note-center">P0,P1,P2,P3,P4</div>

应当把它分成左右两个内部结点, 并把中间分隔关键字提升到父亲.

与叶结点分裂的区别是:

- 叶结点分裂: 分隔键复制到父结点, 数据仍保留在叶子;
- 内部结点分裂: 中间分隔键通常上升到父结点, 用于分开左右两部分.

具体左右各分多少个孩子, 要按照课程规定的向上或向下取整规则进行, 但是总体原则是**尽量平均分配**

**(5) 根结点分裂:** 

如果原根结点也溢出:

<div class="note-center">原根: P0,P1,P2,P3,P4</div>

将原根分成两个结点, 并创建一个新根:

```
                 新根
                /    \
            左结点    右结点
```

此时树高增加 1.

B+ 树高度只会在根分裂时增加.

插入过程中, 无论发生多少次分裂, 所有叶结点仍然保持在同一深度.

3. **删除**

与插入正好相反, 插入处理的是节点过满 (overflow), 删除处理的是节点过空 (underflow).

(1) **删除后仍然满足最低容量**

那么直接从叶结点删除记录.

例如:

<div class="note-center">10 | 20 | 30</div>

删除 20:

<div class="note-center">10 | 30</div>

- 如果叶结点仍然至少半满, 操作结束;
- 如果删除的是某个子树最小关键字, 还需要更新祖先中的分隔关键字.

(2) **向兄弟借一个元素**

假设当前叶结点低于最低容量, 但相邻兄弟的元素数超过最低值.

例如最低要求 2 条:

<div class="note-center">当前叶: 10</div>
<div class="note-center">右兄弟: 20 | 30 | 40</div>

可以从右兄弟借出最小的 20:

<div class="note-center">当前叶: 10 | 20</div>
<div class="note-center">右兄弟: 30 | 40</div>

然后更新父结点中的分隔关键字, 这称为:

- 借位;
- 重新分配;
- redistribution.

类似地, cyll 的 PPT 在插入溢出时也提醒我们:

<div class="note-center">可以先找还有容量的兄弟, 重新分配后尽量让已有节点更满. </div>

删除时则反过来找有富余记录的兄弟, 并且借位或合并应在同一父节点下的相邻兄弟之间进行.

(3) **与兄弟合并**

如果当前结点元素不足, 而相邻兄弟也只有最低数量, 无法借出, 就进行合并.

例如:

<div class="note-center">当前叶: 10</div>
<div class="note-center">右兄弟: 20 | 30</div>

合并为:

<div class="note-center">10 | 20 | 30</div>

然后:

- 删除一个叶结点;
- 从父结点删除对应的分隔关键字和孩子指针;
- 修复叶子链表.

(4) **父结点也可能下溢**

合并会使父结点少一个孩子, 此时父结点可能也低于最小孩子数, 于是问题向上传递影响:

<div class="note-center">叶结点合并 → 父结点少一个孩子 → 父结点下溢 → 向父结点的兄弟借孩子或进行合并 → 可能一直传递到根</div>

(5) **根结点缩短**

如果删除后根结点只剩一个孩子, 可以删除旧根, 让唯一孩子成为新根:

<div class="note-center">旧根</div>
<div class="note-center">↓</div>
<div class="note-center">唯一孩子</div>

变成:

<div class="note-center">新根</div>

注意, 此时树高减少 1.

所以, 结论如下:

- B+ 树插入时, 根分裂会使高度增加;
- B+ 树删除时, 根只剩一个孩子会使高度减少.


#### 1.4.4 B+ Trees 的高度

我们假设阶为 $M\ge3$, 那么每个非根内部节点至少有 $\lceil M/2\rceil$ 个孩子(非叶根至少有 2 个), 因此树高为:

$$
O(\log_{\lceil M/2\rceil}N)
$$

显而易见地, 通常分支 M 越大, 树越矮.

#### 1.4.5 查找复杂度

我们设每个内部节点最多线性扫描 M 个位置, 那么复杂度是 $O(M)$;

此时我们取树高约为 $O(\log_M N)$, 则总成本为 $O(M\log_M N)$

> **没用的引理**
>
> $$
> \log_M N=\frac{\log N}{\log M}
> $$
>
> <s>懂的都懂, 不懂的也不必问了~</s>

所以:

$$
T(M, N) = O\left( \frac{M}{\log M} \log N \right)
$$

如果 M 被看作固定常数, 那么:

$$
\boxed{T_{\text{find}} = O(\log N)}
$$

插入和删除也只沿一条根到叶子的路径进行, 因此通常为:

$$
\boxed{O(\log N)}
$$

#### 1.4.6 泛谈阶的取值

在"每个结点线性扫描 $O(M)$"这一理论模型下, 需要考虑

$$
\frac{M}{\log M}
$$

它在 M 接近自然常数 $e\approx2.718$ 时较小, 因此整数中 3 或 4 是较好的选择, 不过在真实数据库和文件系统中, M 往往远大于 4, 因为实际目标是:

> <div class="note-center">让一个结点正好装满一个磁盘页, 尽量减少磁盘页面访问次数. </div>

#### 1.4.7 最终表格

最后, 同样是 ChatGPT 给的表, 也许有用:

|          特点          |         红黑树         |           B+ 树            |
| :--------------------: | :--------------------: | :------------------------: |
|        **类型**        |       二叉搜索树       |         多路搜索树         |
| **每个内部结点孩子数** |         最多 2         |          最多 (M)          |
|      **平衡方式**      |        颜色约束        | 所有叶子同层,结点至少半满 |
|      **数据存储**      | 每个真实结点都可存数据 |    完整数据集中在叶结点    |
|      **顺序扫描**      |      需要中序遍历      |       直接沿叶子链表       |
|        **树高**        |      $O(\log_2N)$      |        $O(\log_MN)$        |
|      **典型场景**      |        内存容器        | 数据库,文件系统,磁盘索引 |

## Chapter 2: Inverted File Index

### 2.1 Inverted File Index 是干什么的

#### 2.1.1 扫描所有网页

假设你需要查找一百万篇文档里面, 哪些文档出现了 computer science 的字样, 最笨的方法当然是先找第一篇, 再找第二篇......一直到第一百万篇. 

以上就是方法一, 即逐个扫描所有网页. 

A little sample: 

| 文档  |                     内容                     |
| :---: | :------------------------------------------: |
| Doc 1 |              Gold silver truck               |
| Doc 2 |      Shipment of gold damaged in a fire      |
| Doc 3 | Delivery of silver arrived in a silver truck |
| Doc 4 |     Shipment of gold arrived in a truck      |

后面的分析全部基于以上表格信息, 其中, 我们将这些字母全部转为小写. 

#### 2.1.2 词项-文档关联矩阵

这里我们引入方法二, 即 Term-Document Incidence Matrix, 也就是词项-文档关联矩阵. 

这里涉及到 AND 查询,即相当于某个词在某篇文档中出现则为 1,不出现则为 0,这样比如 1010 和 1011 取 & 得 1010,即文档一和文档三同时拥有这两个词.

C 语言实现非常简单,如下所示:

```c
#include <stdio.h>

int main(void)
{
    int silver[4] = {1, 0, 1, 0};
    int truck[4]  = {1, 0, 1, 1};

    int result[4];

    for (int i = 0; i < 4; i++) {
        result[i] = silver[i] && truck[i];
    }

    for (int i = 0; i < 4; i++) {
        if (result[i]) {
            printf("Doc %d\n", i + 1);
        }
    }

    return 0;
}
```

此时我要说,假如我有 10 亿篇文档,但是某个词出现的次数也就五十来次,这样就会出现将近 10 亿个 0,极其浪费空间.

既然如此,为什么还要保留 0,保留 1 不就行了.这就是我们要讲的 Inverted File Index.

#### 2.1.3 Inverted File Index 基本介绍

> Index is a mechanism for locating a given term in a text.
>
> -- 索引(Index)是一种用来定位某个词项的方法.
>
> Inverted file contains a list of pointers ... to all occurrences of that term in the text.
>
> -- 倒排文件保存某个词对应的所有出现位置,例如出现在哪些文档中.

倒排可以理解为不是文档->单词,而是单词->文档,如下理解:

```text
Doc1 -> gold silver truck

Doc2 -> shipment of gold damaged in a fire

Doc3 -> delivery of silver arrived in a silver truck

Doc4 -> shipment of gold arrived in a truck

// 以上是正排

gold     -> 1, 2, 4
silver   -> 1, 3
truck    -> 1, 3, 4
arrived  -> 3, 4
shipment -> 2, 4

// 以上是倒排
```

#### 2.1.4 Posting List

即 **倒排表 / 倒排列表**.

`silver -> 1 -> 3` 的 Posting List 即为 `1->3`.

所以整个结构可以变为:

```text
Term Dictionary
│
├── gold
│    └── 1 -> 2 -> 4
│
├── silver
│    └── 1 -> 3
│
├── truck
│    └── 1 -> 3 -> 4
│
└── arrived
     └── 3 -> 4
```

### 2.2 Inverted File Index 的实现

#### 2.2.1 基本结构体

```c
// 对于文档：
typedef struct DocNode 
{
    int doc_id;
    struct DocNode *next;
} DocNode;

// 对于文本：
typedef struct WordNode 
{
    char word[50];
    DocNode *docs;
    struct WordNode *next;
} WordNode;
```

即以下形态:

```text
WordNode
┌──────────────────────┐
│ word = "silver"      │
│ docs ───────┐        │
└─────────────│────────┘
              ↓
            Doc1
              ↓
            Doc3
              ↓
             NULL
```

于是整个形态就变成了如下的形式:

```text
                                Dictionary

// WordNode链表

       apple
         |
         | docs
         v
       Doc1 ---> Doc3
         
         |
         | next
         v

       banana
         |
         | docs
         v
       Doc2 ---> Doc3

         |
         | next
         v

       like
         |
         | docs
         v
       Doc1 ---> Doc2
```

#### 2.2.2 运作模式

其运作模式基本如下:

```c
while ( read a document D ) {

    while ( read a term T in D ) {

        if ( Find( Dictionary, T ) == false )

            Insert( Dictionary, T );

        Get T’s posting list;

        Insert a node to T’s posting list;
    }
}
```

- 其本质就是,遍历一篇文档,读取其中每个关键词;
  - 如果这个关键词并没有在字典出现,则加入;
  - 如果出现过则不加入;
- 二者均需要更新该词的 Posting List. 若每个 posting 代表一篇文档, 同一词在同一文档再次出现时应累计词频,追加位置, 不应重复创建相同的 doc_id;按 doc_id 递增处理文档可方便地保持列表有序.

> [!NOTE]
>
> 上面的链表字典只用于说明结构, `word[50]` 也只是简化示例. 实际实现要处理长度边界, 大词典通常使用哈希表或搜索树. 上方 Index Generator 是伪代码, 不是可直接编译的 C 程序.

### 2.3 更相关的 Times

#### 2.3.1 选更优的思想

假设现在有两篇文章,搜索的词在两篇文章中同时出现了,请问哪一篇文章和我想要的东西更相关.此时,简单的倒排已经无法解决这样的问题.

于是这里引入了 Times,即某个词在某篇文章中出现的次数,例如:

```text
gold

Doc1:1
Doc2:1
Doc4:1
```

以上沿用前面的四篇文档, gold 在 Doc 1,Doc 2,Doc 4 中各出现一次;而 silver 在 Doc 3 中出现两次, 所以可以记为 `Doc3:2`.

> [!CAUTION]
>
> Times 是一个相关性信号, 不能直接理解成"出现越多, 就一定越相关". 长文档本来就容易重复某个词, 而几乎每篇文档都有的词区分能力也很弱.

#### 2.3.2 Frequency 和 Position

我们需要区分三个东西:

| 信息 | 含义 | silver 的例子 |
| :--- | :--- | :--- |
| Document Frequency, $df$ | 有多少篇文档包含该词 | Doc 1,Doc 3, 所以 $df=2$ |
| Term Frequency, $tf$ | 在某一篇文档中出现多少次 | 在 Doc 3 中 $tf=2$ |
| Position | 在文档中的具体位置 | Doc 3 的第 3,7 个词, 按原文从 1 开始数 |

如果想显示原句,突出关键词, 或者检查 `computer science` 是否作为短语出现, 只知道 doc_id 就不够了, 还需要位置,偏移量等信息.

> [!IMPORTANT]
>
> `computer AND science` 只要求两个词出现在同一文档中;短语查询还要求顺序与相邻位置匹配. 对两个 Posting List 求交只能得到候选文档, 不能直接证明短语出现.

#### 2.3.3 两个 Posting List 怎么求交

对按 doc_id 递增排列的列表, 用两个指针即可:

1. 相等, 说明这篇文档同时包含两个词, 输出并同时后移;
2. 不相等, 较小的一侧后移;
3. 某一侧结束, 交集查找结束.

例如 `silver: [1,3]` 和 `truck: [1,3,4]`, 交集就是 `[1,3]`.

设两个列表长度分别为 $m,n$, 总时间为 $O(m+n)$. OR 查询对应并集, NOT 则需要明确文档全集, 或者在已有候选集合中做差集.

### 2.4 Index Generator 中的几个细节

> 对应 `ADS03InvFileInd_Stu.ppt` 第 7~10 页.

#### 2.4.1 Token Analyzer,Stemming 和 Stop Words

建立索引前, 我们并不是看到一段字符就直接塞进去, 而是要先处理:

```text
原始文档 → 切词 / 规范化 → 停用词过滤 → 查找或新增词项 → 更新 Posting List
```

- **Token Analyzer**: 把文本分成词项, 处理大小写,标点等;
- **Word Stemming**: 将不同词形归并, 如 `processing / processed / processes` 归到 `process`;
- **Stop Words**: 对 `a / the / it` 这类非常常见,区分能力弱的词, 可以选择不建立普通词项索引.

> [!CAUTION]
>
> 建索引和处理查询要使用一致的规则, 否则文档存了 `process`, 查询却拿 `processing` 原样去找, 就对不上了.
>
> 停用词也不是任何场景都没用. 短语,书名等可能需要它们;若保留位置索引, 过滤后也应保留原始位置间隔, 避免制造错误的"相邻".

#### 2.4.2 Dictionary 用树还是 Hashing

| 方案 | 查找特点 | 需要注意 |
| :--- | :--- | :--- |
| 平衡搜索树 | $V$ 个词项时, 通常需要 $O(\log V)$ 次键比较 | 支持有序遍历,范围查询 |
| Hashing | 合理哈希和负载因子下, 精确查询期望 $O(1)$ 次探查 | 最坏可退化, 不直接支持有序范围查询 |
| Trie | 查找主要取决于词长 | 方便前缀查询, 要考虑节点空间 |

这里的复杂度还没有把字符串比较,计算哈希的词长成本全部展开. 不能简单地认为 Hashing 在所有情况下都比树快.

#### 2.4.3 内存放不下怎么办

当然不能等全部文档都处理完才发现内存炸了. 课件的方法是**分块建立索引, 再归并**:

1. 在内存中建立一个 Block Index;
2. 接近内存上限时, 将该块按词项,doc_id 等顺序写入磁盘, 清空工作内存;
3. 继续读文档, 重复上述过程;
4. 输入结束时, 将最后一块尚未写出的内容也写入磁盘;
5. 归并各个有序块, 合并相同词项的 Posting List.

> [!WARNING]
>
> 最后一块即使没有"装满", 也必须写出去. 同一文档可能跨块, 归并时还要合并相同 `(term, doc_id)` 的词频和位置, 不能把它们算成两篇文档.

### 2.5 索引变大,变动之后

> 对应课件第 11~14 页.

#### 2.5.1 Distributed Indexing

| 划分方式 | 每台机器保存什么 | 查询过程 |
| :--- | :--- | :--- |
| Term-partitioned | 一部分词项及其 Posting List | 将不同查询词发给负责的机器, 再合并结果 |
| Document-partitioned | 一部分文档的完整倒排索引 | 各文档分片执行查询, 汇总各自结果 |

按词分, 要处理多词查询的通信与热门词负载;按文档分, 通常要向多个分片查询, 再统一合并和排序.

#### 2.5.2 Dynamic Indexing

文档并不是一次性全部到齐的, 所以可以维护:

```text
Main Index       → 已有的大索引
Auxiliary Index  → 新增文档的小索引
删除标记          → 哪些 doc_id 已失效
```

查询时同时查主索引与辅助索引, 合并结果并过滤删除标记;辅助索引积累到一定规模后再与主索引归并.

修改文档可理解成"旧版本失效 + 新版本加入", 要避免两个版本同时作为有效结果返回. 何时重建或归并取决于更新量,空间和查询成本, 并没有一个固定通用的时间间隔.

#### 2.5.3 Compression

课件给出了两类直观压缩方法:

1. **Dictionary 压缩**: 将词拼接保存, 通过偏移量或长度找到各个词, 减少固定长度字段的浪费;
2. **Posting List 压缩**: 对递增的 doc_id 存差值, 即 Gap Encoding.

例如:

```text
doc_id:  2, 15, 47, 100
gap:     2, 13, 32, 53
```

解码时前缀累加即可恢复原编号. 差值通常比完整编号小, 配合变长编码可以节省空间;如果仍然给每个差值固定分配相同的 32 位, 则仅仅做减法不会自动减少存储量.

#### 2.5.4 Thresholding

<details style="--wi-box-color:var(--wi-question);--wi-box-bg:var(--wi-question-bg)"><summary>索引已经有了, 能不能再少查一点?</summary><p>可以, 但要先想清楚: 少查的部分会不会改变答案. </p></details>

- **Document Thresholding**: 按权重排序, 只考虑排名靠前的 $x$ 篇候选文档;
- **Query Thresholding**: 按词项频率升序排列查询词, 优先处理较稀有的词, 并只使用原查询中的一部分词.

> [!CAUTION]
>
> 课件这里讲的是截断近似, 可能遗漏相关文档. 对要求精确集合语义的 Boolean Query, 不能随意丢掉词项或候选文档.
>
> "先处理较短的 Posting List"与"只处理部分词项"也不同: 前者只是改变求交顺序, 后者可能改变最终答案.

### 2.6 如何评价搜索结果

> 对应课件第 15~18 页.

#### 2.6.1 快不快, 与找得对不对

评价指标包括索引构建速度,查询延迟,索引空间,查询语言的表达能力, 以及答案的相关性.

要测相关性, 至少需要一套文档集合,一组查询, 以及每个"查询-文档"是否相关的标注. 相关性不能仅凭关键词是否出现来认定.

#### 2.6.2 Precision 和 Recall

| | Relevant | Irrelevant |
| :--- | :---: | :---: |
| Retrieved | $RR$ | $IR$ |
| Not Retrieved | $RN$ | $IN$ |

$$
\mathrm{Precision}=\frac{RR}{RR+IR},\qquad
\mathrm{Recall}=\frac{RR}{RR+RN}
$$

> [!TIP]
>
> Precision: **找出来的里面, 有多少是对的?**
>
> Recall: **本来应该找出来的, 实际找到了多少?**

例如找出 16 篇, 其中 4 篇相关, 而全部相关文档共有 12 篇, 则:

$$
P=\frac4{16}=25\%,\qquad R=\frac4{12}\approx33.3\%
$$

高 Precision,低 Recall, 说明返回结果比较准, 但漏得多;高 Recall,低 Precision, 说明相关文档大多找到了, 但夹杂的无关文档也多. 理想状态是两者都接近 1.

> [!NOTE]
>
> 分母为 0 时, 应按评测规则处理, 不能直接做除法. 提高相关性的方向包括使用词频与文档频率,考虑位置或短语,改进规范化和排序, 最后仍要在标注数据上比较结果.


## Chapter 3: Leftist Heaps and Skew Heaps

> 资料: <a href="/my_note/materials/ads/ADS04LeftistSkewH_Stu.ppt" download>ADS04LeftistSkewH_Stu.ppt</a>, 第 2~12 页.
>
> 本章默认讨论 Min-Heap, 即父节点的 key 不大于孩子的 key;$N$ 表示堆的节点数, 合并时表示两堆节点总数. 对数默认以 2 为底.

### 3.1 为什么还需要新的 Heap

#### 3.1.1 Binary Heap 的问题

之前的二叉堆已经能在 $O(\log N)$ 时间内完成 Insert 和 DeleteMin, 那么它哪里不够好?

> **问题: Merge**
>
> 现在有两个堆, 希望将它们合成一个. 如果仍要求完全二叉树的结构, 就不能简单地把两个根连起来完事.

将两个数组拼接后自底向上 BuildHeap, 可以在 $O(N)$ 时间内完成;逐个插入则有 $O(N\log N)$ 的一般上界. 我们希望合并比线性扫描更快.

#### 3.1.2 保留什么, 放弃什么

Heap 可以拆成两部分:

1. **Order Property**: 父节点不大于孩子, 最小值在根;
2. **Structure Property**: 普通 Binary Heap 要求完全二叉树.

Leftist Heap 保留堆序, 改变结构要求: 允许整棵树不平衡, 但把合并所走的**最右路径**控制得足够短.

> [!IMPORTANT]
>
> Heap 与 BST 的顺序要求不同. Heap 不要求"左小右大", 也不保证中序遍历有序;交换左右子树不会破坏父子间的堆序.

### 3.2 Leftist Heaps

#### 3.2.1 Null Path Length

先引入一个新指标, Null Path Length, 记为 $Npl(X)$:

> 从节点 X 出发, 到一个**没有两个孩子的节点**的最短路径长度, 按边数计. 约定 $Npl(NULL)=-1$.

因此:

$$
Npl(X)=1+\min\{Npl(X_L),Npl(X_R)\}
$$

叶节点,只有一个孩子的节点, $Npl$ 都是 0;左右孩子均为叶时, 父节点的 $Npl$ 为 1.

```text
      A                 B                 C
                       /                 / \
                      D                 E   F

  Npl(A)=0          Npl(B)=0           Npl(C)=1
```

> [!CAUTION]
>
> Npl 不是树高. 树高取最长路径, Npl 取到"缺孩子的节点"的最短路径;一条很长的单链, 每个节点的 Npl 仍然可以全是 0.
>
> 如果改为数到空指针的距离, 会比这里的 Npl 多 1. 做题时先看约定.

#### 3.2.2 Leftist Property

对于堆中每个节点 X, 都要求:

$$
Npl(X_L)\ge Npl(X_R)
$$

也就是说, 左边的"最短缺口"不能比右边更近. 于是最短路径总可以选择向右走, 得到:

$$
\boxed{Npl(X)=Npl(X_R)+1}
$$

<details style="--wi-box-color:var(--wi-question);--wi-box-bg:var(--wi-question-bg)"><summary>Leftist 是说左子树一定更高,节点一定更多吗?</summary><p>都不是. 比较的是 Npl, 不是 Height, 也不是 Size. 右子树可以有很多节点, 只要它的 Npl 不超过左边即可. </p></details>

一个有用的小结论: **如果左孩子为空, 右孩子也必须为空**, 否则左边 Npl 为 -1, 右边至少为 0, 直接违反左式性质.

#### 3.2.3 为什么右路径只有对数长

定义 Right Path 为从根开始, 一直沿右孩子走到空指针之前经过的非空节点序列. 若有 $r$ 个节点, 则:

$$
r=Npl(root)+1
$$

> **定理**
>
> 一棵右路径有 $r$ 个节点的左式树, 至少包含 $2^r-1$ 个节点.

证明可以直接归纳:

1. $r=0$ 时为空树, 节点数为 $0=2^0-1$;
2. $r\ge1$ 时, 右子树的右路径有 $r-1$ 个节点;
3. 左子树 Npl 不小于右子树, 因而左子树的右路径也至少有 $r-1$ 个节点;
4. 加上根, 节点数至少为 $1+2(2^{r-1}-1)=2^r-1$.

于是:

$$
N\ge2^r-1\quad\Longrightarrow\quad r\le\log_2(N+1)
$$

> [!IMPORTANT]
>
> 我们限制的是右路径, 不是整棵树高. 左式堆完全可以是一条向左的长链, 树高为 $N-1$, 但右路径仅包含根一个节点.

#### 3.2.4 Merge 的递归思想

假设两个堆为 H1,H2:

1. 某个堆为空, 直接返回另一个;
2. 比较根, 让较小的根作为 H1;
3. 将 `H1->Right` 与 H2 合并, 结果接回 `H1->Right`;
4. 如果左孩子 Npl 小于右孩子, 交换左右孩子;
5. 更新根的 Npl, 返回 H1.

> 可以理解为: **先保住堆序, 再修复左式性质**. 递归只沿右边走, 左子树整棵保留, 因而不用扫描所有节点.

下面给出核心实现, 包括空堆和单节点情况:

```c
#include <stdio.h>
#include <stdlib.h>

typedef struct LeftistNode
{
    int Element;
    struct LeftistNode *Left;
    struct LeftistNode *Right;
    int Npl;
} LeftistNode, *PriorityQueue;

int getNpl(PriorityQueue H)
{
    return H == NULL ? -1 : H->Npl;
}

void SwapChildren(PriorityQueue H)
{
    PriorityQueue temp = H->Left;
    H->Left = H->Right;
    H->Right = temp;
}

PriorityQueue Merge(PriorityQueue H1, PriorityQueue H2)
{
    if (H1 == NULL) return H2;
    if (H2 == NULL) return H1;

    if (H1->Element > H2->Element)
    {
        PriorityQueue temp = H1;
        H1 = H2;
        H2 = temp;
    }

    H1->Right = Merge(H1->Right, H2);
    if (getNpl(H1->Left) < getNpl(H1->Right))
        SwapChildren(H1);

    H1->Npl = getNpl(H1->Right) + 1;
    return H1;
}

PriorityQueue Insert(PriorityQueue H, int x)
{
    PriorityQueue node = malloc(sizeof(*node));
    if (node == NULL) exit(EXIT_FAILURE);
    node->Element = x;
    node->Left = node->Right = NULL;
    node->Npl = 0;
    return Merge(H, node);
}

PriorityQueue DeleteMin(PriorityQueue H)
{
    if (H == NULL) return NULL;
    PriorityQueue left = H->Left;
    PriorityQueue right = H->Right;
    free(H);
    return Merge(left, right);
}
```

这里各章代码独立使用, 同名函数不应不加区分地拼在同一个源文件中. 堆的根可能改变, 调用时要写 `H = Insert(H, x)`,`H = DeleteMin(H)` 或 `H = Merge(H, other)`.

> [!WARNING]
>
> Merge 会重接原来的节点, 两个输入堆必须互不共享节点, 合并后也不能再把旧堆当作独立的堆使用. 这不是复制操作.
>
> Npl 必须在递归返回,必要交换之后更新. 忘记更新可能暂时不破坏堆序, 但之后的交换判断会依据错误信息, 对数时间保证也就没了.

#### 3.2.5 一个小例子

以下是便于手算的补充例子, 括号里标 Npl:

```text
H1:       3(1)           H2:     2(0)
         /    \                 /
       8(0)  10(0)            6(0)
```

先选 2 为根, 将它的空右子树与 H1 合并, 相当于把 H1 接到 2 的右边. 此时左右 Npl 分别为 0,1, 所以必须交换:

```text
              2(1)
             /    \
           3(1)   6(0)
          /    \
        8(0)  10(0)
```

注意 2 的 Npl 是右孩子的 Npl 加 1, 即 1;不能用整棵树的高度 2 代替.

#### 3.2.6 Merge 的迭代理解

课件第 7 页给了另一种理解:

1. 两条右路径由于堆序, 本来就是非递减序列;
2. 像归并两个有序链表一样, 合并它们, 暂时不动各节点原来的左子树;
3. 从合并路径末端向上回溯, 需要时交换孩子, 并更新 Npl.

这里的 Sort 不是再调用一次通用排序. 两条有序路径可以线性归并;路径总长度为 $O(\log N)$, 回溯也只处理这些节点. 实现时可用栈记录路径.

#### 3.2.7 Insert,DeleteMin 和 BuildHeap

- **FindMin**: 非空堆直接读根, $O(1)$;
- **Insert**: 把新元素当作单节点堆, 再 Merge, 最坏 $O(\log N)$;
- **DeleteMin**: 删除根, 合并左右子堆, 最坏 $O(\log N)$.

如果从 $N$ 个元素建堆, 逐次 Insert 的一般上界为 $O(N\log N)$;还可以把所有单节点堆入队, 每次取出两个合并, 再将结果入队.

为什么后者是 $O(N)$?先看 $N=2^K$ 的情形: 第 $k$ 轮有 $N/2^k$ 次合并, 每次成本为 $O(k)$, 包含单节点合并的常数成本. 因此:

$$
T(N)=O\left(\sum_{k=1}^{K}\frac{N}{2^k}k\right)
=O(N),\qquad \sum_{k=1}^{\infty}\frac{k}{2^k}=2
$$

一般 $N$ 下队列中的规模不一定处处相同, 不能硬说每个中间堆都恰有 $2^k$ 个节点;按合并规模分层计费仍可得到线性上界. 同时至少要处理所有元素, 所以这种 BuildHeap 为 $\Theta(N)$.

### 3.3 Skew Heaps

#### 3.3.1 为什么还要把 Npl 去掉

左式堆的 Merge 已经很好了, 但每个节点要存 Npl, 每次还要判断是否交换. Skew Heap 的想法更直接:

> 不维护 Npl. 每次真正参与递归合并的节点, 回来时都交换左右孩子.

这与前面的 Splay Trees 有相似之处: 不要求每个时刻结构都很好看, 只要求一系列操作的总成本可控.

> [!CAUTION]
>
> Skew Heap 保留堆序, 但不保证左式性质. 某次右路径可能有 $\Theta(N)$ 个节点, 所以单次 Merge 最坏可以是 $O(N)$.

#### 3.3.2 Merge 的实现

```c
typedef struct SkewNode
{
    int Element;
    struct SkewNode *Left;
    struct SkewNode *Right;
} SkewNode, *SkewHeap;

SkewHeap SkewMerge(SkewHeap H1, SkewHeap H2)
{
    if (H1 == NULL) return H2;
    if (H2 == NULL) return H1;

    if (H1->Element > H2->Element)
    {
        SkewHeap temp = H1;
        H1 = H2;
        H2 = temp;
    }

    H1->Right = SkewMerge(H1->Right, H2);

    SkewHeap temp = H1->Left;
    H1->Left = H1->Right;
    H1->Right = temp;
    return H1;
}
```

Insert 仍然是与单节点堆合并;DeleteMin 仍然是删除根后合并两个子堆.

<details style="--wi-box-color:var(--wi-question);--wi-box-bg:var(--wi-question-bg)"><summary>课件说右路径上最大的节点不交换, 是要单独找最大值吗?</summary><p>不用. 某个堆为空时直接返回另一个堆, 自然终止递归. 被整体接上的剩余子堆没有继续递归, 其中的节点都保持原样. 不要为了"无条件交换"再遍历整个剩余子堆. </p></details>

迭代版本也可以看作先归并右路径, 再交换实际处理过的路径节点的孩子;原左子树内部结构不变.

#### 3.3.3 为什么不是每次交换后都变成左式堆

沿用 3.2.5 的两个堆, 第一次交换后恰好得到左式堆, 但这是巧合. 若此时再插入 20:

```text
插入前:          2              插入后:        2
                / \                         / \
               3   6                       6   3
              / \                         /   / \
             8  10                       20  8  10
```

根 2 左子树的 Npl 为 0, 右子树的 Npl 为 1, 不满足 Leftist Property, 但仍然是合法的 Skew Heap.

#### 3.3.4 Heavy / Light 的定义

设 $s(X)$ 为以 X 为根的子树节点数, **包含 X 自身**, $s(NULL)=0$.

$$
\begin{aligned}
X\text{ is heavy}&\iff s(X_R)\ge\frac{s(X)}2,\\
X\text{ is light}&\iff s(X_R)<\frac{s(X)}2.
\end{aligned}
$$

这里的 heavy 是说右子树占了整个子树至少一半, 与 key 大小,Npl 都没有关系.

沿右路径经过一个 light 节点后, 剩余子树规模至少减半, 所以一条右路径上的 light 节点数为 $O(\log N)$;heavy 节点却可能很多.

#### 3.3.5 Potential Method 分析 Merge

> 对应课件第 11~12 页. 不想硬背的话, 先抓住一点: 贵的部分是右路径上很多 heavy 节点, 交换会把这些节点变 light.

取势能为当前所有堆中 heavy 节点的总数:

$$
\Phi(D)=\#\{\text{heavy nodes in }D\}
$$

这里把两个输入堆和输出堆放在同一个状态模型中, 合并前的势能是两堆之和.

设本次递归实际处理的路径节点中有 $l$ 个 light,$h$ 个 heavy, 其余未处理节点中共有 $q$ 个 heavy. 则实际成本按每个处理节点一个单位计, 为 $l+h+O(1)$.

对于一个原本 heavy 的节点, 设旧左右子树大小分别为 $L,R$, 则:

$$
R\ge\frac{1+L+R}{2}\quad\Longrightarrow\quad R\ge L+1
$$

合并后, 新左子树至少包含旧右子树, 大小记为 $R'\ge R$;交换后的新右子树则是旧左子树, 大小为 $L$. 因此:

$$
L<\frac{1+L+R'}2
$$

该节点一定变成 light. 原本 light 的节点则可能变 heavy, 最多新增 $l$ 个;未参与递归的子树内部状态不变.

$$
\Phi_{before}=h+q,\qquad \Phi_{after}\le l+q
$$

所以:

$$
\hat c=c+\Delta\Phi
\le(l+h)+(l-h)+O(1)
=2l+O(1)=O(\log N)
$$

> [!IMPORTANT]
>
> 这里数的是**实际处理的右路径前缀**, 不包含递归终止后整体接上的剩余子堆. 它们中的 heavy 节点没有被交换, 也就不能算作已经消耗的势能.

Insert 只额外创建一个 light 的单节点堆;DeleteMin 删除根后, 其他节点的子树大小不变, 再调用 Merge. 因而这两种操作的摊还复杂度也为 $O(\log N)$.

从空堆开始, 势能初始为 0 且始终非负, $M$ 次操作的总时间为 $O(M\log(N+1))$, 其中 $N$ 为过程中节点数的上界. 若直接从任意已有堆开始, 则还需计入初始势能.

### 3.4 最终表格

| 特点 / 操作 | Leftist Heap | Skew Heap |
| :--- | :--- | :--- |
| 基本要求 | 堆序 + 左式性质 | 堆序 |
| 额外维护 | Npl | 无 Npl |
| 交换孩子 | 左 Npl 小于右 Npl 时 | 每个实际参与合并的节点都交换 |
| 右路径长度 | 最坏 $O(\log N)$ | 最坏 $O(N)$ |
| FindMin | $O(1)$ | $O(1)$ |
| Merge / Insert / DeleteMin | 单次最坏 $O(\log N)$ | 单次最坏 $O(N)$, 摊还 $O(\log N)$ |

> [!TIP]
>
> 做合并题时, 先圈出原来的右路径, 再按根的大小递归处理. 左式堆回溯时看 Npl, 斜堆回溯时直接交换. 两者都不需要重新排列每个原左子树内部的节点.

## Chapter 4: Binomial Queues

> 资料: <a href="/my_note/materials/ads/ADS05BinomialQ_Stu.ppt" download>ADS05BinomialQ_Stu.ppt</a>, 第 2~13 页.
>
> 本章同样讨论 Min-Priority Queue. Binomial Queue 虽然叫 Queue, 但不是先进先出的 FIFO 队列.

### 4.1 为什么还要 Binomial Queue

#### 4.1.1 我们想要更便宜的 Insert

前面的堆已经让 Merge 达到对数级别. 二项队列还希望做到:

> Merge,DeleteMin 最坏 $O(\log N)$, 而 Insert 的摊还成本为 $O(1)$.

解决方法不是继续要求一棵树更平衡, 而是允许整个优先队列由**一片森林**组成.

> [!CAUTION]
>
> 普通二叉堆自底向上 BuildHeap 为 $O(N)$;逐次插入任意给定的 $N$ 个键, 最坏仍为 $\Theta(N\log N)$. 课件开头关于 binary heap 的平均插入讨论, 不能当作任意输入下的最坏保证. 本章要证明的是二项队列连续插入的确定性总成本为 $O(N)$.

#### 4.1.2 Binomial Tree 的递归定义

- $B_0$: 只有一个节点;
- $B_k$: 将两棵 $B_{k-1}$ 合并, 把一棵的根接成另一棵根的孩子.

```text
B0:    o       B1:    o       B2:     o
                      |              / \
                      o             o   o
                                    |
                                    o
```

注意这是一种多叉树. $B_k$ 的根可以有 $k$ 个孩子, 不能因为后面使用两个指针存储, 就把它当作普通二叉树.

#### 4.1.3 为什么叫 Binomial

由定义可得:

| 性质 | $B_k$ |
| :--- | :--- |
| 高度, 按边计 | $k$ |
| 节点数 | $2^k$ |
| 根的孩子数 | $k$ |
| 根的各个子树 | 各一棵 $B_0,B_1,\ldots,B_{k-1}$ |
| 深度 $d$ 的节点数 | $\binom{k}{d}$, 其中 $0\le d\le k$ |

最后一项可以用组合数递推解释: 合并两棵 $B_{k-1}$ 后, 一棵深度不变, 另一棵整体加深一层, 所以:

$$
\binom{k}{d}=\binom{k-1}{d}+\binom{k-1}{d-1}
$$

而所有层的节点数之和为:

$$
\sum_{d=0}^{k}\binom{k}{d}=2^k
$$

这就是 Binomial, 即二项式系数, 名字的来源.

### 4.2 一片森林如何表示一个队列

#### 4.2.1 结构要求

> [!IMPORTANT]
>
> 二项队列 = 每棵树是 Binomial Tree + 每棵树满足堆序 + **同一阶数至多保留一棵树**.

设 $N=13$, 则:

$$
13=(1101)_2=2^3+2^2+2^0
$$

因此这个队列包含 $B_3,B_2,B_0$, 不包含 $B_1$:

```text
阶数:        0      1      2      3
TheTrees:   B0     NULL    B2     B3
节点数:      1      0      4      8
```

<details style="--wi-box-color:var(--wi-question);--wi-box-bg:var(--wi-question-bg)"><summary>课件说表示唯一, 是整片森林里的 key 排列唯一吗?</summary><p>不是. 唯一的是由 N 的二进制展开决定的"包含哪些阶数". 同一组 key 可以有不同的合法堆序排列. </p></details>

#### 4.2.2 根的数量

对于 $N>0$, 最大阶数为 $\lfloor\log_2N\rfloor$, 因此最多有:

$$
\lfloor\log_2N\rfloor+1
$$

个根, 实际数量等于 N 的二进制表示中 1 的个数, 记为 $\operatorname{popcount}(N)$.

> [!NOTE]
>
> 不要直接写"至多 $\lceil\log_2N\rceil$ 个根"而忽略 $N=1$ 的边界. 复杂度同为 $O(\log(N+1))$, 但准确计数要分清楚.

### 4.3 基本操作

#### 4.3.1 FindMin

每棵树的最小值都在自己的根, 因此只扫描所有根, 就能找出全局最小值, 时间 $O(\log N)$.

如果额外缓存最小根指针, 并在修改时维护, FindMin 可以是 $O(1)$;删除最小根之后仍然需要寻找新的最小根.

#### 4.3.2 CombineTrees

两棵**相同阶数**的 $B_k$ 可以合成一棵 $B_{k+1}$:

1. 比较两个根的 key;
2. 较小的根保留为根;
3. 较大的根接成它的一个孩子.

只比较根,修改几个指针, 因而一次 CombineTrees 为 $O(1)$.

> [!WARNING]
>
> CombineTrees 合并两棵同阶树, Merge 合并两整个队列. 这两个操作不是一回事, 不同阶的两棵树不能直接 Combine 成一棵二项树.

#### 4.3.3 Merge 就是二进制加法

按阶数从低到高处理, 当前位可能有三棵树:

- H1 中的 $B_i$;
- H2 中的 $B_i$;
- 前一位传来的 Carry, 也是 $B_i$.

| Carry | H2 | H1 | 当前位留下什么 | 向下一位传什么 |
| :---: | :---: | :---: | :--- | :--- |
| 0 | 0 | 0 | 空 | 无 |
| 0 | 0 | 1 | H1 的树 | 无 |
| 0 | 1 | 0 | H2 的树 | 无 |
| 1 | 0 | 0 | Carry | 无 |
| 0 | 1 | 1 | 空 | Combine(H1, H2) |
| 1 | 0 | 1 | 空 | Combine(H1, Carry) |
| 1 | 1 | 0 | 空 | Combine(H2, Carry) |
| 1 | 1 | 1 | 原 Carry | Combine(H1, H2) |

其中 `111` 最容易写错: $1+1+1=3=(11)_2$, 所以当前位保留一棵, 再向高一位进一棵.

例如课件中的 $6+7$:

```text
    0110   (B1 + B2)
  + 0111   (B0 + B1 + B2)
  ------
    1101   (B0 + B2 + B3)
```

- 第 0 位只有一棵, 直接留下;
- 第 1 位两棵 $B_1$ 合成 Carry $B_2$;
- 第 2 位三棵 $B_2$, 留一棵, 另外两棵合成 $B_3$;
- 第 3 位接收 Carry.

总共处理 $O(\log N)$ 个阶数, 每位至多一次常数时间的 Combine, 因此 Merge 为 $O(\log N)$.

#### 4.3.4 Insert

插入就是把一个 $B_0$ 加进森林, 相当于二进制计数器加 1.

设最小的空位是 $B_i$, 则低位 $B_0$ 到 $B_{i-1}$ 都已经存在, 插入需要连续进位 $i$ 次, 再将结果放入第 $i$ 位, 成本为 $O(i+1)$.

```text
插入后元素个数       队列中存在的树       本次 Combine 次数
       1                  B0                    0
       2                  B1                    1
       3                  B1, B0                0
       4                  B2                    2
       5                  B2, B0                0
       6                  B2, B1                1
       7                  B2, B1, B0            0
       8                  B3                    3
```

单次最坏仍为 $O(\log N)$, 但很多次只需要放入一个 $B_0$, 所以有机会把摊还成本降到常数.

#### 4.3.5 DeleteMin

假设最小根位于 $B_k$, 过程如下:

1. 扫描所有根, 找到它;
2. 从原队列中取出整棵 $B_k$, 剩余森林记为 H';
3. 删除 $B_k$ 的根, 其孩子恰好构成 $B_{k-1},\ldots,B_0$, 组成新队列 H'';
4. Merge(H', H'').

节点数要分别算清楚:

$$
|H'|=N-2^k,\qquad |H''|=2^k-1
$$

所以最后总数正好为 $N-1$. 找最小根,拆子树,合并均至多 $O(\log N)$, 总时间仍为 $O(\log N)$.

### 4.4 代码实现

#### 4.4.1 Left-Child / Next-Sibling

多叉树可以用**最左孩子-下一个兄弟**表示:

```text
root
  |
  LeftChild
  v
B(k-1) --NextSibling--> B(k-2) --> ... --> B0 --> NULL
```

每次 Combine 把新孩子接到孩子链表头部, 新接的子树阶数最大, 所以孩子按照阶数递减排列. 删除根时沿兄弟链走, 按 $k-1,k-2,\ldots,0$ 放回数组即可.

> [!CAUTION]
>
> `NextSibling` 指向兄弟, 不是右孩子. 拆出子树时必须先保存下一个兄弟, 再把当前根的 `NextSibling` 断开, 否则会丢链或让两棵树仍然串在一起.

以下代码使用固定容量数组说明算法, `CurrentSize` 使用无符号宽整数;FindMin 和 DeleteMin 通过返回值表示成功与否, 避免用某个合法 key 冒充 Infinity.

```c
#include <stdint.h>
#include <stdio.h>
#include <stdlib.h>

#define MAX_TREES 32
#define CAPACITY ((UINT64_C(1) << MAX_TREES) - 1)

typedef struct BinNode
{
    int Element;
    struct BinNode *LeftChild;
    struct BinNode *NextSibling;
} BinNode, *BinTree;

typedef struct Collection
{
    uint64_t CurrentSize;
    BinTree TheTrees[MAX_TREES];
} Collection, *BinQueue;

BinTree CombineTrees(BinTree T1, BinTree T2)
{
    if (T1->Element > T2->Element)
    {
        BinTree temp = T1;
        T1 = T2;
        T2 = temp;
    }
    T2->NextSibling = T1->LeftChild;
    T1->LeftChild = T2;
    return T1;
}

/* H1、H2 是不同队列, 且互不共享节点. 成功后 H2 变为空队列. */
int BinMerge(BinQueue H1, BinQueue H2)
{
    if (H1 == H2 || H2->CurrentSize > CAPACITY - H1->CurrentSize)
        return 0;

    uint64_t total = H1->CurrentSize + H2->CurrentSize;
    BinTree Carry = NULL;

    for (int i = 0; i < MAX_TREES && (UINT64_C(1) << i) <= total; i++)
    {
        BinTree T1 = H1->TheTrees[i];
        BinTree T2 = H2->TheTrees[i];
        int state = !!T1 + 2 * !!T2 + 4 * !!Carry;

        switch (state)
        {
            case 0:
            case 1:
                break;
            case 2:
                H1->TheTrees[i] = T2;
                H2->TheTrees[i] = NULL;
                break;
            case 4:
                H1->TheTrees[i] = Carry;
                Carry = NULL;
                break;
            case 3:
                Carry = CombineTrees(T1, T2);
                H1->TheTrees[i] = H2->TheTrees[i] = NULL;
                break;
            case 5:
                Carry = CombineTrees(T1, Carry);
                H1->TheTrees[i] = NULL;
                break;
            case 6:
                Carry = CombineTrees(T2, Carry);
                H2->TheTrees[i] = NULL;
                break;
            case 7:
                H1->TheTrees[i] = Carry;
                Carry = CombineTrees(T1, T2);
                H2->TheTrees[i] = NULL;
                break;
        }
    }
    H1->CurrentSize = total;
    H2->CurrentSize = 0;
    return 1;
}

/* 专门实现插入: 遇到首个空位就停止, 不扫描无关高位. */
int BinInsert(BinQueue H, int x)
{
    if (H->CurrentSize == CAPACITY) return 0;
    BinTree Carry = malloc(sizeof(*Carry));
    if (Carry == NULL) return 0;
    Carry->Element = x;
    Carry->LeftChild = Carry->NextSibling = NULL;

    int i = 0;
    while (H->TheTrees[i] != NULL)
    {
        Carry = CombineTrees(H->TheTrees[i], Carry);
        H->TheTrees[i] = NULL;
        i++;
    }
    H->TheTrees[i] = Carry;
    H->CurrentSize++;
    return 1;
}

int MinTreeIndex(BinQueue H)
{
    int best = -1;
    for (int i = 0; i < MAX_TREES &&
         (UINT64_C(1) << i) <= H->CurrentSize; i++)
    {
        if (H->TheTrees[i] != NULL &&
            (best == -1 || H->TheTrees[i]->Element < H->TheTrees[best]->Element))
            best = i;
    }
    return best;
}

/* 调用者提供有效的 out 指针. 空队列返回 0, 不改写 *out. */
int BinFindMin(BinQueue H, int *out)
{
    int k = MinTreeIndex(H);
    if (k == -1) return 0;
    *out = H->TheTrees[k]->Element;
    return 1;
}

int BinDeleteMin(BinQueue H, int *out)
{
    int k = MinTreeIndex(H);
    if (k == -1) return 0;

    BinTree oldRoot = H->TheTrees[k];
    BinTree child = oldRoot->LeftChild;
    *out = oldRoot->Element;
    H->TheTrees[k] = NULL;
    free(oldRoot);

    Collection deleted = {0};
    deleted.CurrentSize = (UINT64_C(1) << k) - 1;
    for (int j = k - 1; j >= 0; j--)
    {
        BinTree next = child->NextSibling;
        deleted.TheTrees[j] = child;
        child->NextSibling = NULL;
        child = next;
    }

    H->CurrentSize -= UINT64_C(1) << k;
    return BinMerge(H, &deleted);
}
```

队列可用 `Collection H = {0};` 初始化, 再调用 `BinInsert(&H, x)`. 用 `BinMerge(&H1, &H2)` 合并后, H2 的节点归 H1 管理, H2 为空.

这里 `MAX_TREES=32` 的数组本身是固定常数大小;算法分析把可用阶数视为随问题规模增长, 活跃阶数为 $O(\log N)$. 若实现可增长数组, 还需把扩容费用计入分析.

#### 4.4.2 代码中容易漏掉的地方

1. `case 7` 要先保留旧 Carry, 再产生新 Carry;
2. 从 H2 移走的指针要清空, 最后也要把 H2 的 `CurrentSize` 清零;
3. DeleteMin 暂时减去的是整棵 $B_k$ 的 $2^k$ 个节点, 再合并回 $2^k-1$ 个;
4. `1 << k` 若用普通有符号 int, 大阶数时可能溢出;这里使用 `UINT64_C(1) << k` 并限制阶数;
5. 新队列数组必须初始化为空, 不能留下随机指针;
6. Insert 要在进位结束后立即停止. 如果每次机械调用扫描所有活跃位的通用 Merge, 就不能直接套用下面的常数摊还证明.

### 4.5 为什么 Insert 的摊还成本是 O(1)

#### 4.5.1 Aggregate Analysis

从空队列开始连续插入 $N$ 次:

- 每次先新建一棵树, 共创建 $N$ 棵;
- 每次 Combine 将两棵变成一棵, 森林中的树数减少 1;
- 最后剩下 $\operatorname{popcount}(N)$ 棵树.

因此整个过程中 Combine 的总次数恰好为:

$$
N-\operatorname{popcount}(N)<N\qquad(N>0)
$$

连同每次插入的常数工作, 总成本为 $\Theta(N)$, 每次摊还 $O(1)$.

例如插入 1~8, 合并次数为 $0+1+0+2+0+1+0+3=7$, 恰好等于 $8-1$.

#### 4.5.2 Potential Method

定义势能为森林中树的数量:

$$
\Phi(H)=\#\{\text{trees in }H\}
$$

若一次插入合并了 $t$ 次, 则:

$$
c=t+1,\qquad \Delta\Phi=1-t
$$

于是:

$$
\hat c=c+\Delta\Phi=(t+1)+(1-t)=2=O(1)
$$

这正好对应课件中的另一种写法: 成本为 $c$ 的插入, 树的净增加数为 $2-c$.

> [!TIP]
>
> 便宜的插入多留下一棵树, 势能增加;贵的插入一路进位, 消掉很多树, 势能减少. 这与二进制计数器连续加 1 的分析基本一致.

从空队列开始 $\Phi_0=0$, 结束时 $\Phi_N\ge0$, 所以:

$$
\sum_{i=1}^{N}c_i
=\sum_{i=1}^{N}\hat c_i-\Phi_N+\Phi_0
\le2N
$$

这里的 2 是按"每次链接一个单位,每次插入固定工作一个单位"的抽象模型算出的常数, 不是说 CPU 只执行两条指令.

### 4.6 最终表格

| 操作 | 单次最坏时间 | 说明 |
| :--- | :--- | :--- |
| CombineTrees | $O(1)$ | 仅合并两棵同阶二项树 |
| FindMin | $O(\log N)$ | 缓存最小根后可为 $O(1)$ |
| Merge | $O(\log N)$ | 按阶数做二进制加法 |
| Insert | $O(\log N)$ | 专门的进位插入实现, 摊还 $O(1)$ |
| DeleteMin | $O(\log N)$ | 找根,拆树,合并 |
| 从空队列连续插入 $N$ 次 | $\Theta(N)$ | 总时间的最坏界, 不依赖随机输入 |

最后可以把这三类可合并堆的思想对应起来:

- Leftist Heap: 用 Npl 保证右路径短;
- Skew Heap: 不存 Npl, 通过交换把昂贵操作的成本摊还掉;
- Binomial Queue: 按二进制组织一片森林, 用进位完成合并与插入.


## Chapter 6: Practice

### 6.1 判断题 && 单选题

本节保留已有 Week 1-4 题干和选项. Week 1.4 为中文整理版, Week 1.5 仅保留了题意和答案; 未恢复到的完整英文题干、选项与原图不补造.

#### Week 1.1

If the depth of an AVL tree is 6 (the depth of an empty tree is defined to be -1), then the minimum possible number of nodes in this tree is:

A. 13  
B. 17  
C. 20  
D. 33

**答案: D**

**解析:**  AVL 树达到给定高度时, 最少结点数满足

$$
N(h)=N(h-1)+N(h-2)+1
$$

其中 $N(-1)=0,\ N(0)=1$. 依次得到

$$
N(1)=2,\ N(2)=4,\ N(3)=7,\ N(4)=12,\ N(5)=20,\ N(6)=33
$$

因此答案为 33.

#### Week 1.2

Insert `2, 1, 4, 5, 9, 3, 6, 7` into an initially empty AVL tree. Which one of the following statements is FALSE?

A. 4 is the root  
B. 3 and 7 are siblings  
C. 2 and 6 are siblings  
D. 9 is the parent of 7

**答案: B**

**解析:**  最终 AVL 树的根为 4;2 和 6 是兄弟, 9 是 7 的父节点. 3 的父节点是 2, 而 7 的父节点是 9, 因此 3 和 7 不是兄弟.

#### Week 1.3

For the result of accessing the keys `3, 9, 1, 5` in order in the splay tree in the figure, which one of the following statements is FALSE?

A. 5 is the root  
B. 1 and 9 are siblings  
C. 6 and 10 are siblings  
D. 3 is the parent of 4

**原图状态:** 当前本地笔记和可读取对话中未恢复到题目所指的初始树图. 以下保留已有答案与解析, 复习完整操作过程时需对照原图.

**答案: D**

**解析:**  Splay Tree 每次访问后都会把被访问结点旋转到根, 因此最后访问的 5 成为根;1 和 9 是兄弟, 6 和 10 是兄弟. 最终是 4 为 3 的父节点, 而不是 3 为 4 的父节点.

#### Week 1.4

关于摊还分析(Amortized Analysis), 下列说法中哪一项是错误的?

A. 若任意 $n$ 次操作的总最坏代价为 $T(n)$, 则聚合分析得到的平均摊还代价为 $T(n)/n$  
B. 使用势能法时, 势能函数必须从最大值开始  
C. 会计法中, 多收取的代价可以作为 credit 保存, 用于支付之后较昂贵的操作  
D. 聚合分析对总成本取平均, 而会计法可以给不同类型操作分配不同的摊还代价

**答案: B**

**解析:**  势能法通常要求初始势能满足 $\Phi(D_0)=0$, 并保证之后势能非负, 并不要求势能从最大值开始.

#### Week 1.5

动态数组 / buffer 在装满后采用扩容方式继续插入, 使用势能法分析其摊还复杂度. 题目给出的正确势能函数选项为"空闲块数量的相反数".

**答案: D**

**解析:**  若当前已有 $n$ 个元素,容量为 $m$, 空闲块数为 $m-n$, 因此其相反数为

$$
\Phi=n-m
$$

普通插入的摊还代价为常数;发生扩容时, 虽然实际代价较大, 但势能下降会抵消大部分代价, 因此每次插入的摊还复杂度仍为

$$
O(1)
$$

#### Week 2.1

In the red-black tree that results after successively inserting the keys `41, 38, 31, 12, 19, 8` into an initially empty red-black tree, which one of the following statements is FALSE?

A. 38 is the root  
B. 19 and 41 are siblings, and they are both red  
C. 12 and 31 are siblings, and they are both black  
D. 8 is red

**答案: B**

**解析:**  最终红黑树为:

```
          38(B)
         /     \
      19(R)    41(B)
      /   \
   12(B) 31(B)
   /
 8(R)
```

19 和 41 的确是兄弟, 但 41 是黑色, 因此 B 错误.

#### Week 2.2

After deleting 15 from the red-black tree given in the figure, which one of the following statements must be FALSE?

A. 11 is the parent of 17, and 11 is black  
B. 17 is the parent of 11, and 11 is red  
C. 11 is the parent of 17, and 11 is red  
D. 17 is the parent of 11, and 17 is black

**原图状态:** 当前本地笔记和可读取对话中未恢复到题目所指的初始树图. 以下保留已有答案与解析, 复习完整操作过程时需对照原图.

**答案: C**

**解析:**  删除 15 时可以使用前驱 11 或后继 17 替代, 因此 A,B,D 都可能出现在合法结果中;若 11 成为 17 的父节点, 则 11 必须为黑色, 因此 C 一定不成立.

#### Week 2.3

Insert `3, 1, 4, 5, 9, 2, 6, 8, 7, 0` into an initially empty 2-3 tree (with splitting). Which one of the following statements is FALSE?

A. 7 and 8 are in the same node  
B. the parent of the node containing 5 has 3 children  
C. the first key stored in the root is 6  
D. there are 5 leaf nodes

**答案: A**

**解析:**  最终结构为:

```text
              [6]
           /       \
        [2,4]      [8]
       /  |  \     /  \
   [0,1][2,3][4,5][6,7][8,9]
```

7 位于 `[6,7]`, 8 位于 `[8,9]`, 不在同一结点中, 因此 A 错误.

#### Week 2.4

After deleting 9 from the 2-3 tree given in the figure, which one of the following statements is FALSE?

A. the root is full  
B. the second key stored in the root is 6  
C. 6 and 8 are in the same node  
D. 6 and 5 are in the same node

**原图状态:** 当前本地笔记和可读取对话中未恢复到题目所指的初始树图. 以下保留已有答案与解析, 复习完整操作过程时需对照原图.

**答案: D**

**解析:**  删除 9 后发生合并并使树高下降, 最终可得到:

```text
             [4,6]
           /   |    \
      [1,2,3] [4,5] [6,7,8]
```

根结点已满, 第二个 key 为 6, 6 和 8 在同一叶结点中;5 在 `[4,5]`, 因此 D 错误.

#### Week 2.5

Which of the following statements concerning a B+ tree of order $M$ is TRUE?

A. the root always has between 2 and $M$ children  
B. not all leaves are at the same depth  
C. leaves and nonleaf nodes have some key values in common  
D. all nonleaf nodes have between $\lceil M/2\rceil$ and $M$ children

**答案: C**

**解析:**  B+ 树的所有叶结点都处在同一层;非叶结点只保存索引 key, 因此一些 key 会同时出现在非叶结点和叶结点中. 根结点是特殊情况, 所以 A,D 中的 `always/all` 均不成立.

#### Week 3.1

**题目**

In distributed indexing, document-partitioned strategy is to store on each node all the documents that contain the terms in a certain range.

- T
- F

**答案:F**

**解析:**

题目描述的是 **term-partitioned(按词项划分)**.

- Document-partitioned:每个节点负责一部分 documents,并为这些文档建立索引.
- Term-partitioned:每个节点负责一定范围的 terms.

因此题目错误.

---

#### Week 3.2

**题目**

When evaluating the performance of data retrieval, it is important to measure the relevancy of the answer set.

- T
- F

**答案:T**

**解析:**

评价信息检索系统不仅要考虑检索速度,也需要考虑返回结果的相关性.常用的相关性评价指标包括 Precision 和 Recall.

---

#### Week 3.3

**题目**

Precision is more important than recall when evaluating the explosive detection in airport security.

- T
- F

**答案:F**

**解析:**

机场爆炸物检测中更重要的是减少漏检,即提高 **Recall**.

宁可产生一定的误报,也不能漏掉真正的爆炸物,因此 Recall 通常比 Precision 更重要.

---

#### Week 3.4

**题目**

While accessing a term by hashing in an inverted file index, range searches are expensive.

- T
- F

**答案:T**

**解析:**

Hash Table 很适合精确查找,但哈希后的 key 没有保持大小顺序,因此范围查询需要检查大量位置,代价较高.

---

#### Week 3.5

**题目**

When measuring the relevancy of the answer set, if the precision is high but the recall is low, it means that:

A. most of the relevant documents are retrieved, but too many irrelevant documents are returned as well

B. most of the retrieved documents are relevant, but still a lot of relevant documents are missed

C. most of the relevant documents are retrieved, but the benchmark set is not large enough

D. most of the retrieved documents are relevant, but the benchmark set is not large enough

**答案:B**

**解析:**

Precision 高说明:

> 检索出来的文档中,大多数是相关文档.

Recall 低说明:

> 所有相关文档中,还有很多没有被检索出来.

因此选 B.

---

#### Week 3.6

**题目**

Which of the following is NOT concerned for measuring a search engine?

A. How fast does it index

B. How fast does it search

C. How friendly is the interface

D. How relevant is the answer set

**答案:C**

**解析:**

搜索引擎的主要性能指标包括:

- 建立索引的速度
- 查询速度
- 返回结果的相关性

界面是否友好属于用户界面设计,不属于这里衡量搜索引擎核心检索性能的指标.

---

#### Week 3.7

**题目**

There are 28000 documents in the database. The statistic data for one query are shown in the following table. The recall is:

|               | Relevant | Irrelevant |
| ------------- | -------: | ---------: |
| Retrieved     |     4000 |      12000 |
| Not Retrieved |     8000 |       4000 |

A. 14%

B. 25%

C. 33%

D. 50%

**答案:C**

**解析:**

Recall 的定义为:

$$
Recall=
\frac{\text{Retrieved Relevant}}
{\text{All Relevant}}
$$

相关文档总数为:

$$
4000+8000=12000
$$

因此:

$$
Recall=\frac{4000}{12000}
=\frac13
\approx33\%
$$

所以选择 C.

---

#### Week 4.1

**题目**

The result of inserting keys $1$ to $2^k-1$ for any $k>4$ in order into an initially empty skew heap is always a full binary tree.

- T
- F

**答案:T**

**解析:**

对于依次插入

$$
1,2,\cdots,2^k-1
$$

的情况,Skew Heap 每次 Merge 后交换左右子树,会形成规则的二叉树结构.

当结点数恰好为 $2^k-1$ 时,最终得到 full binary tree,因此该说法正确.

---

#### Week 4.2

**题目**

The right path of a skew heap can be arbitrarily long.

- T
- F

**答案:T**

**解析:**

Skew Heap 不像 Leftist Heap 那样维护 Npl,也没有强制要求右路径必须较短.

因此某一时刻的 right path 可以非常长.Skew Heap 保证的是一系列操作的摊还复杂度,而不是每棵树都严格平衡.

---

#### Week 4.3

**题目**

Merge the two leftist heaps in the following figure. Which one of the following statements is FALSE?

![Leftist Heap](https://images.ptausercontent.com/131)

A. 2 is the root with 11 being its right child

B. the depths of 9 and 12 are the same

C. 21 is the deepest node with 11 being its parent

D. the null path length of 4 is less than that of 2

**答案:D**

**解析:**

合并后:

- 2 是根,11 是 2 的右孩子.
- 9 和 12 的深度相同.
- 21 是最深的结点,其父结点为 11.

同时:

$$
Npl(4)=Npl(2)=2
$$

所以并不存在:

$$
Npl(4)<Npl(2)
$$

因此 D 错误.

---

#### Week 4.4

**题目**

We can perform BuildHeap for leftist heaps by considering each element as a one-node leftist heap, placing all these heaps on a queue, and performing the following step: Until only one heap is on the queue, dequeue two heaps, merge them, and enqueue the result. Which one of the following statements is FALSE?

A. in the $k$-th run, $\lceil N/2^k\rceil$ leftist heaps are formed, each contains $2^k$ nodes

B. the worst case is when $N=2^K$ for some integer $K$

C. the time complexity

$$
T(N)=O\left(
\frac{N}{2}\log 2^0+
\frac{N}{2^2}\log 2^1+
\frac{N}{2^3}\log 2^2+
\cdots+
\frac{N}{2^K}\log 2^{K-1}
\right)
$$

for some integer $K$ so that $N=2^K$

D. the worst case time complexity of this algorithm is $\Theta(N\log N)$

**答案:D**

**解析:**

第 $k$ 轮需要大约进行:

$$
\frac{N}{2^k}
$$

次 Merge,每次 Merge 的复杂度约为:

$$
O(1+\log 2^{k-1})=O(k)
$$

这里把单节点合并的常数成本也计入. 因此:

$$
T(N)
=
O\left(
N\sum_{k=1}^{K}\frac{k}{2^k}
\right)
$$

而级数:

$$
\sum_{k=1}^{\infty}\frac{k}{2^k}
$$

收敛到常数,因此:

$$
T(N)=O(N)
$$

所以最坏时间复杂度为 $\Theta(N)$,D 错误.

> 题中按轮计数的整齐表达以 $N=2^K$ 为分析模型;一般 $N$ 下, 中间堆不一定全有相同大小, 但队列两两合并的线性结论仍然成立.

---

#### Week 4.5

**题目**

Insert keys 1 to 15 in order into an initially empty skew heap. Which one of the following statements is FALSE?

A. the resulting tree is a complete binary tree

B. there are 6 leaf nodes

C. 6 is the left child of 2

D. 11 is the right child of 7

**答案:B**

**解析:**

依次插入 $1\sim15$ 后得到的 Skew Heap 为完整的 15 个结点结构.

其中:

- 6 是 2 的左孩子.
- 11 是 7 的右孩子.
- 叶子结点共有 8 个,而不是 6 个.

因此 B 错误.

---

#### Week 4.6

**题目**

Merge the two skew heaps in the following figure. Which one of the following statements is FALSE?

![Skew Heap](https://images.ptausercontent.com/195)

A. 15 is the right child of 8

B. 14 is the right child of 6

C. 1 is the root

D. 9 is the right child of 3

**答案:A**

**解析:**

Skew Heap 合并时,先沿 right path 进行 Merge,然后将合并路径上结点的左右子树交换.

合并以后:

- 1 仍然是根.
- 9 是 3 的右孩子.
- 14 是 6 的右孩子.
- 8 不在需要交换的合并路径上,因此 15 仍然是 8 的左孩子.

所以:

> 15 is the right child of 8

是错误的,选择 A.

### 6.2 编程题 && 程序填空题

#### Week 1: 7-1 Root of AVL Tree

> 这份独立习题代码采用空树高度 0,叶节点高度 1, 与正文整体平移 1;BF 与旋转判断不变, 但不要混用两套高度函数.

**题意:**  给出 $N$ 个互不相同的整数, 依次插入一棵初始为空的 AVL 树, 最后输出 AVL 树根结点的 key.

**核心思路:** 

1. 先按照 BST 规则递归插入;
2. 回溯时更新结点高度;
3. 计算平衡因子 `height(left) - height(right)`;
4. 若失衡, 根据 LL,RR,LR,RL 四种情况进行旋转;
5. 所有元素插入后输出根结点.

```c
#include <stdio.h>
#include <stdlib.h>

typedef struct Node
{
    int key;
    int height;
    struct Node *left;
    struct Node *right;
} Node;

int max(int a, int b)
{
    return a > b ? a : b;
}

int height(Node *root)
{
    if (root == NULL)
        return 0;

    return root->height;
}

Node *create(int x)
{
    Node *node = (Node *)malloc(sizeof(Node));

    node->key = x;
    node->height = 1;
    node->left = NULL;
    node->right = NULL;

    return node;
}

Node *rightRotate(Node *y)
{
    Node *x = y->left;
    Node *T = x->right;

    x->right = y;
    y->left = T;

    y->height = max(height(y->left), height(y->right)) + 1;
    x->height = max(height(x->left), height(x->right)) + 1;

    return x;
}

Node *leftRotate(Node *x)
{
    Node *y = x->right;
    Node *T = y->left;

    y->left = x;
    x->right = T;

    x->height = max(height(x->left), height(x->right)) + 1;
    y->height = max(height(y->left), height(y->right)) + 1;

    return y;
}

Node *insert(Node *root, int x)
{
    if (root == NULL)
        return create(x);

    if (x < root->key)
        root->left = insert(root->left, x);
    else
        root->right = insert(root->right, x);

    root->height = max(height(root->left), height(root->right)) + 1;

    int balance = height(root->left) - height(root->right);

    if (balance > 1 && x < root->left->key)
        return rightRotate(root);

    if (balance < -1 && x > root->right->key)
        return leftRotate(root);

    if (balance > 1 && x > root->left->key)
    {
        root->left = leftRotate(root->left);
        return rightRotate(root);
    }

    if (balance < -1 && x < root->right->key)
    {
        root->right = rightRotate(root->right);
        return leftRotate(root);
    }

    return root;
}

int main()
{
    int N;
    scanf("%d", &N);

    Node *root = NULL;

    for (int i = 0; i < N; i++)
    {
        int x;
        scanf("%d", &x);

        root = insert(root, x);
    }

    printf("%d\n", root->key);

    return 0;
}
```

#### Week 2: 7-1 Self-printable B+ Tree

**原题:**

In this project, you are supposed to implement a B+ tree of order 3, with the following operations: initialize, insert (with splitting) and search.  The B+ tree should be able to print out itself.

**Input Specification:**
Each input file contains one test case.  For each case, the first line contains a positive number $N$ ($\le 10^4$), the number of integer keys to be inserted.  Then a line of the N positive integer keys follows.  All the numbers in a line are separated by spaces.

**Output Specification:**
For each test case, insert the keys into an initially empty B+ tree of order 3 according to the given order.  Print in a line Key X is duplicated where X already exists when being inserted.  After all the insertions, print out the B+ tree in a top-down lever-order format as shown by the samples.

**Sample Input 1:**

```text
6
7 8 9 10 7 4
```

**Sample Output 1:**

```text
Key 7 is duplicated
[9]
[4,7,8][9,10]
```

**Sample Input 2:**

```text
10
3 1 4 5 9 2 6 8 7 0
```

**Sample Output 2:**

```text
[6]
[2,4][8]
[0,1][2,3][4,5][6,7][8,9]
```

**Sample Input 3:**

```text
3
1 2 3
```

**Sample Output 3:**

```text
[1,2,3]
```



**来源:** 2026-10-01 的课程对话中粘贴的 PTA 题面. `lever-order` 保留原文拼写. 题面写 positive integer keys, 但 Sample Input 2 包含 `0`, 实现应以样例允许 `0`.

**题意:**  实现 order 3 的 B+ 树, 支持初始化,插入,重复 key 检测,结点分裂, 并最终按照层序打印整棵树.

本题中:

- 叶结点最多保存 3 个 key, 第 4 个 key 插入时分裂;
- 非叶结点最多保存 2 个索引 key, 第 3 个索引 key 出现时分裂;
- 叶结点分裂时, 中间 key 是**复制**到父结点;
- 非叶结点分裂时, 中间 key 是**上移**到父结点;
- 输出使用 BFS 层序遍历.

```c
#include <stdio.h>
#include <stdlib.h>

typedef int ElemType;

struct node
{
    ElemType isLeaf;
    ElemType isRepeat;
    ElemType curr_n;
    ElemType key[4];
    struct node *child[6];
};

typedef struct node B_plus;

B_plus *create_node(ElemType is_a_leaf)
{
    B_plus *newnode = (B_plus *)malloc(sizeof(B_plus));

    newnode->isLeaf = is_a_leaf;
    newnode->isRepeat = 1;
    newnode->curr_n = 0;

    for (int i = 0; i < 4; i++)
        newnode->key[i] = -1;

    for (int i = 0; i < 6; i++)
        newnode->child[i] = NULL;

    return newnode;
}

ElemType isRepeated(B_plus *root, ElemType x)
{
    if (root == NULL)
        return 0;

    B_plus *curr = root;

    while (curr->isLeaf == 0)
    {
        ElemType counter = 0;

        for (int i = 0; i < curr->curr_n; i++)
        {
            if (x >= curr->key[i])
                counter++;
            else
                break;
        }

        curr = curr->child[counter];
    }

    for (int i = 0; i < curr->curr_n; i++)
    {
        if (curr->key[i] == x)
            return 1;
    }

    return 0;
}

void insertion(B_plus *curr, ElemType x)
{
    ElemType pos = 0;

    while (pos < curr->curr_n && curr->key[pos] < x)
        pos++;

    for (int i = curr->curr_n; i > pos; i--)
        curr->key[i] = curr->key[i - 1];

    curr->key[pos] = x;
    curr->curr_n++;
}

B_plus *leaf_boom(B_plus *curr, ElemType *up)
{
    B_plus *R = create_node(1);

    R->key[0] = curr->key[2];
    R->key[1] = curr->key[3];
    R->curr_n = 2;

    curr->curr_n = 2;

    *up = R->key[0];

    return R;
}

B_plus *father_boom(B_plus *curr, ElemType *up)
{
    B_plus *R = create_node(0);

    *up = curr->key[1];

    R->key[0] = curr->key[2];
    R->curr_n = 1;

    R->child[0] = curr->child[2];
    R->child[1] = curr->child[3];

    curr->curr_n = 1;

    return R;
}

ElemType insertNodes(B_plus *curr, ElemType x, ElemType *up, B_plus **newR)
{
    if (curr->isLeaf == 1)
    {
        insertion(curr, x);

        if (curr->curr_n <= 3)
            return 0;

        *newR = leaf_boom(curr, up);

        return 1;
    }

    ElemType counter = 0;

    for (int i = 0; i < curr->curr_n; i++)
    {
        if (x >= curr->key[i])
            counter++;
        else
            break;
    }

    ElemType child_toward;
    B_plus *child_right = NULL;

    ElemType booming =
        insertNodes(curr->child[counter], x, &child_toward, &child_right);

    if (booming == 0)
        return 0;

    for (int i = curr->curr_n; i > counter; i--)
        curr->key[i] = curr->key[i - 1];

    for (int i = curr->curr_n + 1; i > counter + 1; i--)
        curr->child[i] = curr->child[i - 1];

    curr->key[counter] = child_toward;
    curr->child[counter + 1] = child_right;
    curr->curr_n++;

    if (curr->curr_n <= 2)
        return 0;

    *newR = father_boom(curr, up);

    return 1;
}

void insertTree(B_plus **root, ElemType x)
{
    if (*root == NULL)
    {
        *root = create_node(1);

        (*root)->key[0] = x;
        (*root)->curr_n = 1;

        return;
    }

    ElemType upforward;
    B_plus *newR = NULL;

    ElemType booming =
        insertNodes(*root, x, &upforward, &newR);

    if (booming == 1)
    {
        B_plus *newRoot = create_node(0);

        newRoot->key[0] = upforward;
        newRoot->curr_n = 1;

        newRoot->child[0] = *root;
        newRoot->child[1] = newR;

        *root = newRoot;
    }
}

void print_one(B_plus *curr)
{
    printf("[");

    for (int i = 0; i < curr->curr_n; i++)
    {
        if (i != 0)
            printf(",");

        printf("%d", curr->key[i]);
    }

    printf("]");
}

void print_whole(B_plus *root)
{
    if (root == NULL)
        return;

    B_plus *q[40010];

    ElemType front = 0;
    ElemType rear = 0;

    q[rear++] = root;

    while (front < rear)
    {
        ElemType cnt = rear - front;

        for (int k = 0; k < cnt; k++)
        {
            B_plus *curr = q[front++];

            print_one(curr);

            if (curr->isLeaf == 0)
            {
                for (int i = 0; i <= curr->curr_n; i++)
                    q[rear++] = curr->child[i];
            }
        }

        printf("\n");
    }
}

int main()
{
    int n;
    scanf("%d", &n);

    B_plus *root = NULL;

    for (int i = 0; i < n; i++)
    {
        int x;
        scanf("%d", &x);

        if (isRepeated(root, x))
            printf("Key %d is duplicated\n", x);
        else
            insertTree(&root, x);
    }

    print_whole(root);

    return 0;
}
```

**关键点:** 

- 查找内部结点时, 若 `x >= key[i]`, 应继续向右侧孩子走;
- 叶结点 `[a,b,c,d]` 分裂为 `[a,b]` 和 `[c,d]`, 并把 `c` 复制给父结点;
- 非叶结点 `[a,b,c]` 分裂为 `[a]` 和 `[c]`, 把 `b` 上移;
- 一个内部结点有 `curr_n + 1` 个孩子, 所以 BFS 时必须写:

```c
for (int i = 0; i <= curr->curr_n; i++)
```

#### Week 4

**题目**

Complete the following function for merging two leftist heaps.

```c
PriorityQueue Merge( PriorityQueue H1, PriorityQueue H2 )
{ 
    if (H1 == NULL) return H2;
    if (H2 == NULL) return H1;

    if (@@)
        swap(H1, H2);  // swap H1 and H2

    if (H1->Left == NULL)
        @@;
    else {
        H1->Right = Merge(H1->Right, H2);

        if (H1->Left->Npl < H1->Right->Npl)
            SwapChildren(H1);

        @@;
    }

    return H1;
}
```

**答案:** 三处依次为:

```c
H1->Element > H2->Element
H1->Left = H2
H1->Npl = H1->Right->Npl + 1
```

第一处保证 H1 的根较小;第二处利用"左孩子为空的左式堆必为单节点", 把 H2 接到左侧, 此时右侧仍为空,Npl 仍为 0;第三处在必要交换完成后用右孩子更新 Npl.

> [!NOTE]
>
> 题目中的 `swap(H1, H2)` 是交换两个指针变量的伪代码 / 宏写法. C 函数若只按值接收两个指针, 不能交换调用者的变量;实际写法可参考第三章的临时指针交换.


### 6.3 历史提问: Binary Heap

**原提问:** 二叉堆的insert和deletemin是什么,为什么OlogN

**来源:** 2026-10-12 的 GPT 对话 "二叉堆操作复杂度". 仅将原提问中的逗号改为英文标点.

**解析:** 这里讨论 Min-Heap. Insert 将新 key 放到数组末尾, 然后沿父节点方向上滤, 直到满足父节点不大于孩子的 Heap Order. DeleteMin 删除根处的最小值, 将末尾元素移到根, 再与较小的孩子比较并下滤.

二叉堆是 Complete Binary Tree, $N$ 个节点的高度为 $\lfloor\log_2 N\rfloor$. 每一步只移动一层并进行常数次比较, 因此两种操作的最坏时间均为 $O(\log N)$. 单次操作可能提前停止, 不意味着每次都必须走到最后一层. 动态数组重新分配内存的成本需要另外分析.

| 操作 | 起点 | 调整方向 | 最坏时间 |
| :--- | :--- | :--- | :---: |
| Insert | 数组末尾的新节点 | 上滤 | $O(\log N)$ |
| DeleteMin | 根处的末尾替代值 | 下滤 | $O(\log N)$ |

<div style="display: block !important; text-align: right !important; margin-top: 60px !important; padding-right: 20px !important; font-family: '钟齐志莽行书', cursive !important; font-size: 26px !important; font-weight: bold !important; font-style: italic !important; color: #6b4423 !important;">邓欢桐</div>
