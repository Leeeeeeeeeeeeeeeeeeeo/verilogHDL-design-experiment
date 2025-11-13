`timescale 1ns / 1ps

module test;
    // 输入信号
    reg S;
    reg R;
    reg D;
    reg CP;
    
    // 输出信号
    wire Q;
    wire Q_n;
    
    // 实例化被测试模块
    Dff uut (
        .S(S),
        .R(R),
        .D(D),
        .CP(CP),
        .Q(Q),
        .Q_n(Q_n)
    );
    
    // 时钟信号生成 - 50ns周期
    initial begin
        CP = 0;
        forever #25 CP = ~CP;
    end
    
    // 测试用例
    initial begin
        // 初始化所有输入
        S = 0; R = 0; D = 0;
        #10; // 初始稳定时间
        
        $display("=== 测试开始 ===");
        
        // 测试用例1：异步复位功能
        $display("=== 测试1：异步复位 ===");
        #10 R = 1;  // 异步复位
        #40 R = 0;
        
        // 测试用例2：同步置位功能
        $display("=== 测试2：同步置位 ===");
        #10 S = 1;  // 在时钟上升沿前设置置位
        #40 S = 0;
        
        // 测试用例3：正常D触发器功能
        $display("=== 测试3：正常D触发器 ===");
        #10 D = 1;  // 设置数据
        #50 D = 0;
        #50 D = 1;
        
        // 测试用例4：复位优先级测试
        $display("=== 测试4：复位优先级 ===");
        #10 R = 1; S = 1; D = 1; // 同时有效
        #30 R = 0; S = 0;
        
        // 测试用例5：综合功能测试
        $display("=== 测试5：综合测试 ===");
        #10 D = 1;
        #20 S = 1;
        #30 S = 0;
        #20 R = 1;
        #20 R = 0;
        
        // 结束仿真
        #50 $display("=== 测试结束 ===");
        $finish;
    end
    
    // 监控信号变化
    initial begin
        $monitor("Time=%0t CP=%b S=%b R=%b D=%b Q=%b Q_n=%b", 
                 $time, CP, S, R, D, Q, Q_n);
    end
    
endmodule