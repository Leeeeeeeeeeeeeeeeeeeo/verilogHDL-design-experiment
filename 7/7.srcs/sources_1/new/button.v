`timescale 1ns / 1ps

module key_debounce(
    input clk,          // 时钟信号 (W5, 100MHz)
    input rst_n,        // 复位信号 (BTNC, 低电平有效)
    input [2:0] key_in, // 按键输入 {BTNU, BTNL, BTND}
    output reg [2:0] led_out // LED输出 {LD5, LD3, LD1}
);

// 参数定义
parameter CLK_FREQ = 100_000_000;    // 100MHz时钟频率
parameter DEBOUNCE_TIME = 20;        // 20ms消抖时间
parameter COUNTER_MAX = CLK_FREQ / 1000 * DEBOUNCE_TIME; // 20ms计数值

// 内部信号定义
reg [2:0] key_sync_ff;      // 同步寄存器
reg [2:0] key_stable;       // 稳定后的按键状态
reg [2:0] key_last;         // 上一周期按键状态
reg [19:0] debounce_counter;// 消抖计数器 (21位可计数到2,000,000)
reg [2:0] led_state;        // LED状态寄存器

// 同步化处理 - 降低亚稳态风险
always @(posedge clk or negedge rst_n) begin
    if (!rst_n) begin
        key_sync_ff <= 3'b111;  // 按键未按下时为高电平
    end else begin
        key_sync_ff <= key_in;
    end
end

// 消抖计数器控制
always @(posedge clk or negedge rst_n) begin
    if (!rst_n) begin
        debounce_counter <= 0;
        key_stable <= 3'b111;
        key_last <= 3'b111;
    end else begin
        key_last <= key_sync_ff;
        
        // 检测按键状态变化
        if (key_sync_ff != key_last) begin
            // 状态变化，重置计数器
            debounce_counter <= 0;
        end else if (debounce_counter < COUNTER_MAX) begin
            // 计数中
            debounce_counter <= debounce_counter + 1;
        end else begin
            // 计数完成，更新稳定状态
            key_stable <= key_sync_ff;
        end
    end
end

// LED状态控制 - 按键触发翻转
always @(posedge clk or negedge rst_n) begin
    if (!rst_n) begin
        led_state <= 3'b000;  // 复位时LED全灭
    end else begin
        // 检测每个按键的下降沿（按下事件）
        if (debounce_counter == COUNTER_MAX) begin
            // BTNU (key_stable[2]) 控制 LD5 (led_state[2])
            if (!key_stable[2] && key_last[2])  // 检测下降沿
                led_state[2] <= ~led_state[2];
                
            // BTNL (key_stable[1]) 控制 LD3 (led_state[1])
            if (!key_stable[1] && key_last[1])  // 检测下降沿
                led_state[1] <= ~led_state[1];
                
            // BTND (key_stable[0]) 控制 LD1 (led_state[0])
            if (!key_stable[0] && key_last[0])  // 检测下降沿
                led_state[0] <= ~led_state[0];
        end
    end
end

// LED输出
always @(posedge clk or negedge rst_n) begin
    if (!rst_n) begin
        led_out <= 3'b000;
    end else begin
        led_out <= led_state;
    end
end

endmodule