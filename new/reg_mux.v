`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/11/14 17:54:12
// Design Name: 
// Module Name: reg_mux
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


module reg_mux(
reg_in_sel, alu_out, ram_data,reg_source 
    );
 input reg_in_sel;
 input [15:0]alu_out; 
 input [15:0]ram_data;
 output reg [15:0] reg_source;
 
always@(* )  begin
      if( reg_in_sel==0) 
      begin
        reg_source=alu_out;
      end
      else 
        begin 
           reg_source=ram_data;
        end 
end
    
endmodule
