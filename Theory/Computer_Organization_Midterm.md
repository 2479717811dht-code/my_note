---
title: 计算机组成与体系 · 期中考试完整全景备考手册与考场速查卡
description: 计算机组成核心考点、RISC-V/MIPS 指令集、单周期/流水线数据通路、冒险处理与考场速查
---

# 计算机组成期中开卷资料：完整主手册

导航：G 使用指南；C1/C2/C3/C4 四章；Q01-Q80 题型；M 模拟卷；E 英文与更正；V 术语。附录另见逐页解读。

## 快速目录

- [G01 | 如何使用：先找题型，再查公式，再看步骤](#g01)
- [G02 | 看见这些英文，应该去哪里](#g02)
- [G03 | 全套统一约定：每道题先检查这 9 件事](#g03)
- [G04 | 内容覆盖与原始课件定位](#g04)
- [G05 | 考场操作流程与检索策略](#g05)
- [G06 | 来源与可信边界](#g06)
- [C1-01 | 计算机定义、发展、类别与存储程序](#c1-01)
- [C1-02 | 五大部件、抽象、ISA 与软硬件层次](#c1-02)
- [C1-03 | IC 制造、良率与成本](#c1-03)
- [C1-04 | 执行时间、时钟、性能比与百分比](#c1-04)
- [C1-05 | IC、CPI、指令混合与 CPU 性能方程](#c1-05)
- [C1-06 | 动态功耗、能量、功耗墙](#c1-06)
- [C1-07 | Amdahl's Law：局部优化与整体加速](#c1-07)
- [C1-08 | SPEC、几何平均与性能每瓦](#c1-08)
- [C1-09 | MIPS 与性能比较误区](#c1-09)
- [C1-10 | 八大设计思想与流水线类比](#c1-10)
- [C2-01 | RISC-V 入门与四个设计原则](#c2-01)
- [C2-02 | 全部整数寄存器与保存责任](#c2-02)
- [C2-03 | 内存、数组、有效地址与 load/store](#c2-03)
- [C2-04 | 字节序、对齐、结构体布局](#c2-04)
- [C2-05 | 无符号、补码、取负与扩展](#c2-05)
- [C2-06 | 数据搬运总表与 RV64 W 操作](#c2-06)
- [C2-07 | 逻辑、掩码、移位与比较置位](#c2-07)
- [C2-08 | 六类 32 位指令格式与字段位置](#c2-08)
- [C2-09 | 编码、解码的通用步骤与现成例子](#c2-09)
- [C2-10 | 分支、跳转、PC 相对偏移与范围](#c2-10)
- [C2-11 | 大立即数、LUI/AUIPC 与寻址方式](#c2-11)
- [C2-12 | if、while、for、switch 与基本块](#c2-12)
- [C2-13 | 函数调用、栈帧、leaf 与 non-leaf](#c2-13)
- [C2-14 | 递归、swap/sort 与调用追踪](#c2-14)
- [C2-15 | 字符、字符串与数组/指针优化](#c2-15)
- [C2-16 | 同步、原子性、LR/SC 和锁](#c2-16)
- [C2-17 | 编译、汇编、链接、装载、动态链接、JIT](#c2-17)
- [C2-18 | RISC/MIPS/x86、扩展和伪指令](#c2-18)
- [C3-01 | 进制、定点、原码反码补码](#c3-01)
- [C3-02 | 加减、进位、借位与有符号溢出](#c3-02)
- [C3-03 | 半加器、全加器、真值表和逻辑式](#c3-03)
- [C3-04 | ALU 的加减、比较、零检测与控制](#c3-04)
- [C3-05 | Ripple、CLA、分组超前进位与 Carry Select](#c3-05)
- [C3-06 | 无符号乘法、三版乘法器与乘法指令](#c3-06)
- [C3-07 | Booth 算法：规则、时序、完整追踪](#c3-07)
- [C3-08 | 恢复余数除法、有符号除法与 RISC-V 除法](#c3-08)
- [C3-09 | IEEE 754：字段、偏置与规格化数](#c3-09)
- [C3-10 | 零、次正规数、无穷、NaN、范围与精度](#c3-10)
- [C3-11 | 浮点加减乘除的解题流程](#c3-11)
- [C3-12 | GRS、最近偶数舍入与误差](#c3-12)
- [Q01 | CPU time and clock rate 目标时钟频率](#q01)
- [Q02 | Weighted CPI and execution time 加权 CPI](#q02)
- [Q03 | More instructions can be faster 指令多反而更快](#q03)
- [Q04 | Amdahl and an impossible target 局部加速上限](#q04)
- [Q05 | Power versus energy 功耗和能量](#q05)
- [Q06 | Yield and die cost 良率成本](#q06)
- [Q07 | SPEC geometric mean 基准几何平均](#q07)
- [Q08 | Pipelining with unequal stages 不等长流水](#q08)
- [Q09 | Compile an array expression 数组表达式翻译](#q09)
- [Q10 | Little-endian and load extension 字节序与扩展](#q10)
- [Q11 | Signed comparison and right shifts 比较与右移](#q11)
- [Q12 | Encode R/I/S instructions 指令编码](#q12)
- [Q13 | Decode a machine word 反汇编](#q13)
- [Q14 | Branch offset and encoding 正向与反向分支](#q14)
- [Q15 | LUI plus ADDI 大常数拆分](#q15)
- [Q16 | Stack frame and recursion 栈帧追踪](#q16)
- [Q17 | Linker versus loader 工具职责](#q17)
- [Q18 | Carry versus signed overflow 进位不等于溢出](#q18)
- [Q19 | CLA signals and carries 超前进位演算](#q19)
- [Q20 | Shift-and-add multiplication 移位乘法](#q20)
- [Q21 | Booth signed multiplication Booth 逐轮表](#q21)
- [Q22 | Restoring division and signs 恢复除法](#q22)
- [Q23 | Encode a floating-point value 浮点编码](#q23)
- [Q24 | Decode IEEE 754 and classify specials 浮点解码分类](#q24)
- [Q25 | Range and precision 范围精度](#q25)
- [Q26 | Floating-point addition 对阶与相消](#q26)
- [Q27 | Round to nearest, ties to even 最近偶数](#q27)
- [Q28 | Bit-field extraction and insertion 位域提取与插入](#q28)
- [Q29 | if-else control flow 互斥路径](#q29)
- [Q30 | Counting dynamic instructions 循环动态计数](#q30)
- [Q31 | Register preservation bug 寄存器保存错误](#q31)
- [Q32 | JALR uses the old source and clears bit zero 间接跳转](#q32)
- [Q33 | Structure alignment and padding 结构体布局](#q33)
- [Q34 | ALU signed less-than fix 比较溢出纠正](#q34)
- [Q35 | Minimum two's-complement value 最小负数](#q35)
- [Q36 | Floating-point multiplication 指数偏置](#q36)
- [Q37 | Non-associative floating-point addition 不结合性](#q37)
- [Q38 | Division edge cases 除法边界](#q38)
- [Q39 | LR/SC status 原子存储状态](#q39)
- [Q40 | Explain the ISA interface 英文概念简答](#q40)
- [E01 | 英文命令词与常见限定词](#e01)
- [E02 | 可以直接改写使用的英文作答句式](#e02)
- [E03 | 从题干抽取条件的示范](#e03)
- [E04 | 30 个最常见易错点速查](#e04)
- [E05 | 开卷资料准备与最后一轮复习](#e05)
- [E06 | 与课件、旧笔记不同的地方：集中更正表](#e06)
- [E07 | Chapter 4 易错点 25 条与英文作答句式](#e07)
- [V01 | Chapter 1 概念与性能术语](#v01)
- [V02 | Chapter 2 指令、地址与程序术语](#v02)
- [V03 | Chapter 3 算术与浮点术语](#v03)
- [V04 | Chapter 4 处理器、数据通路与控制术语](#v04)
- [C4-01 | 本章地图：CPU = 数据通路 + 控制；与性能公式的接口](#c4-01)
- [C4-02 | 逻辑设计约定：组合元件、状态元件、边沿触发、时钟方法](#c4-02)
- [C4-03 | 数据通路元件全表：端口、位宽与职责](#c4-03)
- [C4-04 | 指令格式与“字段 → 端口”接线；课程指令的 opcode/funct 表](#c4-04)
- [C4-05 | 立即数生成器 Imm Gen：五种拼接、符号扩展、“左移 1 位”约定](#c4-05)
- [C4-06 | 各类指令的数据流：五阶段对照与“哪些部件被用到”](#c4-06)
- [C4-07 | 多路选择器与 7 个控制信号：语义表](#c4-07)
- [C4-08 | 主控制器（第一级）：真值表、Verilog 模板答案、I 型 ALUOp 陷阱](#c4-08)
- [C4-09 | ALU 译码器（第二级）：ALUOp + funct → ALU control；3 位与 4 位两套编码](#c4-09)
- [C4-10 | 完整数据通路 + 控制：一张图读懂所有连线](#c4-10)
- [C4-11 | 单周期时序：关键路径、时钟周期、CPI 与性能](#c4-11)
- [C4-12 | 完整逐线追踪：一段 9 条指令程序在单周期数据通路上的所有值](#c4-12)
- [C4-13 | 为新指令修改数据通路：addi、bne、jalr、lui、auipc、slli、lw/lb](#c4-13)
- [C4-14 | 控制信号故障（stuck-at）分析与 don't care](#c4-14)
- [C4-15 | 课件核心英文原句与翻译（考英语题干必读）](#c4-15)
- [C4-16 | Chapter 4 课件与旧笔记勘误表](#c4-16)
- [Q41 | Trace the single-cycle datapath 单周期逐线追踪](#q41)
- [Q42 | Fill in the control signals 控制信号填表](#q42)
- [Q43 | Complete the main-controller Verilog 主控制器模板填空](#q43)
- [Q44 | Complete the ALU-decoder Verilog ALU 译码器填空](#q44)
- [Q45 | Critical path of each instruction class 各类指令关键路径](#q45)
- [Q46 | Fixed versus ideal variable clock 固定周期与可变周期](#q46)
- [Q47 | Which improvement helps more? 改进哪个部件](#q47)
- [Q48 | Encode the lab instruction set 实验指令编码](#q48)
- [Q49 | Immediate generator outputs 立即数生成器输出](#q49)
- [Q50 | The I-type ALUOp bug 立即数指令译码陷阱](#q50)
- [Q51 | Stuck-at faults on control signals 控制信号卡死](#q51)
- [Q52 | A concrete fault trace 故障的具体后果](#q52)
- [Q53 | Add jalr to the datapath 增加 jalr](#q53)
- [Q54 | Add bne 增加 bne](#q54)
- [Q55 | Add lui and auipc 增加 lui 与 auipc](#q55)
- [Q56 | Why separate memories and adders? 为何分离存储器和加法器](#q56)
- [Q57 | Writes to x0 and jal x0 x0 的写入](#q57)
- [Q58 | Units used by each instruction 部件使用表](#q58)
- [Q59 | Reading and writing the same register 同周期读写](#q59)
- [Q60 | Identify the instruction from control signals 由控制信号反推指令](#q60)
- [Q61 | Concepts in English 概念英文简答](#q61)
- [Q62 | Why shift left by one? 为何左移一位](#q62)
- [Q63 | Amdahl's Law variants Amdahl 变式](#q63)
- [Q64 | Parallel speedup limit 多核加速上限](#q64)
- [Q65 | MIPS rating and CPI MIPS 与 CPI](#q65)
- [Q66 | Compiler trade-off 编译器取舍](#q66)
- [Q67 | Eight-bit addition flags 8 位加法标志](#q67)
- [Q68 | Booth: 6 × (-9) Booth 5 位](#q68)
- [Q69 | Restoring division 13 ÷ 3 恢复除法](#q69)
- [Q70 | Encode IEEE 754 single 浮点编码加练](#q70)
- [Q71 | Decode IEEE 754 single 浮点解码加练](#q71)
- [Q72 | Decode an R-type word 反汇编 R 型](#q72)
- [Q73 | Encode store and backward branch 编码 sw 与后向分支](#q73)
- [Q74 | Encode and decode jal 编码解码 jal](#q74)
- [Q75 | while loop and dynamic count while 循环计数](#q75)
- [Q76 | Leaf procedure 叶过程](#q76)
- [Q77 | Carry-select delay 选择进位延迟](#q77)
- [Q78 | Toy floating-point addition with rounding 小格式浮点加法](#q78)
- [Q79 | Floating-point multiplication with stored exponents 用存储指数做乘法](#q79)
- [Q80 | Percentages and speedup wording 百分比措辞](#q80)
- [M01 | Mock paper 模拟卷题目（英文）](#m01)
- [M02 | Answer key 模拟卷答案与评分要点](#m02)


---

# Computer Organization 期中开卷资料 | Chapters 1-4 (Part 1)

> 中英对照 · 按题型检索 · 公式与步骤 · 80 道例题与英文作答 · 模拟卷 · 408 页课件逐页解读附录

编制日期：2026-10-27；2026-10-30 扩充第 4 章。范围依据 `lesson` 中的全部原始课件：Chapter 1 共 106 页、Chapter 2 共 131 页、Chapter 3 共 100 页、Chapter 4 Part 1 共 71 页，合计 408 页。未获得本次试卷、教师另发的考试大纲或删减通知，因此“完整”指对现有四份课件的系统覆盖，不代表预测考点或保证试卷只考这些内容。

**本次扩充（10-30）**：新增 C4-01…C4-16（单周期数据通路与控制，含 Verilog 填空答案、逐线追踪、关键路径、故障分析、扩展指令、勘误）；Q41-Q80 共 40 道新题（22 道第 4 章 + 18 道第 1-3 章加练）；M01/M02 英文模拟卷及答案；V04 第 4 章术语；E07 第 4 章易错与句式；速查卡 P11/P12；第 4 章 71 页逐页翻译解读并入附录。

<a id="g01"></a>

## G01 | 如何使用：先找题型，再查公式，再看步骤

Tags: #guide #open-book #导航 #开卷 #search #使用方法

**HTML 是推荐入口**。离线打开 `期中考试资料_离线检索版.html` 即可，不需要联网、登录或安装插件。搜索框支持中文、英文、指令名、标签和多个关键词；多个词按“同时包含”匹配，例如 `branch offset`、`补码 溢出`、`float rounding`。搜索时大小写不敏感。主手册与逐页附录有独立入口；全库搜索包含两者。也可以按 Ctrl+F 使用浏览器原生搜索。

建议先用主手册解决题目；对课件中特定图表、历史说明或未展开的小节，再进入逐页附录。附录沿用现有笔记的全部 408 页解读（第 1-3 章 337 页 + 第 4 章 71 页），增加来源定位入口，不把旧笔记中的说法当作新核验的事实。主手册的更正与统一约定见 G03、E06。

**纸质准备**：先打印 `考场速查卡.pdf`；需要更完整的纸质本时，打开主手册 HTML，点击“打印当前结果”，搜索框清空且选择“主手册”，再打印或另存为 PDF。浏览器打印附录会产生很长的文档。PDF 速查卡是压缩索引，完整推导在 HTML/Markdown 中。

<a id="g02"></a>

## G02 | 看见这些英文，应该去哪里

Tags: #router #题型 #English #英文题干 #关键词

| 英文题干关键词 | 中文意思 / 你要做什么 | 查找编号 |
|---|---|---|
| CPU time, execution time, clock rate, CPI, instruction mix | 性能计算；先统一单位 | C1-04、C1-05、Q01-Q04 |
| faster than, speedup, performance improvement | 性能比与时间比互为倒数 | C1-04、C1-07 |
| Amdahl, enhanced fraction, unaffected | 局部加速的整体上限 | C1-07、Q04 |
| die, wafer, yield, defect density | 晶圆、裸片、良率、成本 | C1-03、Q06 |
| power, voltage, capacitive load, energy | 动态功耗平方项与能量 | C1-06、Q05 |
| encode, machine code, hexadecimal | 汇编转机器码，按格式填字段 | C2-08、C2-09、Q12-Q15 |
| decode, disassemble | 机器码反汇编，先看 opcode | C2-09、Q13 |
| branch offset, target address, PC-relative | 目标地址减当前 PC；重排立即数字段 | C2-10、Q14 |
| array, pointer, base address, effective address | 数组元素大小决定偏移 | C2-03、C2-12、Q09 |
| endian, byte order, alignment, padding | 地址顺序、字节顺序、结构体填充 | C2-04、Q10 |
| procedure, leaf, nested, recursive, stack frame | 调用、保存寄存器、栈帧 | C2-13、C2-14、Q16 |
| caller-saved, callee-saved, preserved | 谁负责保存旧值 | C2-02、C2-13 |
| signed, unsigned, sign extension, zero extension | 补码解释、扩展、加载宽度 | C2-05、C2-06、C3-01 |
| overflow, carry out, borrow | 有符号溢出与无符号进位分别判断 | C3-02、Q18 |
| ALU, full adder, less, zero | 逻辑式、减法、比较、零检测 | C3-03、C3-04 |
| ripple carry, lookahead, propagate, generate | 串行进位、CLA、延迟 | C3-05、Q19 |
| multiplicand, multiplier, partial product | 被乘数、乘数、部分积 | C3-06、Q20 |
| Booth, arithmetic right shift | 相邻两位判定、联合算术右移 | C3-07、Q21 |
| dividend, divisor, quotient, remainder, restoring | 恢复余数除法和符号 | C3-08、Q22 |
| IEEE 754, exponent, significand, bias, normalize | 浮点编码、解码和特殊值 | C3-09、C3-10、Q23-Q25 |
| guard, round, sticky, nearest even, ulp | 舍入和精度 | C3-12、Q27 |
| floating-point add / multiply | 对阶→运算→规格化→舍入 | C3-11、Q26 |
| compiler, assembler, linker, loader, relocation | 编译链接装载 | C2-17、Q17 |
| synchronization, atomic, reservation, lock | LR/SC、原子交换、同步 | C2-16 |
| compare RISC and CISC, x86, MIPS | ISA 对比，避免混用语法 | C2-18 |
| explain, justify, derive, trace | 解释理由、推导、逐轮列状态 | E01、E02 |
| datapath, control unit, single-cycle | 单周期 CPU 结构与五阶段 | C4-01、C4-06、C4-10 |
| combinational, state element, edge-triggered, clocking | 组合/时序元件、时钟方法 | C4-02、Q61 |
| register file, read port, write enable | 寄存器堆端口、同周期读写 | C4-03、Q59 |
| immediate generator, sign-extend, shift left 1 | 立即数拼接、半字偏移 | C4-05、Q49 |
| control signal, RegWrite, ALUSrc, MemtoReg, Branch, Jump | 控制信号语义与填表 | C4-07、C4-08、Q42、Q60 |
| ALUOp, ALU control, funct | 两级译码、ALU 控制编码 | C4-09、Q44、Q50 |
| Verilog template, case, fill in | 课件 HDL 模板填空 | C4-08、C4-09、Q43、Q44 |
| trace the datapath, value on each wire | 逐线追踪 | C4-12、Q41 |
| critical path, latency, minimum clock period | 关键路径与时钟周期 | C4-11、Q45-Q47 |
| stuck-at-0, stuck-at-1, fault | 控制信号故障 | C4-14、Q51、Q52 |
| add support for, modify the datapath, jalr, lui, bne | 扩展指令 | C4-13、Q53-Q55 |
| mock exam, practice paper | 综合模拟 | M01、M02 |

<a id="g03"></a>

## G03 | 全套统一约定：每道题先检查这 9 件事

Tags: #assumptions #RV64 #RV32 #约定 #字节 #signed #陷阱

1. **位宽**：主手册汇编默认 RV64，整数寄存器 XLEN=64；为便于手算会明确指定 4/5/8 位。指令编码默认普通 32 位指令，未启用 C 压缩扩展。不要把 64 位寄存器误认为指令也有 64 位。
2. **数据宽度**：byte=8 bit；halfword=16 bit；word=32 bit；doubleword=64 bit。RV64 中 word 仍是 32 bit。C 的 `int` 通常为 4 字节，本文例题明确用 int32_t / int64_t；不能只因 CPU 为 64 位就将 int 当作 8 字节。
3. **地址**：按字节编址。`A[i]` 的地址为 `base+i×sizeof(element)`；load/store 的立即数是字节偏移。B/J 的偏移编码带隐含最低 0 位，不能与 load/store 混用。
4. **signed / unsigned**：位串本身没有类型；当前解释及指令决定符号。add/sub 的低 XLEN 位相同，比较、右移、扩展、高半乘积、除法要选对版本。
5. **立即数**：普通 I/S 的 12 位立即数有符号，范围 -2048…2047；逻辑立即数也做符号扩展。移位立即数按移位格式编码，不把 shamt 当普通有符号常数。
6. **时钟单位**：GHz=10^9 Hz；ns=10^-9 s；ps=10^-12 s。容量使用题目约定；KiB=1024 B，kB=1000 B，不能把所有 KB/GB 一律看作 1024。
7. **调用约定**：教学代码可以画简化栈；本文新写的 RV64 标准调用示例保持 sp 的 16 字节对齐。调用前后检查保存寄存器与栈平衡；ISA 本身与 ABI 约定分清。
8. **第 4 章约定**：课程数据通路 MemtoReg 为 2 位（00 ALU/01 存储器/10 PC+4）；Branch 与 Jump 是两个信号，PCSrc=Branch·Zero；ImmGen 对 beq/jal 输出半字数，后接 Shift left 1；ALU 控制有 3 位（课程 p55）与 4 位（教材 p57/p62）两套；I 型 ALU 指令建议 ALUOp=11。题目给的图或表与此不同时以题目为准。
9. **题目给定优先**：机器位宽、门延迟、舍入模式、数据类型、字节序、寄存器映射、是否包含压缩指令等，若题目明确给出，以题目为准。解答开头写出假设，避免默默套默认值。

<a id="g04"></a>

## G04 | 内容覆盖与原始课件定位

Tags: #coverage #source #范围 #页码 #课件

下表页码均为原始 PDF 的物理页码，不是加页解读版或打印本页码。主手册按知识结构重编；课程介绍、设备照片、历史、课后题号等保留在逐页附录。没有提供题面的教材作业，只记录题号，不虚构原题。

| 原始课件页段 | 覆盖主题 | 主手册 |
|---|---|---|
| C1 p1-38 | 课程介绍、历史、计算机定义与类别 | C1-01；逐页附录 |
| C1 p39-51 | 五大部件、软硬件层次、ISA | C1-02 |
| C1 p52-61 | IC 制造、良率、成本、技术瓶颈 | C1-03 |
| C1 p62-77 | 时间、频率、CPI、性能 | C1-04、C1-05 |
| C1 p78-90 | 功耗、多核、SPEC、Amdahl、MIPS | C1-06 至 C1-09 |
| C1 p91-106 | 八大思想、流水线类比、总结与作业 | C1-10；逐页附录 |
| C2 p1-26 | 运算、寄存器、内存、大小端、补码 | C2-01 至 C2-06 |
| C2 p27-46 | 指令编码、逻辑和移位 | C2-07 至 C2-09 |
| C2 p47-57 | 分支、循环、比较、switch、基本块 | C2-10 至 C2-12 |
| C2 p58-75 | 调用、栈、递归、数据搬运与 ISA 对比 | C2-13、C2-14、C2-18 |
| C2 p76-89 | 字符串、大常数、跳转和寻址 | C2-06、C2-10、C2-11、C2-15 |
| C2 p90-96 | 反汇编、编码表、同步 | C2-09、C2-16 |
| C2 p97-104 | 编译、汇编、链接、装载、JIT | C2-17 |
| C2 p105-113 | swap/sort、数组与指针、清零 | C2-12、C2-14、C2-15 |
| C2 p114-131 | MIPS/x86、扩展、其他指令、误区 | C2-18、E06；逐页附录 |
| C3 p1-16 | 数字表示、加减、溢出 | C3-01、C3-02 |
| C3 p17-30 | 全加器、ALU、比较与零检测 | C3-03、C3-04 |
| C3 p31-46 | 串行进位、CLA、选择进位 | C3-05 |
| C3 p47-66 | 三版乘法器、Booth、乘法指令 | C3-06、C3-07 |
| C3 p67-77 | 两版除法器、有符号除法、除法指令 | C3-08 |
| C3 p78-86 | IEEE 754、范围、精度、特殊值 | C3-09、C3-10 |
| C3 p87-98 | 浮点运算、规格化、GRS、舍入 | C3-11、C3-12 |
| C3 p99-100 | 作业题号与结束页 | 逐页附录 |
| C4 p1-8 | CPU 结构、性能因素、指令子集、执行概览、MUX 与控制 | C4-01、C4-07 |
| C4 p9-13 | 逻辑设计约定、组合/时序元件、边沿触发、时钟方法 | C4-02 |
| C4 p14-20 | 数据通路元件、字段、寄存器表、汇编与编码表 | C4-03、C4-04 |
| C4 p21-31 | 执行步骤、取指、R/访存/分支通路、组装元件 | C4-03、C4-05、C4-06 |
| C4 p32-40 | 中文：取指/译码/执行/访存写回、阶段表、多选器 | C4-06、C4-07 |
| C4 p41-45 | R/I/S/SB/UJ 型数据流与立即数拼接 | C4-05、C4-06 |
| C4 p46-52 | 合并通路与完整数据通路高亮 | C4-10 |
| C4 p53-63 | 控制器：信号表、主控制器、ALU 控制、Verilog 模板 | C4-07、C4-08、C4-09 |
| C4 p64-71 | 带控制的数据通路、五类指令走查、阶段总结 | C4-10、C4-11、C4-12 |

<a id="g05"></a>

## G05 | 考场操作流程与检索策略

Tags: #workflow #exam #trace #查找 #答题流程

**读题 20 秒**：圈出位宽、数据类型、signed/unsigned、单位、PC、寄存器初值、循环边界和所需结果。题目要求“show your work / intermediate steps”，只写结果通常不够；要求“minimum number”，还要考虑边界、溢出和所允许指令。

**定位 20 秒**：用具体词搜，不用“第几章”。机器码搜 `decode`，堆栈搜 `callee`，浮点搜 `bias`，门延迟搜 `CLA`，性能百分比搜 `speedup`。同义词可逐个试，不必把整句题干粘进搜索框。

**演算**：按模板逐步填；单位写全；位操作固定 n 位。程序题画“寄存器→含义”和“地址→内容”两张小表。算法题每一轮记录操作前/操作后状态，不混用两种时序。

**英文落笔**：保留题目的变量名和寄存器名，使用简短句，如 `The byte offset is 8i.`、`The result overflows the signed 8-bit range.`。英文不需要复杂，但每个结论都应给理由。E02 提供现成句式。

**最后检查**：速度比方向；百分比基数；单位；分支相对当前 PC；低位 0 只补一次；load/store 方向；栈是否恢复；余数符号；浮点隐藏 1；舍入是否向偶数；答案是否真在指定位宽内。第 4 章再查：MemtoReg 是否 2 位；写使能是否误写 X；分支目标用 PC 不用 PC+4；立即数只补一次 0；并行路径取 max 不相加；周期取所有指令类的最大值。

<a id="g06"></a>

## G06 | 来源与可信边界

Tags: #references #sources #更正 #参考来源

本套的课程覆盖以以下本地文件为依据：

- [第一章原课件](../lesson/1.Orga_Ch1_V2.4.pdf)：Computer Abstractions and Technology，106 页。
- [第二章原课件](../lesson/1.Orga_Ch2_Risc-v_V1.0-Full.pdf)：Instructions: Language of the Machine，131 页。
- [第三章原课件](../lesson/Orga_Ch3_Rsic-v_v1.1.pdf)：Arithmetic for Computers，100 页。
- [第四章原课件](../lesson/Orga_Ch4_Risc-v_Part1_v1.1.pdf)：The Processor Part 1，71 页。
- [现有逐页翻译与初学者解读](../note/计算机组成_第1至3章逐页翻译与初学者解读.md)：作为独立附录保留，不修改原文件。
- [第四章逐页翻译与解读](../note/ch4_处理器_逐页翻译与解读.md)：并入附录（c4p001-c4p071），已知问题在相应页加注并汇总于 C4-16。

对易混的 ISA / ABI 细节，核对了官方资料。以下网络链接只用于溯源，离线阅读主手册无需打开它们：

- [RISC-V RV32I 官方规范](https://docs.riscv.org/reference/isa/v20260120/unpriv/rv32.html)：基础整数、跳转、分支、立即数。
- [RISC-V RV64I 官方规范](https://docs.riscv.org/reference/isa/v20260120/unpriv/rv64.html)：LUI、LW/LWU、W 指令。
- [RISC-V M 扩展官方规范](https://docs.riscv.org/reference/isa/v20260120/unpriv/m-st-ext.html)：乘除、溢出和除零结果。
- [RISC-V A 扩展官方规范](https://docs.riscv.org/reference/isa/v20260120/unpriv/a-st-ext.html)：LR/SC 语法、成功状态和预留。
- [RISC-V psABI 官方资料](https://riscv-non-isa.github.io/riscv-elf-psabi-doc/)：整数寄存器保存责任与标准栈对齐。

手册中的 Q01 起例题是重新编写或对课件数字重新推演的练习，不是历年试卷；英语问答模板同样不是教师标准答案。优先级是复习建议，未作考频统计。少量明确标“补充”的内容用于说明边界，不据此扩大考试范围。第四章只覆盖已发的 Part 1（单周期）；流水线（Part 2）与第五章缓存未收录。第四章的关键路径延迟数值、故障分析和扩展指令题是配套自编练习，课件本身未给具体延迟数字。


---

# Chapter 1 | Computer Abstractions and Technology

本章解决三件事：计算机有哪些层次；性能该怎样公平比较；硬件为什么受成本、功耗和串行部分限制。考试计算的主线始终是 **执行时间 execution time**。

<a id="c1-01"></a>

## C1-01 | 计算机定义、发展、类别与存储程序

Tags: #C1 #computer #history #stored-program #von-Neumann #历史 #存储程序 #类别

来源：C1 p11-38；C2 p7、p39。

**Computer**：接受输入，按照存储的指令处理数据，并产生输出的可编程电子系统。判断一种设备是否为计算机，应看它是否能执行程序，而不是只看外形、有无屏幕。

**Stored-program concept 存储程序思想**：指令用数字/位串表示，和数据一样可以存入存储器。CPU 从存储器取指、译码并执行。因此编译器、链接器等程序可以处理另一个程序的代码。某一位串是指令还是数据取决于使用方式。

**Von Neumann architecture 冯·诺依曼结构**：通常从运算、控制、存储、输入、输出及存储程序解释。经典模型把指令与数据置于统一存储体系；现代实现可以有分离的指令/数据缓存，仍可对软件呈现统一地址空间。不要把“所有现代 CPU 必须只有一条物理总线”当定义。

| Generation 代际 | 代表技术 | 理解重点 |
|---|---|---|
| First | vacuum tube 电子管 | 体积大、功耗高；ENIAC 为早期代表，历史“第一”要限定类别 |
| Second | transistor 晶体管 | 更小、更可靠、更节能 |
| Third | integrated circuit 集成电路 | 多个器件集成；System/360 强调家族兼容 |
| Fourth | microprocessor 微处理器 | CPU 集成到芯片，推动个人计算 |

课件还介绍 Pascal 机械计算器、Turing machine、ABC、UNIVAC、Dynabook、Xerox Alto、个人电脑和后 PC 时代。图灵机是计算理论模型；不要把模型直接等同于某台电子计算机。设备图片、发布日期和历史争议可按逐页附录查。

| Class 类别 | 主要诉求 | 英文解释抓手 |
|---|---|---|
| Personal/mobile computer | 成本、交互、能耗、续航 | cost, responsiveness, energy efficiency |
| Server | 大量请求、吞吐、可靠性 | throughput, availability, scalability |
| Supercomputer | 大规模高性能计算 | parallel scientific computation |
| Embedded computer | 特定功能、实时、低成本 | dedicated function, real-time constraints |
| Personal mobile device / cloud | 移动端结合远端服务 | mobile clients and shared services |

英文简答：`Instructions are represented as binary numbers and stored in memory. This allows programs to be loaded and manipulated like data.`

<a id="c1-02"></a>

## C1-02 | 五大部件、抽象、ISA 与软硬件层次

Tags: #C1 #ISA #abstraction #datapath #control #五大部件 #软硬件接口

来源：C1 p39-51。

| Component | 中文 | 做什么 |
|---|---|---|
| Input | 输入 | 把外界的信息送入系统 |
| Output | 输出 | 把处理结果提供给外界 |
| Memory | 存储器 | 保存程序和数据 |
| Datapath | 数据通路 | 执行算术逻辑、传送和保存中间数据 |
| Control | 控制器 | 决定数据通路、存储器与 I/O 何时做什么 |

Processor/CPU 通常由 datapath + control 构成。ALU 是数据通路的一部分；CPU 不等于 ALU。主存不等于硬盘；寄存器、cache、DRAM、持久存储在速度、容量、成本与易失性方面不同。

**抽象 abstraction**：在当前层次只暴露必要接口，隐藏实现细节。软件通常不需知道每个逻辑门的连接；硬件依据 ISA 理解机器指令，不直接理解任意 C 代码。

```text
Application / high-level language 高级语言程序
    ↓ compiler 编译器
Assembly 汇编
    ↓ assembler 汇编器
Machine code 机器码  ← ISA 规定软件可见行为
    ↓ execution by implementation
Datapath + control 微体系结构
Logic circuits 逻辑电路
Transistors / physical devices 器件
```

**ISA, instruction set architecture** 是软件与硬件之间的接口约定，规定指令、寄存器、编码、数据访问等软件可见行为。**Microarchitecture 微体系结构** 是实现该接口的具体组织。同一 ISA 可以由不同流水线、时钟、cache、执行单元实现，因此 ISA 相同不保证性能相同。

**ABI, application binary interface** 进一步规定寄存器使用、参数传递、栈、目标文件等软件协作约定。`x1` 作为 `ra`、`x2` 作为 `sp` 是调用约定；`x0` 永为零则是 ISA 定义的行为。

**系统软件**：操作系统管理资源并提供服务；编译器翻译高级语言并进行优化；汇编器生成机器码和相关信息；firmware 固件通常存于非易失存储中提供底层控制。解释器逐步执行一种表示；JIT 在运行时将热点代码编译为本机代码。

**帧缓冲补充**：frame buffer 大小=宽×高×每像素位数÷8。若 1920×1080、24 bit/pixel，则一帧 6,220,800 B，约 6.22 MB 或 5.93 MiB；若每秒刷新 60 次，仅按整帧传送估计约 373.25 MB/s。不要漏除以 8，也不要把实际接口带宽简化为仅此数据量。

英文简答：`The ISA specifies the programmer-visible behavior. Different microarchitectures can implement the same ISA with different performance and power consumption.`

<a id="c1-03"></a>

## C1-03 | IC 制造、良率与成本

Tags: #C1 #IC #wafer #die #yield #defect #cost #晶圆 #良率 #芯片成本

来源：C1 p52-61；公式按 p57 图像核对。

**Wafer 晶圆** 是用于批量制造的圆片；**die 裸片** 是晶圆上切出的单个芯片单位；**defect 缺陷** 可能使裸片失效；**yield 良率** 是可工作裸片占比；封装 package 和测试 testing 在制造链中也有成本。

```text
Dies per wafer ≈ Wafer area / Die area
Yield = 1 / (1 + Defect density × Die area / 2)^2
Cost per good die = Wafer cost / (Dies per wafer × Yield)
```

本式是课件采用的近似模型，忽略边缘损失等因素。D（缺陷/面积）与 A（面积）单位必须相同，使 D×A 无量纲。若 A 用 mm² 而 D 用 /cm²，要换算；1 cm²=100 mm²。

**解题步骤**：①面积单位统一；②计算每片晶圆的 die 数；③计算良率；④有效 die 数=总 die 数×良率；⑤晶圆成本除以有效数量。若要求比值，在相同晶圆条件下 `Cost ∝ A×(1+DA/2)^2`。

**为什么面积增大会非线性涨价？** 一方面同一晶圆可切出的裸片更少；另一方面每个裸片遇到缺陷的概率上升，良率下降。面积翻倍通常不只是成本翻倍。

**技术瓶颈**：memory wall 内存速度相对 CPU 发展的瓶颈；power wall 功耗与散热的限制；继续缩小工艺还面临制造复杂度和成本等限制。课件价格和 SPEC2006 数据是历史案例，不是当前采购数据。

英文答法：`A larger die reduces the number of dies per wafer and also lowers yield. Therefore, the cost per working die grows faster than the die area in this model.`

<a id="c1-04"></a>

## C1-04 | 执行时间、时钟、性能比与百分比

Tags: #C1 #CPU-time #execution-time #clock #speedup #faster #性能 #时钟 #百分比

来源：C1 p63-72。

**Response time / latency 响应时间/延迟**：完成一项任务需多久；**throughput 吞吐率**：单位时间完成多少任务。增加处理器数量可提高总吞吐，不一定让单个串行任务更快。

**Elapsed time / wall-clock time 实际经过时间** 包括 CPU 执行、I/O 等待、调度和其他影响。**CPU time** 是 CPU 为该任务工作的时间，可分 user CPU time 与 system CPU time。比较前应明确用哪种时间。

```text
Performance = 1 / Execution time
Clock period Tc = 1 / Clock rate f
CPU time = Clock cycles × Tc = Clock cycles / f
Speedup of A over B = Performance_A / Performance_B = Time_B / Time_A
```

换算锚点：1 GHz 对应 1 ns；2 GHz 对应 0.5 ns；4 GHz 对应 0.25 ns=250 ps。**GHz × seconds = 10^9 cycles**。

| 说法 | 数学表达 | 旧时间 10 s、新时间 8 s |
|---|---|---|
| speedup | T_old/T_new | 1.25× |
| performance improves by r | (P_new-P_old)/P_old | 25% |
| execution time decreases by r | (T_old-T_new)/T_old | 20% |
| time becomes r of original | T_new/T_old | 80% |

若“performance increases by 50%”，新性能=1.5 倍，新时间=旧时间/1.5。若“execution time decreases by 50%”，时间减半，性能翻倍。这两句话不能混用。

**课件目标频率例**：A 为 2 GHz、10 s → cycles_A=20×10^9。B 要 6 s，但周期数增加 20% → cycles_B=24×10^9 → f_B=4 GHz。不能直接使用频率比 10/6，因为周期数改变了。

**比较例**：相同动态指令数 IC，A：CPI=2、Tc=250 ps；B：CPI=1.2、Tc=500 ps。每指令时间 A=500 ps，B=600 ps，故 A 快 1.2 倍。这里需要相同 IC 这个前提；“相同 ISA”本身不必然保证编译后 IC 相同。

英文答法：`A is 1.2 times as fast as B because T_B/T_A = 600/500 = 1.2.`

<a id="c1-05"></a>

## C1-05 | IC、CPI、指令混合与 CPU 性能方程

Tags: #C1 #CPI #IC #instruction-mix #weighted-average #指令数 #加权平均

来源：C1 p70-77。

```text
CPU time = IC × CPI_avg / f
Cycles = Σ(IC_i × CPI_i)
CPI_avg = Σ(IC_i × CPI_i) / ΣIC_i = Σ(fraction_i × CPI_i)
T_new/T_old = (IC_new/IC_old) × (CPI_new/CPI_old) × (f_old/f_new)
```

IC 是**实际执行的动态指令数 dynamic instruction count**。循环体写了 5 条，执行 100 次就可能贡献约 500 条，不是文件中静态写出的 5 条。分支路径不同也会改变 IC。CPI 是本程序、指令混合和该机器实现共同形成的平均值，可为非整数。

**常见题型 A：按类别算**。类别 CPI 为 1、2、3；序列 1 的 IC 为 2、1、2，总周期 2+2+6=10，IC=5，平均 CPI=2。序列 2 为 4、1、1，总周期=4+2+3=9，IC=6，平均 CPI=1.5。在同一频率下，序列 2 虽指令更多却更快，速度比为 10/9。

**常见题型 B：混合比例改变**。原比例 arithmetic/load/branch=50%/30%/20%，CPI=1/2/3 → 平均 1.7。如果优化减少 load 条数，不能只改 load 的 CPI；应重新算每类动态条数，再更新总 IC 和比例。

**常见题型 C：不同 ISA**。若 A 的 IC=10^9、CPI=2、f=2 GHz → 1 s；B 的 IC=1.5×10^9、CPI=1、f=2 GHz → 0.75 s，B 快 4/3 倍。不要因为 A 指令数少就判 A 更快。

| 因素 | 常见影响来源 | 解题时注意 |
|---|---|---|
| IC | 算法、语言、编译器、ISA、输入 | 同程序源代码不保证 IC 相同 |
| CPI | 指令类别、微体系结构、存储访问 | 换程序或优化后可能改变 |
| clock period | 工艺、组织、设计复杂度 | 更短周期可能付出更多周期数 |

英文答法：`The average CPI is weighted by the dynamic instruction counts, not by the number of instruction classes.`

<a id="c1-06"></a>

## C1-06 | 动态功耗、能量、功耗墙

Tags: #C1 #power #energy #CMOS #voltage #frequency #功耗 #能量 #电压

来源：C1 p78-82、p88。

```text
Dynamic power ∝ α × C × V^2 × f
P_new/P_old = (α_new/α_old) × (C_new/C_old) × (V_new/V_old)^2 × (f_new/f_old)
Energy = Average power × Execution time
```

α 为开关活动因子；如果题目只给 C/V/f 且视其他条件相同，可用 `P∝CV²f`。这是动态功耗模型，未包括全部漏电、静态功耗、外围功耗。Power 单位 W=J/s；energy 单位 J。

**课件例**：C 为原来的 0.85，V 和 f 均降 15%，功耗比=0.85×0.85²×0.85=0.85⁴≈0.5220，功耗降低约 47.80%。不要把“剩余 52.20%”写成“降低 52.20%”。

**降频后的能量**：如果 IC、CPI 不变，执行时间变为 1/0.85 倍，能量比=0.85⁴/0.85=0.85³≈0.6141。只降频、保持电压与每任务周期数不变，在这个纯动态模型下 P 下降而时间延长，动态能量可近似不变；实际还要考虑静态功耗。

**Power wall**：提高频率、器件数量等会增加热和供电负担，电压不能无限降低。单核频率持续提升受到限制，多核和并行成为重要方向；但软件必须有可利用的并行部分。

**Idle** 不是 zero power。低利用率服务器仍可能消耗明显功率。比较能效要看实际负载及总完成工作，不只看空载或峰值。

英文答法：`Voltage has a quadratic effect on dynamic power. Energy also depends on how long the program runs.`

<a id="c1-07"></a>

## C1-07 | Amdahl's Law：局部优化与整体加速

Tags: #C1 #Amdahl #speedup #parallel #fraction #阿姆达尔 #局部加速 #并行

来源：C1 p87；多核解释关联 p82、p95。

设 F 为**优化前总执行时间中**可加速部分的比例，s 为该部分自身速度比；未优化部分不变：

```text
T_new = T_old × [(1-F) + F/s]
Overall speedup S = 1 / [(1-F)+F/s]
S_max = 1/(1-F)       when s → infinity
s_required = F / [1/S_target - (1-F)]
```

**步骤**：①确定 F 的基数是旧时间；②将时间分成未改善和改善两段；③改善段除以局部速度比；④相加得到新时间；⑤旧时间除以新时间。

例：程序 100 s，乘法占 80 s，乘法加快 4 倍 → 新时间=20+80/4=40 s → 整体 2.5 倍。乘法无穷快也仍需 20 s → 上限 5 倍。想“恰好达到 5 倍”需要局部无限快，任何有限 s 都达不到；超过 5 倍更不可能。

**反求的可行性**：分母大于 0 才有有限正 s；等于 0 表示只能趋近；小于 0 表示即使该部分耗时归零也做不到。

**多核理想模型**：串行比例 q=1-F，可并行部分在 N 核理想均分时，`S(N)=1/[q+(1-q)/N]`。真实的通信、同步、负载不均等会增加额外耗时；若题目给这些开销，应加回新时间。

**多个互不重叠部分优化**：`T_new/T_old=F1/s1+F2/s2+(1-F1-F2)`。若优化作用重叠，不能这样简单相加；需要明确每部分受哪些加速影响。

英文答法：`The unaffected part limits the overall speedup. Even if multiplication took no time, the remaining 20 seconds would limit the speedup to 5.`

<a id="c1-08"></a>

## C1-08 | SPEC、几何平均与性能每瓦

Tags: #C1 #SPEC #benchmark #geometric-mean #performance-per-watt #基准 #几何平均

来源：C1 p83-86。这里按课件的历史基准实例解释统计方法，不作最新基准介绍。

**Benchmark 基准程序** 用于测量系统在特定工作负载上的表现。可信比较应控制输入、编译条件、测量方法，并使用能代表目标应用的工作负载。单个程序不能证明所有程序都快。

```text
SPEC ratio_i = Reference execution time_i / Measured execution time_i
Geometric mean = (Π ratio_i)^(1/n)
                   = exp[(Σ ln ratio_i)/n]
```

若比率为 2、8，几何平均是 √16=4，不是算术平均 5。比率大通常表示相对参考机更快。注意有的题把 ratio 定义成反方向，须先读定义。

**为什么几何平均？** 这些是乘法意义上的相对比率，几何平均适合汇总规范化比率。它不等于“完成所有程序的总时间比”；总时间应相加后再比较，而不能把两种评价混用。

**SPECpower** 思路：在不同负载水平测吞吐和功率。整体效率按指定的汇总方法，例如 `Σ throughput / Σ power`，不能默认等于各点 `throughput/power` 的算术平均。单位可能是 operations/s/W。

英文答法：`The geometric mean summarizes normalized performance ratios. It does not directly give the total execution time for a workload mix.`

<a id="c1-09"></a>

## C1-09 | MIPS 与性能比较误区

Tags: #C1 #MIPS #fallacy #pitfall #性能误区 #instructions-per-second

来源：C1 p89-90。

```text
MIPS = IC/(Execution time × 10^6) = Clock rate/(CPI × 10^6)
```

MIPS 在此是 **million instructions per second** 指标；另一个同名的 MIPS 是一种 ISA，二者不同。高 MIPS 可能只是执行了更多更简单的指令，并不代表更快完成相同任务。

| 错误判断 | 为什么不充分 | 应该比较 |
|---|---|---|
| GHz 更高就一定更快 | 周期数、CPI、IC 也变 | 相同任务执行时间 |
| CPI 更小就一定更快 | IC 和周期长度也变 | IC×CPI/f |
| 指令更少一定更快 | 每条耗时可能更长 | 总周期和频率 |
| MIPS 更高一定更快 | ISA 和每条完成工作不同 | 完成目标工作的时间 |
| N 核一定快 N 倍 | 串行与同步限制 | Amdahl 加开销 |
| 优化占比 F 等于指令比例 | 指令类别 CPI 可能不同 | 旧执行时间占比 |

英文答法：`MIPS ignores how much useful work each instruction performs. Execution time for the same task is the more direct performance measure.`

<a id="c1-10"></a>

## C1-10 | 八大设计思想与流水线类比

Tags: #C1 #eight-great-ideas #pipelining #parallelism #prediction #hierarchy #redundancy #八大思想

来源：C1 p91-101。

| Idea | 中文解释 | 可用例子 / 英文表达 |
|---|---|---|
| Design for Moore's Law | 按设计完成时的技术规模规划 | anticipate future technology |
| Use abstraction to simplify design | 分层隐藏细节，降低复杂度 | ISA hides implementation details |
| Make the common case fast | 优先加速常用/占时多的部分 | optimize the frequent case |
| Performance via parallelism | 多个执行者同时工作 | multiple tasks at the same time |
| Performance via pipelining | 不同任务在不同阶段重叠 | overlap stages of different tasks |
| Performance via prediction | 对未来分支等进行预测 | proceed based on a prediction |
| Hierarchy of memories | 用多层结构兼顾速度容量成本 | small and fast near the CPU |
| Dependability via redundancy | 用冗余检测或容忍故障 | redundant components improve dependability |

**Moore's Law** 的课件表述是历史经验趋势，不是 CPU 频率、单线程性能或每一代产品都必须翻倍的物理定律。

**并行 vs 流水**：并行可用多个同类资源同时做任务；流水则让不同阶段重叠。两者都可能提高吞吐，但单个任务经过所有阶段的延迟未必下降。

```text
非流水 n 个任务总时间 = n × Σ stage times
理想同步流水 = [k+(n-1)] × max(stage times)
异步/按实际资源开始时间调度的流水 = 按资源占用画时间线
```

**课件洗衣例**：wash 30 min、dry 40 min、fold 20 min，4 批串行=360 min。按资源独立、允许阶段完成后等待与接续的安排：第 1 批 0-30 洗、30-70 烘、70-90 折；第 2 批 30-60 洗、70-110 烘、110-130 折；第 3 批至 170 完成；第 4 批至 210 完成。故总时间=30+4×40+20=210，速度比=360/210≈1.714。

如果题目要求统一 40 min 时钟槽的同步流水，k=3、n=4 → 6×40=240 min。**210 与 240 是不同调度模型**，不能把不等长阶段硬套一个公式。流水线 CPU、冒险等属于后续章节，此处只解释前三章中的基本思想与类比。

英文答法：`Pipelining improves throughput by overlapping different stages of multiple tasks. The slowest stage limits the steady-state throughput.`


---

# Chapter 2 | Instructions: Language of the Machine

主线：高级语言表达式 → 寄存器操作 → 地址与控制流 → 编码 → 过程调用。以下新写代码默认 RV64，普通指令每条 4 字节，数组类型明确；伪指令会注明。

<a id="c2-01"></a>

## C2-01 | RISC-V 入门与四个设计原则

Tags: #C2 #RISC-V #RV64 #instruction #register #设计原则 #汇编入门

来源：C2 p1-20、p128。

RISC-V 是指令集体系结构，不是某个固定芯片。RV32/RV64 的数字表示整数寄存器宽度 XLEN；常见基本整数寄存器均有 32 个。基础普通指令为 32 位；可选 C 扩展提供 16 位压缩指令，考试没有说明时不要擅自使用。

| Design principle | 中文 | 如何体现在指令中 |
|---|---|---|
| Simplicity favors regularity | 规整有利于简单 | 统一字段、常见三操作数形式 |
| Smaller is faster | 较小通常较快 | 寄存器数量有限，不直接拿巨大内存作所有算术操作数 |
| Make the common case fast | 加速常用情况 | 立即数直接表达常用小常数 |
| Good design demands good compromises | 好设计需要折中 | 固定长度但采用多种格式 |

```asm
add  x5, x6, x7      # x5 = x6 + x7
sub  x5, x6, x7      # x5 = x6 - x7
addi x5, x6, -12     # x5 = x6 - 12
```

顺序是 `operation destination, source1, source2`。`sub` 的顺序不可交换。目标寄存器可以与源相同：`add x5,x5,x6` 先读取旧值，再写 x5。`add x0,...` 丢弃结果，x0 仍为 0。普通算术是寄存器之间的运算；需要内存数据先 load，算完后按需 store。

表达式 `f=(g+h)-(i+j)`：若 f/g/h/i/j 在 s0/s1/s2/s3/s4，先 `add t0,s1,s2`、`add t1,s3,s4`，再 `sub s0,t0,t1`。多个运算不能凭空写成一条三源 `add`。

<a id="c2-02"></a>

## C2-02 | 全部整数寄存器与保存责任

Tags: #C2 #ABI #register #caller-saved #callee-saved #ra #sp #寄存器表

来源：C2 p11、p58-74、p88；标准 ABI 边界见 G06。

| Number | ABI name | 作用 | 跨普通函数调用应否保持旧值 |
|---|---|---|---|
| x0 | zero | 常数零 | 不可修改 |
| x1 | ra | return address 返回地址 | caller-saved；非叶函数常自行保存返回地址 |
| x2 | sp | stack pointer 栈指针 | 返回时必须恢复 |
| x3 | gp | global pointer | 标准 ABI 不作普通临时寄存器使用 |
| x4 | tp | thread pointer | 标准 ABI 不作普通临时寄存器使用 |
| x5-x7 | t0-t2 | temporary | 否，调用者需要旧值就保存 |
| x8 | s0/fp | saved / optional frame pointer | 是，被调用者修改就保存恢复 |
| x9 | s1 | saved | 是 |
| x10-x11 | a0-a1 | arguments / return values | 否；常用于前两个返回寄存器 |
| x12-x17 | a2-a7 | arguments | 否 |
| x18-x27 | s2-s11 | saved | 是 |
| x28-x31 | t3-t6 | temporary | 否 |

“saved”不表示硬件自动存栈。谁修改、谁按调用约定承担责任：callee 修改 s 寄存器要恢复给 caller；caller 需要某 t/a 旧值跨调用存活，就自己保存它。`ra` 被下一条 `jal ra,...` 覆盖，因此非叶函数返回上层之前通常必须先保存自身入口的 ra。

逐个映射：s2=x18、s3=x19、s4=x20、s5=x21、s6=x22、s7=x23、s8=x24、s9=x25、s10=x26、s11=x27；a0=x10，a7=x17。机器编码填的是 5 位寄存器编号，不能直接把字母名字写入字段。

英文：`A callee must restore any callee-saved registers that it modifies. A caller must save caller-saved values that are still needed after the call.`

<a id="c2-03"></a>

## C2-03 | 内存、数组、有效地址与 load/store

Tags: #C2 #memory #array #pointer #load #store #effective-address #数组 #字节偏移

来源：C2 p13-20、p72-74、p111-113。

```text
Effective address EA = value in base register + sign-extended byte offset
Address of A[i] = Base(A) + i × element size in bytes
```

```asm
ld t0, 24(s1)       # 从地址 s1+24 读取连续8字节，组成一个64位值写入t0
sd t0, 40(s1)       # 把t0的64位值写到地址s1+40开始的8字节
lw t1, -4(sp)       # 取4字节并符号扩展到RV64寄存器
sw t1, 12(s1)       # 只写低32位；不改变t1
```

**数据和地址分开**：s1=1000、Memory64[1024]=7，执行 `ld t0,24(s1)` 后 t0=7，既不是 1024，也不是 1007。`addi t0,s1,24` 才是把地址 1024 算入 t0。load 不改变 base；store 的第一个寄存器是数据源，不是目标。

| Element | 大小 | 下标→字节偏移 | 访问 |
|---|---|---|---|
| char / uint8_t | 1 B | i | lb/lbu、sb |
| int16_t | 2 B | i<<1 | lh、sh |
| int32_t | 4 B | i<<2 | lw、sw |
| int64_t | 8 B | i<<3 | ld、sd |
| double 数值位模式 | 8 B | i<<3 | 浮点指令另有 fld/fsd；整数 ld/sd 可搬位串 |

**例：A[12]=h+A[8]，int64_t，A 在 s1，h 在 s2**：

```asm
ld   t0, 64(s1)     # 8*8
add  t0, s2, t0
sd   t0, 96(s1)     # 12*8
```

**变量下标 A[i]**，i 在 s2：

```asm
slli t0, s2, 3
add  t0, s1, t0
ld   t1, 0(t0)
```

如果所需偏移超出 -2048…2047，要先构造地址，不能把任意大数字塞进 load/store。地址可用 XLEN 位寄存器计算；具体可用虚拟地址范围是环境问题，不应由“64 位寄存器”推成所有 2^64 字节均实现。

<a id="c2-04"></a>

## C2-04 | 字节序、对齐、结构体布局

Tags: #C2 #endianness #little-endian #big-endian #alignment #padding #大小端 #对齐

来源：C2 p14-15。

假设在地址 0x1000 存 32 位 `0x12345678`：

| 地址 | Little-endian 小端 | Big-endian 大端 |
|---|---|---|
| 0x1000 | 78，最低有效字节 | 12，最高有效字节 |
| 0x1001 | 56 | 34 |
| 0x1002 | 34 | 56 |
| 0x1003 | 12 | 78 |

小端是 **least significant byte at the lowest address**。字节序影响多个字节如何组合成一个数，不会把每个字节内部的 bit 顺序反转；也不会改变寄存器里数值的数学大小。0x78 不应写成位反转的 0x1E。

**Natural alignment 自然对齐**：n 字节对象地址通常应为 n 的倍数。8 字节对象地址末 3 个二进制位为 0，4 字节对象末 2 位为 0。RISC-V 环境对非对齐数据访问可能支持、较慢或触发异常，不能无条件断言任何实现必然陷阱。

**结构体题模板**：给定每字段大小与对齐要求，从偏移 0 顺序摆放；字段开始处向上取整到其对齐边界；最后结构体总大小向上取整为最大成员对齐的倍数。题目若使用 packed 或自定规则则另算。

```c
struct Example { int32_t a; char b; char c[2]; int64_t d; };
```

通常布局：a 在 0-3；b 在 4；c 在 5-6；7 为 padding；d 在 8-15；总大小 16，对齐 8。数组每个元素的 stride 是整个结构体大小，包含 padding。

<a id="c2-05"></a>

## C2-05 | 无符号、补码、取负与扩展

Tags: #C2 #signed #unsigned #two-complement #sign-extension #zero-extension #补码

来源：C2 p21-26；C3 p4-11。

```text
Unsigned = Σ b_i 2^i                              range 0 … 2^n-1
Signed two's complement = -b_(n-1)2^(n-1)+Σ_(i=0..n-2)b_i2^i
Signed range = -2^(n-1) … 2^(n-1)-1
If MSB=1: signed value = unsigned value - 2^n
Negation in n bits: ~x + 1, keep only n bits
```

8 位 `1111 1010`：unsigned=250，signed=250-256=-6。`0000 0110` 取反 `1111 1001` 再加 1 → `1111 1010`。最小负数 `1000 0000`=-128，取负仍为同一位串，因为 +128 不在 8 位 signed 范围内。

**Sign extension 符号扩展**：高位复制原符号位，以保持补码有符号值。8 位 0xFA → 16 位 0xFFFA → RV64 `0xFFFFFFFFFFFFFFFA`。**Zero extension 零扩展**：高位补 0，保持无符号值；0xFA → 0x00FA。截断 truncation 只保留低位，可能改变原值。

**立即数逻辑也符号扩展**：`andi t0,t1,255` 保留低 8 位；`xori t0,t1,-1` 逐位取反全部 XLEN 位。12 位字段 `0xFFF` 表示 -1，不是 +4095。`sltiu` 的立即数也先按 12 位符号扩展，再按无符号数比较。

<a id="c2-06"></a>

## C2-06 | 数据搬运总表与 RV64 W 操作

Tags: #C2 #lb #lbu #lw #lwu #ld #sw #addw #load-width #符号扩展 #W

来源：C2 p73、p77、p123。

| 指令 | 访问字节数 | RV64 写入 rd 的结果 | 格式/funct3 |
|---|---|---|---|
| lb | 1 | 8 位符号扩展到 64 位 | I / 000 |
| lh | 2 | 16 位符号扩展 | I / 001 |
| lw | 4 | 32 位符号扩展 | I / 010 |
| ld | 8 | 完整 64 位 | I / 011 |
| lbu | 1 | 8 位零扩展 | I / 100 |
| lhu | 2 | 16 位零扩展 | I / 101 |
| lwu | 4 | 32 位零扩展，仅 RV64 | I / 110 |
| sb / sh / sw / sd | 1 / 2 / 4 / 8 | 只写 rs2 低 8/16/32/64 位，不扩展、不写 rd | S / 000 / 001 / 010 / 011 |

例如内存 32 位模式为 `0x80000001`，lw 得 `0xFFFFFFFF80000001`，lwu 得 `0x0000000080000001`。如果目的只为取低 32 位后 sw 回内存，两者低位相同；但后续 64 位算术、比较等可能不同。

**W suffix**：RV64 中 addw/subw/addiw、sllw/srlw/sraw 及其立即数版以低 32 位参与相应操作，再将 32 位结果**符号扩展**成 64 位。`addiw rd,rs,0` 是常见 32 位符号扩展方法。无符号右移 `srlw` 最后同样符号扩展其 32 位结果，不等于整个 64 位寄存器做逻辑右移。32 位 W 移位量取低 5 位；普通 RV64 寄存器移位量取低 6 位。

<a id="c2-07"></a>

## C2-07 | 逻辑、掩码、移位与比较置位

Tags: #C2 #AND #OR #XOR #mask #slli #srli #srai #slt #位操作 #移位

来源：C2 p40-46、p51-53。

| 指令 | 语义 | 常见用途 |
|---|---|---|
| and / andi | 每位同时为 1 才为 1 | mask 掩码、保留指定位置 |
| or / ori | 任一为 1 即为 1 | set bits 置位 |
| xor / xori | 两位不同为 1 | flip bits 翻转、判断差异 |
| sll / slli | 左移，低位补 0，高位丢弃 | 乘 2^k、计算地址偏移 |
| srl / srli | 逻辑右移，高位补 0 | unsigned 除 2^k、提取字段 |
| sra / srai | 算术右移，高位补符号 | 保持负数符号，但与向零除法有差别 |
| slt / slti | signed 小于则写 1，否则 0 | 比较得到布尔值 |
| sltu / sltiu | unsigned 小于则写 1 | 无符号比较与边界 |

**位编号**：最右为 bit0。掩码 `1<<k` 对应 bit k。清 bit k：`x & ~(1<<k)`；置 bit k：`x | (1<<k)`；翻转：`x ^ (1<<k)`；提取 b…a（b≥a）：`(x>>a)&(2^(b-a+1)-1)`。立即数掩码超出可编码范围时先放入寄存器。

**例**：提取 x 的 bit15:8 到 t0：`srli t0,x,8` 后 `andi t0,t0,255`。将 t1 的低 8 位插入 bit15:8，先清目标字段，再掩码、左移并 OR；不能只 OR，因为原字段中的 1 可能需要清掉。

**负数算术右移陷阱**：以固定 8 位解释 -7 为 `11111001`，算术右移 1 得 `11111100`=-4；signed `div -7,2` 向零得 -3。srai 常对应向负无穷取整，不普遍等于 signed 除法。RV64 `srli` 对负数则可能产生很大的正数。

`slt t0,t1,t2` 不跳转，只把 0/1 写入 t0；`blt t1,t2,L` 才改变控制流。同一位串全 1 对 signed 是 -1，对 unsigned 是最大值；`blt -1,1` 成立，`bltu` 不成立。

<a id="c2-08"></a>

## C2-08 | 六类 32 位指令格式与字段位置

Tags: #C2 #encoding #R-type #I-type #S-type #B-type #U-type #J-type #机器码 #格式

来源：C2 p27-38、p80-93。课件 SB=这里的 B，UJ=这里的 J。

```text
bit      31          25 24     20 19     15 14  12 11      7 6       0
R        funct7         rs2       rs1      funct3   rd       opcode
I        imm[11:0]               rs1      funct3   rd       opcode
S        imm[11:5]      rs2       rs1      funct3 imm[4:0]   opcode
B        imm[12|10:5]   rs2       rs1      funct3 imm[4:1|11] opcode
U        imm[31:12]                               rd       opcode
J        imm[20|10:1|11|19:12]                     rd       opcode
```

R 字段位数：7+5+5+3+5+7=32。I：12+5+3+5+7=32。B/J 的碎片顺序必须记位置，不是把位串按数学顺序从左排到底。

| 操作类 | opcode binary | hex | 形式 |
|---|---|---|---|
| register-register ALU | 0110011 | 0x33 | R |
| immediate ALU | 0010011 | 0x13 | I |
| loads | 0000011 | 0x03 | I |
| stores | 0100011 | 0x23 | S |
| conditional branches | 1100011 | 0x63 | B |
| jalr | 1100111 | 0x67 | I |
| jal | 1101111 | 0x6F | J |
| lui | 0110111 | 0x37 | U |
| auipc | 0010111 | 0x17 | U |
| RV64 register W ALU | 0111011 | 0x3B | R |
| RV64 immediate W ALU | 0011011 | 0x1B | I |

| R 指令 | funct3 | funct7 |
|---|---|---|
| add / sub | 000 | 0000000 / 0100000 |
| sll | 001 | 0000000 |
| slt / sltu | 010 / 011 | 0000000 |
| xor | 100 | 0000000 |
| srl / sra | 101 | 0000000 / 0100000 |
| or / and | 110 / 111 | 0000000 |
| mul / mulh / mulhsu / mulhu | 000 / 001 / 010 / 011 | 0000001 |
| div / divu / rem / remu | 100 / 101 / 110 / 111 | 0000001 |

普通 I 算术：addi/slti/sltiu/xori/ori/andi 的 funct3=000/010/011/100/110/111。移位立即数：slli=001；srli/srai=101。RV64 shamt 有 6 位，inst[31:26] 为 000000 或（srai）010000；RV32 shamt 有 5 位，inst[31:25] 为 0000000 或 0100000。不要在 RV64 中把全部 inst[31:25] 都当固定 funct7，否则会错过 shamt[5]。

B 的 funct3：beq 000、bne 001、blt 100、bge 101、bltu 110、bgeu 111。所有这些 B 指令 opcode 都是 **0x63**，不是 jalr 的 0x67。

<a id="c2-09"></a>

## C2-09 | 编码、解码的通用步骤与现成例子

Tags: #C2 #encode #decode #disassemble #hex #机器码 #反汇编

来源：C2 p28-38、p90-93。

**汇编→机器码**：①确认 ISA/位宽、真实指令而非伪指令；②选格式与 opcode/funct；③ABI 名换寄存器编号；④计算立即数的固定位宽补码；⑤按 inst 位位置摆入；⑥每 4 bit 分组转十六进制；⑦反向解码核查。

```text
R: word=(funct7<<25)|(rs2<<20)|(rs1<<15)|(funct3<<12)|(rd<<7)|opcode
I: word=((imm & 0xFFF)<<20)|(rs1<<15)|(funct3<<12)|(rd<<7)|opcode
S: word=((imm>>5 & 0x7F)<<25)|(rs2<<20)|(rs1<<15)|(funct3<<12)
        |((imm & 0x1F)<<7)|opcode
```

**例 1** `add x9,x20,x21`：字段 `0000000 10101 10100 000 01001 0110011` → `0x015A04B3`。rd 是 x9，不是第一个源寄存器 x20。

**例 2** `addi x5,x6,-12`：12 位补码为 `0xFF4`，结果 `0xFF430293`。负立即数不需要将整个指令按有符号数再取负，只转换相应立即数字段。

**例 3** `sd x5,24(x6)`：S 型 imm=24；高 7 位为 0、低 5 位 11000，结果 `0x00533C23`。S 没有 rd；inst[11:7] 是立即数片段。

**机器码→汇编**：①32 位填满；②取 `opcode=word&0x7F`；③选择格式；④提取 rd/rs1/rs2/funct；⑤重拼立即数后，按该格式总位宽符号解释；⑥写汇编，必要时算目标地址。

```text
rd     = (word>>7)&31
funct3 = (word>>12)&7
rs1    = (word>>15)&31
rs2    = (word>>20)&31
funct7 = (word>>25)&127
SignExtend(v,n) = v if v < 2^(n-1), else v-2^n
```

**例 4** `0x00578833`：opcode 0x33，rd=16，rs1=15，rs2=5，funct3=000、funct7=0 → `add x16,x15,x5`，也可写 `add a6,a5,t0`。

**十六进制与内存顺序分开**：指令字 `0x00578833` 若按小端存放在四个连续地址中，字节顺序为 `33 88 57 00`，不是把机器指令数值写成 `0x33885700` 后再按常规字段解码。若题目给字节转储，应先按字节序还原 32 位指令字。

<a id="c2-10"></a>

## C2-10 | 分支、跳转、PC 相对偏移与范围

Tags: #C2 #branch #jump #PC-relative #offset #jal #jalr #分支偏移 #目标地址

来源：C2 p47-59、p83-89。

| 指令 | 条件 / 更新 | 要点 |
|---|---|---|
| beq / bne rs1,rs2,L | 相等 / 不等跳转 | 按位值相等，无 signed 区别 |
| blt / bge | signed < / ≥ | 有符号 |
| bltu / bgeu | unsigned < / ≥ | 无符号 |
| jal rd,L | rd=旧PC+4；PC=旧PC+offset | PC 相对直接跳转 |
| jalr rd,imm(rs1) | rd=旧PC+4；PC=(旧rs1+sext(imm)) & ~1 | 寄存器间接跳转，清目标 bit0 |

普通顺序执行下一条 PC=当前 PC+4。B/J 的目标相对**当前分支/跳转指令地址**，不是 PC+4。`jalr` 的偏移按字节，**不左移一位**；旧 rs1 先取值，rd 与 rs1 同名时也不能先覆盖源。

```text
B byte_offset = SignExtend({inst[31],inst[7],inst[30:25],inst[11:8],0},13)
J byte_offset = SignExtend({inst[31],inst[19:12],inst[20],inst[30:21],0},21)
Target = PC + byte_offset
```

大括号表示按顺序拼接位串。B 是 13 位含最低 0，范围 -4096…+4094 B；J 是 21 位含最低 0，范围 -1048576…+1048574 B。范围的步长为 2；若没有压缩扩展，还需满足指令地址 4 字节对齐。可编码不代表任何 2 字节对齐目标在基础 ISA 下都合法。

**位名两种说法**：若题目称“12 位 encoded immediate”，偏移可能指省略低位后的半字单位数，需乘 2；若已经给出完整 13 位 byte offset，不再乘 2。最稳妥是先算字节差 D，再直接提取 D 的 imm[12:1]。

```text
B encode: ((D>>12&1)<<31)|((D>>5&63)<<25)|(rs2<<20)|(rs1<<15)
          |(funct3<<12)|((D>>1&15)<<8)|((D>>11&1)<<7)|0x63
J encode: ((D>>20&1)<<31)|((D>>1&1023)<<21)|((D>>11&1)<<20)
          |((D>>12&255)<<12)|(rd<<7)|0x6F
```

**课件循环**：bne 位于十进制 80012，Exit=80024 → D=+12，半字数=6，机器码 `0x01849663`（bne x9,x24,Exit）。回跳 beq 位于 80020，Loop=80000 → D=-20，半字数=-10 → `0xFE0006E3`（beq x0,x0,Loop）。不能把半字数直接当完整 D 再编码。

**远条件分支**：如果原 `beq t0,t1,Far` 超出 B 范围，反转条件跳过 `jal x0,Far`：

```asm
bne t0, t1, Skip
jal x0, Far             # Far 仍须在J范围内
Skip:
```

更远目标可由 auipc/lui 与 jalr 等配合生成；符号地址的重定位通常交给汇编器/链接器。`j L` 是 `jal x0,L` 的伪指令；`ret` 是 `jalr x0,0(ra)`；`jal ra,func` 为常用调用。

<a id="c2-11"></a>

## C2-11 | 大立即数、LUI/AUIPC 与寻址方式

Tags: #C2 #lui #auipc #constant #immediate #addressing #4000000 #大常数

来源：C2 p80-89、p123；RV64 边界由官方 RV64I 核对。

普通 `addi` 不能表示 +2304。课件装载 4,000,000=`0x003D0900` 时，低 12 位 0x900 的 signed 值为 -1792，故高位必须进一：

```asm
lui  s3, 977            # 977 = 0x3D1; s3 = 0x003D1000
addi s3, s3, -1792      # 0x003D1000 - 0x700 = 0x003D0900
```

不能写 `addi s3,s3,2304` 作为合法普通 addi；仅把高位改为 977 也不够，还必须更正带符号低段。

**拆分公式（RV32 / 可直接表示的 RV64 情况）**：`lo = sign_extend(C & 0xFFF,12)`，`hi = (C-lo)>>12`，常写 `hi=(C+0x800)>>12`。验证 `(hi<<12)+lo=C`，然后检查各字段范围。

**RV64 重要边界**：lui 将所构造 32 位结果符号扩展到 64 位。为形成任意 32 位模式的**符号扩展值**，可配合 `addiw`，让最后一步对低 32 位取值并符号扩展。例如 `0x7FFFFFFF`：`lui t0,0x80000` 后 `addiw t0,t0,-1` → 正 2147483647；如果改为普通 addi，可能保留错误高 32 位。若需无符号 32 位值先符号扩展，再 `slli 32; srli 32` 零扩展。任意 64 位常数通常需要更多指令；`li` 是交给汇编器展开的伪指令，不保证一条。

**LUI**：load upper immediate，将 U 字段放入 bit31:12，低 12 位置零；RV64 再符号扩展。**AUIPC**：add upper immediate to PC，向当前 PC 加上构造的带符号偏移，常配合 load 或 jalr 用于 PC 相对寻址。两者不从内存读取值，名字含 load 不等于 load memory。

| Addressing mode | 中文 | 例子 |
|---|---|---|
| Register | 寄存器寻址 | add t0,t1,t2 |
| Immediate | 立即数寻址 | addi t0,t1,10 |
| Base / displacement | 基址+偏移 | ld t0,24(s0) |
| PC-relative | PC 相对 | beq、jal、auipc |

<a id="c2-12"></a>

## C2-12 | if、while、for、switch 与基本块

Tags: #C2 #if #while #for #switch #basic-block #control-flow #循环 #条件

来源：C2 p47-57、p85-86、p105-113。

**if-else 模板**：`if(i==j) f=g+h; else f=g-h;`，i/j 在 s3/s4，f/g/h 在 s0/s1/s2：

```asm
bne s3, s4, Else
add s0, s1, s2
jal x0, Done
Else:
sub s0, s1, s2
Done:
```

第一条通常按条件的**反面**跳过 then。then 结束后必须跳过 else，否则两个分支都会执行。

**while 模板**：`while(save[i]==k) i++;`，save 为 int64_t，base=s1、i=s2、k=s3：

```asm
Loop:
slli t0, s2, 3
add  t0, s1, t0
ld   t1, 0(t0)
bne  t1, s3, Exit
addi s2, s2, 1
jal  x0, Loop
Exit:
```

此例假定数组访问均有效；实际程序必须有边界条件。while 可能执行 0 次；do-while 至少 1 次。编译时不能把 while 偷换成先执行再测试。

**for 清零**：int32_t A，base=a0、signed count=a1。

```asm
addi t0, x0, 0         # i=0
bge  t0, a1, Done     # size<=0 时直接结束
Loop:
slli t1, t0, 2         # sizeof(int32_t)=4
add  t2, a0, t1
sw   x0, 0(t2)
addi t0, t0, 1
blt  t0, a1, Loop
Done:
```

若 A 为 int64_t，改为 shift 3 / sd。不能保持 `int[]` 同时用 stride8 和 sd。按上述代码，N>0 时动态指令数=2+5N（标签不计指令）；注意机器执行次数与源代码静态条数不同。

**短路**：`j>=0 && v[j]>v[j+1]` 先检查 j，若 j<0 就必须跳出，不能先用负下标读内存。`A || B` 中 A 真可直接进入真分支，不一定计算 B。

**switch / jump table**：先检查 case 范围，再把索引乘**表项大小**，读出目标地址，再 jalr。RV64 地址表若每项是 64 位地址就 stride8；表项为相对 32 位偏移则是另一种布局，不能一概都用 8。

```asm
# 补充示意：case 0..3，t0为索引，s0为64位目标地址表首地址
sltiu t1, t0, 4        # unsigned比较也把负索引排除
beq   t1, x0, Default
slli  t1, t0, 3
add   t1, s0, t1
ld    t2, 0(t1)
jalr  x0, 0(t2)
```

**Basic block 基本块**：一段直线执行的指令序列，入口在开始，中途无分支目标，除结尾外无控制转移。构建时把入口、分支目标、控制转移后的下一条作为 leader；再分段。不要只按 C 源代码的花括号划分。

<a id="c2-13"></a>

## C2-13 | 函数调用、栈帧、leaf 与 non-leaf

Tags: #C2 #procedure #call #stack #leaf #non-leaf #prologue #epilogue #函数 #栈

来源：C2 p58-74。

**调用的逻辑步骤**：传参数；转移控制；必要时分配栈和保存寄存器；执行；准备返回值；恢复状态并返回。参数常先放 a0-a7，简单整数结果常在 a0。复杂参数与返回对象按具体 ABI，不在这里假设所有返回值只用 a0。

**Stack grows downward 栈向低地址增长**：分配 N B 用 `addi sp,sp,-N`，释放用 `addi sp,sp,N`。先分配再 store，返回前先 load 旧值再释放。RV64 保存一个寄存器常用 8 B，但标准栈帧总体应保持 16 B 对齐。

**Leaf procedure 叶函数** 不调用其他函数；如仅用 a/t 寄存器且不需栈，可直接返回。不是所有叶函数都不需要栈，也不是所有函数都必须保存 ra。

```asm
# int64_t sum2(int64_t x, int64_t y)
# a0=x,a1=y; return a0
sum2:
add  a0, a0, a1
jalr x0, 0(ra)
```

**非叶函数模板**：`g(x)=f(x)+x`，假定 x 为 int64_t：

```asm
g:
addi sp, sp, -16
sd   ra, 8(sp)
sd   s0, 0(sp)
addi s0, a0, 0          # 保留x；s0的原值也已保存
jal  ra, f              # a0变为f(x)，a/t寄存器均可能改变
add  a0, a0, s0
ld   s0, 0(sp)
ld   ra, 8(sp)
addi sp, sp, 16
jalr x0, 0(ra)
```

不能把 x 放 t0 然后调用 f，再默认 t0 仍是 x；它是 caller-saved。也不能把 x 放 s0 却不保存入口旧 s0，否则破坏上层调用者的状态。

**栈图**：若初始 sp=0x1000，分配 16 后 sp=0x0FF0；`0(sp)` 在 0x0FF0，`8(sp)` 在 0x0FF8。恢复必须从相同地址读。sp 自身的数值与内存位置里的内容不同。

**内存布局概念**：text/code 是指令；static data 保存全局/静态对象；heap 由动态分配管理；stack 用于调用与自动对象。课件堆向上栈向下是典型示意，不是所有运行时的绝对物理布局。函数返回后，局部栈对象生存期结束，返回其地址会形成悬空指针 dangling pointer。

<a id="c2-14"></a>

## C2-14 | 递归、swap/sort 与调用追踪

Tags: #C2 #recursive #factorial #swap #sort #trace #递归 #排序

来源：C2 p64-68、p105-110。以下 factorial 是新写的 RV64 对照示例，假设 n 为非负、且 n! 在 int64_t 范围内；使用 M 扩展 mul。

```asm
fact:
addi sp, sp, -16
sd   ra, 8(sp)
sd   a0, 0(sp)          # 保存本层n
addi t0, x0, 2
blt  a0, t0, Base
addi a0, a0, -1
jal  ra, fact
ld   t0, 0(sp)          # 递归返回后重新读取n
mul  a0, a0, t0
jal  x0, End
Base:
addi a0, x0, 1
End:
ld   ra, 8(sp)
addi sp, sp, 16
jalr x0, 0(ra)
```

fact(3) 的活动层 n=3、2、1，总计 3 帧×16=48 B。若入口 sp=S，最深 sp=S-48。回溯结果：fact(1)=1 → fact(2)=2 → fact(3)=6。每层保存自己的 ra 和 n；栈帧不能共享同一存储位置。若改成基例 n=0、每层均分配栈，则 fact(3) 有 4 帧，不能不看代码直接套“n 帧”。

**swap 模板**：`swap(int64_t v[], int64_t k)`，a0=base、a1=k，交换 v[k] 与 v[k+1]：

```asm
swap:
slli t0, a1, 3
add  t0, a0, t0
ld   t1, 0(t0)
ld   t2, 8(t0)
sd   t2, 0(t0)
sd   t1, 8(t0)
jalr x0, 0(ra)
```

此例只用 caller-saved 临时寄存器，是叶函数，无需为这些临时量保存旧值。int32_t 版则 shift2、lw/sw、相邻偏移4。

**sort 读代码的顺序**：①分辨 i 与 j；②外层 i 从 1 到 n-1；③内层先判断 j>=0；④比较 v[j] 和 v[j+1]；⑤调用 swap 前布置 a0/a1；⑥调用后 i/j/base/count 等活跃值需仍可恢复；⑦内层 j--；⑧外层 i++；⑨函数末恢复所有用到的 s 寄存器、ra、sp。

不用死背整段排序机器码。先从 C 代码写控制流，再为长期活跃变量选 s 寄存器或栈槽；a0/a1 作为传参可能被覆盖，不适合未经保存就长期存放外层状态。

<a id="c2-15"></a>

## C2-15 | 字符、字符串与数组/指针优化

Tags: #C2 #ASCII #Unicode #UTF-8 #string #strcpy #pointer #字符 #字符串

来源：C2 p76-79、p111-113。

**ASCII** 使用 7 位编码，128 个码位；放入一个字节时高位常为 0。字符 `'0'` 的码为 48（0x30），不是数值 0；`'A'=65`，`'a'=97`。C 字符串以 NUL byte `0x00` 结束；不是字符 `'0'`、空格或换行。

**Unicode 与 UTF**：Unicode 定义字符码位；UTF-8/UTF-16 是编码方式。UTF-8 一个码位可占 1-4 字节，ASCII 部分保持单字节；不能把“一个字符”总当一字节，也不能把 Unicode 一概当固定 32 位存储。课件中的简化说法需结合这一区别理解。

**字符串复制**，a0=dest、a1=src，源目标容量合法、不重叠；逐字节拷贝，包括终止符。保留 a0 作为返回的原 dest：

```asm
copy:
addi t2, a0, 0
Loop:
lbu  t0, 0(a1)
sb   t0, 0(t2)
beq  t0, x0, Done
addi a1, a1, 1
addi t2, t2, 1
jal  x0, Loop
Done:
jalr x0, 0(ra)
```

先写入再判断，才能把 `\0` 也复制到目标。lbu 将普通字节解释为非负数，字符判断与二进制数据处理更直观；对“是否为零”的判断而言 lb/lbu 都能检测零，但扩展后的其他值不同。

**指针法清零**：int32_t，a0=base、a1=size，size 为 signed，先处理 <=0：

```asm
bge  x0, a1, Done
slli t0, a1, 2
add  t1, a0, t0         # end=base+4*size
addi t2, a0, 0         # p=base
Loop:
sw   x0, 0(t2)
addi t2, t2, 4
bltu t2, t1, Loop
Done:
```

相比每轮由 i 计算 4i 的形式，指针直接每轮加 4，可减少动态指令；编译器也可做 **strength reduction 强度削减** 和 **induction variable elimination 归纳变量消除**，因此“指针源码一定比数组源码快”不成立。性能仍要看最终机器码与实际时间。

<a id="c2-16"></a>

## C2-16 | 同步、原子性、LR/SC 和锁

Tags: #C2 #synchronization #atomic #LR-SC #lock #reservation #同步 #原子

来源：C2 p94-96；标准语法按官方 A 扩展核对。A 扩展是可选扩展，不属于单独 RV64I 的全部基础整数功能。

**Race condition 竞争**：两个线程各自 load、加 1、store，可能都从旧值 0 算到 1，最后值仍为 1，丢失一次更新。某条 load 与某条 store 各自合法，不代表中间整段读改写原子。

```asm
# 原子交换的教学循环：a0=地址，a1=要写入的新值，返回a0=旧值
again:
lr.d t0, (a0)
sc.d t1, a1, (a0)       # 标准顺序 rd, rs2, (rs1)
bne  t1, x0, again
addi a0, t0, 0
```

LR 读取并建立 reservation 预留；SC 尝试条件存储，将**成功状态 0** 或失败非零写入 rd。SC 的 rd 是状态，不是旧内存值。失败时不执行该次内存写入，需重新 LR 后重试。即使没有明显的其他线程写入也不能假定 SC 必定成功；预留可能因其他原因失效。

课件“未改变则成功”是帮助理解竞争的简化说法；精确定义按 reservation set 和平台规则。课件 sc.d 的操作数顺序与标准汇编顺序不同，本文统一使用标准 `sc.d rd,rs2,(rs1)`。

**锁的概念**：先读锁值，非零则重试；为零时尝试 SC 写 1；SC 失败重试；退出临界区后释放锁。若写成可用于真实多线程的锁，还需要正确的 acquire/release 排序，例如 LR 的 `.aq`、SC 的 `.rl` 或合适的 fence / 原子指令。课件只讲原子更新时，不能把它的裸循环直接等同于完整并发库实现。

英文：`The store-conditional writes zero to its destination register on success. A nonzero status causes the operation to retry.`

<a id="c2-17"></a>

## C2-17 | 编译、汇编、链接、装载、动态链接、JIT

Tags: #C2 #compiler #assembler #linker #loader #relocation #symbol #JIT #编译链接

来源：C2 p97-104。

```text
Source code → Compiler → Assembly → Assembler → Object modules
Object modules + libraries → Linker → Executable → Loader → Running program
```

| Tool / concept | 职责 | 题干出现什么词可识别 |
|---|---|---|
| Compiler | 高级语言翻译、优化、寄存器分配等 | source language, optimization |
| Assembler | 把真实汇编指令编码，生成目标模块 | assembly, machine code, object file |
| Symbol table | 记录符号名、定义/引用与位置等 | external symbol, function name |
| Relocation information | 记录地址未定时需要修补的位置与方式 | address-dependent reference |
| Linker | 合并模块、解析符号、布局并处理重定位 | resolve references, combine modules |
| Loader | 建立程序内存映像并转交执行 | load executable, initialize process |
| Dynamic linking | 运行或装载时连接共享库 | shared library, runtime resolution |
| Lazy binding | 首次使用时解析目标，后续复用 | first call, resolve on demand |
| Interpreter | 按某中间表示逐步执行 | bytecode execution |
| JIT compiler | 运行时编译热点为本机代码 | hot methods, native code at runtime |

目标模块常含 header、text、static data、relocation、symbol table、debug info。目标文件中的未定地址不是程序必然错误，可能等待链接时解析；但最终仍缺少定义会出现 unresolved symbol。

**链接题模板**：先确定每个模块代码/数据段在最终映像中的基址；局部偏移加段基址；通过符号表找外部引用定义；再按相应重定位类型修补。不要把所有地址字段一律“加同一个常数”，PC 相对与绝对地址的处理可能不同。

英文：`The linker resolves external symbols and relocates address-dependent references. The loader places the executable into the process address space and transfers control to the entry point.`

<a id="c2-18"></a>

## C2-18 | RISC/MIPS/x86、扩展和伪指令

Tags: #C2 #RISC #CISC #MIPS #x86 #extension #pseudo #ISA对比 #伪指令

来源：C2 p75、p114-128。

| 特征 | 课件 RISC-V 主线 | MIPS 对照 | x86/IA-32 对照 |
|---|---|---|---|
| 寄存器命名 | x0-x31、ABI 名 | 常见 $0、$t0 等 | eax/ebx 等（IA-32） |
| 常见算术 | 寄存器间，显式 load/store | 类似 load/store 风格 | 允许更复杂操作数形式 |
| 指令长度 | 本套默认 32 位普通指令 | 课件经典形式 32 位 | 可变长，包含前缀等 |
| 分支/跳转编码 | B/J 重排，偏移低位 0 | 字段与目标计算规则不同 | 编码规则复杂，不能套 RISC-V |
| 实现 | ISA 与具体实现分离 | 同理 | 复杂指令可内部译成微操作 |

不能将 MIPS 的 `$`、`jr`、专用 HI/LO 乘除结果寄存器、分支 PC+4 规则直接搬到 RISC-V。RISC-V mul/div 写普通目标寄存器；标准基础整数指令没有 MIPS 式分支延迟槽。

**x86 有效地址概念**：base+index×scale+displacement，scale 常为 1/2/4/8；这是与 RISC-V base+12 位 offset 的对照，不要把 x86 一条复杂寻址语法写进 RISC-V load。

| 伪指令 | 常见展开 | 注意 |
|---|---|---|
| mv rd,rs | addi rd,rs,0 | 一条常见真实指令 |
| nop | addi x0,x0,0 | 改变PC而无普通数据效果 |
| not rd,rs | xori rd,rs,-1 | 全XLEN位取反 |
| neg rd,rs | sub rd,x0,rs | 最小负数仍需留意 |
| j label | jal x0,label | 不保存链接 |
| ret | jalr x0,0(ra) | 返回 |
| li rd,constant | 依数值和ISA展开 | 不保证只有一条 |
| la rd,symbol | 依链接模型与重定位展开 | 不简单等同任意lui一条 |
| call symbol | 可能为 jal 或更长序列 | 算代码大小须看实际展开 |

**扩展**：I 基础整数；M 乘除；A 原子；F 单精度浮点；D 双精度浮点；C 压缩等。整数 x 寄存器与浮点 f 寄存器是不同寄存器组。知道浮点编码不意味着能用整数 add 完成 IEEE 浮点加法。

**fallacies**：复杂指令减少 IC 不必然减少时间；手写汇编不必然胜过优化编译器；向后兼容不意味着 ISA 永不扩展。判断仍回到程序行为是否正确以及实际执行时间。


---

# Chapter 3 | Arithmetic for Computers

本章最容易错的是“表示范围”和“算法时序”。先固定 n 位及解释方式，再列步骤；最后用十进制数学关系验证位串。不要直接拿无限精度整数运算代替硬件的固定位宽运算。

<a id="c3-01"></a>

## C3-01 | 进制、定点、原码反码补码

Tags: #C3 #radix #binary #hexadecimal #two-complement #sign-magnitude #one-complement #数制

来源：C3 p3-12；C2 p21-29。

**位置权**：二进制整数从右起权为 2^0、2^1…；二进制小数从小数点右起权为 2^-1、2^-2…。例如 `101.101₂=4+1+1/2+1/8=5.625`。十进制整数转二进制可反复除 2 取余并倒序；小数部分反复乘 2，按顺序取整数部分。

| Hex | Binary | Hex | Binary |
|---|---|---|---|
| 0 | 0000 | 8 | 1000 |
| 1 | 0001 | 9 | 1001 |
| 2 | 0010 | A | 1010 |
| 3 | 0011 | B | 1011 |
| 4 | 0100 | C | 1100 |
| 5 | 0101 | D | 1101 |
| 6 | 0110 | E | 1110 |
| 7 | 0111 | F | 1111 |

| n 位表示 | 正负表示方法 | 范围 | 零 |
|---|---|---|---|
| Unsigned 无符号 | 全部位为非负权 | 0…2^n-1 | 1 个 |
| Sign magnitude 原码 | 最高位符号，其余为大小 | -(2^(n-1)-1)…+(2^(n-1)-1) | +0 和 -0 |
| One's complement 反码 | 负数为对应正数逐位取反 | 同原码 | +0 和 -0 |
| Two's complement 补码 | 负数为对应正数取反加一 | -2^(n-1)…2^(n-1)-1 | 1 个 |

同样 `1001`：unsigned=9；4 位原码=-1；反码=-6；补码=-7。必须看题目要求哪种表示。

**8 位 -5**：原码 `10000101`；反码 `11111010`；补码 `11111011`。只适用于“负数”的转换，正数在这三种方式中表示相同。

**常用幂与范围**：2^8=256，2^10=1024，2^12=4096，2^16=65536，2^20=1048576，2^31=2147483648，2^32=4294967296。signed32 范围 -2147483648…2147483647；signed64 范围 -9223372036854775808…9223372036854775807。

**定点 fixed-point 补充**：若固定 f 位小数，解释值=存储整数×2^-f；分辨率=2^-f，位宽不变时增大小数位会减少整数范围。不要和浮点可变指数混淆。课件的位串例可因解释为字符、指令、整数或浮点而有不同含义。

<a id="c3-02"></a>

## C3-02 | 加减、进位、借位与有符号溢出

Tags: #C3 #addition #subtraction #carry #borrow #overflow #溢出 #补码加减

来源：C3 p13-16、p24-26。

```text
n-bit addition: Result = (A+B) mod 2^n
n-bit subtraction: A-B = A+(~B)+1, keep low n bits
Signed addition overflow: same operand signs, different result sign
Signed subtraction overflow: different operand signs, result sign differs from A
Overflow V = carry_into_MSB XOR carry_out_of_MSB
```

用符号位 sA/sB/sR 表达：加法 `V=NOT(sA XOR sB) AND (sA XOR sR)`；减法 `V=(sA XOR sB) AND (sA XOR sR)`。这里的减法判断针对真正 A-B 的原始 B 符号。

| 运算 | 会溢出的符号组合 | 不会溢出的组合 |
|---|---|---|
| A+B | 正+正→负；负+负→非负 | 异号相加 |
| A-B | 非负-负→负；负-非负→非负 | 同号相减 |

**8 位例**：

- `01111111 + 00000001 = 10000000`：127+1 数学值128，signed 溢出；unsigned 128 合法，carry-out=0。
- `11111111 + 00000001 = 00000000`，carry-out=1：unsigned 255+1 超范围；signed -1+1=0 无溢出。
- `10000000 - 00000001 = 01111111`：signed -128-1 溢出；unsigned 128-1=127，无借位。
- `00000011 - 00000101 = 11111110`：signed 3-5=-2 合法；unsigned 会借位。

**Carry ≠ overflow**。无符号加法看最高位外进位；无符号减法比较 `A < B` 可判断借位。用 A+~B+1 实现时常将 carry-out=1 理解为“无借位”，但标志语义依题目电路定义，不能跨 ISA 盲套。

**RISC-V 行为**：普通 add/sub/addi 只保留 XLEN 低位，不因整数溢出自动陷阱，也没有要求像某些 ISA 那样更新条件码。课件“产生异常”一节是一般硬件处理方式介绍，不能直接推成 RISC-V add 溢出就异常。

**如何软件检测**（补充思路）：无符号加法 sum=a+b 后若 sum<a 则有进位；有符号判断可使用上面的符号逻辑。不要在 C 中先执行有符号溢出再希望得到可靠检测，C 语言层面的溢出规则与 ISA 截断行为不同。

英文：`A carry-out indicates unsigned overflow, whereas signed overflow depends on the operand and result signs.`

<a id="c3-03"></a>

## C3-03 | 半加器、全加器、真值表和逻辑式

Tags: #C3 #half-adder #full-adder #truth-table #sum #carry #全加器 #逻辑式

来源：C3 p17-22。

Half adder 半加器接受 A/B，无 Cin：`S=A XOR B`，`C=A AND B`。Full adder 全加器接受 A/B/Cin，输出 S/Cout：

```text
S = A XOR B XOR Cin
Cout = AB + A Cin + B Cin
     = AB + (A XOR B) Cin
```

在布尔公式中，`+` 表 OR，乘写相邻表 AND；不是十进制加乘。`XOR` 是异或。

| A | B | Cin | S | Cout |
|---|---|---|---|---|
| 0 | 0 | 0 | 0 | 0 |
| 0 | 0 | 1 | 1 | 0 |
| 0 | 1 | 0 | 1 | 0 |
| 0 | 1 | 1 | 0 | 1 |
| 1 | 0 | 0 | 1 | 0 |
| 1 | 0 | 1 | 0 | 1 |
| 1 | 1 | 0 | 0 | 1 |
| 1 | 1 | 1 | 1 | 1 |

n 位加法器可由 n 个全加器连接，第 i 位 Cout 送第 i+1 位 Cin。bit0 从最低位开始；最后的 Cout 在 n 位结果之外。有符号符号位是 bit n-1，不能把额外进位当作结果的符号位。

**画电路题**：先确认门种类是否允许 XOR 和多输入门，再将等式映射成门。两个不同布尔表达式可以等价，但延迟受逻辑深度、fan-in 和门延迟假设影响。

<a id="c3-04"></a>

## C3-04 | ALU 的加减、比较、零检测与控制

Tags: #C3 #ALU #Bnegate #less #set #zero #control #比较 #零检测

来源：C3 p23-30。控制码是课件这个 ALU 的局部约定，不是 RISC-V 指令 opcode。

ALU 通常并行计算逻辑运算和加法器输出，再由 mux 选择结果。减法用 `A+~B+1`：对每个 B 位作 XOR（sub=1 时取反），将 bit0 的 Cin 置 1；sub=0 时保留 B 并使 Cin=0。

**比较 signed SLT**：先做 A-B，最高位减法结果的符号在无溢出时可表示 `A < B`；有溢出时要纠正：

```text
less_signed = sign(A-B result) XOR overflow
ALU result for SLT: bit0=less_signed; all other bits=0
Zero = NOT(result0 OR result1 OR ... OR result_(n-1))
```

例：4 位 A=7 (`0111`)，B=-1 (`1111`)。A-B=8，截断结果 `1000` 符号=1，但 7<-1 为假。V=1，因此 less=1 XOR 1=0。若直接取符号位会误判。

**Unsigned less** 可用借位/无借位关系或直接比较逻辑，不能用 signed 的符号位公式替代。**Equality** 常通过减法结果 Zero 判断；两个相等位串相减低 n 位为 0，不要求 signed/unsigned 区分。

| ALU control | 课件功能 |
|---|---|
| 000 | AND |
| 001 | OR |
| 010 | Add |
| 110 | Subtract |
| 111 | Set on less than |
| 100 | NOR |
| 101 | logical shift right |
| 011 | XOR |

课件的基础 1-bit ALU 图可能只画 AND/OR/Add/Less 等，扩展符号表才列更多操作；不能把 3 位表和另一个使用 4 位控制的教材电路混写。Verilog 的 A/B 端口、res 位宽和 signed 声明同样会影响比较语义，判断代码必须看声明，不只看 `<` 符号。

<a id="c3-05"></a>

## C3-05 | Ripple、CLA、分组超前进位与 Carry Select

Tags: #C3 #CLA #ripple-carry #generate #propagate #carry-select #delay #超前进位 #延迟

来源：C3 p31-46；分组图已核对 p43。

**Ripple-carry adder 串行进位加法器**：位 i 的进位依赖前一位，最坏情况下整条链传播，延迟随 n 增长。课件使用每级约 2 单位的简化模型得到约 2n；若题目分别给 XOR/AND/OR 延迟或指定末位 sum，应按实际路径数，不能总写 2n。

**Carry lookahead adder** 将进位展开为输入和更早进位的函数，减少逐位串行依赖。课件约定：

```text
Pi = Ai XOR Bi                propagate 传播
Gi = Ai AND Bi                generate 产生
Si = Pi XOR Ci
C(i+1) = Gi OR (Pi AND Ci)

C1 = G0 + P0 C0
C2 = G1 + P1 G0 + P1 P0 C0
C3 = G2 + P2 G1 + P2 P1 G0 + P2 P1 P0 C0
C4 = G3 + P3 G2 + P3 P2 G1 + P3 P2 P1 G0 + P3 P2 P1 P0 C0
```

有些教材为进位计算用 `Pi=Ai OR Bi`；这时 `Ci+1=Gi+PiCi` 也成立，但 sum 不能直接改成这个 Pi XOR Ci。**一份推导内保持定义一致**，本套默认 XOR propagate。

**4 位组**：

```text
P_group = P3 P2 P1 P0
G_group = G3 + P3 G2 + P3 P2 G1 + P3 P2 P1 G0
C4 = G_group + P_group C0
```

16 位可分 4 个 4 位组。若组编号 0..3 表示位0-3、4-7、8-11、12-15，则第二层也使用同样结构：

```text
C16 = Ggrp3 + Pgrp3 Ggrp2 + Pgrp3 Pgrp2 Ggrp1
      + Pgrp3 Pgrp2 Pgrp1 Ggrp0 + Pgrp3 Pgrp2 Pgrp1 Pgrp0 C0
```

只把四个小 CLA 的 Cout 串起来，组之间仍有串行链；额外的组间 lookahead 才进一步并行计算组进位。

**延迟题通用方法**：从输入到每个内部节点标最早到达时间：`t(out)=max(t(inputs))+gate_delay`。先求 Pi/Gi，再求组信号，再求进位，最后 sum。如果限定两输入门，多输入 AND/OR 必须分层；无限扇入“两级逻辑”不等于现实中恒定小延迟。

**示例约定**：若 XOR/AND/OR 都算 1 单位，允许任意输入数 AND/OR，则 Pi/Gi 在 t=1；C4 的乘积项最晚 t=2，OR 得 C4 在 t=3；对应使用某个进位的 sum 还需 XOR。但若改成全部两输入门树，答案会不同，所以必须先写模型。

**Carry select adder 选择进位**：每个块为 Cin=0 和 Cin=1 预先算两套结果，真正进位到达后用 mux 选。用额外面积换更短等待。**Carry skip** 允许满足条件的块绕过内部进位链。注意 CSA 也常被用作 carry-save adder 的缩写；本课 p45-46 的 CSA 是 carry-select，不要凭缩写混同。

<a id="c3-06"></a>

## C3-06 | 无符号乘法、三版乘法器与乘法指令

Tags: #C3 #multiply #multiplicand #multiplier #partial-product #mul #mulh #乘法器

来源：C3 p47-58、p65-66。

n 位×n 位无符号乘法完整结果需要最多 2n 位。被乘数 M，乘数 Q；部分积按乘数每一位生成，再移位累加。

**V1 宽寄存器模型**：Product P 为 2n 位，初始0；Multiplicand M 扩成 2n 位，初始放低半；Multiplier Q 为 n 位。重复 n 轮：①若 Q0=1，则 P=P+M；②M 左移1；③Q 逻辑右移1。一次迭代可能对应多个控制周期，不能直接说 n 轮必然 n 个时钟。

**V2** 减小加法器和被乘数宽度，只对 product 的高半做加法，并移位 product，使需要相加的位置对齐。乘数可仍保留独立寄存器；题目给电路时按电路中的控制顺序记录。

**V3 合并模型**：将乘数放在 2n 位 product 的低半 Q，高半 A 初始0。每轮检查 Q0，若为1就 A+=M，再将联合寄存器右移1。加法的额外 carry 必须保留并送入高位；图中 64 位实现会有 129 位联合存储/进位安排，而不只是无条件截断高半。

```text
Initialize A=0, Q=multiplier, M=multiplicand
Repeat n times:
    {C,A} = A + (M if Q0=1 else 0)       // n+1-bit temporary
    {A,Q} = logical_right_shift({C,A,Q},1), retaining 2n output bits
Product = {A,Q}
```

**4 位示例 3×5**：

| 轮次 | Q0 | 加法后 C:A | 联合右移后的 A:Q |
|---|---|---|---|
| initial | - | - | 0000 : 0101 |
| 1 | 1 | 0:0011 | 0001 : 1010 |
| 2 | 0 | 0:0001 | 0000 : 1101 |
| 3 | 1 | 0:0011 | 0001 : 1110 |
| 4 | 0 | 0:0001 | 0000 : 1111 |

结果 00001111=15。逐轮表一定注明状态是在“加法后”还是“移位后”。

**有符号简单办法**：记录符号、取幅值做无符号乘法，最后按异或符号修正；最小负数取绝对值需更宽表示，否则会溢出。Booth 直接对补码操作，见下一节。

| RV64 M 指令 | 返回哪部分 | 解释 |
|---|---|---|
| mul rd,rs1,rs2 | 128位乘积低64位 | 低半位模式对signed/unsigned一致 |
| mulh | 高64位 | signed×signed |
| mulhu | 高64位 | unsigned×unsigned |
| mulhsu | 高64位 | rs1 signed×rs2 unsigned |
| mulw | 低32位结果再符号扩展 | RV64专用W形式 |

**溢出检查思路**：若要把完整乘积放回 n 位 unsigned，高半必须为0；signed 高半必须是低半符号位的完整扩展。mul 本身不会为你给出完整2n位结果，需另取高半。

**快速乘法**：把多次加法展开，多个部分积用树形结构归约以缩短关键路径。面积和功耗会上升；课堂三版移位乘法器是串行实现，并非所有实际 mul 都需要相同轮数或周期。

<a id="c3-07"></a>

## C3-07 | Booth 算法：规则、时序、完整追踪

Tags: #C3 #Booth #signed-multiplication #arithmetic-shift #Q-1 #布斯 #补码乘法

来源：C3 p59-64。

连续 1 可以表示成两个幂之差，如 `00111100₂=2^6-2^2`，将多次加法变为一次加一次减。Booth 从低位扫描相邻位，适用于补码有符号乘数。

设 A 为高半累加器，Q 为乘数，Q-1 为额外前一位，初值 A=0、Q-1=0。**两位观察顺序是 (Q0,Q-1)**：

| Q0 Q-1 | 当前运算 | 然后 |
|---|---|---|
| 00 | 不加不减 | 联合算术右移 |
| 01 | A=A+M | 联合算术右移 |
| 10 | A=A-M | 联合算术右移 |
| 11 | 不加不减 | 联合算术右移 |

每轮完成运算后，对 **A:Q:Q-1 整体**算术右移，高位复制 A 的符号位；A 的最低位进入 Q 最高位，Q0 进入 Q-1。不是对 A 和 Q 分别独立右移。执行 n 轮后丢掉 Q-1，结果 A:Q。

**课件 5 位 13×(-11)**：M=01101，-M=10011，Q=10101（-11），初始 `00000 10101 0`。

| 轮次 | Q0,Q-1 | 运算后 A | 联合算术右移后 A Q Q-1 |
|---|---|---|---|
| 1 | 10 | 10011 | 11001 11010 1 |
| 2 | 01 | 00110 | 00011 01101 0 |
| 3 | 10 | 10110 | 11011 00110 1 |
| 4 | 01 | 01000 | 00100 00011 0 |
| 5 | 10 | 10111 | 11011 10001 1 |

完整10位结果 `1101110001₂`，unsigned=881，signed=881-1024=-143。`0010001111` 是它取负后的 +143 幅值，不是有符号乘积最终应交的位串。

**4 位 2×(-3)**：M=0010，Q=1101，最后 A:Q=11111010=-6。可用 Q21 的逐步表复习。

**最小负数边界**：若 M=-2^(n-1)，n 位中无法表示 +2^(n-1)，直接在 n 位 A 中计算 -M 的朴素版本可能出错。通用实现应增加一位符号/运算宽度，并按扩展算法记录和取结果。普通课堂例子未触及该边界时，不需要擅自改变题目规定的轮数/寄存器格式；但不能声称朴素 n 位版本无条件覆盖所有输入。

Booth 对长串1可能减少非零加减次数；对于交替 0101… 未必比普通乘法更少。不要写成“Booth 对任何乘数都一定更快”。

英文：`The pair is examined in the order Q0, Q-1. After the selected addition or subtraction, the entire combined register is shifted right arithmetically.`

<a id="c3-08"></a>

## C3-08 | 恢复余数除法、有符号除法与 RISC-V 除法

Tags: #C3 #division #restoring #dividend #divisor #quotient #remainder #div #rem #除法

来源：C3 p67-77。

```text
Dividend = Quotient × Divisor + Remainder
Unsigned: 0 ≤ Remainder < Divisor      (Divisor>0)
Signed ordinary division: quotient truncates toward zero
Nonzero signed remainder has the sign of the dividend
```

**恢复 restoring** 的意思：试减除数后若余数为负，则加回除数，恢复之前的有效余数，同时该商位写0；非负则保留并写1。

**课件 V1 概念**：把 divisor 放在宽寄存器高半、dividend 放在 remainder 的低半；反复试减、判断、恢复/保留，商移位加入新位，divisor 右移。课件 V1 使用包含初始对齐检查的 n+1 次流程；具体次数和最后修正看给出的流程图，不能和 V2 的 n 次循环直接混表。

**易手算的标准合并 A:Q 版本（V2 思想）**：A=0，Q=dividend，M=divisor。重复 n 次：①将 A:Q 整体左移1；②A_trial=A-M（用足够宽度判断正负）；③若负，则恢复A，Q0=0；否则保留A_trial，Q0=1。最后 A=余数、Q=商。左移发生在试减**之前**。

| 4位 7÷2 | 左移后 A:Q | A_trial | 处理后 A:Q |
|---|---|---|---|
| initial | - | - | 0000 : 0111 |
| 1 | 0000 : 1110 | -2 | 恢复 → 0000 : 1110 |
| 2 | 0001 : 1100 | -1 | 恢复 → 0001 : 1100 |
| 3 | 0011 : 1000 | +1 | 保留并置1 → 0001 : 1001 |
| 4 | 0011 : 0010 | +1 | 保留并置1 → 0001 : 0011 |

结果 Q=3，R=1；校验 7=3×2+1，且0≤1<2。**注意**课件 p73 的另一种安排将部分移位放在其他位置，末尾还有高半右移修正；只要时序保持一致结果应相同，不能把这里“先移后减”的中间行直接塞进原图。

**有符号符号恢复**：

| Dividend | Divisor | Quotient | Remainder | 校验 |
|---|---|---|---|---|
| +7 | +2 | +3 | +1 | 7=3×2+1 |
| +7 | -2 | -3 | +1 | 7=(-3)×(-2)+1 |
| -7 | +2 | -3 | -1 | -7=(-3)×2-1 |
| -7 | -2 | +3 | -1 | -7=3×(-2)-1 |

商符号是两数符号异或，非零余数随被除数。不要为了把余数变正而改成向负无穷取整，那是另一种除法约定。

RISC-V `div/rem` 是 signed，`divu/remu` 是 unsigned；结果分别写 rd，不依赖 HI/LO。W 版在 RV64 处理低32位并符号扩展32位结果。

**ISA 规定的特殊结果（补充边界）**：除数为0时，商全1，余数为原被除数；signed 最小负数除以-1时，商仍是最小负数位串，余数0。这些整数指令不因为这两种情况自动引发算术陷阱。数学层面的除零不成立，若应用需要报错应另行检测。

**为什么除法较难简单并行展开？** 后一位商的决定依赖前一次的试减/余数符号；不像乘法的多个部分积可以较独立地产生。实际仍有更高级除法器，但不等于“除法绝不可能优化”。

<a id="c3-09"></a>

## C3-09 | IEEE 754：字段、偏置与规格化数

Tags: #C3 #floating-point #IEEE754 #single #double #exponent #bias #significand #浮点表示

来源：C3 p78-84。

浮点数类似科学计数法，用符号、有效数和指数表示，扩大表示范围。它不能精确表示所有实数，也不一定能精确表示看似简单的十进制小数。

| 格式 | Total | Sign S | Stored exponent E | Fraction F | Bias B | 正常有效精度 p |
|---|---|---|---|---|---|---|
| binary32 / single | 32 | 1 | 8 | 23 | 127 | 24（二进制位） |
| binary64 / double | 64 | 1 | 11 | 52 | 1023 | 53（二进制位） |

```text
Normal finite number:
Value = (-1)^S × (1 + F/2^f) × 2^(E-B)
S = sign bit; E = stored exponent as unsigned integer
F = unsigned integer represented by fraction bits; f = number of fraction bits
e = E-B is the true/unbiased exponent
```

正常数最高有效位 1 是隐含的 **hidden/implicit leading 1**，不写进 fraction 字段；因此 single 虽只存23位 fraction，却有24位正常精度。E 是 biased exponent，**不是补码指数**。

**十进制→浮点步骤**：①S；②绝对值转二进制；③规格化成 `1.xxx×2^e`；④E=e+B；⑤丢掉最高隐含1，留下f位F；⑥若超长则按指定舍入；⑦拼 S/E/F，按4位转hex；⑧反算校验。

**例 -0.75**：`-0.11₂=-1.1₂×2^-1`。S=1，e=-1，E=126=`01111110`，F=`1000…0`（23位） → `1 01111110 10000000000000000000000` → `0xBF400000`。

**例 -13.25**：`-1101.01₂=-1.10101₂×2^3`。S=1，E=130=`10000010`；F=`10101000000000000000000` → `0xC1540000`。

**例 0.15625**：`0.00101₂=1.01₂×2^-3` → E=124，F=`0100…0` → `0x3E200000`。

**浮点→数值步骤**：先识别格式和字段宽度；再判断 E 是否全0/全1；只有 normal 才使用隐藏1；由 E-B 得指数，再解释F。不要先套 normal 公式再发现是NaN。

**位串复用**：32 位 `0x3F800000` 若解释为 float 是1.0，若解释为 unsigned 是1065353216。整数 `1` 的位串不是浮点1.0；类型转换 conversion 与位重解释 bit reinterpretation 是不同操作。

<a id="c3-10"></a>

## C3-10 | 零、次正规数、无穷、NaN、范围与精度

Tags: #C3 #subnormal #denormal #NaN #infinity #range #precision #ulp #特殊值

来源：C3 p82-86；次正规公式为解释范围边界的补充。

| E 字段 | F 字段 | 类型 | 数值 |
|---|---|---|---|
| 0 | 0 | +0 / -0 | 符号由 S 决定 |
| 0 | 非0 | subnormal / denormal 次正规数 | (-1)^S × (F/2^f) × 2^(1-B) |
| 1…2^k-2 | 任意 | normal 正常数 | (-1)^S × (1+F/2^f) × 2^(E-B) |
| 全1 | 0 | ±infinity | 无穷 |
| 全1 | 非0 | NaN, not a number | 非普通数值 |

**次正规没有隐藏1**，并使用固定指数1-B，而不是0-B；目的是靠近0时实现 gradual underflow。有效相对精度会降低。

| 量 | binary32 | binary64 |
|---|---|---|
| normal 的真实指数 | -126…+127 | -1022…+1023 |
| 最小正normal | 2^-126≈1.17549×10^-38 | 2^-1022≈2.22507×10^-308 |
| 最大有限正数 | (2-2^-23)×2^127≈3.40282×10^38 | (2-2^-52)×2^1023≈1.79769×10^308 |
| 最小正subnormal | 2^-149≈1.40130×10^-45 | 2^-1074≈4.94066×10^-324 |
| 1与下一个较大值之差 | 2^-23 | 2^-52 |
| 常说的十进制有效位量级 | 约7位 | 约16位 |

**“smallest positive”必须辨别**：问 smallest normalized → 2^-126；允许 subnormal → 2^-149（single）。若课件只在 normal 范围讨论最小值，不代表 subnormal 不存在。

**常见single位模式**：+0 `0x00000000`；-0 `0x80000000`；+∞ `0x7F800000`；-∞ `0xFF800000`；NaN例 `0x7FC00000`；最小正subnormal `0x00000001`；最小正normal `0x00800000`；最大有限 `0x7F7FFFFF`。

**NaN 例子**：0/0、∞-∞、负数实数平方根等无效运算可产生 NaN。普通数值比较中 NaN 不等于包括自身在内的数；“有相同 NaN 位串”不等于数值 `NaN==NaN` 为真。具体异常标志和陷阱机制取决于执行环境，此处只需区分类别。

**Overflow**：结果幅值超出最大有限范围。**Underflow**：结果进入极小/次正规范围并涉及标准规定的微小与不精确条件；不要简单把每个非零 subnormal 都断言“已经产生 underflow 异常”。课堂范围题常用“太小，可能变次正规或舍入到0”解释。

**精度不是常数绝对间隔**：在 binade `[2^e,2^(e+1))`，normal 间距 `ULP=2^(e-(p-1))`。single 在 [1,2) 间距2^-23，在[2,4)间距2^-22。它在数值越大时绝对间隔越大。

**整数精确范围**：binary32 可连续精确表示 -2^24…2^24 中的整数；超过该范围仍有某些整数可精确表示，但不是每个都能。例如 2^24+1 不可精确，2^24+2 可以。binary64 对应2^53。

**machine epsilon 与 unit roundoff**：常见 epsilon=1到下一个数的距离2^-(p-1)；最近舍入误差分析常用u=2^-p。题目用哪个定义就照定义，不能看到“epsilon”直接混写两者。

<a id="c3-11"></a>

## C3-11 | 浮点加减乘除的解题流程

Tags: #C3 #floating-addition #floating-multiplication #normalize #align #浮点运算 #对阶

来源：C3 p87-95。

**加减步骤**：①识别特殊值；②比较真实指数；③**小指数的有效数右移**到较大指数，保留GRS；④按符号加/减有效数；⑤规格化；⑥舍入；⑦若舍入导致进位再次规格化；⑧判断指数范围并编码。

**对阶为何移小数？** 因为把 `m×2^e` 改写成 `(m/2)×2^(e+1)`，数值不变。右移时被挤掉的位用于舍入，不能直接不管。

**课件例 0.5+(-0.4375)**：

```text
0.5     =  1.000₂ × 2^-1
-0.4375 = -1.110₂ × 2^-2
对齐     = -0.111₂ × 2^-1
相加     =  0.001₂ × 2^-1
规格化   =  1.000₂ × 2^-4 = 0.0625
single encoding = 0x3D800000
```

相消会产生多个前导0，需要左移并减少指数；同号相加可能产生 `10.xxx`，需右移并增加指数。不能只考虑加法进位，不考虑减法相消。

**乘法步骤**：①符号 S=S1 XOR S2；②真实指数相加 `e=e1+e2`（若直接用存储指数，则 `E=E1+E2-B`）；③有效数相乘；④若乘积≥2则右移1且指数+1；⑤舍入；⑥再规格化与范围检查。

例：1.5×(-2.5) → `1.1₂×2^0 × (-1.01₂×2^1)` → `-1.111₂×2^1=-3.75` → single `0xC0700000`。

**除法步骤**：符号异或；真实指数相减；有效数相除；规格化；舍入；检查特殊/范围。若直接用 E，候选结果 `E=E1-E2+B`。不要漏掉 bias 补回。

**有限精度可能不结合**：`(a+b)+c` 与 `a+(b+c)` 可能不同。single 最近偶数示例 a=2^24、b=1、c=-2^24：先 a+b 舍回2^24，再+c得0；先b+c=-16777215可精确，再+a得1。代数实数的重排不一定保持浮点位级结果。

**取消与误差**：两个接近值相减会使已有误差相对突出；保留更多中间位能改善但不能让所有小数都精确。题目指定 toy format（如4位有效数）时每一步按该格式舍入，不擅自用双精度算到底最后才舍。

<a id="c3-12"></a>

## C3-12 | GRS、最近偶数舍入与误差

Tags: #C3 #rounding #GRS #guard #round #sticky #nearest-even #ULP #舍入

来源：C3 p96-98。

保留 p 位有效数后，还需观察被截掉的位：**G guard** 为第一个丢弃位；**R round** 为第二个；**S sticky** 为后面全部位的 OR。Sticky 只判断“后面有没有任何1”，不是再取一个原始位。

```text
retained significand | G R remaining bits
S = OR(all remaining bits)
For round-to-nearest, ties-to-even:
increment retained magnitude iff G AND (R OR S OR retained_LSB)
```

| G R S | 与半个ULP比较 | 最近偶数处理 |
|---|---|---|
| 0xx | 小于一半 | 保持保留部分 |
| 100 | 恰好一半 tie | 看保留末位：0保持，1进1，使最终末位为0 |
| 101 / 110 / 111 | 大于一半 | 保留部分加1 |

**“偶”是最终保留最低位为0**，不是让十进制整数部分成为偶数。tie 时不能一律加1。

保留4位有效数（含隐藏1）：`1.010|100` → `1.010`；`1.011|100` → `1.100`；`1.010|101` → `1.011`；`1.111|101` → `10.000` 再规格化为 `1.000×2^(e+1)`。

| 模式 | 正数有丢弃的非零尾数 | 负数有丢弃的非零尾数 |
|---|---|---|
| toward zero 截断 | 幅值向小 | 幅值向小（数值变大、更接近0） |
| toward +∞ | 向更大数值 | 向更大数值（幅值可能不增） |
| toward -∞ | 向更小数值 | 向更小数值（幅值可能增加） |
| nearest, ties to even | 选最近值，同距选偶 | 同样按距离和偶数最低位 |

**负数示例**：保留一位十进制小数的类比中 -1.25：toward0→-1.2；toward+∞→-1.2；toward-∞→-1.3；nearest-even→-1.2。此例只帮助理解方向，不替代二进制格式的位运算。

**误差**：最近舍入时通常绝对误差≤0.5 ULP（在适当相邻间隔定义下）；normal 区间中相对误差可用约2^-p界定，subnormal 近0时不保持相同相对精度。截断的误差方向与最近舍入不同。

**0.1 为什么不精确？** 十进制1/10的约分分母含5，不是2的幂，其二进制展开无限循环。single 最近舍入位模式 `0x3DCCCCCD`，实际约0.10000000149011612；这不是计算机“算错了1/10”，而是有限位格式选择了最近可表示值。

英文：`The discarded bits are exactly halfway, so the retained least significant bit determines the result. Ties are rounded to an even least significant bit.`


---

# Worked Problems | 英文题型与完整解答

这些练习用于展示解题流程，不是历年卷或命题预测。标“课件数字”的题根据本地课件重算；其余为配套自编题。每题先读英文，然后用中文理解，再尝试写出简短英文结论。计算位宽、数据类型与舍入假设均属于题目条件。

<a id="q01"></a>

## Q01 | CPU time and clock rate 目标时钟频率

Tags: #Q #C1 #CPU-time #clock #frequency #目标频率

**Question.** Computer A runs a program in 10 seconds at 2 GHz. Computer B requires 1.2 times as many clock cycles but must finish in 6 seconds. What clock rate is required for B?（课件数字，C1 p68-69）

**题意**：B 用的周期更多，但要更短时间，求频率。

1. `Cycles_A=10 s×2×10^9 cycles/s=20×10^9 cycles`。
2. `Cycles_B=1.2×20×10^9=24×10^9 cycles`。
3. `f_B=24×10^9/6=4×10^9 Hz=4 GHz`。

**English answer.** `B requires 24 billion clock cycles. Its clock rate must be 24×10^9/6 = 4 GHz.`

**检查**：若错用相同周期数，会得到3.333GHz；这忽略了“1.2 times as many”。

<a id="q02"></a>

## Q02 | Weighted CPI and execution time 加权 CPI

Tags: #Q #C1 #CPI #weighted-average #instruction-mix #加权平均

**Question.** A program executes 100 million instructions. The instruction mix is 50% arithmetic, 30% load/store, and 20% branch. Their CPIs are 1, 2, and 3. Find the average CPI and CPU time at 2 GHz.

**解**：`CPI=0.5×1+0.3×2+0.2×3=1.7`。总周期 `100×10^6×1.7=170×10^6`。时间 `170×10^6/(2×10^9)=0.085 s=85 ms`。

若仅把 branch CPI 从3降到1，动态条数不变：新平均CPI=1.3，新时间65ms，速度比85/65=17/13≈1.3077，执行时间减少20/85≈23.53%，性能提高约30.77%。

**English answer.** `The average CPI is 1.7, so the CPU time is 85 ms. Reducing branch CPI to 1 gives 65 ms and a speedup of 1.3077.`

**陷阱**：类别数为3不表示三个CPI直接平均；优化比例20%是指令占比，不是原时间占比。原分支周期占比0.6/1.7≈35.29%。

<a id="q03"></a>

## Q03 | More instructions can be faster 指令多反而更快

Tags: #Q #C1 #instruction-count #CPI #sequence #性能比较

**Question.** The CPIs of classes A, B, and C are 1, 2, and 3. Sequence 1 uses 2, 1, and 2 instructions; sequence 2 uses 4, 1, and 1. Which is faster at the same clock rate?（课件数字，C1 p74-75）

**解**：序列1：IC=5，周期=10，平均CPI=2。序列2：IC=6，周期=9，平均CPI=1.5。同频率下序列2更快，`S=10/9≈1.1111`，时间减少10%，性能增加11.11%。

**English answer.** `Sequence 2 is faster because it requires 9 cycles instead of 10, despite having one more instruction.`

<a id="q04"></a>

## Q04 | Amdahl and an impossible target 局部加速上限

Tags: #Q #C1 #Amdahl #limit #speedup #上限

**Question.** Multiplication accounts for 80 seconds of a 100-second program. Find the overall speedup if multiplication is four times faster. Can a finite multiplication speedup make the entire program five times faster?（课件数字扩展，C1 p87）

**解**：未改善20s，改善80/4=20s，新总40s，速度比2.5。目标5倍需新总20s；未改善已经20s，必须改善部分耗时为0，只能作为无限局部加速的极限，任何有限倍数不能达到。

若目标整体4倍，则新时间25s，乘法只许5s，局部速度=80/5=16倍。

**English answer.** `The overall speedup is 100/(20+80/4)=2.5. A speedup of 5 is only a limiting value; no finite multiplication speedup reaches it.`

<a id="q05"></a>

## Q05 | Power versus energy 功耗和能量

Tags: #Q #C1 #power #energy #voltage #功耗

**Question.** The new processor has 85% of the old capacitance, voltage, and frequency. Assume dynamic power is proportional to CV²f. Find the power ratio. If the cycle count is unchanged, find the dynamic energy ratio.（课件数字扩展，C1 p79）

**解**：功耗比0.85⁴=0.52200625；降低47.799375%。运行时间比1/0.85≈1.17647。能量比0.85⁴/0.85=0.85³=0.614125；降低38.5875%。

**English answer.** `The power ratio is 0.5220. The longer execution time makes the energy ratio 0.6141 under the stated dynamic-power model.`

<a id="q06"></a>

## Q06 | Yield and die cost 良率成本

Tags: #Q #C1 #yield #wafer #die #cost #良率

**Question.** A wafer costs $5,000 and has 70,000 mm² of usable area. Die area is 100 mm² and defect density is 0.002/mm². Ignore edge loss. Using the lecture yield model, find the cost per working die.

**解**：总die=70000/100=700。D×A/2=0.002×100/2=0.1。yield=1/1.1²=100/121≈0.826446。可工作数量约578.512，成本5000/578.512≈$8.64286。

若die面积翻倍至200：数量350，yield=1/1.2²≈0.694444，成本≈$20.57143。成本比≈2.38017，不是2。

**English answer.** `The yield is approximately 0.8264, giving about 578.5 working dies per wafer. The cost per working die is approximately $8.64.`

<a id="q07"></a>

## Q07 | SPEC geometric mean 基准几何平均

Tags: #Q #C1 #SPEC #geometric-mean #几何平均

**Question.** A machine has normalized performance ratios 2, 4, and 8. Find their geometric mean. Is it the same as the arithmetic mean?

**解**：积=64，三次根=4。算术平均14/3≈4.6667，不相同。若目标是这些程序的总运行时间，还需要各程序参考时间和执行权重，不能仅凭这个几何平均推总耗时。

**English answer.** `The geometric mean is (2×4×8)^(1/3)=4. The arithmetic mean is 14/3 and is not the specified metric.`

<a id="q08"></a>

## Q08 | Pipelining with unequal stages 不等长流水

Tags: #Q #C1 #pipeline #throughput #latency #洗衣

**Question.** Four loads require washing for 30 minutes, drying for 40 minutes, and folding for 20 minutes. Each stage has one resource. Stages can proceed independently. Find the total completion time with and without overlap.（课件数字，C1 p96-97）

**解**：无重叠4×90=360。各批结束洗涤在30、60、90、120；烘干结束70、110、150、190；折叠结束90、130、170、210。总210min，速度比12/7≈1.7143；稳态瓶颈烘干40min/批。

如果题目改要求同步40min槽，结果为(4+3-1)×40=240，与本题独立资源模型不同。

**English answer.** `Overlapping the stages reduces total time from 360 to 210 minutes. Drying is the bottleneck and limits the steady-state throughput to one load every 40 minutes.`

<a id="q09"></a>

## Q09 | Compile an array expression 数组表达式翻译

Tags: #Q #C2 #array #load #store #C-to-assembly #数组

**Question.** Translate `A[i] = A[i] + h;` for an array of 64-bit integers. The base address of A is in s1, i in s2, and h in s3.

**解**：算地址=base+8i；load；加h；store。不能直接对内存加法。

```asm
slli t0, s2, 3
add  t0, s1, t0
ld   t1, 0(t0)
add  t1, t1, s3
sd   t1, 0(t0)
```

**English explanation.** `The index is multiplied by 8 because each element occupies eight bytes. The value is loaded, updated in a register, and stored back.`

若改成int32_t且要按32位计算，则shift2、lw、addw、sw；大多数低32位写回场景可用add再sw，但要明确题目关注的是32位存储结果还是64位寄存器结果。

<a id="q10"></a>

## Q10 | Little-endian and load extension 字节序与扩展

Tags: #Q #C2 #little-endian #lb #lbu #lw #lwu #字节序

**Question.** Memory bytes at 0x1000 through 0x1003 are 80, 7F, 00, FF (hexadecimal). Assume little-endian RV64. Find the results of `lb t0,0(s0)`, `lbu t1,0(s0)`, `lw t2,0(s0)`, and `lwu t3,0(s0)` when s0=0x1000.

**解**：32位字是0xFF007F80。lb将0x80解释为signed8=-128，扩展为0xFFFFFFFFFFFFFF80。lbu→0x0000000000000080。lw→0xFFFFFFFFFF007F80。lwu→0x00000000FF007F80。四条都不改变s0。

**English answer.** `The 32-bit little-endian word is 0xFF007F80. LB and LW sign-extend, whereas LBU and LWU zero-extend their loaded values.`

<a id="q11"></a>

## Q11 | Signed comparison and right shifts 比较与右移

Tags: #Q #C2 #signed #unsigned #sra #srl #比较

**Question.** In an 8-bit toy machine, x=11111001₂. Interpret x as signed and unsigned. Find the result of a logical and an arithmetic right shift by one. Compare signed division by 2.

**解**：unsigned249，signed=-7。逻辑右移01111100=124；算术右移11111100=-4；signed向零除2=-3，位串11111101。这里明确是8位模型，不能把124当RV64负数逻辑右移的通用结果。

**English answer.** `The bit pattern represents -7 as a signed value. An arithmetic right shift gives -4, while signed division by 2 truncates toward zero and gives -3.`

<a id="q12"></a>

## Q12 | Encode R/I/S instructions 指令编码

Tags: #Q #C2 #encode #R-type #I-type #S-type #机器码

**Question.** Encode the following instructions: `add x9,x20,x21`; `addi x5,x6,-12`; `sd x5,24(x6)`.

**解**：

| 指令 | 关键字段 | 机器码 |
|---|---|---|
| add | funct7=0,rs2=21,rs1=20,funct3=0,rd=9,op=0x33 | 0x015A04B3 |
| addi | imm12=0xFF4,rs1=6,funct3=0,rd=5,op=0x13 | 0xFF430293 |
| sd | imm=24→high7=0,low5=24,rs2=5,rs1=6,funct3=3,op=0x23 | 0x00533C23 |

**English explanation.** `The immediate -12 is encoded as the 12-bit two's-complement value 0xFF4. The S-type immediate is split between bits 31:25 and 11:7.`

<a id="q13"></a>

## Q13 | Decode a machine word 反汇编

Tags: #Q #C2 #decode #disassemble #hex #反汇编

**Question.** Disassemble the 32-bit word 0x00578833.（课件数字，C2 p90）

**解**：op=0x33→R整数；rd=(word>>7)&31=16；rs1=15；rs2=5；funct3=0；funct7=0→add。结果 `add x16,x15,x5`，别名 `add a6,a5,t0`。

**English answer.** `The instruction is add x16,x15,x5. It adds the values in x15 and x5 and writes the low XLEN bits to x16.`

如果题目给小端字节33 88 57 00，先还原成0x00578833再解码。

<a id="q14"></a>

## Q14 | Branch offset and encoding 正向与反向分支

Tags: #Q #C2 #branch #offset #PC #B-type #分支

**Question.** A `bne x9,x24,Exit` at address 80012 branches to 80024. A `beq x0,x0,Loop` at address 80020 branches to 80000. Find the byte offsets and machine codes. Addresses are decimal.（课件数字，C2 p85-86）

**解**：正向D=+12，13位补码0000000001100，imm12=0，imm10:5=000000，imm4:1=0110，imm11=0，op0x63、f3=1 → 0x01849663。反向D=-20，13位位串1111111101100；imm12=1，imm10:5=111111，imm4:1=0110，imm11=1，f3=0 → 0xFE0006E3。

**English answer.** `The offsets are +12 and -20 bytes, measured from the branch instruction itself. The encodings are 0x01849663 and 0xFE0006E3.`

**检查**：imm4:1=0110 的两种情况可以相同，但符号和其他片段不同。不要用PC+4作为减数。

<a id="q15"></a>

## Q15 | LUI plus ADDI 大常数拆分

Tags: #Q #C2 #lui #addi #constant #sign-extension #立即数

**Question.** Load decimal 4,000,000 into s3 using LUI and ADDI. Explain why `addi s3,s3,2304` is invalid.（课件数字更正，C2 p81）

**解**：4000000=0x003D0900。低12位0x900的signed值=-1792，高段=(4000000+1792)/4096=977。代码 `lui s3,977; addi s3,s3,-1792`。+2304>2047，无法作为signed12立即数直接编码；若硬把0x900填入字段，机器会把它解释为-1792。

**English answer.** `Use lui s3,977 followed by addi s3,s3,-1792. The low 12-bit field is signed, so 0x900 represents -1792 rather than +2304.`

<a id="q16"></a>

## Q16 | Stack frame and recursion 栈帧追踪

Tags: #Q #C2 #stack #recursive #factorial #callee #栈帧

**Question.** Use the factorial routine in C2-14. The initial stack pointer is 0x1000 and the argument is 3. Each invocation allocates 16 bytes, including the base case. Find the deepest stack pointer, maximum stack use, and result.

**解**：n=3入栈→0x0FF0；n=2→0x0FE0；n=1基例→0x0FD0。最深0x0FD0，总48B，回溯a0=1、2、6。最后sp恢复0x1000。每层ra在本层sp+8，本层n在sp+0；不能从当前sp直接读取父层同名变量。

**English answer.** `There are three active frames, so the maximum stack use is 48 bytes and the deepest sp is 0x0FD0. The function returns 6 and restores sp to 0x1000.`

<a id="q17"></a>

## Q17 | Linker versus loader 工具职责

Tags: #Q #C2 #linker #loader #relocation #symbol #链接

**Question.** Which tool resolves a reference from one object module to a function defined in another module? Which tool establishes the executable's initial memory image?

**解**：普通静态链接情形前者linker；后者loader。动态链接也可在装载/运行时解析共享库引用，但题目明确目标模块静态合并时，不要把所有工作都给loader。

**English answer.** `The linker resolves the external function reference and applies relocation. The loader establishes the initial program image and starts execution at the entry point.`

<a id="q18"></a>

## Q18 | Carry versus signed overflow 进位不等于溢出

Tags: #Q #C3 #overflow #carry #signed #加减法

**Question.** For 8-bit arithmetic, compute 0x7F+0x01, 0xFF+0x01, and 0x80-0x01. State signed overflow and unsigned carry/borrow separately.

**解**：

| 运算 | 8位结果 | signed 解释 | unsigned 解释 |
|---|---|---|---|
| 7F+01 | 80 | 127+1→-128，overflow | 127+1=128，无carry |
| FF+01 | 00 | -1+1=0，无overflow | 255+1→0，有carry |
| 80-01 | 7F | -128-1→127，overflow | 128-1=127，无borrow |

**English answer.** `Signed overflow occurs in the first and third operations. An unsigned carry occurs only in the second addition; the subtraction has no unsigned borrow.`

<a id="q19"></a>

## Q19 | CLA signals and carries 超前进位演算

Tags: #Q #C3 #CLA #propagate #generate #进位

**Question.** A 4-bit CLA adds A=1011₂ and B=0110₂ with C0=0. Use Pi=Ai XOR Bi and Gi=AiBi. Find P, G, all carries, and the sum.

**解**：按bit3…0写，P=1101，G=0010。从bit0开始：C1=G0+P0C0=0；C2=G1+P1C1=1；C3=G2+P2C2=1；C4=G3+P3C3=1。S=P XOR (C3 C2 C1 C0)=1101 XOR1100=0001。完整unsigned结果C4:S=10001=17。signed4位解释 -5+6=1，无signed溢出；C3 XOR C4=0。

**English answer.** `P=1101 and G=0010. The carry sequence C1,C2,C3,C4 is 0,1,1,1, producing the 4-bit sum 0001 and carry-out 1.`

<a id="q20"></a>

## Q20 | Shift-and-add multiplication 移位乘法

Tags: #Q #C3 #multiply #partial-product #shift #乘法

**Question.** Multiply unsigned 4-bit values 3 and 5 with the combined A:Q shift-and-add algorithm. Show the state after each iteration.

**解**：M=0011，A=0000，Q=0101。C3-06的完整表给出四轮移位后状态：0001:1010，0000:1101，0001:1110，0000:1111。结果15，最多需要8位；每次加法保留进位再整体右移。

**English answer.** `After four iterations, A:Q=00001111, which is 15. The carry from the upper-half addition must be preserved during the shift.`

<a id="q21"></a>

## Q21 | Booth signed multiplication Booth 逐轮表

Tags: #Q #C3 #Booth #signed #arithmetic-shift #补码乘法

**Question.** Use the 4-bit Booth algorithm to multiply 2 by -3. Initially A=0000, Q=1101, Q-1=0, and M=0010. Show each operation and arithmetic shift.

**解**：

| 轮 | 当前Q0,Q-1 | 操作后A | 算术右移后 A:Q:Q-1 |
|---|---|---|---|
| 1 | 10 | A-M=1110 | 1111:0110:1 |
| 2 | 01 | A+M=0001 | 0000:1011:0 |
| 3 | 10 | A-M=1110 | 1111:0101:1 |
| 4 | 11 | 不变1111 | 1111:1010:1 |

丢掉Q-1后11111010，unsigned250，signed250-256=-6。

**English answer.** `The final product is 11111010₂, which represents -6 in 8-bit two's complement. Each iteration uses an arithmetic shift of the entire combined register.`

<a id="q22"></a>

## Q22 | Restoring division and signs 恢复除法

Tags: #Q #C3 #division #restoring #remainder #除法

**Question.** Divide unsigned 7 by 2 using the 4-bit restoring algorithm. Then give the signed quotient and remainder for -7 divided by 2.

**解**：无符号按C3-08表四轮后A=0001、Q=0011，商3余1。对于signed -7/2，向零商-3，余-1。验证 `-7=(-3)×2+(-1)` 且 `|R|<|D|`。

**English answer.** `Unsigned division gives quotient 3 and remainder 1. Signed division of -7 by 2 gives quotient -3 and remainder -1 because the quotient truncates toward zero.`

<a id="q23"></a>

## Q23 | Encode a floating-point value 浮点编码

Tags: #Q #C3 #IEEE754 #encode #single #bias #浮点

**Question.** Represent -13.25 in IEEE 754 single precision. Give the sign, biased exponent, fraction, and hexadecimal word.

**解**：绝对值13=1101，小数0.25=.01 →1101.01 →1.10101×2^3。S=1，E=3+127=130=10000010，F=10101000000000000000000。拼接 `1 10000010 10101000000000000000000` → C1540000。

**English answer.** `S=1, E=130, and the fraction field is 10101000000000000000000. The encoding is 0xC1540000.`

<a id="q24"></a>

## Q24 | Decode IEEE 754 and classify specials 浮点解码分类

Tags: #Q #C3 #IEEE754 #decode #NaN #infinity #subnormal #分类

**Question.** Decode or classify these single-precision words: 0x3F800000, 0xBF400000, 0x7F800000, 0x7FC00000, 0x00000001.

**解**：3F800000：S0、E127、F0 →1.0。BF400000：S1、E126、F=2^22，即fraction=.5 →-1.5×2^-1=-.75。7F800000：E255、F0→+∞。7FC00000：E255、F≠0→NaN。00000001：E0、F1→最小正subnormal2^-149，不使用隐含1。

**English answer.** `The values are 1.0, -0.75, positive infinity, NaN, and the smallest positive subnormal value 2^-149, respectively.`

<a id="q25"></a>

## Q25 | Range and precision 范围精度

Tags: #Q #C3 #range #precision #ULP #normal #subnormal #精度

**Question.** For binary32, state the smallest positive normal, the smallest positive subnormal, and the spacing between normal values in [8,16).

**解**：normal最小2^-126；subnormal最小2^-149。[8,16)的真实指数e=3，有效精度p=24，因此间距=2^(3-23)=2^-20≈9.53674×10^-7。不是到处都是2^-23。

**English answer.** `The two minimum values are 2^-126 and 2^-149. The spacing in [8,16) is 2^-20 because the unbiased exponent is 3.`

<a id="q26"></a>

## Q26 | Floating-point addition 对阶与相消

Tags: #Q #C3 #floating-addition #alignment #cancellation #对阶

**Question.** Show the binary floating-point steps for 0.5+(-0.4375). Assume sufficient precision so that no rounding is required.（课件数字，C3 p90）

**解**：1.000×2^-1与-1.110×2^-2。小指数项右移为-.111×2^-1；和=.001×2^-1；左移3位规格化为1.000×2^-4=.0625。single位模式3D800000。

**English answer.** `After exponent alignment, the significands subtract to 0.001₂×2^-1. Normalizing gives 1.000₂×2^-4=0.0625.`

<a id="q27"></a>

## Q27 | Round to nearest, ties to even 最近偶数

Tags: #Q #C3 #GRS #rounding #nearest-even #舍入

**Question.** Keep four significand bits, including the leading 1. Round `1.010|100`, `1.011|100`, `1.010|101`, and `1.111|101` using round-to-nearest, ties-to-even. The suffix gives GRS.

**解**：分别是1.010，1.100，1.011，以及10.000（规格化后1.000且指数加1）。第一个tie末位0保持；第二个tie末位1进1；第三、第四大于半ULP进1。

**English answer.** `The rounded results are 1.010, 1.100, 1.011, and 1.000×2^(e+1). The first two are ties, so the retained least significant bit determines whether to increment.`

<a id="q28"></a>

## Q28 | Bit-field extraction and insertion 位域提取与插入

Tags: #Q #C2 #mask #bitfield #shift #位域

**Question.** Extract bits 15:8 of s1 into t0. Then show how to replace bits 15:8 of s1 with the low eight bits of s2 while preserving all other bits.

**解**：提取`srli t0,s1,8; andi t0,t0,255`。插入需先清目标字段：

```asm
addi t0, x0, 255
slli t0, t0, 8         # mask=0xFF00
xori t0, t0, -1        # inverse mask
and  s1, s1, t0        # clear bits15:8
andi t1, s2, 255
slli t1, t1, 8
or   s1, s1, t1
```

**English explanation.** `The target field is cleared before the replacement bits are ORed in. OR alone cannot clear old one bits.`

<a id="q29"></a>

## Q29 | if-else control flow 互斥路径

Tags: #Q #C2 #if #branch #control-flow #条件分支

**Question.** A student translates `if(i==j) f=g+h; else f=g-h;` but omits the unconditional jump at the end of the then part. Explain the bug.

**解**：条件相等时先执行加法，然后顺序落入else又执行减法，最后f恒被减法覆盖。应在then后跳到Done。另检查bne/beq条件方向。

**English answer.** `When i equals j, execution falls through into the else block and overwrites the addition result. An unconditional jump must skip the else block.`

<a id="q30"></a>

## Q30 | Counting dynamic instructions 循环动态计数

Tags: #Q #C2 #dynamic-count #loop #IC #循环计数

**Question.** In the int32_t clearing loop of C2-12, assume N>0. Count the dynamically executed instructions, excluding labels and any return instruction.

**解**：循环外初始化addi1次、入口bge1次，共2。循环体slli/add/sw/addi/blt？应逐条数：实际代码体是 slli、add、sw、addi、blt，共**5条**，执行N次。因此总 `2+5N`。最后一次blt不跳但仍执行。N<=0时只执行2条。

**English answer.** `The loop executes 2+5N instructions for N>0. The final branch still counts even though it is not taken.`

**核对提醒**：本题特意按具体代码逐行数。不能把另一个多出一条load或无条件回跳的循环公式直接套进来。

<a id="q31"></a>

## Q31 | Register preservation bug 寄存器保存错误

Tags: #Q #C2 #caller-saved #callee-saved #procedure #保存

**Question.** A function copies its argument from a0 to t0, calls another function, then adds t0 to the returned a0. Is this correct under the standard calling convention?

**解**：不保证正确，callee允许改t0。可把x保存在栈槽，或放s0并先保存旧s0、返回前恢复；同时非叶函数保护自身ra，栈帧保持对齐。

**English answer.** `No. The called function may overwrite t0 because it is caller-saved. The value must be preserved in a stack slot or in a properly saved callee-saved register.`

<a id="q32"></a>

## Q32 | JALR uses the old source and clears bit zero 间接跳转

Tags: #Q #C2 #jalr #PC #return-address #间接跳转

**Question.** At PC=0x2000, x5=0x1005. Execute `jalr x5,3(x5)` with 32-bit instructions. Find the new x5 and PC.

**解**：先读旧x5=0x1005；目标=0x1005+3=0x1008，清最低位仍0x1008；链接值旧PC+4=0x2004写入x5。不能先写x5再拿0x2004算目标。0x1008满足4字节对齐。

**English answer.** `The new x5 is 0x2004 and the new PC is 0x1008. The target uses the old value of x5.`

<a id="q33"></a>

## Q33 | Structure alignment and padding 结构体布局

Tags: #Q #C2 #alignment #padding #struct #对齐

**Question.** Place `char a; int32_t b; int64_t c; char d;` in a struct. Assume alignments 1, 4, 8, and 1, and round the struct size to a multiple of its maximum alignment.

**解**：a偏移0，占1；1-3填充；b偏移4占4；c偏移8占8；d偏移16占1；17-23尾填充。总24B，align8。数组第二个元素起始相对第一个为24，不是17。

**English answer.** `The field offsets are 0,4,8,16. Tail padding rounds the total size to 24 bytes, with an alignment of 8 bytes.`

<a id="q34"></a>

## Q34 | ALU signed less-than fix 比较溢出纠正

Tags: #Q #C3 #ALU #slt #overflow #less #比较

**Question.** A 4-bit ALU computes signed 7 < -1 by subtracting B from A and using only the result's sign bit. Explain why it fails and give the corrected expression.

**解**：7-(-1)=8超signed4范围，截断1000，符号位1错误指示“小于”。V=1，因此correct less=sign XOR V=1 XOR1=0。

**English answer.** `The subtraction overflows. Signed less-than must use sign(result) XOR overflow, which gives zero in this example.`

<a id="q35"></a>

## Q35 | Minimum two's-complement value 最小负数

Tags: #Q #C3 #two-complement #minimum #negation #最小负数

**Question.** Why does negating 10000000₂ in 8-bit two's complement produce the same bit pattern? Does it mean -(-128) is mathematically -128?

**解**：取反01111111加1→10000000。数学相反数+128存在，但不在signed8最大127范围内，保留低8位后回到原位串；属于表示范围的溢出，不是数学恒等式改变。

**English answer.** `The mathematical result is +128, which is outside the signed 8-bit range. Truncation leaves the same bit pattern; this is overflow.`

<a id="q36"></a>

## Q36 | Floating-point multiplication 指数偏置

Tags: #Q #C3 #floating-multiplication #bias #normalize #浮点乘法

**Question.** Compute 1.5×(-2.5) using binary significands and exponents. Give its single-precision hexadecimal encoding.

**解**：1.5=1.1×2^0；2.5=1.01×2^1；符号负；有效数1.1×1.01=1.111；指数1；结果-3.75。S1、E128、F111000… →0xC0700000。

**English answer.** `The result is -1.111₂×2^1=-3.75, encoded as 0xC0700000 in binary32.`

<a id="q37"></a>

## Q37 | Non-associative floating-point addition 不结合性

Tags: #Q #C3 #rounding #non-associative #precision #不结合

**Question.** In binary32 with round-to-nearest, ties-to-even, let a=2^24, b=1, c=-2^24. Compare (a+b)+c and a+(b+c), rounding after each addition.

**解**：[2^24,2^25)间距2，a+b在2^24与2^24+2正中间，ties-even舍回2^24，再加c得0。b+c=-16777215可精确，再加a得1。结果0与1。

**English answer.** `The first expression evaluates to 0 and the second to 1. Intermediate rounding makes floating-point addition non-associative.`

<a id="q38"></a>

## Q38 | Division edge cases 除法边界

Tags: #Q #C3 #div #rem #divide-by-zero #overflow #除零

**Question.** For RV64 DIV/REM, state the results of dividing -2^63 by -1 and of dividing a nonzero integer x by zero.

**解**：最小负数除-1，div返回最小负数原模式，rem=0；除零div返回全1位串（signed解释-1），rem返回x。这是ISA规定结果，不表示数学除零合法；无自动整数算术陷阱。

**English answer.** `For signed division overflow, DIV returns the minimum signed value and REM returns zero. Division by zero returns an all-ones quotient and the original dividend as the remainder.`

<a id="q39"></a>

## Q39 | LR/SC status 原子存储状态

Tags: #Q #C2 #LR-SC #atomic #lock #status #同步

**Question.** After `lr.d t0,(s0)`, code executes `sc.d t1,a0,(s0)`. What does t1 contain, and why is a retry branch necessary?

**解**：t1不是内存旧值；成功0，失败非0。SC失败时没有把a0写入内存，必须返回LR重新建立预留并重试。旧值在t0，不能把t1当作旧数据。标准顺序是rd、rs2、(rs1)。

**English answer.** `t1 is a status code: zero for success and nonzero for failure. A failed conditional store must be retried with a new reservation.`

<a id="q40"></a>

## Q40 | Explain the ISA interface 英文概念简答

Tags: #Q #C1 #ISA #abstraction #microarchitecture #英文简答

**Question.** Explain why two processors implementing the same ISA can have different execution times for the same program.

**解**：相同ISA约束行为；不同实现有不同clock period、CPI、存储层次等。若执行的动态指令数相同，T=IC×CPI/f，不同CPI/f就导致不同时间。若编译条件、输入也不同，IC也可能变。

**English answer.** `The ISA specifies behavior, not a fixed implementation. Different processors can have different clock rates, execution resources, and memory systems, leading to different CPIs and execution times.`


---

# Exam English | 英语题干、答题模板、易错清单

学会识别关键词，比逐字翻译整段更重要。下面的短句用于表达你已经算出的结果；所有空格都要根据题目填，不能不看条件直接照抄。

<a id="e01"></a>

## E01 | 英文命令词与常见限定词

Tags: #English #question #verb #题干 #英语 #命令词

| English | 中文意思 | 实际要交什么 |
|---|---|---|
| calculate / compute / determine | 计算、确定 | 公式、代入、结果、单位 |
| derive | 推导 | 从已知关系一步步得到式子 |
| show your work / show intermediate steps | 展示过程/中间步骤 | 不能只交最终数字 |
| explain / justify | 解释 / 给理由 | 结论+因果关系 |
| compare / contrast | 比较 / 对比 | 同一标准下的差异与联系 |
| translate / compile | 翻译 / 编译 | 把给定语义写成要求的代码 |
| encode / assemble | 编码 | 填字段并生成位串/hex |
| decode / disassemble | 解码 / 反汇编 | 字段解释成汇编语义 |
| trace / simulate / step through | 跟踪 / 模拟 / 单步 | 按执行顺序列状态变化 |
| identify / classify | 指认 / 分类 | 如normal/NaN或I/S格式 |
| assume / given / suppose | 假设 / 已知 | 这是题目条件，优先于默认约定 |
| ignore / neglect | 忽略 | 指定项不计入模型 |
| respectively | 分别 | 前后两组按顺序一一对应 |
| at least / at most | 至少 / 至多 | 下界 / 上界，方向别反 |
| exactly / approximately | 恰好 / 近似 | 精确等式 / 数值近似 |
| minimum / maximum | 最小 / 最大 | 还要考虑可行范围和边界 |
| normalized / denormalized | 规格化 / 非规格化 | 浮点公式可能不同 |
| without changing other bits | 不改变其他位 | 必须先清字段再插入 |
| preserve / restore | 保持 / 恢复 | 调用前后状态要一致 |
| consecutive / adjacent | 连续 / 相邻 | 地址增量由元素字节数决定 |
| lower / upper half | 低半 / 高半 | 不是正数 / 负数的意思 |
| least / most significant | 最低 / 最高有效 | LSB / MSB，与最小/最大数值不同 |
| taken / not taken | 分支跳转 / 不跳转 | 分支指令无论跳不跳都会执行 |
| inclusive / exclusive | 含端点 / 不含端点 | 循环边界与范围 |
| no more than / no less than | 不多于 / 不少于 | ≤ / ≥ |
| twice as fast / half the time | 快一倍即2倍速度 / 一半时间 | 新时间=旧时间/2 |
| increases by 20% | 增加20% | 新值=旧值×1.2 |
| increases to 120% | 增加到120% | 新值=旧值×1.2 |
| reduced by 20% / to 20% | 减少20% / 减至20% | 剩0.8 / 剩0.2 |
| accounts for | 占……比例 | 看是时间、条数还是功耗比例 |
| falls through | 顺序落入下一段 | 没有发生跳转 |
| truncate toward zero | 向零截断 | -7/2=-3 |
| sign-extend / zero-extend | 符号 / 零扩展 | 补符号位 / 补0 |

<a id="e02"></a>

## E02 | 可以直接改写使用的英文作答句式

Tags: #English #answer-template #because #therefore #英文答案 #句式

| 用途 | English template | 中文 |
|---|---|---|
| 声明假设 | I assume RV64 and 32-bit instructions. | 假设RV64且指令32位 |
| 类型 | Each array element occupies eight bytes. | 每个数组元素8字节 |
| 公式 | The CPU time is IC times CPI divided by the clock rate. | 性能方程 |
| 时间代入 | The total cycle count is __, giving a CPU time of __ seconds. | 周期→时间 |
| 比较 | A is __ times as fast as B because T_B/T_A = __. | 明确速度比方向 |
| 加权 | The CPI is weighted by the dynamic instruction counts. | 按动态条数加权 |
| 上限 | The unchanged portion limits the maximum speedup to __. | 不变部分限制上限 |
| 不可行 | This target cannot be reached with a finite speedup of this part. | 有限局部加速达不到 |
| 功耗 | The voltage term is squared in the dynamic-power ratio. | 电压为平方项 |
| 地址 | The effective address is the base address plus the byte offset. | 有效地址 |
| 下标 | Multiplying the index by __ converts it to a byte offset. | 下标→字节 |
| 分支 | The offset is measured from the address of the branch itself. | 相对当前PC |
| 立即数 | The 12-bit immediate is interpreted as a signed value. | signed12立即数 |
| 小端 | The least significant byte is stored at the lowest address. | 小端定义 |
| 扩展 | The loaded value is sign-extended to 64 bits. | 符号扩展 |
| 循环 | The initial test handles the zero-iteration case. | 入口测试 |
| 保存 | This value must survive the call, so it is saved on the stack. | 跨调用保存 |
| 恢复 | The epilogue restores the saved registers and the original stack pointer. | 函数尾恢复 |
| 递归 | Each recursive invocation has its own stack frame. | 每层独立栈帧 |
| 溢出 | The exact result is outside the signed __-bit range. | 超出范围 |
| 无溢出 | The operands have opposite signs, so signed addition cannot overflow. | 异号加法无溢出 |
| 取低位 | Only the low __ bits are retained. | 截断 |
| 全加器 | The carry-out is one when at least two input bits are one. | 多数函数 |
| CLA | Lookahead logic computes carries without waiting for every preceding stage. | 提前计算 |
| Booth | The pair 10 causes subtraction before the arithmetic right shift. | 先减再算术移位 |
| 除法 | The nonzero remainder has the same sign as the dividend. | 余数随被除数 |
| 验算 | The result satisfies dividend = quotient times divisor plus remainder. | 除法恒等式 |
| 指数 | Subtracting the bias gives an unbiased exponent of __. | 指数减偏置 |
| 隐藏1 | The leading one is implicit and is not stored in the fraction field. | 隐含位 |
| 次正规 | This is subnormal, so there is no implicit leading one. | 无隐藏1 |
| 舍入 | The discarded part is exactly halfway, so ties-to-even applies. | 中点舍入 |
| 进位 | Rounding causes a carry, so the significand is renormalized. | 舍入后再规格化 |
| 不结合 | Intermediate rounding changes the result when the operations are regrouped. | 不结合性原因 |
| 工具 | The linker resolves symbols; the loader starts the executable. | 工具区分 |
| 结论 | Therefore, the required value is __. | 简洁收束 |

**最小完整答案结构**：`Using [formula], ... . Therefore, [result with unit]. This is because [one key reason].` 不需要为了英语复杂而写长句。机器码题可使用表格，列 Format / Opcode / Registers / Immediate / Hex，文字只解释容易混的字段。

<a id="e03"></a>

## E03 | 从题干抽取条件的示范

Tags: #English #reading #conditions #审题 #条件

题干：`Assume a little-endian RV64 processor. The array contains signed 32-bit integers. The base address is held in x10. Translate the statement without modifying x10.`

逐项提取：little-endian→多字节存放顺序；RV64→寄存器64位；signed32→元素4B，用lw做signed加载；base=x10；without modifying x10→地址计算用临时寄存器。不能看到RV64就用ld，也不能递增x10破坏题目要求。

题干：`The enhanced part accounts for 30% of the original execution time and is accelerated by a factor of four.`

提取：F=.3是原时间占比，s=4是局部速度比；新时间比=.7+.3/4=.775，整体S≈1.2903；不是整体4倍，也不是新时间直接减30%。

题干：`Round the significand to four bits, including the leading one, using round to nearest even.`

提取：p=4总有效位，不是4个fraction位；normal fraction仅3位；最近偶数须看GRS与保留末位。

<a id="e04"></a>

## E04 | 30 个最常见易错点速查

Tags: #pitfall #checklist #error #易错 #考前

| # | 容易错 | 正确检查 |
|---|---|---|
| 1 | GHz就是性能 | 比IC×CPI/f |
| 2 | CPI简单平均 | 用动态指令比例加权 |
| 3 | 加速百分比=省时百分比 | 速度与时间互为倒数 |
| 4 | F是新时间比例 | Amdahl F通常基于旧总时间 |
| 5 | 动态功耗只乘V | V平方 |
| 6 | 功耗比就是能量比 | 还乘运行时间比 |
| 7 | RV64指令64位 | 本套普通指令32位 |
| 8 | RV64的int为8字节 | int32_t明确4B，按题目类型 |
| 9 | word=寄存器宽度 | RISC-V word为32bit |
| 10 | A[i]偏移就是i | 要乘元素大小 |
| 11 | sd第一个操作数是目标 | 它是待存数据源 |
| 12 | load改base寄存器 | 普通load/store不自动更新base |
| 13 | lw在RV64零扩展 | lw符号扩展，lwu零扩展 |
| 14 | ori/andi立即数零扩展 | 普通I逻辑立即数符号扩展 |
| 15 | +2304可直接addi | signed12上界2047 |
| 16 | 分支相对PC+4 | 相对当前指令PC |
| 17 | B/J恢复后再乘2 | 若已包含隐含bit0，不再乘 |
| 18 | jalr也乘2 | jalr偏移按字节，清目标bit0 |
| 19 | srai等价任意signed除法 | 负数舍入方向不同 |
| 20 | slt就是条件跳转 | slt写0/1，blt才跳 |
| 21 | caller-saved由callee保证 | caller要旧值就自己保存 |
| 22 | 所有ra都自动保留 | 嵌套jal会覆盖ra |
| 23 | 进位就是signed溢出 | 分开判断 |
| 24 | signed SLT看差的符号就够 | sign XOR overflow |
| 25 | Booth的01/10顺序随意 | 明确(Q0,Q-1) |
| 26 | Booth各半独立移位 | 联合算术右移 |
| 27 | signed余数永远非负 | 非零余数随dividend |
| 28 | IEEE指数是补码 | 指数用bias编码 |
| 29 | E=0仍加隐藏1 | subnormal隐藏位0 |
| 30 | tie一律四舍五入进1 | tie看保留最低位奇偶 |

<a id="e05"></a>

## E05 | 开卷资料准备与最后一轮复习

Tags: #review #open-book #preparation #复习 #打印

建议按“题型是否能独立做”复习，而不是以读完多少页衡量：先做 Q01/Q02/Q04/Q09/Q12/Q14/Q16/Q18/Q19/Q21/Q22/Q23/Q27，再查漏对应章节。上述只是覆盖核心技能的建议组合，不是考点押题。

时间有限时，先保证性能方程、数组寻址、分支偏移、调用保存、补码溢出、Booth/恢复除法、浮点编码和舍入能按步骤写出。其余概念用英文术语表快速定位。时间充足则做完80题，并对每章末尾和附录中未熟悉内容查漏。第 4 章优先 Q41（逐线追踪）、Q42/Q43（控制信号与 Verilog）、Q45（关键路径）、Q50（I 型译码陷阱）、Q51（故障）、Q53（扩展 jalr）；最后限时做 M01 模拟卷。

电子开卷是否可使用设备、是否允许本地HTML/脚本、可携带多少纸张，须服从本次考试实际规则。HTML中的脚本只用于本地检索；若只允许纸质资料，就打印速查卡和主手册需要的章节，正文不依赖在线服务。

<a id="e06"></a>

## E06 | 与课件、旧笔记不同的地方：集中更正表

Tags: #errata #correction #source #更正 #课件笔误

| 位置 | 原说法/易误读 | 本手册采用 |
|---|---|---|
| 旧 `Computer_Organization.md` 算术入门 | 减法例仍写add | 减法应为sub |
| C2 p76 | Unicode简化为32-bit character set | 区分码位与UTF存储编码 |
| C2 p81 | addi低段写2304 | 应为signed12值-1792，高段977 |
| C2 p86 | offset=6等说明 | 6是半字单位，完整字节偏移是12；只补一次bit0 |
| C2 p93 | B分支opcode写1100111 | 正确为1100011；1100111是jalr |
| C2 p95-96 | sc.d rd,(rs1),rs2 | 标准语法sc.d rd,rs2,(rs1) |
| C2 p95 | 未改变就保证SC成功的直观描述 | 需预留有效，SC可能失败并重试 |
| C2 p112 | C中int[]，汇编用sd/stride8；无入口空循环检查 | int32用sw/stride4；int64才sd/stride8；先检查size<=0 |
| C2 p123 | sltui、重复srlw等拼写 | sltiu；sllw/srlw/sraw及相应立即数版 |
| C2部分教学栈图 | 8/24字节等简化帧可能未维持标准对齐 | 新代码保持16字节；原图按教学模型解释 |
| C3 p16等 | 溢出后生成异常的一般介绍 | 普通RISC-V整数add/sub不自动溢出陷阱 |
| C3 p64 | -143位串后箭头转成正数幅值 | signed结果保留1101110001，正幅值仅用于验算 |
| C3 p82-83 | smallest若只列normal最小值 | 明确normal与subnormal两种最小值 |
| C3 p97 | 对round表述较粗 | 用G/R/S精确定义和最近偶数规则 |
| 容量单位习惯 | KB/GB无条件等同1024幂 | 区分kB/MB与KiB/MiB，优先题目约定 |
| C4 课件与旧笔记 | sra funct7、SB opcode、rs2位域、ALUSrc“16位”、addi ALUOp 等 | 共 18 条，集中见 C4-16 |

原文件保持不变。逐页附录保留原解释及其中已有的纠错（第 4 章附录有问题的页面在页首加注）；主手册遇到同一概念时采用上表统一规则。教材示例与标准ABI/ISA有不同假设时，先辨别题目正在考哪一种模型。

<a id="e07"></a>

## E07 | Chapter 4 易错点 25 条与英文作答句式

Tags: #pitfall #English #C4 #datapath #易错 #句式 #第四章

| # | 容易错 | 正确检查 |
|---|---|---|
| 1 | PC+8（因为 RV64） | 指令 4 字节，PC+4；8 是双字数据步长 |
| 2 | 分支目标 = PC+4+offset | 目标 = 当前 PC + offset |
| 3 | jal 写回 PC+offset | 写回 PC+4，跳到 PC+offset |
| 4 | ImmGen 已含 bit0 还再左移 | 半字数输出才左移；只补一次 0 |
| 5 | rs1 在 [24:20] | rs1 [19:15]，rs2 [24:20]，rd [11:7] |
| 6 | sd 写入的数据来自 ALU | 来自 Read data 2（rs2）；ALU 只算地址 |
| 7 | sd 有 rd | S 型无 rd，inst[11:7] 是 imm[4:0] |
| 8 | RegWrite 对 sd/beq 写 X | 写使能永不为 X，必须 0 |
| 9 | MemtoReg 只有 1 位 | 课程 2 位：00 ALU/01 Mem/10 PC+4 |
| 10 | Branch=1 就跳 | 跳转条件 Branch AND Zero |
| 11 | Branch 与 Jump 合一 | 课程两信号、两级 PC MUX |
| 12 | ALUOp 就是 ALU control | ALUOp 2 位大类；ALU control 3/4 位功能码 |
| 13 | 3 位/4 位 ALU 编码混用 | 课程 p55 三位；教材 p57/p62 四位 |
| 14 | addi 用 ALUOp=10 | inst[30] 是立即数位，负立即数会被译成 sub |
| 15 | beq opcode 1100111 | 1100011；1100111 是 jalr |
| 16 | sra funct7 = 0000000 | 0100000 |
| 17 | 关键路径把并行路径相加 | 并行取 max，串行才相加 |
| 18 | 周期只看 ld | 改延迟后要重算所有类别再取最大 |
| 19 | 漏掉 clk-to-q 或 setup | 题目给了就都要加 |
| 20 | 单周期 CPI=1 所以最快 | 周期被最慢指令决定 |
| 21 | 一个存储器就够 | 单周期取指与访存同周期，须分离 |
| 22 | x0 不会被写 | 控制照常写；寄存器堆屏蔽 x0 |
| 23 | lui 读 x0 当 0 | U 型无 rs1，须 ALUSrcA 选 0 |
| 24 | jalr 用分支加法器 | 目标 rs1+imm 由 ALU 算，清 bit0，不左移 |
| 25 | Verilog default 写 X 上板 | 默认全部写确定值，写使能为 0 |

| 用途 | English template | 中文 |
|---|---|---|
| 控制信号 | For a store, RegWrite is 0 and MemWrite is 1; MemtoReg is a don't-care. | store 的信号 |
| 无关项理由 | MemtoReg is a don't-care because no register is written. | X 的理由 |
| 不可为 X | RegWrite cannot be a don't-care because asserting it would corrupt a register. | 写使能不可为 X |
| 数据来源 | The second ALU operand comes from the sign-extended immediate. | ALUSrc=1 |
| 写回 | The value written to rd comes from the data memory. | MemtoReg=01 |
| 分支 | The branch is taken only when Branch and Zero are both 1. | 分支条件 |
| 目标 | The target is the PC of the branch plus the immediate shifted left by one. | 目标地址 |
| 链接 | jal writes PC+4 to rd and loads the target into the PC. | jal 语义 |
| 关键路径 | The critical path of a load passes through the instruction memory, register file, ALU, data memory and the write-back multiplexer. | ld 关键路径 |
| 周期 | The clock period must be at least the latency of the slowest instruction, __ ps. | 最小周期 |
| 并行 | The immediate generator works in parallel with the register read, so only the longer delay counts. | 并行取最大 |
| 故障 | If ALUSrc is stuck at 0, loads and stores use a register value instead of the offset. | 故障描述 |
| 扩展 | A new multiplexer input and a new control signal are required. | 修改数据通路 |
| 单周期缺点 | Faster instructions waste the remainder of the long clock cycle. | 单周期浪费 |
| 两级译码 | Two-level decoding keeps the main control small; only R-type instructions need funct fields. | 两级译码理由 |


---

# Glossary | 英汉术语索引

以英文为检索入口，中文帮助理解。缩写与指令名可直接在离线网页搜索。表中“定位”指主手册章节编号；一行可匹配多个关键词。

<a id="v01"></a>

## V01 | Chapter 1 概念与性能术语

Tags: #glossary #vocabulary #C1 #词汇 #术语

| English / alias | 中文及简明解释 | 定位 |
|---|---|---|
| abstraction | 抽象，只保留当前层次需要的接口 | C1-02 |
| architecture | 体系结构，常指软件可见接口 | C1-02 |
| ISA, instruction set architecture | 指令集体系结构 | C1-02 |
| microarchitecture | 实现ISA的具体组织 | C1-02 |
| ABI, application binary interface | 二进制接口约定 | C2-02 |
| datapath | 数据通路，处理并传送数据 | C1-02 |
| control | 控制器，协调执行 | C1-02 |
| processor, CPU | 处理器，通常含数据通路和控制 | C1-02 |
| ALU, arithmetic logic unit | 算术逻辑单元 | C3-04 |
| input / output, I/O | 输入/输出 | C1-02 |
| memory | 存储器 | C1-02 |
| register | 寄存器，CPU内快速存储 | C2-02 |
| cache | 高速缓存，存储层次的一层 | C1-10 |
| DRAM | 动态随机存储器，常用于主存 | C1-02 |
| SRAM | 静态随机存储器，常用于cache | C1-02 |
| volatile | 易失，断电后信息通常不保留 | C1-02 |
| nonvolatile | 非易失 | C1-02 |
| stored-program concept | 存储程序思想 | C1-01 |
| von Neumann architecture | 冯·诺依曼结构 | C1-01 |
| vacuum tube | 电子管 | C1-01 |
| transistor | 晶体管 | C1-01 |
| integrated circuit, IC | 集成电路；注意IC也可指指令数 | C1-03、C1-05 |
| microprocessor | 微处理器 | C1-01 |
| embedded system | 嵌入式系统 | C1-01 |
| server | 服务器 | C1-01 |
| supercomputer | 超级计算机 | C1-01 |
| firmware | 固件 | C1-02 |
| operating system, OS | 操作系统 | C1-02 |
| frame buffer | 帧缓冲 | C1-02 |
| pixel | 像素 | C1-02 |
| wafer | 晶圆 | C1-03 |
| die, dies | 裸片，复数dies | C1-03 |
| package | 封装 | C1-03 |
| defect density | 单位面积缺陷数 | C1-03 |
| yield | 良率，可工作比例 | C1-03 |
| cost per die | 每个良品裸片的成本 | C1-03 |
| response time, latency | 响应时间/延迟 | C1-04 |
| throughput | 吞吐率，单位时间任务量 | C1-04 |
| elapsed time, wall-clock time | 实际经过时间 | C1-04 |
| CPU execution time | CPU用于本程序工作的时间 | C1-04 |
| user CPU time | 用户代码CPU时间 | C1-04 |
| system CPU time | 为程序提供系统服务的CPU时间 | C1-04 |
| performance | 性能，此处以时间倒数衡量 | C1-04 |
| speedup | 加速比，旧时间/新时间 | C1-04 |
| clock cycle | 时钟周期，一次时钟节拍 | C1-04 |
| clock period, cycle time | 每个周期的时间长度 | C1-04 |
| clock rate, frequency | 每秒周期数，Hz | C1-04 |
| instruction count, IC | 指令数，性能式通常指动态执行条数 | C1-05 |
| dynamic instruction count | 运行时实际执行条数 | C1-05 |
| static instruction count | 程序文本/代码中的指令条数 | C1-05 |
| CPI, cycles per instruction | 每条指令平均周期数 | C1-05 |
| instruction mix | 指令类别的动态比例 | C1-05 |
| weighted average | 加权平均 | C1-05 |
| bottleneck | 瓶颈 | C1-03、C1-07 |
| memory wall | 内存墙 | C1-03 |
| power wall | 功耗墙 | C1-06 |
| capacitive load, capacitance | 电容性负载/电容 | C1-06 |
| voltage | 电压 | C1-06 |
| switching activity | 开关活动 | C1-06 |
| dynamic power | 动态功耗 | C1-06 |
| leakage power | 漏电功耗 | C1-06 |
| energy | 能量，J | C1-06 |
| power | 功率/功耗，W | C1-06 |
| idle | 空闲/轻载状态 | C1-06 |
| multicore, multiprocessor | 多核/多处理器 | C1-07 |
| parallel fraction | 可并行时间比例 | C1-07 |
| serial fraction | 串行时间比例 | C1-07 |
| Amdahl's Law | 阿姆达尔定律 | C1-07 |
| benchmark | 基准测试程序 | C1-08 |
| workload | 工作负载 | C1-08 |
| SPEC ratio | 参考时间/测量时间的比值 | C1-08 |
| geometric mean | 几何平均 | C1-08 |
| arithmetic mean | 算术平均 | C1-08 |
| performance per watt | 每瓦性能/能效 | C1-08 |
| MIPS metric | 每秒百万条指令的指标 | C1-09 |
| fallacy | 错误看法/谬误 | C1-09 |
| pitfall | 容易掉进去的陷阱 | C1-09 |
| Moore's Law | 摩尔定律，历史技术趋势 | C1-10 |
| common case | 常见情况 | C1-10 |
| parallelism | 并行 | C1-10 |
| pipelining | 流水线 | C1-10 |
| pipeline stage | 流水阶段 | C1-10 |
| prediction | 预测 | C1-10 |
| memory hierarchy | 存储层次 | C1-10 |
| redundancy | 冗余 | C1-10 |
| dependability | 可信赖性 | C1-10 |

<a id="v02"></a>

## V02 | Chapter 2 指令、地址与程序术语

Tags: #glossary #vocabulary #C2 #assembly #词汇 #术语

| English / alias | 中文及简明解释 | 定位 |
|---|---|---|
| instruction | 指令 | C2-01 |
| operand | 操作数 | C2-01 |
| destination, rd | 目标寄存器 | C2-01 |
| source, rs1, rs2 | 源寄存器 | C2-01 |
| immediate | 立即数 | C2-05、C2-11 |
| assembly language | 汇编语言 | C2-01 |
| machine language, machine code | 机器语言/机器码 | C2-08 |
| high-level language | 高级语言 | C2-17 |
| load-store architecture | 主要由load/store访问内存的架构 | C2-03 |
| XLEN | 整数寄存器位宽 | C2-01 |
| byte | 字节，8bit | C2-03 |
| halfword | 半字，16bit | C2-06 |
| word | 字，RISC-V中32bit | C2-06 |
| doubleword | 双字，64bit | C2-06 |
| byte-addressed | 按字节编址 | C2-03 |
| effective address | 有效地址 | C2-03 |
| base address | 基地址 | C2-03 |
| displacement, offset | 位移/偏移 | C2-03 |
| index, subscript | 下标 | C2-03 |
| stride | 相邻元素地址步长 | C2-03 |
| pointer | 指针 | C2-15 |
| address versus value | 地址与该地址中数据的区别 | C2-03 |
| load | 从内存读取到寄存器 | C2-03 |
| store | 从寄存器写到内存 | C2-03 |
| alignment | 对齐 | C2-04 |
| padding | 填充字节 | C2-04 |
| endianness, byte order | 字节序 | C2-04 |
| little-endian | 低有效字节放低地址 | C2-04 |
| big-endian | 高有效字节放低地址 | C2-04 |
| sign extension | 符号扩展 | C2-05 |
| zero extension | 零扩展 | C2-05 |
| truncation | 截断 | C2-05 |
| mask | 掩码 | C2-07 |
| bitwise | 逐位的 | C2-07 |
| logical shift | 逻辑移位 | C2-07 |
| arithmetic shift | 算术移位 | C2-07 |
| shift amount, shamt | 移位位数 | C2-08 |
| set on less than | 小于则写1 | C2-07 |
| branch | 条件分支 | C2-10 |
| jump | 跳转 | C2-10 |
| target address | 目标地址 | C2-10 |
| PC, program counter | 程序计数器，当前指令地址 | C2-10 |
| PC-relative addressing | PC相对寻址 | C2-10 |
| fall-through | 顺序执行到下一段 | C2-12 |
| taken branch | 条件成立并跳转的分支 | C2-10 |
| branch range | 分支可达范围 | C2-10 |
| encoding | 编码 | C2-08、C2-09 |
| decoding | 解码 | C2-09 |
| disassembly | 反汇编 | C2-09 |
| opcode | 主操作码 | C2-08 |
| funct3 / funct7 | 区分具体操作的功能字段 | C2-08 |
| instruction format | 指令字段布局 | C2-08 |
| register addressing | 寄存器寻址 | C2-11 |
| immediate addressing | 立即数寻址 | C2-11 |
| base addressing | 基址+位移寻址 | C2-11 |
| upper immediate | 高位立即数 | C2-11 |
| link / return address | 链接值/返回地址 | C2-13 |
| basic block | 基本块 | C2-12 |
| control-flow graph, CFG | 控制流图 | C2-12 |
| jump table | 跳转地址表 | C2-12 |
| short-circuit evaluation | 短路求值 | C2-12 |
| procedure, function | 过程/函数 | C2-13 |
| caller | 调用者 | C2-13 |
| callee | 被调用者 | C2-13 |
| caller-saved | 调用者负责保护旧值 | C2-02 |
| callee-saved | 被调用者修改后负责恢复旧值 | C2-02 |
| leaf procedure | 不再调用其他函数的叶函数 | C2-13 |
| nested call | 嵌套调用 | C2-13 |
| recursion | 递归 | C2-14 |
| argument, parameter | 实参/形参（实际用词需看语境） | C2-13 |
| return value | 返回值 | C2-13 |
| stack pointer, sp | 栈指针 | C2-13 |
| stack frame, activation record | 栈帧/活动记录 | C2-13 |
| frame pointer, fp | 帧指针 | C2-13 |
| prologue | 函数开头建立栈帧等代码 | C2-13 |
| epilogue | 函数末尾恢复并返回的代码 | C2-13 |
| push / pop | 入栈/出栈概念 | C2-13 |
| text segment | 代码段 | C2-13 |
| static data | 静态数据 | C2-13 |
| heap | 堆，动态分配区域 | C2-13 |
| dangling pointer | 对象失效后的悬空指针 | C2-13 |
| ASCII | 128码位的字符编码 | C2-15 |
| Unicode code point | Unicode码位 | C2-15 |
| UTF-8 / UTF-16 | Unicode编码方式 | C2-15 |
| NUL / null terminator | 值0的字符串结束字节 | C2-15 |
| strength reduction | 强度削减 | C2-15 |
| induction variable | 归纳变量 | C2-15 |
| atomic operation | 原子操作 | C2-16 |
| synchronization | 同步 | C2-16 |
| race condition | 竞争条件 | C2-16 |
| critical section | 临界区 | C2-16 |
| load-reserved, LR | 预留装载 | C2-16 |
| store-conditional, SC | 条件存储 | C2-16 |
| reservation set | 预留集合 | C2-16 |
| acquire / release | 获取/释放的内存排序语义 | C2-16 |
| compiler | 编译器 | C2-17 |
| assembler | 汇编器 | C2-17 |
| object module | 目标模块 | C2-17 |
| symbol table | 符号表 | C2-17 |
| relocation | 重定位 | C2-17 |
| linker | 链接器 | C2-17 |
| loader | 装载器 | C2-17 |
| executable | 可执行程序/文件 | C2-17 |
| shared library | 共享库 | C2-17 |
| dynamic linking | 动态链接 | C2-17 |
| lazy binding | 延迟绑定 | C2-17 |
| interpreter | 解释器 | C2-17 |
| bytecode | 字节码 | C2-17 |
| JIT, just-in-time compiler | 即时编译器 | C2-17 |
| pseudo-instruction | 伪指令，由汇编器展开 | C2-18 |
| extension | 可选扩展 | C2-18 |
| RISC | 精简指令集计算风格 | C2-18 |
| CISC | 复杂指令集计算风格 | C2-18 |
| backward compatibility | 向后兼容 | C2-18 |
| micro-operation | 微操作 | C2-18 |

<a id="v03"></a>

## V03 | Chapter 3 算术与浮点术语

Tags: #glossary #vocabulary #C3 #arithmetic #词汇 #术语

| English / alias | 中文及简明解释 | 定位 |
|---|---|---|
| radix, base | 进制的基数 | C3-01 |
| binary / decimal / hexadecimal | 二/十/十六进制 | C3-01 |
| bit pattern | 位模式/位串 | C3-01 |
| signed / unsigned | 有符号/无符号 | C3-01 |
| sign bit | 符号位 | C3-01 |
| sign magnitude | 原码 | C3-01 |
| one's complement | 反码 | C3-01 |
| two's complement | 补码 | C3-01 |
| negation | 取相反数 | C3-01 |
| fixed-point | 定点数 | C3-01 |
| LSB, least significant bit | 最低有效位 | C3-01 |
| MSB, most significant bit | 最高有效位 | C3-01 |
| carry-in, carry-out | 进位输入/输出 | C3-02 |
| borrow | 借位 | C3-02 |
| overflow | 溢出 | C3-02、C3-10 |
| exception | 异常 | C3-02 |
| half adder | 半加器 | C3-03 |
| full adder | 全加器 | C3-03 |
| truth table | 真值表 | C3-03 |
| sum bit | 和位 | C3-03 |
| multiplexer, mux | 多路选择器 | C3-04 |
| zero detector | 零检测器 | C3-04 |
| ripple-carry adder | 串行进位加法器 | C3-05 |
| CLA, carry lookahead adder | 超前进位加法器 | C3-05 |
| generate, G | 本位独立产生进位 | C3-05 |
| propagate, P | 传播输入进位 | C3-05 |
| group carry | 组进位 | C3-05 |
| carry-select adder | 选择进位加法器 | C3-05 |
| carry-skip adder | 跳跃进位加法器 | C3-05 |
| gate delay | 门延迟 | C3-05 |
| fan-in | 门输入数/扇入 | C3-05 |
| critical path | 决定最大延迟的关键路径 | C3-05 |
| multiplicand | 被乘数 | C3-06 |
| multiplier | 乘数/乘法器，依语境 | C3-06 |
| product | 乘积 | C3-06 |
| partial product | 部分积 | C3-06 |
| shift-and-add | 移位加法 | C3-06 |
| Booth algorithm | Booth补码乘法算法 | C3-07 |
| arithmetic right shift | 算术右移，复制符号位 | C3-07 |
| dividend | 被除数 | C3-08 |
| divisor | 除数 | C3-08 |
| quotient | 商 | C3-08 |
| remainder | 余数 | C3-08 |
| restoring division | 恢复余数除法 | C3-08 |
| trial subtraction | 试减 | C3-08 |
| divide by zero | 除零 | C3-08 |
| truncate toward zero | 向零截断 | C3-08 |
| floating point | 浮点 | C3-09 |
| significand | 有效数/有效数字部分 | C3-09 |
| mantissa | 尾数，教材中有时泛指有效数 | C3-09 |
| fraction field | 不含隐藏位的小数字段 | C3-09 |
| exponent | 指数 | C3-09 |
| biased exponent | 加偏置后的存储指数 | C3-09 |
| unbiased exponent | 真实指数 | C3-09 |
| bias | 指数偏置 | C3-09 |
| implicit / hidden bit | 隐含位 | C3-09 |
| normalization | 规格化 | C3-09 |
| binary32 / single precision | 32位单精度格式 | C3-09 |
| binary64 / double precision | 64位双精度格式 | C3-09 |
| normal / normalized number | 正常/规格化数 | C3-10 |
| subnormal / denormal | 次正规/非规格化数 | C3-10 |
| gradual underflow | 渐进下溢 | C3-10 |
| infinity | 无穷 | C3-10 |
| NaN, not a number | 非数 | C3-10 |
| finite | 有限的 | C3-10 |
| range | 表示范围 | C3-10 |
| precision | 精度/有效位数 | C3-10 |
| machine epsilon | 常指1与后一个数的间隔 | C3-10 |
| unit roundoff | 最近舍入误差分析中的单位舍入量 | C3-10 |
| ULP, unit in the last place | 最末有效位的单位/局部间隔 | C3-10 |
| exponent alignment | 对阶 | C3-11 |
| cancellation | 相消 | C3-11 |
| renormalization | 再规格化 | C3-11 |
| non-associativity | 不满足结合律 | C3-11 |
| guard bit | 保护位，第一个额外位 | C3-12 |
| round bit | 第二个额外位 | C3-12 |
| sticky bit | 后续所有位的OR | C3-12 |
| round to nearest | 舍入到最近可表示值 | C3-12 |
| ties to even | 中点选择末位为偶的结果 | C3-12 |
| rounding toward +infinity | 向正无穷舍入 | C3-12 |
| rounding toward -infinity | 向负无穷舍入 | C3-12 |
| rounding toward zero | 向零舍入 | C3-12 |
| inexact | 不精确，结果需舍入 | C3-12 |
| absolute error | 绝对误差 | C3-12 |
| relative error | 相对误差 | C3-12 |

<a id="v04"></a>

## V04 | Chapter 4 处理器、数据通路与控制术语

Tags: #glossary #vocabulary #C4 #processor #datapath #词汇 #术语

| English / alias | 中文及简明解释 | 定位 |
|---|---|---|
| processor | 处理器，CPU | C4-01 |
| control unit, controller | 控制单元/控制器，由指令产生控制信号 | C4-01、C4-08 |
| datapath | 数据通路，处理数据与地址的元件集合 | C4-01、C4-03 |
| implementation | 实现（同一 ISA 的具体硬件组织） | C4-01 |
| single-cycle implementation | 单周期实现，每条指令一个时钟周期 | C4-11 |
| multicycle implementation | 多周期实现（补充，本 Part 未讲） | C4-11 |
| pipelined implementation | 流水线实现（Part 2） | C4-01 |
| simple subset | 简单指令子集 | C4-01 |
| memory-reference instruction | 访存指令（ld/sd） | C4-01 |
| arithmetic-logical instruction | 算术逻辑指令 | C4-01 |
| control transfer instruction | 控制转移指令（分支、跳转） | C4-01 |
| instruction class | 指令类别 | C4-06 |
| fetch | 取指 | C4-06 |
| decode | 译码 | C4-06 |
| execute | 执行 | C4-06 |
| memory access | 访存 | C4-06 |
| write back | 写回 | C4-06 |
| IF / ID / EX / MEM / WB | 取指/译码/执行/访存/写回五阶段缩写 | C4-06 |
| logic design convention | 逻辑设计约定 | C4-02 |
| asserted / deasserted | 信号有效（=1）/无效（=0） | C4-07 |
| bus | 总线，多根导线并行传多位数据 | C4-02 |
| combinational element | 组合元件，输出只取决于当前输入 | C4-02 |
| state element, sequential element | 状态元件/时序元件，能存储信息 | C4-02 |
| clock, Clk | 时钟 | C4-02 |
| clock edge, rising edge | 时钟沿，上升沿 | C4-02 |
| edge-triggered | 边沿触发 | C4-02 |
| level-sensitive, latch | 电平敏感，锁存器（对比概念） | C4-02 |
| D flip-flop | D 触发器 | C4-02 |
| write control, write enable | 写控制/写使能 | C4-02 |
| clocking methodology | 时钟方法学：何时读写信号 | C4-02 |
| clock period, cycle time | 时钟周期 | C4-11 |
| setup time | 建立时间，时钟沿前输入须稳定的时间 | C4-02 |
| hold time | 保持时间，时钟沿后输入须保持的时间 | C4-02 |
| clock-to-Q delay | 时钟到输出延迟 | C4-11 |
| propagation delay | 传播延迟 | C4-11 |
| critical path | 关键路径，决定时钟周期的最长路径 | C4-11 |
| latency | 延迟（一条指令从开始到完成的时间） | C4-11 |
| program counter, PC | 程序计数器，存当前指令地址 | C4-03 |
| next PC | 下一条指令地址（PC+4 或目标） | C4-07 |
| instruction memory | 指令存储器 | C4-03 |
| data memory | 数据存储器 | C4-03 |
| code memory | 代码存储器（即指令存储器，p6） | C4-03 |
| separate instruction and data memories | 分离的指令/数据存储器 | C4-03 |
| register file | 寄存器堆 | C4-03 |
| read register 1 / 2 | 读寄存器号端口 1/2 | C4-03 |
| write register | 写寄存器号端口 | C4-03 |
| read data 1 / 2 | 读数据输出 1/2 | C4-03 |
| write data | 写数据输入 | C4-03 |
| read port / write port | 读端口/写端口 | C4-03 |
| adder | 加法器 | C4-03 |
| increment by 4 | 加 4（指向下一条指令） | C4-03 |
| immediate generator, Imm Gen | 立即数生成器 | C4-05 |
| sign extend, sign extension unit | 符号扩展（单元） | C4-05 |
| sign-bit wire replicated | 符号位导线被复制 | C4-05 |
| re-route wires | 重新排线（立即数拼接只需连线） | C4-05 |
| shift left 1 | 左移一位（乘 2） | C4-05 |
| halfword displacement | 半字位移，偏移以 2 字节为单位编码 | C4-05 |
| displacement, offset | 位移/偏移量 | C4-05 |
| branch target address | 分支目标地址 | C4-06 |
| branch target adder | 分支目标加法器 | C4-10 |
| PC-relative | 相对 PC | C4-05 |
| link, return address | 链接，返回地址（PC+4） | C4-06 |
| multiplexer, multiplexor, mux | 多路选择器 | C4-07 |
| select line, selector | 选择线 | C4-07 |
| control signal | 控制信号 | C4-07 |
| RegWrite | 寄存器写使能 | C4-07 |
| ALUSrc, ALUSrcB | ALU 第二操作数来源选择 | C4-07 |
| MemRead | 数据存储器读使能 | C4-07 |
| MemWrite | 数据存储器写使能 | C4-07 |
| MemtoReg | 寄存器写回数据来源选择（课程 2 位） | C4-07 |
| Branch | 分支信号，与 Zero 相与产生 PCSrc | C4-07 |
| Jump | 跳转信号，选择跳转目标 | C4-07 |
| PCSrc | PC 来源选择 | C4-07 |
| Zero | ALU 结果为零标志 | C4-07、C4-09 |
| Overflow (ALU output) | ALU 溢出输出 | C4-09 |
| ALUOp | 主控制器给出的 2 位 ALU 大类 | C4-08、C4-09 |
| ALU control, ALU operation | 送给 ALU 的具体功能码（3/4 位） | C4-09 |
| Bnegate | B 取反（做减法）控制位 | C4-09 |
| main control unit, main decoder | 主控制单元/主译码器（第一级） | C4-08 |
| ALU decoder, ALU control unit | ALU 译码器（第二级） | C4-09 |
| two-level decoding | 两级译码 | C4-08 |
| truth table | 真值表 | C4-08 |
| don't care, X | 无关项 | C4-07、C4-14 |
| opcode | 操作码字段 | C4-04 |
| funct3 / funct7 | 功能字段 | C4-04 |
| rs1 / rs2 / rd | 源寄存器 1/2、目的寄存器字段 | C4-04 |
| R-format / I-format / S-format | R/I/S 格式 | C4-04 |
| SB-format, B-format | 条件分支格式 | C4-04 |
| UJ-format, J-format | 无条件跳转格式 | C4-04 |
| U-format | 高位立即数格式（lui/auipc） | C4-13 |
| field | 指令字段 | C4-04 |
| first-cut datapath | 第一版（初步）数据通路 | C4-03 |
| full datapath | 完整数据通路 | C4-10 |
| datapath with control | 带控制的数据通路 | C4-10 |
| build incrementally | 增量式构建 | C4-01 |
| compose the elements | 组合元件 | C4-03 |
| alternate data sources | 可选的多个数据源 | C4-07 |
| cause and effect | 因果关系（控制设计分析） | C4-08 |
| CPI = 1 | 单周期每条指令一个周期 | C4-11 |
| variable clock | 可变时钟（理想化比较） | C4-11 |
| stuck-at-0 / stuck-at-1 | 信号固定为 0/1 的故障 | C4-14 |
| fault | 故障 | C4-14 |
| HDL, Verilog | 硬件描述语言 | C4-08 |
| always @* | Verilog 组合逻辑块 | C4-08 |
| case statement | case 语句 | C4-08 |
| latch inference | 推断出锁存器（未赋全值的后果） | C4-08 |
| JumpReg | 为 jalr 新增的控制信号（补充） | C4-13 |
| ALUSrcA | ALU 第一操作数来源选择（lui/auipc 扩展） | C4-13 |
| nop | 空操作（addi x0,x0,0） | C4-03 |


---

# Chapter 4 | The Processor (Part 1) 处理器：单周期数据通路与控制

本章把第 2 章的指令格式与第 3 章的 ALU 拼成一台单周期 CPU。考试最常见的几类题：**给指令填控制信号**、**沿数据通路追踪每根线上的值**、**算关键路径与时钟周期**、**分析某个控制信号坏掉后哪些指令出错**、**为新指令修改数据通路**、**填 Verilog 译码器模板**。做题前先确认课程约定：MemtoReg 是 2 位、Branch 与 Jump 是两个信号、ALU 控制有 3 位（课程/实验）和 4 位（教材）两套编码。

页码为原课件 `Orga_Ch4_Risc-v_Part1_v1.1.pdf` 的物理页码（共 71 页）。

<a id="c4-01"></a>

## C4-01 | 本章地图：CPU = 数据通路 + 控制；与性能公式的接口

Tags: #C4 #processor #datapath #control #overview #CPI #处理器 #数据通路 #控制器

来源：C4 p1-5、p14。

**原文与翻译**

| 课件英文 | 中文 |
|---|---|
| Computer = CPU (Control unit + Datapath) + Memory + I/O interface | 计算机 = CPU（控制单元 + 数据通路）+ 存储器 + I/O 接口 |
| CPU performance factors: Instruction count — determined by ISA and compiler | CPU 性能因素：指令数——由 ISA 和编译器决定 |
| CPI and Cycle time — determined by CPU hardware | CPI 与时钟周期——由 CPU 硬件决定 |
| We will examine two RISC-V implementations: a simplified version; a more realistic pipelined version | 将考察两种 RISC-V 实现：简化版；更接近实际的流水线版 |
| Simple subset, shows most aspects | 简单子集，已能展示大部分要点 |
| Datapath: elements that process data and addresses in the CPU | 数据通路：CPU 中处理数据和地址的元件 |
| We will build a RISC-V datapath incrementally, refining the overview design | 我们将增量式构建 RISC-V 数据通路，逐步细化总览图 |

**性能公式接口**：`CPU time = IC × CPI × Tclk`。IC 由 ISA/编译器决定（第 2 章），CPI 与 Tclk 由本章的硬件实现决定。单周期实现：**CPI = 1**，但 **Tclk = 最慢指令（ld）的组合延迟**，见 C4-11。

**课件子集 vs 实验要求**（p4）

| 类别 | 课件讲解子集 | 实验要求（Lab） |
|---|---|---|
| 访存 Memory reference | ld, sd | lw, sw（32 位数据） |
| 算术逻辑 Arithmetic/logical | add, sub, and, or | R: add, sub, and, or, xor, slt, srl |
| 立即数 I-type ALU | — | addi, andi, ori, xori, slti, srli |
| 控制转移 Control transfer | beq | beq（SB）, jal（UJ） |

**指令执行概览**（p5、p30-31）：**每条指令前两步相同**——①用 PC 取指 fetch；②译码并读寄存器 decode & read registers。之后按类别分叉：ALU 计算算术结果 / 访存地址 / 分支比较；load/store 访问数据存储器；PC ← 目标地址或 PC+4。

**本章四节的逻辑**：4.1 为什么做（CPI、周期）→ 4.2 用什么积木（组合与时序元件）→ 4.3 怎么连（逐类指令拼通路）→ 4.4 谁来指挥（两级译码控制器）。流水线在 Part 2，不在本 Part 内。

英文：`Instruction count is determined by the ISA and the compiler, whereas CPI and cycle time are determined by the hardware implementation.`

<a id="c4-02"></a>

## C4-02 | 逻辑设计约定：组合元件、状态元件、边沿触发、时钟方法

Tags: #C4 #combinational #sequential #state-element #edge-triggered #clocking #register #write-enable #setup-time #组合逻辑 #时序逻辑 #边沿触发

来源：C4 p9-13。

**原文与翻译**

| 课件英文 | 中文 |
|---|---|
| Information encoded in binary: Low voltage = 0, High voltage = 1 | 信息以二进制编码：低电压=0，高电压=1 |
| One wire per bit; multi-bit data encoded on multi-wire buses | 一根线一位；多位数据用多根线组成的总线传输 |
| Combinational element: operate on data; output is a function of input | 组合元件：对数据运算；输出只是（当前）输入的函数 |
| State (sequential) elements: store information | 状态（时序）元件：存储信息 |
| Register: stores data in a circuit; uses a clock signal to determine when to update the stored value | 寄存器：在电路中存数据；用时钟信号决定何时更新所存值 |
| Edge-triggered: update when Clk changes from 0 to 1 | 边沿触发：Clk 由 0 变 1（上升沿）时更新 |
| Register with write control: only updates on clock edge when write control input is 1 | 带写控制的寄存器：仅当写控制输入为 1 时才在时钟沿更新 |
| Used when stored value is required later | 用于所存值以后还要用的场合 |
| Combinational logic transforms data during clock cycles, between clock edges | 组合逻辑在时钟周期内、两个时钟沿之间变换数据 |
| Input from state elements, output to state element | 输入来自状态元件，输出送往状态元件 |
| Longest delay determines clock period | 最长延迟决定时钟周期 |

**四种组合元件**（p10）：AND 门 `Y = A & B`；多路选择器 `Y = S ? I1 : I0`；加法器 `Y = A + B`；ALU `Y = F(A,B)`（F 是操作选择码，不是数学函数）。

| 类别 | 是否有记忆 | 例子 | 输出何时变化 |
|---|---|---|---|
| 组合 combinational | 无 | AND、MUX、加法器、ALU、ImmGen、控制译码器 | 输入变化后经传播延迟即变化 |
| 状态 sequential/state | 有 | PC、寄存器堆、数据存储器（写）、指令存储器（存内容） | 只在有效时钟沿（且写使能=1）更新 |

**时钟方法 clocking methodology**：状态元件 → 组合逻辑 → 状态元件。一个周期开始时状态元件输出新值，组合逻辑在本周期内算完，下一个时钟沿把结果写回状态元件。图 p13 右半为反馈形式：状态元件输出经组合逻辑再回到自身输入（例如 PC ← PC+4），因为采用**边沿触发**，同一周期内读旧值、沿上写新值，不会形成竞争。

```text
Tclk ≥ t_clk-to-q + t_comb(max) + t_setup     （补充：标准时序约束）
t_comb(min) + t_clk-to-q ≥ t_hold             （保持时间约束，单周期题一般不考）
```

**写使能的含义**：Write=0 时寄存器**保持原值**，不是清零。RegWrite 与 MemWrite 都是写控制；读操作在模型中是组合的，不需要使能（MemRead 是例外的“读使能”，见 C4-07）。

**同周期读写寄存器堆**：单周期中读端口在周期内一直输出旧值，写在周期末的时钟沿发生；所以 `add x5,x5,x5` 读到的是旧 x5，结果在沿上写回，不会出错。

英文：`State elements are updated only at the active clock edge; combinational logic between them must settle within one clock period.`

<a id="c4-03"></a>

## C4-03 | 数据通路元件全表：端口、位宽与职责

Tags: #C4 #PC #instruction-memory #register-file #data-memory #adder #ImmGen #ALU #元件 #端口 #寄存器堆

来源：C4 p6-8、p14-16、p22-23、p32-36。

| 元件 English | 中文 | 输入 | 输出 | 类型 |
|---|---|---|---|---|
| PC, program counter | 程序计数器 | next PC（64） | 当前指令地址（64） | 状态 |
| Instruction memory | 指令存储器 | Read address（PC） | Instruction[31:0] | 课程模型中视为组合读（只读） |
| Adder (PC+4) | 加 4 加法器 | PC, 常数 4 | PC+4 | 组合 |
| Registers / register file | 寄存器堆 | Read register 1/2（5 位）、Write register（5 位）、Write data（64）、RegWrite | Read data 1/2（64） | 读组合、写时序 |
| Imm Gen / Sign extend | 立即数生成器 / 符号扩展 | Instruction[31:0]（32） | 扩展后立即数（64） | 组合 |
| ALU | 算术逻辑单元 | A、B（64）、ALU operation（3/4 位） | ALU result（64）、Zero（、Overflow） | 组合 |
| Shift left 1 | 左移 1 位 | 立即数 | 立即数×2 | 纯连线 |
| Adder (branch target) | 分支目标加法器 | PC、移位后的偏移 | Sum = 分支/跳转目标 | 组合 |
| Data memory | 数据存储器 | Address、Write data、MemRead、MemWrite | Read data（64） | 写时序；读在模型中组合 |
| Mux ×3~4 | 多路选择器 | 多个数据源 + 选择信号 | 选中的数据 | 组合 |

**寄存器堆 register file 细节**（p35-36）：接收 **3 个寄存器编号**——至多 2 个读（R 型读两个；I 型实际只用一个）和 1 个写（rd）。写数据端口 Write data 是输入。**每个周期两个读端口都会读出数据**，用不用由后面的 MUX 决定（p21 “whether or not to use”）。

**x0 恒为 0**：硬件必须保证写 x0 无效（写使能在 rd=0 时屏蔽，或读 x0 永远返回 0）。所以 `jal x0, L` 硬件上仍“执行写”，但结果被丢弃。

**存储资源表**（p16）：32 个寄存器 x0-x31（数据须在寄存器中才能运算，x0 恒 0）；存储器按字节编址，顺序双字地址相差 8；课件写 “261 memory words” 应为 **2^61 个双字**（2^64 字节 / 8）。表中的 `Memory[18,446,744,073,709,551,608]` 是最后一个**双字**的起始字节地址 2^64-8。

**为什么用两个存储器**（p28、p32）：单周期中**每个元件每周期只能做一件事**（Each datapath element can only do one function at a time），取指与 ld/sd 访存发生在同一周期，因此需要**分离的指令存储器和数据存储器**（separate instruction and data memories）。同理 PC+4 与分支目标各用一个专用加法器，不能借用正在执行运算的 ALU。

**为什么是 +4**（p23、p31 “为什么是+4呢？”）：RISC-V 基础指令定长 32 位 = 4 字节，PC 存**字节地址**。RV64 中 PC 是 64 位寄存器（64-bit register），但步长仍是 4，不是 8（8 是双字数据的步长）。若支持 C 压缩扩展，下一条可能是 PC+2——本课不考虑。

英文：`Because each element can perform only one function per cycle, a single-cycle datapath needs separate instruction and data memories and a dedicated adder for PC+4.`

<a id="c4-04"></a>

## C4-04 | 指令格式与“字段 → 端口”接线；课程指令的 opcode/funct 表

Tags: #C4 #format #opcode #funct3 #funct7 #rs1 #rs2 #rd #field #wiring #字段 #接线 #机器码

来源：C4 p15-20、p41-45、p48、p64。

**字段定义**（p15）：opcode 指令基本操作；rs1 第一源寄存器；rs2 第二源寄存器；rd 目的寄存器；funct（funct3/funct7）在 opcode 内选择具体变体；Immediate 地址或立即数。

```text
          31      25 24  20 19  15 14 12 11       7 6     0
R-type  | funct7   | rs2  | rs1  | f3  | rd        | opcode |
I-type  | imm[11:0]       | rs1  | f3  | rd        | opcode |
S-type  | imm[11:5]| rs2  | rs1  | f3  | imm[4:0]  | opcode |
SB/B    |12|10:5   | rs2  | rs1  | f3  |4:1|11     | opcode |
U-type  | imm[31:12]                   | rd        | opcode |
UJ/J    |20| 10:1    |11| 19:12        | rd        | opcode |
```

**固定位置原则**：rs1 永远在 [19:15]，rs2 永远在 [24:20]，rd 永远在 [11:7]，opcode 在 [6:0]。所以寄存器堆的三个地址端口可以**直接接线**，不需要 MUX（MIPS 需要 RegDst MUX，RISC-V 不需要）。立即数因此被“打散”。

| 指令位 | 接到 | 课件写法（p48） |
|---|---|---|
| Instruction[6:0] | Control 主译码器 | Instruction[6-0] |
| Instruction[19:15] | Read register 1 | ins15-19 |
| Instruction[24:20] | Read register 2 | ins20-24 |
| Instruction[11:7] | Write register | ins7-11 |
| Instruction[31:0] | Imm Gen（立即数生成器要看整条指令） | ins0-31 |
| Instruction[30, 14:12] | ALU control（funct7 第 5 位 + funct3） | Instruction[30,14-12] |

课件 `ins15-19` 是“低位在前”的写法，Verilog 一律写 `inst[19:15]`。课件 p43 图把 rs2 标成 `bit25-20`，应为 **bit 24-20**；旧逐页笔记 p41 把 rs1/rs2 位域写反了，课件 p41 原图（rs1=bit19-15，rs2=bit24-20）是对的。

**课程指令编码表**（p18-20，已更正）

| 指令 | 格式 | opcode | funct3 | funct7 / 其他 |
|---|---|---|---|---|
| add | R | 0110011 (0x33) | 000 | 0000000 |
| sub | R | 0110011 | 000 | **0100000** |
| sll | R | 0110011 | 001 | 0000000 |
| slt | R | 0110011 | 010 | 0000000（课件表漏列，实验要求） |
| xor | R | 0110011 | 100 | 0000000 |
| srl | R | 0110011 | 101 | 0000000 |
| sra | R | 0110011 | 101 | **0100000**（课件误写 0000000） |
| or | R | 0110011 | 110 | 0000000 |
| and | R | 0110011 | 111 | 0000000 |
| lb/lh/lw/ld | I | 0000011 (0x03) | 000/001/010/011 | — |
| lbu/lhu/lwu | I | 0000011 | 100/101/110 | — |
| addi | I | 0010011 (0x13) | 000 | — |
| slti | I | 0010011 | 010 | — |
| xori / ori / andi | I | 0010011 | 100 / 110 / 111 | — |
| slli | I | 0010011 | 001 | imm[11:6]=000000 |
| srli / srai | I | 0010011 | 101 | imm[11:6]=000000 / 010000 |
| jalr | I | 1100111 (0x67) | 000 | — |
| sb/sh/sw/sd | S | 0100011 (0x23) | 000/001/010/011 | — |
| beq/bne | SB | **1100011 (0x63)** | 000/001 | 课件误写 1100111 |
| blt/bge/bltu/bgeu | SB | 1100011 | 100/101/110/111 | — |
| lui | U | 0110111 (0x37) | — | — |
| auipc | U | 0010111 (0x17) | — | — |
| jal | UJ | 1101111 (0x6F) | — | — |
| lr.d / sc.d | R(A 扩展) | 0101111 (0x2F) | 011 | funct5=00010/00011；课件写 0110011 不正确，本章不实现 |

**一位区分 add/sub、srl/sra**：两组只差 inst[30]（funct7 的第 5 位）。ALU 译码器只需引入 `inst[30]`，所以 p64 的 ALU control 输入写作 `Instruction[30,14-12]`。

**opcode 的低两位恒为 11**：课件 Verilog 模板（p61）只用 `opcode[6:2]` 五位做 case：R `01100`、load `00000`、store `01000`、branch `11000`、jal `11011`、I-ALU `00100`。

英文：`Because rs1, rs2 and rd occupy the same bit positions in every format, the register file addresses can be wired directly from the instruction.`

<a id="c4-05"></a>

## C4-05 | 立即数生成器 Imm Gen：五种拼接、符号扩展、“左移 1 位”约定

Tags: #C4 #ImmGen #immediate #sign-extend #shift-left-1 #halfword #offset #立即数生成 #符号扩展 #偏移

来源：C4 p25-27、p36、p42-45、p68-69。

```text
I  (ld/lw/addi/jalr): imm = sext(inst[31:20])                              12 位
S  (sd/sw):           imm = sext({inst[31:25], inst[11:7]})                12 位
SB (beq):  half = sext({inst[31], inst[7], inst[30:25], inst[11:8]})       = imm[12:1]
UJ (jal):  half = sext({inst[31], inst[19:12], inst[20], inst[30:21]})     = imm[20:1]
U  (lui/auipc): imm = sext({inst[31:12], 12'b0})                           （课件子集未实现）
```

课件中的 Verilog 写法（RV32 实验，扩到 32 位）：

```verilog
imm32_I  = {{20{inst[31]}}, inst[31:20]};                         // p42
imm32_S  = {{20{inst[31]}}, inst[31:25], inst[11:7]};             // p43
imm32_SB = {{20{inst[31]}}, inst[31], inst[7], inst[30:25], inst[11:8]}; // 课件p44: {19{..}}+12位 → 再<<1
imm32_UJ = {{12{inst[31]}}, inst[31], inst[19:12], inst[20], inst[30:21]};  // 课件p45: {11{..}}+20位 → 再<<1
```

**关键约定：课程/教材的 ImmGen 对 SB/UJ 输出的是“半字数”**（imm[12:1] 或 imm[20:1]），数据通路里的 **Shift left 1** 再乘 2 恢复字节偏移，然后与 PC 相加：

```text
Target = PC + (ImmGen_out << 1) = PC + byte_offset
```

课件 p44 的 `{19{bit[31]}}, bit[31], bit[7], bit[30:25], bit[11:8]` 共 19+12=31 位，左移 1 后正好 32 位——括号不配对是笔误，但“输出半字数 + 左移”这一意思是对的。

**另一种常见实现**（很多实验代码）：ImmGen 直接拼出含最低位 0 的字节偏移 `{inst[31],inst[7],inst[30:25],inst[11:8],1'b0}`，那么后面**不能再左移**。两种做法任选其一，**只补一次 0**。答题时先写明采用哪种。

**为什么左移 1 而不是 2**（p26 “halfword displacement”）：RISC-V 允许 16 位压缩指令，所以分支/跳转目标只保证 2 字节对齐，偏移以半字为单位编码。MIPS 指令只有 4 字节，因此左移 2。

**符号扩展就是复制符号位**（p27 “Sign-bit wire replicated”）：inst[31] 一根线扇出到所有高位，几乎零代价；“Just re-routes wires”指立即数拼接只是重新排线，不需要运算电路。

**范围**：I/S 立即数 -2048…+2047；SB 字节偏移 -4096…+4094（步长 2）；UJ 字节偏移 -1048576…+1048574（步长 2）。

**例**（全部由 tools/ch4_model.py 核对）

| 机器字 | 指令 | ImmGen 输出 | 字节偏移 / 用途 |
|---|---|---|---|
| 0x01053303 | ld x6,16(x10) | 16 | 地址 = x10+16 |
| 0xFE753C23 | sd x7,-8(x10) | -8 | 地址 = x10-8 |
| 0x00638663 | beq x7,x6,+12 | 6（半字） | 6<<1=12 |
| 0xFE0288E3 | beq x5,x0,-16 | -8（半字） | -16 |
| 0xFE1FF0EF | jal x1,-32 | -16（半字） | -32 |
| 0xF41FF0EF | jal x1,-192 | -96（半字） | -192 |

**R 型没有立即数**：ImmGen 对 R 型的输出无意义，ALUSrc=0 把它挡在 ALU 之外。

英文：`The immediate generator outputs the sign-extended halfword offset; the shift-left-by-one unit converts it to a byte offset before it is added to the PC.`

<a id="c4-06"></a>

## C4-06 | 各类指令的数据流：五阶段对照与“哪些部件被用到”

Tags: #C4 #R-type #load #store #beq #jal #data-flow #stage #IF #ID #EX #MEM #WB #数据流 #五阶段

来源：C4 p21、p24-26、p29-31、p37-45、p65-70。

**五步执行**（p21 原文翻译）：①Fetch 取指：从指令存储器取指，修改 PC 指向下一条；②Instruction decoding & read operand 译码与读操作数：翻译成机器控制命令，读寄存器操作数（无论用不用）；③Executive control 执行控制：控制 ALU 完成相应运算；④Memory access 访存：读或写数据存储器，只有 ld/sd；⑤Write results to register 写回：R 型把 ALU 结果写 rd，load 把存储器数据写 rd；分支指令修改 PC。

| 指令 | 取指 IF | 译码 ID | 执行 EX | 访存 MEM | 写回 WB |
|---|---|---|---|---|---|
| R 型 | 按 PC 取指 | 读 rs1、rs2 | ALU 运算 | — | ALU 结果 → rd |
| I 型 ALU（addi 等） | 按 PC 取指 | 读 rs1、扩展立即数 | ALU 运算 | — | ALU 结果 → rd |
| ld | 按 PC 取指 | 读 rs1、扩展立即数 | 算地址 rs1+imm | 读数据存储器 | 存储器数据 → rd |
| sd | 按 PC 取指 | 读 rs1、rs2、扩展立即数 | 算地址 rs1+imm | rs2 → 存储器 | — |
| beq | 按 PC 取指 | 读 rs1、rs2、扩展偏移 | 相减看 Zero；另算 PC+offset | — | 目标地址 → PC（若相等） |
| jal | 按 PC 取指 | 扩展偏移 | 目标 PC+offset（分支加法器） | — | PC+4 → rd；目标 → PC |

课件结论（p39/p70）：**单周期中每条指令一个周期完成，CPI=1；时钟周期取决于最长指令（ld 用全部 5 个阶段，其他只用 4 个，但仍要花 5 个阶段的时间）**。

**部件使用矩阵**（“是否产生有效结果”，✓ 有用，— 结果被忽略或不动作）

| 部件 | R | I-ALU | ld | sd | beq | jal |
|---|---|---|---|---|---|---|
| 指令存储器 | ✓ | ✓ | ✓ | ✓ | ✓ | ✓ |
| 寄存器读口 1（rs1） | ✓ | ✓ | ✓ | ✓ | ✓ | — |
| 寄存器读口 2（rs2） | ✓ | — | — | ✓（写出数据） | ✓ | — |
| Imm Gen | — | ✓ | ✓ | ✓ | ✓ | ✓ |
| ALU | ✓ | ✓ | ✓（地址） | ✓（地址） | ✓（减法→Zero） | — |
| 数据存储器 | — | — | 读 | 写 | — | — |
| 寄存器写口 | ✓ | ✓ | ✓ | — | — | ✓（PC+4） |
| PC+4 加法器 | ✓ | ✓ | ✓ | ✓ | ✓（不跳时） | ✓（链接值） |
| 分支目标加法器 | — | — | — | — | ✓ | ✓ |

**每类指令的三句话**

- **R 型 `add x9,x20,x21`**（p24、p65）：Read two register operands → Perform arithmetic/logical operation → Write register result。x9=rd(bit11-7)，x20=rs1(bit19-15)，x21=rs2(bit24-20)。
- **Load `ld x1,200(x2)`**（p25、p66）：Read register operands → Calculate address using 12-bit offset (use ALU, but sign-extend offset) → Read memory and update register。若 x2=1000，地址=1200，ld 读 1200-1207 共 8 字节。
- **Store `sd x1,200(x2)`**（p25、p67）：Read register operands → Calculate address → Write register value to memory。写出的数据来自 **rs2 的 Read data 2，不经 ALU**；S 型**没有 rd**。
- **Branch `beq x1,x2,offset`**（p26、p68）：Read register operands → Compare operands (use ALU, subtract and check Zero output) → Calculate target address (sign-extend displacement, shift left 1 place, add to PC value)。
- **Jal `jal x1,procedure`**（p69）：Write PC+4 to rd → Calculate target address (sign-extend, shift left 1, add to PC) → update PC。**目标用 PC，链接用 PC+4**，两者不能混。

**`addi x1,x2,4` 怎么走**（p42 图角提问）：与 ld 共用“rs1 + 立即数 → ALU”这一段（ALUSrc=1），但 MemRead=0、MemtoReg=00，ALU 结果直接写回 rd。

**课件 p68 “beq x1,x2,200”**：按标准汇编，200 是**字节**偏移，目标 = PC+200，编码进 imm[12:1] 的是 100；ImmGen 输出 100，左移 1 得 200。旧笔记 p68 表中“PC+400”是把“编码值”又乘了一次，属于双重乘 2 错误。

英文：`A store reads two registers: rs1 supplies the base address and rs2 supplies the data. It does not write the register file.`

<a id="c4-07"></a>

## C4-07 | 多路选择器与 7 个控制信号：语义表

Tags: #C4 #mux #control-signal #RegWrite #ALUSrc #MemtoReg #MemRead #MemWrite #Branch #Jump #PCSrc #控制信号 #多路选择器

来源：C4 p7-8、p40、p54、p56。

**为什么需要 MUX**（p7 “Can't just join wires together — Use multiplexers”）：两路不同的信号驱动同一根线会冲突；凡是“一个输入有多个可能来源”的地方都必须加 MUX，由控制信号选择。p40 列出三个问题，正好对应三类 MUX：

1. ALU 的第二输入：两个源寄存器（算术逻辑指令）还是基址寄存器 + 扩展后的立即数（访存指令）？→ **ALUSrc**
2. 写入寄存器堆的数据：ALU 结果（算术逻辑）还是数据存储器读出的数据（load）？（本课程还有 PC+4，给 jal）→ **MemtoReg（2 位）**
3. 写入 PC 的值：PC+4 还是分支目标地址？（本课程还有 jump 目标）→ **Branch（PCSrc）与 Jump**

**7 个控制信号 + ALU operation（课件 “There are 7+4 signals”，p54；语义表 p56）**

| Signal | 置 0（deasserted） | 置 1（asserted） |
|---|---|---|
| RegWrite | None 无动作 | Write data 上的值写入 Write register 指定的寄存器 |
| ALUSrc | ALU 第二操作数来自寄存器堆第二输出 Read data 2 | ALU 第二操作数是指令中**符号扩展后的立即数**（课件写“lower 16 bits”是 MIPS 残留，RISC-V 为 12 位立即数，经 ImmGen 扩展） |
| Branch (PCSrc) | PC 被计算 PC+4 的加法器输出取代 | PC 被计算分支目标的加法器输出取代（实际条件是 Branch AND Zero） |
| Jump | PC 由 PC+4 或分支目标取代（即由前一级决定） | PC 由加法器算出的跳转地址取代 |
| MemRead | None | 地址指定的数据存储器内容送到 Read data 输出 |
| MemWrite | None | 地址指定的数据存储器内容被 Write data 输入的值取代 |
| MemtoReg（2 位） | 00：寄存器写数据来自 ALU | 01：来自数据存储器；10：来自 PC+4 |

**分类记忆**：写使能 2 个（RegWrite、MemWrite）+ 读使能 1 个（MemRead）= p59 所说 “3 R/W”；选择信号 4 个（ALUSrc、MemtoReg、Branch、Jump）= “4 Mux”；再加 ALU operation（课件说 4 位，课程 ALU 实际 3 位，见 C4-09）。

**PC 选择逻辑**（p54、p60、p64 两级 MUX 链）：

```text
PCSrc   = Branch AND Zero                     // 与门
PC_mux1 = PCSrc ? Sum : PC+4                  // 第一级 MUX（Branch）
nextPC  = Jump  ? Sum : PC_mux1               // 第二级 MUX（jump）
等价于    nextPC = (Jump OR (Branch AND Zero)) ? (PC + (imm<<1)) : PC+4
```

beq 与 jal 共用同一个“Shift left 1 + Add”目标加法器；ImmGen 根据 opcode 给出 SB 或 UJ 格式的立即数。

**为什么 Branch 必须与 Zero 相与**：只用 Branch 会让 beq 无条件跳；只用 Zero 会让任何 ALU 结果为 0 的指令（如 `sub x1,x2,x2`、地址为 0 的 ld）误跳。

**Don't care（X）**：某信号的取值不影响该指令的正确性。必须 X 不能乱写的信号：**写使能（RegWrite、MemWrite）不能是 X**——它们一旦误为 1 就会破坏状态；MUX 选择信号在其输出不被使用时可以是 X。实际 Verilog 中把 X 写成确定值（通常 0），避免 X 传播或综合出锁存器。

英文：`RegWrite and MemWrite can never be don't-cares, because asserting them by mistake would corrupt architectural state.`

<a id="c4-08"></a>

## C4-08 | 主控制器（第一级）：真值表、Verilog 模板答案、I 型 ALUOp 陷阱

Tags: #C4 #main-control #truth-table #ALUOp #opcode #verilog #decoder #主控制器 #真值表 #译码器

来源：C4 p53-54、p58-61。

**原文**（p53）：Analyse for cause and effect：Information comes from the 32 bits of the instruction（信息来自指令的 32 位）；Selecting the operations to perform (ALU, read/write, etc.)（选择要执行的操作）；Controlling the flow of data (multiplexor inputs)（控制数据流向，即 MUX 输入）；ALU's operation based on instruction type and function code（ALU 操作基于指令类型和功能码）。

**两级译码 2-level decoder**（p58）：第一级 Main decoder 输入 opcode(7)，输出 7 个控制信号 + ALUOp(2)；第二级 ALU decoder 输入 ALUOp(2) + funct3 + funct7（实际只用 inst[30]），输出 ALU operation。这样第一级真值表只有几行，不必按 opcode×funct 组合爆炸。

**主控制器真值表**（p60，opcode 已更正）

| Instruction | OPCode | ALUSrc(B) | MemtoReg | RegWrite | MemRead | MemWrite | Branch | Jump | ALUOp1 | ALUOp0 |
|---|---|---|---|---|---|---|---|---|---|---|
| R-format | 0110011 | 0 | 00 | 1 | 0 | 0 | 0 | 0 | 1 | 0 |
| ld (I-type) | 0000011 | 1 | 01 | 1 | 1 | 0 | 0 | 0 | 0 | 0 |
| sd (S-type) | 0100011 | 1 | X | 0 | 0 | 1 | 0 | 0 | 0 | 0 |
| beq (SB-type) | **1100011**（课件误写 1100111） | 0 | X | 0 | 0 | 0 | 1 | 0 | 0 | 1 |
| jal (UJ-type) | 1101111 | X | 10 | 1 | 0 | 0 | 0 | 1 | X | X |
| I-ALU（addi 等，补充） | 0010011 | 1 | 00 | 1 | 0 | 0 | 0 | 0 | 1 | 1 |

**ALUOp 含义**（p59）：00 → ALU 做 add（ld/sd 算地址）；01 → subtract（beq 比较）；10 → 看 funct（R 型）；11 课件未定义——本手册建议给 I 型 ALU 指令使用，原因见下。

**逐行理由**：R 型不访存不跳转、写回 ALU 结果；ld 立即数做偏移、读存储器、写回存储器数据；sd 写存储器、不写寄存器（MemtoReg 无关）；beq 两寄存器相减（ALUSrc=0）、Branch=1、不写任何状态；jal 写回 PC+4（MemtoReg=10）、Jump=1，ALU 不用（ALUSrc、ALUOp 无关）。

**课件 Verilog 模板（p61）填空答案**。宏的字段顺序是 `{ALUSrc_B, MemtoReg[1:0], RegWR, MemWrite, Branch, Jump, ALUop[1:0]}`，共 9 位；注意此宏**不含 MemRead**（很多实验存储器总是读，读使能可省略或单独输出）。

```verilog
`define CPU_ctrl_signals {ALUSrc_B,MemtoReg,RegWR,MemWrite,Branch,Jump,ALUop}
always @* begin
  case (OPcode)                       // OPcode = inst[6:2]
    5'b01100: CPU_ctrl_signals = 9'b0_00_1_0_0_0_10; // R-type ALU
    5'b00000: CPU_ctrl_signals = 9'b1_01_1_0_0_0_00; // load  (lw/ld)
    5'b01000: CPU_ctrl_signals = 9'b1_00_0_1_0_0_00; // store (sw/sd)，MemtoReg 无关写 00
    5'b11000: CPU_ctrl_signals = 9'b0_00_0_0_1_0_01; // beq，MemtoReg 无关写 00
    5'b11011: CPU_ctrl_signals = 9'b0_10_1_0_0_1_00; // jal，ALUSrc/ALUop 无关写 0
    5'b00100: CPU_ctrl_signals = 9'b1_00_1_0_0_0_11; // I-type ALU (addi...)，见下方陷阱
    default:  CPU_ctrl_signals = 9'b0_00_0_0_0_0_00; // 未实现指令：不写任何状态
  endcase
end
```

| 指令 | 9 位向量 | 二进制（无下划线） |
|---|---|---|
| R | 0_00_1_0_0_0_10 | 000100010 |
| load | 1_01_1_0_0_0_00 | 101100000 |
| store | 1_00_0_1_0_0_00 | 100010000 |
| beq | 0_00_0_0_1_0_01 | 000001001 |
| jal | 0_10_1_0_0_1_00 | 010100100 |
| I-ALU | 1_00_1_0_0_0_11 | 100100011 |

**重要陷阱：I 型 ALU 指令不能直接复用 ALUOp=10**。课件 ALU 译码器在 ALUOp=10 时用 `Fun={funct3, inst[30]}` 查表。但 I 型指令的 inst[30] 是**立即数的第 10 位**，不是 funct7：

- `addi x5,x0,-1`（0xFFF00293）：inst[30]=1，Fun=0001 → 被译成 **sub**，x5 = 0-(-1) = **1**，正确应为 -1。
- `andi/ori/xori/slti x5,x6,-1`：Fun=1111/1101/1001/0101，表中没有 → 走 default（X）。
- 只有 srli/srai 的 inst[30] 才是有意义的“算术/逻辑右移”位。

修正办法（任选其一）：①主控制器对 I-ALU 输出 **ALUOp=11**，ALU 译码器在 11 时只看 funct3（funct3=101 时再看 inst[30]）；②ALU 译码器输入中把 inst[30] 与“是 R 型”相与：`b30 = inst[30] & (opcode==R || funct3==101)`。旧逐页笔记 p61 给 addi 填 ALUOp=10 而未说明此问题，按它实现会在负立即数时出错。

**default 分支**必须让 RegWrite、MemWrite、Branch、Jump 全为 0，否则遇到未实现指令会改写状态；全部信号都要赋确定值，避免锁存器。

英文：`For I-type instructions, bit 30 belongs to the immediate, so the ALU decoder must not treat it as funct7[5] unless the instruction is a shift.`

<a id="c4-09"></a>

## C4-09 | ALU 译码器（第二级）：ALUOp + funct → ALU control；3 位与 4 位两套编码

Tags: #C4 #ALU-control #ALUOp #funct3 #funct7 #ALU-decoder #encoding #ALU控制 #ALU译码器

来源：C4 p41、p55、p57、p62-63。

**课程 ALU 功能表（3 位，p55；实验以此为准）**

| ALU control lines | Function |
|---|---|
| 000 | And |
| 001 | Or |
| 010 | Add |
| 110 | Sub |
| 111 | Set on less than |
| 100 | nor（灰色，未要求实现） |
| 101 | srl |
| 011 | xor |

ALU 符号（p55）：输入 A、B，控制 Alu Operation，输出 **Zero、Result、Overflow**。beq 只用 Zero；本单周期 CPU 不处理溢出异常，Overflow 端口保留。

**3 位编码的构造**（p41 表）：最高位是 **Bnegate**（B 取反、Cin=1，即做减法），低两位 **op** 选结果：00 and、01 or、10 add、11 slt。所以 sub=1_10、slt=1_11（slt 也要做减法看符号，见 C3-04）。

| Bnegate | op | function |
|---|---|---|
| 0 | 00 | and |
| 0 | 01 | or |
| 0 | 10 | add |
| 1 | 10 | sub |
| 1 | 11 | slt |

**教材 4 位编码（p57、p62）**：AND 0000、OR 0001、add 0010、subtract 0110、slt 0111（另有 NOR 1100）。与 3 位编码的关系：去掉最高位 0 即为 3 位版本。看清题目给的是哪一张表。

**ALU 译码真值表**（p62）

| opcode | ALUOp | Operation | funct7 | funct3 | ALU function | 4 位 | 3 位 |
|---|---|---|---|---|---|---|---|
| ld | 00 | load register | XXXXXXX | xxx | add | 0010 | 010 |
| sd | 00 | store register | XXXXXXX | xxx | add | 0010 | 010 |
| beq | 01 | branch on equal | XXXXXXX | xxx | subtract | 0110 | 110 |
| R-type | 10 | add | 0000000 | 000 | add | 0010 | 010 |
| R-type | 10 | subtract | 0100000 | 000 | subtract | 0110 | 110 |
| R-type | 10 | AND | 0000000 | 111 | AND | 0000 | 000 |
| R-type | 10 | OR | 0000000 | 110 | OR | 0001 | 001 |
| R-type | 10 | SLT | 0000000 | 010 | slt | 0111 | 111 |
| R-type | 10 | XOR（实验） | 0000000 | 100 | xor | — | 011 |
| R-type | 10 | SRL（实验） | 0000000 | 101 | srl | — | 101 |

**课件 HDL 模板（p63）填空答案**：`Fun = {Fun3, Fun7}` 中 Fun7 实际是 1 位 inst[30]，所以 Fun 共 4 位。

```verilog
assign Fun = {Fun3, Fun7};            // Fun7 = inst[30]
always @* begin
  case (ALUop)
    2'b00: ALU_Control = 3'b010;      // add：计算地址
    2'b01: ALU_Control = 3'b110;      // sub：比较条件
    2'b10: case (Fun)
      4'b0000: ALU_Control = 3'b010;  // add
      4'b0001: ALU_Control = 3'b110;  // sub
      4'b1110: ALU_Control = 3'b000;  // and
      4'b1100: ALU_Control = 3'b001;  // or
      4'b0100: ALU_Control = 3'b111;  // slt
      4'b1010: ALU_Control = 3'b101;  // srl
      4'b1000: ALU_Control = 3'b011;  // xor
      default: ALU_Control = 3'b010;  // 课件写 3'bx；上板建议确定值
    endcase
    2'b11: case (Fun3)                // 补充：I-type ALU，只看 funct3
      3'b000: ALU_Control = 3'b010;   // addi
      3'b111: ALU_Control = 3'b000;   // andi
      3'b110: ALU_Control = 3'b001;   // ori
      3'b100: ALU_Control = 3'b011;   // xori
      3'b010: ALU_Control = 3'b111;   // slti
      3'b101: ALU_Control = 3'b101;   // srli（srai 需另一 ALU 功能）
      default: ALU_Control = 3'b010;
    endcase
  endcase
end
```

**4 位 ALU control 的逻辑式**（补充，只考虑上表各行，ALUOp=11 不出现；I30=inst[30]）：

```text
Op3 = 0
Op2 = ALUOp0 + ALUOp1·(I30 + f3[1]·f3[2]')      // beq、sub、slt
Op1 = ALUOp1' + f3[2]'                           // 除 and/or 外都为 1
Op0 = ALUOp1·f3[1]·f3[0]'                        // or(110)、slt(010)
```

逐行代入可验证：ld/sd(00)→0010；beq(01)→0110；add→0010；sub→0110；and(111)→0000；or(110)→0001；slt(010)→0111。

**ALUOp 与 ALU operation 不要混**：ALUOp（2 位）是主控制器给出的“大类”；ALU operation/ALU control（3 或 4 位）是 ALU 译码器给 ALU 的具体功能码。它们也都**不是**指令的 opcode/funct。

英文：`The main control unit produces a two-bit ALUOp; the ALU control unit combines ALUOp with funct3 and bit 30 to select the actual ALU operation.`

<a id="c4-10"></a>

## C4-10 | 完整数据通路 + 控制：一张图读懂所有连线

Tags: #C4 #full-datapath #datapath-with-control #PCSrc #Zero #AND-gate #完整数据通路 #带控制的数据通路

来源：C4 p46-52、p60、p64。

**组装顺序**（p46 → p47 → p54 → p64）：先合并 R/ld/sd（两个 MUX：ALUSrc、MemtoReg）→ 加分支（Shift left 1、第二个 Add、PC 前 MUX）→ 加 jal（第二级 PC MUX、MemtoReg 第三输入 PC+4）→ 接上 Control 与 ALU control。

```text
          ┌──────────── Add(+4) ─────────────┬──────────────────────┐ PC+4
          │                                   │                      ▼
 PC ──► Instruction memory ──► inst[31:0]     │        ┌──► MemtoReg mux (10)
  ▲        │ inst[6:0] ──► Control ──► RegWrite, ALUSrc, MemRead, MemWrite,
  │        │                          MemtoReg, Branch, Jump, ALUOp
  │        │ inst[19:15] ─► Read reg 1 ─► Read data 1 ─────────► ALU A
  │        │ inst[24:20] ─► Read reg 2 ─► Read data 2 ─┬─► ALUSrc mux(0) ─► ALU B
  │        │                                           └─► Data memory Write data
  │        │ inst[11:7]  ─► Write reg
  │        │ inst[31:0]  ─► Imm Gen ─┬─► ALUSrc mux(1)
  │        │                         └─► Shift left 1 ─► Add(PC+...) ─► Sum
  │        │ inst[30,14:12] + ALUOp ─► ALU control ─► ALU operation
  │   ALU result ─► Data memory Address ; ALU result ─► MemtoReg mux(00)
  │   Data memory Read data ─► MemtoReg mux(01) ─► Register Write data
  │   Zero AND Branch ─► mux1(PC+4 / Sum) ─► Jump mux(mux1 / Sum) ─► PC
  └──────────────────────────────────────────────────────────────────┘
```

**各指令的通路高亮（p49-52，红色控制、紫色数据）**

| 指令 | ALU B 来源 | ALU 功能 | 存储器 | 写回 | next PC |
|---|---|---|---|---|---|
| R | Read data 2 | 由 funct 决定 | — | ALU 结果 | PC+4 |
| I-ALU | 立即数 | 由 funct3 决定 | — | ALU 结果 | PC+4 |
| ld | 立即数 | add | 读 | 存储器数据 | PC+4 |
| sd | 立即数 | add | 写 Read data 2 | — | PC+4 |
| beq | Read data 2 | sub → Zero | — | — | Zero ? Sum : PC+4 |
| jal | （不用） | （不用） | — | PC+4 | Sum |

**读图易错**：①分支加法器的输入是 **PC**（当前指令地址），不是 PC+4；②Shift left 1 在加法之前；③sd 写入存储器的数据线从 Read data 2 直接引出，绕过 ALU；④jal 的链接值 PC+4 来自 **第一个** 加法器，目标来自 **第二个** 加法器；⑤ld 的写回值来自存储器 Read data，不是 ALU result；⑥p60 主控制器图中写回 MUX 画成 1 位（1 上 0 下），表格却是 2 位 MemtoReg——以表格为准，并注意 MUX 端口编号的上下顺序因图而异。

**验图方法**：任选一条指令，从 opcode 出发查 C4-08 真值表，逐个 MUX 检查选择端；再从 PC 出发沿数据线走到每个状态元件的输入。

英文：`The branch target adder adds the shifted immediate to the PC of the branch itself, and the AND of Branch and Zero selects that target.`

<a id="c4-11"></a>

## C4-11 | 单周期时序：关键路径、时钟周期、CPI 与性能

Tags: #C4 #critical-path #clock-period #single-cycle #latency #timing #CPI #performance #关键路径 #时钟周期 #单周期

来源：C4 p13、p39、p70；计算模型为补充（与 C1 性能公式衔接）。

**方法**：给每个节点标“最早稳定时间”，`t(out) = max(t(所有输入)) + 元件延迟`。状态元件输出在 t=clk-to-q 时可用；写入状态元件要再加 setup。**并行支路取最大值，不是相加**。

```text
R-type : clk-q + IMem + max(RegRead, ImmGen, Control) + Mux(ALUSrc) + ALU + Mux(MemtoReg) + RegSetup
ld     : clk-q + IMem + RegRead + Mux + ALU + DMem + Mux + RegSetup          ← 通常最长
sd     : clk-q + IMem + RegRead + Mux + ALU + DMem（写）                      （无写回）
beq    : max( clk-q+IMem+RegRead+Mux+ALU+AND , clk-q+IMem+ImmGen+Adder ) + Mux + Mux + PCSetup
jal    : max( clk-q+IMem+ImmGen+Adder + Mux(Jump) + PCSetup , PC+4 写回路径 )
```

**示例延迟（自编，用于 Q45-Q47；单位 ps）**：clk-to-q 30，IMem 200，Control 40，ALU control 30，RegRead 100，ImmGen 30，Mux 20，ALU 120，DMem 250，Setup 20，Adder 70，AND 5，Shift left 1 = 0（连线）。

| 指令类 | 计算 | 延迟 |
|---|---|---|
| R / I-ALU | 30+200+100+20+120+20+20 | **510** |
| ld | 30+200+100+20+120+250+20+20 | **760** |
| sd | 30+200+100+20+120+250 | **720** |
| beq | Zero 在 470，AND 475；目标 330 先到；475+20+20+20 | **535** |
| jal | 目标 330 → Jump mux 350 → setup 370；写回 PC+4 路径 310 | **370** |

**单周期时钟必须取最大值 760 ps**（≈1.316 GHz）。若能“每类指令用自己的周期”（理想可变时钟），按混合 25% ld、10% sd、30% R、15% I-ALU、15% beq、5% jal：平均 = 590.25 ps，比固定周期快 760/590.25 ≈ **1.288 倍**。这就是课件所说“ld 用全部 5 个阶段，其他指令仍要花 5 个阶段的时间”的量化含义，也是流水线的动机。

**控制路径是否在关键路径上**：本例 Control 在 270 ps 给出 ALUSrc，早于寄存器数据 330 ps，ALU control 在 300 ps 也早于数据，所以不在关键路径上。若题目给的控制延迟很大，必须把 `max(数据, 选择信号)` 写进 MUX 节点。

**单周期的两个代价**（p39、p70）：①时钟被最慢指令绑架，大多数指令浪费周期剩余时间；②元件不能复用，需要两个存储器、两个额外加法器。单周期 CPI=1 并不代表性能最好：`CPU time = IC × 1 × Tclk(最长)`。

**常见问法**：“Which instruction determines the clock period?” → ld（若题目延迟不同，要重新比较，不能背答案）。“What is the minimum clock period?” → 各类指令关键路径的最大值。“If the data memory is made faster…” → 重新算所有类，周期取新最大值，再算加速比。

英文：`In a single-cycle design every instruction takes one clock cycle, so the clock period must accommodate the slowest instruction, which is the load.`

<a id="c4-12"></a>

## C4-12 | 完整逐线追踪：一段 9 条指令程序在单周期数据通路上的所有值

Tags: #C4 #trace #wire-values #simulation #machine-code #单周期追踪 #信号值 #逐线追踪

来源：自编综合例；机器码、每根线的值和最终状态由 tools/ch4_model.py 模拟核对。约定：RV64，PC 初值 0x1000；初始 x8=0x55，x10=0x2000，其余寄存器 0；Mem[0x2010]=0x37（8 字节）。ImmGen 对 beq/jal 输出半字数。

```asm
0x1000  addi x5, x0, 8        # 00800293
0x1004  ld   x6, 16(x10)      # 01053303
0x1008  add  x7, x5, x6       # 006283B3
0x100C  sd   x7, -8(x10)      # FE753C23
0x1010  beq  x7, x6, +12      # 00638663  不跳
0x1014  sub  x28, x6, x5      # 40530E33
0x1018  beq  x0, x0, +8       # 00000463  跳到 0x1020
0x101C  add  x0, x0, x0       # 被跳过
0x1020  jal  x1, -32          # FE1FF0EF  回到 0x1000
```

**寄存器读端口与 ImmGen**（注意：读口 2 永远按 inst[24:20] 读出，即使指令不用它）

| PC | 指令 | rs1 → Read data 1 | inst[24:20] → Read data 2 | rd 字段 | ImmGen |
|---|---|---|---|---|---|
| 0x1000 | addi x5,x0,8 | x0 → 0 | x8 → 0x55（不用） | 5 | 8 |
| 0x1004 | ld x6,16(x10) | x10 → 0x2000 | x16 → 0（不用） | 6 | 16 |
| 0x1008 | add x7,x5,x6 | x5 → 0x8 | x6 → 0x37 | 7 | （无意义） |
| 0x100C | sd x7,-8(x10) | x10 → 0x2000 | x7 → 0x3F | 24（=imm[4:0]，不写） | -8 |
| 0x1010 | beq x7,x6,+12 | x7 → 0x3F | x6 → 0x37 | 12（不写） | 6 |
| 0x1014 | sub x28,x6,x5 | x6 → 0x37 | x5 → 0x8 | 28 | （无意义） |
| 0x1018 | beq x0,x0,+8 | x0 → 0 | x0 → 0 | 8（不写） | 4 |
| 0x1020 | jal x1,-32 | x31 → 0（不用） | x1 → 0（不用） | 1 | -16 |

**ALU、存储器、写回与 next PC**

| PC | ALUSrc | ALU B | ALU ctl | ALU result | Zero | DMem | MemtoReg → Write data | RegWrite | Branch/Jump | Sum | next PC |
|---|---|---|---|---|---|---|---|---|---|---|---|
| 0x1000 | 1 | 8 | 010 add | 0x8 | 0 | — | 00 → 0x8 | 1 | 0/0 | 0x1010 | 0x1004 |
| 0x1004 | 1 | 16 | 010 add | 0x2010 | 0 | 读 0x37 | 01 → 0x37 | 1 | 0/0 | 0x1024 | 0x1008 |
| 0x1008 | 0 | 0x37 | 010 add | 0x3F | 0 | — | 00 → 0x3F | 1 | 0/0 | — | 0x100C |
| 0x100C | 1 | -8 | 010 add | 0x1FF8 | 0 | 写 0x3F → [0x1FF8] | X | 0 | 0/0 | 0x0FFC | 0x1010 |
| 0x1010 | 0 | 0x37 | 110 sub | 0x8 | 0 | — | X | 0 | 1/0 | 0x101C | 0x1014（不跳） |
| 0x1014 | 0 | 0x8 | 110 sub | 0x2F | 0 | — | 00 → 0x2F | 1 | 0/0 | — | 0x1018 |
| 0x1018 | 0 | 0 | 110 sub | 0 | 1 | — | X | 0 | 1/0 | 0x1020 | **0x1020**（跳） |
| 0x1020 | X | — | X | （不用） | — | — | 10 → 0x1024 | 1 | 0/1 | 0x1000 | **0x1000** |

**最终状态**：x1=0x1024，x5=0x8，x6=0x37，x7=0x3F，x28=0x2F，x8、x10 不变；Mem[0x1FF8]=0x3F。0x101C 的指令从未执行。

**逐条要点**：sd 的 rd 字段 24 其实是 imm[4:0]——RegWrite=0 所以不会写 x24（见 C4-14 故障例）。0x1010 的 beq：Sum 已算出 0x101C，但 Zero=0，第一级 MUX 选 PC+4。jal 的 Sum=0x1020+(-16<<1)=0x1000，写回的是 PC+4=0x1024。表中 R 型和 jal 的 ImmGen/Sum 列虽然有电信号，但不被任何被选中的 MUX 使用。

英文：`Although the immediate field is irrelevant for an R-type instruction, the immediate generator and the branch adder still produce values; the multiplexer control simply ignores them.`

<a id="c4-13"></a>

## C4-13 | 为新指令修改数据通路：addi、bne、jalr、lui、auipc、slli、lw/lb

Tags: #C4 #extend-datapath #new-instruction #jalr #lui #auipc #bne #addi #modification #扩展指令 #修改数据通路

来源：课件实验要求 p4（addi、andi、ori、xori、slti、srli、lw、sw、jal）+ 常见考题补充。答题模板：**①需要哪些新数据通路（新 MUX 输入/新连线/新元件）②需要哪些新控制信号 ③给出该指令的全部控制信号值 ④确认不影响原有指令。**

| 指令 | 数据通路改动 | 控制信号值（未列者同 0） |
|---|---|---|
| addi/andi/ori/xori/slti（I-ALU） | 无需新元件；ImmGen 支持 I 格式 | ALUSrc=1，MemtoReg=00，RegWrite=1，ALUOp=11（ALU 译码器按 funct3） |
| srli/slli/srai | ALU 增加移位功能；B 只用低 6 位（RV64）/5 位（RV32） | 同 I-ALU；srai 需看 inst[30] |
| lw / lb / lbu | 数据存储器按 funct3 选择宽度，读出后加符号/零扩展单元 | 同 ld：ALUSrc=1，MemRead=1，MemtoReg=01，RegWrite=1，ALUOp=00 |
| sw / sb | 存储器按 funct3 写字节掩码 | 同 sd |
| bne | PCSrc 改为 `Branch AND (Zero XOR funct3[0])`（beq f3=000，bne f3=001）或新增 BranchNE 信号 | Branch=1，ALUSrc=0，ALUOp=01，RegWrite=0 |
| blt/bge | 不能用 Zero；需 ALU 的 less 输出（slt 结果位/符号⊕溢出），PCSrc=Branch AND (less XOR f3[0]) | ALUOp 选 slt 或 sub+标志 |
| jalr rd, imm(rs1) | **新增 PC MUX 输入：ALU result & ~1**（目标 = rs1+imm，最低位清 0）；新控制信号 JumpReg（或把 Jump 扩成 2 位） | ALUSrc=1，ALU add（ALUOp=00），MemtoReg=10，RegWrite=1，JumpReg=1，Branch=0 |
| lui rd, imm | ImmGen 增加 U 格式（inst[31:12]<<12）；ALU A 口加 MUX 可选 **0**，或 ALU 增加“pass B”功能 | ALUSrc=1，ALUSrcA=0（零），ALU add，MemtoReg=00，RegWrite=1 |
| auipc rd, imm | 同 lui 的 U 立即数；ALU A 口 MUX 选 **PC** | ALUSrc=1，ALUSrcA=PC，ALU add，MemtoReg=00，RegWrite=1 |

**jalr 细节**：目标用 rs1 的**旧值**，链接写入 rd 发生在周期末，所以 `jalr x1, 0(x1)` 也正确；jalr 的偏移**不乘 2**，不能走 Shift left 1 + Add 这条路径。

**lui 细节**：U 型没有 rs1 字段，inst[19:15] 是立即数的一部分，Read data 1 读出的是“某个随机寄存器”，所以 ALU A 必须被强制为 0（不能假设是 x0）。

**为什么 jal 可以复用 beq 的加法器而 jalr 不行**：jal 目标 = PC + 立即数（和 beq 同型）；jalr 目标 = 寄存器 + 立即数（和 ld 同型，用 ALU）。

英文：`To support jalr, the ALU computes rs1 plus the sign-extended immediate, the least significant bit is cleared, and a new multiplexer input routes this value to the PC.`

<a id="c4-14"></a>

## C4-14 | 控制信号故障（stuck-at）分析与 don't care

Tags: #C4 #stuck-at #fault #control-signal #dont-care #故障分析 #信号卡死 #无关项

来源：常见考题补充（教材 “stuck-at-0/1” 题型）；以 C4-08 的真值表和 C4-12 的程序为依据。方法：**对每条指令，比较“正确值”与“卡死值”；若不同且该信号在该指令中不是 X，则该指令出错。**

| 故障 | 出错的指令 | 原因 / 现象 |
|---|---|---|
| RegWrite stuck-at-0 | R、I-ALU、ld、jal | 结果无法写回 |
| RegWrite stuck-at-1 | sd、beq | 把 MemtoReg 选中的值写入 inst[11:7] 指定的寄存器（sd 中是 imm[4:0]，beq 中是 imm[4:1|11]） |
| ALUSrc stuck-at-0 | I-ALU、ld、sd | ALU B 用了 inst[24:20] 号寄存器的值代替立即数 |
| ALUSrc stuck-at-1 | R、beq | 用 ImmGen 输出代替 rs2；beq 比较错误 |
| MemtoReg stuck-at-00 | ld、jal | ld 写回地址，jal 写回 ALU 结果而非 PC+4 |
| MemtoReg stuck-at-01 | R、I-ALU、jal | 写回存储器读出值（R 型时 MemRead=0，值无意义） |
| MemRead stuck-at-0 | ld | 读不出数据 |
| MemRead stuck-at-1 | （理想模型下无功能错误） | 多余读；实际可能因非法地址异常或增加功耗 |
| MemWrite stuck-at-1 | 除 sd 外几乎所有 | 每条指令都把 Read data 2 写到 ALU result 地址，破坏内存 |
| Branch stuck-at-0 | beq（相等时） | 永不跳转 |
| Branch stuck-at-1 | 任何 Zero=1 的非分支指令 | 如 `sub x1,x2,x2`、地址为 0 的访存、结果为 0 的 add，都会误跳到 PC+(imm<<1) |
| Jump stuck-at-0 | jal | 写了链接但不跳 |
| Jump stuck-at-1 | 除 jal 外全部（恰好成立的 beq 除外，它本来就跳到同一目标） | 每条指令都跳到 PC+(ImmGen<<1) |
| ALUOp stuck-at-00 | R（除 add）、beq | 都变成 add；beq 用 a+b 判零 |

**结合 C4-12 的具体例子**

- `sd x7,-8(x10)` 若 RegWrite 卡在 1：MemtoReg 在 sd 中是 X，若实现为 00，则 x24 ← ALU result = 0x1FF8。
- `ld x6,16(x10)` 若 ALUSrc 卡在 0：ALU B = Read data 2 = x16 = 0，地址变成 0x2000 而不是 0x2010。
- `sd x7,-8(x10)` 若控制把它当作 I 型立即数译码：ImmGen 输出 sext(inst[31:20]) = -25，地址 0x1FE7——说明 ImmGen 必须按 opcode 选择格式。

**哪些信号可以设计成 X**：只有其输出不被使用的 MUX 选择端（sd/beq 的 MemtoReg，jal 的 ALUSrc/ALUOp）。写使能、Branch、Jump 不能为 X。

英文：`If RegWrite is stuck at one, store and branch instructions will incorrectly write a value into the register selected by bits 11 to 7.`

<a id="c4-15"></a>

## C4-15 | 课件核心英文原句与翻译（考英语题干必读）

Tags: #C4 #English #translation #sentence #原句 #翻译 #英文 #课件原文

| 页 | English | 中文 |
|---|---|---|
| p5 | For every instruction, the first two steps are identical: fetch the instruction from the memory; decode and read the registers. | 每条指令前两步相同：从存储器取指；译码并读寄存器。 |
| p5 | Next steps depend on the instruction class: memory-reference, arithmetic-logical, branches. | 后续步骤取决于指令类别：访存、算术逻辑、分支。 |
| p5 | Use ALU to calculate arithmetic result, memory address for load/store, branch comparison. | 用 ALU 计算算术结果、load/store 的地址、分支比较。 |
| p6 | Send PC to the code memory. Read one or two registers. | 把 PC 送到代码（指令）存储器；读一个或两个寄存器。 |
| p7 | Can't just join wires together. Use multiplexers. | 不能把导线直接接在一起，要用多路选择器。 |
| p8 | Different sources for unit. Control the units: read memory, write memory. | 部件的数据来源不同；控制各部件：读存储器、写存储器。 |
| p11 | Edge-triggered: update when Clk changes from 0 to 1. | 边沿触发：Clk 从 0 变 1 时更新。 |
| p12 | Only updates on clock edge when write control input is 1. | 只有写控制输入为 1 时才在时钟沿更新。 |
| p13 | Longest delay determines clock period. | 最长延迟决定时钟周期。 |
| p14 | We will build a RISC-V datapath incrementally. | 我们将增量式地构建 RISC-V 数据通路。 |
| p21 | Will be translated into machine control command. | （指令）将被翻译成机器控制命令。 |
| p25 | Calculate address using 12-bit offset. Use ALU, but sign-extend offset. | 用 12 位偏移计算地址：用 ALU，但偏移要符号扩展。 |
| p26 | Shift left 1 place (halfword displacement). Add to PC value. | 左移 1 位（半字位移），再与 PC 相加。 |
| p27 | Just re-routes wires. Sign-bit wire replicated. | 只是重新排线；符号位导线被复制。 |
| p28 | First-cut data path does an instruction in one clock cycle. | 第一版数据通路在一个时钟周期内完成一条指令。 |
| p28 | Each datapath element can only do one function at a time. Hence, we need separate instruction and data memories. | 每个数据通路元件同一时间只能完成一个功能，因此需要分离的指令和数据存储器。 |
| p28 | Use multiplexers where alternate data sources are used for different instructions. | 不同指令使用不同数据源的地方用多路选择器。 |
| p53 | Analyse for cause and effect. Information comes from the 32 bits of the instruction. | 分析因果关系：信息来自指令的 32 位。 |
| p53 | Controlling the flow of data (multiplexor inputs). | 控制数据流向（多路选择器的输入）。 |
| p56 | Effect when deasserted (=0) / Effect when asserted (=1). | 信号无效（=0）时的效果 / 有效（=1）时的效果。 |
| p57 | Load/Store: F = add; Branch: F = subtract; R-type: F depends on opcode. | load/store：ALU 做加法；分支：减法；R 型：取决于（funct）编码。 |
| p62 | ALU operation is decided by 2-bit ALUOp derived from opcode, and funct7 & funct3 fields. Combinational logic derives ALU control. | ALU 操作由 opcode 导出的 2 位 ALUOp 以及 funct7、funct3 决定；用组合逻辑导出 ALU 控制。 |

**常用动词**：assert 置为有效（=1）；deassert 置为无效（=0）；fetch 取指；decode 译码；sign-extend 符号扩展；route 布线/引导；select 选择；drive 驱动；latch 锁存；settle 稳定下来；propagate 传播。

<a id="c4-16"></a>

## C4-16 | Chapter 4 课件与旧笔记勘误表

Tags: #C4 #errata #correction #更正 #笔误 #勘误

| 位置 | 原文 / 旧说法 | 正确 |
|---|---|---|
| 课件 p2、p40 | multiplexo(r)s / Muplexor | multiplexer，同一元件 |
| 课件 p16 | 261 memory words | 2^61 个双字；最后一个双字起址 2^64-8 |
| 课件 p17 | bltu 语义写 `x5 >= x6` | bltu：if (x5 < x6) unsigned |
| 课件 p17 | `and x5,x6,3`，注释“算术右移” | R 型 and 无立即数：`and x5,x6,x7`，按位与 |
| 课件 p18 | sra 的 funct7 = 0000000 | 0100000 |
| 课件 p18 | lr.d/sc.d opcode 0110011 | 0101111（A 扩展），本章不实现 |
| 课件 p20、p60 | SB 型（beq 等）opcode 1100111 | 1100011；1100111 是 jalr |
| 课件 p43 | rs2 标 bit25-20 | bit 24-20 |
| 课件 p44 | `imm32={19{bit[31]}},…` 括号不配对 | <code v-pre>{{19{inst[31]}}, inst[31], inst[7], inst[30:25], inst[11:8]}</code> 再左移 1 |
| 课件 p45 | `rs/rt`、`bit21-25/16-20` 标签 | MIPS 残留；RISC-V 为 rs1[19:15]、rs2[24:20] |
| 课件 p54 | 7+4 signals | 课程 ALU 控制 3 位（p55），教材 4 位（p57） |
| 课件 p56 | ALUSrc=1：sign-extended lower 16 bits | RISC-V：ImmGen 扩展的 12 位立即数 |
| 课件 p60 图 | 写回 MUX 画成 1 位 | 课程 MemtoReg 为 2 位（00 ALU/01 存储器/10 PC+4） |
| 旧笔记 p41 | rs1=bit24-20、rs2=bit19-15 | rs1=[19:15]，rs2=[24:20]（课件原图正确） |
| 旧笔记 p49 | 访存“通常几十个周期量级” | 单周期模型中存储器延迟只是组合延迟的一部分；不要混入 cache 缺失概念 |
| 旧笔记 p61 | addi 的 ALUop=10 | 会被 inst[30] 误译（负立即数时成 sub），用 ALUOp=11 或屏蔽 inst[30]，见 C4-08 |
| 旧笔记 p68 | 表中“PC+400” | beq 汇编偏移 200 为字节偏移，目标 PC+200 |
| 旧笔记 p44 | 称课件公式“笔误”且是 13 位后再左移 | 课件意思正确：ImmGen 输出 imm[12:1]，左移 1 恢复字节偏移；只是括号笔误 |


---

# Extended Problems | 扩展题库 Q41-Q80（Chapter 4 新增 + Chapter 1-3 加练）

Q41-Q62 为第 4 章单周期处理器题；Q63-Q80 为第 1-3 章加练。全部为自编练习（标“课件”者取自课件例子），不是历年真题。数值、机器码、追踪表和关键路径都由 `tools/verify_content.py` 与 `tools/ch4_model.py` 独立核对。每题格式：英文题目 → 中文解题 → 英文答案。

<a id="q41"></a>

## Q41 | Trace the single-cycle datapath 单周期逐线追踪

Tags: #Q #C4 #trace #wire-values #datapath #追踪 #单周期

**Question.** Using the single-cycle datapath of Chapter 4, trace the program in C4-12 (PC starts at 0x1000; x8=0x55, x10=0x2000; Mem[0x2010]=0x37). For each executed instruction give Read data 1, Read data 2, the ALU result, Zero, the value written to the register file and the next PC.

**解**：按 C4-12 两张表逐条填写。要点：①Read data 2 永远按 inst[24:20] 读出（addi 读出 x8=0x55，但 ALUSrc=1 不用它）；②ld 地址 0x2000+16=0x2010，写回 0x37；③sd 地址 0x2000-8=0x1FF8，写入 x7=0x3F，不写寄存器；④第一个 beq 0x3F-0x37=8，Zero=0 不跳；⑤第二个 beq 0-0=0，Zero=1，next PC=0x1018+8=0x1020；⑥jal 写 x1=0x1024，next PC=0x1020-32=0x1000。

| PC | Read data 1 | Read data 2 | ALU result | Zero | Write data | next PC |
|---|---|---|---|---|---|---|
| 0x1000 | 0 | 0x55 | 0x8 | 0 | x5←0x8 | 0x1004 |
| 0x1004 | 0x2000 | 0 | 0x2010 | 0 | x6←0x37 | 0x1008 |
| 0x1008 | 0x8 | 0x37 | 0x3F | 0 | x7←0x3F | 0x100C |
| 0x100C | 0x2000 | 0x3F | 0x1FF8 | 0 | （不写） | 0x1010 |
| 0x1010 | 0x3F | 0x37 | 0x8 | 0 | （不写） | 0x1014 |
| 0x1014 | 0x37 | 0x8 | 0x2F | 0 | x28←0x2F | 0x1018 |
| 0x1018 | 0 | 0 | 0 | 1 | （不写） | 0x1020 |
| 0x1020 | 0 | 0 | （不用） | — | x1←0x1024 | 0x1000 |

**English answer.** `The load computes the address 0x2010 and writes 0x37 to x6. The first beq is not taken because the difference is 8, while beq x0,x0 is taken to 0x1020. jal writes 0x1024 to x1 and jumps back to 0x1000.`

<a id="q42"></a>

## Q42 | Fill in the control signals 控制信号填表

Tags: #Q #C4 #control-signal #truth-table #dont-care #控制信号 #填表

**Question.** Give the values of ALUSrc, MemtoReg, RegWrite, MemRead, MemWrite, Branch, Jump and ALUOp for `add`, `ld`, `sd`, `beq`, `jal` and `addi`. Mark don't-cares as X and justify every X.

**解**

| 指令 | ALUSrc | MemtoReg | RegWrite | MemRead | MemWrite | Branch | Jump | ALUOp |
|---|---|---|---|---|---|---|---|---|
| add | 0 | 00 | 1 | 0 | 0 | 0 | 0 | 10 |
| ld | 1 | 01 | 1 | 1 | 0 | 0 | 0 | 00 |
| sd | 1 | X | 0 | 0 | 1 | 0 | 0 | 00 |
| beq | 0 | X | 0 | 0 | 0 | 1 | 0 | 01 |
| jal | X | 10 | 1 | 0 | 0 | 0 | 1 | X |
| addi | 1 | 00 | 1 | 0 | 0 | 0 | 0 | 11（建议；见 C4-08） |

X 的理由：sd、beq 的 RegWrite=0，写回 MUX 输出没人用；jal 的 ALU 结果不被任何选中的 MUX 使用（目标由分支加法器算，写回选 PC+4）。RegWrite/MemWrite/Branch/Jump 永不为 X。

**English answer.** `MemtoReg is a don't-care for sd and beq because RegWrite is zero. ALUSrc and ALUOp are don't-cares for jal because the ALU result is not used.`

<a id="q43"></a>

## Q43 | Complete the main-controller Verilog 主控制器模板填空

Tags: #Q #C4 #verilog #main-control #template #填空 #主控制器

**Question.** Complete each `?` in the lecture template (C4 p61): `CPU_ctrl_signals = {ALUSrc_B, MemtoReg, RegWR, MemWrite, Branch, Jump, ALUop}`; the case label is opcode[6:2].

**解**：MemtoReg 2 位、ALUop 2 位，共 9 位。

| case | 含义 | 值 |
|---|---|---|
| 5'b01100 | R-type | 9'b000100010 |
| 5'b00000 | load | 9'b101100000 |
| 5'b01000 | store | 9'b100010000 |
| 5'b11000 | beq | 9'b000001001 |
| 5'b11011 | jal | 9'b010100100 |
| 5'b00100 | I-type ALU | 9'b100100011（ALUop=11） |
| default | 未实现 | 9'b000000000 |

**English answer.** `For a load, ALUSrc_B=1, MemtoReg=01, RegWR=1, MemWrite=0, Branch=0, Jump=0 and ALUop=00, giving 9'b101100000.`

**检查**：宏里没有 MemRead；若题目的宏包含它，按题目字段顺序重排。

<a id="q44"></a>

## Q44 | Complete the ALU-decoder Verilog ALU 译码器填空

Tags: #Q #C4 #verilog #ALU-control #ALUOp #funct #填空 #ALU译码

**Question.** Complete the lecture's ALU-control template (C4 p63) with the 3-bit ALU encoding of p55. `Fun = {Fun3, Fun7}` where Fun7 is instruction bit 30.

**解**：ALUop=00 → 3'b010；01 → 3'b110；ALUop=10 时：0000 add→010，0001 sub→110，1110 and→000，1100 or→001，0100 slt→111，1010 srl→101，1000 xor→011。

**English answer.** `Loads and stores use 010 for addition, branches use 110 for subtraction, and R-type instructions are decoded from funct3 and bit 30.`

<a id="q45"></a>

## Q45 | Critical path of each instruction class 各类指令关键路径

Tags: #Q #C4 #critical-path #latency #clock-period #关键路径 #时钟周期

**Question.** Latencies (ps): PC clock-to-Q 30, instruction memory 200, control 40, ALU control 30, register read 100, immediate generator 30, multiplexer 20, ALU 120, data memory 250, register/PC setup 20, adder 70, AND gate 5; shift-left-1 is free. Find the latency of R-type, ld, sd, beq and jal, and the minimum clock period.

**解**：指令在 230 可用；寄存器值 330；立即数 260；控制 270。
- R：ALUSrc MUX 350 → ALU 470 → MemtoReg MUX 490 → setup 510。
- ld：ALU 470 → DMem 720 → MUX 740 → setup **760**。
- sd：ALU 470 → DMem 写 720。
- beq：Zero 470 → AND 475 → Branch MUX 495 → Jump MUX 515 → setup 535（目标 260+70=330 早已到达）。
- jal：目标 330 → Jump MUX 350 → setup 370；写回 PC+4（100）等控制 270 → 290 → 310；取 370。
- 时钟周期 = max = **760 ps**（ld）。

**English answer.** `The latencies are 510, 760, 720, 535 and 370 ps. The load is the slowest, so the minimum clock period is 760 ps.`

<a id="q46"></a>

## Q46 | Fixed versus ideal variable clock 固定周期与可变周期

Tags: #Q #C4 #single-cycle #variable-clock #instruction-mix #speedup #可变时钟 #加速比

**Question.** Using Q45, the instruction mix is 25% ld, 10% sd, 30% R-type, 15% I-type ALU, 15% beq, 5% jal. Compare a fixed-clock single-cycle design with an ideal design where each instruction takes only its own latency. Find the CPU time for 10^9 instructions in both.

**解**：固定：每条 760 ps → 0.76 s。可变平均 = .25×760+.10×720+.30×510+.15×510+.15×535+.05×370 = 590.25 ps → 0.59025 s。速度比 760/590.25≈1.288。

**English answer.** `The fixed design takes 0.76 s, whereas the ideal variable-clock design takes 0.590 s, a speedup of about 1.29.`

**意义**：说明单周期浪费；但真实硬件难做可变周期，流水线才是实用方案。

<a id="q47"></a>

## Q47 | Which improvement helps more? 改进哪个部件

Tags: #Q #C4 #critical-path #improvement #Amdahl #改进 #关键路径

**Question.** Starting from Q45, (a) the data memory latency is reduced to 150 ps; (b) instead, the ALU latency is halved to 60 ps. Find the new clock period and speedup for each.

**解**：(a) ld=660，sd=620，R=510，beq=535 → 周期 660，速度比 760/660≈**1.152**。(b) R=450，ld=700，sd=660，beq=475 → 周期 700，速度比 760/700≈**1.086**。
关键：改善后必须重新求**所有**类别最大值；(a) 中 ld 仍最慢但差距缩小。

**English answer.** `Reducing the data-memory latency gives a 660 ps clock and a speedup of 1.15; halving the ALU latency gives a 700 ps clock and a speedup of 1.09.`

<a id="q48"></a>

## Q48 | Encode the lab instruction set 实验指令编码

Tags: #Q #C4 #encode #lab #xor #slt #srl #andi #machine-code #实验 #编码

**Question.** Encode `xor x5,x6,x7`, `slt x5,x6,x7`, `srl x5,x6,x7`, `andi x5,x6,15`, `ori x5,x6,15`, `xori x5,x6,-1`, `slti x5,x6,100`, `srli x5,x6,3`, `lw x5,8(x6)`, `sw x5,8(x6)`.

**解**

| 指令 | 字段 | 机器码 |
|---|---|---|
| xor x5,x6,x7 | f7=0 rs2=7 rs1=6 f3=100 rd=5 op=33 | 0x007342B3 |
| slt x5,x6,x7 | f3=010 | 0x007322B3 |
| srl x5,x6,x7 | f3=101 | 0x007352B3 |
| andi x5,x6,15 | imm=0x00F f3=111 op=13 | 0x00F37293 |
| ori x5,x6,15 | f3=110 | 0x00F36293 |
| xori x5,x6,-1 | imm=0xFFF f3=100 | 0xFFF34293 |
| slti x5,x6,100 | imm=0x064 f3=010 | 0x06432293 |
| srli x5,x6,3 | imm[11:6]=0 shamt=3 f3=101 | 0x00335293 |
| lw x5,8(x6) | imm=8 f3=010 op=03 | 0x00832283 |
| sw x5,8(x6) | imm[11:5]=0 rs2=5 rs1=6 f3=010 imm[4:0]=8 op=23 | 0x00532423 |

**English answer.** `For example, sw x5,8(x6) places imm[4:0]=8 in bits 11:7 and rs2=x5 in bits 24:20, giving 0x00532423.`

<a id="q49"></a>

## Q49 | Immediate generator outputs 立即数生成器输出

Tags: #Q #C4 #ImmGen #immediate #sign-extend #shift #立即数生成

**Question.** For each word give the format, the immediate-generator output (lecture convention: halfword count for SB/UJ) and the effective byte offset: 0xFE753C23, 0xFE0288E3, 0xF41FF0EF, 0x0100006F.

**解**
- 0xFE753C23：op=23 S；imm={1111111,11000}=-8 → sd x7,-8(x10)。
- 0xFE0288E3：op=63 SB；{1,1,111111,0100}=imm[12:1]=-8 → 字节 -16 → beq x5,x0,-16。
- 0xF41FF0EF：op=6F UJ；imm[20:1]=-96 → 字节 -192 → jal x1,-192。
- 0x0100006F：op=6F；inst[30:21]=0000001000→imm[20:1]=8 → 字节 +16；rd=0 → jal x0,+16（即 j +16）。

**English answer.** `The immediate generator outputs -8, -8, -96 and 8; after the shift-left-by-one for SB and UJ formats, the byte offsets are -8, -16, -192 and +16.`

<a id="q50"></a>

## Q50 | The I-type ALUOp bug 立即数指令译码陷阱

Tags: #Q #C4 #ALUOp #addi #inst30 #bug #decoder #陷阱 #译码错误

**Question.** A student's main control sets ALUOp=10 for addi, and the ALU decoder uses {funct3, instruction[30]}. What does `addi x5,x0,-1` produce? Which other lab instructions can fail? Fix the design.

**解**：0xFFF00293 的 inst[30]=1（立即数第 10 位），Fun=0001 → 译成 sub，ALU=0-(-1)=1，x5=1（应为 -1）。andi/ori/xori/slti 的负立即数使 Fun=1111/1101/1001/0101，落入 default。srli 合法（inst[30]=0）。修正：I-ALU 用 ALUOp=11 只看 funct3（funct3=101 时才看 inst[30]），或把 inst[30] 与“R 型或移位”相与。

**English answer.** `Bit 30 of an I-type instruction is part of the immediate. With ALUOp=10, addi x5,x0,-1 is decoded as a subtraction and writes 1. A separate ALUOp for I-type instructions avoids this.`

<a id="q51"></a>

## Q51 | Stuck-at faults on control signals 控制信号卡死

Tags: #Q #C4 #stuck-at #fault #RegWrite #ALUSrc #MemtoReg #故障 #卡死

**Question.** For each fault, list which of add, ld, sd, beq, jal execute incorrectly: (a) RegWrite stuck at 0; (b) RegWrite stuck at 1; (c) ALUSrc stuck at 0; (d) MemtoReg stuck at 00; (e) Branch stuck at 1.

**解**
- (a) add、ld、jal（不写回）；sd、beq 正常。
- (b) sd、beq（向 inst[11:7] 号寄存器写垃圾）；其余正常。
- (c) ld、sd（ALU B 用寄存器 inst[24:20] 代替立即数）；add、beq 正常；jal 不受影响（ALUSrc 为 X）。
- (d) ld（写回地址）、jal（写回 ALU 结果而非 PC+4）。
- (e) 任何 ALU 结果为 0 的指令会误跳，如 `sub x1,x2,x2`、地址为 0 的 ld/sd；beq 本身正常；jal 正常（Jump=1 已选目标）。

**English answer.** `If RegWrite is stuck at 0, add, ld and jal fail because they cannot write their results. If it is stuck at 1, sd and beq corrupt the register selected by bits 11 to 7.`

<a id="q52"></a>

## Q52 | A concrete fault trace 故障的具体后果

Tags: #Q #C4 #stuck-at #trace #ALUSrc #RegWrite #故障追踪

**Question.** In the C4-12 program, (a) what does `ld x6,16(x10)` load if ALUSrc is stuck at 0 (x16=0, Mem[0x2000]=0)? (b) What happens during `sd x7,-8(x10)` if RegWrite is stuck at 1 and MemtoReg is implemented as 00 for stores?

**解**：(a) ld 的 inst[24:20]=16 → Read data 2 = x16 = 0；地址 0x2000+0=0x2000，读到 0，x6=0（正确应为 0x37）。(b) sd 的 inst[11:7]=24，x24 ← ALU result = 0x1FF8；存储器写仍正常。

**English answer.** `With ALUSrc stuck at 0, the load uses x16 instead of the offset and reads address 0x2000. With RegWrite stuck at 1, the store also writes its address 0x1FF8 into x24.`

<a id="q53"></a>

## Q53 | Add jalr to the datapath 增加 jalr

Tags: #Q #C4 #jalr #extend-datapath #new-instruction #扩展 #jalr

**Question.** Describe the datapath and control changes needed to support `jalr rd, imm(rs1)`, and give its control-signal values.

**解**：目标 = (rs1 + sext(imm)) & ~1，用 ALU 计算（ALUSrc=1，ALUOp=00 add）；新增 PC MUX 输入“ALU result 最低位清零”及控制 JumpReg（或 Jump 扩为 2 位）；链接 PC+4 写 rd（MemtoReg=10，RegWrite=1）；Branch=0，MemRead=MemWrite=0。jalr 立即数**不左移**，不能用分支加法器。rs1 读旧值，写 rd 在周期末，所以 rd=rs1 也正确。

**English answer.** `The ALU adds rs1 and the immediate, bit 0 is cleared, and a new PC multiplexer input selects this target. PC+4 is written to rd through the existing MemtoReg=10 path.`

<a id="q54"></a>

## Q54 | Add bne 增加 bne

Tags: #Q #C4 #bne #branch #extend-datapath #Zero #扩展 #bne

**Question.** How can the datapath support bne with minimal change?

**解**：beq 与 bne 只差 funct3[0]（000/001）。把 PCSrc 改为 `Branch AND (Zero XOR inst[12])`。ALU 仍做减法（ALUOp=01），主控制器对 opcode 1100011 统一给 Branch=1。或增加 BranchNE 信号：PCSrc = (Branch·Zero) + (BranchNE·Zero')。

**English answer.** `Since beq and bne differ only in funct3 bit 0, PCSrc can be computed as Branch AND (Zero XOR funct3[0]).`

<a id="q55"></a>

## Q55 | Add lui and auipc 增加 lui 与 auipc

Tags: #Q #C4 #lui #auipc #U-type #extend-datapath #扩展 #U型

**Question.** What changes support `lui` and `auipc`? Why can't lui simply rely on Read data 1 being zero?

**解**：ImmGen 增加 U 格式（inst[31:12] 左移 12 并符号扩展）；ALU A 口加 MUX（ALUSrcA）：lui 选 0、auipc 选 PC、其余选 Read data 1；ALUSrc=1，ALU add，MemtoReg=00，RegWrite=1。U 型没有 rs1，inst[19:15] 是立即数的一部分，Read data 1 读出的是任意寄存器的值，不能当作 0。

**English answer.** `U-type instructions have no rs1 field, so bits 19:15 belong to the immediate. A new ALU A-input multiplexer must select zero for lui and the PC for auipc.`

<a id="q56"></a>

## Q56 | Why separate memories and adders? 为何分离存储器和加法器

Tags: #Q #C4 #separate-memory #adder #single-cycle #concept #概念 #简答

**Question.** Explain why the single-cycle datapath uses separate instruction and data memories and two adders besides the ALU.

**解**：一个周期内每个元件只能完成一个功能；ld/sd 需要在同一周期内取指又访存，所以存储器分开；PC+4、分支目标、ALU 运算在同一周期都可能需要，所以 PC+4 和目标地址各用专用加法器。

**English answer.** `In a single-cycle design each element can be used only once per cycle. Fetching and accessing data happen in the same cycle, so two memories are required, and the PC increment and branch target need adders separate from the ALU.`

<a id="q57"></a>

## Q57 | Writes to x0 and jal x0 x0 的写入

Tags: #Q #C4 #x0 #register-file #jal #concept #零寄存器

**Question.** `jal x0, L` asserts RegWrite. Explain what happens and why the design still works.

**解**：控制照常 RegWrite=1、MemtoReg=10，但寄存器堆对 rd=0 屏蔽写入（或读 x0 永远为 0），链接值被丢弃，效果是无条件跳转 j L。这避免了为 j 设置专门控制。

**English answer.** `The register file ignores writes to x0, so jal x0 behaves as an unconditional jump while the controller can treat it like any other jal.`

<a id="q58"></a>

## Q58 | Units used by each instruction 部件使用表

Tags: #Q #C4 #unit-usage #datapath #部件 #使用

**Question.** For R-type, ld, sd, beq and jal, state whether the data memory, the immediate generator, the ALU and the branch-target adder produce a useful result.

**解**：

| | DMem | ImmGen | ALU | 目标加法器 |
|---|---|---|---|---|
| R | 否 | 否 | 是 | 否 |
| ld | 读 | 是 | 是（地址） | 否 |
| sd | 写 | 是 | 是（地址） | 否 |
| beq | 否 | 是 | 是（减法） | 是 |
| jal | 否 | 是 | 否 | 是 |

**English answer.** `Only loads and stores use the data memory; beq and jal are the only instructions that use the branch-target adder, and jal is the only one that does not need the ALU.`

<a id="q59"></a>

## Q59 | Reading and writing the same register 同周期读写

Tags: #Q #C4 #register-file #edge-triggered #timing #读写同一寄存器

**Question.** In `add x5,x5,x5`, the same register is read and written. Explain why the single-cycle design produces the correct result.

**解**：读端口组合输出旧 x5，整个周期都稳定；写在周期末的上升沿发生，此时 ALU 结果已稳定；下一周期才看到新值。边沿触发使得“先读后写”自然成立。

**English answer.** `The register file is read combinationally during the cycle and written only at the clock edge, so the instruction sees the old value of x5.`

<a id="q60"></a>

## Q60 | Identify the instruction from control signals 由控制信号反推指令

Tags: #Q #C4 #control-signal #reverse #identify #反推

**Question.** Identify the instruction class for each vector (ALUSrc, MemtoReg, RegWrite, MemRead, MemWrite, Branch, Jump, ALUOp): (a) 1,01,1,1,0,0,0,00; (b) 0,X,0,0,0,1,0,01; (c) X,10,1,0,0,0,1,X; (d) 1,X,0,0,1,0,0,00; (e) 0,00,1,0,0,0,0,10.

**解**：(a) load；(b) beq；(c) jal；(d) store；(e) R 型。

**English answer.** `The vectors correspond to a load, beq, jal, a store and an R-type instruction, respectively.`

<a id="q61"></a>

## Q61 | Concepts in English 概念英文简答

Tags: #Q #C4 #English #combinational #sequential #clocking #简答 #英文

**Question.** (a) Distinguish combinational and state elements. (b) What does edge-triggered mean? (c) State the clocking methodology in one sentence.

**解与英文答案**
- (a) `A combinational element's output depends only on its current inputs; a state element stores information and changes only at a clock edge.`
- (b) `An edge-triggered register samples its input and updates its output only when the clock changes from 0 to 1.`
- (c) `Combinational logic takes inputs from state elements and delivers outputs to state elements between clock edges, and the longest such delay determines the clock period.`

<a id="q62"></a>

## Q62 | Why shift left by one? 为何左移一位

Tags: #Q #C4 #shift-left-1 #halfword #branch #MIPS #半字 #左移

**Question.** Why does the RISC-V branch datapath shift the immediate left by one place rather than two, as in MIPS? Compute the target of `beq x0,x0,8` at PC=0x1018 in the lecture datapath.

**解**：RISC-V 支持 16 位压缩指令，指令只保证 2 字节对齐，偏移以半字为单位编码；MIPS 指令一律 4 字节，所以左移 2。ImmGen 输出 4（imm[12:1]），左移得 8，目标 0x1018+8=0x1020。

**English answer.** `RISC-V branch offsets are encoded in halfwords because compressed instructions only guarantee 2-byte alignment. The target is 0x1018 + (4<<1) = 0x1020.`

<a id="q63"></a>

## Q63 | Amdahl's Law variants Amdahl 变式

Tags: #Q #C1 #Amdahl #speedup #fraction #Amdahl定律

**Question.** (a) 40% of execution time is improved 3×. (b) 25% is improved 10×. (c) What fraction must be improved 10× to obtain an overall speedup of 2?

**解**：(a) 1/(0.6+0.4/3)=1/0.7333≈**1.364**。(b) 1/(0.75+0.025)≈**1.290**。(c) 1/2=(1-F)+F/10 → 0.5=1-0.9F → F=5/9≈**55.6%**。

**English answer.** `The overall speedups are 1.36 and 1.29. To double performance with a tenfold local speedup, 5/9 of the original time must be enhanced.`

<a id="q64"></a>

## Q64 | Parallel speedup limit 多核加速上限

Tags: #Q #C1 #multicore #Amdahl #parallel #serial #多核

**Question.** A program is 10% serial. Find the speedup on 8 and 16 cores, and the upper bound.

**解**：8 核 1/(0.1+0.9/8)=1/0.2125≈**4.706**；16 核 1/(0.1+0.05625)=**6.4**；上限 1/0.1=**10**。核数翻倍，速度远未翻倍。

**English answer.** `The speedups are 4.71 on 8 cores and 6.4 on 16 cores. The serial fraction limits the speedup to 10.`

<a id="q65"></a>

## Q65 | MIPS rating and CPI MIPS 与 CPI

Tags: #Q #C1 #MIPS #CPI #clock-rate #MIPS指标

**Question.** A 2 GHz processor is rated at 1000 MIPS on a program. Find its average CPI. Explain why a higher MIPS rating does not guarantee a shorter execution time.

**解**：MIPS=f/(CPI×10^6) → CPI=2×10^9/(1000×10^6)=**2**。不同 ISA/编译器的指令数不同；简单指令多的机器 MIPS 高，但完成任务所需指令也多，执行时间未必短。

**English answer.** `The average CPI is 2. MIPS ignores instruction count, so a machine that needs more instructions can have a higher MIPS rating but a longer execution time.`

<a id="q66"></a>

## Q66 | Compiler trade-off 编译器取舍

Tags: #Q #C1 #instruction-count #CPI #compiler #performance #编译器

**Question.** A new compiler reduces the instruction count by 20% but increases the average CPI by 10%. The clock rate is unchanged. Is the new code faster? By how much?

**解**：时间比 = 0.8×1.1 = 0.88 → 新代码快，速度比 1/0.88≈**1.136**，执行时间减少 12%。

**English answer.** `The new execution time is 0.88 of the old one, so the new code is about 1.14 times as fast.`

<a id="q67"></a>

## Q67 | Eight-bit addition flags 8 位加法标志

Tags: #Q #C3 #overflow #carry #two-complement #溢出 #进位

**Question.** Add 0x9C and 0xB5 in 8 bits. Give the result, the unsigned carry and whether signed overflow occurs. Repeat for 0x6A + 0x3C.

**解**：0x9C+0xB5=0x151 → 结果 **0x51**，carry=1；signed -100+(-75)=-175 < -128，负+负得正 → **溢出**。0x6A+0x3C=0xA6，carry=0；signed 106+60=166>127，正+正得负 → **溢出**；unsigned 166 合法。

**English answer.** `0x9C+0xB5 gives 0x51 with a carry-out and signed overflow. 0x6A+0x3C gives 0xA6 with no carry but signed overflow.`

<a id="q68"></a>

## Q68 | Booth: 6 × (-9) Booth 5 位

Tags: #Q #C3 #Booth #signed-multiplication #trace #布斯

**Question.** Multiply 6 by -9 with the 5-bit Booth algorithm (M=00110, -M=11010, Q=10111). Show each step.

**解**

| 轮 | Q0,Q-1 | 运算后 A | 算术右移后 A Q Q-1 |
|---|---|---|---|
| 1 | 10 | A-M=11010 | 11101 01011 1 |
| 2 | 11 | 11101 | 11110 10101 1 |
| 3 | 11 | 11110 | 11111 01010 1 |
| 4 | 01 | A+M=00101 | 00010 10101 0 |
| 5 | 10 | A-M=11100 | 11110 01010 1 |

结果 A:Q=1111001010 = -54。

**English answer.** `The 10-bit product is 1111001010, which is -54 in two's complement.`

<a id="q69"></a>

## Q69 | Restoring division 13 ÷ 3 恢复除法

Tags: #Q #C3 #restoring-division #trace #quotient #remainder #除法

**Question.** Divide unsigned 13 by 3 with the 4-bit restoring algorithm (shift A:Q left, then trial-subtract).

**解**

| 轮 | 左移后 A:Q | A-M | 处理后 A:Q |
|---|---|---|---|
| 1 | 0001:1010 | -2 | 恢复 0001:1010 |
| 2 | 0011:0100 | 0 | 保留、Q0=1 → 0000:0101 |
| 3 | 0000:1010 | -3 | 恢复 0000:1010 |
| 4 | 0001:0100 | -2 | 恢复 0001:0100 |

商 Q=0100=4，余数 A=0001=1；13=4×3+1。

**English answer.** `The quotient is 4 and the remainder is 1, which satisfies 13 = 4×3 + 1.`

<a id="q70"></a>

## Q70 | Encode IEEE 754 single 浮点编码加练

Tags: #Q #C3 #IEEE754 #encode #single #浮点编码

**Question.** Encode 100.25 and -5.625 in binary32.

**解**：100.25=1100100.01₂=1.10010001×2^6，E=133=10000101，F=1001000100…→ **0x42C88000**。-5.625=-101.101₂=-1.01101×2^2，E=129=10000001，F=01101000…→ **0xC0B40000**。

**English answer.** `100.25 is encoded as 0x42C88000 and -5.625 as 0xC0B40000.`

<a id="q71"></a>

## Q71 | Decode IEEE 754 single 浮点解码加练

Tags: #Q #C3 #IEEE754 #decode #single #浮点解码

**Question.** Decode 0xC2F00000 and 0x3F200000.

**解**：C2F00000：S=1，E=10000101=133→e=6，F=.111→-1.111₂×2^6=-1111000₂=**-120**。3F200000：S=0，E=126→e=-1，F=.01→1.01₂×2^-1=**0.625**。

**English answer.** `The values are -120 and 0.625.`

<a id="q72"></a>

## Q72 | Decode an R-type word 反汇编 R 型

Tags: #Q #C2 #decode #R-type #sub #反汇编

**Question.** Disassemble 0x40B50533.

**解**：op=0110011 R；rd=bits11:7=01010=10；f3=000；rs1=01010=10；rs2=01011=11；f7=0100000 → **sub x10,x10,x11**（sub a0,a0,a1）。

**English answer.** `The word is sub x10, x10, x11 (sub a0, a0, a1).`

<a id="q73"></a>

## Q73 | Encode store and backward branch 编码 sw 与后向分支

Tags: #Q #C2 #encode #S-type #B-type #编码

**Question.** Encode `sw x9,-4(x8)` and a `beq x5,x0,L` whose target is 16 bytes before the branch.

**解**：sw：imm=-4=0xFFC → imm[11:5]=1111111，imm[4:0]=11100；rs2=9，rs1=8，f3=010 → **0xFE942E23**。beq：D=-16 → 13 位 1111111110000，imm[12]=1，imm[10:5]=111111，imm[4:1]=1000，imm[11]=1 → **0xFE0288E3**。

**English answer.** `sw x9,-4(x8) is 0xFE942E23 and the backward beq is 0xFE0288E3.`

<a id="q74"></a>

## Q74 | Encode and decode jal 编码解码 jal

Tags: #Q #C2 #jal #J-type #encode #decode #跳转

**Question.** Encode `jal x1,-192`. Decode 0x0100006F.

**解**：-192 的 21 位：imm[20]=1，imm[10:1]=1110100000，imm[11]=1，imm[19:12]=11111111 → **0xF41FF0EF**。0x0100006F：rd=0，imm[10:1]=0000001000→+16 → **jal x0,+16**（j +16）。

**English answer.** `jal x1,-192 is 0xF41FF0EF, and 0x0100006F is jal x0,16, an unconditional jump forward by 16 bytes.`

<a id="q75"></a>

## Q75 | while loop and dynamic count while 循环计数

Tags: #Q #C2 #while #loop #dynamic-count #循环 #动态计数

**Question.** Translate `while (save[i] == k) i += 1;` for int64 save[] with base s6, i in s3, k in s5. If the condition is true m times before failing, how many instructions execute?（课件经典例）

```asm
Loop: slli t1, s3, 3
      add  t1, t1, s6
      ld   t0, 0(t1)
      bne  t0, s5, Exit
      addi s3, s3, 1
      beq  x0, x0, Loop
Exit:
```

**解**：成功一轮 6 条，执行 m 次；最后失败的一轮执行 slli/add/ld/bne 4 条 → **6m+4**。

**English answer.** `Each successful iteration executes six instructions and the final test executes four, so the total is 6m+4.`

<a id="q76"></a>

## Q76 | Leaf procedure 叶过程

Tags: #Q #C2 #leaf #procedure #stack #callee-saved #叶过程

**Question.** Write RV64 code for `long f(long g,long h,long i,long j){return (g+h)-(i+j);}` with arguments in a0-a3. Must any register be saved?

```asm
f:  add  t0, a0, a1
    add  t1, a2, a3
    sub  a0, t0, t1
    jalr x0, 0(ra)
```

**解**：叶函数只用 t 寄存器（caller-saved），无需保存，也无需栈帧。若改用 s0/s1，则必须在入口保存、出口恢复（如课件版本存 3 个寄存器、用 24 字节；标准 ABI 应对齐到 16 的倍数，取 32 字节）。

**English answer.** `Because the leaf procedure uses only temporary registers, it needs no stack frame and saves no registers.`

<a id="q77"></a>

## Q77 | Carry-select delay 选择进位延迟

Tags: #Q #C3 #carry-select #ripple #delay #选择进位 #延迟

**Question.** A 4-bit ripple-carry block takes 8 gate delays from carry-in to carry-out and sum; a 2-to-1 multiplexer takes 2. Compare a 16-bit ripple adder with a carry-select adder built from four 4-bit blocks (blocks 1-3 duplicated for Cin=0 and Cin=1).

**解**：串行 4×8=**32**。选择进位：所有块在 8 时同时完成；块 0 的进位在 8 到达，块 1 选择在 10，块 2 在 12，块 3 在 **14**。代价是块 1-3 的硬件加倍并加 MUX。

**English answer.** `The ripple adder needs 32 gate delays; the carry-select adder needs 8+3×2=14 because the blocks compute both possibilities in parallel.`

<a id="q78"></a>

## Q78 | Toy floating-point addition with rounding 小格式浮点加法

Tags: #Q #C3 #floating-addition #rounding #toy-format #GRS #浮点加法

**Question.** With 4 significand bits (including the hidden 1) and round-to-nearest-even, add 1.011₂×2^2 and 1.101₂×2^0.

**解**：对阶：1.101×2^0 = 0.01101×2^2；相加 1.01100+0.01101=1.11001×2^2；保留 1.110，G=0、R=1 → 舍去 → **1.110×2^2=7.0**。精确值 5.5+1.625=7.125，误差 0.125（小于半个 ULP=0.25）。

**English answer.** `The exact sum 1.11001×2^2 rounds down to 1.110×2^2 = 7.0 because the guard bit is zero.`

<a id="q79"></a>

## Q79 | Floating-point multiplication with stored exponents 用存储指数做乘法

Tags: #Q #C3 #floating-multiplication #bias #exponent #浮点乘法

**Question.** Multiply 0x40400000 by 0x3F000000 in binary32 using stored exponents.

**解**：0x40400000=1.1×2^1（E=128）=3.0；0x3F000000=1.0×2^-1（E=126）=0.5。E=128+126-127=127；有效数 1.1×1.0=1.1；符号 0 → 1.5 → **0x3FC00000**。

**English answer.** `The biased exponent is 128+126-127=127 and the significand is 1.1₂, so the product is 1.5, encoded as 0x3FC00000.`

<a id="q80"></a>

## Q80 | Percentages and speedup wording 百分比措辞

Tags: #Q #C1 #speedup #percentage #wording #百分比 #措辞

**Question.** Execution time drops from 50 s to 40 s. Express this as (a) a speedup, (b) a percentage performance increase, (c) a percentage time reduction.

**解**：(a) 50/40=**1.25**；(b) 性能提高 **25%**；(c) 时间减少 **20%**。“快 25%”与“时间少 20%”描述同一件事。

**English answer.** `The speedup is 1.25, so performance improves by 25%, while execution time is reduced by 20%.`


---

# Mock Midterm | 期中模拟卷（英文命题）与完整答案

自编模拟卷，用来检验 Chapter 1-4 Part 1 的综合解题能力，**不是**往年试卷，也不代表考试题型或分值。建议限时 100 分钟独立完成，再对照 M02。所有数值由 tools/verify_content.py 核对。

<a id="m01"></a>

## M01 | Mock paper 模拟卷题目（英文）

Tags: #mock #exam #paper #模拟卷 #英文题目

**Assumptions.** RV64I with 32-bit instructions unless stated. Show intermediate steps.

**Part A — Performance (Chapter 1)**

1. (8 pts) A program executes 2×10^9 instructions on a 2.5 GHz processor. Classes A, B and C account for 50%, 30% and 20% of the instructions and have CPIs of 1, 2 and 4. (a) Find the average CPI and the CPU time. (b) A hardware change reduces the CPI of class C to 2. Find the new CPU time and the speedup.
2. (6 pts) Floating-point operations account for 40% of the execution time. A new FP unit makes them 5 times faster. Find the overall speedup and the maximum speedup obtainable by improving only the FP unit.

**Part B — Instructions (Chapter 2)**

3. (8 pts) (a) Encode `ld x9, 40(x18)` and `sub x5, x9, x6` in hexadecimal. (b) Disassemble 0x00A4B023.
4. (6 pts) A `bne x5, x6, Loop` instruction is located at 0x2010 and Loop is at 0x2004. Give the byte offset and the machine code.

**Part C — Arithmetic (Chapter 3)**

5. (6 pts) Compute 0x6A + 0x3C in 8 bits. State the result, the carry-out, and whether signed overflow occurs. Explain.
6. (8 pts) Use the 4-bit Booth algorithm to multiply 3 by -5. Show A, Q and Q-1 after each step.
7. (8 pts) (a) Encode -0.3125 in IEEE 754 single precision. (b) Decode 0x41460000.

**Part D — The Processor (Chapter 4 Part 1)**

8. (10 pts) For the single-cycle datapath in the lecture, give ALUSrc, MemtoReg, RegWrite, MemRead, MemWrite, Branch, Jump and ALUOp for `sd`, `beq` and `jal`. Which of these three instructions use the data memory, and which use the branch-target adder?
9. (12 pts) Latencies (ps): PC clock-to-Q 20, instruction memory 250, control 50, ALU control 25, register read 150, immediate generator 50, multiplexer 25, ALU 200, data memory 300, setup 20, adder 100, AND gate 10. Find the latency of R-type, ld, sd, beq and jal instructions and the minimum clock period.
10. (8 pts) The MemtoReg signal is stuck at 01. Which of add, addi, ld, sd, beq and jal execute incorrectly? Why?
11. (6 pts) In about three sentences, explain why a single-cycle implementation is inefficient even though its CPI is 1.
12. (6 pts) Explain why the lecture's ALU decoder must not use instruction bit 30 when decoding `addi`. Give an example that fails.

<a id="m02"></a>

## M02 | Answer key 模拟卷答案与评分要点

Tags: #mock #answer #solution #模拟卷答案 #评分

**1.** (a) CPI = 0.5×1 + 0.3×2 + 0.2×4 = **1.9**；T = 2×10^9×1.9/2.5×10^9 = **1.52 s**。(b) CPI = 0.5+0.6+0.4 = 1.5；T = **1.2 s**；speedup = 1.52/1.2 ≈ **1.267**。`The new CPU time is 1.2 s, a speedup of 1.27.`（参考 C1-05）

**2.** S = 1/(0.6+0.4/5) = 1/0.68 ≈ **1.47**；上限 1/0.6 ≈ **1.67**。`The unaffected 60% limits the speedup to 1/0.6.`（C1-07）

**3.** (a) ld：imm=40=0x028，rs1=18，f3=011，rd=9，op=0000011 → **0x02893483**。sub：f7=0100000，rs2=6，rs1=9，f3=000，rd=5，op=0110011 → **0x406482B3**。(b) 0x00A4B023：op=0100011 S；f3=011 sd；rs1=9，rs2=10；imm={0000000,00000}=0 → **sd x10, 0(x9)**。（C2-09）

**4.** offset = 0x2004-0x2010 = **-12**；13 位 1111111110100：imm[12]=1，imm[11]=1，imm[10:5]=111111，imm[4:1]=1010；f3=001 → **0xFE629AE3**。偏移相对分支自身 PC，不是 PC+4。（C2-10）

**5.** 0x6A+0x3C = **0xA6**，carry-out **0**；signed 106+60=166 超出 127，两正数相加得到负数（符号位 1）→ **signed overflow**。unsigned 166 合法。（C3-02）

**6.** M=0011，-M=1101，Q=1011，A=0000，Q-1=0。

| 步 | Q0,Q-1 | 操作后 A | 移位后 A Q Q-1 |
|---|---|---|---|
| 1 | 10 | 1101 | 1110 1101 1 |
| 2 | 11 | 1110 | 1111 0110 1 |
| 3 | 01 | 0010 | 0001 0011 0 |
| 4 | 10 | 1110 | 1111 0001 1 |

结果 **11110001 = -15**。（C3-07）

**7.** (a) -0.3125 = -0.0101₂ = -1.01₂×2^-2；S=1，E=125=01111101，F=0100…0 → **0xBEA00000**。(b) 0x41460000：S=0，E=130→e=3，F=.100011 → 1.100011₂×2^3 = 1100.011₂ = **12.375**。（C3-09）

**8.**

| | ALUSrc | MemtoReg | RegWrite | MemRead | MemWrite | Branch | Jump | ALUOp |
|---|---|---|---|---|---|---|---|---|
| sd | 1 | X | 0 | 0 | 1 | 0 | 0 | 00 |
| beq | 0 | X | 0 | 0 | 0 | 1 | 0 | 01 |
| jal | X | 10 | 1 | 0 | 0 | 0 | 1 | X |

只有 **sd** 用数据存储器；**beq 与 jal** 用分支目标加法器。（C4-07、C4-08）

**9.** 指令 270，寄存器 420，立即数 320，控制 320。R：ALUSrc MUX 445 → ALU 645 → MUX 670 → setup **690**。ld：645+300=945 → 970 → **990**。sd：**945**。beq：Zero 645 → AND 655 → MUX 680 → MUX 705 → setup **725**（目标 320+100=420 先到）。jal：目标 420 → MUX 445 → setup **465**（写回路径 365）。最小时钟周期 **990 ps**（ld）。（C4-11）

**10.** MemtoReg=01 时写回值总是数据存储器输出：**add、addi** 出错（写回存储器读出的无意义值而非 ALU 结果）；**jal** 出错（链接值应为 PC+4）；**ld** 正确；**sd、beq** 不写寄存器（RegWrite=0）因而不受影响。（C4-14）

**11.** 参考答案：`Every instruction must finish in one clock cycle, so the clock period is set by the slowest instruction, the load. Faster instructions such as add and beq waste the remainder of the cycle. In addition, hardware cannot be shared within a cycle, so the design needs separate memories and extra adders.`（C4-11）

**12.** I 型指令的 inst[30] 是立即数第 10 位，不是 funct7[5]。若 addi 使用 ALUOp=10 并按 {funct3, inst[30]} 译码，`addi x5,x0,-1`（0xFFF00293）得到 Fun=0001 → sub，结果 x5=1 而不是 -1。应为 I 型 ALU 单设 ALUOp（如 11）只按 funct3 译码。（C4-08、Q50）

**评分自查**：每题先写公式/规则，再代入，再给带单位或位宽的结论；位串题标明位宽；分支题写出相对哪个 PC；数据通路题说明 X 的理由。


---

## 附录：考场核心公式与速查卡

# 考场速查卡 | Computer Organization Chapters 1-4 (Part 1)

本卡压缩整理重要公式、步骤和英文词，完整解释与80题、模拟卷见主手册。页码是本卡页码；C1-/C2-/C3-/C4-/Q/M/E/V为主手册检索编号。默认RV64、普通32位指令；题目给定优先。

## P01 | Performance 性能与成本

Tags: #quick #C1 #formula #性能 #公式

| 要查什么 | 公式 / 要点 |
|---|---|
| CPU time | T=cycles/f=IC×CPI/f |
| 加权CPI | CPI=Σ(IC_i×CPI_i)/ΣIC_i |
| 周期 / 频率 | Tc=1/f；1GHz↔1ns；4GHz↔250ps |
| 加速比 | S=T_old/T_new；性能提高S-1；省时1-1/S |
| 多因素变动 | Tnew/Told=(ICnew/ICold)(CPInew/CPIold)(fold/fnew) |
| Amdahl | S=1/[(1-F)+F/s]；F是旧时间占比 |
| 局部上限 | Smax=1/(1-F)；有限s达不到极限 |
| 反求局部s | s=F/[1/Starget-(1-F)]，先检查分母正负 |
| 理想N核 | S=1/[q+(1-q)/N]；q为串行比例 |
| 动态功耗 | P∝αCV²f；电压平方 |
| 能量 | E=P×T，不能只比P |
| 良率 | Y=1/(1+DA/2)² |
| 裸片成本 | waferCost/[(waferArea/dieArea)×Y] |
| SPEC | ratio=Tref/Ttest；几何平均=(Πratio)^(1/n) |
| MIPS指标 | IC/(T×10^6)=f/(CPI×10^6)，不等同任务性能 |

**看到关键词**：accounts for→占比；as fast as→速度比；reduced by→减了多少；reduced to→剩多少；weighted→加权。

**典型锚点**：10s@2GHz=20×10^9cycles；B多20%周期且6s完成→4GHz。C/V/f均0.85→功耗0.85⁴≈0.522；若周期数不变，能量0.85³≈0.614。F=.8,s=4→整体2.5倍，极限5倍。

**八大思想**：Moore's Law、abstraction、common case fast、parallelism、pipelining、prediction、memory hierarchy、redundancy。

## P02 | Registers and memory 寄存器与内存

Tags: #quick #C2 #register #memory #load #store

| 寄存器 | 名称 / 保存责任 |
|---|---|
| x0 | zero，恒0 |
| x1 / x2 | ra返回地址 / sp栈指针 |
| x3 / x4 | gp / tp，不当普通临时使用 |
| x5-x7 / x28-x31 | t0-t2 / t3-t6，caller-saved |
| x8-x9 / x18-x27 | s0-s1 / s2-s11，callee-saved |
| x10-x17 | a0-a7，参数；a0-a1可作返回值，caller-saved |

**Caller**要旧t/a值跨调用存活就保存；**callee**修改s寄存器就保存恢复。非叶函数注意ra；标准栈保持16B对齐。

| 访问 | 字节 | 扩展/动作 |
|---|---|---|
| lb/lbu | 1 | signed / zero extend |
| lh/lhu | 2 | signed / zero extend |
| lw/lwu | 4 | signed / zero extend（lwu仅RV64） |
| ld | 8 | 完整64位 |
| sb/sh/sw/sd | 1/2/4/8 | 存rs2对应低位，无rd |

**地址**：EA=base+signed12字节偏移。A[i]=base+i×elementSize。char shift0、int16 shift1、int32 shift2、int64 shift3。RV64的word仍32bit。load取数据，addi算地址；base不自动更新。

**小端**：0x12345678低地址起为78 56 34 12；大端为12 34 56 78。字节内部位不反转。

**补码**：signed range -2^(n-1)…2^(n-1)-1；MSB1时signed=unsigned-2^n；取负~x+1保留n位；sign extension复制符号位；zero extension补0。最小负数无法在同宽度中取正幅值。

## P03 | Logic, loops and constants 位运算与代码模板

Tags: #quick #C2 #mask #loop #lui #constant

**掩码**：保留x&mask；置位x|mask；翻转x^mask；清位x&~mask。提取b:a：`(x>>a)&(2^(b-a+1)-1)`。插入前先清目标字段。

**移位**：slli低补0；srli高补0；srai高补符号。负数srai一般向负无穷，不等同div向零。RV64普通shamt6位；W版5位。W操作低32位后符号扩展。

```asm
# A[i]+=h，int64，s1=base,s2=i,s3=h
slli t0,s2,3
add  t0,s1,t0
ld   t1,0(t0)
add  t1,t1,s3
sd   t1,0(t0)
```

```asm
# if (i==j) f=g+h; else f=g-h
bne  s3,s4,Else
add  s0,s1,s2
jal  x0,Done
Else:
sub  s0,s1,s2
Done:
```

**while**先测试允许0次；do-while至少1次；`&&`先检查边界再访问数组。分支未跳也计动态指令。

**大常数**：signed12范围-2048…2047。lo=sext(C&0xFFF,12)，hi=(C-lo)>>12。4000000：`lui s3,977`；`addi s3,s3,-1792`。+2304不是合法addi立即数。

**RV64边界**：lui构造32位后符号扩展；任意32位模式的符号扩展可配addiw。li/la/call为伪指令，不保证一条。mv=addi0；not=xori-1；ret=jalr x0,0(ra)。

## P04 | Formats and opcodes 六类格式与编码表

Tags: #quick #C2 #encoding #opcode #R-type #I-type

```text
R: funct7 | rs2 | rs1 | f3 | rd | op
I: imm11:0     | rs1 | f3 | rd | op
S: imm11:5| rs2 | rs1 | f3 | imm4:0 | op
B: 12,10:5| rs2| rs1| f3 | 4:1,11 | op
U: imm31:12              | rd | op
J: 20,10:1,11,19:12      | rd | op
positions: rs2[24:20],rs1[19:15],f3[14:12],rd[11:7],op[6:0]
```

| 类别 | op hex | f3等 |
|---|---|---|
| R整数 | 33 | add/sub000；sll001；slt010；sltu011；xor100；srl/sra101；or110；and111 |
| I算术 | 13 | addi000；slti010；sltiu011；xori100；ori110；andi111 |
| load | 03 | lb000,lh001,lw010,ld011,lbu100,lhu101,lwu110 |
| store | 23 | sb000,sh001,sw010,sd011 |
| branch | 63 | beq000,bne001,blt100,bge101,bltu110,bgeu111 |
| jalr | 67 | f3=000 |
| jal | 6F | J |
| lui / auipc | 37 / 17 | U |
| W寄存器 / W立即数 | 3B / 1B | RV64 |

R funct7：通常0000000；sub/sra为0100000；M乘除为0000001。M的f3依次mul000、mulh001、mulhsu010、mulhu011、div100、divu101、rem110、remu111。

**解码顺序**：opcode→format→funct→registers→立即数重拼→符号解释。S/B没有rd。机器字0x00578833=add x16,x15,x5，小端字节33 88 57 00。

## P05 | Branches and calls 分支偏移与调用

Tags: #quick #C2 #branch #PC #jal #jalr #stack

**B/J**：D=Target-当前PC，按字节；重拼后已含最低0，别再乘2。

```text
B D=sext({inst31,inst7,inst30:25,inst11:8,0},13)
J D=sext({inst31,inst19:12,inst20,inst30:21,0},21)
B range -4096..4094; J range -1048576..1048574 (bytes, step2)
jal:  rd=oldPC+4; PC=oldPC+D
jalr: rd=oldPC+4; PC=(oldrs1+sext(imm12))&~1
```

jalr偏移不乘2。无C扩展仍要求4字节指令对齐。`beq x0,x0,L`无条件；`jal x0,L`不保存链接。

**例**：PC80012→80024，D12，半字数6；bne x9,x24=0x01849663。PC80020→80000，D-20；beq x0,x0=0xFE0006E3。

```asm
# g(x)=f(x)+x，RV64对齐帧
addi sp,sp,-16
sd ra,8(sp)
sd s0,0(sp)
addi s0,a0,0
jal ra,f
add a0,a0,s0
ld s0,0(sp)
ld ra,8(sp)
addi sp,sp,16
jalr x0,0(ra)
```

**递归**：每层独立栈帧；最大栈量=同时活动帧数×帧大小（等大小时）；基例是否分配帧看代码。先恢复旧值再释放sp。

**工具链**：compiler→assembly；assembler→object；linker解析symbol并relocate；loader建立映像启动；JIT运行时编译。LR/SC标准`sc.d rd,rs2,(rs1)`，rd=0成功，非0重试。

## P06 | Integer ALU and CLA 整数运算与加法器

Tags: #quick #C3 #overflow #ALU #CLA #adder

**加减**：A-B=A+~B+1，保留n位。加法溢出=同号加出异号；减法溢出=异号相减且结果符号异于A。V=进符号位进位 XOR 出符号位进位。carry-out不等同signed overflow。

**例**：8位7F+1→80：signed overflow，无carry；FF+1→00：有carry，无signed overflow；80-1→7F：signed overflow，无unsigned borrow。

```text
Full adder: S=A XOR B XOR Cin
            Cout=AB+A Cin+B Cin
Subtract: B'=B XOR sub; C0=sub
Signed SLT: less=sign(A-B) XOR overflow
Zero=NOT(OR of all result bits)
```

```text
Pi=Ai XOR Bi; Gi=AiBi; C(i+1)=Gi+PiCi
C1=G0+P0C0
C2=G1+P1G0+P1P0C0
C3=G2+P2G1+P2P1G0+P2P1P0C0
C4=G3+P3G2+P3P2G1+P3P2P1G0+P3P2P1P0C0
Pgroup=P3P2P1P0
Ggroup=G3+P3G2+P3P2G1+P3P2P1G0
```

布尔式+是OR、相乘是AND。CLA快在减少串行等待；carry-select为Cin0/1预计算再mux。延迟从输入沿路径逐门累计，按题目fan-in和gate delay；不总能套2n。ALU控制码≠ISA opcode。

## P07 | Multiplication and Booth 乘法

Tags: #quick #C3 #multiply #Booth #mul #乘法

**unsigned n×n**完整结果2n位。V1：Q0=1则P+=M；M左移；Q右移，n轮。V3：A=0,Q=multiplier；每轮Q0=1则A+=M，保留carry，再C:A:Q联合逻辑右移。读表时统一“移位后”。

**Booth补码**：A0，Q乘数，Q-1=0；查(Q0,Q-1)：00/11不加减，01加M，10减M；再A:Q:Q-1整体**算术右移**；n轮后丢Q-1。最小负数M需扩展宽度避免取负溢出。

| 13×(-11)，5位 | 运算后A | 移位后A Q Q-1 |
|---|---|---|
| 10→减M | 10011 | 11001 11010 1 |
| 01→加M | 00110 | 00011 01101 0 |
| 10→减M | 10110 | 11011 00110 1 |
| 01→加M | 01000 | 00100 00011 0 |
| 10→减M | 10111 | 11011 10001 1 |

结果1101110001是10位补码-143；正幅值0010001111只是验算。2×(-3)的8位结果11111010=-6。

**M扩展**：mul低XLEN位；mulh signed×signed高半；mulhu unsigned×unsigned高半；mulhsu第一源signed、第二源unsigned高半。mulw低32位后sign-extend。

**英文**：multiplicand被乘数；multiplier乘数；product积；partial product部分积；arithmetic right shift算术右移。

## P08 | Division 除法

Tags: #quick #C3 #division #restoring #div #rem

**验算**：dividend=quotient×divisor+remainder。unsigned R∈[0,D)；signed商向0截断，非零余数随被除数符号。

**恢复算法合并版**：A=0,Q=被除数,M=除数；n轮：①A:Q左移；②A试减M；③负则加回恢复、Q0=0，否则保留、Q0=1。最后Q商、A余数。课件不同移位安排有不同末尾修正，不混中间状态。

| unsigned7/2，4位 | 移位后A:Q | 试减 | 最终A:Q |
|---|---|---|---|
| 1 | 0000:1110 | -2 | 0000:1110 |
| 2 | 0001:1100 | -1 | 0001:1100 |
| 3 | 0011:1000 | +1 | 0001:1001 |
| 4 | 0011:0010 | +1 | 0001:0011 |

| signed | 商 | 余数 |
|---|---|---|
| +7/+2 | +3 | +1 |
| +7/-2 | -3 | +1 |
| -7/+2 | -3 | -1 |
| -7/-2 | +3 | -1 |

div/rem signed；divu/remu unsigned；普通RISC-V无HI/LO。除0：商全1，余数原dividend；最小负数/-1：商最小负数位串，余0。指令不自动除零/溢出算术陷阱。数学除零仍未定义。

**英文**：dividend被除数；divisor除数；quotient商；remainder余数；restore恢复；truncate toward zero向零截断。

## P09 | IEEE 754 fields, range and special values 浮点

Tags: #quick #C3 #IEEE754 #bias #normal #subnormal #NaN

| 格式 | S/E/F | bias | p |
|---|---|---|---|
| single | 1/8/23 | 127 | 24 |
| double | 1/11/52 | 1023 | 53 |

Normal：`(-1)^S × (1+F/2^f) × 2^(E-bias)`；E非0非全1。

Subnormal：`(-1)^S × (F/2^f) × 2^(1-bias)`；E0,F非0，无隐藏1。

E0,F0：±0；E全1,F0：±∞；E全1,F非0：NaN。

| binary32量 | 值 |
|---|---|
| 最小正normal | 2^-126；0x00800000 |
| 最小正subnormal | 2^-149；0x00000001 |
| 最大有限 | (2-2^-23)×2^127；0x7F7FFFFF |
| +∞ / -∞ | 0x7F800000 / 0xFF800000 |
| +0 / -0 | 0x00000000 / 0x80000000 |
| NaN例 | 0x7FC00000 |
| [2^e,2^(e+1))的ULP | 2^(e-23) |
| 连续整数精确范围 | -2^24…2^24 |

Double：正常e=-1022…1023；最小normal2^-1022；最小subnormal2^-1074；ULP=2^(e-52)；连续整数至2^53。

**编码例**：-0.75=-1.1×2^-1→BF400000；-13.25=-1.10101×2^3→C1540000；0.15625=1.01×2^-3→3E200000；1.0→3F800000。

## P10 | Floating operations and rounding 浮点运算舍入

Tags: #quick #C3 #rounding #GRS #nearest-even #浮点

**加减**：特殊值→比较指数→小指数有效数右移对阶→带符号加减→规格化→舍入→可能再规格化→范围检查。0.5-.4375=.001×2^-1=1.000×2^-4=.0625→3D800000。

**乘**：符号异或；真实指数相加（E1+E2-bias）；有效数乘；规格化；舍入；检查。除法指数E1-E2+bias。1.5×(-2.5)=-3.75→C0700000。

**GRS**：G第一个丢弃位，R第二个，S后续所有位OR。nearest-even进位条件：`G AND (R OR S OR retained_LSB)`。

| GRS | 处理 |
|---|---|
| 0xx | 保持 |
| 100 | tie；末位0保持，末位1加1 |
| 101/110/111 | 加1 |

4位有效数：1.010|100→1.010；1.011|100→1.100；1.010|101→1.011；1.111|101→1.000且指数+1。nearest通常误差≤0.5ULP。toward0负数趋向0；toward+∞使数值更大；toward-∞使数值更小。

**英文**：significand有效数；fraction小数字段；biased/unbiased exponent存储/真实指数；normal/subnormal正常/次正规；hidden bit隐含位；guard/round/sticky保护/舍入/粘滞；tie中点。

**最后检查**：范围与精度不同；E是偏置非补码；subnormal没有隐含1；浮点加法可不结合；0.1二进制无限循环。请到Q23-Q27、Q36-Q37查完整演算。

## P11 | Single-cycle datapath and control 单周期数据通路与控制

Tags: #quick #C4 #datapath #control #truth-table #ALUOp

| 指令 | ALUSrc | MemtoReg | RegWr | MemRd | MemWr | Branch | Jump | ALUOp |
|---|---|---|---|---|---|---|---|---|
| R 0110011 | 0 | 00 | 1 | 0 | 0 | 0 | 0 | 10 |
| ld 0000011 | 1 | 01 | 1 | 1 | 0 | 0 | 0 | 00 |
| sd 0100011 | 1 | X | 0 | 0 | 1 | 0 | 0 | 00 |
| beq 1100011 | 0 | X | 0 | 0 | 0 | 1 | 0 | 01 |
| jal 1101111 | X | 10 | 1 | 0 | 0 | 0 | 1 | X |
| I-ALU 0010011 | 1 | 00 | 1 | 0 | 0 | 0 | 0 | 11* |

*I 型 inst[30] 属立即数，ALUOp=10 会把负立即数 addi 译成 sub。课件 beq opcode 误写 1100111。

```text
PCSrc=Branch·Zero; PC1=PCSrc?Sum:PC+4; nextPC=Jump?Sum:PC1
Sum=PC+(ImmGen<<1)      // ImmGen 对 SB/UJ 输出半字数
MemtoReg: 00 ALU, 01 DMem, 10 PC+4   // 2位
Verilog {ALUSrc_B,MemtoReg,RegWR,MemWrite,Branch,Jump,ALUop}
R 000100010  ld 101100000  sd 100010000
beq 000001001  jal 010100100  I-ALU 100100011  case=opcode[6:2]
```

| ALU 3位(p55) | 功能 | ALU 4位(p62) |
|---|---|---|
| 000 / 001 | and / or | 0000 / 0001 |
| 010 / 110 | add / sub | 0010 / 0110 |
| 111 | slt | 0111 |
| 101 / 011 / 100 | srl / xor / nor | — |

ALUOp=10 时 Fun={funct3,inst[30]}：add0000 sub0001 and1110 or1100 slt0100 srl1010 xor1000。3位最高位=Bnegate。

**写使能不可为X**；X只给输出不被使用的MUX选择端。default分支全部置0。

## P12 | Datapath tracing, timing, faults 追踪·时序·故障·扩展

Tags: #quick #C4 #trace #critical-path #stuck-at #ImmGen

```text
I : sext(inst[31:20])            S : sext({inst[31:25],inst[11:7]})
SB: sext({31,7,30:25,11:8})<<1   UJ: sext({31,19:12,20,30:21})<<1
fields: rs1[19:15] rs2[24:20] rd[11:7] op[6:0]; ALUctl in: inst[30,14:12]
```

**追踪顺序**：PC→指令hex→字段→Read data1/2（读口2总按inst[24:20]读）→ImmGen→ALU B→ALU result/Zero→DMem→写回值→Sum→next PC。

**关键路径**：节点时间=max(输入)+延迟。

```text
R  = cq+IM+max(RF,Imm,Ctl)+Mux+ALU+Mux+setup
ld = cq+IM+RF+Mux+ALU+DM+Mux+setup       (通常最长)
sd = cq+IM+RF+Mux+ALU+DM
beq= max(…ALU+AND, cq+IM+Imm+Add)+Mux+Mux+setup
jal= max(cq+IM+Imm+Add+Mux+setup, PC+4写回)
```

例(cq30 IM200 RF100 Imm30 Mux20 ALU120 DM250 setup20 Add70 AND5)：R510 ld760 sd720 beq535 jal370，周期760。

| 卡死 | 出错指令 |
|---|---|
| RegWrite=0 / 1 | R,I,ld,jal / sd,beq |
| ALUSrc=0 / 1 | I,ld,sd / R,beq |
| MemtoReg=00 / 01 | ld,jal / R,I,jal |
| Branch=1 | ALU结果为0的非分支 |
| Jump=1 / MemWrite=1 | 非jal（成立的beq除外）/ 除sd外全部 |

**扩展**：bne→PCSrc=Branch·(Zero⊕f3[0])；jalr→ALU算rs1+imm、清bit0、新PC MUX输入、MemtoReg=10；lui/auipc→U型ImmGen+ALU A口MUX选0/PC；I-ALU→ALUOp=11按funct3。

**英文**：assert置1；deassert置0；don't care无关；critical path关键路径；edge-triggered边沿触发；register file寄存器堆；immediate generator立即数生成器；stuck-at卡死故障。

