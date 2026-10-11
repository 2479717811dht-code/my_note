# <center>高级数据结构与算法分析</center>

<center>浙江大学 竺可桢学院 混合2504班 邓欢桐 3250102223</center>

---

<center>
<img src="../public/20260323101520_871_96.png" style="zoom: 60%;" />
<img src="../public/20260323101521_872_96.png" style="zoom: 20%;" />
<img src="../public/ckc.png" style="zoom: 25%;" />
</center>

---

[TOC]

<div style="display: block !important; text-align: center !important; margin: 60px auto 20px !important; padding: 20px 0 !important; width: 85% !important; border-top: 1px dashed #b1c2ca !important; border-bottom: 1px dashed #b1c2ca !important; font-family: '钟齐志莽行书', cursive !important; font-size: 20px !important; line-height: 1.8 !important; letter-spacing: 2px !important; font-weight: normal !important; font-style: italic !important; color: #2d4856 !important;">“ 我终于, 自由了！”<span style="display: block !important; text-align: right !important; margin-top: 10px !important; font-size: 18px !important;">—— 2026.7.4 玉湖七幢</span></div>

## Chapter 1: Trees

### 1.1 AVL Trees

#### 1.1.1 为什么需要 AVL Trees

> **目标**
>
> 普通 BST 的查找时间虽然是 $O(h)$, 但无法保证 $h$ 小到一个类似 $logN$ 的值.
>
> 我们需要快速查找, 包括插入和删除, 即在这三个过程中始终让树保持足够平衡, 从而保证树高总为 $logN$.

显然, 其需要一个 Binary Search Trees (BST)

> **问题**
>
> 当退化成一个链表的时候, 时间复杂度直接变成 $O(N)$.

换句话说, BST 很好, 但是在极端情况下, 它又不是那么好, 这就需要一个新的工具 / 算法了.

<details style="--wi-box-color:var(--wi-question);--wi-box-bg:var(--wi-question-bg)"><summary>那么到底需要用什么算法？</summary><p>cyll: 你看现在我们在讲 AVL Trees. </p></details>

#### 1.1.2 AVL Trees 的基本定义和思想

AVL Trees 的思想是典型的工程师思维:

1. 先当它“坏的”；
2. “坏了”再修好就是了.

我们希望的是 $O(logN)$ 情况, 超过此情况的包括但不限于 $O(N)$ 这样的复杂度, 我们都认为它是“坏的”.

> [!IMPORTANT]
>
> 我们首先记一棵二叉树为 $T$:
>
> 1. 显然, 一个空的二叉树是高度平衡 (Height Balanced) 的；
> 2. 对于一个非空的二叉树, 记其左子树和右子树分别为 $T_L$ 和 $T_R$, 高度分别记为 $h_L$ 和 $h_R$, $T$ 是平衡的当且仅当:
>    - $T_L$ 和 $T_R$ 均为高度平衡的, 即 $T$ 的左子树和右子树均为 AVL 树；
>    - $|h_R-h_L| \leq 1$.

#### 1.1.3 树高和平衡因子

首先, 我们引入一个概念: 平衡因子——Balance Factor (BF(node)), 记 BF(node) $= h_L-h_R$, 故 BF(node) 的取值仅为 $-1$, $0$, $1$.

> [!CAUTION]
>
> 定义是左高减右高, 因此 BF 为负数表示左重, 反之右重.

那么这里涉及到一个问题:

<details style="--wi-box-color:var(--wi-question);--wi-box-bg:var(--wi-question-bg)"><summary>BF 是从上往下更新还是从下往上更新？</summary><p>答案: 从下往上</p><p>这里其实是一个递归的过程, 从最底下插入, 递归到节点的 parent, 一层层往上计数. </p></details>

其次, 我们再来澄清一下树高这个概念

> **Height**
>
> 我们一般把根节点的高度记为 $1$, 往下一层 $+1$.
>
> 也就是说, 我们需要找到从根节点到叶子节点的最长路径, 其终点（叶子）高度即为树的高度.
>
> 注意，空树的树高记为 $-1$, 一个节点树高记为 $0$.

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

另外, 我们记 $n_h$ 为高为 $h$ 的高度平衡树的最小节点树, 那么会有公式:

$$
n_h=n_{h-1}+n_{h-2}+1
$$

我们由此极容易联想到斐波那契数列.

> [!CAUTION]
>
> 这不是真正传统意义上的斐波那契数列, 需要进行甄别.

#### 1.1.4 AVL Trees 的基本插入过程

1. 首先, 按照普通的 BST 插入；

2. 沿着插入路径向上:
   - 更新每个节点的高度；

   - 计算 BF；

   - 找到第一个失衡的祖先节点, 即 $|$BF$|$ 为 2 或 -2 的点；

   - 对该结构进行局部的旋转.

     > 一般该节点称为 trouble finder

#### 1.1.5 失衡情况

> [!IMPORTANT]
>
> 引理: Trouble Maker 和 Trouble Finder
>
> Trouble Maker: 导致树产生失衡的新插入节点;
>
> Trouble Finder: 从 trouble maker 向上找，遇到的最近的失衡节点.

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
> 1. LL 型: 长成单链 `/` 型；
> 2. RR 型: 长成单链 `\` 型；
> 3. LR 型: 顾名思义先左后右, 长成 `《` 型；
> 4. RL 型, 显而易见先右后左, 长成 `》` 型.
>
> 下面开始讲这些失衡的修正.

#### 1.1.6 旋转修正

先定义结构体：

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
> 这部分的内容很可能和中文的角度有所不同, 比如一棵只有右子树的三层单链树, 表面上应该是左旋使其调平, 但实际上该旋转方式称为 RR 旋, 下面会给详细的介绍.

可分为 LL 旋、LR 旋、RL 旋、RR 旋, 只需知道其如何旋转即可, 名称其实并不太重要.

下面是四周失衡的修正方法:

1. 对于 **LL** 型失衡, 我们只需将 `/` 的状态掰成 `^` 即可, 也就是说, 对该链的根节点做一个**右**旋, 中间节点为顶点；

   ```c
        【旋转前】                【右旋后】
            30 (A)                    20
           /                         /  \
          20 (B)       --->         10   30
         /
        10

   // code:
   ALVNode *rotateRight(AVLNode *A)
   {
       AVLNode *B = A->left;
       A->left = B->right; // 保住 B 的右子树
       B->right = A;
       A->height = max(getHeight(A->left), getHeight(A->right) + 1);
       B->height = max(getHeight(B->left), getHeight(B->right) + 1);
       return B;
   }
   ```

2. 对于 **RR** 型失衡, 我们只需将 `\` 的状态掰成 `^` 即可, 也就是说, 对该链的根节点做一个**左**旋, 中间节点为顶点；

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

3. 对于 **LR** 型失衡, 我们将最低节点变成根节点, 中间节点作为左孩子, 原来的根节点作为右孩子即可, 化成一个 `^` 的形状；

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
        【旋转前】               【局部左旋后】             【右旋后】
            30                         30                       20
           /                          /                        /  \
          10           --->          20          --->         10   30
            \                       /
             20                    10
   // code:
   AVLNode *rotateRightLeft(AVLNode *A)
   {
       A->right = rotateRight(A->Right);
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
    int data;
    struct AVLNode *left;
    struct AVLNode *right;
    int height;
} AVLNode;

// 获取节点高度
int getHeight(AVLNode *node)
{
    if (node == NULL)
        return 0;
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
AVLNode *rightRotate(AVLNode *y)
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
AVLNode *leftRotate(AVLNode *x)
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
AVLNode *lrRotate(AVLNode *node)
{
    node->left = leftRotate(node->left); // 把 / \ 变成 / /
    return rightRotate(node);            // 再把 / / 变成 ^
}

// ---------------------------------------------------
// 4. 右左旋 RL (先右旋右孩子, 再左旋根节点)
// ---------------------------------------------------
AVLNode *rlRotate(AVLNode *node)
{
    node->right = rightRotate(node->right); // 把 \ / 变成 \ \
    return leftRotate(node);                // 再把 \ \ 变成 ^
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

#### 1.1.8 为什么 AVL Trees 一定只有 O(logN) 高

想要证明这个问题, 我们首先设树高为 $h$ 的 AVL Trees 的节点数为 $n_h$；

为了整棵树的节点数尽可能少, 我们设左子树和右子树的差距足够大, 以满足单边字数和根节点一起满足 $h$ 的树高即可, 也就是说, 我们可以设左子树高度为 $h-1$, 右子树高度为 $h-2$, 这样两边的差距达到最大, 节点数最少；

此时我们记左子树最少节点数为 $n_{h-1}$, 右子树同理为 $n_{h-2}$, 因此我们得到了如下关系:

$$
n_h=n_{h-1}+n_{h-2}+1
$$

想起来了吗, 此前我们提到过这个公式, 并提及我们很容易联想到斐波那契数列.

> [!WARNING]
>
> 这个证明有点不容易, 这里给出 ChatGPT 的示例:
>
> > **证明过程**
> >
> > 由于空树高度为 -1:
> >
> > $$
> > n_{-1}=0
> > $$
> >
> > 叶结点高度为 0:
> >
> > $$
> > n_0=1
> > $$
> >
> > 继续计算:
> >
> > $$
> > n_1=n_0+n_{-1}+1=2
> > $$
> >
> > $$
> > n_2=n_1+n_0+1=4
> > $$
> >
> > $$
> > n_3=n_2+n_1+1=7
> > $$
> >
> > $$
> > n_4=n_3+n_2+1=12
> > $$
> >
> > 得到:
> >
> > ```
> > 高度        -1   0   1   2   3   4
> > 最少结点     0   1   2   4   7  12
> > ```
> >
> > ---
> >
> > 斐波那契数列满足:
> >
> > $$
> > F_0=0,\quad F_1=1
> > $$
> >
> > $$
> > F_i=F_{i-1}+F_{i-2}
> > $$
> >
> > AVL 最少结点数满足:
> >
> > $$
> > n_h=F_{h+3}-1
> > $$
> >
> > 而斐波那契数大约按照黄金比例的指数增长:
> >
> > $$
> > F_k\approx \frac{\varphi^k}{\sqrt{5}}
> > $$
> >
> > 其中:
> >
> > $$
> > \varphi=\frac{1+\sqrt{5}}{2}
> > $$
> >
> > 所以:
> >
> > $$
> > N\geq n_h\approx C\varphi^h
> > $$
> >
> > 两边取对数:
> >
> > $$
> > h=O(\log N)
> > $$
> >
> > 因此 AVL 树的:
> >
> > $$
> > \text{查找}=O(\log N)
> > $$
> >
> > $$
> > \text{插入}=O(\log N)
> > $$
> >
> > PPT 这一部分证明的核心不是求某个特别精确的常数, 而是证明:
> >
> > > AVL Trees 的高度不会接近 $N$, 而只会随着结点数按对数增长.

个人认为只需知道即可, 怎么证的其实不太重要, 只需记住 AVL Trees 的树高就是 O(logN) 即可吧~

```c
// create a node:
AVLNode *newNode(int key)
{
    AVLNode *node = (AVLNode *)malloc(sizeof(AVLNode));
    node->key = key;
    node->left = NULL;
    node->right = NULL;
    node->height = 0; // the height of a singel node is 0
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
    if (root == 0)
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

### 1.2 Splay Trees

#### 1.2.1 背景

> 首先, 它是一棵 BST, 毋庸置疑.

我们首先做一个引入:

<center>Why Splay Trees ?</center>

> 我们回看 AVL Trees, 可以发现其每一次操作都是 O(logN), 但代价同样<s>可观</s>比较大:
>
> 1.  每个节点需要保存 Height 和 BF；
> 2.  插入和删除都要检查平衡问题, 否则需要调整修正；
> 3.  需识别 LL、RR、LR、RL；
> 4.  某次删除可能需要多次回溯向上调平衡.

此时 Splay Trees 应运而生, 它的基本思想是:

> 不要求树在每次操作都要极度平衡, 只需要糟糕操作的次数在总样本中足够小.

#### 1.2.2 定义

> [!IMPORTANT]
>
> AVL Trees 是一种极端的 Splay Trees, 但 Splay Trees 不一定是 AVL Tress, 其条件宽松很多.

我们因此说些人话, Splay Trees 的基本要求是, 从空树开始进行连续的 M 次操作, 总操作时间不应该高于 O(M · logN) 即可. 即 Splay 不保证单次 $O(logN)$.

> **引理: 摊还时间**
>
> 可以简单地理解为平均时间, 但是它并不是标准意义上的平均时间, 本质上它是平均时间的上界.
>
> 归纳地, worst-case bound $\ge$ amortized bound $\ge$ average-case bound

因此每次的摊还时间为 O(logN), 但并不意味着每一次的操作时间均为严格的 O(logN).

也就是说, 某次操作可能是 O(N), 但多次操作后总时间成本仍然受控制.

简单来说, 一个或几个操作很糟糕, 也无所谓, 反正最终平均是 O(logN) 就可以了.

定义结构体, 以及基本操作:

```c
typedef struct SplayNode
{
    int key;
    struct SplayNode *left;
    struct SplayNode *right;
} SplayNode;

// rotateRight
SpalyNode *rotateRight(SplayNode *root)
{
    SpalyNode *newNode = root->left;
    root->left = newNode->right;
    newNode->right = root;
    return newNode;
}

// rotateLeft
SpalyNode *rotateLeft(SplayNode *root)
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

> [!WARNING]
>
> 依次插入 1,2,3,...,N, 再依次访问 1,2,3,...,N；
>
> 显然, 若不断地单旋会产生极大的操作成本, 因为全是 O(N) 了.
>
> 因此, 这种方法如 cyll 的课件所说:
>
> > <center>Does NOT work</center>

<details style="--wi-box-color:var(--wi-question);--wi-box-bg:var(--wi-question-bg)"><summary>正确的伸展操作是什么？</summary><p>正确的伸展操作必须根据: </p><ol><li>当前节点 X；</li><li>父节点 P；</li><li>祖父节点 G；</li></ol><p>之间的位置关系进行处理. </p></details>

此时, 按照这个前提, 我们设:

- X 为当前节点；
- P 为 X 的父节点；
- G 为 X 的祖父节点；

> 分为三种情况讨论:
>
> > **Zig**
> >
> > P 是根节点时, 只剩最后一层, 只需 X 与 P 旋转一次即可
> >
> > (1) 情况一: X 为左孩子（单右旋）
> >
> > ```c
> >       P                    X
> >    /       ---->          \
> > X                        P
> > ```
> >
> > (2) 情况二: X 为右孩子（单左旋）
> >
> > ```c
> > P                        X
> >    \       ---->          /
> >       X                    P
> > ```
>
> > **Zig-zig**
> >
> > 当 X 与 P 位于同一方向, 先旋 P 和 G, 再旋 X 和 P
> >
> > (1) 情况一: 左左情况（先右旋 P-G, 再右旋 X-P）
> >
> > ```c
> >        G
> >       /                      P
> >      P        ---->         / \
> >     /                      X   G
> >  X
> > ```
> >
> > (2) 情况二: 右右情况（先左旋 P-G, 再左旋 X-P）
> >
> > ```c
> >  G
> >     \                        P
> >      P        ---->         / \
> >       \                    G   X
> >        X
> > ```
>
> > **Zig-zag**
> >
> > 当 X 和 P 位于相反方向时, 先旋 X 和 P, 再旋 X 和 G
> >
> > (1) 情况一: 左右情况（先左旋 X-P, 再右旋 X-G）
> >
> > ```c
> >      G
> >    /                      X
> >  P        ---->         / \
> >    \                    P   G
> >      X
> > ```
> >
> > (2) 情况二: 右左情况（先右旋 X-P, 再左旋 X-G）
> >
> > ```c
> >  G
> >    \                      X
> >      P        ---->       / \
> >    /                    G   P
> >  X
> > ```

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
        if (key->left == NULL)
        {
            return root;
        }
        // zig-zig
        if (key < root->left->key)
        {
            root->left->left = spaly(root->left->left, key);
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
            return root
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
            if (root->right == NULL)
            {
                return root;
            }
            return rotateLeft(root);
        }
    }
}
```

#### 1.2.4 Splay 的效果

如上可知, Zig-zig 和 Zig-zag 都能让 X 直接上升两层, 还会重新组织整条访问路径.

因此 cyll 给出了直观的结论:

> 伸展不仅把访问结点移到根, 还会使访问路径上大多数结点的深度大致减半.

其正是“摊还”操作的底层逻辑, 即一次的昂贵操作换来了后续多次的便宜操作.

#### 1.2.5 Splay Trees 的查找、插入和删除

> **一点约定**
>
> 这里我们为表区分, 查找的元素设为 X, 插入的元素设为 X', 删除的元素设为 X''

1. 查找:
   - 先按普通的 BST 寻找到 X；

   - 对其 Splay, 将其伸展到根；

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
   - 先按普通 BST 的规则插入节点 X'；

   - 再对插入的节点进行 Splay；

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
         return root;
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
   - 首先查找 X'', 找到后对其进行 Splay, 成为根；

   - 删除 X'', 剩下左右两颗子树, 记为 $T_L$ 和 $T_R$, 显然 $T_L$ 中所有元素小于 X'', $T_R$ 中所有元素大于 X''；

   - 寻找 $T_L$ 中的最大元素 M, 显然 M 一定没有右孩子, 对 M 进行 Splay, 伸展到 $T_L$ 的根；

   - 容易发现这有点类似于 Zig, 此时 M 依旧没有右孩子, 即顺理成章地将 $T_R$ 连接到 M 上；

     > [!CAUTION]
     >
     > - 此情况下仍然满足 $Elements \ of \ T_{L} < M < Elements \ of \ T_{R}$
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
         if (root->left = NULL)
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

- 输入随机；
- 操作等概率；
- 数据服从某种概率分布.

其为一种确定性的最坏序列总成本分析.

<details style="--wi-box-color:var(--wi-question);--wi-box-bg:var(--wi-question-bg)"><summary>由此, “摊还”拥有了一个极为神准的定义</summary><p>cyll: 摊还, 可理解为平均值的上界. </p></details>

基于此, 我们拥有了三种不同含义的复杂度:

1. 单次最坏复杂度；
2. 平均复杂度；
3. 摊还复杂度.

#### 1.2.7 摊还分析方法

这里介绍三种分析方法:

1. 聚合法 (Aggregate Analysis)

2. 记账法 (Accounting Method)

3. 势能法 (Potential Method)

<center>↓下面进行一一解读↓,</center>

> **Aggregate Analysis**
>
> 本质是直接分析整个序列
>
> 假设连续 n 次操作的总时间成本是 T(n), 那么每一次的时间成本就是 T(n)/n
>
> > **典型例子**
> >
> > 压栈和弹栈的操作, 每一次都是 O(1), 那么连续弹出 k 个元素, 成本为 O(min{|S|, k})
> >
> > 压栈和弹栈的总次数最多均为 n, 因此 T(n) = O(n), 每次摊还成本仍为 T(n)/n = O(1)
> >
> > > [!WARNING]
> > >
> > > :x: **Wrong Thinking**: 如果认为有 n 次操作, 一次连续弹栈最坏是 n 次操作, 认为时间成本是 O(n²).
> > >
> > > 该结论过于坏, 导致实际情况中根本不会发生, 因为除非重新压栈, 否则一个元素不可能弹出两次.

> **Accounting Method**
>
> 本质是摊还成本高于实际成本时, 多出的成本存储起来以供下一次的复杂操作消耗
>
> - 记第 i 次的实际成本为 $c_i$
> - 记第 i 次的摊还成本为 $c_i'$
>
> 为保证分析有效, 需要满足:
>
> $$
> Σc_i' \ge Σc_i
> $$
>
> > 我们以**栈操作**为例:
> >
> > > [!IMPORTANT]
> > >
> > > 1. 实际成本:
> > >    - Push: 1；
> > >    - Pop: 1；
> > >    - MultiPop: 实际多少元素就是多少；
> > > 2. 摊还分析:
> > >    - Push: 2；
> > >    - Pop: 0；
> > >    - MultiPop: 0；
> > >
> > > 此时每一次 Push 收取 2, 该元素被 Pop 时, 自动消耗其 Push 时留下的信用, 这样栈中有几个元素, 就至少有几份信用, 由此可知每个元素:
> > >
> > > - 被 Push 时获得信用；
> > > - 被弹出时消耗信用；
> > > - 不会被无支付地重复弹出.
> > >
> > > 即总摊还成本最多是 2n, 每次成本依然为 O(1).
> >
> > 其中, Pop 为 0 不代表其真的不运行, 而是其成本已由 Push 预支付了.

> **Potential Method**
>
> > [!TIP]
> >
> > 可以认为是记账法的数学化版本
>
> 记 $D_i$ 表示第 i 次完成后的数据结构状态, 定义势能函数 $Φ(D_i)$, 表示积累的“潜在工作 / 存储”
>
> 由此我们有:
>
> $$
> c_i'=c_i+Φ(D_i)−Φ(D_{i−1})=c_i+ΔΦ_i
> $$
>
> 那么对于总的操作, 我们有:
>
> $$
> Σc_i'=Σc_i+ΣΔΦ_i=Σc_i+Φ(D_n)-Φ(D_0)
> $$
>
> 若保证 $Φ(D_n) \ge Φ(D_0)$, 则有 $Σc_i' \ge Σc_i$, 即摊还成本为实际总成本的上界.
>
> 因此一个好的势能函数通常要满足:
>
> - 势能非负；
> - 初始状态势能最小；
> - 数据结构越“危险”或未来可能越贵, 势能越高.
>
> > **势能法分析栈**
> >
> > 我们定义一个势能函数, 即 $Φ(D_i)$ 表示栈中元素个数, 即 $Φ(D_i)=|S_i|$；
> >
> > 那么任何时候都有 $Φ(D_i) \ge 0$；
> >
> > 1. Push
> >    - 实际成本 $c_i=1$；
> >    - 入栈, 势能增加: $ΔΦ=1$；
> >    - 即 $c_i'=2$；
> > 2. Pop
> >    - 实际成本 $c_i=1$；
> >    - 弹栈, 势能减少: $ΔΦ=-1$；
> >    - 即 $c_i'=0$；
> > 3. MultiPop
> >    - 假设弹出 k' 个元素, 即 k' = min{k, |S|}
> >    - 实际成本 $c_i=k'$；
> >    - 势能减少: $ΔΦ=-k'$；
> >    - 即 $c_i'=0$；
> >
> > 故三种操作的摊还成本均为 O(1), 与记账法结论一致.

#### 1.2.8 Potential Method 分析 Splay Trees

> 感觉是最<s>恶心</s>难的部分

我们需要证明将树中任意结点 X 伸展（Splay）到根结点的摊还时间复杂度为 O(logN).

> **引理: Rank**
>
> 对伸展树中的任意结点 $i$, 作如下定义:
>
> - **子树大小 S(i)**: 以结点 $i$ 为根的子树中的结点总数（包含 $i$ 自身）.
> - 范围界限: $1 \leq S(i) \leq N$
> - **结点秩 R(i)**: 子树大小的对数值, 即: $R(i) = \log S(i)$
> - 范围界限: $0 \leq R(i) \leq \log N$
>
> > [!NOTE]
> >
> > 这里的“Rank”不是树的高度. 由于伸展树可能极度不平衡（高度可能达到 N）, 直接用高度无法得到对数界, 必须借助子树大小的对数来进行势能分析.

1. 整棵树的势能函数 (Potential Function)

整棵伸展树 $T$ 的总势能 $\Phi(T)$ 定义为树中所有结点的秩之和:

$$
\Phi(T) = \sum_{i \in T} R(i) = \sum_{i \in T} \log S(i)
$$

- **物理意义**: 一棵极度不平衡的树（如退化成链的树）, 底部结点子树较小, 但顶部存在大量较大的子树, 整体势能较高.
- **分摊机制**: 虽然某些旋转操作会花费较高的实际成本, 但它们会显著降低整棵树的总势能, 从而释放势能来“支付”实际开销.

2. 旋转成本与摊还成本分析

设某次旋转操作前结点 $X$ 的秩为 $R_1(X)$, 旋转后的秩为 $R_2(X)$. 由于 $X$ 在旋转中向上移动, 其子树大小必然增加或不变, 因此始终有 $R_2(X) \geq R_1(X)$.

根据势能法公式, 某步操作的**摊还成本** $\hat{c}_i = \text{实际成本} + \Delta\Phi$.

3. 分析三种旋转修正的势能

> **3.1 Zig**（单旋）
>
> - 实际成本: $1$
> - 势能变化: 只有 $X$ 和其父结点 $P$ 的子树大小发生改变. 由于旋转后 $P$ 成了 $X$ 的孩子, 其子树变小或不变, 即 $R_2(P) - R_1(P) \leq 0$.
> - 摊还成本:
>   $$
>   \hat{c}_{\text{zig}} = 1 + R_2(X) - R_1(X) + R_2(P) - R_1(P) \leq 1 + R_2(X) - R_1(X)
>   $$

> **3.2 Zig-zag**（双旋: 一左一右 或 一右一左）
>
> - 实际成本: $2$
> - 摊还成本: 涉及 $X$、父结点 $P$ 和祖父结点 $G$ 的秩变化. 利用对数函数的凹凸性及子树大小关系可以证明:
>   $$
>   \hat{c}_{\text{zig-zag}} \leq 2(R_2(X) - R_1(X)) \leq 3(R_2(X) - R_1(X))
>   $$

> **3.3 Zig-zig**（双旋: 同左 或 同右）
>
> - 实际成本: $2$
> - 摊还成本: 同样通过代数放缩和秩的变化关系, 可以证明:
>   $$
>   \hat{c}_{\text{zig-zig}} \leq 3(R_2(X) - R_1(X))
>   $$

> **统一结论 (Access Lemma)**: 无论哪种双旋（Zig-zag 或 Zig-zig）, 其单步摊还成本都可以被放宽并严格界定为:
>
> $$
> \hat{c}_i \leq 3(R_2(X) - R_1(X))
> $$

4. 望远镜消去与最终复杂度证明

将结点 $X$ 从底端伸展至根结点, 整个过程由若干次双旋（Zig-zig / Zig-zag）以及至多一次单旋（Zig, 仅在最后一步可能发生）组成.

将所有步骤的摊还成本累加时, $X$ 在各步的秩变化 $(R_2 - R_1) + (R_3 - R_2) + \dots$ 会发生**望远镜消去（Telescoping Sum）**:

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
> 这一严格的数学界限证明了: 尽管单次伸展操作在最坏情况下的实际耗时可能达到 $O(N)$, 但经过势能平摊后, 连续多次访问的平均单次复杂度始终稳定在 $O(\log N)$.

#### 1.2.9 Amortized Analysis 总览 (Astra)

**摊还分析（Amortized Analysis）**研究的是：从某个初始状态开始，连续进行一系列操作时，每次操作的平均代价。

其特点为：

- 不涉及概率；
- 某一次操作可以非常慢；
- 关注一整串连续操作的总成本；
- 若连续 $M$ 次操作总成本为 $O(M\log N)$，则每次操作的摊还复杂度为 $O(\log N)$。

一般有：

$$
\text{worst-case bound}
\ge
\text{amortized bound}
\ge
\text{average-case bound}
$$

摊还分析主要有三种方法：

- Aggregate Analysis
- Accounting Method
- Potential Method

**Aggregate Analysis**

直接分析 $n$ 次操作的总成本 $T(n)$，再除以操作次数：

$$
T_{\text{amortized}}=\frac{T(n)}{n}
$$

典型例子是带 `MultiPop` 的栈：

```c
while (!IsEmpty(S) && k > 0) {
    Pop(S);
    k--;
}
```

单独一次 `MultiPop` 最坏可能需要弹出 $O(n)$ 个元素，但对于从空栈开始的 $n$ 次 `Push`、`Pop`、`MultiPop` 操作，一个元素必须先被 `Push` 进入栈，且每次进入栈后最多被 `Pop` 一次。

因此所有 `Pop` 的总次数不会超过所有 `Push` 的总次数，所以：

$$
T(n)=O(n)
$$

从而：

$$
T_{\text{amortized}}
=
\frac{O(n)}{n}
=
O(1)
$$

核心思想是：**不能把某一次操作的最坏复杂度直接乘以操作次数，而应该分析昂贵操作在整个操作序列中最多能发生多少次。**

**Accounting Method**

Accounting Method 可以理解为“提前收费”。

设：

- $c_i$：第 $i$ 次操作的实际成本（actual cost）；
- $\hat c_i$：第 $i$ 次操作的摊还成本（amortized cost）；
- $\hat c_i-c_i$：多收取的部分，称为 Credit。

如果某次操作：

$$
\hat c_i>c_i
$$

则多出的成本作为 Credit 保存起来，用于支付以后实际成本较高的操作。

必须保证：

$$
\sum_{i=1}^{n}\hat c_i
\ge
\sum_{i=1}^{n}c_i
$$

即总摊还成本不能小于实际总成本。

对于 Stack + MultiPop，可以规定：

| Operation | Actual Cost $c_i$ | Amortized Cost $\hat c_i$ |
| --------- | ----------------: | ------------------------: |
| Push      |                 1 |                         2 |
| Pop       |                 1 |                         0 |
| MultiPop  |  实际弹出元素个数 |                         0 |

每执行一次 `Push`：

- 实际花费 1；
- 摊还成本记为 2；
- 多出的 1 作为 Credit 保存在这个元素上。

以后这个元素被 `Pop` 时，使用之前保存的 Credit 支付，因此：

$$
\hat c_{\text{Pop}}=0
$$

对于 `MultiPop`，每弹出一个元素，都使用该元素之前保存的 Credit 支付，因此：

$$
\hat c_{\text{MultiPop}}=0
$$

于是：

$$
T_{\text{amortized}}=O(1)
$$

Accounting Method 的本质是：

> 便宜操作提前多支付一些成本，把 Credit 留给未来昂贵的操作。

**Potential Method**

Potential Method 可以看作 Accounting Method 的整体形式。

定义数据结构当前状态 $D$ 的势能函数：

$$
\Phi(D)
$$

势能可以理解为：

> 已经支付、但尚未真正使用的工作量。

第 $i$ 次操作的摊还成本定义为：

$$
\boxed{
\hat c_i
=
c_i+\Phi(D_i)-\Phi(D_{i-1})
}
$$

其中：

$$
\Delta\Phi
=
\Phi(D_i)-\Phi(D_{i-1})
$$

表示本次操作造成的势能变化。

若：

$$
\Delta\Phi>0
$$

说明本次操作除了完成实际工作，还为未来储存了一部分工作量。

若：

$$
\Delta\Phi<0
$$

说明当前操作使用了之前储存的势能。

连续 $n$ 次操作的摊还成本之和为：

$$
\sum_{i=1}^{n}\hat c_i
=
\sum_{i=1}^{n}
\left(
c_i+\Phi(D_i)-\Phi(D_{i-1})
\right)
$$

展开后中间势能项相互抵消：

$$
\boxed{
\sum_{i=1}^{n}\hat c_i
=
\sum_{i=1}^{n}c_i
+
\Phi(D_n)-\Phi(D_0)
}
$$

因此通常希望势能函数满足：

$$
\Phi(D_i)\ge\Phi(D_0)
$$

从而：

$$
\sum_{i=1}^{n}\hat c_i
\ge
\sum_{i=1}^{n}c_i
$$

对于 Stack + MultiPop，可以选择：

$$
\Phi(D_i)=\text{栈中元素的个数}
$$

初始为空栈：

$$
\Phi(D_0)=0
$$

对于 `Push`：

$$
c_i=1
$$

势能增加 1：

$$
\Phi(D_i)-\Phi(D_{i-1})=1
$$

所以：

$$
\hat c_i=1+1=2
$$

对于 `Pop`：

$$
c_i=1
$$

势能减少 1：

$$
\Phi(D_i)-\Phi(D_{i-1})=-1
$$

所以：

$$
\hat c_i=1-1=0
$$

对于 `MultiPop`，若实际弹出 $k'$ 个元素：

$$
c_i=k'
$$

势能减少：

$$
\Phi(D_i)-\Phi(D_{i-1})=-k'
$$

因此：

$$
\hat c_i
=
k'-k'
=
0
$$

所以：

$$
\boxed{
T_{\text{amortized}}=O(1)
}
$$

三种方法可以总结为：

| Method             | 核心思想                                           |
| ------------------ | -------------------------------------------------- |
| Aggregate Analysis | 直接分析整串操作的总成本                           |
| Accounting Method  | 提前保存 Credit，用于支付未来操作                  |
| Potential Method   | 用势能函数 $\Phi(D)$ 表示整个数据结构保存的 Credit |

对于 **Splay Tree**，单次 Splay 操作最坏可能达到：

$$
O(N)
$$

但利用 Potential Method 可以证明其摊还复杂度为：

$$
\boxed{
O(\log N)
}
$$

定义：

$$
S(i)=\text{以节点 }i\text{ 为根的子树节点数，包括 }i
$$

节点的 Rank 定义为：

$$
R(i)=\log S(i)
$$

整棵树的势能定义为：

$$
\boxed{
\Phi(T)=\sum_{i\in T}\log S(i)
}
$$

Splay 操作中：

- Zig：1 次旋转；
- Zig-zag：2 次旋转；
- Zig-zig：2 次旋转。

虽然一次 Splay 可能执行很多次 rotation，但 rotation 会改变树的势能，势能的下降可以抵消一部分实际旋转成本。

最终可以证明：

$$
\boxed{
\hat c
\le
3(R(T)-R(X))+1
=
O(\log N)
}
$$

因此：

$$
\boxed{
\text{Splay Tree 单次操作最坏可以达到 }O(N)
}
$$

但：

$$
\boxed{
\text{Splay Tree 的摊还复杂度为 }O(\log N)
}
$$

需要区分三种复杂度：

- **Worst-case**：研究单独一次操作的最坏情况；
- **Average-case**：研究某种概率分布下的平均情况，需要概率；
- **Amortized**：研究一整串连续操作的总成本，不涉及概率。

最重要的两个公式为：

$$
\boxed{
\hat c_i
=
c_i+\Phi(D_i)-\Phi(D_{i-1})
}
$$

以及：

$$
\boxed{
\sum_{i=1}^{n}\hat c_i
=
\sum_{i=1}^{n}c_i
+
\Phi(D_n)-\Phi(D_0)
}
$$

最终需要记住：

> Aggregate Analysis 看总成本；Accounting Method 用 Credit；Potential Method 用势能函数。摊还分析不涉及概率，允许单次操作很慢，只要求连续一系列操作的总成本具有较好的上界。

### 1.3 Red-Black Trees

依旧经典问题起手:

<center>Why Not AVL but Red-Black ?</center>

AVL Trees 要求任意节点左右子树得高度差不能超过 1, 实际上该要求是比较严格的.

对于 AVL Trees 来说, 其优势显而易见, 就是矮, 查找稳定, 但是每一次插入和删除都需要不断地调整, 非常麻烦.

此时, 红黑树就拥有了存在的必要性.

#### 1.3.1 基本思想

> [!IMPORTANT]
>
> 红黑树不追求严格的高度平衡, 而是通过结点颜色约束, 保证最长路径不会比最短路径长太多.

且红黑树仍能保证树高的基本性质 h = O(logN).

#### 1.3.2 Red-Black Trees 定义

1. **每个节点非红即黑: **显然, 每个节点拥有一个颜色字段, 其为 Red 或者 Black, 当然其无真正的实际意义, 只是用来维持平衡.

2. **根节点是黑色: **插入的过程可能会使根暂时变红, 但最后插入完毕后将根染黑即可.

3. **所有的 NIL 叶节点均为黑色: **我们把空孩子看作特殊的外部节点, 称为 NIL, 也就是说, 存储真实键值的是内部节点, 而空指针是外部 NIL 节点.

4. **红节点的孩子必须是黑色: **也就是说, 连续两个红色孩子相连是违法的.

5. **从任意节点到其所有后代的 NIL 的路径中, 黑节点数必须相同: **这里给个示例, 从节点

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

结构体定义：

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

定义: 从 x 向下到任意 NIL 叶结点的简单路径中, 黑结点的数量, 记为 bh(x).

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
h≤2log_2(N+1)
$$

其中 h 是红黑树的高度, N 为红黑树的内部节点数. 下面给出一个简单的证明.

> **证明红黑树的树高**
>
> 首先证明每个以 x 为根的子树至少有 $2^{bh(x)}-1$ 个内部真实节点, 这里需要归纳假设.
>
> > **引理: 证明子树节点数公式**
> >
> > 1. 若 x 是 NIL, 则 bh(x) 显然是 0, 注意黑高不把 x 自身算在内；
> > 2. 归纳假设, 若 x 是平凡内部节点, 其孩子的黑高至少是 bh(x) - 1, 根据归纳假设, 其孩子的子树拥有至少 $2^{bh(x)-1}-1$ 个内部真实节点；
> > 3. 此时有 $size(x) \ge 1+2(2^{bh(x)-1}-1) = 2^{bh(x)}-1$.
> >
> > 由此, 假设成立.
>
> 其次, 根据红黑树的第四条性质, 我们知道红色的节点相连是违法的, 因此每一条路径中黑节点数必须大于等于该路径节点数的一半, 即 bh(x) ≥ h/2.
>
> 最后, 合并两个结论有:
>
> $$
> h≤2log_2(N+1)
> $$
>
> 这就说明虽然 Red-Black Trees 没有 AVL Trees 那样严格的平衡, 但其树高依然满足 O(logN), 因此查找时间依旧为 O(logN).

#### 1.3.5 查找、插入和删除

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

> **查找**
>
> 极易理解, 因为和 BST 完全一致, 不多赘述.
>
> 由于树高为 O(logN), 因此查找的时间复杂度同为 O(logN).
>
> ```c
> RBNode *search(RBNode *root, int key)
> {
>     while (root != NIL && root->key != key)
>     {
>         if (key < root->key)
>         {
>             root = root->left;
>         }
>         else
>         {
>             root = root->right;
>         }
>     }
>     return root;
> }
> ```

> **插入**
>
> Red-Black Trees 的插入主要分为两步, 首先是按照普通的 BST 规则插入, 其次是修复节点颜色. 在此我们直接略过 BST 插入部分.
>
> 1. 新插入的元素, 默认是红色；
>
>    > [!WARNING]
>    >
>    > 如果是黑色, 直接破坏了相关路径的 bh(x), 很容易直接违反不同路径黑高相同的经典性质.
>
> > **引理: 四个关键元素**
> >
> > 1. G: 祖父结点 Grandparent
> > 2. P: 父结点 Parent
> > 3. U: 叔叔结点 Uncle
> > 4. x: 当前结点
> >
> > 以下给出一个示例:
> >
> > ```c
> >           G
> >          / \
> >         P   U
> >        /
> >       x
> > ```
>
> 2. 不需要修复的情况如下:
>    - 新节点成为根, 无脑将其染成黑色, 因为根节点永远是黑色；
>    - 父节点是黑色, 那么直接插入即可, 因为如果染黑就会破坏 bh(x).
> 3. 插入总体有三种 Case, 如下:
>
>    > **Case 1: 叔叔节点是红色**
>    >
>    > ```c
>    >           黑 G                            红 G
>    >          /    \                          /    \
>    >        红 P   红 U        ---->        黑 P   黑 U
>    >        /                               /
>    >      红 x                            红 x
>    > ```
>    >
>    > 此时我们需要 P 染黑, U 染黑, G 染红即可.
>
>    > **Case 2: 叔叔黑色, 形成折线**
>    >
>    > ```c
>    >          黑 G                            黑 G
>    >          /                               /
>    >        红 P           ---->            红 x
>    >          \                             /
>    >          红 x                        红 P
>    > ```
>    >
>    > 现在当然是不合法的状态, 因此顺势转入 Case 3.
>
>    > **Case 3: 叔叔黑色, 形成直线**
>    >
>    > ```c
>    >           黑 G
>    >          /                           黑 P
>    >        红 P          ---->           /   \
>    >        /                          红 x   红 G
>    >      红 x
>    > ```
>    >
>    > 将 P 染黑, 将 G 染红, 然后 G 右旋.
>
> 我们将其汇总起来即为:
>
> |  情况  | 叔叔颜色 |     结构      |              操作              |
> | :----: | :------: | :-----------: | :----------------------------: |
> | Case 1 |   红色   |     任意      | 父、叔染黑, 祖父染红, 继续向上 |
> | Case 2 |   黑色   | 折线 LR 或 RL |    旋转父结点, 转成 Case 3     |
> | Case 3 |   黑色   | 直线 LL 或 RR |    父黑、祖父红, 再旋转祖父    |
>
> 这里我们给到 cyll 的一个例子:
>
> <center>11,2,14,1,7,15,5,8,4</center>
>
> 插入 4 之前, 树长成如下的状态↓
>
> ```c
>             11黑
>            /    \
>          2红    14黑
>         /  \       \
>       1黑  7黑     15红
>           /  \
>         5红  8红
> ```
>
> 插入 4 之后, 树长成如下的状态↓
>
> ```c
>             11黑
>            /    \
>          2红    14黑
>         /  \       \
>       1黑  7黑     15红
>           /  \
>         5红  8红
>        /
>       4红
> ```
>
> 此时 x = 4, 5 和 8 均为红色, 故为 Case 1, 即 5 和 8 染黑, 7 染红后结果如下↓
>
> ```c
>             11黑
>            /    \
>          2红    14黑
>         /  \       \
>       1黑  7红     15红
>           /  \
>         5黑  8黑
>        /
>       4红
> ```
>
> 现在 7 和 2 同为红色, 令 x = 7, 此时 2 为父亲, 11 为祖父, 14 为叔叔, 2 为 11 的左孩子, 7 是 2 的右孩子, 符合 Case 2 的条件；
>
> 对 2 左旋, 形成 Case 3, 将 7 染黑, 将 11染红, 最后对 11 右旋, 最终根为 7.
>
> ```c
>              7黑
>            /     \
>          2红     11红
>         /  \     /  \
>       1黑  5黑  8黑 14黑
>            /          \
>          4红          15红
> ```
>
> **时间复杂度**
>
> 查找插入位置为 O(h) = O(logN)
>
> 颜色修复可能沿祖先路径上移, 故依然为 O(logN)
>
> 注意旋转次数最多只有 2 次.
>
> ```c
> void leftRotate(RBNode **root, RBNode *x)
> {
>     RBNode *y = x->right;
> 
>     x->right = y->left;
> 
>     if (y->left != NIL)
>         y->left->parent = x;
> 
>     y->parent = x->parent;
> 
>     if (x->parent == NIL)
>     {
>         *root = y;
>     }
>     else if (x == x->parent->left)
>     {
>         x->parent->left = y;
>     }
>     else
>     {
>         x->parent->right = y;
>     }
> 
>     y->left = x;
>     x->parent = y;
> }
> 
> void rightRotate(RBNode **root, RBNode *y)
> {
>     RBNode *x = y->left;
> 
>     y->left = x->right;
> 
>     if (x->right != NIL)
>         x->right->parent = y;
> 
>     x->parent = y->parent;
> 
>     if (y->parent == NIL)
>     {
>         *root = x;
>     }
>     else if (y == y->parent->left)
>     {
>         y->parent->left = x;
>     }
>     else
>     {
>         y->parent->right = x;
>     }
> 
>     x->right = y;
>     y->parent = x;
> }
> 
> RBNode *bstInsert(RBNode **root, int key)
> {
>     RBNode *z = newNode(key);
> 
>     RBNode *y = NIL;
>     RBNode *x = *root;
> 
>     while (x != NIL)
>     {
>         y = x;
> 
>         if (key < x->key)
>         {
>             x = x->left;
>         }
>         else if (key > x->key)
>         {
>             x = x->right;
>         }
>         else
>         {
>             free(z);
>             return NIL;
>         }
>     }
> 
>     z->parent = y;
> 
>     if (y == NIL)
>     {
>         *root = z;
>     }
>     else if (z->key < y->key)
>     {
>         y->left = z;
>     }
>     else
>     {
>         y->right = z;
>     }
> 
>     return z;
> }
> 
> void insertFixup(RBNode **root, RBNode *z)
> {
>     while (z->parent->color == RED)
>     {
>         if (z->parent ==
>             z->parent->parent->left)
>         {
>             RBNode *uncle =
>                 z->parent->parent->right;
> 
>             /* Case 1：叔叔是红色 */
>             if (uncle->color == RED)
>             {
>                 z->parent->color = BLACK;
>                 uncle->color = BLACK;
> 
>                 z->parent->parent->color = RED;
> 
>                 z = z->parent->parent;
>             }
> 
>             else
>             {
>                 /* Case 2：LR */
>                 if (z == z->parent->right)
>                 {
>                     z = z->parent;
> 
>                     leftRotate(root, z);
>                 }
> 
>                 /* Case 3：LL */
>                 z->parent->color = BLACK;
> 
>                 z->parent->parent->color = RED;
> 
>                 rightRotate(
>                     root,
>                     z->parent->parent);
>             }
>         }
> 
>         /* 完全对称 */
>         else
>         {
>             RBNode *uncle =
>                 z->parent->parent->left;
> 
>             /* Case 1 */
>             if (uncle->color == RED)
>             {
>                 z->parent->color = BLACK;
>                 uncle->color = BLACK;
> 
>                 z->parent->parent->color = RED;
> 
>                 z = z->parent->parent;
>             }
> 
>             else
>             {
>                 /* Case 2：RL */
>                 if (z == z->parent->left)
>                 {
>                     z = z->parent;
> 
>                     rightRotate(root, z);
>                 }
> 
>                 /* Case 3：RR */
>                 z->parent->color = BLACK;
> 
>                 z->parent->parent->color = RED;
> 
>                 leftRotate(
>                     root,
>                     z->parent->parent);
>             }
>         }
>     }
> 
>     (*root)->color = BLACK;
> }
> 
> void rbInsert(RBNode **root, int key)
> {
>     RBNode *z = bstInsert(root, key);
> 
>     if (z != NIL)
>         insertFixup(root, z);
> }
> ```

> **删除**
>
> 先进行普通的 BST 删除规则
>
> 1. 删除叶节点: 直接使用指针断开其与父节点的连接即可；
> 2. 删除只有一个孩子的节点: 直接用它唯一的孩子替代它；
> 3. 删除有两个孩子的节点: 取用左子树的最大值节点（中序前驱）或右子树的最小节点（中序后继）进行替代, 复制到目标节点后删除该替代节点. （Keep the color）
>
> 删除的一些情况:
>
> 1. 删除红色叶子节点, 直接删除即可；
> 2. 删除黑色节点, 且其有一个红色孩子, 即将其孩子替代它后染成黑色；
> 3. 最困难的情况莫过于, 删除了一个黑色的节点, 而替代它的是一个黑色的节点或者 NIL, 这样直接删除的话会使得该路径直接少一个黑色节点.
>
>    > [!IMPORTANT]
>    >
>    > 为了表述这种状态, 常把替代位置 x 表示为“双黑节点”, 是一种分析状态, 表示该路径目前缺少一个黑色节点, 需要补偿.
>
> 为了做到真正的删除, 我们需要首先定义其节点的角色
>
> > **节点角色**
> >
> > - x: 当前缺少一个黑色的结点, 可能是 NIL；
> > - p: x 的父结点；
> > - w: x 的兄弟结点 sibling；
> >
> > 对于其他的节点我们也一起做定义:
> >
> > ```c
> >           p
> >          / \
> >         x   w
> >            / \
> >          near far
> > ```
> >
> > w 的左孩子离 x 较近, 成为 near child, 同理离得远的叫 far child.
>
> 删除的**四种情况**:
>
> 1. **Case 1**: 兄弟 w 是红色
>    - 则将 w 染黑, 将 p 染红, 再对 p 左旋
>
>    ```c
>              黑 p                             黑 w
>             /    \                           /
>          双黑 x  红 w      ---->          红 p
>                  / \                     /    \
>                黑   黑               双黑 x      新兄弟
>    ```
>
>    一般来说 Case 1 不会直接解决问题, 而是转换后进入 Case 2 或者 Case 3 或者 Case 4.
>
> 2. **Case 2**: 兄弟是黑色, 两个孩子也都是黑色
>    - 将兄弟 w 染红, 这样相当于从兄弟那条路径中拿走一个黑色, 使左右两边在当前层重新相等.
>
>    ```c
>               p                             p
>             /   \                          / \
>          双黑 x  黑 w      ---->      双黑 x  红 w
>                  / \
>                黑   黑
>    ```
>
>    **子情况 2.1（父结点是红色）: ** 把父结点染黑（父红 → 父黑）. 缺少的黑色由父结点补上, 问题解决.
>
>    **子情况 2.2（父结点也是黑色）: ** 当前局部虽然平衡了, 但整个子树相对于更高层仍然缺少一个黑色. 所以将 x ← p（把“双黑”问题向上移动）, 继续检查. 如果 x 最终成为根, 则可以直接停止, 因为整棵树所有路径同时少一个黑色, 并不会导致路径之间不一致.
>
> 3. **Case 3**: 兄弟黑, 近孩子红, 远孩子黑
>    - 将近孩子染黑, w 染红, 再对 w 右旋；
>    - 得到的新兄弟具有红色远孩子, 从而转成 Case 4.
>
>    ```c
>              p                              p
>             / \                            / \
>          双黑 x  黑 w      ---->       双黑 x  黑 near
>                  / \                             \
>                红   黑                           红 w
>               near  far                           \
>                                                    黑 far
>    ```
>
>    Case 3 的目的与插入中的折线调整类似, 是把结构转换成 Case 4.
>
> 4. **Case 4**: 兄弟黑, 远孩子红
>    - 将 w 染成原父结点 p 的颜色, 将 p 染黑, 将远孩子染黑, 再对 p 左旋；
>    - 旋转后, 两侧路径的黑结点数量恢复一致, 双黑问题彻底解决.
>
>    ```c
>              p                             w (原 p 颜色)
>             / \                                / \
>          双黑 x  黑 w      ---->          黑 p  黑 far
>                  / \                         /   \
>                 ?   红 far                 黑 x   ?
>    ```
>
>    补充: 如果 x 在右侧, 则全部处理左右对称:
>    - Case 1 对父结点右旋；
>    - Case 3 对兄弟左旋；
>    - Case 4 对父结点右旋.
>
> 红黑树删除复杂度:
>
> 查找与普通删除需要 O(logN), Case 2 可能不断地向上推, 所以颜色修正可能也是 O(logN), 但旋转次数最多只有 3 次（Case 1、3、4 各一次）, 因此删除总时间仍为 O(logN).
>
> ```c
> RBNode *minimum(RBNode *root)
> {
>     while (root->left != NIL)
>         root = root->left;
> 
>     return root;
> }
> 
> 
> void transplant(RBNode **root, RBNode *u, RBNode *v)
> {
>     if (u->parent == NIL)
>     {
>         *root = v;
>     }
>     else if (u == u->parent->left)
>     {
>         u->parent->left = v;
>     }
>     else
>     {
>         u->parent->right = v;
>     }
> 
>     v->parent = u->parent;
> }
> 
> 
> void deleteFixup(RBNode **root, RBNode *x)
> {
>     while (x != *root && x->color == BLACK)
>     {
>         /* x 是左孩子 */
>         if (x == x->parent->left)
>         {
>             RBNode *w = x->parent->right;
> 
>             /* Case 1: sibling 是 RED */
>             if (w->color == RED)
>             {
>                 w->color = BLACK;
>                 x->parent->color = RED;
> 
>                 leftRotate(root, x->parent);
> 
>                 w = x->parent->right;
>             }
> 
>             /* Case 2: sibling 黑，两个孩子都黑 */
>             if (w->left->color == BLACK &&
>                 w->right->color == BLACK)
>             {
>                 w->color = RED;
> 
>                 x = x->parent;
>             }
>             else
>             {
>                 /* Case 3:
>                    sibling 黑
>                    近孩子红
>                    远孩子黑
>                 */
>                 if (w->right->color == BLACK)
>                 {
>                     w->left->color = BLACK;
>                     w->color = RED;
> 
>                     rightRotate(root, w);
> 
>                     w = x->parent->right;
>                 }
> 
>                 /* Case 4:
>                    sibling 黑
>                    远孩子红
>                 */
>                 w->color = x->parent->color;
> 
>                 x->parent->color = BLACK;
>                 w->right->color = BLACK;
> 
>                 leftRotate(root, x->parent);
> 
>                 x = *root;
>             }
>         }
> 
>         /* x 是右孩子，完全左右对称 */
>         else
>         {
>             RBNode *w = x->parent->left;
> 
>             /* Case 1 */
>             if (w->color == RED)
>             {
>                 w->color = BLACK;
>                 x->parent->color = RED;
> 
>                 rightRotate(root, x->parent);
> 
>                 w = x->parent->left;
>             }
> 
>             /* Case 2 */
>             if (w->right->color == BLACK &&
>                 w->left->color == BLACK)
>             {
>                 w->color = RED;
> 
>                 x = x->parent;
>             }
>             else
>             {
>                 /* Case 3 */
>                 if (w->left->color == BLACK)
>                 {
>                     w->right->color = BLACK;
>                     w->color = RED;
> 
>                     leftRotate(root, w);
> 
>                     w = x->parent->left;
>                 }
> 
>                 /* Case 4 */
>                 w->color = x->parent->color;
> 
>                 x->parent->color = BLACK;
>                 w->left->color = BLACK;
> 
>                 rightRotate(root, x->parent);
> 
>                 x = *root;
>             }
>         }
>     }
> 
>     x->color = BLACK;
> }
> 
> 
> void rbDelete(RBNode **root, int key)
> {
>     RBNode *z = search(*root, key);
> 
>     if (z == NIL)
>         return;
> 
>     RBNode *y = z;
>     Color originalColor = y->color;
> 
>     RBNode *x;
> 
>     /* 情况 1：没有左孩子 */
>     if (z->left == NIL)
>     {
>         x = z->right;
> 
>         transplant(root, z, z->right);
>     }
> 
>     /* 情况 2：没有右孩子 */
>     else if (z->right == NIL)
>     {
>         x = z->left;
> 
>         transplant(root, z, z->left);
>     }
> 
>     /* 情况 3：左右孩子都有 */
>     else
>     {
>         /* 找右子树最小节点，即 successor */
>         y = minimum(z->right);
> 
>         originalColor = y->color;
> 
>         x = y->right;
> 
>         if (y->parent == z)
>         {
>             x->parent = y;
>         }
>         else
>         {
>             transplant(root, y, y->right);
> 
>             y->right = z->right;
>             y->right->parent = y;
>         }
> 
>         transplant(root, z, y);
> 
>         y->left = z->left;
>         y->left->parent = y;
> 
>         y->color = z->color;
>     }
> 
>     free(z);
> 
>     /* 只有真正移走的是 BLACK 才需要修复 */
>     if (originalColor == BLACK)
>     {
>         deleteFixup(root, x);
>     }
> }
> ```

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
| 删除  | 最坏 O(logN) 次旋转 | 最多 3 次旋转 |

再给出一个对比表:

|   特点   |     AVL 树     |         红黑树         |
| :------: | :------------: | :--------------------: |
| 平衡要求 |     更严格     |         更宽松         |
|   树高   |    通常更低    | 最多约为理想高度的两倍 |
|   查找   |    通常稍快    |      也是 O(logN)      |
| 插入删除 |    调整较多    |      旋转通常较少      |
| 额外信息 | 高度或平衡因子 |        1 位颜色        |
| 典型用途 |  查找特别频繁  |    动态插入删除频繁    |

### 1.4 B+ Trees

我们希望一个结点一次存放很多关键字和很多孩子指针, 因此 B+ Trees 就是来干这个的；

> **引理: B+ Trees 的阶（Order）**
>
> 我们记一棵 B+ Trees 的阶为 M, 也就是说, 内部节点最多有 M 个孩子.
>
> > [!NOTE]
> >
> > 另外, 这也意味着一个内部节点最多拥有 M - 1 个分隔关键字.

#### 1.4.1 B+ Trees 的结构性质

1. 对于任何根节点, 其可以本身就是叶子节点, 也可以拥有 2 ~ M 个孩子；

2. 对于任意内部非根节点, 其拥有 ⌈M/2⌉ ~ M 个孩子, 即至少半满.

另外, B+ 树所有叶节点都处在同一层, 即所有真实数据**叶结点**都处在同一层, 所以 B+ 树是一棵严格的高度平衡树.

同时, 叶子节点也是至少半满, 即叶子节点数在 ⌈M/2⌉ ~ M 范围内.

#### 1.4.2 节点存储值

1. **内部节点**

假如一个内部节点有四个孩子: P0、P1、P2、P3, 那么该节点存储 3 个分隔关键字, 记为 K1、K2、K3, 这三个分隔关键字和 P0、P1、P2、P3 的对应关系如下:

- P0: key < K1；
- P1: K1 ≤ key < K2；
- P2: K2 ≤ key < K3；
- P3: key ≥ K3

2. **叶子节点**

> [!IMPORTANT]
>
> B+ Trees 的所有完整的数据记录都存放在叶结点中, 内部节点只存分隔关键字和子树指针.

叶子节点之间的链表类似 叶1 → 叶2 → 叶3 → 叶4 → ... 或 叶1 ⇄ 叶2 ⇄ 叶3 ⇄ 叶4；

例如查找 20≤key≤80 时, 只需要:

- 从根查找到第一个不小于 20 的叶结点；
- 沿叶子链表顺序向右扫描；
- 扫描到关键字大于 80 时停止.

#### 1.4.3 B+ Trees 的查找、插入和删除

> 1. **查找**
>
> 一般步骤是: 根 → 根据分隔关键字选择一个孩子 → 继续向下 → 到达叶结点 → 查找真实记录

> 2. **插入**
>
> **(1) 基本过程**——插入关键字 X:
>
> - 从根向下查找；
> - 找到 X 应该进入的叶结点；
> - 按顺序插入；
> - 如果结点未溢出, 结束；
> - 如果结点溢出, 将它分裂；
> - 把新的分隔关键字插入父结点；
> - 如果父结点也溢出, 继续向上分裂；
> - 如果根溢出, 产生一个新根.
>
> **(2) 未溢出的插入: **
>
> 假设一个叶结点为:
>
> <center>10 | 20 | 40</center>
>
> 插入 30:
>
> <center>10 | 20 | 30 | 40</center>
>
> 如果叶结点最大允许 4 条记录, 那么没有溢出, 插入完成, 可能需要更新父结点中的分隔关键字, 但不需要分裂.
>
> **(3) 叶结点分裂: **
>
> 假设四阶 B+ 树的叶结点最多存放 4 条记录.
>
> 原叶结点:
>
> <center>10 | 20 | 30 | 40</center>
>
> 插入 25:
>
> <center>10 | 20 | 25 | 30 | 40</center>
>
> 出现 5 条记录, 超过容量, 需要分裂.
>
> 可以平分为:
>
> <center>左叶: 10 | 20</center>
>
> <center>右叶: 25 | 30 | 40</center>
>
> 然后把右叶中的最小关键字 25 **复制**到父结点中作为分隔值:
>
> ```
>                                   25
>                                  /  \
>                           10 | 20    25 | 30 | 40
> ```
>
> 注意:
>
> > 25 仍然保留在右叶中.
>
> 因为真实数据必须存放在叶结点中, 所以叶结点分裂时, 分隔关键字通常是复制到父结点而不是从叶子中彻底移走.
>
> 同时还要维护叶子链表:
>
> <center>左叶 → 右叶 → 原来的下一个叶</center>
>
> **(4) 内部结点分裂: **
>
> 如果向父结点插入新分隔值后, 父结点也超过最大容量, 就必须分裂内部结点.
>
> 例如某内部结点最多有 4 个孩子, 现在变成 5 个孩子:
>
> <center>P0、P1、P2、P3、P4</center>
>
> 应当把它分成左右两个内部结点, 并把中间分隔关键字提升到父亲.
>
> 与叶结点分裂的区别是:
>
> - 叶结点分裂: 分隔键复制到父结点, 数据仍保留在叶子；
> - 内部结点分裂: 中间分隔键通常上升到父结点, 用于分开左右两部分.
>
> 具体左右各分多少个孩子, 要按照课程规定的向上或向下取整规则进行, 但是总体原则是**尽量平均分配**
>
> **(5) 根结点分裂: **
>
> 如果原根结点也溢出:
>
> <center>原根: P0、P1、P2、P3、P4</center>
>
> 将原根分成两个结点, 并创建一个新根:
>
> ```
>                  新根
>                 /    \
>             左结点    右结点
> ```
>
> 此时树高增加 1.
>
> B+ 树高度只会在根分裂时增加.
>
> 插入过程中, 无论发生多少次分裂, 所有叶结点仍然保持在同一深度.

> 3. **删除**
>
> 与插入正好相反, 插入处理的是节点过满 (overflow), 删除处理的是节点过空 (underflow).
>
> (1) **删除后仍然满足最低容量**
>
> 那么直接从叶结点删除记录.
>
> 例如:
>
> <center>10 | 20 | 30</center>
>
> 删除 20:
>
> <center>10 | 30</center>
>
> - 如果叶结点仍然至少半满, 操作结束；
> - 如果删除的是某个子树最小关键字, 还需要更新祖先中的分隔关键字.
>
> (2) **向兄弟借一个元素**
>
> 假设当前叶结点低于最低容量, 但相邻兄弟的元素数超过最低值.
>
> 例如最低要求 2 条:
>
> <center>当前叶: 10</center>
> <center>右兄弟: 20 | 30 | 40</center>
>
> 可以从右兄弟借出最小的 20:
>
> <center>当前叶: 10 | 20</center>
> <center>右兄弟: 30 | 40</center>
>
> 然后更新父结点中的分隔关键字, 这称为:
>
> - 借位；
> - 重新分配；
> - redistribution.
>
> cyll 的 PPT 里面说:
>
> > <center>寻找可以调整的兄弟结点</center>
>
> (3) **与兄弟合并**
>
> 如果当前结点元素不足, 而相邻兄弟也只有最低数量, 无法借出, 就进行合并.
>
> 例如:
>
> <center>当前叶: 10</center>
> <center>右兄弟: 20 | 30</center>
>
> 合并为:
>
> <center>10 | 20 | 30</center>
>
> 然后:
>
> - 删除一个叶结点；
> - 从父结点删除对应的分隔关键字和孩子指针；
> - 修复叶子链表.
>
> (4) **父结点也可能下溢**
>
> 合并会使父结点少一个孩子, 此时父结点可能也低于最小孩子数, 于是问题向上传递影响:
>
> <center>叶结点合并 → 父结点少一个孩子 → 父结点下溢 → 向父结点的兄弟借孩子或进行合并 → 可能一直传递到根</center>
>
> (5) **根结点缩短**
>
> 如果删除后根结点只剩一个孩子, 可以删除旧根, 让唯一孩子成为新根:
>
> <center>旧根</center>
> <center>↓</center>
> <center>唯一孩子</center>
>
> 变成:
>
> <center>新根</center>
>
> 注意, 此时树高减少 1.
>
> 所以, 结论如下:
>
> - B+ 树插入时, 根分裂会使高度增加；
> - B+ 树删除时, 根只剩一个孩子会使高度减少.

#### 1.4.4 B+ Trees 的高度

我们假设阶为 M, 那么每个内部节点至少有 ⌈M/2⌉ 个孩子, 因此树高为:

$$
O(log_{⌈M/2⌉}N)
$$

显而易见地, 通常分支 M 越大, 树越矮.

#### 1.4.5 查找复杂度

我们设每个内部节点最多线性扫描 M 个位置, 那么复杂度是 $O(M)$；

此时我们取树高约为 $O(log_{M}N)$, 则总成本为 $O(Mlog_{M}N)$

> **没用的引理**
>
> $$
> log_{M}N=\frac{logM}{logN}
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

在“每个结点线性扫描 $O(M)$”这一理论模型下, 需要考虑

$$
\frac{M}{logM}
$$

它在 M 接近自然常数 $e\approx2.718$ 时较小, 因此整数中 3 或 4 是较好的选择, 不过在真实数据库和文件系统中, M 往往远大于 4, 因为实际目标是:

> <center>让一个结点正好装满一个磁盘页, 尽量减少磁盘页面访问次数. </center>

#### 1.4.7 最终表格

最后, 同样是 ChatGPT 给的表, 也许有用:

|          特点          |         红黑树         |           B+ 树            |
| :--------------------: | :--------------------: | :------------------------: |
|        **类型**        |       二叉搜索树       |         多路搜索树         |
| **每个内部结点孩子数** |         最多 2         |          最多 (M)          |
|      **平衡方式**      |        颜色约束        | 所有叶子同层、结点至少半满 |
|      **数据存储**      | 每个真实结点都可存数据 |    完整数据集中在叶结点    |
|      **顺序扫描**      |      需要中序遍历      |       直接沿叶子链表       |
|        **树高**        |      $O(\log_2N)$      |        $O(\log_MN)$        |
|      **典型场景**      |        内存容器        | 数据库、文件系统、磁盘索引 |

## Chapter 2: Inverted File Index

### 2.1 Inverted File Index 是干什么的

假设你需要查找一百万篇文档里面, 哪些文档出现了 computer science 的字样, 最笨的方法当然是先找第一篇, 再找第二篇……一直到第一百万篇. 

以上就是方法一, 即逐个扫描所有网页. 

A little sample: 

| 文档  |                     内容                     |
| :---: | :------------------------------------------: |
| Doc 1 |              Gold silver truck               |
| Doc 2 |      Shipment of gold damaged in a fire      |
| Doc 3 | Delivery of silver arrived in a silver truck |
| Doc 4 |     Shipment of gold arrived in a truck      |

后面的分析全部基于以上表格信息, 其中, 我们将这些字母全部转为小写. 

这里我们引入方法二, 即 Term-Document Incidence Matrix, 也就是词项-文档关联矩阵. 



## Chapter 3: Heap

### 3.1 Leftist Heaps and Skew Heaps

动机：

## Chapter 6: Practice

### 6.1 判断题 && 单选题

#### Week 1.1

If the depth of an AVL tree is 6 (the depth of an empty tree is defined to be -1), then the minimum possible number of nodes in this tree is:

A. 13  
B. 17  
C. 20  
D. 33

**答案: D**

**解析: ** AVL 树达到给定高度时, 最少结点数满足

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

**解析: ** 最终 AVL 树的根为 4；2 和 6 是兄弟, 9 是 7 的父节点. 3 的父节点是 2, 而 7 的父节点是 9, 因此 3 和 7 不是兄弟.

#### Week 1.3

For the result of accessing the keys `3, 9, 1, 5` in order in the splay tree in the figure, which one of the following statements is FALSE?

A. 5 is the root  
B. 1 and 9 are siblings  
C. 6 and 10 are siblings  
D. 3 is the parent of 4

**答案: D**

**解析: ** Splay Tree 每次访问后都会把被访问结点旋转到根, 因此最后访问的 5 成为根；1 和 9 是兄弟, 6 和 10 是兄弟. 最终是 4 为 3 的父节点, 而不是 3 为 4 的父节点.

#### Week 1.4

关于摊还分析（Amortized Analysis）, 下列说法中哪一项是错误的？

A. 若任意 $n$ 次操作的总最坏代价为 $T(n)$, 则聚合分析得到的平均摊还代价为 $T(n)/n$  
B. 使用势能法时, 势能函数必须从最大值开始  
C. 会计法中, 多收取的代价可以作为 credit 保存, 用于支付之后较昂贵的操作  
D. 聚合分析对总成本取平均, 而会计法可以给不同类型操作分配不同的摊还代价

**答案: B**

**解析: ** 势能法通常要求初始势能满足 $\Phi(D_0)=0$, 并保证之后势能非负, 并不要求势能从最大值开始.

#### Week 1.5

动态数组 / buffer 在装满后采用扩容方式继续插入, 使用势能法分析其摊还复杂度. 题目给出的正确势能函数选项为“空闲块数量的相反数”.

**答案: D**

**解析: ** 若当前已有 $n$ 个元素、容量为 $m$, 空闲块数为 $m-n$, 因此其相反数为

$$
\Phi=n-m
$$

普通插入的摊还代价为常数；发生扩容时, 虽然实际代价较大, 但势能下降会抵消大部分代价, 因此每次插入的摊还复杂度仍为

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

**解析: ** 最终红黑树为:

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

**答案: C**

**解析: ** 删除 15 时可以使用前驱 11 或后继 17 替代, 因此 A、B、D 都可能出现在合法结果中；若 11 成为 17 的父节点, 则 11 必须为黑色, 因此 C 一定不成立.

#### Week 2.3

Insert `3, 1, 4, 5, 9, 2, 6, 8, 7, 0` into an initially empty 2-3 tree (with splitting). Which one of the following statements is FALSE?

A. 7 and 8 are in the same node  
B. the parent of the node containing 5 has 3 children  
C. the first key stored in the root is 6  
D. there are 5 leaf nodes

**答案: A**

**解析: ** 最终结构为:

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

**答案: D**

**解析: ** 删除 9 后发生合并并使树高下降, 最终可得到:

```text
             [4,6]
           /   |    \
      [1,2,3] [4,5] [6,7,8]
```

根结点已满, 第二个 key 为 6, 6 和 8 在同一叶结点中；5 在 `[4,5]`, 因此 D 错误.

#### Week 2.5

Which of the following statements concerning a B+ tree of order $M$ is TRUE?

A. the root always has between 2 and $M$ children  
B. not all leaves are at the same depth  
C. leaves and nonleaf nodes have some key values in common  
D. all nonleaf nodes have between $\lceil M/2\rceil$ and $M$ children

**答案: C**

**解析: ** B+ 树的所有叶结点都处在同一层；非叶结点只保存索引 key, 因此一些 key 会同时出现在非叶结点和叶结点中. 根结点是特殊情况, 所以 A、D 中的 `always/all` 均不成立.

#### Week 3.1

**题目**

In distributed indexing, document-partitioned strategy is to store on each node all the documents that contain the terms in a certain range.

- T
- F

**答案：F**

**解析：**

题目描述的是 **term-partitioned（按词项划分）**。

- Document-partitioned：每个节点负责一部分 documents，并为这些文档建立索引。
- Term-partitioned：每个节点负责一定范围的 terms。

因此题目错误。

---

#### Week 3.2

**题目**

When evaluating the performance of data retrieval, it is important to measure the relevancy of the answer set.

- T
- F

**答案：T**

**解析：**

评价信息检索系统不仅要考虑检索速度，也需要考虑返回结果的相关性。常用的相关性评价指标包括 Precision 和 Recall。

---

#### Week 3.3

**题目**

Precision is more important than recall when evaluating the explosive detection in airport security.

- T
- F

**答案：F**

**解析：**

机场爆炸物检测中更重要的是减少漏检，即提高 **Recall**。

宁可产生一定的误报，也不能漏掉真正的爆炸物，因此 Recall 通常比 Precision 更重要。

---

#### Week 3.4

**题目**

While accessing a term by hashing in an inverted file index, range searches are expensive.

- T
- F

**答案：T**

**解析：**

Hash Table 很适合精确查找，但哈希后的 key 没有保持大小顺序，因此范围查询需要检查大量位置，代价较高。

---

#### Week 3.5

**题目**

When measuring the relevancy of the answer set, if the precision is high but the recall is low, it means that:

A. most of the relevant documents are retrieved, but too many irrelevant documents are returned as well

B. most of the retrieved documents are relevant, but still a lot of relevant documents are missed

C. most of the relevant documents are retrieved, but the benchmark set is not large enough

D. most of the retrieved documents are relevant, but the benchmark set is not large enough

**答案：B**

**解析：**

Precision 高说明：

> 检索出来的文档中，大多数是相关文档。

Recall 低说明：

> 所有相关文档中，还有很多没有被检索出来。

因此选 B。

---

#### Week 3.6

**题目**

Which of the following is NOT concerned for measuring a search engine?

A. How fast does it index

B. How fast does it search

C. How friendly is the interface

D. How relevant is the answer set

**答案：C**

**解析：**

搜索引擎的主要性能指标包括：

- 建立索引的速度
- 查询速度
- 返回结果的相关性

界面是否友好属于用户界面设计，不属于这里衡量搜索引擎核心检索性能的指标。

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

**答案：C**

**解析：**

Recall 的定义为：

$$
Recall=
\frac{\text{Retrieved Relevant}}
{\text{All Relevant}}
$$

相关文档总数为：

$$
4000+8000=12000
$$

因此：

$$
Recall=\frac{4000}{12000}
=\frac13
\approx33\%
$$

所以选择 C。

---

#### Week 4.1

**题目**

The result of inserting keys $1$ to $2^k-1$ for any $k>4$ in order into an initially empty skew heap is always a full binary tree.

- T
- F

**答案：T**

**解析：**

对于依次插入

$$
1,2,\cdots,2^k-1
$$

的情况，Skew Heap 每次 Merge 后交换左右子树，会形成规则的二叉树结构。

当结点数恰好为 $2^k-1$ 时，最终得到 full binary tree，因此该说法正确。

---

#### Week 4.2

**题目**

The right path of a skew heap can be arbitrarily long.

- T
- F

**答案：T**

**解析：**

Skew Heap 不像 Leftist Heap 那样维护 Npl，也没有强制要求右路径必须较短。

因此某一时刻的 right path 可以非常长。Skew Heap 保证的是一系列操作的摊还复杂度，而不是每棵树都严格平衡。

---

#### Week 4.3

**题目**

Merge the two leftist heaps in the following figure. Which one of the following statements is FALSE?

![Leftist Heap](https://images.ptausercontent.com/131)

A. 2 is the root with 11 being its right child

B. the depths of 9 and 12 are the same

C. 21 is the deepest node with 11 being its parent

D. the null path length of 4 is less than that of 2

**答案：D**

**解析：**

合并后：

- 2 是根，11 是 2 的右孩子。
- 9 和 12 的深度相同。
- 21 是最深的结点，其父结点为 11。

同时：

$$
Npl(4)=Npl(2)=2
$$

所以并不存在：

$$
Npl(4)<Npl(2)
$$

因此 D 错误。

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

**答案：D**

**解析：**

第 $k$ 轮需要大约进行：

$$
\frac{N}{2^k}
$$

次 Merge，每次 Merge 的复杂度约为：

$$
O(\log 2^{k-1})
$$

因此：

$$
T(N)
=
O\left(
N\sum_{k=1}^{K}\frac{k-1}{2^k}
\right)
$$

而级数：

$$
\sum_{k=1}^{\infty}\frac{k}{2^k}
$$

收敛到常数，因此：

$$
T(N)=O(N)
$$

所以最坏时间复杂度不是 $\Theta(N\log N)$，D 错误。

---

#### Week 4.5

**题目**

Insert keys 1 to 15 in order into an initially empty skew heap. Which one of the following statements is FALSE?

A. the resulting tree is a complete binary tree

B. there are 6 leaf nodes

C. 6 is the left child of 2

D. 11 is the right child of 7

**答案：B**

**解析：**

依次插入 $1\sim15$ 后得到的 Skew Heap 为完整的 15 个结点结构。

其中：

- 6 是 2 的左孩子。
- 11 是 7 的右孩子。
- 叶子结点共有 8 个，而不是 6 个。

因此 B 错误。

---

#### Week 4.6

**题目**

Merge the two skew heaps in the following figure. Which one of the following statements is FALSE?

![Skew Heap](https://images.ptausercontent.com/195)

A. 15 is the right child of 8

B. 14 is the right child of 6

C. 1 is the root

D. 9 is the right child of 3

**答案：A**

**解析：**

Skew Heap 合并时，先沿 right path 进行 Merge，然后将合并路径上结点的左右子树交换。

合并以后：

- 1 仍然是根。
- 9 是 3 的右孩子。
- 14 是 6 的右孩子。
- 8 不在需要交换的合并路径上，因此 15 仍然是 8 的左孩子。

所以：

> 15 is the right child of 8

是错误的，选择 A。

### 6.2 编程题 && 程序填空题

#### Week 1: 7-1 Root of AVL Tree

**题意: ** 给出 $N$ 个互不相同的整数, 依次插入一棵初始为空的 AVL 树, 最后输出 AVL 树根结点的 key.

**核心思路: **

1. 先按照 BST 规则递归插入；
2. 回溯时更新结点高度；
3. 计算平衡因子 `height(left) - height(right)`；
4. 若失衡, 根据 LL、RR、LR、RL 四种情况进行旋转；
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

**题意: ** 实现 order 3 的 B+ 树, 支持初始化、插入、重复 key 检测、结点分裂, 并最终按照层序打印整棵树.

本题中:

- 叶结点最多保存 3 个 key, 第 4 个 key 插入时分裂；
- 非叶结点最多保存 2 个索引 key, 第 3 个索引 key 出现时分裂；
- 叶结点分裂时, 中间 key 是**复制**到父结点；
- 非叶结点分裂时, 中间 key 是**上移**到父结点；
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

**关键点: **

- 查找内部结点时, 若 `x >= key[i]`, 应继续向右侧孩子走；
- 叶结点 `[a,b,c,d]` 分裂为 `[a,b]` 和 `[c,d]`, 并把 `c` 复制给父结点；
- 非叶结点 `[a,b,c]` 分裂为 `[a]` 和 `[c]`, 把 `b` 上移；
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

<div style="display: block !important; text-align: right !important; margin-top: 60px !important; padding-right: 20px !important; font-family: '钟齐志莽行书', cursive !important; font-size: 26px !important; font-weight: bold !important; font-style: italic !important; color: #6b4423 !important;">邓欢桐</div>
