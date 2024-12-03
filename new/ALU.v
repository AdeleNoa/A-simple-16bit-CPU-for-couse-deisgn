`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/09/12 15:47:46
// Design Name: 
// Module Name: ALU
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

`define MOV  4'b0001
`define ADD  4'b0010
`define SUB  4'b0100
`define AND  4'b0110
`define OR   4'b1000
`define XOR  4'b1010


module ALU(op_a, op_b, alu_out, alu_func);
input [15:0] op_a, op_b;
input [3:0] alu_func;
output reg [15:0] alu_out;

always @(*)
        begin
            case(alu_func)
                    `MOV:  alu_out = 16'b0000000000000000 + op_b;
                    `ADD:  alu_out = op_a + op_b;
                    `SUB:  alu_out = op_a - op_b;
                    `AND:  alu_out = op_a & op_b;
                    `OR:   alu_out = op_a | op_b;
                    `XOR:  alu_out = op_a ^ op_b;
                     default: alu_out = 16'b0000000000000000;
             endcase
         end  
endmodule
