## 输入信号 - 拨码开关
# opcode[1:0] 对应 SW11, SW10
set_property PACKAGE_PIN V15 [get_ports {opcode[0]}]
set_property IOSTANDARD LVCMOS33 [get_ports {opcode[0]}]

set_property PACKAGE_PIN U15 [get_ports {opcode[1]}]
set_property IOSTANDARD LVCMOS33 [get_ports {opcode[1]}]

# a[1:0] 对应 SW8, SW7
set_property PACKAGE_PIN W13 [get_ports {a[0]}]
set_property IOSTANDARD LVCMOS33 [get_ports {a[0]}]

set_property PACKAGE_PIN W14 [get_ports {a[1]}]
set_property IOSTANDARD LVCMOS33 [get_ports {a[1]}]

# b[1:0] 对应 SW5, SW4
set_property PACKAGE_PIN U16 [get_ports {b[0]}]
set_property IOSTANDARD LVCMOS33 [get_ports {b[0]}]

set_property PACKAGE_PIN V16 [get_ports {b[1]}]
set_property IOSTANDARD LVCMOS33 [get_ports {b[1]}]

## 输出信号 - LED灯
# out[2:0] 对应 LD9, LD8, LD7
set_property PACKAGE_PIN W18 [get_ports {out[0]}]
set_property IOSTANDARD LVCMOS33 [get_ports {out[0]}]

set_property PACKAGE_PIN V19 [get_ports {out[1]}]
set_property IOSTANDARD LVCMOS33 [get_ports {out[1]}]

set_property PACKAGE_PIN U19 [get_ports {out[2]}]
set_property IOSTANDARD LVCMOS33 [get_ports {out[2]}]