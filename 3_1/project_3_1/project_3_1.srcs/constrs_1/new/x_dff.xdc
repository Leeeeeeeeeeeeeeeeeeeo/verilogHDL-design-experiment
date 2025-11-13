## 时钟信号 - 使用SW3模拟时钟
set_property PACKAGE_PIN V16 [get_ports CP]
set_property IOSTANDARD LVCMOS33 [get_ports CP]
# 由于使用开关模拟时钟，需要添加以下约束
set_property CLOCK_DEDICATED_ROUTE FALSE [get_nets CP]

## 复位信号 - SW1
set_property PACKAGE_PIN V17 [get_ports R]  
set_property IOSTANDARD LVCMOS33 [get_ports R]

## 置位信号 - SW2
set_property PACKAGE_PIN V18 [get_ports S]
set_property IOSTANDARD LVCMOS33 [get_ports S]

## 数据输入 - SW0
set_property PACKAGE_PIN V10 [get_ports D]
set_property IOSTANDARD LVCMOS33 [get_ports D]

## 输出Q - LD1
set_property PACKAGE_PIN W4 [get_ports Q]
set_property IOSTANDARD LVCMOS33 [get_ports Q]

## 反相输出Q_n - LD0  
set_property PACKAGE_PIN U16 [get_ports Q_n]
set_property IOSTANDARD LVCMOS33 [get_ports Q_n]

## 关闭未使用LED（可选）
set_property BITSTREAM.CONFIG.UNUSEDPIN Pullnone [current_design]