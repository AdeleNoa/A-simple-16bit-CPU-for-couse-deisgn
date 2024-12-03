`timescale 1ns / 1ps

module rom_tb;
// Inputs
reg sys_clk;
reg rst_n;
reg [3:0] addra ;
wire [15:0] douta ;

// Instantiate the Unit Under Test (UUT)
ip_rom ip_rom (
	.sys_clk	(sys_clk), 		
	.rst_n		(rst_n),
	.addra(addra),
	.douta(douta)
);

initial 
begin
	// Initialize Inputs
	sys_clk = 0;
	rst_n = 0;

	// Wait 100 ns for global reset to finish
	#100;
      rst_n = 1;       

 end

initial 
begin
          addra=4'b0000;
     #100 addra=4'b0001;
     #20  addra=4'b0010;
     #20  addra=4'b0011;
     #20  addra=4'b0010;
     
 end

always #10 sys_clk = ~ sys_clk;   //20ns一个周期，产生50MHz时钟源
   
endmodule
