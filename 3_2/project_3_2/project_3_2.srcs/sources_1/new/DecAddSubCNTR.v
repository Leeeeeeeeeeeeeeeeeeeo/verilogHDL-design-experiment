`timescale 1ns / 1ps

module DecAddSubCNTR(
    input Clk,           // 时钟信号，对应 SW15
    input R,             // 异步复位，对应 SW13
    input S,             // 同步置位，对应 SW14
    input Up_Down,       // 加减控制，对应 SW12
    input [3:0] load_data, // 预置数据，对应 SW3-SW0
    output reg [3:0] Q   // 计数器输出，对应 LD3-LD0
);

// 异步复位和同步置位/计数逻辑
always @(posedge Clk or posedge R) begin
    if (R) 
        Q <= 4'b0000;           // 异步复位，清零
    else if (S) 
        // 同步置位，如果预置数大于9，根据加减模式处理
        if (load_data > 4'b1001)
            Q <= (Up_Down) ? 4'b0000 : 4'b1001;
        else
            Q <= load_data;
    else begin
        // 正常计数模式
        if (Up_Down) begin
            // 加法计数
            if (Q == 4'b1001)
                Q <= 4'b0000;   // 9->0
            else
                Q <= Q + 1;     // 正常加1
        end else begin
            // 减法计数
            if (Q == 4'b0000)
                Q <= 4'b1001;   // 0->9
            else
                Q <= Q - 1;     // 正常减1
        end
    end
end

endmodule