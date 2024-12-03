`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/11/21 19:59:09
// Design Name: 
// Module Name: clk_div
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


module clk_div(
    input clk_undiv,
    input rst,
    output reg clk
);    
    parameter NUM_DIV = 50000000;
    reg [19:0]cnt;
    

    
always@(posedge clk_undiv or negedge rst) begin
            if(!rst) begin
                cnt <= 20'd0;
                clk<= 1'b0;     
            end
            else begin
                cnt <= cnt + 1'b1;
                if(cnt == NUM_DIV/2-1) begin
                    cnt <= 20'd0;
                    clk <= ~clk;          
                end      
            end
        end    
endmodule
