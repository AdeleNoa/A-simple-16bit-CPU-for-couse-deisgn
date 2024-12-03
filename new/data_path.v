`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/09/21 19:29:50
// Design Name: 
// Module Name: data_path
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


module data_path(
clk, rst, alu_func,offset, alu_in_sel,en_ALUdec,rd,rs, reg_en, pc_ctrl, en_pc, w_en, pc_out, offset_addr, led_out, reg_in_sel, ram_data, regout
    );
    input clk,rst,en_ALUdec,alu_in_sel,en_pc,w_en,reg_in_sel;
    input [7:0] offset;
    input [7:0] offset_addr;
    input [1:0] rd,rs,pc_ctrl;
    input [3:0] reg_en;
    input [3:0] alu_func;
    output [15:0] pc_out, led_out, ram_data;
    output reg [15:0]  regout;
    wire [15:0] rs_q, rd_q ,op_a ,op_b ,alu_out,source_in, reg_source;
       
    regfile regfile1(
                 .clk(clk),        
                 .rst(rst),     
                 .w_en(w_en),         
                 .reg_en(reg_en),
                 .source_in(reg_source),         
                 .rd_q(rd_q),
                 .rs_q(rs_q),         
                 .rd(rd),  
                 .rs(rs),
                 .led_out(led_out)        
                );
                
    ALU_decoder ALU_decoder1(
                    .clk(clk),
                    .rst(rst),
                    .rs_q(rs_q),
                    .rd_q(rd_q),
                    .offset(offset),
                    .en_ALUdec(en_ALUdec),
                    .alu_in_sel(alu_in_sel),
                    .op_a(op_a),
                    .op_b(op_b)
                );
                
    ALU alu1(
                   .op_a(op_a),
                   .op_b(op_b),
                   .alu_func(alu_func),
                   .alu_out(alu_out)
                );             
                    
     pc pc1(
             .clk(clk),
             .rst(rst), 
             .en_pc(en_pc),
             .pc_ctrl(pc_ctrl),
             .offset_addr(offset_addr),                       
             .pc_out(pc_out)                  
            );
            
     reg_mux regmux1(
        .reg_in_sel(reg_in_sel), 
        .alu_out(alu_out), 
        .ram_data(ram_data),
        .reg_source(reg_source)
     );
     
     always@(*) begin
        regout = rd_q;
     end
     
    endmodule                