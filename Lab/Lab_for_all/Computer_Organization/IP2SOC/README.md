# Lab2：CPU 调试测试环境

按照提供的 `CSSTE.pdf`、实验要求及 PPT 71、85–93 页组织顶层模块。顶层为 `rtl/CSSTE.v`，目标器件沿用原 IP 的 `xc7a100tcsg324-1`，板级管脚沿用原 `A7.xdc`，并补充 100 MHz 输入时钟约束。原始资料保留在上一级 `provided` 目录。

本实验要求不需要实验报告；本文件用于构建和验收操作。

## 构建

双击 `build.cmd`，或在 Vivado Tcl Console 中执行（工程文件夹路径可按实际位置修改）：

```tcl
source {F:/Zhejiang University/Computer Organization/lab/lab2/OExp02-IP2SOC/scripts/build.tcl}
```

脚本自动建立 `build/lab2.xpr`，通过 IP Catalog 生成 `Seg7_Dev_0` 和 ROM `ROM_D`（Distributed Memory Generator，ROM、深度 1024、宽度 32，以 `mem/I_mem.coe` 初始化，异步 spo 输出），加入其他模块的 `.v` 接口及 `.edf` 网表，执行综合、实现和 bitstream 生成。成功后文件为 `output/CSSTE.bit`，并产生 DRC、资源和时序报告。再次构建将打开已有工程继续运行；脚本检测到源文件更新时会重置综合并重新实现。已有工程目录不会被脚本覆盖或删除。

只创建工程、不开始综合时运行 `scripts/create_project.tcl`。工程建立后可直接打开 `build/lab2.xpr`。更换电脑或目录时重新创建工程：先将旧 `build` 文件夹改名保留，再执行创建脚本；脚本会更新 VGA 的两个初始化文件绝对路径。其他 Vivado 安装位置可修改 `build.cmd` 中的 `LAB2_VIVADO`。

通过 GUI 手工添加时：将 `ip/Seg7_Dev` 加入 IP Repository 并生成名为 `Seg7_Dev_0` 的 IP；按上述参数创建 `ROM_D`；添加 `rtl/CSSTE.v`、`rtl/vga/*.v`、`ip/netlist` 中的全部 `.v` 和 `.edf`、`mem` 中两个 `.mem` 和 `constraints` 下两个 `.xdc`。不要把 `provided` 中的其他旧工程、VGA stub 或 VGA.edf 同时导入。

## 模块与连线

| 实例 | 模块 | 功能 |
|---|---|---|
| U1 | SCPU | 课程给出的 CPU 网表，Lab4 在此替换 |
| U2 | ROM_D | `PC_out[11:2]` 访问 32 位指令 |
| U3 | RAM_B | 数据 RAM，时钟为 `~clk_100mhz` |
| U4 | MIO_BUS | CPU、RAM、外设数据通路 |
| U5 | Multi_8CH32 | 8 路数码管显示数据选择 |
| U6 | Seg7_Dev_0 | `clkdiv[18:16]` 扫描数码管 |
| U7 | SPIO | LED 与计数器通道控制 |
| U8 | clk_div | 分频与 CPU 时钟模式 |
| U9 | SAnti_jitter | 按键、开关去抖和低有效 RSTN 转换 |
| U10 | Counter_x | 三路定时计数器 |
| U11 | VGA | 25 MHz 像素时钟，显示 CPU 调试信号 |

U4、U5、U7、U10 使用 `~Clk_CPU`；手动 STEP 使用去抖后的 `SW_OK[10]`。`MIO_ready` 接 0；未使用的输出端口明确留空。VGA 内部未提供的寄存器、控制信号输入明确接 0，以符合实验要求中的全零显示。VGA 使用原有扫描与字符显示结构，并修正了源文件中将 ASCII 编码减去行号的错误（这会把第 2 行的数字 0 显示成点号）。RAM 返回数据在 VGA 内增加一级 100 MHz 寄存，将 RAM/总线与字符选择逻辑分开，观测延迟增加 10ns；CPU 和 RAM 的功能与连线不变。

## 上板验收

1. 在 Hardware Manager 连接开发板并下载 `output/CSSTE.bit`，连接 VGA 显示器。
2. 设置 `SW[8]=1, SW[2]=0, SW[10]=0`，按板上 C12 的 RESET 复位，再松开。
3. `SW[7:5]=111` 时数码管显示字节 PC；复位后应为 `00000000`。`010` 显示首条指令 `00100093`；`100` 显示首条指令的 ALU 结果 `00000001`。
4. 将 `SW[10]` 从 0 拨到 1，应执行一次指令；拨回 0 再拨 1，继续执行。等待去抖稳定，PC 从 0 到 4、8、C……，到 `0000007C` 的分支指令后回到 0。
5. `SW[8]=0, SW[2]=1` 为自动慢速单步，观察 PC、指令和 ALU 连续变化；`00` 为全速运行，适合慢速观察后再尝试。
6. VGA 显示字节 PC（正常顺序每次加 4）、当前指令及当前组合 ALU 结果；未接入的寄存器等区域显示 0。改变数码管显示选择不应改变 VGA 的这些信息。

| SW[7:5] | 数码管内容 |
|---|---|
| 000 | 总线外设显示数据（由程序写入锁存；本 demo 无此写入） |
| 001 | 指令字地址 `{2'b0,PC_out[31:2]}`，顺序每次加 1 |
| 010 | 指令 `Inst_in` |
| 011 | 计数器 `counter_out` |
| 100 | ALU 地址结果 `Addr_out` |
| 101 | CPU 写数据 `Data_out` |
| 110 | CPU 读数据 `Data_in` |
| 111 | 指令字节地址 `PC_out`，顺序每次加 4 |

VGA/数码管展示的是**当前 PC 对应指令的组合输出**，上升沿之后 PC 移到下一条指令；不要将它误认为上一条指令的写回值。分支周期的 ALU 结果由给定 CPU 实现决定，参考表对此留空。

## 验证与参考结果

在本目录执行：

```powershell
python tests/check_demo.py
python tests/check_sources.py
```

前者解码原 COE 的全部 32 条指令，执行两轮，按独立 Fibonacci 递推校验，并生成 `output/demo_reference.csv`。后者核对 11 个顶层实例的命名端口、8 组 EDF 依赖、Seg7 封装文件及全部 68 个唯一板级引脚。两者不等同于给定 SCPU 网表功能仿真，也不代替板卡实测。

原资料从 PC `0x3C` 开始有数值错误。正确的部分结果为：`0x3C → 000003DB`、`0x40 → 0000063D`、`0x44 → 00000A18`、`0x78 → 00148ADD`，完整结果见 CSV。`0x3C` 的值本身正确，后续请以独立计算结果为准。

VGA 字符显示另有真实 HDL 回归测试 `tests/tb_vga.sv`。在已配置 Vivado 命令环境的本目录中执行：

```text
xvlog --sv rtl/vga/VgaDisplay.v tests/tb_vga.sv
xelab tb_vga -s vga_check
xsim vga_check -R
```

应看到 `PASS: VGA static label, PC zero digit, dynamic character write across rows`。相同测试在修正前的提供源码上于 1ns 失败，输出 `PC digit must be ASCII 0, got 2e`；修正后在 7ns 通过。此测试验证实际字符寻址和写入，不是整机 CPU 仿真。

## 本次构建结果

Vivado 2025.2 已完成综合、布局布线和 bitstream 生成，DRC 为 0 个 Error。已约束路径 WNS 为 +0.534 ns，TNS 为 0.000 ns。分频/手动时钟及外部 IO 仍有未约束路径，不能把该结果解读为所有模式已完成时序签核。尚未上板实测；详细边界与证据见 `output/VERIFICATION.md`、`output/timing_summary.rpt` 和 `output/drc.rpt`。
