`timescale 1ns / 1ps

module test;
    // 输入信号
    reg clk;
    reg rstn;
    reg [1:0] coin;
    
    // 输出信号
    wire sell;
    wire change;
    
    // 状态信号（为了观察内部状态）
    wire [1:0] current_state;
    
    // 实例化被测模块
    machine uut (
        .clk(clk),
        .rstn(rstn),
        .coin(coin),
        .sell(sell),
        .change(change)
    );
    
    // 为了观察内部状态，我们需要通过层次化引用
    assign current_state = uut.current_state;
    
    // 状态名称定义，使用数字表示
    reg [7:0] state_name;
    always @(*) begin
        case (current_state)
            2'b00: state_name = "S0";  // IDLE
            2'b01: state_name = "S1";  // GET05
            2'b10: state_name = "S2";  // GET10
            2'b11: state_name = "S3";  // GET15
            default: state_name = "ERR";
        endcase
    end
    
    // 时钟生成 - 周期20ns
    initial begin
        clk = 0;
        forever #10 clk = ~clk;
    end
    
    // 测试过程
    initial begin
        // 初始化信号
        rstn = 1;
        coin = 2'b00;
        
        // 等待一个时钟周期
        #15;
        
        // 打印表头
        $display("Time\tRstn\tCoin\tSell\tChange\tState");
        $display("----------------------------------------");
        
        #5 display_line();
        
        // === 测试1: 异步复位 ===
        $display("\n=== 测试1: 异步复位 ===");
        rstn = 0;  // 复位有效
        #20 display_line();
        
        rstn = 1;  // 复位解除
        #20 display_line();
        
        // === 测试2: 投入0.5元 ===
        $display("\n=== 测试2: 投入0.5元 ===");
        display_line();
        coin = 2'b01;  // 投入0.5元
        #20 display_line();
        
        // === 测试3: 再投入0.5元 ===
        $display("\n=== 测试3: 再投入0.5元 ===");
        coin = 2'b00;
        #20 display_line();
        coin = 2'b01;  // 再投入0.5元
        #20 display_line();
        
        // === 测试4: 投入1元（达到2元，出货不找零）===
        $display("\n=== 测试4: 投入1元（达到2元，出货不找零）===");
        coin = 2'b00;
        #20 display_line();
        coin = 2'b10;  // 投入1元
        #20 display_line();
        
        // === 测试5: 回到初始状态 ===
        $display("\n=== 测试5: 回到初始状态 ===");
        coin = 2'b00;
        #20 display_line();
        
        // === 测试6: 投入1元 ===
        $display("\n=== 测试6: 投入1元 ===");
        coin = 2'b10;  // 投入1元
        #20 display_line();
        
        // === 测试7: 再投入0.5元 ===
        $display("\n=== 测试7: 再投入0.5元 ===");
        coin = 2'b00;
        #20 display_line();
        coin = 2'b01;  // 投入0.5元
        #20 display_line();
        
        // === 测试8: 再投入1元（达到2.5元，出货并找零）===
        $display("\n=== 测试8: 再投入1元（达到2.5元，出货并找零）===");
        coin = 2'b00;
        #20 display_line();
        coin = 2'b10;  // 投入1元
        #20 display_line();
        
        // === 测试9: 回到初始状态 ===
        $display("\n=== 测试9: 回到初始状态 ===");
        coin = 2'b00;
        #20 display_line();
        
        // === 测试10: 异常输入测试 ===
        $display("\n=== 测试10: 异常输入测试（coin=11）===");
        coin = 2'b11;  // 异常输入
        #20 display_line();
        
        // === 仿真完成 ===
        $display("\n=== 仿真完成 ===");
        #100 $finish;
    end
    
    // 显示一行数据的任务
    task display_line;
        begin
            $display("%0d\t%0d\t%b\t%0d\t%0d\t%s", 
                    $time, rstn, coin, sell, change, state_name);
        end
    endtask
    
    // 波形保存
    initial begin
        $dumpfile("machine_wave.vcd");
        $dumpvars(0, test);
    end

endmodule