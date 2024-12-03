`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/11/15 10:30:00
// Design Name: 
// Module Name: tb_LS
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


module tb_LS(

    );
    
reg clk,rst,en_in,en2;
reg [15:0] ins;
wire [7:0] led;
wire [15:0] pc_out;

    
    CPU_LS tb_LS(
    .clk(clk),
    .rst(rst),
    .en_in(en_in),
    .en2(en2),
    .ins(ins),
    .led(led),
    .pc_out(pc_out)
    );
    
    parameter Tclk = 10;
    
    reg cnt1;
    
    initial begin                
                    en_in = 1'b0;
        #(Tclk*2)    en_in = 1'b1;
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
                            ins=16'b0000000000000000;// move 0 to reg0
             #(Tclk*19/2)   ins=16'b0000010000000001;//move 1 to reg1, led = 00000001
             #(Tclk*4)      ins=16'b0010010000000001;//add 1 to reg1,  led = 00000010         
             #(Tclk*4)      ins=16'b0010010000000010;//add 2 to reg1,  led = 00000100            
             #(Tclk*4)      ins=16'b0010010000000100;//add 4 to reg1,  led = 00001000
             #(Tclk*4)      ins=16'b0010010000001000;//add 8 to reg1,  led = 00010000
             #(Tclk*4)      ins=16'b0010010000010000;//add 16 to reg1, led = 00100000
             #(Tclk*4)      ins=16'b0010010000100000;//add 32 to reg1, led = 01000000
             #(Tclk*4)      ins=16'b0010010001000000;//add 64 to reg1, led = 10000000
             #(Tclk*4)      ins=16'b0100010001000000;//sub 64 to reg1, led = 01000000 
             #(Tclk*4)      ins=16'b0100010000100000;//sub 32 to reg1, led = 00100000 
             #(Tclk*4)      ins=16'b1000010010000001;// or reg1 00100000 with 10000001, led = 10100001
             #(Tclk*4)      ins=16'b0110010000101001;//and reg1 10100001 with 10010001, led = 10000001
             #(Tclk*4)      ins=16'b1100000000000011;// jump for 3
             #(Tclk*3)      ins=16'b1101000000100010;//store reg0 00000000 to ram 00100010, led = 01001001
             #(Tclk*6)      ins=16'b1110010000100010;//load ram 00100010 to reg1, led = 00000000
            end
            
    initial
                begin
                    #(Tclk*100)  $stop;
                end
           
endmodule
