`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/09/19 15:02:43
// Design Name: 
// Module Name: tb_ALU
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module tb_ALU(

    );
 reg [15:0] op_a, op_b;
 reg [3:0] alu_func;
 wire [15:0] alu_out;
 
 ALU test_alu(
    .op_a(op_a),
    .op_b(op_b),
    .alu_func(alu_func),
    .alu_out(alu_out)
 );
 
parameter Tclk=10;
         
initial
    begin
        alu_func = 4'b0010;
        #(Tclk*4) alu_func = 4'b0100;
        #(Tclk*4) alu_func = 4'b0110;
        #(Tclk*4) alu_func = 4'b1000;
        #(Tclk*4) alu_func = 4'b1010;
        //新功能循环用于测试第二轮进入的数
        #(Tclk*4) alu_func = 4'b0010;
        #(Tclk*4) alu_func = 4'b0100;
        #(Tclk*4) alu_func = 4'b0110;
        #(Tclk*4) alu_func = 4'b1000;
        #(Tclk*4) alu_func = 4'b1010;
     end
     
initial
    begin
        op_a = 16'b0000000000000001;
        op_b = 16'b0000100000100100;//假设进入b的为寄存器中的正数
        #(Tclk*20)op_b = 16'b1111111110000100;//假设进入b的为符号位扩展的立即数
    end
 
 initial
    begin
        #(Tclk*40)  $stop;
    end
    
 endmodule