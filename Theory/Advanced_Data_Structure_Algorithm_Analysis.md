# <center>高级数据结构与算法分析</center>

<center>浙江大学 竺可桢学院 混合2504班 邓欢桐 3250102223</center>

---

<center>
<img src="/20260323101520_871_96.png" style="zoom: 60%;" />
<img src="/20260323101521_872_96.png" style="zoom: 20%;" />
<img src="/ckc.png" style="zoom: 25%;" />
</center>


---

[[toc]]

> 当前范围: 按课件顺序覆盖到 ADS08 Dynamic Programming. ADS01 AVL / Splay 与 ADS02 Red-Black / B+ Trees 对应第一章, ADS03 对应第二章, ADS04 对应第三章, ADS05 对应第四章, ADS06 / ADS07 对应第五、六章, ADS08 对应第七章; 原习题与 Binary Heap 补充保留在第八章. [ADS00 课程导论](<../lesson/Materials/Student Slides/ADS00.ppt>)主要介绍课程安排和参考书, 不包含待补的算法实现.

> 代码使用说明: 各算法独立编译, 同名的 insert、search 等函数不要跨章混在一个源文件里. [完整源码与运行方法](./code/README.md)给出本笔记全部可运行示例; 题目原文中的填空保留, 后面提供完整答案.

<div style="display: block !important; text-align: center !important; margin: 60px auto 20px !important; padding: 20px 0 !important; width: 85% !important; border-top: 1px dashed var(--wi-epigraph-border) !important; border-bottom: 1px dashed var(--wi-epigraph-border) !important; font-family: '钟齐志莽行书', cursive !important; font-size: 20px !important; line-height: 1.8 !important; letter-spacing: 2px !important; font-weight: normal !important; font-style: italic !important; color: var(--wi-quote-text) !important;">" 我终于, 自由了!"<span style="display: block !important; text-align: right !important; margin-top: 10px !important; font-size: 18px !important;">-- 2026.7.4 玉湖七幢</span></div>

## Chapter 1: Trees

### 1.1 AVL Trees

> 完整可运行源码: [avl.c](./code/avl.c). 下方按操作拆开讲解, 同一算法的代码配套使用.

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

#### 1.1.8 为什么 AVL Trees 一定只有 O(logN) 高

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
    if (node == NULL) exit(EXIT_FAILURE);
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

接下来把查找和删除真正写出来. 删除后的每一层都要重新计算高度, 而且孩子 BF 为 0 时也可能需要单旋:

```c
AVLNode *search(AVLNode *root, int key)
{
    while (root != NULL && root->key != key)
        root = key < root->key ? root->left : root->right;
    return root;
}

AVLNode *findMin(AVLNode *root)
{
    if (root == NULL) return NULL;
    while (root->left != NULL) root = root->left;
    return root;
}

AVLNode *findMax(AVLNode *root)
{
    if (root == NULL) return NULL;
    while (root->right != NULL) root = root->right;
    return root;
}

AVLNode *deleteNode(AVLNode *root, int key)
{
    if (root == NULL) return NULL;
    if (key < root->key)
        root->left = deleteNode(root->left, key);
    else if (key > root->key)
        root->right = deleteNode(root->right, key);
    else
    {
        if (root->left == NULL || root->right == NULL)
        {
            AVLNode *child = root->left != NULL ? root->left : root->right;
            free(root);
            return child;
        }
        AVLNode *successor = findMin(root->right);
        root->key = successor->key;
        root->right = deleteNode(root->right, successor->key);
    }

    root->height = 1 + max(getHeight(root->left), getHeight(root->right));
    int bf = getBalance(root);
    // 删除时看孩子的 BF, 注意包括 BF == 0 的情况.
    if (bf > 1)
    {
        if (getBalance(root->left) < 0)
            root->left = rotateLeft(root->left);
        return rotateRight(root);
    }
    if (bf < -1)
    {
        if (getBalance(root->right) > 0)
            root->right = rotateRight(root->right);
        return rotateLeft(root);
    }
    return root;
}

void inorder(AVLNode *root)
{
    if (root == NULL) return;
    inorder(root->left);
    printf("%d ", root->key);
    inorder(root->right);
}

void destroy(AVLNode *root)
{
    if (root == NULL) return;
    destroy(root->left);
    destroy(root->right);
    free(root);
}
```

#### 1.1.10 把这些函数串起来

前面的结构体、旋转和插入函数各保留一份, 再加上查找、删除和下面的 main 即可运行. 不要把用于解释单旋的片段和完整旋转实现重复定义两次.

```c
int main(void)
{
    AVLNode *root = NULL;
    int a[] = {30, 10, 20, 40, 50, 25};
    for (size_t i = 0; i < sizeof(a) / sizeof(a[0]); i++) root = insert(root, a[i]);
    inorder(root);
    printf("\nFind 25: %d\n", search(root, 25) != NULL);
    root = deleteNode(root, 20);
    inorder(root);
    putchar('\n');
    destroy(root);
    return 0;
}
```


### 1.2 Splay Trees

> 完整可运行源码: [splay.c](./code/splay.c). 下方按操作拆开讲解, 同一算法的代码配套使用.

#### 1.2.1 背景

> 首先, 它是一棵 BST, 毋庸置疑.

我们首先做一个引入:

<center>Why Splay Trees ?</center>

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
#include <stdio.h>
#include <stdlib.h>

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

<center>Does NOT work</center>


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
         if (node == NULL) exit(EXIT_FAILURE);
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

4. 遍历、释放与调用:

Splay 的 search 返回的是调整后的树根. 判断是否找到, 还要检查根的 key; 找不到时返回值也可能非空.

```c
void inorder(SplayNode *root)
{
    if (root == NULL) return;
    inorder(root->left);
    printf("%d ", root->key);
    inorder(root->right);
}

void destroy(SplayNode *root)
{
    if (root == NULL) return;
    destroy(root->left);
    destroy(root->right);
    free(root);
}
```


```c
int main(void)
{
    SplayNode *root = NULL;
    int a[] = {30, 10, 20, 40, 50, 25};
    for (size_t i = 0; i < sizeof(a) / sizeof(a[0]); i++) root = insert(root, a[i]);
    root = search(root, 10); // 查找也会改变根, 必须接收返回值
    printf("Find 10: %d\n", root != NULL && root->key == 10);
    root = search(root, 99);
    printf("Find 99: %d\n", root != NULL && root->key == 99);
    root = deleteNode(root, 20);
    inorder(root);
    putchar('\n');
    destroy(root);
    return 0;
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

<center>↓下面进行一一解读↓,</center>


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


**把栈操作也写完整**

下面的代码对应前面的 Push / Pop / MultiPop 分析. 空栈 Pop 返回 0, MultiPop 最多弹出当前实际拥有的元素, 不能把一次 MultiPop 的最坏成本直接乘以总操作数.

完整示例: [stack.c](./code/stack.c).

```c
typedef struct StackNode
{
    int value;
    struct StackNode *next;
} StackNode;

int Push(StackNode **top, int x)
{
    StackNode *p = malloc(sizeof(*p));
    if (p == NULL) return 0;
    p->value = x;
    p->next = *top;
    *top = p;
    return 1;
}

int Pop(StackNode **top, int *out)
{
    if (*top == NULL) return 0;
    StackNode *old = *top;
    *out = old->value;
    *top = old->next;
    free(old);
    return 1;
}

size_t MultiPop(StackNode **top, size_t k)
{
    size_t count = 0;
    int value;
    while (count < k && Pop(top, &value)) count++;
    return count;
}

void DestroyStack(StackNode **top)
{
    int value;
    while (Pop(top, &value)) { }
}
```


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

> 完整可运行源码: [redblack.c](./code/redblack.c). 下方按操作拆开讲解, 同一算法的代码配套使用.

依旧经典问题起手:

<center>Why Not AVL but Red-Black ?</center>

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
#include <stdio.h>
#include <stdlib.h>

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
    if (NIL == NULL) exit(EXIT_FAILURE);
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
    if (node == NULL) exit(EXIT_FAILURE);
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

Red-Black Trees 的插入主要分为两步, 首先是按照普通的 BST 规则插入, 其次是通过变色和必要的旋转恢复红黑性质. 下方代码同时给出 BST 插入和修复, 不跳过指针连接的步骤.

1. 新插入的元素, 默认是红色;

**WARNING:**

新节点替换原来的黑色 NIL 位置时, 先染红不会增加祖先到 NIL 路径上的黑节点数. 若新节点直接染黑, 经过它的那些祖先路径就会多一个黑节点, 可能破坏黑高一致性; 空树插入根是例外, 最后直接把根染黑.

> [!CAUTION]
>
> 按前面的定义, $bh(x)$ 不包含 x 自身, 所以不能说“把 x 染黑直接增加了 $bh(x)$”. 改变的是经过 x 的祖先路径上的黑节点数.

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
   - 父节点是黑色, 新节点保持红色即可, 不出现红红相连, 各条路径的黑节点数也不变.
3. 只有父节点 P 为红色时, 才进入下面三种修复情况. 此时祖父 G 必然存在且为黑色; 叔叔 U 可能是黑色 NIL. 下面先画 P 是 G 左孩子的情况, 右侧完全镜像.

**Case 1: 叔叔节点是红色**

```c
          黑 G                            红 G
         /    \                          /    \
       红 P   红 U        ---->        黑 P   黑 U
       /                               /
     红 x                            红 x
```

此时将 P、U 染黑, G 染红, 再令 `x = G`, 继续检查新的父节点. 这一步只解决当前局部, G 仍可能与更上层的红色父节点相连; 若 G 已经是根, 最后将根染黑.

**Case 2: 叔叔黑色, 形成折线**

```c
初始：
       G(B)
       /
     P(R)
        \
        x(R)

第一次：P 左旋
       G(B)
       /
     x(R)
     /
   P(R)

第二次：G 右旋 + 变色
        x(B)
       /    \
     P(R)   G(R)
```

先对旧 P 左旋, 将折线变成直线, 再进入 Case 3. 这里需要特别注意图中的名字:

> [!IMPORTANT]
>
> 上图 x、P 是旋转前的节点标签. 左旋以后, 旧 x 变成旧 P 的父节点. 进入 Case 3 时, 代码先前已经令 `z = z->parent`, 所以此时新的“当前节点”是旧 P, 新的“父节点”是旧 x, G 不变.
>
> 因此 Case 3 要染黑的是**旧 x**, 不能继续把旋转前的旧 P 当作父节点去染黑. Case 3 图中的 x、P 应按新的位置重新理解.

**Case 3: 叔叔黑色, 形成直线**

```c
          黑 G
         /                           黑 P
       红 P          ---->           /   \
       /                          红 x   红 G
     红 x
```

将当前的父节点 P 染黑, 当前的祖父 G 染红, 再对 G 右旋. 若刚由 Case 2 转来, 此处 P 指的是旋转后的新父节点. 对称的 RR 情况则对 G 左旋.

我们将其汇总起来即为:

|  情况  | 叔叔颜色 |     结构      |              操作              |
| :----: | :------: | :-----------: | :----------------------------: |
| Case 1 |   红色   |     任意      | 父,叔染黑, 祖父染红, 继续向上 |
| Case 2 |   黑色   | 折线 LR 或 RL |    旋转父结点, 转成 Case 3     |
| Case 3 |   黑色   | 直线 LL 或 RR |    父黑,祖父红, 再旋转祖父    |

这里我们给到 cyll 的一个例子:

<center>11,2,14,1,7,15,5,8,4</center>

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

**初始化、释放与完整调用**

NIL 是共享的黑色哨兵. 开始时先调用 initNIL, 并令 `root = NIL`; 最后先释放真实节点, 再释放一次 NIL.

```c
void destroy(RBNode *root)
{
    if (root == NIL) return;
    destroy(root->left);
    destroy(root->right);
    free(root);                     // 此处不释放共享的 NIL
}
```


```c
int main(void)
{
    initNIL();                      // 创建哨兵, 空树的根是 NIL, 不是 NULL
    RBNode *root = NIL;
    int a[] = {11, 2, 14, 1, 7, 15, 5, 8, 4};
    for (size_t i = 0; i < sizeof(a) / sizeof(a[0]); i++) rbInsert(&root, a[i]);
    printf("Root: %d\n", root->key); // 7
    inorder(root);
    printf("\nFind 8: %d\n", search(root, 8) != NIL);
    rbDelete(&root, 7);
    inorder(root);
    putchar('\n');
    destroy(root);
    free(NIL);                      // 所有真实节点释放后, 最后释放一次 NIL
    NIL = NULL;
    return 0;
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

> 完整可运行源码: [bplus.c](./code/bplus.c). 下方按操作拆开讲解, 同一算法的代码配套使用.

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

<center>10 | 20 | 40</center>

插入 30:

<center>10 | 20 | 30 | 40</center>

如果叶结点最大允许 4 条记录, 那么没有溢出, 插入完成, 可能需要更新父结点中的分隔关键字, 但不需要分裂.

**(3) 叶结点分裂:** 

假设四阶 B+ 树的叶结点最多存放 4 条记录.

原叶结点:

<center>10 | 20 | 30 | 40</center>

插入 25:

<center>10 | 20 | 25 | 30 | 40</center>

出现 5 条记录, 超过容量, 需要分裂.

可以平分为:

<center>左叶: 10 | 20</center>

<center>右叶: 25 | 30 | 40</center>

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

<center>左叶 → 右叶 → 原来的下一个叶</center>

**(4) 内部结点分裂:** 

如果向父结点插入新分隔值后, 父结点也超过最大容量, 就必须分裂内部结点.

例如某内部结点最多有 4 个孩子, 现在变成 5 个孩子:

<center>P0,P1,P2,P3,P4</center>

应当把它分成左右两个内部结点, 并把中间分隔关键字提升到父亲.

与叶结点分裂的区别是:

- 叶结点分裂: 分隔键复制到父结点, 数据仍保留在叶子;
- 内部结点分裂: 中间分隔键通常上升到父结点, 用于分开左右两部分.

具体左右各分多少个孩子, 要按照课程规定的向上或向下取整规则进行, 但是总体原则是**尽量平均分配**

**(5) 根结点分裂:** 

如果原根结点也溢出:

<center>原根: P0,P1,P2,P3,P4</center>

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

<center>10 | 20 | 30</center>

删除 20:

<center>10 | 30</center>

- 如果叶结点仍然至少半满, 操作结束;
- 如果删除的是某个子树最小关键字, 还需要更新祖先中的分隔关键字.

(2) **向兄弟借一个元素**

假设当前叶结点低于最低容量, 但相邻兄弟的元素数超过最低值.

例如最低要求 2 条:

<center>当前叶: 10</center>
<center>右兄弟: 20 | 30 | 40</center>

可以从右兄弟借出最小的 20:

<center>当前叶: 10 | 20</center>
<center>右兄弟: 30 | 40</center>

然后更新父结点中的分隔关键字, 这称为:

- 借位;
- 重新分配;
- redistribution.

类似地, cyll 的 PPT 在插入溢出时也提醒我们:

<center>可以先找还有容量的兄弟, 重新分配后尽量让已有节点更满. </center>

删除时则反过来找有富余记录的兄弟, 并且借位或合并应在同一父节点下的相邻兄弟之间进行.

(3) **与兄弟合并**

如果当前结点元素不足, 而相邻兄弟也只有最低数量, 无法借出, 就进行合并.

例如:

<center>当前叶: 10</center>
<center>右兄弟: 20 | 30</center>

合并为:

<center>10 | 20 | 30</center>

然后:

- 删除一个叶结点;
- 从父结点删除对应的分隔关键字和孩子指针;
- 修复叶子链表.

(4) **父结点也可能下溢**

合并会使父结点少一个孩子, 此时父结点可能也低于最小孩子数, 于是问题向上传递影响:

<center>叶结点合并 → 父结点少一个孩子 → 父结点下溢 → 向父结点的兄弟借孩子或进行合并 → 可能一直传递到根</center>

(5) **根结点缩短**

如果删除后根结点只剩一个孩子, 可以删除旧根, 让唯一孩子成为新根:

<center>旧根</center>
<center>↓</center>
<center>唯一孩子</center>

变成:

<center>新根</center>

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

> <center>让一个结点正好装满一个磁盘页, 尽量减少磁盘页面访问次数. </center>

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

#### 1.4.8 B+ Trees 的代码实现

上面把思路讲完了, 下面把整套操作串起来. 默认 $M=3$, 叶节点最多 3 条记录, 内部节点最多 3 个孩子; 与习题中的 order 3 约定一致. 也可以修改 `BPLUS_ORDER`, 但必须至少为 3.

**(1) 结构体和分隔键更新**

每个内部节点的第 i 个分隔键, 都等于第 i+1 个孩子子树的最小值. 缓存 minimum 是为了更新分隔键时不必反复走到最底下. 两类节点的 n 含义不同, 注释中已经标出.

```c
#include <stdio.h>
#include <stdlib.h>

#define BPLUS_ORDER 3
#define MIN_LEAF ((BPLUS_ORDER + 1) / 2)
#define MIN_CHILD ((BPLUS_ORDER + 1) / 2)

typedef struct BPlusNode
{
    int isLeaf;
    int n;                         // 叶: 记录数; 内部: 分隔键数
    int key[BPLUS_ORDER + 1];       // 多留一个溢出位置
    struct BPlusNode *child[BPLUS_ORDER + 2];
    struct BPlusNode *next;         // 仅叶节点使用
    int minimum;                   // 子树最小 key, 便于 O(M) 更新分隔键
} BPlusNode;

BPlusNode *bpNew(int isLeaf)
{
    BPlusNode *p = calloc(1, sizeof(*p));
    if (p == NULL) exit(EXIT_FAILURE);
    p->isLeaf = isLeaf;
    return p;
}

void bpRefresh(BPlusNode *p)
{
    if (p->isLeaf)
    {
        if (p->n > 0) p->minimum = p->key[0];
        return;
    }
    p->minimum = p->child[0]->minimum;
    for (int i = 0; i < p->n; i++)
        p->key[i] = p->child[i + 1]->minimum;
}

int bpChildIndex(const BPlusNode *p, int x)
{
    int i = 0;
    while (i < p->n && x >= p->key[i]) i++;
    return i;                       // 等于分隔键时, 向右边的孩子走
}
```

**(2) 查找和范围查询**

单点查找一路向下, 范围查询找到起始叶后沿 next 向右走. 同样要记住, 等于分隔键时走右侧孩子.

```c
BPlusNode *bpFindLeaf(BPlusNode *root, int x)
{
    while (root != NULL && !root->isLeaf)
        root = root->child[bpChildIndex(root, x)];
    return root;
}

int bpContains(BPlusNode *root, int x)
{
    BPlusNode *p = bpFindLeaf(root, x);
    if (p == NULL) return 0;
    for (int i = 0; i < p->n; i++)
        if (p->key[i] == x) return 1;
    return 0;
}

void bpRange(BPlusNode *root, int low, int high)
{
    if (low > high) return;
    BPlusNode *p = bpFindLeaf(root, low);
    while (p != NULL)
    {
        for (int i = 0; i < p->n; i++)
        {
            if (p->key[i] > high) return;
            if (p->key[i] >= low) printf("%d ", p->key[i]);
        }
        p = p->next;
    }
}
```

**(3) 插入和分裂**

递归返回值用来传回“新分裂出的右节点”; NULL 表示没有分裂. 叶子把记录分开, 内部节点把孩子分开, 最后重新计算分隔键. 这仍然对应叶分隔键复制、内部中间分隔键提升的规则.

```c
/* 返回新分裂出的右节点; 未分裂则返回 NULL. 原节点保留左半部分. */
BPlusNode *bpInsertRec(BPlusNode *p, int x)
{
    if (p->isLeaf)
    {
        int i = p->n;
        while (i > 0 && p->key[i - 1] > x)
        {
            p->key[i] = p->key[i - 1];
            i--;
        }
        p->key[i] = x;
        p->n++;
        bpRefresh(p);
        if (p->n <= BPLUS_ORDER) return NULL;

        BPlusNode *right = bpNew(1);
        int leftCount = (p->n + 1) / 2;
        right->n = p->n - leftCount;
        for (int j = 0; j < right->n; j++)
            right->key[j] = p->key[leftCount + j];
        p->n = leftCount;
        right->next = p->next;
        p->next = right;
        bpRefresh(right);
        return right;
    }

    int i = bpChildIndex(p, x);
    BPlusNode *right = bpInsertRec(p->child[i], x);
    if (right != NULL)
    {
        for (int j = p->n + 1; j > i + 1; j--)
            p->child[j] = p->child[j - 1];
        p->child[i + 1] = right;
        p->n++;
    }
    bpRefresh(p);
    if (p->n < BPLUS_ORDER) return NULL;

    // 内部节点分裂的是孩子数组; 分隔键由各子树最小值重新计算.
    right = bpNew(0);
    int totalChildren = p->n + 1;
    int leftChildren = (totalChildren + 1) / 2;
    right->n = totalChildren - leftChildren - 1;
    for (int j = 0; j <= right->n; j++)
    {
        right->child[j] = p->child[leftChildren + j];
        p->child[leftChildren + j] = NULL;
    }
    p->n = leftChildren - 1;
    bpRefresh(p);
    bpRefresh(right);
    return right;
}

int bpInsert(BPlusNode **root, int x)
{
    if (bpContains(*root, x)) return 0; // 本例把 key 当作集合, 拒绝重复
    if (*root == NULL)
    {
        *root = bpNew(1);
        (*root)->key[0] = x;
        (*root)->n = 1;
        bpRefresh(*root);
        return 1;
    }
    BPlusNode *right = bpInsertRec(*root, x);
    if (right != NULL)
    {
        BPlusNode *newRoot = bpNew(0);
        newRoot->n = 1;
        newRoot->child[0] = *root;
        newRoot->child[1] = right;
        bpRefresh(newRoot);
        *root = newRoot;
    }
    return 1;
}
```

**(4) 删除、借位与合并**

先删除叶子记录, 回到父节点时检查刚处理的孩子. 能借就借, 不能借就合并. 内部节点借的是孩子指针, 叶节点借的是记录, 所以不能把两种情况写成同一个数组搬移.

```c
int bpMinimumCount(const BPlusNode *p)
{
    return p->isLeaf ? MIN_LEAF : MIN_CHILD - 1;
}

/* 合并同一父节点中的第 i、i+1 个孩子, 结果留在左侧. */
void bpMergeChildren(BPlusNode *parent, int i)
{
    BPlusNode *left = parent->child[i];
    BPlusNode *right = parent->child[i + 1];
    if (left->isLeaf)
    {
        for (int j = 0; j < right->n; j++)
            left->key[left->n + j] = right->key[j];
        left->n += right->n;
        left->next = right->next;
    }
    else
    {
        int offset = left->n + 1;
        for (int j = 0; j <= right->n; j++)
            left->child[offset + j] = right->child[j];
        left->n += right->n + 1;
    }
    free(right);
    for (int j = i + 1; j < parent->n; j++)
        parent->child[j] = parent->child[j + 1];
    parent->child[parent->n] = NULL;
    parent->n--;
    bpRefresh(left);
}

void bpRepairChild(BPlusNode *parent, int i)
{
    BPlusNode *p = parent->child[i];
    int minimum = bpMinimumCount(p);
    if (p->n >= minimum) return;

    BPlusNode *left = i > 0 ? parent->child[i - 1] : NULL;
    BPlusNode *right = i < parent->n ? parent->child[i + 1] : NULL;

    if (left != NULL && left->n > minimum)
    {
        if (p->isLeaf)
        {
            for (int j = p->n; j > 0; j--) p->key[j] = p->key[j - 1];
            p->key[0] = left->key[left->n - 1];
        }
        else
        {
            for (int j = p->n + 1; j > 0; j--) p->child[j] = p->child[j - 1];
            p->child[0] = left->child[left->n];
            left->child[left->n] = NULL;
        }
        left->n--;
        p->n++;
        bpRefresh(left);
        bpRefresh(p);
    }
    else if (right != NULL && right->n > minimum)
    {
        if (p->isLeaf)
        {
            p->key[p->n] = right->key[0];
            for (int j = 0; j < right->n - 1; j++) right->key[j] = right->key[j + 1];
        }
        else
        {
            p->child[p->n + 1] = right->child[0];
            for (int j = 0; j < right->n; j++) right->child[j] = right->child[j + 1];
            right->child[right->n] = NULL;
        }
        right->n--;
        p->n++;
        bpRefresh(right);
        bpRefresh(p);
    }
    else if (left != NULL)
        bpMergeChildren(parent, i - 1);
    else
        bpMergeChildren(parent, i);
}

int bpDeleteRec(BPlusNode *p, int x)
{
    if (p->isLeaf)
    {
        int i = 0;
        while (i < p->n && p->key[i] < x) i++;
        if (i == p->n || p->key[i] != x) return 0;
        for (int j = i; j < p->n - 1; j++) p->key[j] = p->key[j + 1];
        p->n--;
        bpRefresh(p);
        return 1;
    }
    int i = bpChildIndex(p, x);
    if (!bpDeleteRec(p->child[i], x)) return 0;
    bpRepairChild(p, i);
    bpRefresh(p);                  // 即使没有合并, 最小 key 也可能改变
    return 1;
}

int bpDelete(BPlusNode **root, int x)
{
    if (*root == NULL || !bpDeleteRec(*root, x)) return 0;
    if ((*root)->n == 0)
    {
        BPlusNode *old = *root;
        *root = old->isLeaf ? NULL : old->child[0];
        free(old);
    }
    return 1;
}
```

**(5) 输出与运行示例**

这里按叶链输出所有记录. 习题要求的逐层输出仍见第八章, 两种输出格式用途不同. 释放时按树结构递归即可, 不要又沿 next 重复释放.

```c
void bpPrint(BPlusNode *root)
{
    BPlusNode *p = root;
    while (p != NULL && !p->isLeaf) p = p->child[0];
    while (p != NULL)
    {
        printf("[");
        for (int i = 0; i < p->n; i++) printf("%s%d", i ? "," : "", p->key[i]);
        printf("]");
        p = p->next;
    }
    putchar('\n');
}

void bpDestroy(BPlusNode *root)
{
    if (root == NULL) return;
    if (!root->isLeaf)
        for (int i = 0; i <= root->n; i++) bpDestroy(root->child[i]);
    free(root);                    // next 只是引用, 不能再沿 next 重复释放
}

int main(void)
{
    BPlusNode *root = NULL;
    int a[] = {22, 16, 41, 8, 11, 12, 17, 23, 31, 52, 58, 59, 61};
    for (size_t i = 0; i < sizeof(a) / sizeof(a[0]); i++) bpInsert(&root, a[i]);
    bpPrint(root);
    printf("Find 52: %d\n", bpContains(root, 52));
    printf("Range [16, 41]: ");
    bpRange(root, 16, 41);
    putchar('\n');
    bpDelete(&root, 22);
    bpDelete(&root, 8);
    bpPrint(root);
    bpDestroy(root);
    return 0;
}
```

> [!NOTE]
>
> 本实现拒绝重复 key, 插入或删除成功返回 1, 重复插入或删除不存在的 key 返回 0. 固定阶数下, 查找、插入、删除均为 $O(\log N)$; 范围查询还需计入实际扫描和输出的记录数.


## Chapter 2: Inverted File Index

> 完整可运行源码: [inverted_index.c](./code/inverted_index.c). 下方按操作拆开讲解, 同一算法的代码配套使用.

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
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <limits.h>

#define DOC_LIMIT 4096
#define WORD_LIMIT 256

typedef struct Posting
{
    int doc_id;
    int *position;
    size_t count, capacity;        // count 同时就是 tf
    struct Posting *next;
} Posting;

typedef struct Term
{
    char word[WORD_LIMIT];
    Posting *docs;
    struct Term *next;
} Term;

typedef struct Index
{
    Term *terms;
    unsigned char state[DOC_LIMIT]; // 0: 未出现; 1: 有效; 2: 已删除
    int stop_filter;
    int stemming;
} Index;

void *checkedAlloc(size_t bytes)
{
    void *p = malloc(bytes);
    if (p == NULL) exit(EXIT_FAILURE);
    return p;
}

void IndexInit(Index *I, int stop_filter, int stemming)
{
    *I = (Index){0};
    I->stop_filter = stop_filter;
    I->stemming = stemming;
}

Term *FindTerm(const Index *I, const char *word)
{
    Term *t = I->terms;
    while (t != NULL && strcmp(t->word, word) < 0) t = t->next;
    return t != NULL && strcmp(t->word, word) == 0 ? t : NULL;
}

Term *GetOrCreateTerm(Index *I, const char *word)
{
    Term **link = &I->terms;
    while (*link != NULL && strcmp((*link)->word, word) < 0) link = &(*link)->next;
    if (*link == NULL || strcmp((*link)->word, word) != 0)
    {
        Term *t = checkedAlloc(sizeof(*t));
        strcpy(t->word, word);      // 调用前已保证长度小于 WORD_LIMIT
        t->docs = NULL;
        t->next = *link;
        *link = t;
    }
    return *link;
}

void AddOccurrence(Index *I, const char *word, int doc_id, int pos)
{
    Term *t = GetOrCreateTerm(I, word);
    Posting **link = &t->docs;
    while (*link != NULL && (*link)->doc_id < doc_id) link = &(*link)->next;
    if (*link == NULL || (*link)->doc_id != doc_id)
    {
        Posting *p = checkedAlloc(sizeof(*p));
        *p = (Posting){.doc_id = doc_id, .next = *link};
        *link = p;
    }
    Posting *p = *link;
    size_t i = 0;
    while (i < p->count && p->position[i] < pos) i++;
    if (i < p->count && p->position[i] == pos) return;
    if (p->count == p->capacity)
    {
        p->capacity = p->capacity == 0 ? 4 : p->capacity * 2;
        int *next = realloc(p->position, p->capacity * sizeof(*next));
        if (next == NULL) exit(EXIT_FAILURE);
        p->position = next;
    }
    for (size_t j = p->count; j > i; j--) p->position[j] = p->position[j - 1];
    p->position[i] = pos;
    p->count++;
}
```

上面的 Posting 对应前文的 DocNode, Term 对应 WordNode. 示意图仍沿用原来的名称, 但实际代码还保存 tf 和 positions, 并通过 state 标记文档是否有效.

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

先把输入处理和索引建立的函数写完整. 本例读取 ASCII 字母与数字组成的词, 单词最多 255 个字符, 超长会明确报错. 默认不去停用词、不做词干归并; 两个选项开启后, 查询端也使用同一套规则.

**Token Analyzer 与规范化:**

```c
int IsWordChar(unsigned char c)
{
    return (c >= 'a' && c <= 'z') || (c >= 'A' && c <= 'Z') || (c >= '0' && c <= '9');
}

int NextToken(const char **cursor, char word[WORD_LIMIT])
{
    const unsigned char *p = (const unsigned char *)*cursor;
    while (*p != 0 && !IsWordChar(*p)) p++;
    if (*p == 0) { *cursor = (const char *)p; return 0; }
    size_t n = 0;
    while (IsWordChar(*p))
    {
        if (n + 1 >= WORD_LIMIT)
        {
            fputs("Token exceeds WORD_LIMIT.\n", stderr);
            exit(EXIT_FAILURE);    // 明确拒绝超长词, 不静默截断成另一个词
        }
        word[n++] = (char)(*p >= 'A' && *p <= 'Z' ? *p - 'A' + 'a' : *p);
        p++;
    }
    word[n] = '\0';
    *cursor = (const char *)p;
    return 1;
}

int IsStopWord(const char *word)
{
    const char *stop[] = {"a", "the", "it", "of", "in"};
    for (size_t i = 0; i < sizeof(stop) / sizeof(stop[0]); i++)
        if (strcmp(word, stop[i]) == 0) return 1;
    return 0;
}

void StemDemo(char *word)
{
    // 仅实现课件展示的词形表, 不是完整 Porter Stemmer.
    const char *from[] = {"processing", "processes", "processed", "says", "said", "saying"};
    const char *to[] = {"process", "process", "process", "say", "say", "say"};
    for (size_t i = 0; i < sizeof(from) / sizeof(from[0]); i++)
        if (strcmp(word, from[i]) == 0) { strcpy(word, to[i]); return; }
}

int Normalize(const Index *I, char *word)
{
    if (I->stop_filter && IsStopWord(word)) return 0;
    if (I->stemming) StemDemo(word);
    return 1;
}

Term *Lookup(const Index *I, const char *query)
{
    char word[WORD_LIMIT], extra[WORD_LIMIT];
    if (!NextToken(&query, word) || NextToken(&query, extra)) return NULL;
    if (!Normalize(I, word)) return NULL;
    return FindTerm(I, word);
}
```

**更新 Posting List、加入文档与删除标记:**

```c
void RemovePostings(Index *I, int doc_id)
{
    Term **termLink = &I->terms;
    while (*termLink != NULL)
    {
        Term *t = *termLink;
        Posting **link = &t->docs;
        while (*link != NULL && (*link)->doc_id < doc_id) link = &(*link)->next;
        if (*link != NULL && (*link)->doc_id == doc_id)
        {
            Posting *old = *link;
            *link = old->next;
            free(old->position);
            free(old);
        }
        if (t->docs == NULL)
        {
            *termLink = t->next;
            free(t);
        }
        else termLink = &t->next;
    }
}

int AddDocument(Index *I, int doc_id, const char *text)
{
    if (doc_id <= 0 || doc_id >= DOC_LIMIT) return 0;
    RemovePostings(I, doc_id);      // 同编号再次加入时, 替换旧文档
    I->state[doc_id] = 1;
    char word[WORD_LIMIT];
    int position = 0;
    while (NextToken(&text, word))
    {
        if (position == INT_MAX) exit(EXIT_FAILURE);
        position++;               // 即使过滤了停用词, 原始位置也不能压缩
        if (Normalize(I, word)) AddOccurrence(I, word, doc_id, position);
    }
    return 1;
}

int DeleteDocument(Index *I, int doc_id)
{
    if (doc_id <= 0 || doc_id >= DOC_LIMIT) return 0;
    I->state[doc_id] = 2;            // 墓碑标记, 查询时忽略旧 posting
    return 1;
}

void IndexDestroy(Index *I)
{
    Term *t = I->terms;
    while (t != NULL)
    {
        Term *nextTerm = t->next;
        Posting *p = t->docs;
        while (p != NULL)
        {
            Posting *nextPosting = p->next;
            free(p->position);
            free(p);
            p = nextPosting;
        }
        free(t);
        t = nextTerm;
    }
    *I = (Index){0};
}
```



- 其本质就是,遍历一篇文档,读取其中每个关键词;
  - 如果这个关键词并没有在字典出现,则加入;
  - 如果出现过则不加入;
- 二者均需要更新该词的 Posting List. 若每个 posting 代表一篇文档, 同一词在同一文档再次出现时应累计词频,追加位置, 不应重复创建相同的 doc_id;按 doc_id 递增处理文档可方便地保持列表有序.

> [!NOTE]
>
> 这里用有序链表保存词典, 方便把查找、插入和 Posting List 的关系看清楚; 词典查找最坏为 $O(V)$, 不是哈希表的期望常数时间. 完整源码包含所有辅助函数, 没有依赖未实现的 Find 或 Insert.

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

**把 AND / OR / NOT 和短语查询写出来**

输出数组长度由调用者保证至少为 DOC_LIMIT, 返回值是命中数. NOT 的全集是 state 为 1 的所有有效文档, 包括没有任何词项的空文档. QueryPhrase2 检查两个词是否按顺序相邻, 不能用 AND 的结果冒充短语结果; 若希望支持含停用词的精确短语, 建索引时应关闭停用词过滤.

```c
size_t QueryTerm(const Index *I, const char *query, int out[DOC_LIMIT])
{
    Term *t = Lookup(I, query);
    size_t n = 0;
    for (Posting *p = t == NULL ? NULL : t->docs; p != NULL; p = p->next)
        if (I->state[p->doc_id] == 1) out[n++] = p->doc_id;
    return n;
}

size_t QueryAnd(const Index *I, const char *a, const char *b, int out[DOC_LIMIT])
{
    Term *ta = Lookup(I, a), *tb = Lookup(I, b);
    Posting *p = ta == NULL ? NULL : ta->docs;
    Posting *q = tb == NULL ? NULL : tb->docs;
    size_t n = 0;
    while (p != NULL && q != NULL)
    {
        if (p->doc_id == q->doc_id)
        {
            if (I->state[p->doc_id] == 1) out[n++] = p->doc_id;
            p = p->next; q = q->next;
        }
        else if (p->doc_id < q->doc_id) p = p->next;
        else q = q->next;
    }
    return n;
}

size_t QueryOr(const Index *I, const char *a, const char *b, int out[DOC_LIMIT])
{
    int first[DOC_LIMIT], second[DOC_LIMIT];
    size_t n1 = QueryTerm(I, a, first), n2 = QueryTerm(I, b, second);
    size_t i = 0, j = 0, n = 0;
    while (i < n1 || j < n2)
    {
        if (j == n2 || (i < n1 && first[i] < second[j])) out[n++] = first[i++];
        else if (i == n1 || second[j] < first[i]) out[n++] = second[j++];
        else { out[n++] = first[i]; i++; j++; }
    }
    return n;
}

size_t QueryNot(const Index *I, const char *word, int out[DOC_LIMIT])
{
    int hits[DOC_LIMIT];
    size_t count = QueryTerm(I, word, hits), j = 0, n = 0;
    for (int id = 1; id < DOC_LIMIT; id++)
    {
        if (I->state[id] != 1) continue;
        if (j < count && hits[j] == id) j++;
        else out[n++] = id;
    }
    return n;
}

int Adjacent(const Posting *a, const Posting *b)
{
    size_t i = 0, j = 0;
    while (i < a->count && j < b->count)
    {
        long long target = (long long)a->position[i] + 1;
        if (target == b->position[j]) return 1;
        if (target < b->position[j]) i++;
        else j++;
    }
    return 0;
}

size_t QueryPhrase2(const Index *I, const char *a, const char *b, int out[DOC_LIMIT])
{
    Term *ta = Lookup(I, a), *tb = Lookup(I, b);
    Posting *p = ta == NULL ? NULL : ta->docs;
    Posting *q = tb == NULL ? NULL : tb->docs;
    size_t n = 0;
    while (p != NULL && q != NULL)
    {
        if (p->doc_id == q->doc_id)
        {
            if (I->state[p->doc_id] == 1 && Adjacent(p, q)) out[n++] = p->doc_id;
            p = p->next; q = q->next;
        }
        else if (p->doc_id < q->doc_id) p = p->next;
        else q = q->next;
    }
    return n;
}
```

**词频排序与截断:**

下面先按单词的 tf 做简单排序, 再取前 k 项; 这里只演示数据流, 不把 tf 等同于真实相关性. QueryThresholdOne 则展示丢掉部分 AND 条件后会改变查询语义.

```c
typedef struct Hit { int doc_id; size_t score; } Hit;

int CompareHits(const void *a, const void *b)
{
    const Hit *x = a, *y = b;
    if (x->score != y->score) return x->score < y->score ? 1 : -1;
    return (x->doc_id > y->doc_id) - (x->doc_id < y->doc_id);
}

size_t TopK(const Index *I, const char *word, size_t k, Hit out[DOC_LIMIT])
{
    Term *t = Lookup(I, word);
    size_t n = 0;
    for (Posting *p = t == NULL ? NULL : t->docs; p != NULL; p = p->next)
        if (I->state[p->doc_id] == 1) out[n++] = (Hit){p->doc_id, p->count};
    qsort(out, n, sizeof(*out), CompareHits);
    return n < k ? n : k;           // 只演示按 tf 排序和截断, 不声称 tf 就是相关性
}

size_t DocumentFrequency(const Index *I, const char *word)
{
    int out[DOC_LIMIT];
    return QueryTerm(I, word, out);
}

/* 演示 AND 查询只保留两个词中较稀有的一个, 是近似结果, 不是精确 AND. */
size_t QueryThresholdOne(const Index *I, const char *a, const char *b, int out[DOC_LIMIT])
{
    return QueryTerm(I, DocumentFrequency(I, a) <= DocumentFrequency(I, b) ? a : b, out);
}
```


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

**分块建立的调用代码:**

下面以完整文档为块边界, 最后一块不足 block_docs 篇也会处理. SaveIndex、LoadIndex、MergeIndex 在下一节给出. 本例演示落盘与重新读取的步骤, 最终总索引仍保存在内存; 真正超内存的大索引还需将有序归并结果直接流式写回磁盘, 不能把这个教学驱动当作完整外存引擎.

```c
int SaveIndex(const Index *I, FILE *file);
int LoadIndex(Index *I, FILE *file);
int MergeIndex(Index *dst, const Index *src);

/* 按完整文档分块, 每块写入临时文件再读回归并. 返回 0 表示 I 中只含已完成的块. */
int BuildByBlocks(Index *I, const char *docs[], size_t count, size_t block_docs)
{
    if (block_docs == 0 || count >= DOC_LIMIT) return 0;
    for (size_t begin = 0; begin < count; )
    {
        size_t end = begin + (count - begin < block_docs ? count - begin : block_docs);
        Index block, loaded;
        IndexInit(&block, I->stop_filter, I->stemming);
        IndexInit(&loaded, I->stop_filter, I->stemming);
        for (size_t j = begin; j < end; j++) AddDocument(&block, (int)j + 1, docs[j]);
        FILE *file = tmpfile();
        int ok = file != NULL && SaveIndex(&block, file);
        IndexDestroy(&block);
        if (ok)
        {
            ok = fflush(file) == 0 && fseek(file, 0, SEEK_SET) == 0;
            if (ok) ok = LoadIndex(&loaded, file) && MergeIndex(I, &loaded);
        }
        if (file != NULL && fclose(file) != 0) ok = 0;
        IndexDestroy(&loaded);
        if (!ok) return 0;
        begin = end;
    }
    return 1;
}
```


### 2.5 索引变大,变动之后

> 对应课件第 11~14 页.

#### 2.5.1 Distributed Indexing

| 划分方式 | 每台机器保存什么 | 查询过程 |
| :--- | :--- | :--- |
| Term-partitioned | 一部分词项及其 Posting List | 将不同查询词发给负责的机器, 再合并结果 |
| Document-partitioned | 一部分文档的完整倒排索引 | 各文档分片执行查询, 汇总各自结果 |

按词分, 要处理多词查询的通信与热门词负载;按文档分, 通常要向多个分片查询, 再统一合并和排序.

**分片位置怎么计算:**

以下只负责决定一个词或文档去哪一片. 使用非零 shards; 分片上的建索引、查询和结果归并仍需另外调用前面的算法. 这里用哈希分词项, 与课件按字母范围划分是同一种按词项分片思想的不同映射方式.

源码见 [index_tools.c](./code/index_tools.c).

```c
#include <stdint.h>
#include <stddef.h>

size_t TermShard(const char *normalizedWord, size_t shards)
{
    uint32_t hash = 2166136261u;
    for (const unsigned char *p = (const unsigned char *)normalizedWord; *p; p++)
        hash = (hash ^ *p) * 16777619u;
    return shards == 0 ? 0 : hash % shards;
}

size_t DocumentShard(uint32_t doc_id, size_t shards)
{
    return shards == 0 ? 0 : doc_id % shards;
}
```


#### 2.5.2 Dynamic Indexing

文档并不是一次性全部到齐的, 所以可以维护:

```text
Main Index       → 已有的大索引
Auxiliary Index  → 新增文档的小索引
删除标记          → 哪些 doc_id 已失效
```

查询时同时查主索引与辅助索引, 合并结果并过滤删除标记;辅助索引积累到一定规模后再与主索引归并.

修改文档可理解成"旧版本失效 + 新版本加入", 要避免两个版本同时作为有效结果返回. 何时重建或归并取决于更新量,空间和查询成本, 并没有一个固定通用的时间间隔.

**索引合并、保存与读取:**

MergeIndex 把 src 视为较新的完整文档批次: 同编号以 src 为准, 删除墓碑也会覆盖旧状态. 所以它既可以合并不同文档块, 也可以把辅助索引合入主索引. 若同一文档被拆成多个词项块, 则不能用“新版本覆盖”规则直接归并那些碎片.

SaveIndex / LoadIndex 使用本例自己的文本格式, `D` 记录文档状态, `P` 记录一个词的出现位置. LoadIndex 要求目标已经初始化, 只用于读取本例导出的受信任文件.

```c
/* src 是更新的一批完整文档. 相同编号以 src 为准, 包括删除墓碑. */
int MergeIndex(Index *dst, const Index *src)
{
    if (dst == src || dst->stop_filter != src->stop_filter || dst->stemming != src->stemming) return 0;
    for (int id = 1; id < DOC_LIMIT; id++)
        if (src->state[id] != 0)
        {
            RemovePostings(dst, id);
            dst->state[id] = src->state[id];
        }
    for (Term *t = src->terms; t != NULL; t = t->next)
        for (Posting *p = t->docs; p != NULL; p = p->next)
            if (src->state[p->doc_id] == 1)
                for (size_t i = 0; i < p->count; i++)
                    AddOccurrence(dst, t->word, p->doc_id, p->position[i]);
    return 1;                     // src 仍然独立存在, 由调用者销毁
}

int SaveIndex(const Index *I, FILE *file)
{
    if (fprintf(file, "INDEX1 %d %d\n", I->stop_filter, I->stemming) < 0) return 0;
    for (int id = 1; id < DOC_LIMIT; id++)
        if (I->state[id] != 0 && fprintf(file, "D %d %u\n", id, (unsigned)I->state[id]) < 0) return 0;
    for (Term *t = I->terms; t != NULL; t = t->next)
        for (Posting *p = t->docs; p != NULL; p = p->next)
            if (I->state[p->doc_id] == 1)
                for (size_t i = 0; i < p->count; i++)
                    if (fprintf(file, "P %s %d %d\n", t->word, p->doc_id, p->position[i]) < 0) return 0;
    return !ferror(file);
}

/* 读取本示例导出的受信任格式; 失败不修改原有索引. */
int LoadIndex(Index *I, FILE *file)
{
    Index temp;
    int stop, stem;
    if (fscanf(file, "INDEX1 %d %d", &stop, &stem) != 2) return 0;
    if ((stop != 0 && stop != 1) || (stem != 0 && stem != 1)) return 0;
    IndexInit(&temp, stop, stem);
    char type, word[WORD_LIMIT];
    int id, value;
    while (fscanf(file, " %c", &type) == 1)
    {
        if (type == 'D')
        {
            if (fscanf(file, "%d %d", &id, &value) != 2 || id <= 0 || id >= DOC_LIMIT || (value != 1 && value != 2)) goto fail;
            temp.state[id] = (unsigned char)value;
        }
        else if (type == 'P')
        {
            if (fscanf(file, "%255s %d %d", word, &id, &value) != 3 || id <= 0 || id >= DOC_LIMIT || value <= 0 || temp.state[id] != 1) goto fail;
            AddOccurrence(&temp, word, id, value);
        }
        else goto fail;
    }
    if (ferror(file)) goto fail;
    IndexDestroy(I);
    *I = temp;
    return 1;
fail:
    IndexDestroy(&temp);
    return 0;
}
```


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

**Gap Encoding 与变长整数的实现:**

数组下标从 0 开始, doc_id 是严格递增的正数. 先取 gap, 再用变长字节编码节省空间. 这里采用“最高位 1 表示还有后续字节”的约定; 编码与解码必须使用相同约定.

```c
#include <stdint.h>
#include <stddef.h>

int GapEncode(const uint32_t ids[], size_t n, uint32_t gaps[])
{
    uint32_t previous = 0;
    for (size_t i = 0; i < n; i++)
    {
        if (ids[i] <= previous) return 0; // doc_id 为严格递增的正数
        previous = ids[i];
    }
    previous = 0;
    for (size_t i = 0; i < n; i++)
    {
        uint32_t current = ids[i];
        gaps[i] = current - previous;
        previous = current;
    }
    return 1;
}

int GapDecode(const uint32_t gaps[], size_t n, uint32_t ids[])
{
    uint32_t sum = 0;
    for (size_t i = 0; i < n; i++)
    {
        if (gaps[i] == 0 || gaps[i] > UINT32_MAX - sum) return 0;
        sum += gaps[i];
    }
    sum = 0;
    for (size_t i = 0; i < n; i++) { sum += gaps[i]; ids[i] = sum; }
    return 1;
}

/* 每字节低 7 位存数据, 最高位 1 表示后面还有字节. uint32_t 最多 5 字节. */
size_t VByteEncode(uint32_t x, unsigned char out[5])
{
    size_t n = 0;
    do
    {
        unsigned char byte = (unsigned char)(x & 127u);
        x >>= 7;
        out[n++] = (unsigned char)(byte | (x != 0 ? 128u : 0u));
    } while (x != 0);
    return n;
}

int VByteDecode(const unsigned char in[], size_t n, uint32_t *value, size_t *used)
{
    uint32_t x = 0;
    for (size_t i = 0; i < n && i < 5; i++)
    {
        uint32_t digit = in[i] & 127u;
        if (i == 4 && digit > 15u) return 0;
        x |= digit << (7 * i);
        if (!(in[i] & 128u)) { *value = x; *used = i + 1; return 1; }
    }
    return 0;                      // 缺少终止字节, 或超出 uint32_t
}
```


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


**评价指标的代码:**

```c
#include <math.h>
#include <stddef.h>

typedef struct Measures
{
    double precision;
    double recall;
} Measures;

Measures Evaluate(size_t RR, size_t IR, size_t RN)
{
    Measures m;
    double retrieved = (double)RR + (double)IR;
    double relevant = (double)RR + (double)RN;
    m.precision = retrieved > 0 ? RR / retrieved : NAN;
    m.recall = relevant > 0 ? RR / relevant : NAN;
    return m;                      // NAN 表示分母为 0, 由评测规则另行决定
}
```

### 2.7 将索引和查询串起来

用前面的四篇文档运行. 预期 `silver AND truck` 和双词短语 `silver truck` 都命中文档 1、3; 但这只是本例恰好相同, 一般不能互相替代. 删除文档 3 后, silver 只命中文档 1.

```c
void PrintHits(const int a[], size_t n)
{
    for (size_t i = 0; i < n; i++) printf("%s%d", i ? " " : "", a[i]);
    putchar('\n');
}

int main(void)
{
    Index I;
    IndexInit(&I, 0, 0);            // 默认保留停用词, 不做词形归并
    AddDocument(&I, 1, "Gold silver truck");
    AddDocument(&I, 2, "Shipment of gold damaged in a fire");
    AddDocument(&I, 3, "Delivery of silver arrived in a silver truck");
    AddDocument(&I, 4, "Shipment of gold arrived in a truck");
    int hits[DOC_LIMIT];
    size_t n = QueryAnd(&I, "SILVER", "truck", hits);
    printf("silver AND truck: "); PrintHits(hits, n);
    n = QueryPhrase2(&I, "silver", "truck", hits);
    printf("phrase silver truck: "); PrintHits(hits, n);
    Hit ranked[DOC_LIMIT];
    n = TopK(&I, "silver", 2, ranked);
    for (size_t i = 0; i < n; i++) printf("doc=%d tf=%zu\n", ranked[i].doc_id, ranked[i].score);
    DeleteDocument(&I, 3);
    n = QueryTerm(&I, "silver", hits);
    printf("after delete doc 3: "); PrintHits(hits, n);
    IndexDestroy(&I);
    return 0;
}
```


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

> 完整可运行源码: [leftist.c](./code/leftist.c). 下方按操作拆开讲解, 同一算法的代码配套使用.

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

对应的迭代代码如下, 显式 path 栈保存递归原本要处理的回溯路径:

```c
PriorityQueue MergeIterative(PriorityQueue H1, PriorityQueue H2)
{
    if (H1 == NULL) return H2;
    if (H2 == NULL) return H1;
    size_t size = 0, capacity = 16;
    PriorityQueue *path = malloc(capacity * sizeof(*path));
    if (path == NULL) exit(EXIT_FAILURE);
    while (H1 != NULL && H2 != NULL)
    {
        if (H1->Element > H2->Element)
        {
            PriorityQueue temp = H1;
            H1 = H2;
            H2 = temp;
        }
        if (size == capacity)
        {
            capacity *= 2;
            PriorityQueue *temp = realloc(path, capacity * sizeof(*path));
            if (temp == NULL) exit(EXIT_FAILURE);
            path = temp;
        }
        path[size++] = H1;
        H1 = H1->Right;
    }
    PriorityQueue result = H1 != NULL ? H1 : H2;
    while (size > 0)
    {
        PriorityQueue p = path[--size];
        p->Right = result;
        if (getNpl(p->Left) < getNpl(p->Right)) SwapChildren(p);
        p->Npl = getNpl(p->Right) + 1;
        result = p;
    }
    free(path);
    return result;
}
```


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

**把 FindMin、队列建堆与释放补上:**

BuildHeap 使用循环队列, 每次取出两个堆合并再放回. n 不是 2 的幂时也能直接运行. FindMin 返回成功与否, 因而不需要拿某个合法 key 冒充“空堆”.

```c
int FindMin(PriorityQueue H, int *out)
{
    if (H == NULL) return 0;
    *out = H->Element;
    return 1;
}

PriorityQueue BuildHeap(const int a[], size_t n)
{
    if (n == 0) return NULL;
    PriorityQueue *queue = malloc(n * sizeof(*queue));
    if (queue == NULL) exit(EXIT_FAILURE);
    for (size_t i = 0; i < n; i++) queue[i] = Insert(NULL, a[i]);
    size_t front = 0, rear = 0, count = n; // 容量 n 的循环队列
    while (count > 1)
    {
        PriorityQueue x = queue[front]; front = (front + 1) % n;
        PriorityQueue y = queue[front]; front = (front + 1) % n;
        queue[rear] = Merge(x, y); rear = (rear + 1) % n;
        count--;                       // 出队两个, 入队一个
    }
    PriorityQueue result = queue[front];
    free(queue);
    return result;
}

void DestroyHeap(PriorityQueue H)
{
    // 旋转后逐个释放, 避免很长的左链耗尽递归栈.
    while (H != NULL)
    {
        if (H->Left != NULL)
        {
            PriorityQueue left = H->Left;
            H->Left = left->Right;
            left->Right = H;
            H = left;
        }
        else
        {
            PriorityQueue next = H->Right;
            free(H);
            H = next;
        }
    }
}
```

**运行示例:**

```c
int main(void)
{
    int a[] = {8, 3, 10, 2, 6};
    PriorityQueue H = BuildHeap(a, sizeof(a) / sizeof(a[0]));
    PriorityQueue other = Insert(NULL, 5);
    H = MergeIterative(H, other);
    other = NULL;                      // 所有权已经移交给 H
    int x;
    while (FindMin(H, &x))
    {
        printf("%d ", x);
        H = DeleteMin(H);
    }
    putchar('\n');
    DestroyHeap(H);
    return 0;
}
```


### 3.3 Skew Heaps

> 完整可运行源码: [skew.c](./code/skew.c). 下方按操作拆开讲解, 同一算法的代码配套使用.

#### 3.3.1 为什么还要把 Npl 去掉

左式堆的 Merge 已经很好了, 但每个节点要存 Npl, 每次还要判断是否交换. Skew Heap 的想法更直接:

> 不维护 Npl. 每次真正参与递归合并的节点, 回来时都交换左右孩子.

这与前面的 Splay Trees 有相似之处: 不要求每个时刻结构都很好看, 只要求一系列操作的总成本可控.

> [!CAUTION]
>
> Skew Heap 保留堆序, 但不保证左式性质. 某次右路径可能有 $\Theta(N)$ 个节点, 所以单次 Merge 最坏可以是 $O(N)$.

#### 3.3.2 Merge 的实现

```c
#include <stdio.h>
#include <stdlib.h>

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

**Insert、FindMin、DeleteMin、建堆和释放:**

这里的 SkewBuildHeap 使用连续插入, 给出 $O(n\log(n+1))$ 的总时间上界; 不要直接套用上一节左式堆两两合并建堆的证明.

```c
SkewHeap SkewInsert(SkewHeap H, int x)
{
    SkewHeap p = malloc(sizeof(*p));
    if (p == NULL) exit(EXIT_FAILURE);
    p->Element = x;
    p->Left = p->Right = NULL;
    return SkewMerge(H, p);
}

int SkewFindMin(SkewHeap H, int *out)
{
    if (H == NULL) return 0;
    *out = H->Element;
    return 1;
}

SkewHeap SkewDeleteMin(SkewHeap H)
{
    if (H == NULL) return NULL;
    SkewHeap left = H->Left, right = H->Right;
    free(H);
    return SkewMerge(left, right);
}

SkewHeap SkewBuildHeap(const int a[], size_t n)
{
    SkewHeap H = NULL;
    for (size_t i = 0; i < n; i++) H = SkewInsert(H, a[i]);
    return H;                          // 连续插入的 O(n log(n+1)) 总时间上界
}

void SkewDestroy(SkewHeap H)
{
    while (H != NULL)
    {
        if (H->Left != NULL)
        {
            SkewHeap left = H->Left;
            H->Left = left->Right;
            left->Right = H;
            H = left;
        }
        else
        {
            SkewHeap next = H->Right;
            free(H);
            H = next;
        }
    }
}
```

**不用递归的 Merge:**

同样保存实际处理的路径. 回溯时直接把旧左子树放到右边, 把合并结果放到左边; 剩余子堆不再逐节点交换.

```c
SkewHeap SkewMergeIterative(SkewHeap H1, SkewHeap H2)
{
    if (H1 == NULL) return H2;
    if (H2 == NULL) return H1;
    size_t size = 0, capacity = 16;
    SkewHeap *path = malloc(capacity * sizeof(*path));
    if (path == NULL) exit(EXIT_FAILURE);
    while (H1 != NULL && H2 != NULL)
    {
        if (H1->Element > H2->Element)
        {
            SkewHeap temp = H1;
            H1 = H2;
            H2 = temp;
        }
        if (size == capacity)
        {
            capacity *= 2;
            SkewHeap *temp = realloc(path, capacity * sizeof(*path));
            if (temp == NULL) exit(EXIT_FAILURE);
            path = temp;
        }
        path[size++] = H1;
        H1 = H1->Right;
    }
    SkewHeap result = H1 != NULL ? H1 : H2;
    while (size > 0)
    {
        SkewHeap p = path[--size];
        p->Right = p->Left;             // 新右子树是旧左子树
        p->Left = result;              // 新左子树是刚刚合并的结果
        result = p;
    }
    free(path);
    return result;
}
```

**运行示例:**

```c
int main(void)
{
    int a[] = {8, 3, 10, 2, 6};
    SkewHeap H = SkewBuildHeap(a, sizeof(a) / sizeof(a[0]));
    H = SkewMergeIterative(H, SkewInsert(NULL, 5));
    int x;
    while (SkewFindMin(H, &x))
    {
        printf("%d ", x);
        H = SkewDeleteMin(H);
    }
    putchar('\n');
    SkewDestroy(H);
    return 0;
}
```


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

> 完整可运行源码: [binomial.c](./code/binomial.c). 下方按操作拆开讲解, 同一算法的代码配套使用.

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

**初始化、释放与完整调用:**

初始化只对新队列使用; 已有队列要先销毁, 否则直接清空指针会泄漏节点. 删除最小值直到空队列, 输出应为 1～13.

```c
void BinInit(BinQueue H)
{
    *H = (Collection){0};              // 只用于尚未持有节点的新队列
}

void BinDestroyTree(BinTree T)
{
    if (T == NULL) return;
    BinTree child = T->LeftChild;
    while (child != NULL)
    {
        BinTree next = child->NextSibling;
        BinDestroyTree(child);
        child = next;
    }
    free(T);
}

void BinDestroy(BinQueue H)
{
    for (int i = 0; i < MAX_TREES; i++) BinDestroyTree(H->TheTrees[i]);
    BinInit(H);
}
```


```c
int main(void)
{
    Collection H1, H2;
    BinInit(&H1);
    BinInit(&H2);
    for (int x = 1; x <= 13; x++)
    {
        if (!BinInsert(x <= 6 ? &H1 : &H2, x))
        {
            BinDestroy(&H1);
            BinDestroy(&H2);
            return EXIT_FAILURE;
        }
    }
    if (!BinMerge(&H1, &H2)) return EXIT_FAILURE;
    int x;
    while (BinDeleteMin(&H1, &x)) printf("%d ", x);
    putchar('\n');
    BinDestroy(&H1);
    BinDestroy(&H2);
    return 0;
}
```


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


## Chapter 5: Backtracking

> 对应课件: [ADS06Backtracking_Stu.ppt](<../lesson/Materials/Student Slides/ADS06Backtracking_Stu.ppt>), 第 2～17 页为主要内容, 第 18 页为 Safe Fruit 项目引入.

### 5.1 为什么需要 Backtracking

#### 5.1.1 从枚举所有答案开始

前面几章更多是在设计数据结构, 现在我们开始讨论: 面对一个问题, 到底怎样组织求解过程?

一种最直接的方法是把所有候选答案列出来, 然后逐一判断.

> **问题**
>
> 如果一个问题有 $N$ 个位置, 每个位置有 $K$ 种选择, 那么候选答案最多就有 $K^N$ 个.
>
> 明明前几个选择已经冲突, 还把后面全部填完再检查, 就很浪费.

于是, 我们希望在答案还没构造完的时候, 就判断这条路有没有必要继续走.

> [!IMPORTANT]
>
> Backtracking 的核心: **选择 → 检查 → 递归 → 撤销**.
>
> 当前部分解记为 $(x_1,\ldots,x_i)$, 再尝试 $x_{i+1}$. 如果这一步使它不可能扩展成合法解, 就不再搜索这个分支; 否则继续向下一层.

这里的“不再搜索这个分支”就是 Pruning, 即剪枝.

<details style="--wi-box-color:var(--wi-question);--wi-box-bg:var(--wi-question-bg)"><summary>剪枝是不是凭感觉觉得这个分支不好, 就跳过去?</summary><p>不是. 必须能说明: 被剪掉的分支不可能产生我们需要的答案. 如果只是“看起来不太像”, 就可能把正确答案一起剪掉.</p></details>

#### 5.1.2 State-Space Tree

我们把每次选择画成一条边, 把已经作出的选择画成一个节点, 就得到 State-Space Tree, 即状态空间树.

```text
                   空的部分解
                 /     |     \
              x1=a   x1=b   x1=c
              /  \
           x2=d  x2=e
             ×     |
           冲突   继续搜索
```

每条根到叶的路径代表一个候选答案; 中途发现冲突, 就可以一次排除它下面的一整棵子树.

我们通常用 DFS 搜索它, 但**不需要真的把整棵树建出来**. 递归栈加上当前部分解, 就足以记录当前所在的位置.

> [!NOTE]
>
> 课件用树遍历帮助理解搜索过程. 代码里是在进入下一层之前检查约束, 回来之后撤销选择; 不要把它机械理解成“所有工作都在后序访问时完成”.

#### 5.1.3 找一个解和找所有解

这两种任务的退出方式不同:

| 目标 | 到达一个合法叶节点后 | 撤销时机 |
| :--- | :--- | :--- |
| 找一个解 | 返回成功, 可以结束整次搜索 | 失败的分支必须撤销; 成功路径可保留为答案 |
| 找所有解 / 计数 | 保存或计数, 然后继续搜索 | 每次递归返回后都要撤销 |
| 找最优解 | 更新当前最优答案, 继续寻找更优解 | 返回上一层前恢复状态 |

> [!CAUTION]
>
> “撤销”不只是把 $x_i$ 清掉. 只要本层修改过计数、集合、标记数组等共享状态, 都要恢复到进入本层之前的样子.
>
> 如果检查过程已经扣掉了一部分资源, 然后发现不够用, 这部分修改也要撤销.

### 5.2 Eight Queens

> 完整可运行源码: [nqueens.c](./code/nqueens.c).

#### 5.2.1 怎样表示一个答案

在 $N\times N$ 棋盘上放 $N$ 个皇后, 要求任意两个皇后不同一行、不同一列, 也不在同一条对角线上.

如果规定第 $i$ 行只放一个皇后, 用 $x_i$ 表示它所在的列, 那么一个答案就是:

$$
(x_1,x_2,\ldots,x_N)
$$

同行冲突已经被表示方式排除了. 剩下的条件是, 对任意 $i\ne j$:

$$
x_i\ne x_j,\qquad |x_i-x_j|\ne |i-j|
$$

原来每一行都能任选一列, 有 $N^N$ 个候选. 再要求列互不相同, 候选就变成 $1,2,\ldots,N$ 的排列, 数量为 $N!$.

> [!CAUTION]
>
> $N!$ 是排除了行、列冲突之后的候选数量, 不是合法解数量. 对角线冲突还需要继续检查.

#### 5.2.2 以 4 Queens 为例

一种搜索过程是:

```text
第 1 行选第 1 列
  第 2 行选第 3 列 → 第 3 行无处可放 → 撤销
  第 2 行选第 4 列 → 继续搜索, 最终仍失败 → 撤销
第 1 行改选第 2 列
  第 2 行选第 4 列
  第 3 行选第 1 列
  第 4 行选第 3 列 → 找到 (2,4,1,3)
```

另外一个解为 $(3,1,4,2)$, 正好与它左右镜像.

```text
. Q . .       . . Q .
. . . Q       Q . . .
Q . . .       . . . Q
. . Q .       . Q . .
```

#### 5.2.3 如何让冲突判断变成 O(1)

最直接的办法是与前面每一个皇后比较, 单次检查为 $O(N)$.

但一条对角线上的格子满足:

- 一个方向的 `row - col` 相同;
- 另一个方向的 `row + col` 相同.

因此我们用三个标记数组, 分别记录列、两个方向的对角线有没有被占用. 代码采用从 $0$ 开始的下标, `row-col` 加上 $N-1$ 后就不会为负.

完整实现所需头文件为 `<stdint.h>` 和 `<stdio.h>`:

```c
#define QUEEN_LIMIT 15
typedef void (*QueenVisitor)(const int col[], int n);

typedef struct {
    int n, col[QUEEN_LIMIT];
    int used[QUEEN_LIMIT];
    int down[2 * QUEEN_LIMIT - 1], up[2 * QUEEN_LIMIT - 1];
    uint64_t count;
    QueenVisitor visit;
} Queens;

static void PlaceQueen(Queens *q, int row)
{
    if (row == q->n) {
        ++q->count;
        if (q->visit) q->visit(q->col, q->n);
        return;
    }
    for (int c = 0; c < q->n; ++c) {
        int d = row - c + q->n - 1, u = row + c;
        if (q->used[c] || q->down[d] || q->up[u]) continue;
        q->col[row] = c;
        q->used[c] = q->down[d] = q->up[u] = 1;
        PlaceQueen(q, row + 1);
        // 枚举所有解: 即使刚刚找到解, 也必须撤销后继续.
        q->used[c] = q->down[d] = q->up[u] = 0;
    }
}

uint64_t SolveQueens(int n, QueenVisitor visit)
{
    if (n < 0 || n > QUEEN_LIMIT) return 0;
    Queens q = {0};
    q.n = n;
    q.visit = visit;
    PlaceQueen(&q, 0);
    return q.count;
}
```

注意看最后一行撤销: 这里要求**枚举所有解**, 所以找到解之后仍然要清除本层占用标记.

`col[row]` 不需要专门置零, 因为它只是记录答案, 下一次试探会覆盖它; 真正影响能否继续搜索的是三个标记数组.

#### 5.2.4 运行与复杂度

```c
#ifndef NOTE_NO_MAIN
static void PrintQueens(const int col[], int n)
{
    for (int i = 0; i < n; ++i) printf("%d%c", col[i] + 1, i + 1 == n ? '\n' : ' ');
}
int main(void)
{
    printf("4 queens: %llu solutions\n", (unsigned long long)SolveQueens(4, PrintQueens));
    printf("8 queens: %llu solutions\n", (unsigned long long)SolveQueens(8, NULL));
    return 0;
}
#endif
```

4 皇后输出两个解, 8 皇后得到 $92$ 个解. 这里把旋转、镜像形成的摆法分别计数, 没有合并成基本解.

> [!NOTE]
>
> 本实现支持 $0\le N\le15$, $N=0$ 按组合计数约定有一个空解, 越界返回 0. `visit=NULL` 时只计数; 回调如果要保留答案, 应立即复制数组.

剪枝不会保证多项式时间. 以忽略对角线剪枝的排列搜索树估计, 部分排列节点总数为 $O(N!)$, 本实现每个非叶节点仍会扫描 $N$ 列, 所以 $O(N\cdot N!)$ 是一个保守上界. 存储当前路径、标记与递归栈需要 $O(N)$ 空间, 不包含输出全部解的存储.

### 5.3 The Turnpike Reconstruction Problem

> 完整可运行源码: [turnpike.c](./code/turnpike.c).

#### 5.3.1 给距离, 反过来求坐标

给出数轴上 $N$ 个互不相同的点:

$$
0=x_1<x_2<\cdots<x_N
$$

任意两点之间都有一个距离, 一共有 $N(N-1)/2$ 个. 现在只知道这些距离, 要求还原一组点的位置.

课件例子:

$$
D=\{1,2,2,2,3,3,3,4,5,5,5,6,7,8,10\}
$$

因为有 15 个距离, 所以 $N(N-1)/2=15$, 得到 $N=6$. 最大距离为 10, 所以先确定两端点 $x_1=0,x_6=10$.

> [!IMPORTANT]
>
> $D$ 是 Multiset, 即多重集. 距离 2 出现三次, 就只能使用三次.
>
> 不能只问“2 在不在集合里”, 而不管还剩几份.

#### 5.3.2 为什么下一步只有两个候选

设两端点间距为 $L$, 剩余距离的最大值为 $d$.

此时所有“已确定点之间”的距离都已经删除. 设未确定点中最左边的坐标为 $u$, 最右边为 $v$, 那么剩余最大距离必然是:

$$
d=\max\{v,L-u\}
$$

因为任何至少涉及一个未确定点的距离, 都不会大于这两个端点距离的最大值; 而 $v$ 到 0、$u$ 到 $L$ 的距离都还在集合里.

所以至少有一个候选成立:

1. 最右边尚未确定的点在 $d$;
2. 最左边尚未确定的点在 $L-d$.

每次先尝试一个, 不行就回退尝试另一个.

#### 5.3.3 Check 与 Undo 到底做什么

假设要放一个新点 $y$, 已确定的点为 $p_1,\ldots,p_k$, 那么它需要的距离是:

$$
|y-p_1|,\ldots,|y-p_k|
$$

这些距离必须**按出现次数全部包含于剩余多重集**. 能扣除才放点; 递归失败, 就把刚扣除的距离一份不差地加回去.

以上面的例子为例, 先放 0 和 10, 再尝试 8, 会用掉距离 8、2. 接着尝试 7, 用掉 7、3、1. 下一步尝试 6 时又需要距离 1, 但此时已经没有了, 所以必须回退, 不能继续放下去.

最后可以得到:

$$
(0,3,5,6,8,10)
$$

它的镜像也是答案. 一般输入还可能有不止一对镜像解, 因而题目要求的是“还原一组”, 不应默认唯一.

#### 5.3.4 多重集与扣除操作

这里先排序所有距离, 用 `value[]` 存不同距离, `count[]` 存剩余次数. `taken[]` 记录本次实际扣除的下标, 便于失败后撤销.

所需头文件为 `<stdio.h>`、`<stdlib.h>`:

```c
#define POINT_LIMIT 64
#define DIST_LIMIT (POINT_LIMIT * (POINT_LIMIT - 1) / 2)
typedef struct {
    int value[DIST_LIMIT], count[DIST_LIMIT], kinds, remaining;
    int x[POINT_LIMIT], n, width;
} TurnpikeState;

static int CompareInt(const void *a, const void *b)
{
    int x = *(const int *)a, y = *(const int *)b;
    return (x > y) - (x < y);
}

static int FindDistance(const TurnpikeState *s, int d)
{
    int lo = 0, hi = s->kinds;
    while (lo < hi) {
        int mid = lo + (hi - lo) / 2;
        if (s->value[mid] < d) lo = mid + 1;
        else hi = mid;
    }
    return lo < s->kinds && s->value[lo] == d ? lo : -1;
}

static void Restore(TurnpikeState *s, const int taken[], int k)
{
    while (k > 0) {
        ++s->count[taken[--k]];
        ++s->remaining;
    }
}

static int TakeDistances(TurnpikeState *s, int y, int left, int right,
                         int taken[], int *k)
{
    *k = 0;
    for (int i = 0; i < s->n; ++i) {
        if (i >= left && i <= right) continue; // 还没确定的点
        int d = y > s->x[i] ? y - s->x[i] : s->x[i] - y;
        int at = FindDistance(s, d);
        if (at < 0 || s->count[at] == 0) {
            Restore(s, taken, *k); // 部分扣除失败也要恢复
            return 0;
        }
        --s->count[at];
        --s->remaining;
        taken[(*k)++] = at;
    }
    return 1;
}
```

`TakeDistances` 中“扣到一半失败”的路径也进行了恢复. 这是 Turnpike 代码里很容易漏掉的地方.

#### 5.3.5 递归重建

维护如下不变量:

> `x[0..left-1]` 与 `x[right+1..n-1]` 已确定, 中间的空位还没有填; 剩余多重集正好对应至少涉及一个未确定点的距离.

```c
static int Reconstruct(TurnpikeState *s, int left, int right)
{
    if (left > right) return s->remaining == 0;
    int at = s->kinds - 1;
    while (at >= 0 && s->count[at] == 0) --at;
    if (at < 0) return 0;
    int d = s->value[at];
    int candidate[2] = {d, s->width - d};
    for (int option = 0; option < 2; ++option) {
        int y = candidate[option], taken[POINT_LIMIT], k;
        if (option == 1 && candidate[0] == y) continue;
        if (y <= s->x[left - 1] || y >= s->x[right + 1]) continue;
        if (!TakeDistances(s, y, left, right, taken, &k)) continue;
        int slot = option == 0 ? right : left;
        s->x[slot] = y;
        if (Reconstruct(s, left + (option == 1), right - (option == 0))) return 1;
        Restore(s, taken, k);
    }
    return 0;
}

// out 至少有 POINT_LIMIT 个位置; 失败时不改 out / pointCount.
// 正整数距离表示互不重合的点; m=0 约定还原为单点 {0}.
int Turnpike(const int distances[], int m, int out[], int *pointCount)
{
    if (m < 0 || m > DIST_LIMIT || !out || !pointCount || (m && !distances)) return 0;
    int n = 1;
    while (n < POINT_LIMIT && n * (n - 1) / 2 < m) ++n;
    if (n * (n - 1) / 2 != m) return 0;
    if (n == 1) { out[0] = 0; *pointCount = 1; return 1; }
    int sorted[DIST_LIMIT];
    for (int i = 0; i < m; ++i) {
        if (distances[i] <= 0) return 0;
        sorted[i] = distances[i];
    }
    qsort(sorted, (size_t)m, sizeof *sorted, CompareInt);
    TurnpikeState s = {0};
    s.n = n;
    s.remaining = m - 1;
    for (int i = 0; i < m; ++i) {
        if (s.kinds == 0 || s.value[s.kinds - 1] != sorted[i])
            s.value[s.kinds++] = sorted[i];
        ++s.count[s.kinds - 1];
    }
    s.width = s.x[n - 1] = sorted[m - 1];
    --s.count[s.kinds - 1]; // 两端点之间的距离已被用掉
    if (!Reconstruct(&s, 1, n - 2)) return 0;
    for (int i = 0; i < n; ++i) out[i] = s.x[i];
    *pointCount = n;
    return 1;
}
```

注意, 失败分支不需要清空 `x[slot]`, 因为进入下一次检查时它属于 `[left,right]` 的未确定区间, 会被跳过; 距离计数则必须真正恢复.

本实现最多支持 64 个点, 距离为正 `int`. 数量不是三角数、包含非正距离, 或者根本无法重建, 都返回失败. 成功输出按照坐标递增; 不改动传入的距离数组.

```c
#ifndef NOTE_NO_MAIN
int main(void)
{
    const int distances[] = {1,2,2,2,3,3,3,4,5,5,5,6,7,8,10};
    int x[POINT_LIMIT], n;
    if (Turnpike(distances, 15, x, &n)) {
        for (int i = 0; i < n; ++i) printf("%d%c", x[i], i + 1 == n ? '\n' : ' ');
    } else puts("No solution");
    return 0;
}
#endif
```

#### 5.3.6 时间复杂度

每层至多两个分支, 深度为 $N-2$, 最坏搜索树可以是指数规模.

本实现每个节点会扫描至多 $O(N^2)$ 种距离以找最大剩余值, 再对 $O(N)$ 个已知点进行二分查找. 因此 $O(N^2 2^N)$ 是保守最坏上界, 距离排序预处理另需 $O(N^2\log N)$ 时间.

保存距离需要 $O(N^2)$ 空间; 各递归层的撤销记录累计也是 $O(N^2)$. 换一种多重集结构可以优化单个节点的开销, 但不能仅凭剪枝就把整个算法说成多项式时间.

### 5.4 搜索顺序与优化问题

#### 5.4.1 Smaller Si First

课件提出, 如果不同变量的候选集合 $S_i$ 大小不同, 可以优先处理较小的集合.

为什么? 越受限制的变量越容易暴露冲突, 先确定它可能更早剪掉无效分支. 如果约束会随搜索过程变化, 就可以在每一步选择**当前剩余合法候选最少**的变量.

> [!CAUTION]
>
> 这是一种搜索顺序启发式, 不会凭空减少正确答案, 也不保证每个输入都更快. 变量改了处理顺序, 仍要保留它的原始编号和约束关系.

#### 5.4.2 Safe Fruit 怎样建模

课件第 18 页用“某些水果不能同时吃”引出项目, 但具体输入输出和完整优化目标需要另外的题面.

这里先写一个明确的教学版本: **在给定冲突关系下, 选出数量最多的一组水果**, 每种水果选或不选, 不添加价格、优先级等额外规则.

把水果看成顶点, 冲突关系看成无向边, 则所选集合内部不能有边, 也就是 Independent Set. 最大化所选数量, 对应 Maximum Independent Set.

搜索到第 $i$ 种水果时有两种选择:

1. 选: 必须与所有已选水果都不冲突;
2. 不选: 直接进入下一种.

假设当前已选 `count` 种, 还有 `N-i` 种没处理, 那么即使剩下的全选, 最多也只有:

$$
\text{upperBound}=\text{count}+N-i
$$

如果这个上界都不大于当前最优答案 `best`, 就不可能改善答案, 可以剪枝. 这体现了 Branch and Bound 的思想: 用最乐观的上界排除无望分支.

> [!CAUTION]
>
> `upperBound <= best` 适用于这里只要**一个**最优解的要求. 如果要列出所有并列最优解, 不能把可能恰好等于 `best` 的分支也剪掉.

完整可运行源码: [safe_fruit.c](./code/safe_fruit.c), 头文件为 `<stdio.h>`:

```c
#define FRUIT_LIMIT 32
typedef struct {
    int n, best, chosen[FRUIT_LIMIT], answer[FRUIT_LIMIT];
    unsigned char conflict[FRUIT_LIMIT][FRUIT_LIMIT];
} FruitState;

static void ChooseFruit(FruitState *s, int i, int count)
{
    if (count + s->n - i <= s->best) return; // 最乐观也无法改善答案
    if (i == s->n) {
        s->best = count;
        for (int j = 0; j < s->n; ++j) s->answer[j] = s->chosen[j];
        return;
    }
    int ok = 1;
    for (int j = 0; j < i; ++j)
        if (s->chosen[j] && s->conflict[i][j]) { ok = 0; break; }
    if (ok) {
        s->chosen[i] = 1;
        ChooseFruit(s, i + 1, count + 1);
        s->chosen[i] = 0;
    }
    ChooseFruit(s, i + 1, count);
}

// 简化教学目标: 选最多种两两不冲突的水果, 不含价格或其他次级目标.
// conflict 为无向简单图的对称 0/1 邻接矩阵; answer 至少有 n 个元素.
int SafeFruit(int n, unsigned char conflict[FRUIT_LIMIT][FRUIT_LIMIT], int answer[])
{
    if (n < 0 || n > FRUIT_LIMIT || !conflict || !answer) return -1;
    FruitState s = {0};
    s.n = n;
    for (int i = 0; i < n; ++i)
        for (int j = 0; j < n; ++j) s.conflict[i][j] = conflict[i][j];
    ChooseFruit(&s, 0, 0);
    for (int i = 0; i < n; ++i) answer[i] = s.answer[i];
    return s.best;
}
```

```c
#ifndef NOTE_NO_MAIN
int main(void)
{
    unsigned char conflict[FRUIT_LIMIT][FRUIT_LIMIT] = {{0}};
    int answer[FRUIT_LIMIT];
    conflict[0][1] = conflict[1][0] = 1;
    conflict[1][2] = conflict[2][1] = 1;
    conflict[2][3] = conflict[3][2] = 1;
    printf("maximum count = %d\n", SafeFruit(4, conflict, answer));
    for (int i = 0; i < 4; ++i) if (answer[i]) printf("fruit %d\n", i + 1);
    return 0;
}
#endif
```

邻接矩阵应对称且对角线为 0, 本实现上限为 32 种水果, 最坏仍需指数级搜索. 每个搜索节点的冲突检查为 $O(N)$, 可用 $O(N2^N)$ 作保守上界; 矩阵占 $O(N^2)$ 空间. 这份代码用于理解剪枝, 不等同于完整课程项目的提交程序.

### 5.5 Games 与 Minimax

> 完整可运行源码: [tictactoe.c](./code/tictactoe.c).

#### 5.5.1 井字棋与 Game Tree

井字棋有 9 个位置, 每个位置可以为空、X、O. 如果不检查规则, 有 $3^9=19683$ 种格子赋值; 如果按落子顺序把九格都填满, 有 $9!=362880$ 种顺序.

> [!CAUTION]
>
> 这两个数都是粗略枚举空间的大小, 不是真正合法可达局面数或合法完整对局数. 双方交替落子, 且有人获胜就应停止, 会排除不少情况.

我们不能只挑“下一步对自己最有利”的位置, 因为对手也会选择对自己有利的应对.

于是有 Minimax:

- 轮到我方, 取子节点评价的最大值;
- 轮到对方, 取子节点评价的最小值.

整个树始终使用同一个评价视角. 以下规定 X 为 MAX, O 为 MIN.

#### 5.5.2 Evaluation Function

课件的启发式评价是:

$$
f(P)=W_{\text{Computer}}-W_{\text{Human}}
$$

这里 $W$ 表示仍有可能连成三子的线的数量: 对 X 而言, 一条线只要不含 O, 就还可能成为 X 的胜线; 对 O 同理.

这个数适合在**提前截断搜索**时估计局面好坏. 它不等于完美对弈结果, 终局仍要优先按真实胜负计分.

下面代码把 X 获胜记为 $+10$, O 获胜记为 $-10$, 平局记为 0. 完整搜索一直进行到终局, 因而无需用启发式评价代替终局值. `Potential` 单独保留以对应课件中的定义.

头文件为 `<stdio.h>`:

```c
static const int Lines[8][3] = {
    {0,1,2}, {3,4,5}, {6,7,8}, {0,3,6},
    {1,4,7}, {2,5,8}, {0,4,8}, {2,4,6}
};

int Winner(const int board[9])
{
    for (int i = 0; i < 8; ++i) {
        int a = Lines[i][0], b = Lines[i][1], c = Lines[i][2];
        if (board[a] && board[a] == board[b] && board[b] == board[c]) return board[a];
    }
    return 0;
}

int Potential(const int board[9])
{
    int wx = 0, wo = 0;
    for (int i = 0; i < 8; ++i) {
        int hasX = 0, hasO = 0;
        for (int j = 0; j < 3; ++j) {
            hasX |= board[Lines[i][j]] == 1;
            hasO |= board[Lines[i][j]] == -1;
        }
        wx += !hasO;
        wo += !hasX;
    }
    return wx - wo;
}
```

#### 5.5.3 Minimax 值怎样往上传

若 $V(P)$ 表示当前局面的值, 则:

$$
V(P)=
\begin{cases}
\operatorname{score}(P), & P\text{ 为终局};\\
\max\limits_{C\in\operatorname{Children}(P)}V(C), & \text{轮到 MAX};\\
\min\limits_{C\in\operatorname{Children}(P)}V(C), & \text{轮到 MIN}.
\end{cases}
$$

例如, MAX 面前有两个分支, 对手分别可以把结果压低到 1 和 -2, 那么 MAX 会选择第一个, 当前局面的值为 1.

这不是猜测对手实际会怎样犯错, 而是假设双方都按最优策略行动.

### 5.6 Alpha-Beta Pruning

#### 5.6.1 已经不可能被选中的分支

假设 MAX 已经找到一条至少能得到 44 的路. 它再看另一个 MIN 节点, 发现其中一个子节点的值为 40.

那么这个 MIN 节点最后的值一定 $\le40$, 后面即使出现 100 也没有用, 因为 MIN 会选择更小的那个. MAX 已经有 44, 所以不需要继续看这里剩余的孩子.

对称地, 如果某个 MIN 祖先已经有至多为 40 的选择, 再探索一个 MAX 分支时发现它至少为 44, 这个 MAX 分支也不会被该 MIN 祖先选中.

#### 5.6.2 alpha 和 beta 分别是什么

在当前搜索路径上:

- $\alpha$: MAX 已经能保证的下界;
- $\beta$: MIN 已经能保证的上界.

初始为 $\alpha=-\infty,\beta=+\infty$. 访问 MAX 节点时提高 $\alpha$, 访问 MIN 节点时降低 $\beta$.

> [!IMPORTANT]
>
> 当 $\alpha\ge\beta$ 时, 剩余孩子不可能影响祖先的选择, 可以截断搜索.
>
> MIN 节点发现值 $\le\alpha$ 对应 alpha cutoff; MAX 节点发现值 $\ge\beta$ 对应 beta cutoff.

注意: 这是停止当前节点的剩余分支, 不是结束整场搜索.

#### 5.6.3 完整 Minimax / Alpha-Beta 代码

两者的递归过程相同, 只通过 `prune` 决定是否启用截断. 井字棋的分值在 $[-10,10]$, 因而用 -11、11 作为初始边界即可.

```c
// board 为合法可达局面; turn: X=1, O=-1. 返回值始终站在 X 的视角.
static int Search(int board[9], int turn, int alpha, int beta, int prune)
{
    int win = Winner(board);
    if (win) return 10 * win;
    int best = turn == 1 ? -11 : 11, moved = 0;
    for (int i = 0; i < 9; ++i) {
        if (board[i]) continue;
        moved = 1;
        board[i] = turn;
        int value = Search(board, -turn, alpha, beta, prune);
        board[i] = 0; // 必须在 break / return 前撤销
        if (turn == 1) {
            if (value > best) best = value;
            if (best > alpha) alpha = best;
        } else {
            if (value < best) best = value;
            if (best < beta) beta = best;
        }
        if (prune && alpha >= beta) break;
    }
    return moved ? best : 0;
}

int Minimax(int board[9], int turn) { return Search(board, turn, -11, 11, 0); }
int AlphaBeta(int board[9], int turn) { return Search(board, turn, -11, 11, 1); }

int BestMove(int board[9], int turn)
{
    if (Winner(board)) return -1;
    int best = turn == 1 ? -11 : 11, move = -1;
    for (int i = 0; i < 9; ++i) {
        if (board[i]) continue;
        board[i] = turn;
        int value = AlphaBeta(board, -turn);
        board[i] = 0;
        if ((turn == 1 && value > best) || (turn == -1 && value < best)) {
            best = value;
            move = i;
        }
    }
    return move;
}
```

`BestMove` 对每个候选使用完整窗口求值, 取最优的一个. 并列时保留最先遍历到的位置. 它没有额外偏好“更快获胜”或“更晚失败”.

> [!CAUTION]
>
> 截断发生前必须把试走的棋子撤销, 否则别的分支会在被污染的棋盘上继续计算.
>
> 内部被截断的节点返回值可能只是足以证明剪枝成立的界; 不要把它误当成该节点全部孩子搜索后的精确值. 根节点以完整窗口搜索, 得到的 Minimax 值保持正确.

```c
#ifndef NOTE_NO_MAIN
int main(void)
{
    int board[9] = {0};
    printf("empty board minimax = %d, alpha-beta = %d\n", Minimax(board, 1), AlphaBeta(board, 1));
    int turn = 1, move;
    while ((move = BestMove(board, turn)) >= 0) {
        board[move] = turn;
        turn = -turn;
    }
    for (int i = 0; i < 9; ++i)
        printf("%c%c", board[i] == 1 ? 'X' : board[i] == -1 ? 'O' : '.', i % 3 == 2 ? '\n' : ' ');
    printf("winner = %d (0 means draw)\n", Winner(board));
    return 0;
}
#endif
```

空棋盘的最优对弈结果为 0, 双方都用 `BestMove` 时得到平局. 函数输入应为合法可达的局面, `turn` 应与实际轮次一致; 这里不另做外部棋谱合法性校验.

#### 5.6.4 剪枝能快多少

设每层平均分支数为 $b$, 搜索深度为 $d$:

| 方法 | 时间 | 说明 |
| :--- | :--- | :--- |
| 完整 Minimax | $O(b^d)$ | 搜索到设定深度或终局 |
| Alpha-Beta 最坏情况 | $O(b^d)$ | 走子顺序差, 几乎不能剪枝 |
| Alpha-Beta 理想走子顺序 | 约 $O(b^{d/2})$ | 均匀博弈树模型下的经典最佳量级 |

搜索时只保留当前路径, 递归额外空间为 $O(d)$, 不包含事先存储整棵树的情况. 本例用固定大小棋盘, 直接原地试走和撤销.

> [!TIP]
>
> MAX 优先尝试可能得分较高的走法, MIN 优先尝试可能得分较低的走法, 有利于更早收紧边界. 这改变搜索效率, 不改变完整搜索的最优值.

课件借棋类游戏引出搜索思想; 此处的井字棋 Minimax 示例不能直接代表 AlphaGo 的完整算法.

### 5.7 最后把几种剪枝分开

| 场景 | 剪枝依据 | 撤销内容 |
| :--- | :--- | :--- |
| N Queens | 已违反列 / 对角线约束 | 三个占用标记 |
| Turnpike | 剩余距离及其次数不够 | 已扣除的每一份距离 |
| Safe Fruit 教学版 | 冲突, 或最大可能数量不优于已有答案 | 当前选择标记 |
| Minimax / Alpha-Beta | 当前分支无法改善祖先的选择 | 当前试走的棋子 |

<details style="--wi-box-color:var(--wi-question);--wi-box-bg:var(--wi-question-bg)"><summary>回溯最容易写错的是什么?</summary><p>不是递归调用本身, 而是没说清楚“当前状态是什么”和“返回时要恢复哪些东西”. 写代码前先写不变量, 通常比写完再找漏掉的 Undo 更省事.</p></details>

## Chapter 6: Divide and Conquer

> 对应课件: [ADS07Divide Conquer_Stu.ppt](<../lesson/Materials/Student Slides/ADS07Divide Conquer_Stu.ppt>), 第 2～6 页为分治与最近点对, 第 7～16 页为递推式分析.

### 6.1 分治到底在做什么

#### 6.1.1 Divide, Conquer, Combine

分治可以拆成三个步骤:

1. **Divide**: 把原问题拆成若干规模更小的子问题;
2. **Conquer**: 递归求解这些子问题;
3. **Combine**: 利用子问题的答案构造原问题的答案.

规模足够小时直接求解, 否则递归会没有尽头.

<details style="--wi-box-color:var(--wi-question);--wi-box-bg:var(--wi-question-bg)"><summary>回溯也递归, 那它和分治有什么区别?</summary><p>回溯通常是在不同候选选择之间搜索, 失败就撤销并换一条路; 分治是把需要解决的子问题分别算出答案, 再合并. 是否使用递归, 并不能单独决定算法属于哪一类.</p></details>

#### 6.1.2 一般递推式

如果每次产生 $a$ 个规模为 $N/b$ 的子问题, 本层除递归之外的工作为 $f(N)$, 则:

$$
T(N)=aT(N/b)+f(N)
$$

其中 $a\ge1,b>1$ 为常数. $f(N)$ 应包括划分、合并和其他本层开销, 不能只看某一段循环.

> [!CAUTION]
>
> 分成两份并不自动意味着 $O(N\log N)$.
>
> 还要看两份的大小是否平衡, 以及本层合并要多少时间.

### 6.2 先回顾几个已有例子

> 完整可运行源码: [divide_basics.c](./code/divide_basics.c). 所需头文件为 `<stdio.h>`、`<stdlib.h>`、`<stdint.h>`, 各函数使用左闭右开的区间 `[left,right)`.

#### 6.2.1 Maximum Subsequence Sum

最大连续子序列和的答案只有三种位置:

1. 完全在左半边;
2. 完全在右半边;
3. 跨过中间分界线.

前两种递归计算. 第三种必须由“左半边最大后缀和 + 右半边最大前缀和”组成, 两次线性扫描即可求出.

```c
static long long MaxSumRec(const int a[], int left, int right)
{
    if (left == right) return 0;
    if (right - left == 1) return a[left] > 0 ? a[left] : 0;
    int mid = left + (right - left) / 2;
    long long bestLeft = MaxSumRec(a, left, mid);
    long long bestRight = MaxSumRec(a, mid, right);
    long long suffix = 0, prefix = 0, sum = 0;
    for (int i = mid - 1; i >= left; --i) {
        sum += a[i];
        if (sum > suffix) suffix = sum;
    }
    sum = 0;
    for (int i = mid; i < right; ++i) {
        sum += a[i];
        if (sum > prefix) prefix = sum;
    }
    long long best = bestLeft > bestRight ? bestLeft : bestRight;
    return best > suffix + prefix ? best : suffix + prefix;
}

// 允许空子序列, 因而空数组 / 全负数组的结果均为 0.
long long MaxSubsequenceSum(const int a[], int n)
{
    return n > 0 ? MaxSumRec(a, 0, n) : 0;
}
```

因此:

$$
T(N)=2T(N/2)+\Theta(N)=\Theta(N\log N)
$$

> [!NOTE]
>
> 这里允许空子序列, 所以全负数组的答案为 0. 如果题目要求非空, 基例和前后缀初始化都要相应修改, 不能直接照搬这个版本.
>
> 这不是此问题最快的算法, 还可以做到线性时间; 本节用它说明分治结构.

#### 6.2.2 Merge Sort

Merge Sort 先把两半排好序, 再用双指针线性合并. 每层总工作量为 $\Theta(N)$, 一共有 $\Theta(\log N)$ 层.

```c
static void MergeSortRec(int a[], int temp[], int left, int right)
{
    if (right - left <= 1) return;
    int mid = left + (right - left) / 2;
    MergeSortRec(a, temp, left, mid);
    MergeSortRec(a, temp, mid, right);
    int i = left, j = mid, k = left;
    while (i < mid && j < right)
        temp[k++] = a[i] <= a[j] ? a[i++] : a[j++];
    while (i < mid) temp[k++] = a[i++];
    while (j < right) temp[k++] = a[j++];
    for (i = left; i < right; ++i) a[i] = temp[i];
}

int MergeSort(int a[], int n)
{
    if (n < 0 || (n > 0 && !a)) return 0;
    if (n < 2) return 1;
    if ((size_t)n > SIZE_MAX / sizeof(int)) return 0;
    int *temp = malloc((size_t)n * sizeof *temp);
    if (!temp) return 0;
    MergeSortRec(a, temp, 0, n);
    free(temp);
    return 1;
}
```

辅助数组只在最外层申请一次, 递归中复用, 额外空间为 $O(N)$, 递归栈为 $O(\log N)$. 合并时相等元素优先取左侧, 所以这种归并规则是稳定的.

#### 6.2.3 Quick Sort

Quick Sort 把主要工作放在划分阶段: 小于 pivot 的到左边, 大于 pivot 的到右边, 然后分别排序.

下面用三路划分, 把等于 pivot 的一段集中起来, 避免重复元素被不断递归处理:

```c
static void Swap(int *a, int *b) { int t = *a; *a = *b; *b = t; }

static void QuickSortRec(int a[], int left, int right)
{
    while (right - left > 1) {
        int pivot = a[left + (right - left) / 2];
        int lt = left, i = left, gt = right;
        // [left,lt) < pivot, [lt,i) == pivot, [i,gt) 未知, [gt,right) > pivot
        while (i < gt) {
            if (a[i] < pivot) Swap(&a[lt++], &a[i++]);
            else if (a[i] > pivot) Swap(&a[i], &a[--gt]);
            else ++i;
        }
        // 只递归较小一侧, 较大一侧改成循环, 控制栈深度.
        if (lt - left < right - gt) {
            QuickSortRec(a, left, lt);
            left = gt;
        } else {
            QuickSortRec(a, gt, right);
            right = lt;
        }
    }
}

void QuickSort(int a[], int n)
{
    if (n > 1) QuickSortRec(a, 0, n);
}
```

若两边比较均衡, 则为 $\Theta(N\log N)$; 若持续极不均衡, 则有:

$$
T(N)=T(N-1)+\Theta(N)=\Theta(N^2)
$$

> [!CAUTION]
>
> 代码取的是**下标中间位置的元素**, 不一定是按数值大小排列后的中位数, 所以仍可能遇到二次时间的最坏情况.
>
> 只递归较小一侧能把栈深度限制为 $O(\log N)$, 但不会因此消除最坏 $O(N^2)$ 的运行时间.

讨论平均 $O(N\log N)$ 时, 要有相应的随机输入或随机选 pivot 假设, 不能把平均界写成无条件的最坏界.

#### 6.2.4 Tree Traversals

遍历也是递归处理左右子问题的例子. 前序、中序、后序的区别只是访问根节点的位置:

```c
typedef struct TreeNode {
    int key;
    struct TreeNode *left, *right;
} TreeNode;
typedef void (*Visitor)(int key);

void Preorder(const TreeNode *t, Visitor visit)
{
    if (!t) return;
    visit(t->key);
    Preorder(t->left, visit);
    Preorder(t->right, visit);
}
void Inorder(const TreeNode *t, Visitor visit)
{
    if (!t) return;
    Inorder(t->left, visit);
    visit(t->key);
    Inorder(t->right, visit);
}
void Postorder(const TreeNode *t, Visitor visit)
{
    if (!t) return;
    Postorder(t->left, visit);
    Postorder(t->right, visit);
    visit(t->key);
}
```

如果访问一个节点为 $O(1)$, 每个节点恰好访问一次, 总时间为 $\Theta(N)$, 栈空间为 $O(h)$.

> [!IMPORTANT]
>
> 任意二叉树不一定平衡, 正确的一般形式是:
>
> $T(N)=T(N_L)+T(N_R)+\Theta(1)$, 其中 $N_L+N_R=N-1$.
>
> 不能对所有二叉树都直接写 $2T(N/2)+O(1)$. 树退化成链时, 遍历时间仍是线性的, 栈深度却可能变成 $O(N)$.

#### 6.2.5 将例子串起来

```c
#ifndef NOTE_NO_MAIN
static void PrintKey(int key) { printf("%d ", key); }
int main(void)
{
    int a[] = {-2, 11, -4, 13, -5, -2}, b[] = {3, 1, 3, 0, -2, 8};
    printf("maximum sum = %lld\n", MaxSubsequenceSum(a, 6));
    if (!MergeSort(a, 6)) return 1;
    QuickSort(b, 6);
    for (int i = 0; i < 6; ++i) printf("%d%c", a[i], i == 5 ? '\n' : ' ');
    for (int i = 0; i < 6; ++i) printf("%d%c", b[i], i == 5 ? '\n' : ' ');
    TreeNode l = {1, NULL, NULL}, r = {3, NULL, NULL}, root = {2, &l, &r};
    Preorder(&root, PrintKey); putchar('\n');
    Inorder(&root, PrintKey); putchar('\n');
    Postorder(&root, PrintKey); putchar('\n');
    return 0;
}
#endif
```

最大子序列和示例输出 20; 随后分别展示归并排序、快速排序, 以及小树的前序、中序、后序遍历.

### 6.3 Closest Points Problem

> 完整可运行源码: [closest_pair.c](./code/closest_pair.c).

#### 6.3.1 为什么不能只看左右两边

给定平面上的 $N$ 个点, 求距离最近的一对. 如果两个不同输入点坐标相同, 答案就是 0.

暴力枚举全部点对, 有 $N(N-1)/2$ 对, 时间为 $\Theta(N^2)$.

分治时先按 x 坐标排序, 按**点的数量**分成左右两半. 递归得到两侧最近距离 $\delta_L,\delta_R$, 记:

$$
\delta=\min\{\delta_L,\delta_R\}
$$

但是, 最优点对可能一左一右, 所以还必须检查跨分界线的点对.

```text
        左半边          |          右半边
                        |
                 p  ·   |  · q
                        |
                  x = midX
```

#### 6.3.2 为什么只看 Strip

如果跨界点对的距离小于 $\delta$, 则两个点到分界线的水平距离也都必须小于 $\delta$.

因此只需考虑:

$$
|x-\text{midX}|<\delta
$$

这个宽度为 $2\delta$ 的竖直带状区域就是 Strip.

> [!CAUTION]
>
> Strip 中仍可能有 $N$ 个点. 仅仅缩小到 Strip, 再把其中所有点两两比较, 最坏还是 $\Theta(N^2)$.

#### 6.3.3 按 y 排序后, 为什么只看后面 7 个点

先让 Strip 内的点按 y 坐标递增排列. 对于点 $p_i$, 只需继续考虑 y 差小于 $\delta$ 的后续点, 再远就不可能改善答案.

这些点被限制在一个宽 $2\delta$、高 $\delta$ 的矩形中. 把左右各宽 $\delta$ 的部分再分成边长 $\delta/2$ 的小格, 一共有 8 格.

同一侧的小格里不能同时出现两个点: 它们的距离小于 $\delta$, 会与“该侧最近距离至少为 $\delta$”矛盾. 因而矩形里至多有 8 个需要考虑的点, 包括当前点自身, 后面最多比较 7 个.

即使某些点的 x 坐标正好落在分界线上, 也按递归划分时的左右归属计入相应半区; 不要用 `x < midX` 重新划分成员, 否则同 x 的点可能全部跑到同一侧.

> [!IMPORTANT]
>
> “最多比较 7 个”依赖两个条件: **两侧已经递归求出最近距离**, 并且 **Strip 按 y 有序**. 它不是任意点集都能直接使用的规则.

#### 6.3.4 又一个容易漏掉的 log

如果每次递归都对 Strip 调用一次排序, 合并层的开销可能是 $\Theta(N\log N)$, 则:

$$
T(N)=2T(N/2)+\Theta(N\log N)=\Theta(N\log^2N)
$$

所以要想做到 $\Theta(N\log N)$, 需要把 y 序一起维护起来.

这里的做法与 Merge Sort 相似:

1. 最外层只做一次 x 排序;
2. 递归入口时, 当前片段按 x 排好;
3. 每个子问题返回时, 把自己的点按 y 排好;
4. 父问题线性归并两个 y 有序片段, 再顺序筛出 Strip.

这样本层的合并与 Strip 检查均为 $O(N)$.

#### 6.3.5 数据类型与初始排序

下面使用整数坐标并比较**平方距离**, 避免每次开平方. 坐标限制为 $[-10^9,10^9]$, 因而最大平方距离为 $8\times10^{18}$, 可以放入 `long long`.

所需头文件为 `<limits.h>`、`<stdint.h>`、`<stdio.h>`、`<stdlib.h>`:

```c
// 整数坐标限制在 [-10^9,10^9], 使平方距离能精确存入 long long.
typedef struct { long long x, y; int id; } Point;
typedef struct { long long squared; int first, second; } ClosestResult;

static int BeforeX(Point a, Point b)
{
    return a.x < b.x || (a.x == b.x && (a.y < b.y || (a.y == b.y && a.id < b.id)));
}
static int BeforeY(Point a, Point b)
{
    return a.y < b.y || (a.y == b.y && (a.x < b.x || (a.x == b.x && a.id < b.id)));
}
static void SortX(Point p[], Point temp[], int n)
{
    if (n < 2) return;
    int mid = n / 2;
    SortX(p, temp, mid);
    SortX(p + mid, temp + mid, n - mid);
    int i = 0, j = mid, k = 0;
    while (i < mid && j < n) temp[k++] = BeforeX(p[i], p[j]) ? p[i++] : p[j++];
    while (i < mid) temp[k++] = p[i++];
    while (j < n) temp[k++] = p[j++];
    for (i = 0; i < n; ++i) p[i] = temp[i];
}

static void Consider(ClosestResult *best, Point a, Point b)
{
    long long dx = a.x - b.x, dy = a.y - b.y;
    long long d = dx * dx + dy * dy;
    if (d < best->squared) {
        best->squared = d;
        best->first = a.id;
        best->second = b.id;
    }
}
```

这里连初始 x 排序也采用归并排序, 使最坏 $O(N\log N)$ 的排序界明确. `id` 记录原数组下标, 即使点被重新排序也能返回原来的两个点.

#### 6.3.6 核心递归

```c
// 入口: 当前片段按 x 排好; 出口: 同一批点按 y 排好.
static ClosestResult ClosestRec(Point p[], Point temp[], int n)
{
    ClosestResult best = {LLONG_MAX, -1, -1};
    if (n <= 3) {
        for (int i = 0; i < n; ++i)
            for (int j = i + 1; j < n; ++j) Consider(&best, p[i], p[j]);
        for (int i = 1; i < n; ++i) {
            Point v = p[i];
            int j = i;
            while (j > 0 && BeforeY(v, p[j - 1])) { p[j] = p[j - 1]; --j; }
            p[j] = v;
        }
        return best;
    }
    int mid = n / 2;
    long long midX = p[mid].x; // 必须在递归将点改为 y 序之前保存
    ClosestResult a = ClosestRec(p, temp, mid);
    ClosestResult b = ClosestRec(p + mid, temp + mid, n - mid);
    best = a.squared <= b.squared ? a : b;

    int i = 0, j = mid, k = 0;
    while (i < mid && j < n) temp[k++] = BeforeY(p[i], p[j]) ? p[i++] : p[j++];
    while (i < mid) temp[k++] = p[i++];
    while (j < n) temp[k++] = p[j++];
    for (i = 0; i < n; ++i) p[i] = temp[i];
    if (best.squared == 0) return best; // y 序已维护好, 才能提前结束

    int count = 0;
    for (i = 0; i < n; ++i) {
        long long dx = p[i].x - midX;
        if (dx * dx < best.squared) temp[count++] = p[i];
    }
    for (i = 0; i < count; ++i) {
        for (j = i + 1; j < count && j - i <= 7; ++j) {
            long long dy = temp[j].y - temp[i].y;
            if (dy * dy >= best.squared) break;
            Consider(&best, temp[i], temp[j]);
        }
    }
    return best;
}
```

这里有三个细节:

1. `midX` 要在递归之前保存. 递归返回后数组已经不是 x 序;
2. 即使某一侧已经找到距离 0, 仍要先完成本层 y 序维护, 才能返回给父问题;
3. 比较平方距离时, Strip 的筛选与 y 差的剪枝也要比较平方量, 单位必须一致.

#### 6.3.7 外层接口与运行

```c
// 输出原输入数组中两个点的下标; 不修改 input. 少于两点 / 非法坐标 / 分配失败返回 0.
int ClosestPair(const Point input[], int n, ClosestResult *out)
{
    if (n < 2 || !input || !out || (size_t)n > SIZE_MAX / sizeof(Point)) return 0;
    for (int i = 0; i < n; ++i)
        if (input[i].x < -1000000000LL || input[i].x > 1000000000LL ||
            input[i].y < -1000000000LL || input[i].y > 1000000000LL) return 0;
    Point *p = malloc((size_t)n * sizeof *p), *temp = malloc((size_t)n * sizeof *temp);
    if (!p || !temp) { free(p); free(temp); return 0; }
    for (int i = 0; i < n; ++i) { p[i] = input[i]; p[i].id = i; }
    SortX(p, temp, n);
    *out = ClosestRec(p, temp, n);
    free(p);
    free(temp);
    return 1;
}

#ifndef NOTE_NO_MAIN
int main(void)
{
    Point p[] = {{0,0,0}, {5,5,0}, {2,1,0}, {2,2,0}, {9,9,0}};
    ClosestResult best;
    if (!ClosestPair(p, 5, &best)) return 1;
    printf("indices: %d, %d; squared distance: %lld\n", best.first, best.second, best.squared);
    return 0;
}
#endif
```

函数不修改原数组, 成功时返回两个不同输入下标及其平方距离. 多组点对并列最优时, 返回其中一组. 少于两个点不构成点对, 因而返回失败, 不能约定最近距离为 0.

实际距离为 `sqrt(best.squared)`, 但比较大小和本例输出都无需开平方, 编译时不依赖数学库.

总时间为 $\Theta(N\log N)$, 额外数组空间为 $O(N)$, 递归栈为 $O(\log N)$.

### 6.4 Substitution Method

#### 6.4.1 先猜, 再用归纳法证明

Substitution Method 的关键是“猜一个界, 代入递推式证明”, 不是只把递推式展开几次.

例如:

$$
T(N)=2T(\lfloor N/2\rfloor)+N
$$

猜测 $T(N)=O(N\log N)$, 然后对较小规模假设:

$$
T(m)\le cm\log_2m
$$

对于 $N\ge4$, 有:

$$
\begin{aligned}
T(N)&\le2c\lfloor N/2\rfloor\log_2\lfloor N/2\rfloor+N\\
&\le cN(\log_2N-1)+N\\
&=cN\log_2N-(c-1)N\\
&\le cN\log_2N\qquad(c\ge1).
\end{aligned}
$$

选取足够大的同一个常数 $c$, 使 $N=2,3$ 的基例也成立, 上界证明就闭合了. $N=1$ 可单独作为常数基例处理, 不强求 $T(1)\le c\cdot1\cdot\log1=0$.

> [!NOTE]
>
> 这段代换证明的是上界 $O(N\log N)$. 要写成 $\Theta(N\log N)$, 还需要下界; 本例可以从递归树每层线性开销得到匹配下界.

#### 6.4.2 为什么“最后还是 O(N)”不能算证明

如果错误地猜 $T(N)\le cN$, 代入得到:

$$
T(N)\le2c(N/2)+N=cN+N
$$

虽然对固定的 $c$ 来说右边属于 $O(N)$, 但它**没有得到原本要证明的 $T(N)\le cN$**.

每向上一层就偷偷换成更大的常数, 并不能构成同一个归纳命题的证明.

<details style="--wi-box-color:var(--wi-question);--wi-box-bg:var(--wi-question-bg)"><summary>那是不是每次猜测都必须一步成功?</summary><p>不需要. 代入后闭合不了, 就检查猜测是否错误, 或者是否需要加强归纳假设, 例如补上一个低阶修正项. 不能只在最后重新写一个大 O 来跳过问题.</p></details>

### 6.5 Recursion-Tree Method

#### 6.5.1 每层成本加起来

对于 $T(N)=aT(N/b)+f(N)$, 第 $i$ 层有 $a^i$ 个子问题, 每个规模为 $N/b^i$, 本层总成本为:

$$
a^if(N/b^i)
$$

若 $N=b^h$, 则树高 $h=\log_bN$, 叶节点数为:

$$
a^h=N^{\log_ba}
$$

若叶节点成本为 $\Theta(1)$, 递推式可以写为:

$$
T(N)=\Theta(N^{\log_ba})+\sum_{i=0}^{\log_bN-1}a^if(N/b^i)
$$

第一项不能漏掉: 如果越往下成本越高, 叶节点成本可能正是主导项.

#### 6.5.2 合并是线性还是平方, 差别很大

对于 $T(N)=2T(N/2)+cN$, 每层成本均为 $cN$, 共 $\log_2N$ 层, 所以为 $\Theta(N\log N)$.

如果合并变成 $cN^2$, 则第 $i$ 层的成本为:

$$
2^i c(N/2^i)^2=cN^2/2^i
$$

逐层求和得到几何级数, 总成本为 $\Theta(N^2)$, 而不是 $\Theta(N^2\log N)$.

#### 6.5.3 课件中的 3T(N/4)

对于:

$$
T(N)=3T(N/4)+cN^2
$$

第 $i$ 层成本为 $cN^2(3/16)^i$, 叶节点成本为 $\Theta(N^{\log_43})$. 因此:

$$
T(N)=cN^2\sum_{i=0}^{\log_4N-1}(3/16)^i+\Theta(N^{\log_43})=\Theta(N^2)
$$

根层本来就要 $\Theta(N^2)$, 这也直接给出了匹配下界.

#### 6.5.4 两边不等大怎么办

再看:

$$
T(N)=T(N/3)+T(2N/3)+cN
$$

最长路径一直走 $2N/3$ 的分支, 高度为 $O(\log_{3/2}N)$. 每层尚未终止的子问题规模总和至多为 $N$, 所以每层成本至多 $O(N)$, 得到上界 $O(N\log N)$.

前 $\Theta(\log_3N)$ 层在常数基例附近之前仍是完整展开的, 每层总成本为 $\Theta(N)$, 因而下界也是 $\Omega(N\log N)$. 结论为 $\Theta(N\log N)$.

课件还用代换验证上界. 取以 2 为底的对数, 假设子问题满足 $T(m)\le dm\log_2m$, 则:

$$
\begin{aligned}
T(N)&\le d\frac N3\log_2\frac N3+d\frac{2N}3\log_2\frac{2N}3+cN\\
&=dN\log_2N-dN(\log_23-2/3)+cN\\
&\le dN\log_2N
\end{aligned}
$$

只需 $d\ge c/(\log_23-2/3)$, 并同时满足基例.

> [!CAUTION]
>
> 这棵递归树并不完整, 深层的一些分支已经终止, 所以不能说“直到最长路径结束, 每层都恰好为 $cN$”. 用“至多”求上界才正确.

### 6.6 Master Theorem

#### 6.6.1 先比较谁

对于:

$$
T(N)=aT(N/b)+f(N),\qquad a\ge1,\ b>1
$$

记 $d=\log_ba$. 核心比较对象是 $f(N)$ 与 $N^d$, 即本层非递归工作与叶节点数量的增长速度.

假设基本规模的时间为 $\Theta(1)$, $f(N)$ 最终非负, 并满足下面相应条件:

| 情况 | 条件 | 结论 |
| :--- | :--- | :--- |
| Case 1 | 存在固定 $\varepsilon>0$, $f(N)=O(N^{d-\varepsilon})$ | $T(N)=\Theta(N^d)$ |
| Case 2 | $f(N)=\Theta(N^d)$ | $T(N)=\Theta(N^d\log N)$ |
| Case 3 | 存在固定 $\varepsilon>0$, $f(N)=\Omega(N^{d+\varepsilon})$, 且满足 regularity condition | $T(N)=\Theta(f(N))$ |

Case 3 的 regularity condition 是: 存在固定常数 $0<c<1$, 对充分大的 $N$ 有:

$$
af(N/b)\le cf(N)
$$

也就是向下一层后, 总的非递归工作量按一个固定比例缩小.

#### 6.6.2 用递归树理解三种情况

把 $N^d$ 当作基准:

- Case 1: $f(N)$ 比它小一个多项式因子, 深层和叶节点主导;
- Case 2: 各层成本同阶, 额外乘上层数 $\log N$;
- Case 3: 根层主导, 且 regularity condition 保证下面各层不会反复变大.

例如 Case 2:

$$
a^if(N/b^i)=\Theta\left(a^i(N/b^i)^d\right)=\Theta(N^d)
$$

因为 $b^d=a$, 所以每层都是 $\Theta(N^d)$. 累计 $\Theta(\log N)$ 层, 得到 $\Theta(N^d\log N)$.

Case 1 中, 递归树求和的上界最终为 $O(N^d)$, 而叶节点已经给出 $\Omega(N^d)$. Case 3 中, 各层成本至多按 $c^i f(N)$ 递减, 总和为 $O(f(N))$, 根层又给出 $\Omega(f(N))$.

#### 6.6.3 不是“大一点”就满足 Case 3

考虑:

$$
T(N)=2T(N/2)+N\log N
$$

此时 $a=b=2$, 所以 $N^d=N$.

$N\log N$ 确实大于 $N$, 但它没有大到 $\Omega(N^{1+\varepsilon})$, 对任何固定 $\varepsilon>0$ 都不满足. 它也不是 $\Theta(N)$, 所以不能硬套基本版本的 Case 2 或 Case 3.

递归树第 $i$ 层成本为:

$$
2^i\frac N{2^i}\log_2\frac N{2^i}=N(\log_2N-i)
$$

因此:

$$
T(N)=\Theta\left(N\sum_{j=1}^{\log_2N}j\right)=\Theta(N\log^2N)
$$

> [!IMPORTANT]
>
> Master Theorem 的 Case 1 / 3 要求**多项式级别的差距**, 不是看 $f(N)$ 最后比 $N^d$ 大还是小就足够了.

#### 6.6.4 带 log 因子的扩展形式

课件还给出适用于以下形状的版本:

$$
T(N)=aT(N/b)+\Theta(N^k\log^pN),\qquad k\ge0,\ p\ge0
$$

这里 $a,b,k,p$ 都是固定常数. 比较 $a$ 与 $b^k$:

$$
T(N)=
\begin{cases}
\Theta(N^{\log_ba}), & a>b^k;\\
\Theta(N^k\log^{p+1}N), & a=b^k;\\
\Theta(N^k\log^pN), & a<b^k.
\end{cases}
$$

注意: 递推式给的是紧确的 $\Theta$ 非递归成本, 才能按这里的条件写出对应紧确界. 如果只知道 $f(N)=O(N^k\log^pN)$, 不能直接据此断定同样的下界.

例如 $a=b=2,k=p=1$, 正好属于中间一类, 得到 $\Theta(N\log^2N)$.

#### 6.6.5 课件的另一种比例形式

如果 $af(N/b)=Kf(N)$, 且 $K$ 是**不随 $N$ 变化的固定常数**, 就能用几何级数理解:

| 比例 | 层成本变化 | 结果 |
| :--- | :--- | :--- |
| $0<K<1$ | 逐层递减 | $\Theta(f(N))$ |
| $K=1$ | 每层相同 | $\Theta(f(N)\log_bN)$ |
| $K>1$ | 逐层递增 | $\Theta(N^{\log_ba})$ |

这里仍采用常数规模终止、叶节点成本为 $\Theta(1)$ 的前提. 若比例只是接近某个数, 不能把它直接当成精确固定比例.

例如 $a=4,b=2,f(N)=N\log N$:

$$
\frac{af(N/b)}{f(N)}=2-\frac2{\log_2N}
$$

它随 $N$ 变化, 不直接满足“固定 $K$”的等式版本. 但因为 $N\log N=O(N^{3/2})$, 而 $N^{\log_24}=N^2$, 可以使用基本 Case 1, 得到 $\Theta(N^2)$.

### 6.7 递推式与算法总表

| 递推式 / 算法 | 结果 | 关键理由 |
| :--- | :--- | :--- |
| $T(N)=2T(N/2)+\Theta(N)$ | $\Theta(N\log N)$ | 每层线性, 层数对数 |
| $T(N)=2T(N/2)+\Theta(N^2)$ | $\Theta(N^2)$ | 根层主导 |
| $T(N)=3T(N/4)+\Theta(N^2)$ | $\Theta(N^2)$ | 层成本按 $3/16$ 缩小 |
| $T(N)=3T(N/2)+\Theta(N)$ | $\Theta(N^{\log_23})$ | Case 1, 指数约为 1.585 |
| $T(N)=3T(N/2)+\Theta(N^2)$ | $\Theta(N^2)$ | Case 3, 比例 $3/4<1$ |
| $T(N)=2T(N/2)+\Theta(N\log N)$ | $\Theta(N\log^2N)$ | 扩展形式, 额外多一层 log |
| $T(N)=4T(N/2)+\Theta(N\log N)$ | $\Theta(N^2)$ | Case 1 |
| $T(N)=T(N/3)+T(2N/3)+\Theta(N)$ | $\Theta(N\log N)$ | 递归树 / 代换, 不能直接套等规模子问题版本 |
| 最近点对, 维护 y 序 | $\Theta(N\log N)$ | 线性归并 + 每点常数次比较 |
| Quick Sort | 最坏 $\Theta(N^2)$ | 划分未必均衡 |
| 任意二叉树遍历 | $\Theta(N)$ | 每个节点恰好处理一次 |

最后分析分治时, 依次问自己三个问题就很清楚:

1. 到底有几个子问题, 各自多大?
2. 这一层除递归以外, 真正做了多少工作?
3. 写出的递推式满足所用定理的条件吗?

<details style="--wi-box-color:var(--wi-question);--wi-box-bg:var(--wi-question-bg)"><summary>为什么最近点对这一题特别适合放在分治里?</summary><p>因为“分成两半”很容易, 难的是把跨界答案在线性时间内合并. 如果没有证明 Strip 中每点只需常数次比较, 或者忽略了每层排序的成本, 最后的复杂度就会算错.</p></details>


## Chapter 7: Dynamic Programming

> 对应课件: [ADS08DynamicProgramming_Stu.ppt](<../lesson/Materials/Student Slides/ADS08DynamicProgramming_Stu.ppt>). 第 2～3 页为 Fibonacci, 第 4～6 页为矩阵链乘, 第 7～9 页为最优 BST, 第 10～11 页为全源最短路, 第 12～17 页为 DP 设计与装配线调度, 第 18 页为 Beautiful Subsequence 项目引入.

### 7.1 为什么需要 Dynamic Programming

#### 7.1.1 递归本身没有问题, 重复计算才是问题

上一章分治把原问题拆成较小的子问题, 递归解决后再组合答案. 那么, 如果不同分支里面反复出现**同一个子问题**, 会怎么样?

例如, 计算 Fibonacci Numbers:

$$
F(N)=F(N-1)+F(N-2)
$$

计算 $F(6)$ 时要计算 $F(5)$ 和 $F(4)$; 计算 $F(5)$ 时又要计算 $F(4)$ 和 $F(3)$.

```text
                  F(6)
                /      \
             F(5)      F(4)
            /    \     /   \
          F(4)  F(3) F(3)  F(2)
          ...   ...   ...   ...
```

相同参数的函数在不同分支里被重新算了一遍又一遍, 但答案明明是一样的.

> **目标**
>
> 每个不同的子问题只求解一次, 把答案保存下来. 后面需要它时, 直接读取, 不再把整个计算过程重做一遍.

这就是 Dynamic Programming, 简称 DP, 即动态规划的核心思想.

<details style="--wi-box-color:var(--wi-question);--wi-box-bg:var(--wi-question-bg)"><summary>所以动态规划就是把递归改成 for 循环?</summary><p>不完全是. 循环只是实现方式之一. 递归加上记忆化也可以实现 DP. 真正要说明的是: 状态表示什么、为什么这些信息足够、依赖哪些更小状态, 以及如何复用已经算出的答案.</p></details>

#### 7.1.2 两种实现方式

| 方式 | 思路 | 需要注意 |
| :--- | :--- | :--- |
| Top-down / Memoization | 按需求递归, 算过的状态直接查缓存 | 区分“未计算”和“答案恰好为 0”; 还要考虑递归栈 |
| Bottom-up / Tabulation | 先算依赖项, 再按顺序填表 | 填表顺序必须符合状态依赖关系 |

课件中的 “Use a table instead of recursion” 强调避免朴素递归的重复计算, 不能由此认为“只要有递归就不算 DP”.

#### 7.1.3 两个常见条件

1. **Optimal Substructure, 最优子结构**: 原问题的最优解可以由适当子问题的最优解组成;
2. **Overlapping Subproblems, 重叠子问题**: 不同求解过程会遇到同一个状态, 保存答案后能够避免重复工作.

对于计数问题, 不一定讨论“最优”, 但仍然要能把答案分解成子状态的计数, 并确保没有漏计或重复计数.

> [!IMPORTANT]
>
> 状态必须包含决定后续选择与代价所需要的信息. 两条路径到达同一个状态后, 如果未来可选动作仍然不同, 那就说明状态还没定义完整.

例如, 装配线每次换线收费固定, 只需知道当前阶段和所在生产线; 如果题目改为“最多换线两次”, 还必须记录已经换线几次.

### 7.2 Fibonacci Numbers

> 完整可运行源码: [fibonacci_dp.c](./code/fibonacci_dp.c).

#### 7.2.1 先统一初值

本章沿用课件:

$$
F(0)=F(1)=1,\qquad F(N)=F(N-1)+F(N-2)\quad(N\ge2)
$$

得到 $1,1,2,3,5,8,\ldots$. 它与常见的 $F(0)=0,F(1)=1$ 版本相差一个下标, 写程序和对答案时不能混用.

朴素递归的调用次数满足:

$$
T(N)=T(N-1)+T(N-2)+\Theta(1)=\Theta(\varphi^N),\qquad
\varphi=\frac{1+\sqrt5}{2}
$$

虽然递归树很大, 但不同的状态其实只有 $F(0),F(1),\ldots,F(N)$, 一共 $N+1$ 个.

#### 7.2.2 从记忆化到滚动变量

先用 `memo[n]` 保存答案, `seen[n]` 记录是否已经计算. 再把顺序改成从小到大填表, 就得到自底向上的版本.

最后观察: 计算 $F(i)$ 时只需要前两项, 更早的值不会再用到, 所以可以进一步压缩为两个滚动变量.

头文件为 `<stdint.h>`、`<stdio.h>`:

```c
// 沿用本章课件: F(0)=F(1)=1. uint64_t 可精确表示到 F(92).
#define FIB_LIMIT 92
static uint64_t MemoValue(int n, uint64_t memo[], int seen[])
{
    if (seen[n]) return memo[n];
    memo[n] = n <= 1 ? 1 : MemoValue(n - 1, memo, seen) + MemoValue(n - 2, memo, seen);
    seen[n] = 1;
    return memo[n];
}

int FibonacciMemo(int n, uint64_t *out)
{
    if (n < 0 || n > FIB_LIMIT || !out) return 0;
    uint64_t memo[FIB_LIMIT + 1] = {0};
    int seen[FIB_LIMIT + 1] = {0};
    *out = MemoValue(n, memo, seen);
    return 1;
}

int FibonacciTable(int n, uint64_t *out)
{
    if (n < 0 || n > FIB_LIMIT || !out) return 0;
    uint64_t f[FIB_LIMIT + 1];
    f[0] = f[1] = 1;
    for (int i = 2; i <= n; ++i) f[i] = f[i - 1] + f[i - 2];
    *out = f[n];
    return 1;
}

int FibonacciRolling(int n, uint64_t *out)
{
    if (n < 0 || n > FIB_LIMIT || !out) return 0;
    uint64_t previous = 1, current = 1;
    for (int i = 2; i <= n; ++i) {
        uint64_t next = previous + current;
        previous = current;
        current = next;
    }
    *out = current;
    return 1;
}
```

> [!CAUTION]
>
> 更新滚动变量时, 先保存 `next = previous + current`, 再移动两个旧值. 如果先覆盖 `previous` 或 `current`, 就可能把本应不同的两项加错.
>
> 本实现采用 `uint64_t`, 按本章初值最多支持 $N=92$. $F(92)=12200160415121876738$, 再往后一项就超出 64 位无符号整数范围, 所以接口对越界输入返回失败.

```c
#ifndef NOTE_NO_MAIN
int main(void)
{
    uint64_t a, b, c;
    if (!FibonacciMemo(10, &a) || !FibonacciTable(10, &b) || !FibonacciRolling(10, &c)) return 1;
    printf("F(10): memo=%llu, table=%llu, rolling=%llu\n",
           (unsigned long long)a, (unsigned long long)b, (unsigned long long)c);
    return 0;
}
#endif
```

三个版本都输出 $F(10)=89$.

#### 7.2.3 复杂度怎么变化

| 方法 | 时间 | 额外空间 |
| :--- | :--- | :--- |
| 朴素递归 | $\Theta(\varphi^N)$ | $O(N)$ 递归栈 |
| 记忆化递归 | $\Theta(N)$ | $O(N)$ 缓存与递归栈 |
| 自底向上填表 | $\Theta(N)$ | $O(N)$ |
| 滚动变量 | $\Theta(N)$ | $O(1)$ |

这里按一次整数加法为 $O(1)$ 的模型分析. 若用任意精度整数计算非常大的下标, 还需要考虑数值位数增长, 不能把大整数加法永远当作常数时间.

### 7.3 Ordering Matrix Multiplications

> 完整可运行源码: [matrix_chain.c](./code/matrix_chain.c).

#### 7.3.1 为什么乘法顺序会影响成本

矩阵乘法满足结合律, 但一般不满足交换律. 因此这里允许改变括号位置, **不改变矩阵原来的先后顺序**.

一个 $a\times b$ 矩阵乘一个 $b\times c$ 矩阵, 按普通乘法算法需要 $abc$ 次标量乘法.

课件给出:

$$
M_1:10\times20,\quad M_2:20\times50,\quad
M_3:50\times1,\quad M_4:1\times100
$$

如果按 $M_1(M_2(M_3M_4))$ 计算, 费用为:

$$
50\cdot1\cdot100+20\cdot50\cdot100+10\cdot20\cdot100=125000
$$

如果按 $(M_1(M_2M_3))M_4$ 计算, 费用为:

$$
20\cdot50\cdot1+10\cdot20\cdot1+10\cdot1\cdot100=2200
$$

最终得到的矩阵相同, 工作量却相差很大.

#### 7.3.2 直接枚举括号为什么慢

设 $b_N$ 为 $N$ 个矩阵的完全加括号方式数, 最后一次乘法一定把矩阵链切成左右两段:

$$
b_1=1,\qquad b_N=\sum_{k=1}^{N-1}b_kb_{N-k}
$$

所以 $b_N=C_{N-1}$, 即第 $N-1$ 个 Catalan Number, 随 $N$ 指数增长; $b_2=1,b_3=2,b_4=5$.

但不同的连续区间 $[i,j]$ 只有 $N(N+1)/2$ 个. 同一段矩阵链的最优计算方式, 不需要随着外层括号位置变化而重新计算.

#### 7.3.3 状态和最后一步

设 $M_i$ 的维度为 $r_{i-1}\times r_i$, 定义:

$$
m[i][j]=\text{计算 }M_iM_{i+1}\cdots M_j\text{ 所需的最少标量乘法次数}
$$

若最后一次乘法在 $k$ 后切开, 则:

```text
           M_i ... M_j
             /     \
        M_i ... M_k   M_{k+1} ... M_j
        r_{i-1}×r_k     r_k×r_j
```

两边计算完后再相乘, 新增费用为 $r_{i-1}r_kr_j$. 因此:

$$
m[i][j]=
\begin{cases}
0,&i=j;\\
\displaystyle\min_{i\le k<j}\{m[i][k]+m[k+1][j]+r_{i-1}r_kr_j\},&i<j.
\end{cases}
$$

为什么两边可以各自取最优? 因为无论内部怎样加括号, 两段乘积的维度都固定. 如果某段不是最优, 把它换成更便宜的方案, 外层乘法费用不会变化, 整体就能更优, 与原先的最优性矛盾.

#### 7.3.4 为什么按区间长度填表

$m[i][j]$ 只依赖严格更短的区间. 所以先填长度 1, 再填长度 2、3, 一直到 $N$.

每个状态记录费用之外, 再记录最优切分位置 `split[i][j]`, 就能从答案区间递归还原整套括号.

> [!NOTE]
>
> 这里的状态是“区间”. 它不记录这一段最后算出了哪些具体矩阵元素, 因为费用只取决于维度与括号结构.

#### 7.3.5 完整实现与括号还原

代码采用从 0 开始的下标, `dims[i] * dims[i+1]` 对应第 $i$ 个矩阵的维度. 因而最后一次乘法费用写成 `dims[i] * dims[k+1] * dims[j+1]`.

头文件为 `<limits.h>`、`<stdio.h>`:

```c
#define MATRIX_LIMIT 64
typedef struct {
    int n;
    long long cost[MATRIX_LIMIT][MATRIX_LIMIT];
    int split[MATRIX_LIMIT][MATRIX_LIMIT];
} MatrixPlan;

// M_i 的维度是 dims[i] * dims[i+1], 代码从 0 开始编号.
// 最多 64 个矩阵, 各维度 1..100000, 保证费用不溢出 long long.
int MatrixChain(const int dims[], int n, MatrixPlan *plan)
{
    if (!plan || n < 0 || n > MATRIX_LIMIT || (n > 0 && !dims)) return 0;
    if (n > 0) for (int i = 0; i <= n; ++i)
        if (dims[i] <= 0 || dims[i] > 100000) return 0;
    plan->n = n;
    for (int i = 0; i < n; ++i) {
        plan->cost[i][i] = 0;
        plan->split[i][i] = -1;
    }
    for (int length = 2; length <= n; ++length) {
        for (int i = 0; i + length <= n; ++i) {
            int j = i + length - 1;
            plan->cost[i][j] = LLONG_MAX;
            for (int k = i; k < j; ++k) {
                long long value = plan->cost[i][k] + plan->cost[k + 1][j]
                                + 1LL * dims[i] * dims[k + 1] * dims[j + 1];
                if (value < plan->cost[i][j]) {
                    plan->cost[i][j] = value;
                    plan->split[i][j] = k;
                }
            }
        }
    }
    return 1;
}

long long MatrixCost(const MatrixPlan *plan)
{
    return plan->n ? plan->cost[0][plan->n - 1] : 0;
}

// 只对成功生成的 plan 和其中的有效区间调用; i>j 表示空区间.
void PrintMatrixOrder(const MatrixPlan *plan, int i, int j)
{
    if (i > j) return;
    if (i == j) { printf("M%d", i + 1); return; }
    int k = plan->split[i][j];
    putchar('(');
    PrintMatrixOrder(plan, i, k);
    printf(" * ");
    PrintMatrixOrder(plan, k + 1, j);
    putchar(')');
}
```

费用相同时保留先遇到的切分位置; 这只是从多个最优方案中选一个, 不影响最优值.

```c
#ifndef NOTE_NO_MAIN
int main(void)
{
    int dims[] = {10, 20, 50, 1, 100};
    MatrixPlan plan;
    if (!MatrixChain(dims, 4, &plan)) return 1;
    printf("minimum scalar multiplications = %lld\n", MatrixCost(&plan));
    PrintMatrixOrder(&plan, 0, plan.n - 1);
    putchar('\n');
    return 0;
}
#endif
```

输出费用 2200, 括号为 `((M1 * (M2 * M3)) * M4)`.

共有 $O(N^2)$ 个区间, 每个区间尝试 $O(N)$ 个切分点, 所以时间为 $O(N^3)$; 费用表与切分表占 $O(N^2)$ 空间, 输出括号另外需要 $O(N)$ 时间.

> [!CAUTION]
>
> `1LL * dims[i] * ...` 中要先提升为宽整数再连乘. 先用 `int` 乘完、最后再赋给 `long long`, 不能防止中间溢出.
>
> 本实现最多 64 个矩阵, 各维度为 1～100000. 空矩阵链费用约定为 0, 一个矩阵无需乘法, 费用也是 0.

### 7.4 Optimal Binary Search Tree

> 完整可运行源码: [optimal_bst.c](./code/optimal_bst.c).

#### 7.4.1 高度最小, 不一定平均查询最快

AVL Trees 强调控制树高, 从而保证最坏查询时间. 但如果某些词特别常被查询, 把它们放得更靠近根, 可能比单纯追求平衡更划算.

给定有序关键词:

$$
w_1<w_2<\cdots<w_N
$$

成功查询 $w_i$ 的概率为 $p_i$, 根的深度为 0. 查询到深度为 $d_i$ 的关键词, 需要进行 $d_i+1$ 次节点比较, 所以目标为:

$$
\min\sum_{i=1}^{N}p_i(d_i+1)
$$

> [!IMPORTANT]
>
> 这里沿用课件的**仅含成功查询**模型, 适合关键词集合与访问权重已知、相对稳定的场景.
>
> 如果还给出了查找失败时落入各间隙的概率, 状态与边界都要相应加入这些权重, 不能直接把两种 OBST 模型混用.

#### 7.4.2 选根之后, 左右区间就确定了

BST 的有序性保证: 如果选 $w_k$ 为根, 则左子树只能包含 $w_i,\ldots,w_{k-1}$, 右子树只能包含 $w_{k+1},\ldots,w_j$.

定义:

$$
c[i][j]=\text{关键词区间 }[i,j]\text{ 的最小加权比较次数}
$$

子树单独作为一棵树时, 它的根按深度 0 计费. 将它挂到新根下之后, 其中每个关键词的深度都增加 1, 于是要增加整棵子树的权重和.

记:

$$
W(i,j)=\sum_{t=i}^{j}p_t
$$

选 $k$ 为根时的总费用就是:

$$
c[i][k-1]+c[k+1][j]+W(i,j)
$$

最后一项已经包括根自身的一次比较, 以及左右子树所有节点增加的一次比较, 因而不应再额外加一次 $p_k$.

#### 7.4.3 边界与转移

$$
c[i][j]=
\begin{cases}
0,&i>j;\\
\displaystyle W(i,j)+\min_{i\le k\le j}\{c[i][k-1]+c[k+1][j]\},&i\le j.
\end{cases}
$$

特别地, $c[i][i]=p_i$.

> [!CAUTION]
>
> 课件第 8 页在包含两端点的 $[i,j]$ 定义下标了 $c_{ii}=0$, 并把候选根范围写成 $i<l\le j$. 这与本页费用推导、以及第 9 页单个词的费用表不一致.
>
> 按本章统一定义, 应为 **空区间费用 0、单个词费用 $p_i$、候选根包含左右端点**. 不要把矩阵链“单个矩阵不需要乘法”的边界直接搬到 OBST 中.

#### 7.4.4 代码与树形还原

仍按区间长度递增填表. 用前缀和在 $O(1)$ 时间内求 $W(i,j)$, 用 `root[i][j]` 记录最优根.

代码用非负整数权重, 既可以代表查询次数, 也可以把百分比统一放大 100 倍, 避免小数误差. 权重统一缩放不会改变最优树.

头文件为 `<limits.h>`、`<stdio.h>`:

```c
#define OBST_LIMIT 64
typedef struct {
    int n;
    long long cost[OBST_LIMIT][OBST_LIMIT];
    int root[OBST_LIMIT][OBST_LIMIT];
} BSTPlan;

static long long IntervalCost(const BSTPlan *plan, int i, int j)
{
    return i > j ? 0 : plan->cost[i][j];
}

// 关键词已经严格递增, weight[i] 是第 i 个关键词的成功查询权重.
// 0<=weight[i]<=10^9; 可以是频数, 不必归一化. 不包含失败查询权重.
int OptimalBST(const long long weight[], int n, BSTPlan *plan)
{
    if (!plan || n < 0 || n > OBST_LIMIT || (n > 0 && !weight)) return 0;
    long long prefix[OBST_LIMIT + 1] = {0};
    for (int i = 0; i < n; ++i) {
        if (weight[i] < 0 || weight[i] > 1000000000LL) return 0;
        prefix[i + 1] = prefix[i] + weight[i];
    }
    plan->n = n;
    for (int length = 1; length <= n; ++length) {
        for (int i = 0; i + length <= n; ++i) {
            int j = i + length - 1;
            long long sum = prefix[j + 1] - prefix[i];
            plan->cost[i][j] = LLONG_MAX;
            for (int k = i; k <= j; ++k) {
                long long value = IntervalCost(plan, i, k - 1)
                                + IntervalCost(plan, k + 1, j) + sum;
                if (value < plan->cost[i][j]) {
                    plan->cost[i][j] = value;
                    plan->root[i][j] = k;
                }
            }
        }
    }
    return 1;
}

long long OptimalBSTCost(const BSTPlan *plan)
{
    return IntervalCost(plan, 0, plan->n - 1);
}

// names 与权重使用同一词序; 输出为 root(left,right), 空子树为 #.
void PrintOptimalBST(const BSTPlan *plan, const char *const names[], int i, int j)
{
    if (i > j) { putchar('#'); return; }
    int k = plan->root[i][j];
    printf("%s(", names[k]);
    PrintOptimalBST(plan, names, i, k - 1);
    putchar(',');
    PrintOptimalBST(plan, names, k + 1, j);
    putchar(')');
}
```

```c
#ifndef NOTE_NO_MAIN
int main(void)
{
    const char *words[] = {"break", "case", "char", "do", "return", "switch", "void"};
    long long weight[] = {22, 18, 20, 5, 25, 2, 8};
    BSTPlan plan;
    if (!OptimalBST(weight, 7, &plan)) return 1;
    printf("weighted cost = %lld, expected comparisons = %.2f\n",
           OptimalBSTCost(&plan), OptimalBSTCost(&plan) / 100.0);
    PrintOptimalBST(&plan, words, 0, 6);
    putchar('\n');
    return 0;
}
#endif
```

课件中的概率为:

| 关键词 | break | case | char | do | return | switch | void |
| :--- | :--- | :--- | :--- | :--- | :--- | :--- | :--- |
| 概率 | 0.22 | 0.18 | 0.20 | 0.05 | 0.25 | 0.02 | 0.08 |

得到的一棵最优树为:

```text
              char
             /    \
          break   return
             \    /   \
            case do   void
                       /
                    switch
```

加权费用为 215, 除以总权重 100, 平均比较次数为 **2.15**.

例如根 `char` 的贡献是 $0.20\times1$, `switch` 在深度 3, 贡献为 $0.02\times4$.

> [!NOTE]
>
> 概率最大的 `return` 没有成为根. 选根会同时改变左右整个区间的深度, 所以“每次把频率最高的词放根上”并不能保证整体最优.

#### 7.4.5 复杂度与适用范围

这份实现有 $O(N^2)$ 个区间, 每个枚举 $O(N)$ 个根, 所以时间为 $O(N^3)$、空间为 $O(N^2)$; 还原树形为 $O(N)$ 时间.

课件还提到可进一步优化到 $O(N^2)$, 但这依赖额外的最优根结构性质, 不能仅靠少写一层循环就得到. 本节代码对应课件完整展开的三重循环版本.

本实现最多 64 个关键词, 每个权重在 $[0,10^9]$. 若权重全为 0, 所有树费用都是 0, 可以返回任意一棵最优树; 此时不能除以总权重去解释平均查询次数.

### 7.5 All-Pairs Shortest Path

> 完整可运行源码: [floyd_warshall.c](./code/floyd_warshall.c).

#### 7.5.1 从单源到全源

Single-Source Shortest Path 解决一个起点到其他顶点的最短路; All-Pairs Shortest Path 要求任意两个顶点之间的最短路.

一个办法是对每个顶点分别跑一次单源算法. 但复杂度取决于选用的单源算法与图的表示, 不能只说“重复 $|V|$ 次, 所以总是 $O(|V|^3)$”.

例如, 非负权图上, 朴素矩阵版 Dijkstra 每次 $O(|V|^2)$, 重复后为 $O(|V|^3)$; 若使用邻接表和二叉堆, 总上界可写为 $O(|V|(|V|+|E|)\log|V|)$, 稀疏图可能受益.

本节用动态规划得到 Floyd-Warshall, 它可以处理负边, 但有限最短路要求相应路径不受负环影响.

#### 7.5.2 状态中的 k 到底限制什么

顶点编号为 $0,1,\ldots,N-1$, 定义:

$$
D^{(k)}[i][j]=\text{从 }i\text{ 到 }j\text{、中间顶点只允许来自 }\{0,\ldots,k\}\text{ 的最短距离}
$$

这里限制的是**允许作为中间点的集合**, 不是路径最多经过 $k$ 条边, 也不是起点或终点必须不大于 $k$.

没有任何中间点可用时, 只允许直接边, 再加上顶点到自身的空路径:

$$
D^{(-1)}[i][j]=
\begin{cases}
0,&i=j\text{ 且没有更小的自环};\\
\text{最小直接边权},&\text{存在对应边};\\
+\infty,&\text{否则}.
\end{cases}
$$

平行边应取最小边权; 负权自环本身就是负环, 不能被初始化为 0 后忽略.

#### 7.5.3 新允许一个中间点

加入顶点 $k$ 后, 最优路径有两种情况:

1. 不使用 $k$ 作为中间点, 原来的距离已经足够;
2. 使用 $k$, 则可拆成 $i\to k$ 与 $k\to j$ 两段.

在不存在负环时, 可以选取一条不重复经过顶点的最短路径, 因而拆开的两段不需要再把 $k$ 作为内部中间点.

于是:

$$
D^{(k)}[i][j]=\min\left\{D^{(k-1)}[i][j],
D^{(k-1)}[i][k]+D^{(k-1)}[k][j]\right\}
$$

最终答案为 $D^{(N-1)}$.

#### 7.5.4 为什么可以只用二维数组

朴素状态看起来有三维, 但计算第 $k$ 层时可以在同一个 `dist` 数组中更新.

在无负环的情况下, $D[k][k]=0$. 本轮用 $k$ 中转不会改善 $D[i][k]$ 或 $D[k][j]$, 所以这两条参与转移的行、列保持所需值, 原地更新是安全的.

> [!IMPORTANT]
>
> **`k` 必须位于这份标准原地算法的最外层循环.** 完成一轮 `k` 后, 才能说所有状态都允许使用了 $0,\ldots,k$ 作为中间点.
>
> 如果随意换成 `i,j,k` 且只扫一遍, 就不再满足上面的状态不变量, 可能漏掉路径.

#### 7.5.5 不可达、负环与路径还原

实现时有三件事不能省:

1. 一段不可达时, 不能直接做 `INF + weight`;
2. 如果发现某个 `dist[v][v] < 0`, 就说明存在负环;
3. 要输出路径, 除距离外还要记录下一步走向哪个顶点.

如果 $i$ 能走到某个负环, 再从该负环走到 $j$, 则 $i\to j$ 的费用可以通过反复绕环无限降低, 没有有限最短距离. 与负环无关的点对仍可能有有限答案.

下面采用一个简单明确的接口: **发现图中任何负环就返回 -1, 不提供本次结果的路径查询**. 它不进一步逐对区分哪些点对受负环影响.

头文件为 `<limits.h>`、`<stdio.h>`, 先定义图和结果表:

```c
#define FLOYD_LIMIT 64
#define FLOYD_INF (LLONG_MAX / 4)
typedef struct { int n; long long edge[FLOYD_LIMIT][FLOYD_LIMIT]; } Graph;
typedef struct {
    int n, ready;
    long long dist[FLOYD_LIMIT][FLOYD_LIMIT];
    int next[FLOYD_LIMIT][FLOYD_LIMIT];
} FloydResult;

int InitGraph(Graph *g, int n)
{
    if (!g || n < 0 || n > FLOYD_LIMIT) return 0;
    g->n = n;
    for (int i = 0; i < n; ++i)
        for (int j = 0; j < n; ++j) g->edge[i][j] = i == j ? 0 : FLOYD_INF;
    return 1;
}

// 有向边; 平行边保留较小权重. 无向边要双向添加.
int AddEdge(Graph *g, int from, int to, long long weight)
{
    if (!g || g->n < 0 || g->n > FLOYD_LIMIT || from < 0 || from >= g->n ||
        to < 0 || to >= g->n || weight < -1000000000LL || weight > 1000000000LL) return 0;
    if (weight < g->edge[from][to]) g->edge[from][to] = weight;
    return 1;
}
```

`next[i][j]` 表示从 $i$ 去 $j$ 的最短路径上, 下一步应到达的顶点. 如果经 $k$ 中转更优, 则下一步应与 $i\to k$ 的下一步相同.

```c
// 返回 1: 成功; 0: 非法输入; -1: 图中存在负环, 本接口不发布最短路结果.
int FloydWarshall(const Graph *g, FloydResult *out)
{
    if (!out) return 0;
    out->ready = 0;
    if (!g || g->n < 0 || g->n > FLOYD_LIMIT) return 0;
    int n = out->n = g->n;
    for (int i = 0; i < n; ++i) {
        for (int j = 0; j < n; ++j) {
            long long w = g->edge[i][j];
            if (w != FLOYD_INF && (w < -1000000000LL || w > 1000000000LL)) return 0;
            if (i == j && w > 0) w = 0; // 包括没有显式自环的情况
            out->dist[i][j] = w;
            out->next[i][j] = w == FLOYD_INF ? -1 : j;
        }
        if (out->dist[i][i] < 0) return -1;
    }
    for (int k = 0; k < n; ++k) {
        for (int i = 0; i < n; ++i) {
            if (out->dist[i][k] == FLOYD_INF) continue;
            for (int j = 0; j < n; ++j) {
                if (out->dist[k][j] == FLOYD_INF) continue;
                long long value = out->dist[i][k] + out->dist[k][j];
                // 负环情况下的保护下界; 合法无负环最短路不会接近这个值.
                if (value < -FLOYD_INF) value = -FLOYD_INF;
                if (value < out->dist[i][j]) {
                    out->dist[i][j] = value;
                    out->next[i][j] = out->next[i][k];
                    if (i == j && value < 0) return -1;
                }
            }
        }
    }
    out->ready = 1;
    return 1;
}

// 返回顶点数; 0 表示不可达; -1 表示结果无效 / 参数错误 / 容量不足.
// 失败或不可达时不改 path. 成功结果包括起点和终点.
int FloydPath(const FloydResult *r, int from, int to, int path[], int capacity)
{
    if (!r || !r->ready || !path || from < 0 || from >= r->n ||
        to < 0 || to >= r->n || capacity < 0) return -1;
    if (r->next[from][to] < 0) return 0;
    int temp[FLOYD_LIMIT], length = 1;
    temp[0] = from;
    while (from != to) {
        if (length >= r->n) return -1;
        from = r->next[from][to];
        if (from < 0 || from >= r->n) return -1;
        temp[length++] = from;
    }
    if (length > capacity) return -1;
    for (int i = 0; i < length; ++i) path[i] = temp[i];
    return length;
}
```

路径查询中 $i=j$ 返回仅含该顶点的一条空路径表示, 顶点数为 1; 不可达返回 0. 参数错误、负环导致结果不可用、输出空间不足均返回 -1.

#### 7.5.6 示例与复杂度

```c
#ifndef NOTE_NO_MAIN
int main(void)
{
    Graph g;
    FloydResult r;
    InitGraph(&g, 4);
    AddEdge(&g, 0, 1, 3); AddEdge(&g, 0, 2, 8);
    AddEdge(&g, 1, 2, -2); AddEdge(&g, 2, 3, 4);
    AddEdge(&g, 1, 3, 9);
    if (FloydWarshall(&g, &r) != 1) return 1;
    int path[FLOYD_LIMIT], length = FloydPath(&r, 0, 3, path, FLOYD_LIMIT);
    printf("distance 0 -> 3 = %lld; path: ", r.dist[0][3]);
    for (int i = 0; i < length; ++i) printf("%d%s", path[i], i + 1 == length ? "\n" : " -> ");
    printf("3 -> 0 path length = %d (0 means unreachable)\n", FloydPath(&r, 3, 0, path, FLOYD_LIMIT));
    return 0;
}
#endif
```

该例有负边 $1\to2=-2$, 但没有负环. 从 0 到 3 的最短距离为 5, 路径为:

$$
0\to1\to2\to3,\qquad 3+(-2)+4=5
$$

而 3 到 0 不可达, 不能把它解释成距离为 0.

Floyd-Warshall 的最坏时间为 $O(N^3)$, 额外空间为 $O(N^2)$; 一次路径还原至多输出 $O(N)$ 个顶点. 本实现支持至多 64 个顶点, 直接边权在 $[-10^9,10^9]$, 未连接位置用单独的 `FLOYD_INF` 表示.

### 7.6 Product Assembly

> 完整可运行源码: [assembly_line.c](./code/assembly_line.c).

#### 7.6.1 两条生产线, 每个阶段怎样选择

两条生产线都能完成同一种产品, 不同阶段的费用不同, 阶段之间还可以换线. 目标是让总费用最小.

如果逐一枚举每个阶段走哪条线, 候选方案会随阶段数指数增长. 但到了同一阶段、同一条线之后, 未来的选择不再关心之前是怎样走过来的.

因此到达这个状态的所有历史中, 只需保留费用最小的那条.

> **最优子结构**
>
> 如果一条最优路线到达某个状态的前缀不是最便宜的, 就可以换成更便宜、到达相同状态的前缀, 再接上原来的后缀, 得到更好的完整路线. 这与最优性矛盾.

#### 7.6.2 先说清楚课件图中的费用

课件把生产过程画成一个分层图, 第 $j$ 层到第 $j+1$ 层有两类边:

- `process[line][j]`: 留在同一条线, 跨到下一层的边权;
- `transit[line][j]`: **从 `line` 出发**, 换到另一条线并跨到下一层的整条边权.

```text
     第 j 层                   第 j+1 层
      line 0 ------ process[0][j] ------> line 0
          \                            /
           \ transit[0][j]            /
            \                       /
             ---------------------> line 1
      line 1 ------ process[1][j] ------> line 1

另外还存在 line 1 -> line 0 的边, 权重为 transit[1][j].
```

> [!CAUTION]
>
> 按这个分层图约定, `transit` 已经是一次跨层动作的全部费用, 所以课件转移式不再单独加 `process`.
>
> 如果题目另外给的是“纯换线时间 $t$”和“目标工位加工时间 $a$”, 那么换线分支必须计入两者. 不能把纯换线时间直接代入这份代码的 `transit`.

例如常见工位模型, 到达线 $\ell$ 的工位 $j$ 的费用为:

$$
g[\ell][j]=a[\ell][j]+\min\{g[\ell][j-1],
g[1-\ell][j-1]+t[1-\ell][j-1]\}
$$

与分层图对应时, 留线边权为 $a[\ell][j]$, 从另一条线换入的边权为 $t[1-\ell][j-1]+a[\ell][j]$. 如果还有入口或出口费用, 也必须分别计入初值或最终选择.

#### 7.6.3 状态与递推式

本节严格采用课件的分层图版本: 一共有 $N$ 次跨层转移, 层编号为 $0,\ldots,N$, 初始可免费选择任一条线, 最后没有额外出口费用.

定义:

$$
f[\ell][s]=\text{到达第 }s\text{ 层、生产线 }\ell\text{ 的最小费用}
$$

初值为 $f[0][0]=f[1][0]=0$. 对 $s\ge1$:

$$
f[\ell][s]=\min\left\{
f[\ell][s-1]+\operatorname{process}[\ell][s-1],
f[1-\ell][s-1]+\operatorname{transit}[1-\ell][s-1]
\right\}
$$

答案为 $\min\{f[0][N],f[1][N]\}$.

两个状态都只依赖前一层, 所以阶段递增填表即可. 若用两个滚动变量, 必须用两个临时变量同时算好本层结果, 再覆盖上一层的值.

#### 7.6.4 怎样还原生产方案

记录 `previous[line][stage]`, 表示当前最优路线是从上一层哪条线过来的.

最后选总费用较小的终点线, 从第 $N$ 层一路反向追溯到第 0 层, 就得到完整方案.

头文件为 `<stdio.h>`:

```c
#define STAGE_LIMIT 128
typedef struct {
    int n;
    long long process[2][STAGE_LIMIT];
    long long transit[2][STAGE_LIMIT]; // transit[from][j] 是跨到另一条线的整条边权
} AssemblyInput;
typedef struct {
    int n, line[STAGE_LIMIT + 1];
    int previous[2][STAGE_LIMIT + 1];
    long long cost[2][STAGE_LIMIT + 1], total;
} AssemblyPlan;

// 课件的分层图模型: n 次跨阶段转移, 初始可免费选线, 结束无额外费用.
// 每条边权 0..2*10^9; line[0..n] 给出每一层所在生产线.
int AssemblyLine(const AssemblyInput *input, AssemblyPlan *plan)
{
    if (!input || !plan || input->n < 0 || input->n > STAGE_LIMIT) return 0;
    int n = input->n;
    for (int line = 0; line < 2; ++line)
        for (int j = 0; j < n; ++j)
            if (input->process[line][j] < 0 || input->process[line][j] > 2000000000LL ||
                input->transit[line][j] < 0 || input->transit[line][j] > 2000000000LL) return 0;
    plan->n = n;
    plan->cost[0][0] = plan->cost[1][0] = 0;
    for (int stage = 1; stage <= n; ++stage) {
        for (int line = 0; line < 2; ++line) {
            long long stay = plan->cost[line][stage - 1] + input->process[line][stage - 1];
            long long move = plan->cost[1 - line][stage - 1] + input->transit[1 - line][stage - 1];
            int parent = stay <= move ? line : 1 - line;
            plan->cost[line][stage] = stay <= move ? stay : move;
            plan->previous[line][stage] = parent;
        }
    }
    int line = plan->cost[0][n] <= plan->cost[1][n] ? 0 : 1;
    plan->total = plan->cost[line][n];
    plan->line[n] = line;
    for (int stage = n; stage > 0; --stage) {
        line = plan->previous[line][stage];
        plan->line[stage - 1] = line;
    }
    return 1;
}
```

注意, `line[0..N]` 是 **$N+1$ 个层上的线号**, 对应 $N$ 条转移边. 不要把它误认为只需要输出 $N$ 个工位编号.

```c
#ifndef NOTE_NO_MAIN
int main(void)
{
    AssemblyInput input = {
        .n = 3,
        .process = {{7, 9, 3}, {8, 5, 6}},
        .transit = {{10, 7, 8}, {9, 11, 5}}
    };
    AssemblyPlan plan;
    if (!AssemblyLine(&input, &plan)) return 1;
    printf("minimum cost = %lld; lines: ", plan.total);
    for (int j = 0; j <= plan.n; ++j) printf("%d%c", plan.line[j], j == plan.n ? '\n' : ' ');
    return 0;
}
#endif
```

教学示例输出总费用 18, 路线为 `1 1 1 0`, 即:

$$
8+5+5=18
$$

第一步留在 0 号线只需 7, 看起来更便宜, 但之后整体最优的方案却从 1 号线开始. 这说明不能每一步只看眼前较小的边权.

#### 7.6.5 为什么是线性时间

每一层只有两个状态, 每个状态只比较两个来源. 因此总时间为 $O(N)$; 费用表、前驱表与路线共占 $O(N)$ 空间.

如果只求最优值, 可将费用表压缩到 $O(1)$ 空间; 若仍想直接还原方案, 这份实现需要保留前驱记录.

本实现最多支持 128 次转移, 边权在 $[0,2\times10^9]$. 相同费用时优先留线, 两个终点费用相同时选 0 号线; 这些约定只是让输出确定, 不改变最优值.

### 7.7 怎样设计一个 DP

#### 7.7.1 课件的四个步骤

1. **Characterize an optimal solution**: 先描述最优方案的结构, 常常从“最后一步是什么”入手;
2. **Recursively define the optimal values**: 定义状态、初值、合法转移与目标状态;
3. **Compute the values in some order**: 按依赖顺序计算, 让每个状态只求解一次;
4. **Reconstruct the solving strategy**: 如果需要方案, 同时记录最优选择, 最后回溯还原.

| 问题 | 状态 | 枚举什么 | 计算顺序 | 还原信息 |
| :--- | :--- | :--- | :--- | :--- |
| Fibonacci | 下标 $i$ | 固定的前两项 | 下标递增 | 不需要 |
| 矩阵链乘 | 连续区间 $[i,j]$ | 最后乘法的切分点 $k$ | 区间长度递增 | `split[i][j]` |
| 最优 BST | 有序关键词区间 $[i,j]$ | 根的位置 $k$ | 区间长度递增 | `root[i][j]` |
| Floyd-Warshall | 允许中间点集合与端点 $i,j$ | 使用 / 不使用新中间点 $k$ | $k$ 递增 | `next[i][j]` |
| 装配线 | 阶段 $s$ 与线号 $\ell$ | 留线 / 换线 | 阶段递增 | `previous[line][stage]` |

> [!TIP]
>
> 常见复杂度估计是“状态数 × 每个状态枚举转移的成本”. 但还要计入预处理和输出, 也要检查一次转移是不是真的 $O(1)$.
>
> 例如 OBST 若没有前缀和, 每次重新求区间权重会增加额外开销; Floyd 的路径输出也不属于一次常数时间查表.

#### 7.7.2 什么时候不能直接套 DP

不是每个递归都需要 DP, 也不是只要开一个二维数组就能得到高效算法.

- 子问题没有重复时, 保存大量缓存可能没有收益, 分治就已经足够;
- 状态丢失了必要历史时, 合并这些状态会得到错误答案;
- 转移存在循环依赖时, 不能随便选一个循环顺序填表, 需要重新组织状态或采用适合该依赖结构的算法;
- 状态虽正确, 数量却是指数级时, DP 仍可能不够高效.

例如一般图的最长简单路径, “从 $i$ 到 $j$ 的最长长度”不足以作为可随意拼接的状态, 因为两个子路径可能重复使用顶点. 为保证“简单路径”, 通常需要额外描述已使用顶点等信息, 状态规模可能迅速变大.

<details style="--wi-box-color:var(--wi-question);--wi-box-bg:var(--wi-question-bg)"><summary>有最优子结构, 就一定能写出多项式时间 DP 吗?</summary><p>不能. 还要看能否用数量可控的状态描述问题, 以及每个状态的转移是否高效. “能递推”与“递推后很快”是两件需要分别说明的事.</p></details>

### 7.8 Beautiful Subsequence: 从优化转到计数

> 完整教学源码: [beautiful_subsequence.c](./code/beautiful_subsequence.c). 课件第 18 页只有项目简介, 本节明确采用下面的教学约定, 不把缺失的数据范围或提交格式当作已知条件.

#### 7.8.1 先把“相邻”说清楚

给定整数序列 $a_0,\ldots,a_{N-1}$ 与 $m\ge0$, 选择下标严格递增的一组元素形成子序列. 本节把“差不大于 $m$”解释为绝对差不大于 $m$.

如果所选子序列至少有两个元素, 且**存在一对在所选子序列中相邻的元素**, 满足绝对差 $\le m$, 就称为 beautiful.

> [!CAUTION]
>
> 相邻指的是“所选子序列中相邻”, 不要求它们在原数组中相邻; 条件是“存在一对”, 不是“每一对都满足”.
>
> 本教学实现按所选下标区分方案. 即使值相同, 选择了不同下标也算不同子序列. 若正式题面有不同约定, 需要相应修改.

#### 7.8.2 为什么需要两个状态

只用“以 $i$ 结尾的子序列数量”, 无法区分它是否已经出现过符合条件的相邻对.

所以定义:

- $bad[i]$: 以 $i$ 结尾、目前没有符合条件的相邻对的非空子序列数;
- $good[i]$: 以 $i$ 结尾、已经至少出现一对符合条件相邻元素的子序列数.

单独选 $a_i$ 时, `bad[i]=1`, `good[i]=0`.

考虑把 $a_i$ 接到以 $j<i$ 结尾的子序列后:

1. 原来已经 beautiful, 接什么都仍然 beautiful;
2. 原来还不 beautiful, 若 $|a_i-a_j|\le m$, 新增相邻对使它变为 beautiful;
3. 否则它仍然属于 bad.

于是:

$$
bad[i]=1+\sum_{\substack{j<i\\|a_i-a_j|>m}}bad[j]
$$

$$
good[i]=\sum_{j<i}good[j]+\sum_{\substack{j<i\\|a_i-a_j|\le m}}bad[j]
$$

最后答案是 $\sum_i good[i]$.

为什么不会重复? 任意长度至少为 2 的子序列都有唯一的最后下标 $i$ 和倒数第二个下标 $j$. 再按追加前是否已经 beautiful 分类, 每种方案恰好被计数一次.

#### 7.8.3 完整计数实现

子序列数量可能指数增长, 因而教学代码规定答案对 $10^9+7$ 取模. 这个模数是本示例的明确约定, 不是从课件中推断出的正式项目要求.

头文件为 `<stdint.h>`、`<stdio.h>`、`<stdlib.h>`:

```c
#define BEAUTIFUL_MOD 1000000007LL

// 教学约定: 子序列按下标集合区分; 存在一对相邻所选元素满足绝对差 <= m.
// m>=0, 结果按 BEAUTIFUL_MOD 取模. 空序列和单元素序列不计入答案.
int CountBeautiful(const int a[], int n, long long m, long long *out)
{
    if (n < 0 || m < 0 || !out || (n > 0 && !a)) return 0;
    if (n < 2) { *out = 0; return 1; }
    if ((size_t)n > SIZE_MAX / sizeof(long long)) return 0;
    long long *bad = calloc((size_t)n, sizeof *bad);
    long long *good = calloc((size_t)n, sizeof *good);
    if (!bad || !good) { free(bad); free(good); return 0; }
    long long answer = 0;
    for (int i = 0; i < n; ++i) {
        bad[i] = 1; // 单独选 a[i], 还没有符合条件的相邻对
        for (int j = 0; j < i; ++j) {
            long long difference = (long long)a[i] - a[j];
            if (difference < 0) difference = -difference;
            good[i] = (good[i] + good[j]) % BEAUTIFUL_MOD;
            if (difference <= m) good[i] = (good[i] + bad[j]) % BEAUTIFUL_MOD;
            else bad[i] = (bad[i] + bad[j]) % BEAUTIFUL_MOD;
        }
        answer = (answer + good[i]) % BEAUTIFUL_MOD;
    }
    free(bad);
    free(good);
    *out = answer;
    return 1;
}
```

先把元素转换为 `long long` 再相减, 避免 `INT_MIN` 与 `INT_MAX` 的差在 `int` 中溢出.

```c
#ifndef NOTE_NO_MAIN
int main(void)
{
    int a[] = {1, 3, 2};
    long long answer;
    if (!CountBeautiful(a, 3, 1, &answer)) return 1;
    printf("beautiful subsequences = %lld\n", answer);
    return 0;
}
#endif
```

例子 $[1,3,2]$, $m=1$, beautiful 子序列共有 3 个: $[1,2]$、$[3,2]$、$[1,3,2]$.

时间为 $O(N^2)$, 额外空间为 $O(N)$. 这个版本用于展示正确状态与计数转移; 如果正式题面规模很大, 还需要依据具体约束优化求和过程.

### 7.9 最终表格

| 问题 | 时间 | 额外空间 | 重点 |
| :--- | :--- | :--- | :--- |
| Fibonacci, 滚动变量 | $O(N)$ | $O(1)$ | 保存仍会被使用的前两项 |
| 矩阵链乘 | $O(N^3)$ | $O(N^2)$ | 固定矩阵顺序, 枚举最后切分点 |
| 成功查询模型的 OBST | $O(N^3)$ | $O(N^2)$ | 权重和增加一层比较成本 |
| Floyd-Warshall | $O(N^3)$ | $O(N^2)$ | 状态限制中间点集合, `k` 在最外层 |
| 装配线最优路线 | $O(N)$ | $O(N)$ | 状态保留阶段和线号, 前驱用于还原 |
| Beautiful Subsequence 教学版 | $O(N^2)$ | $O(N)$ | 区分是否已经出现合格相邻对 |

> [!IMPORTANT]
>
> 写 DP 前, 先用一句完整的话说明 `dp[...]` 到底代表什么. 状态意义、边界、转移、计算顺序、最终答案、方案还原, 这六件事对上之后, 循环通常就不难写了.


## Chapter 8: Practice

### 8.1 判断题 && 单选题

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

### 8.2 编程题 && 程序填空题

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


**填完整后的函数:**

这里沿用第三章的 PriorityQueue 和 SwapChildren 定义, 把题目中的伪代码 swap 改成实际的指针交换.

```c
PriorityQueue MergeExercise(PriorityQueue H1, PriorityQueue H2)
{
    if (H1 == NULL) return H2;
    if (H2 == NULL) return H1;
    if (H1->Element > H2->Element)
    {
        PriorityQueue temp = H1;
        H1 = H2;
        H2 = temp;
    }
    if (H1->Left == NULL)
        H1->Left = H2;
    else
    {
        H1->Right = MergeExercise(H1->Right, H2);
        if (H1->Left->Npl < H1->Right->Npl) SwapChildren(H1);
        H1->Npl = H1->Right->Npl + 1;
    }
    return H1;
}
```


### 8.3 历史提问: Binary Heap

**原提问:** 二叉堆的insert和deletemin是什么,为什么OlogN

**来源:** 2026-10-12 的 GPT 对话 "二叉堆操作复杂度". 仅将原提问中的逗号改为英文标点.

**解析:** 这里讨论 Min-Heap. Insert 将新 key 放到数组末尾, 然后沿父节点方向上滤, 直到满足父节点不大于孩子的 Heap Order. DeleteMin 删除根处的最小值, 将末尾元素移到根, 再与较小的孩子比较并下滤.

二叉堆是 Complete Binary Tree, $N$ 个节点的高度为 $\lfloor\log_2 N\rfloor$. 每一步只移动一层并进行常数次比较, 因此两种操作的最坏时间均为 $O(\log N)$. 单次操作可能提前停止, 不意味着每次都必须走到最后一层. 动态数组重新分配内存的成本需要另外分析.

| 操作 | 起点 | 调整方向 | 最坏时间 |
| :--- | :--- | :--- | :---: |
| Insert | 数组末尾的新节点 | 上滤 | $O(\log N)$ |
| DeleteMin | 根处的末尾替代值 | 下滤 | $O(\log N)$ |

**Binary Heap 完整代码:**

源码: [binary_heap.c](./code/binary_heap.c). 本例初始化时一次性分配容量, 堆满时 Insert 返回 0, 因而单次 Insert 的 $O(\log N)$ 不包含重新分配数组的成本. 数组从 1 开始, 不需要假设存在比所有输入都小的哨兵值, 所以负数和 INT_MIN 也能正常使用.

```c
#include <stdio.h>
#include <stdlib.h>
#include <stdint.h>

typedef struct BinaryHeap
{
    int *data;                   // 从 1 开始, data[0] 不作哨兵
    size_t size;
    size_t capacity;
} BinaryHeap;

int HeapInit(BinaryHeap *H, size_t capacity)
{
    *H = (BinaryHeap){0};
    if (capacity == 0) capacity = 1;
    if (capacity > SIZE_MAX / sizeof(int) - 1) return 0;
    H->data = malloc((capacity + 1) * sizeof(*H->data));
    if (H->data == NULL) return 0;
    H->capacity = capacity;
    return 1;
}

void HeapDestroy(BinaryHeap *H)
{
    free(H->data);
    *H = (BinaryHeap){0};
}
```


```c
int HeapInsert(BinaryHeap *H, int x)
{
    if (H->data == NULL || H->size == H->capacity) return 0;
    size_t hole = ++H->size;
    while (hole > 1 && H->data[hole / 2] > x)
    {
        H->data[hole] = H->data[hole / 2];
        hole /= 2;
    }
    H->data[hole] = x;
    return 1;
}

void PercolateDown(BinaryHeap *H, size_t hole)
{
    int x = H->data[hole];
    while (hole <= H->size / 2)
    {
        size_t child = hole * 2;
        if (child < H->size && H->data[child + 1] < H->data[child]) child++;
        if (x <= H->data[child]) break;
        H->data[hole] = H->data[child];
        hole = child;
    }
    H->data[hole] = x;
}

int HeapFindMin(const BinaryHeap *H, int *out)
{
    if (H->size == 0) return 0;
    *out = H->data[1];
    return 1;
}

int HeapDeleteMin(BinaryHeap *H, int *out)
{
    if (!HeapFindMin(H, out)) return 0;
    H->data[1] = H->data[H->size--];
    if (H->size > 0) PercolateDown(H, 1);
    return 1;
}

int HeapBuild(BinaryHeap *H, const int a[], size_t n)
{
    if (H->data == NULL || n > H->capacity) return 0;
    for (size_t i = 0; i < n; i++) H->data[i + 1] = a[i];
    H->size = n;
    for (size_t i = n / 2; i > 0; i--) PercolateDown(H, i);
    return 1;
}
```


```c
int main(void)
{
    BinaryHeap H;
    int a[] = {8, 3, 10, 2, 6};
    if (!HeapInit(&H, 16)) return EXIT_FAILURE;
    HeapBuild(&H, a, sizeof(a) / sizeof(a[0]));
    HeapInsert(&H, -1);
    int x;
    while (HeapDeleteMin(&H, &x)) printf("%d ", x);
    putchar('\n');
    HeapDestroy(&H);
    return 0;
}
```

<div style="display: block !important; text-align: right !important; margin-top: 60px !important; padding-right: 20px !important; font-family: '钟齐志莽行书', cursive !important; font-size: 26px !important; font-weight: bold !important; font-style: italic !important; color: var(--wi-signature) !important;">邓欢桐</div>

