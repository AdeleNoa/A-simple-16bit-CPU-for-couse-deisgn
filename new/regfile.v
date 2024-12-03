`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/10/11 15:41:58
// Design Name: 
// Module Name: regfile
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


module regfile( 
            clk,        
            rst,     
            w_en,         
            reg_en,
            source_in,         
            rd_q,
            rs_q,         
            rd,  
            rs,
            led_out    
    ); 
    
    input clk,rst,w_en; 
    input wire[3:0] reg_en; 
    input wire[15:0] source_in;//from alu_out 
    input wire[1:0] rd,rs;//from CU, show that which two regs it need to choose 
    ////////output reg en_out;  (* MARK_DEBUG = "true" *)
    
    output reg[15:0]rd_q,rs_q,led_out;//rd&rs brings two of the 4 addresses des3/2/1/0. It will go to ALU 
    wire[15:0]des0,des1,des2,des3; 
    
    register reg0(  
                  . clk(clk),  
                  . rst(rst),  
                  . en (reg_en[0]),                 
                  . source (source_in),                  
                  . des (des0)        
                  );  
    register reg1(    
                  . clk(clk),    
                  . rst(rst),   
                  . en (reg_en[1]),                  
                  . source (source_in),                  
                  . des (des1)        
                  );  
    register reg2(  
                  . clk(clk),  
                  . rst(rst),  
                  . en (reg_en[2]),                  
                  . source (source_in),                  
                  . des (des2)        
                  );  
    register reg3(  
                  . clk(clk),  
                  . rst(rst),  
                  . en (reg_en[3]),                  
                  . source (source_in),                  
                  . des(des3)        
                  );               
    


     always@(negedge rst or posedge clk)     
          if(rst==0) 
             begin 
                rd_q     <=  0000000000000000; 
                rs_q     <=  0000000000000000;
                led_out <=  0000000000000000;    
                /////////en_out <= 0;  
             end 
          else 
                      begin 
                         led_out <= des1;
                         ////////en_out <=1; 
                         case({rd[1:0],rs[1:0]}) 
                          4'b0000: 
                            begin 
                             rd_q <= des0; 
                             rs_q <= des0;
                             end 
                          4'b0001: 
                             begin 
                             rd_q <= des0; 
                             rs_q <= des1; 
                             end    
                         4'b0010: 
                             begin 
                             rd_q <= des0;  
                             rs_q <= des2;  
                             end 
                         4'b0011:               
                             begin       
                             rd_q <= des0;                                                            
                             rs_q <= des3; 
                             end         
                         4'b0100:           
                             begin       
                             rd_q <= des1; 
                             rs_q <= des0; 
                             end         
                         4'b0101:           
                             begin       
                             rd_q <= des1; 
                             rs_q <= des1; 
                             end            
                         4'b0110:           
                             begin       
                             rd_q <= des1; 
                             rs_q <= des2; 
                             end    
                         4'b0111:           
                              begin       
                              rd_q <= des1; 
                              rs_q <= des3; 
                              end                    
                         4'b1000:            
                            begin       
                            rd_q <= des2; 
                            rs_q <= des0; 
                            end     
                         4'b1001:                 
                             begin            
                             rd_q <= des2;      
                             rs_q <= des1;          
                             end       
                         4'b1010:            
                              begin       
                             rd_q <= des2; 
                             rs_q <= des2; 
                              end                 
                         4'b1011:           
                             begin       
                             rd_q <= des2; 
                             rs_q <= des3;
                             end
                         4'b1100:            
                             begin       
                             rd_q <= des3; 
                             rs_q <= des0; 
                             end               
                         4'b1101:              
                             begin         
                             rd_q <= des3;     
                             rs_q <= des1;           
                             end       
                         4'b1110:            
                              begin       
                             rd_q <= des3; 
                             rs_q <= des2; 
                              end         
                         4'b1111: 
                              begin       
                             rd_q <= des3; 
                             rs_q <= des3; 
                               end          
                         default: 
                             begin 
                             rd_q <= 0000000000000000; 
                             rs_q <= 0000000000000000;
                             led_out <=  0000000000000000;  
                             end 
                         endcase 
                     end 
                /////else 
                   /////en_out <= 0; 
                                            
     
     endmodule          
