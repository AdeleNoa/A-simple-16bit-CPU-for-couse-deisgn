`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/11/08 10:24:56
// Design Name: 
// Module Name: ram_ip
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


module ip_ram(
 sys_clk, sys_rst_n, ram_en, ram_wea, ram_addr, ram_wr_data, ram_rd_data 
    
    );
    input sys_clk,sys_rst_n;
    input         ram_en, ram_wea ;
    input [3 : 0] ram_addr      ;
    input [15 : 0] ram_wr_data   ;
    output [15 : 0] ram_rd_data   ;
    

blk_mem_gen_0 blk_mem_gen_0 (
  .clka(sys_clk),            // input wire clka
  .rsta(sys_rst_n),            // input wire rsta
  .ena(ram_en),              // input wire ena
  .wea(ram_wea),              // input wire [0 : 0] wea
  .addra(ram_addr),          // input wire [3 : 0] addra
  .dina(ram_wr_data),            // input wire [15 : 0] dina
  .douta(ram_rd_data)          // output wire [15 : 0] douta
 // .rsta_busy()  // output wire rsta_busy
);

endmodule

