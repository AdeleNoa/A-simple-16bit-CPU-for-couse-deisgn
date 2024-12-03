`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/09/12 16:25:01
// Design Name: 
// Module Name: ALU_decoder
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

module ALU_decoder(
clk, rst, en_ALUdec, op_a, op_b, rs_q, rd_q,offset, alu_in_sel
    );
input  [15:0] rs_q, rd_q;
input  [7:0] offset;
input  clk, rst, en_ALUdec, alu_in_sel;
output reg [15:0] op_a, op_b;


always @(*)
    begin 
        if(rst == 1'b0)
            begin
                op_a = 16'b0000000000000000;
                op_b = 16'b0000000000000000;
            end            
        else if(en_ALUdec == 1'b1)
                begin
                    op_a = rd_q;
                        if(alu_in_sel == 1'b1)
                            op_b = rs_q;
                        else if(offset[7] == 0)
                            op_b = {8'b00000000,offset[7:0]};
                            else if(offset[7] == 1)
                                op_b = {8'b11111111,offset[7:0]};
                                else op_b = 16'b0000000000000000;
                 end
      end   

endmodule
