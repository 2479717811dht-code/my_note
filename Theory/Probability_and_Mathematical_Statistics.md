# <center>概率论与数理统计</center>

---

<center>浙江大学 竺可桢学院 混合2504班 邓欢桐 3250102223</center>

---

<center>
<img src="../public/20260323101520_871_96.png" style="zoom: 60%;" />
<img src="../public/20260323101521_872_96.png" style="zoom: 20%;" />
<img src="../public/ckc.png" style="zoom: 25%;" />
</center>



---

[TOC]

<div style="display: block !important; text-align: center !important; margin: 60px auto 20px !important; padding: 20px 0 !important; width: 85% !important; border-top: 1px dashed #b1c2ca !important; border-bottom: 1px dashed #b1c2ca !important; font-family: '钟齐志莽行书', cursive !important; font-size: 20px !important; line-height: 1.8 !important; letter-spacing: 2px !important; font-weight: normal !important; font-style: italic !important; color: #2d4856 !important;">“爱你是孤单的心事”<span style="display: block !important; text-align: right !important; margin-top: 10px !important; font-size: 18px !important;">—— 2026.7.17 玉湖七幢</span></div>

## Chapter 1：概率论的基本概念

概率论：研究随机现象数量规律性的学科。

> **key words**
>
> 随机现象，随机试验，样本空间，随机事件，频率和概率，条件概率，事件的独立性......

### 1.1 随机试验

随机试验：对随机现象的观察、记录等过程活动。

自然界与社会生活中的两类现象：必然现象、随机现象。

> **必然现象**：结果确定；
>
> **随机现象**：结果不确定。

随机事件的特点：

- 重复性：可以在相同情况下重复进行；
- 确定性：事先知道所有可能出现的结果；
- 随机性：试验前并不知道哪个结果会发生。

#### 1.1.1 样本空间

> **定义**
>
> 随机事件 E 的所有结果构成的集合称为 E 的样本空间，记为 S={e}，并称 S 中的元素 e 为样本点，一个元素的单点集称为基本事件。

#### 1.1.2 随机事件

> **定义**
>
> 一般，我们称 S 的子集 A 为随机试验 E 的随机事件 A，当且仅当 A 所包含的一个样本点发生称事件 A 发生。

为方便起见，记 ∅ 为不可能事件，∅ 不包含任何样本点。

#### 1.1.3 事件的关系及运算

事件的关系（包含、相等）

1. A 包含于 B（A ⊂ B）：事件 A 发生一定导致 B 发生；

2. 事件 A 与 B 相等（A = B），等价于同时满足两个条件：

   - A 包含于 B
   - B 包含于 A

3. A 和 B 的和运算，记为 A ∪ B，即 A 和 B 至少有一事发生；

4. A 和 B 的积事件，记为 A ∩ B，即 A 和 B 同时发生；

5. n 个事件的和（并）

   $\bigcup\limits_{i=1}^{n} A_i$：表示 $A_1,A_2,\dots,A_n$ 至少有一发生。

6. n 个事件的积（交）

   $\bigcap\limits_{i=1}^{n} A_i$：表示 $A_1,A_2,\dots,A_n$ 同时发生。

7. 互斥（互不相容）定义

   当 AB = ∅（空集）时，称 A 与 B 互不相容或互斥，含义是 A 和 B 不可能同时发生。

8. A 和 B 的差事件，记为 A - B，表示 x 仅属于 A 且不属于 B；

9. 