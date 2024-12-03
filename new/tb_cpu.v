`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/09/05 15:39:22
// Design Name: 
// Module Name: tb_cpu
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


module tb_cpu();
reg         clk,rst,en_in,en2;
reg  [15:0] ins,ram_data;
wire  [1:0] mdr_ctrl;
wire  en_fetch, en_ram,wen_ram,en_mar_pulse;
wire [15:0] pc_out, data_out;
wire [7:0] led, offset_out;


cpu test_cpu(
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
    .ram_data(ram_data),
    .offset_out(offset_out)


);

parameter Tclk = 10;

reg cnt1;

initial begin                
		        en_in = 1'b0;
	#(Tclk*2)	en_in = 1'b1;
end

always @ (posedge clk) begin
	if(!rst) 
		cnt1 <= 1'd0;
	else 
	    cnt1 <= cnt1+1;
end	

initial begin
			clk=0;
			forever #(Tclk/2) clk=~clk;
		end
        
initial begin
				    rst=0;
		#(Tclk*4)   rst=1; 
		end


always @ (posedge clk) begin
	if(!rst)                 
		en2 <= 1'b0;
	else if (cnt1==1'd1)
      en2 <= 1'b1;
      else en2<=1'b0;
	
end



initial begin
                     ins=16'b0000000000000000;
         #(Tclk*4)   ins=16'b0000010000000001;
         #(Tclk*4)   ins=16'b0010010000000010;
         #(Tclk*4)   ins=16'b0010010000000100;
         #(Tclk*4)   ins=16'b0010010000001000;
         #(Tclk*4)   ins=16'b0010010000010000;
         #(Tclk*4)   ins=16'b0010010000100000;
         #(Tclk*4)   ins=16'b0010010001000000;
         #(Tclk*4)   ins=16'b0010010010000000;
         #(Tclk*4)   ins=16'b0100010000000001;
         #(Tclk*4)   ins=16'b0110010000001101;
         #(Tclk*4)   ins=16'b1100010000000000;
    
        end
       
initial begin
    #(Tclk*40)  $stop;
end

endmodule
