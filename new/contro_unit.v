module control_unit (
 clk,rst,en,en_alu,en_in	,ins,
	offset_addr,en2,	en_group_pulse,en_pc_pulse,reg_en,alu_in_sel,alu_func,pc_ctrl ,en_ALUdec_pulse, en_fetch_pulse,	
	rd,rs,en_ram,wen_ram,en_mar_pulse,mdr_ctrl, reg_in_sel,ena	
);
input clk,rst,en,en_alu	,en_in,en2;	
input [15:0] ins;
output en_group_pulse,en_pc_pulse,alu_in_sel, en_fetch_pulse, ena;
output en_ram,wen_ram,en_mar_pulse;
output [1:0]    mdr_ctrl;	
output [7:0]	offset_addr;
output [3:0]	reg_en;
output [3:0]	alu_func;
output [1:0]	pc_ctrl;
output en_ALUdec_pulse;
output reg [1:0]rd,rs;
output reg_in_sel;

wire [15:0] ir_out ;
wire	en_out ;
reg [7:0] offset_addr;
ir ir1 (
				.clk(clk)	,
				.rst(rst)   ,
				.ins(ins)   ,
				.en_in(en_in)	,
				.en_out(en_out),
				.ir_out(ir_out)
				);
	
	
state_transition state_transition(
					.clk(clk) ,
					.rst(rst) ,
					.en1(en_out) ,
					.en_in(en_in),
					.en2(en2) ,
					.rd(ir_out[11:10]) ,
					.opcode(ir_out[15:12])  ,
					.en_fetch_pulse(en_fetch_pulse),	
					.en_group_pulse(en_group_pulse),
					.en_pc_pulse(en_pc_pulse)  ,
					.en_ALUdec_pulse(en_ALUdec_pulse),
					.pc_ctrl(pc_ctrl) ,
					.reg_en(reg_en) ,
					.alu_in_sel(alu_in_sel)	,
					.alu_func(alu_func),
					.en_ram(en_ram),
					.wen_ram(wen_ram),
					.en_mar_pulse(en_mar_pulse),
				    .mdr_ctrl(mdr_ctrl),
				    .reg_in_sel(reg_in_sel),
				    .ena(ena)
				);
				
always @ (*) 
                   begin
                        offset_addr = ins[7:0];
                        rs=ins[9:8];
                        rd=ins[11:10];
                    end


endmodule







