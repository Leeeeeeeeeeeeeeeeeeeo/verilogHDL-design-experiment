`timescale 1ns / 1ps

module test;
    reg clk;
    reg rstn;
    reg [1:0] coin;
    wire sell;
    wire change;
    
    // 实例化被测模块
    machine uut (
        .clk(clk),
        .rstn(rstn),
        .coin(coin),
        .sell(sell),
        .change(change)
    );
    
    // 时钟生成
    always #5 clk = ~clk;
    
    // 状态名称定义，用于更好的显示
    reg [39:0] state_name;
    always @(uut.current_state) begin
        case (uut.current_state)
            3'b000: state_name = "IDLE";
            3'b001: state_name = "GET05";
            3'b010: state_name = "GET10";
            3'b011: state_name = "GET15";
            3'b100: state_name = "SOLD";
            3'b101: state_name = "CHANGE";
            default: state_name = "UNKNOWN";
        endcase
    end
    
    initial begin
        // 初始化信号
        clk = 0;
        rstn = 0;
        coin = 2'b00;
        
        // 生成VCD文件用于详细分析
        $dumpfile("wave.vcd");
        $dumpvars(0, test);
        
        // 复位
        #20;
        rstn = 1;
        
        $display("=== 测试开始 ===");
        $display("Time\tState\t\tCoin\tSell\tChange");
        $display("----\t-----\t\t----\t----\t------");
        
        // 测试用例1: 投入4个0.5元硬币
        $display("\n测试1: 4个0.5元硬币");
        #10; coin = 2'b01;  // 投0.5元
        #10; coin = 2'b00;
        #10; coin = 2'b01;  // 再投0.5元
        #10; coin = 2'b00;
        #10; coin = 2'b01;  // 再投0.5元
        #10; coin = 2'b00;
        #10; coin = 2'b01;  // 再投0.5元
        #10; coin = 2'b00;
        
        #30; // 等待出货完成
        
        // 测试用例2: 投入2个1元硬币
        $display("\n测试2: 2个1元硬币");
        #10; coin = 2'b10;  // 投1元
        #10; coin = 2'b00;
        #10; coin = 2'b10;  // 再投1元
        #10; coin = 2'b00;
        
        #30; // 等待出货完成
        
        // 测试用例3: 投入1元+0.5元+0.5元
        $display("\n测试3: 1元+0.5元+0.5元");
        #10; coin = 2'b10;  // 投1元
        #10; coin = 2'b00;
        #10; coin = 2'b01;  // 投0.5元
        #10; coin = 2'b00;
        #10; coin = 2'b01;  // 再投0.5元
        #10; coin = 2'b00;
        
        #30; // 等待出货完成
        
        // 测试用例4: 投入1元+1元（需要找零）
        $display("\n测试4: 1元+1元（找零）");
        #10; coin = 2'b10;  // 投1元
        #10; coin = 2'b00;
        #10; coin = 2'b10;  // 再投1元
        #10; coin = 2'b00;
        
        #30; // 等待出货和找零完成
        
        $display("\n=== 测试结束 ===");
        $finish;
    end
    
    // 在每个时钟上升沿显示状态信息
    always @(posedge clk) begin
        $display("%0t\t%s\t%b\t%b\t%b", 
                 $time, state_name, coin, sell, change);
    end

endmodule