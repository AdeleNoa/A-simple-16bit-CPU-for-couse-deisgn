`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/11/15 10:27:32
// Design Name: 
// Module Name: CPU_LS
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


module CPU_LS(
clk,rst,en_in,en2, led
    );
    
input clk,rst,en_in, en2;
output [7:0] led;

    
    wire en_ram,wen_ram,en_mar_pulse,ena;
    wire [1:0]    mdr_ctrl;    
    wire en_fetch;
    wire [7:0] addrout, offset_out;
    wire [15:0]  ram_wr_data, ram_rd_data, data_mdr2reg, regout, pc_out, ins;
    
    
    
    cpu cpu1(
            .clk(clk),
            .rst(rst),
            .en_in(en_in),
            .en2(en2),
            .en_fetch(en_fetch),
            .ins(ins),
            .pc_out(pc_out),  
            .led(led),
            .en_ram(en_ram),
            .wen_ram(wen_ram),
            .en_mar_pulse(en_mar_pulse),
            .mdr_ctrl(mdr_ctrl),
            .ram_data(data_mdr2reg),
            .regout(regout),
            .offset_out(offset_out),
            .ena(ena)
    
    );
    
   
    ip_ram ram1(
        .sys_clk(clk),
        .sys_rst_n(rst),
        .ram_en(en_ram), 
        .ram_wea(wen_ram), 
        .ram_addr(addrout[3:0]),      
        .ram_wr_data(ram_wr_data),   
        .ram_rd_data(ram_rd_data)   
    );
    
    MAR MAR1(
    .clk(clk),
    .rst(rst),
    .addrin(offset_out[7:0]), 
    .addrout(addrout), 
    .en_mar(en_mar_pulse)
    );
    
    MDR MDR1(
    .clk(clk),
    .rst(rst), 
    .data_ram2mdr(ram_rd_data),
    .data_mdr2reg(data_mdr2reg), 
    .data_reg2mdr(regout), 
    .data_mdr2ram(ram_wr_data), 
    .en_mdr(mdr_ctrl)
    );
    
    ip_rom rom1(
     .ena(ena),
     .sys_clk(clk),    
     .rst_n(rst),
     .addra(pc_out[3:0]),  
     .douta(ins)  
    );
endmodule
