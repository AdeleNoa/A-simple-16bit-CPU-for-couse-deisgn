module cpu(clk,rst ,en_in,ins,en2,en_fetch,pc_out,en_ram,wen_ram,en_mar_pulse,mdr_ctrl, ram_data, regout, offset_out,led,ena);

input         clk,rst ,en_in, en2;
input  [15:0] ins,ram_data;
output [15:0]  pc_out, regout;
output en_fetch;
output en_ram,wen_ram,en_mar_pulse;
output [1:0]mdr_ctrl;	
output ena;

output reg  [7:0] offset_out;
output reg [7:0] led;
wire  en_pc_pulse,en_group_pulse,alu_in_sel,en_alu,en_ALUdec_pulse,reg_in_sel;
wire  [1:0]  pc_ctrl;
wire  [3:0]  reg_en;
wire  [3:0]  alu_func;
wire  [7:0]  offset_addr;
wire  [15:0] led_out;
			

data_path data_path1 (
					.clk(clk),
					.rst(rst),
					.offset(offset_addr),
					.offset_addr(offset_addr),
					.en_pc(en_pc_pulse),
					.pc_ctrl(pc_ctrl),
					.w_en(en_group_pulse) ,
					.reg_en(reg_en) ,
				    .rd(ins[11:10]),
					.rs(ins[9:8]),
					.en_ALUdec(en_ALUdec_pulse),
				    .alu_in_sel(alu_in_sel),
				    .alu_func(alu_func),
                    .pc_out(pc_out),
                    .led_out(led_out),
                    .reg_in_sel(reg_in_sel), 
                    .ram_data(ram_data),
                    .regout(regout)
				);	                     

control_unit control_unit1(
					.clk(clk ) ,
					.rst(rst) ,
					.en_in(en_in)  ,
					.en2(en2),
					.ins(ins),
					.offset_addr(offset_addr),
				    .en_group_pulse(en_group_pulse ),
					.en_pc_pulse(en_pc_pulse),
				    .reg_en(reg_en),
				    .alu_in_sel(alu_in_sel),
					.alu_func (alu_func),
					.pc_ctrl(pc_ctrl),
					.en_ALUdec_pulse(en_ALUdec_pulse),
					.en_fetch_pulse(en_fetch),
					.en_ram(en_ram),
                    .wen_ram(wen_ram),
                    .en_mar_pulse(en_mar_pulse),
                    .mdr_ctrl(mdr_ctrl),
                    .reg_in_sel(reg_in_sel),
                    .ena(ena)								
				);
				
always@(*)	begin
    offset_out = offset_addr;
end

always@(posedge clk or negedge rst)
    if(rst == 0) begin
        led <= 8'b00000000;
        end
    else begin
       led <= led_out[7:0]; 
    end
    

    
endmodule				