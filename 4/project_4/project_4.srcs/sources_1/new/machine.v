`timescale 1ns / 1ps

module machine(
    input clk,
    input rstn,
    input [1:0] coin,
    output reg sell,
    output reg change
);

    // 状态定义
    parameter IDLE  = 3'b000;
    parameter GET05 = 3'b001;
    parameter GET10 = 3'b010;
    parameter GET15 = 3'b011;
    parameter SOLD  = 3'b100;
    parameter CHANGE = 3'b101;
    
    reg [2:0] current_state;
    reg [2:0] next_state;
    
    // 第一个always块：状态寄存器（时序逻辑）
    always @(posedge clk or negedge rstn) begin
        if (!rstn)
            current_state <= IDLE;
        else
            current_state <= next_state;
    end
    
    // 第二个always块：状态转移逻辑（组合逻辑）
    always @(*) begin
        case (current_state)
            IDLE: begin
                if (coin == 2'b01)          // 投入0.5元
                    next_state = GET05;
                else if (coin == 2'b10)     // 投入1元
                    next_state = GET10;
                else
                    next_state = IDLE;
            end
            
            GET05: begin
                if (coin == 2'b01)          // 再投0.5元
                    next_state = GET10;
                else if (coin == 2'b10)     // 再投1元
                    next_state = GET15;
                else
                    next_state = GET05;
            end
            
            GET10: begin
                if (coin == 2'b01)          // 再投0.5元
                    next_state = GET15;
                else if (coin == 2'b10)     // 再投1元
                    next_state = SOLD;
                else
                    next_state = GET10;
            end
            
            GET15: begin
                if (coin == 2'b01)          // 再投0.5元
                    next_state = SOLD;
                else if (coin == 2'b10)     // 再投1元
                    next_state = CHANGE;
                else
                    next_state = GET15;
            end
            
            SOLD: begin
                next_state = IDLE;
            end
            
            CHANGE: begin
                next_state = IDLE;
            end
            
            default: next_state = IDLE;
        endcase
    end
    
    // 第三个always块：输出逻辑（时序逻辑）
    always @(posedge clk or negedge rstn) begin
        if (!rstn) begin
            sell <= 0;
            change <= 0;
        end else begin
            // 默认输出
            sell <= 0;
            change <= 0;
            
            // 根据下一个状态设置输出
            case (next_state)
                SOLD: begin
                    sell <= 1;
                    change <= 0;
                end
                
                CHANGE: begin
                    sell <= 1;
                    change <= 1;
                end
            endcase
        end
    end

endmodule