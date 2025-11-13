`timescale 1ns / 1ps

module gate(input a,
            input b,
            output [5:0] z);
    assign z[0] = a & b;  //AND
    assign z[1] = ~(a & b);  //NAND
    assign z[2] = a | b;  //OR
    assign z[3] = ~(a | b);  //NOR
    assign z[4] = a ^ b;  //XOR
    assign z[5] = a ~^ b;  //XNOR
endmodule
