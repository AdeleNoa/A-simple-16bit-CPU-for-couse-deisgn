`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/10/11 15:40:37
// Design Name: 
// Module Name: register
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


module register( 
            clk, 
            rst, 
            en,                 
            source,                 
            des             
    ); 

    input clk,rst,en; 
    input wire[15:0]source; 
    output reg[15:0]des; 

   always@(posedge clk or negedge rst ) 
     if(rst==0) 
       des <= 0000000000000000; 
       
     else 
       begin 
          if(en==1) 
             des <= source; 
       end 

endmodule 