module state_transition
(clk,rst,en_in,en1,en2,
en_fetch_pulse,en_group_pulse,en_pc_pulse,en_ALUdec_pulse,
en_ram_pulse,wen_ram,en_mar_pulse,mdr_ctrl,rd,opcode,en_ram,
pc_ctrl,reg_en,reg_in_sel,mar_in_sel,alu_in_sel,alu_func,ena);

input clk,rst;
input en_in;
input en1;
input en2;
input [1:0] rd;
input [3:0] opcode;

output reg en_ALUdec_pulse;
output reg en_fetch_pulse;
output reg en_group_pulse;
output reg en_pc_pulse;
output reg en_ram_pulse;
output reg wen_ram;
output reg en_mar_pulse;
output reg [1:0] mdr_ctrl;
output reg [1:0] pc_ctrl;
output reg [3:0] reg_en;
output reg alu_in_sel;
output reg reg_in_sel;
output reg mar_in_sel;
output reg [3:0] alu_func;
output reg en_ram;
output reg ena;

reg en_fetch_reg,en_fetch;
reg en_ALUdec,en_ALUdec_reg;
reg en_group_reg,en_group;
reg en_pc_reg,en_pc;
reg en_ram_reg;
reg en_mar_reg,en_mar;
reg [4:0] current_state,next_state;

parameter Initial = 5'b00000;
parameter Fetch = 5'b00001;
parameter Decode = 5'b00010;
parameter Execute_Move = 5'b00011;
parameter Execute_Moveb = 5'b00100;
parameter Execute_Add = 5'b00101;
parameter Execute_Addb = 5'b00110;
parameter Execute_Sub = 5'b00111;
parameter Execute_Subb = 5'b01000;
parameter Execute_And = 5'b01001;
parameter Execute_Andb = 5'b01010;
parameter Execute_Or = 5'b01011;
parameter Execute_Orb = 5'b01100;
parameter Execute_Xor = 5'b01101;
parameter Execute_Xorb = 5'b01110;
parameter Execute_Jump = 5'b01111;
parameter Execute_Load= 5'b10000;
parameter Execute_Store = 5'b10001;
parameter Addressout= 5'b10010;
parameter Mem_Load=  5'b11100;
parameter Mem_Store= 5'b11101;
parameter Write_back = 5'b11111;

    
always @ (posedge clk or negedge rst) begin
	if(!rst)
		current_state <= Initial;
	else 
		current_state <= next_state;
end

always @ (current_state or en_in or en1 or en2 or opcode) begin
	case (current_state)
		Initial: begin
			if(en_in)
				next_state = Fetch;
			else
				next_state = Initial;
		end
		Fetch: begin
			if(en1) 
				next_state = Decode;
			else
				next_state = current_state;
		end
		Decode: begin
            case(opcode) 
                4'b0000: next_state = Execute_Move;
                4'b0001: next_state = Execute_Moveb;
                4'b0010: next_state = Execute_Add;
                4'b0011: next_state = Execute_Addb;
                4'b0100: next_state = Execute_Sub;
                4'b0101: next_state = Execute_Subb;
                4'b0110: next_state = Execute_And;
                4'b0111: next_state = Execute_Andb;
                4'b1000: next_state = Execute_Or;
                4'b1001: next_state = Execute_Orb;
                4'b1010: next_state = Execute_Xor;
                4'b1011: next_state = Execute_Xorb;
                4'b1100: next_state = Execute_Jump;
                4'b1101: next_state = Execute_Store;
                4'b1110: next_state = Execute_Load;
                default: next_state = current_state;
            endcase
        end
		Execute_Move: begin
            if(en2)
                next_state = Write_back;
            else
                next_state = current_state;
        end        
		Execute_Moveb: begin
			if(en2)
				next_state = Write_back;
			else
				next_state = current_state;
		end
		Execute_Add: begin
			if(en2)
				next_state = Write_back;
			else
				next_state = current_state;
		end
		Execute_Addb: begin
            if(en2)
                next_state = Write_back;
           else
                next_state = current_state;
        end		
		Execute_Sub: begin
			if(en2)
				next_state = Write_back;
			else
				next_state = current_state;
		end
		Execute_Subb: begin
            if(en2)
                next_state = Write_back;
            else
                next_state = current_state;
        end
		Execute_Andb: begin
            if(en2)
                next_state = Write_back;
            else
                next_state = current_state;
        end
		Execute_And: begin
            if(en2)
				next_state = Write_back;
			else
				next_state = current_state;
		end   
		Execute_Or: begin
	       if(en2)
                 next_state = Write_back;
           else
                 next_state = current_state;
        end
		Execute_Orb: begin
            if(en2)
                next_state = Write_back;
            else
                next_state = current_state;
        end
 		Execute_Xor: begin
           if(en2)
                 next_state = Write_back;
           else
                 next_state = current_state;
        end
        Execute_Xorb: begin
            if(en2)
                next_state = Write_back;
            else
                next_state = current_state;
        end 
 		Execute_Load: begin
          if(en2)
                next_state = Addressout;
          else
                next_state = current_state;
       end
       Execute_Store: begin
           if(en2)
               next_state = Addressout;
           else
               next_state = current_state;
       end  
       Addressout: begin
                   case(opcode) 
                       4'b1101: next_state = Mem_Store;                   
                       4'b1110: next_state = Mem_Load;
                       default: next_state = current_state;
                   endcase
                   end                     
		Execute_Jump: next_state = Fetch;
		Mem_Store: next_state = Write_back;
		Mem_Load: next_state = Write_back;
		Write_back: next_state = Fetch;	
		default: next_state = current_state;
	endcase
end

always @ (rst or current_state) begin
	if(!rst) begin
		en_fetch = 1'b0;
		en_group = 1'b0;
		en_pc = 1'b0;
		pc_ctrl = 2'b00;
		reg_en = 4'b0000;
		alu_in_sel = 1'b0;
		alu_func = 4'b0000;
		en_ALUdec=1'b0;
		en_ram=1'b0;
		en_mar=1'b0;
	    mdr_ctrl=2'b00;
	    wen_ram=1'b0;
	    reg_in_sel=1'b0;
	end
	else begin
		case (current_state)
			Initial: begin
				en_fetch = 1'b0;
				en_group = 1'b0;
				en_pc = 1'b0;
				pc_ctrl = 2'b00;
				reg_en = 4'b0000;
				alu_in_sel = 1'b1;
				alu_func = 4'b0000;
				en_ALUdec=1'b0;
		        en_ram=1'b0;
                en_mar=1'b0;
                mdr_ctrl=2'b00;
                wen_ram=1'b0;
                reg_in_sel=1'b0;
                ena = 1'b0;				
			end
			Fetch: begin
				en_fetch = 1'b1;
				en_group = 1'b1;
				en_pc = 1'b0;
				pc_ctrl = 2'b01;
			    reg_en = 4'b0000;
				alu_in_sel = 1'b1;
				alu_func = 4'b0000;
				en_ALUdec=1'b0;
		        en_ram=1'b1;
                en_mar=1'b0;
                mdr_ctrl=2'b00;
                wen_ram=1'b0;
                reg_in_sel=1'b0;
                ena = 1'b0;	
                en_pc = 1'b1;					                                				
			end
			Decode: begin
				en_fetch = 1'b0;
				en_group = 1'b0;
				en_pc = 1'b0;
				pc_ctrl = 2'b00;
				reg_en = 4'b0000;
				alu_in_sel = 1'b1;
				alu_func = 4'b0000;
				en_ALUdec=1'b0;
		        en_ram=1'b1;
                en_mar=1'b0;
                mdr_ctrl=2'b00;
                wen_ram=1'b0; 
                reg_in_sel=1'b0;
                ena = 1'b0;	
 		       en_pc = 1'b0;					                               
			end	
			Execute_Move: begin
                en_fetch = 1'b0;
                en_group = 1'b1;
                en_pc = 1'b0;
                pc_ctrl = 2'b00;
                reg_en = 4'b0000;
                alu_in_sel = 1'b0;
                alu_func = 4'b0001;
				en_ALUdec=1'b1;
		        en_ram=1'b1;
                en_mar=1'b0;
                mdr_ctrl=2'b00;
                wen_ram=1'b0;                                				
            end
			Execute_Moveb: begin
				en_fetch = 1'b0;
				en_group = 1'b1;
				en_pc = 1'b0;
				pc_ctrl = 2'b00;
				reg_en = 4'b0000;
				alu_in_sel = 1'b1;
				alu_func = 4'b0001;
				en_ALUdec=1'b1;
		        en_ram=1'b1;
                en_mar=1'b0;
                mdr_ctrl=2'b00;
                wen_ram=1'b0;                                
			end
			Execute_Add: begin
				en_fetch = 1'b0;
				en_group = 1'b1;
				en_pc = 1'b0;
				pc_ctrl = 2'b00;
				reg_en = 4'b0000;
				alu_in_sel = 1'b0;
				alu_func = 4'b0010;
				en_ALUdec=1'b1;
		        en_ram=1'b1;
                en_mar=1'b0;
                mdr_ctrl=2'b00;
                wen_ram=1'b0;                                
			end
			Execute_Addb: begin
                en_fetch = 1'b0;
                en_group = 1'b1;
                en_pc = 1'b0;
                pc_ctrl = 2'b00;
                reg_en = 4'b0000;
                alu_in_sel = 1'b1;
                alu_func = 4'b0010;
                en_ALUdec=1'b1;
		        en_ram=1'b1;
                en_mar=1'b0;
                mdr_ctrl=2'b00;
                wen_ram=1'b0;                                
            end			
			Execute_Sub: begin
				en_fetch = 1'b0;
				en_group = 1'b1;
				en_pc = 1'b0;
				pc_ctrl = 2'b00;
				reg_en = 4'b0000;
				alu_in_sel = 1'b0;
				alu_func = 4'b0100;
				en_ALUdec=1'b1;
		        en_ram=1'b0;
                en_mar=1'b0;
                mdr_ctrl=2'b00;
                wen_ram=1'b0;                                
			end
			Execute_Subb: begin
                en_fetch = 1'b0;
                en_group = 1'b1;
                en_pc = 1'b0;
                pc_ctrl = 2'b00;
                reg_en = 4'b0000;
                alu_in_sel = 1'b1;
                alu_func = 4'b0100;
                en_ALUdec=1'b1;
		        en_ram=1'b0;
                en_mar=1'b0;
                mdr_ctrl=2'b00;
                wen_ram=1'b0;                                
            end
			Execute_And: begin
				en_fetch = 1'b0;
				en_group = 1'b1;
				en_pc = 1'b0;
				pc_ctrl = 2'b00;
				reg_en = 4'b0000;
				alu_in_sel = 1'b0;
				alu_func = 4'b0110;
				en_ALUdec=1'b1;
		        en_ram=1'b0;
                en_mar=1'b0;
                mdr_ctrl=2'b00;
                wen_ram=1'b0;                                
			end
			Execute_Andb: begin
                en_fetch = 1'b0;
                en_group = 1'b1;
                en_pc = 1'b0;
                pc_ctrl = 2'b00;
                reg_en = 4'b0000;
                alu_in_sel = 1'b1;
                alu_func = 4'b0110;
                en_ALUdec=1'b1;
		        en_ram=1'b0;
                en_mar=1'b0;
                mdr_ctrl=2'b00;
                wen_ram=1'b0;                                
            end		
			Execute_Or: begin
				en_fetch = 1'b0;
				en_group = 1'b1;
				en_pc = 1'b0;
				pc_ctrl = 2'b00;
				reg_en = 4'b0000;
				alu_in_sel = 1'b0;
				alu_func = 4'b1000;
				en_ALUdec=1'b1;
		        en_ram=1'b0;
                en_mar=1'b0;
                mdr_ctrl=2'b00;
                wen_ram=1'b0;                                				
			end
			Execute_Orb: begin
                en_fetch = 1'b0;
                en_group = 1'b1;
                en_pc = 1'b0;
                pc_ctrl = 2'b00;
                reg_en = 4'b0000;
                alu_in_sel = 1'b1;
                alu_func = 4'b1000;
                en_ALUdec=1'b1;
		        en_ram=1'b0;
                en_mar=1'b0;
                mdr_ctrl=2'b00;
                wen_ram=1'b0;                                                
            end
			Execute_Xor: begin
                 en_fetch = 1'b0;
                 en_group = 1'b1;
                 en_pc = 1'b0;
                 pc_ctrl = 2'b00;
                 reg_en = 4'b0000;
                 alu_in_sel = 1'b0;
                 alu_func = 4'b1010;
                 en_ALUdec=1'b1;
		        en_ram=1'b0;
                 en_mar=1'b0;
                 mdr_ctrl=2'b00;
                 wen_ram=1'b0;                                               
            end
			Execute_Xorb: begin
                en_fetch = 1'b0;
                en_group = 1'b1;
                en_pc = 1'b0;
                pc_ctrl = 2'b00;
                reg_en = 4'b0000;
                alu_in_sel = 1'b1;
                alu_func = 4'b1010;
                en_ALUdec=1'b1;
		        en_ram=1'b0;
                en_mar=1'b0;
                mdr_ctrl=2'b00;
                wen_ram=1'b0;                                                
            end
			Execute_Jump: begin
				en_fetch = 1'b0;
				en_group = 1'b0;
				en_pc = 1'b1;
				pc_ctrl = 2'b10;
				reg_en = 4'b0000;
				alu_in_sel = 1'b0;
				alu_func = 4'b0000;
				en_ALUdec=1'b0;
		        en_ram=1'b0;
                en_mar=1'b0;
                mdr_ctrl=2'b00;
                wen_ram=1'b0;
                ena = 1'b1;
                en_pc = 1'b1;	                                				
			end
			Execute_Load: begin
                en_fetch = 1'b0;
                en_group = 1'b1;
                en_pc = 1'b0;
                pc_ctrl = 2'b00;
                reg_en = 4'b0000;
                alu_in_sel = 1'b1;
                alu_func = 4'b0000;
                en_ALUdec=1'b0;
		        en_ram=1'b1;
                en_mar=1'b1;
                mdr_ctrl=2'b01;
                wen_ram=1'b0;
                reg_in_sel=1'b1;				                                                               
            end
			Execute_Store: begin
                en_fetch = 1'b0;
                en_group = 1'b1;
                en_pc = 1'b0;
                pc_ctrl = 2'b00;
                reg_en = 4'b0000;
                alu_in_sel = 1'b1;
                alu_func = 4'b0000;
                en_ALUdec=1'b0;
		        en_ram=1'b1;
                en_mar=1'b1;
                mdr_ctrl=2'b10;
                wen_ram=1'b1;
                reg_in_sel=1'b1;				                                                                
            end
            
            Addressout:begin
                en_fetch = 1'b0;
                en_group = 1'b1;
                en_pc = 1'b0;
                pc_ctrl = 2'b00;
                reg_en = 4'b0000;
                alu_in_sel = 1'b1;
                alu_func = 4'b0000;
                en_ALUdec=1'b0;
                en_ram=1'b1;
                en_mar=1'b1;
                reg_in_sel=1'b1;				                                                                                    
            end
                        
            Mem_Load:begin
                en_ram=1'b1;
                en_mar=1'b0;
                mdr_ctrl=2'b01;
                wen_ram=1'b0;
                reg_in_sel=1'b1;				                                                                                    
            end
            
            Mem_Store:begin
		        en_ram=1'b1;
                en_mar=1'b0;
                mdr_ctrl=2'b10;
                wen_ram=1'b1;
                reg_in_sel=1'b1;				                                                                                     
            end
            
			Write_back: begin
			  if (opcode==4'b1101)begin 
                 reg_en = 4'b0000;
                 end
              else begin
				case(rd)
					2'b00: reg_en = 4'b0001;
					2'b01: reg_en = 4'b0010;
					2'b10: reg_en = 4'b0100;
					2'b11: reg_en = 4'b1000;
					default: reg_en = 4'b0000;
				endcase
				end
                en_ram=1'b1;
				wen_ram=1'b0;
				ena = 1'b1;	
		        en_pc = 1'b0;	
			end
			
			default: begin
				en_fetch = 1'b0;
				en_group = 1'b0;
				en_pc = 1'b0;
				pc_ctrl = 2'b00;
				reg_en = 4'b0000;
				alu_in_sel = 1'b1;
				alu_func = 4'b0000;
			end
		endcase
	end
end




always @ (posedge clk or negedge rst) begin
	if(!rst) begin
		en_fetch_reg <= 1'b0;
		en_pc_reg <= 1'b0;
		en_group_reg <= 1'b0;
		en_ALUdec_reg <= 1'b0;
		en_ram_reg <= 1'b0;
		en_mar_reg <= 1'b0;
	end
	else begin
		en_fetch_reg <= en_fetch;
		en_pc_reg <= en_pc;
		en_group_reg <= en_group;
		en_ALUdec_reg <= en_ALUdec;
		en_ram_reg <= en_ram;
        en_mar_reg <= en_mar;
	end
end

always @ (en_fetch or en_fetch_reg)
	en_fetch_pulse = en_fetch & (~en_fetch_reg);
	
always @ (en_pc_reg or en_pc)
	en_pc_pulse = en_pc & (~en_pc_reg);
	
always @ (en_group_reg or en_group)
	en_group_pulse = en_group & (~en_group_reg);
	
always @ (en_ALUdec or en_ALUdec_reg)
      en_ALUdec_pulse = en_ALUdec & (~en_ALUdec_reg);
      
always @ (en_ram_reg or en_ram)
          en_ram_pulse = en_ram & (~en_ram_reg);

always @ (en_mar_reg or en_mar)
          en_mar_pulse = en_mar & (~en_mar_reg);
          
endmodule