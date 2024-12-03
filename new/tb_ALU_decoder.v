`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/09/18 16:25:51
// Design Name: 
// Module Name: tb_ALU_decoder
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


module tb_ALU_decoder(

    );
reg [15:0] rs,rq;
reg [7:0] offset;
reg clk, rst, en_in, alu_in_sel;
wire [15:0] op_a, op_b;

ALU_decoder test_ALUdecoder(
    .clk(clk),
    .rst(rst),
    .rs(rs),
    .rq(rq),
    .offset(offset),
    .en_in(en_in),
    .alu_in_sel(alu_in_sel),
    .op_a(op_a),
    .op_b(op_b)
);

parameter Tclk=10;
 initial
    begin
        clk=0;
        forever #(Tclk/2) clk=~clk;
    end
    
initial 
    begin
        rst = 1'b0;
        en_in = 1'b0;
        #(Tclk*2) rst =1'b1;
        #(Tclk*2) en_in =1'b1;
    end

initial
    begin
        alu_in_sel = 1'b1;
        #(Tclk*6) alu_in_sel = 1'b0;
    end
    
initial
    begin
        rs = 16'b0010000110000010;
        rq = 16'b0000010010011101;
        offset = 8'b00100100;
        #(Tclk*8) offset = 8'b10010100;
    end

initial
        begin
            #(Tclk*20)  $stop;
        end
        
endmodule
