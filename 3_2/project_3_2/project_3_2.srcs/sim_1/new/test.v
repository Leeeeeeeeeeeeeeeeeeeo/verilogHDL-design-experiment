`timescale 1ns / 1ps

module test;
    // 输入信号
    reg Clk;
    reg R;
    reg S;
    reg Up_Down;
    reg [3:0] load_data;
    
    // 输出信号
    wire [3:0] Q;
    
    // 实例化被测试模块
    DecAddSubCNTR uut (
        .Clk(Clk),
        .R(R),
        .S(S),
        .Up_Down(Up_Down),
        .load_data(load_data),
        .Q(Q)
    );
    
    // 时钟信号生成 - 缩短周期以加快测试
    initial begin
        Clk = 0;
        forever #20 Clk = ~Clk; // 40ns周期
    end
    
    // 测试用例
    initial begin
        // 初始化所有输入
        R = 0; S = 0; Up_Down = 1; load_data = 4'b0000;
        
        #5; // 初始稳定时间
        
        $display("=== 十进制加减法计数器测试开始 ===");
        
        // 测试用例1：异步复位功能
        $display("=== 测试1：异步复位 ===");
        #5 R = 1;
        #40 R = 0;
        #20;
        
        // 测试用例2：同步置位功能 - 正常预置数
        $display("=== 测试2：同步置位 - 正常预置数5 ===");
        #5 S = 1; load_data = 4'b0101;
        #40 S = 0;
        #20;
        
        // 测试用例3：加法计数
        $display("=== 测试3：加法计数 ===");
        #5 Up_Down = 1;
        #160; // 观察几个计数周期
        
        // 测试用例4：减法计数
        $display("=== 测试4：减法计数 ===");
        #5 Up_Down = 0;
        #160; // 观察几个计数周期
        
        // 测试用例5：同步置位 - 预置数大于9（加法模式）
        $display("=== 测试5：同步置位 - 预置数12（加法模式）===");
        #5 S = 1; Up_Down = 1; load_data = 4'b1100; // 12
        #40 S = 0;
        #80; // 观察后续计数
        
        // 测试用例6：同步置位 - 预置数大于9（减法模式）
        $display("=== 测试6：同步置位 - 预置数15（减法模式）===");
        #5 S = 1; Up_Down = 0; load_data = 4'b1111; // 15
        #40 S = 0;
        #80; // 观察后续计数
        
        // 测试用例7：复位优先级测试
        $display("=== 测试7：复位优先级 ===");
        #5 R = 1; S = 1; Up_Down = 1; load_data = 4'b0111;
        #30 R = 0; S = 0;
        #40;
        
        $display("=== 所有测试完成 ===");
        $finish;
    end
    
    // 监控信号变化
    initial begin
        $monitor("Time=%0t Clk=%b R=%b S=%b U/D=%b Load=%b Q=%d(%b)", 
                 $time, Clk, R, S, Up_Down, load_data, Q, Q);
    end
    
endmodule