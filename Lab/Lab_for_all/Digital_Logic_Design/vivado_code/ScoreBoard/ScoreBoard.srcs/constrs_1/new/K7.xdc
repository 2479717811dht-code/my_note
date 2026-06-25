# 时钟
create_clock -name clk100MHZ -period 10.0 [get_ports clk]
set_property PACKAGE_PIN AC18 [get_ports clk]
set_property IOSTANDARD LVCMOS18 [get_ports clk]

# 按键 BTN[3:0]
set_property PACKAGE_PIN W14 [get_ports BTN[0]]
set_property PACKAGE_PIN V14 [get_ports BTN[1]]
set_property PACKAGE_PIN V19 [get_ports BTN[2]]
set_property PACKAGE_PIN V18 [get_ports BTN[3]]
set_property IOSTANDARD LVCMOS18 [get_ports BTN]
set_property CLOCK_DEDICATED_ROUTE FALSE [get_nets BTN_IBUF[*]]

# 按键使能 BTNX4（PPT 顶层要求必须有）
set_property PACKAGE_PIN W16 [get_ports BTNX4]
set_property IOSTANDARD LVCMOS18 [get_ports BTNX4]

# 拨码开关 SW[7:0]
set_property PACKAGE_PIN AA10 [get_ports SW[0]]
set_property PACKAGE_PIN AB10 [get_ports SW[1]]
set_property PACKAGE_PIN AA13 [get_ports SW[2]]
set_property PACKAGE_PIN AA12 [get_ports SW[3]]
set_property PACKAGE_PIN Y13  [get_ports SW[4]]
set_property PACKAGE_PIN Y12  [get_ports SW[5]]
set_property PACKAGE_PIN AD11 [get_ports SW[6]]
set_property PACKAGE_PIN AD10 [get_ports SW[7]]
set_property IOSTANDARD LVCMOS15 [get_ports SW]

# 数码管选通 AN[3:0]（共阳，低有效）
set_property PACKAGE_PIN AD21 [get_ports AN[0]]
set_property PACKAGE_PIN AC21 [get_ports AN[1]]
set_property PACKAGE_PIN AB21 [get_ports AN[2]]
set_property PACKAGE_PIN AC22 [get_ports AN[3]]
set_property IOSTANDARD LVCMOS33 [get_ports AN]

# 七段码 SEGMENT[7:0] (a~g + dp)
set_property PACKAGE_PIN AB22 [get_ports SEGMENT[0]]
set_property PACKAGE_PIN AD24 [get_ports SEGMENT[1]]
set_property PACKAGE_PIN AD23 [get_ports SEGMENT[2]]
set_property PACKAGE_PIN Y21  [get_ports SEGMENT[3]]
set_property PACKAGE_PIN W20  [get_ports SEGMENT[4]]
set_property PACKAGE_PIN AC24 [get_ports SEGMENT[5]]
set_property PACKAGE_PIN AC23 [get_ports SEGMENT[6]]
set_property PACKAGE_PIN AA22 [get_ports SEGMENT[7]]
set_property IOSTANDARD LVCMOS33 [get_ports SEGMENT]