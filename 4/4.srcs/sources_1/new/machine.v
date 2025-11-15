`timescale 1ns / 1ps

module machine(
    input clk,
    input rstn,
    input [1:0] coin,
    output reg sell,
    output reg change
);

// 状态定义
// S0: IDLE    - 初始状态，0元
// S1: GET05   - 已投0.5元
// S2: GET10   - 已投1元  
// S3: GET15   - 已投1.5元

parameter S0 = 2'b00;  // IDLE
parameter S1 = 2'b01;  // GET05
parameter S2 = 2'b10;  // GET10
parameter S3 = 2'b11;  // GET15

reg [1:0] current_state;
reg [1:0] next_state;

// 第一段：状态寄存器（时序逻辑）
always @(posedge clk or negedge rstn) begin
    if (!rstn) begin
        current_state <= S0;
    end else begin
        current_state <= next_state;
    end
end

// 第二段：状态转移逻辑（组合逻辑）
always @(*) begin
    case (current_state)
        S0: begin  // IDLE
            if (coin == 2'b01) begin        // 投入0.5元
                next_state = S1;
            end else if (coin == 2'b10) begin // 投入1元
                next_state = S2;
            end else begin
                next_state = S0;
            end
        end
        
        S1: begin  // GET05
            if (coin == 2'b01) begin        // 再投入0.5元
                next_state = S2;
            end else if (coin == 2'b10) begin // 再投入1元
                next_state = S3;
            end else begin
                next_state = S1;
            end
        end
        
        S2: begin  // GET10
            if (coin == 2'b01) begin        // 再投入0.5元
                next_state = S3;
            end else if (coin == 2'b10) begin // 再投入1元（达到2元）
                next_state = S0;
            end else begin
                next_state = S2;
            end
        end
        
        S3: begin  // GET15
            if (coin == 2'b01) begin        // 再投入0.5元（达到2元）
                next_state = S0;
            end else if (coin == 2'b10) begin // 再投入1元（达到2.5元）
                next_state = S0;
            end else begin
                next_state = S3;
            end
        end
        
        default: next_state = S0;
    endcase
end

// 第三段：输出逻辑（时序逻辑）
always @(posedge clk or negedge rstn) begin
    if (!rstn) begin
        sell <= 1'b0;
        change <= 1'b0;
    end else begin
        // 默认输出
        sell <= 1'b0;
        change <= 1'b0;
        
        case (current_state)
            S2: begin  // GET10
                if (coin == 2'b10) begin    // 投入1元达到2元，出货不找零
                    sell <= 1'b1;
                    change <= 1'b0;
                end
            end
            
            S3: begin  // GET15
                if (coin == 2'b01) begin    // 投入0.5元达到2元，出货不找零
                    sell <= 1'b1;
                    change <= 1'b0;
                end else if (coin == 2'b10) begin // 投入1元达到2.5元，出货并找零
                    sell <= 1'b1;
                    change <= 1'b1;
                end
            end
        endcase
    end
end

endmodule