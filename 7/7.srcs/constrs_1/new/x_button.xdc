# 时钟信号
set_property PACKAGE_PIN W5 [get_ports clk]							
set_property IOSTANDARD LVCMOS33 [get_ports clk]
create_clock -add -name sys_clk_pin -period 10.00 -waveform {0 5} [get_ports clk]

# 复位按钮 (BTNC)
set_property PACKAGE_PIN U18 [get_ports rst_n]						
set_property IOSTANDARD LVCMOS33 [get_ports rst_n]

# 独立按键
set_property PACKAGE_PIN T18 [get_ports BTNU]						
set_property IOSTANDARD LVCMOS33 [get_ports BTNU]
set_property PACKAGE_PIN W19 [get_ports BTNL]						
set_property IOSTANDARD LVCMOS33 [get_ports BTNL]
set_property PACKAGE_PIN U17 [get_ports BTND]						
set_property IOSTANDARD LVCMOS33 [get_ports BTND]

# LED输出
set_property PACKAGE_PIN U15 [get_ports LD5]					
set_property IOSTANDARD LVCMOS33 [get_ports LD5]
set_property PACKAGE_PIN V19 [get_ports LD3]					
set_property IOSTANDARD LVCMOS33 [get_ports LD3]
set_property PACKAGE_PIN E19 [get_ports LD1]					
set_property IOSTANDARD LVCMOS33 [get_ports LD1]

# 按键时钟路由设置 (防止时序冲突)
set_property CLOCK_DEDICATED_ROUTE FALSE [get_nets rst_n]	
set_property CLOCK_DEDICATED_ROUTE FALSE [get_nets BTNU]
set_property CLOCK_DEDICATED_ROUTE FALSE [get_nets BTNL]
set_property CLOCK_DEDICATED_ROUTE FALSE [get_nets BTND]