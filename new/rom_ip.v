`timescale 1ns / 1ps

module ip_rom(
    input               sys_clk,       //50MHz系统时钟(一个周期是20ns：1/50MHz=0.02us=20ns)
    //differential system clocks //200MHz系统时钟(一个周期是5ns：1/200MHz=0.005us=5ns)
    /*input               sys_clk_p,       // Differential input clock 200Mhz
    input               sys_clk_n,       // Differential input clock 200Mhz*/
    input            rst_n,
    input            ena,
    input  [3:0]  addra ,      //输入 rom 地址
    output  wire [15:0]      douta      //输出 rom 数据

    );     
//实例化ROM
blk_mem_gen_1 blk_mem_gen_1
(
    .clka   (sys_clk    ),      //inoput clka
    .ena(ena),      // input wire ena
    .addra  (addra ),      //input [3:0] addra
    .douta  (douta   )       //output [15:0] douta
);

endmodule
