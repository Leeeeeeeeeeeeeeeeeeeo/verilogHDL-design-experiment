## 时钟信号 - 使用SW15模拟时钟
set_property PACKAGE_PIN U13 [get_ports Clk]
set_property IOSTANDARD LVCMOS33 [get_ports Clk]
# 由于使用开关模拟时钟，需要添加以下约束
set_property CLOCK_DEDICATED_ROUTE FALSE [get_nets Clk]

## 复位信号 - SW13
set_property PACKAGE_PIN T12 [get_ports R]  
set_property IOSTANDARD LVCMOS33 [get_ports R]

## 置位信号 - SW14
set_property PACKAGE_PIN T11 [get_ports S]
set_property IOSTANDARD LVCMOS33 [get_ports S]

## 加减控制信号 - SW12
set_property PACKAGE_PIN V15 [get_ports Up_Down]
set_property IOSTANDARD LVCMOS33 [get_ports Up_Down]

## 预置数据输入 - SW3-SW0
set_property PACKAGE_PIN U16 [get_ports {load_data[0]}]
set_property IOSTANDARD LVCMOS33 [get_ports {load_data[0]}]

set_property PACKAGE_PIN E19 [get_ports {load_data[1]}]
set_property IOSTANDARD LVCMOS33 [get_ports {load_data[1]}]

set_property PACKAGE_PIN U19 [get_ports {load_data[2]}]
set_property IOSTANDARD LVCMOS33 [get_ports {load_data[2]}]

set_property PACKAGE_PIN V19 [get_ports {load_data[3]}]
set_property IOSTANDARD LVCMOS33 [get_ports {load_data[3]}]

## 计数器输出 - LD3-LD0
# 注意：输出引脚不能与输入引脚相同，需要重新映射到LED
set_property PACKAGE_PIN U16 [get_ports {Q[0]}]
set_property IOSTANDARD LVCMOS33 [get_ports {Q[0]}]

set_property PACKAGE_PIN E19 [get_ports {Q[1]}]
set_property IOSTANDARD LVCMOS33 [get_ports {Q[1]}]

set_property PACKAGE_PIN U19 [get_ports {Q[2]}]
set_property IOSTANDARD LVCMOS33 [get_ports {Q[2]}]

set_property PACKAGE_PIN V19 [get_ports {Q[3]}]
set_property IOSTANDARD LVCMOS33 [get_ports {Q[3]}]

## 关闭未使用LED（可选）
set_property BITSTREAM.CONFIG.UNUSEDPIN Pullnone [current_design]