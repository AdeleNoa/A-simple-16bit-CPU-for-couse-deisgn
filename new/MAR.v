`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/11/14 14:10:09
// Design Name: 
// Module Name: MAR
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


module MAR(
clk,rst,addrin, addrout, en_mar
    );
    input clk, rst, en_mar;
    input [7:0] addrin;
    output  reg [7:0]addrout;
    
    always @ (posedge clk or negedge rst) begin
        if(!rst) begin
            addrout <= 16'b000000000000;
        end
        else begin
            if(en_mar==1) begin
                    addrout <= addrin;
                end
            end
        end
endmodule
