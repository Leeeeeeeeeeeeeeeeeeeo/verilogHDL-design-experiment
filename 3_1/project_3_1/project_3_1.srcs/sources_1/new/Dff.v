`timescale 1ns / 1ps

module Dff(
    input S,      // 同步置位，对应 SW2
    input R,      // 异步复位，对应 SW1  
    input D,      // 数据输入，对应 SW0
    input CP,     // 时钟，对应 SW3
    output reg Q, // 输出，对应 LD1
    output Q_n    // 反相输出，对应 LD0
);

// 异步复位：R有效时立即复位
// 同步置位：S有效且在时钟上升沿时置位
always @(posedge CP or posedge R) begin
    if (R) 
        Q <= 1'b0;           // 异步复位
    else 
        Q <= (S) ? 1'b1 : D; // 同步置位或正常D触发器功能
end

// 反相输出
assign Q_n = ~Q;

endmodule