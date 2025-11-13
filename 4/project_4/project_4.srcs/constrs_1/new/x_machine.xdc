## 时钟信号 - SW4
set_property PACKAGE_PIN V16 [get_ports clk]
set_property IOSTANDARD LVCMOS33 [get_ports clk]

## 复位信号 - SW3 (低电平复位)
set_property PACKAGE_PIN W16 [get_ports rstn]
set_property IOSTANDARD LVCMOS33 [get_ports rstn]

## 硬币输入 - SW2, SW1
## coin[1] - SW2, coin[0] - SW1
set_property PACKAGE_PIN U16 [get_ports {coin[1]}]
set_property IOSTANDARD LVCMOS33 [get_ports {coin[1]}]

set_property PACKAGE_PIN V17 [get_ports {coin[0]}]
set_property IOSTANDARD LVCMOS33 [get_ports {coin[0]}]

## 出货指示灯 - LD0
set_property PACKAGE_PIN U16 [get_ports sell]
set_property IOSTANDARD LVCMOS33 [get_ports sell]

## 找零指示灯 - LD1
set_property PACKAGE_PIN E19 [get_ports change]
set_property IOSTANDARD LVCMOS33 [get_ports change]

## 状态显示LED（可选，用于调试）
set_property PACKAGE_PIN U19 [get_ports {current_state[0]}]
set_property IOSTANDARD LVCMOS33 [get_ports {current_state[0]}]

set_property PACKAGE_PIN V19 [get_ports {current_state[1]}]
set_property IOSTANDARD LVCMOS33 [get_ports {current_state[1]}]

set_property PACKAGE_PIN W18 [get_ports {current_state[2]}]
set_property IOSTANDARD LVCMOS33 [get_ports {current_state[2]}]