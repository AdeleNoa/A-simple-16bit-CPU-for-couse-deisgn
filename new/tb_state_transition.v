`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/09/05 15:25:11
// Design Name: 
// Module Name: tb_state_transition
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


module tb_state_transition();

reg clk,rst;
reg en_in;
reg en1;
reg en2;
reg [1:0] rd;
reg [3:0] opcode;
wire en_fetch_pulse;
wire en_group_pulse;
wire en_pc_pulse;
wire [1:0] pc_ctrl;
wire [3:0] reg_en;
wire alu_in_sel;
wire [2:0] alu_func;

state_transition state_transition1(
					.clk(clk) ,
					.rst(rst) ,
					.en_in(en_in) ,
					.en1(en1) ,
					.en2(en2) ,
					.rd(rd) ,
					.opcode(opcode)  ,
					.en_fetch_pulse(en_fetch_pulse),	
					.en_group_pulse(en_group_pulse),
					.en_pc_pulse(en_pc_pulse)  ,
					.pc_ctrl(pc_ctrl) ,
					.reg_en(reg_en) ,
					.alu_in_sel(alu_in_sel)	,
					.alu_func(alu_func)			
				);

parameter Tclk = 10;

initial begin
			clk=0;
			forever #(Tclk/2) clk=~clk;
		end
        
initial begin
				    rst=0;
		  #(Tclk*4)	rst=1; 
		end

reg cnt1;
always @ (posedge clk) begin
	if(!rst) 
		cnt1 <= 1'd0;
	else 
	    cnt1 <= cnt1+1;
end	

always @ (posedge clk) begin
	if(!rst)                 
		en2 <= 1'b0;
	else if (cnt1==1'd1)
      en2 <= 1'b1;
      else en2<=1'b0;
	
end

initial begin                
		        en_in = 1'b0;
		        en1   = 1'b0;
	#(Tclk*2)	en_in = 1'b1;
    #(Tclk*2)   en1   = 1'b1;
end

initial begin
                    	rd = 2'b00;
		  #(Tclk*8)     rd = 2'b01;
		  #(Tclk*4)     rd = 2'b10;
		  #(Tclk*4)     rd = 2'b11;
        end

initial begin
		                 opcode=4'b0111;
          #(Tclk*8)      opcode=4'b0000;
          #(Tclk*8)      opcode=4'b0000;
          #(Tclk*8)      opcode=4'b0111;
          #(Tclk*8)      opcode=4'b1001;
          #(Tclk*8)      opcode=4'b1010;

        end

        
initial begin
          #(Tclk*100)  $stop;
end

endmodule
