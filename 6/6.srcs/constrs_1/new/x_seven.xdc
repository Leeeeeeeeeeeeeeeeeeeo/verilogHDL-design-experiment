# 七段数码管段选信号约束
# CA - 段选信号A
set_property PACKAGE_PIN W7 [get_ports CA]					
set_property IOSTANDARD LVCMOS33 [get_ports CA]

# CB - 段选信号B
set_property PACKAGE_PIN W6 [get_ports CB]					
set_property IOSTANDARD LVCMOS33 [get_ports CB]

# CC - 段选信号C
set_property PACKAGE_PIN U8 [get_ports CC]					
set_property IOSTANDARD LVCMOS33 [get_ports CC]

# CD - 段选信号D
set_property PACKAGE_PIN V8 [get_ports CD]					
set_property IOSTANDARD LVCMOS33 [get_ports CD]

# CE - 段选信号E
set_property PACKAGE_PIN U5 [get_ports CE]					
set_property IOSTANDARD LVCMOS33 [get_ports CE]

# CF - 段选信号F
set_property PACKAGE_PIN V5 [get_ports CF]					
set_property IOSTANDARD LVCMOS33 [get_ports CF]

# CG - 段选信号G
set_property PACKAGE_PIN U7 [get_ports CG]					
set_property IOSTANDARD LVCMOS33 [get_ports CG]


# 小数点约束
# dp - 小数点
set_property PACKAGE_PIN V7 [get_ports dp]							
set_property IOSTANDARD LVCMOS33 [get_ports dp]


# 数码管位选信号约束
# AN0 - 最右边数码管
set_property PACKAGE_PIN U2 [get_ports AN0]					
set_property IOSTANDARD LVCMOS33 [get_ports AN0]

# AN1 - 右边第二个数码管
set_property PACKAGE_PIN U4 [get_ports AN1]					
set_property IOSTANDARD LVCMOS33 [get_ports AN1]

# AN2 - 右边第三个数码管
set_property PACKAGE_PIN V4 [get_ports AN2]					
set_property IOSTANDARD LVCMOS33 [get_ports AN2]

# AN3 - 最左边数码管
set_property PACKAGE_PIN W4 [get_ports AN3]					
set_property IOSTANDARD LVCMOS33 [get_ports AN3]


# 系统时钟约束
# clk_100m - Basys3 100MHz时钟
set_property PACKAGE_PIN W5 [get_ports clk_100m]					
set_property IOSTANDARD LVCMOS33 [get_ports clk_100m]