`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/11/14 16:04:21
// Design Name: 
// Module Name: tb_ram
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


module tb_ram(

    );
    reg clk,rst,ram_en,ram_wea;
    reg [3:0] ram_addr;
    reg [15 : 0] ram_wr_data;
    wire [15 : 0] ram_rd_data;
    
    ip_ram ram1(
    .sys_clk(clk),
    .sys_rst_n(rst),
    .ram_en(ram_en), 
    .ram_wea(ram_wea), 
    .ram_addr(ram_addr),      
    .ram_wr_data(ram_wr_data),   
    .ram_rd_data(ram_rd_data)   
    );
    
    
    reg    [5:0]  rw_cnt ;                //¶ÁÐ´¿ØÖÆ¼ÆÊýÆ÷
    parameter Tclk = 10;
    initial begin
             clk=0;
                forever #(Tclk/2) clk=~clk;
            end
            
    initial begin
            rst=0;
            #(Tclk*4)   rst=1; 
            end
            

          
endmodule
