`timescale 1ns / 1ps

module top(
    input clk,          // 时钟信号 W5 (100MHz)
    input rst_n,        // 复位按键 BTNC
    input BTNU,         // 上按键
    input BTNL,         // 左按键  
    input BTND,         // 下按键
    output LD5,         // LED5
    output LD3,         // LED3
    output LD1          // LED1
);

// 按键输入组合
wire [2:0] keys = {BTNU, BTNL, BTND};

// LED输出组合
wire [2:0] leds;

// 实例化按键消抖模块
key_debounce u_key_debounce(
    .clk(clk),
    .rst_n(rst_n),
    .key_in(keys),
    .led_out(leds)
);

// 分配LED输出
assign {LD5, LD3, LD1} = leds;

endmodule