# <center>Digital Logic Design</center>

---

<center>浙江大学 竺可桢学院 混合2504班 邓欢桐 3250102223 · 杨海涛</center>

---

<center>
<img src="../public/20260323101520_871_96.png" style="zoom: 67%;" />
<img src="../public/20260323101521_872_96.png" style="zoom: 25%;" /><img src="../public/ckc.png" style="zoom: 25%;" />
</center>

---

[📦 GitHub 实验工程与报告源码仓库汇总](https://github.com/2479717811dht-code/my_note/tree/main/Lab/Lab_for_all/Digital_Logic_Design)

---

## 课程设计大作业 · Final Project

::: tip 🎮 期末大作业：完整可运行、通过全功能上板测试与验收
基于 **Sword Kintex-7 FPGA** 实验平台与 **Verilog HDL** 设计实现的节奏类交互游戏系统：**ZJU_Lowrider_Challenge_Lite**。系统包含 640×480 VGA 显示驱动、PS/2 键盘解码、有限状态机、ROM 图像与背景存储、按键交互、计分等级与判定系统。
:::

- 📄 **[期末大作业完整实验设计报告 · Report of Final Project](./Lab_for_all/Digital_Logic_Design/projects/Degital_Logic_Design_Final_Porject/report/Report.md)**
  - **核心主题**：ZJU_Lowrider_Challenge_Lite
  - **硬件平台**：Sword Kintex-7 FPGA 实验箱、VGA 显示器、PS/2 键盘
  - **关键技术**：分频时钟、VGA 像素扫描驱动、ROM 高清图像字模存储、双按键/键盘消抖输入、多状态有限状态机（菜单/游玩/失败/结算/胜利）

---

## 系列实验报告目录 · Weekly Lab Reports (1 ~ 13)

本学期数字逻辑设计课程共完成 13 次实验，涵盖从基础电子仪器、门电路到复杂时序逻辑与数据通路的完整设计：

### 基础仪器与开关门电路 (Lab 1 ~ 3)

| 实验序号 | 实验日期 | 实验项目名称 | 在线报告链接 |
| :---: | :---: | :--- | :---: |
| **Lab 1** | 3.2 | 常用电子仪器使用与直流/正弦信号测量 | [查看报告](./Lab_for_all/Digital_Logic_Design/Lab/3.2/第一次实验报告-邓欢桐、杨海涛.md) |
| **Lab 2** | 3.9 | 基本开关电路 | [查看报告](./Lab_for_all/Digital_Logic_Design/Lab/3.9/第二次实验报告-邓欢桐、杨海涛.md) |
| **Lab 3** | 3.16 | 集成逻辑门电路的功能及参数测试 | [查看报告](./Lab_for_all/Digital_Logic_Design/Lab/3.16/第三次实验报告-邓欢桐、杨海涛.md) |

### EDA 平台与组合逻辑电路设计 (Lab 4 ~ 8)

| 实验序号 | 实验日期 | 实验项目名称 | 在线报告链接 |
| :---: | :---: | :--- | :---: |
| **Lab 4** | 3.23 | EDA 实验平台与实验环境运用 (Vivado 仿真与下板) | [查看报告](./Lab_for_all/Digital_Logic_Design/Lab/3.23/第四次实验报告.md) |
| **Lab 5** | 3.30 | 变量译码器设计与应用 | [查看报告](./Lab_for_all/Digital_Logic_Design/Lab/3.30/第五次实验报告-邓欢桐、杨海涛.md) |
| **Lab 6** | 4.13 | 7 段数码管显示译码器设计与应用 | [查看报告](./Lab_for_all/Digital_Logic_Design/Lab/4.13/第六次实验报告-邓欢桐、杨海涛.md) |
| **Lab 7** | 4.20 | 多路选择器设计及应用 | [查看报告](./Lab_for_all/Digital_Logic_Design/Lab/4.20/第七次实验报告（邓欢桐、杨海涛）.md) |
| **Lab 8** | 4.27 | 加法器设计与应用 (一位全加器、多位串行/超前进位加法器) | [查看报告](./Lab_for_all/Digital_Logic_Design/Lab/4.27/第八次实验报告-邓欢桐、杨海涛.md) |

### 触发器与时序逻辑电路设计 (Lab 9 ~ 13)

| 实验序号 | 实验日期 | 实验项目名称 | 在线报告链接 |
| :---: | :---: | :--- | :---: |
| **Lab 9** | 5.11 | 锁存器与触发器基本原理 | [查看报告](./Lab_for_all/Digital_Logic_Design/Lab/5.11/第九次实验报告-邓欢桐、杨海涛.md) |
| **Lab 10** | 5.18 | 同步时序电路设计 | [查看报告](./Lab_for_all/Digital_Logic_Design/Lab/5.18/第十次实验报告-邓欢桐、杨海涛.md) |
| **Lab 11** | 5.25 | 寄存器及寄存器传输设计 | [查看报告](./Lab_for_all/Digital_Logic_Design/Lab/5.25/第十一次实验报告-邓欢桐，杨海涛.md) |
| **Lab 12** | 6.1 | 移位寄存器设计与应用 | [查看报告](./Lab_for_all/Digital_Logic_Design/Lab/6.1/第十二次实验报告-邓欢桐、杨海涛.md) |
| **Lab 13** | 6.8 | 计数器、定时器设计与应用 | [查看报告](./Lab_for_all/Digital_Logic_Design/Lab/6.8/第十三次实验报告-邓欢桐、杨海涛.md) |

---

## 实验环境与工具链说明

- **EDA 工具**：Xilinx Vivado Design Suite
- **硬件平台**：Sword Kintex-7 FPGA 实验箱
- **输入输出**：4×4 矩阵键盘、8位拨码开关、7段数码管、VGA 显示屏、PS/2 键盘
- **语言标准**：Verilog HDL (IEEE 1364-2001)

---

## 参考与交流提示

::: warning ⚠️ 学习参考建议
- 实验报告中包含完整的电路原理图、引脚约束配置、仿真波形分析以及课后反思记录；
- 建议结合自身板卡的实际管脚约束与时钟频率进行独立验证，尤其关注时序电路中的亚稳态与时钟域同步问题。
:::