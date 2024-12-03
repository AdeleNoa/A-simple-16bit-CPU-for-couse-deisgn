`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/10/11 15:45:19
// Design Name: 
// Module Name: pc
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


module pc(
        clk,
        rst,       
        en_pc,
        pc_ctrl,
        offset_addr,                       
        pc_out          
    );
    input clk, rst, en_pc;
    input wire[1:0] pc_ctrl;
    input wire[7:0] offset_addr;
    output reg[15:0] pc_out;
    
    always@(negedge rst or posedge clk)
        if(rst==0)
            begin
                pc_out<=0000000000000001;
            end
         else
            begin
                 if(en_pc==1)
                    begin
                         case (pc_ctrl)
                         2'b01:
                            pc_out <= pc_out + 1;
                         2'b10:
                            pc_out <= {8'b00000000,offset_addr[7:0]};
                         default:                            
                                  pc_out <= pc_out;
                       endcase
                       
                       end
           
 end   
    
endmodule
