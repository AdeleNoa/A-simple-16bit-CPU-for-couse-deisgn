`define LDR 2'b01
`define STR 2'b10

module MDR(clk, rst, data_ram2mdr,data_mdr2reg, data_reg2mdr, data_mdr2ram, en_mdr);
input clk,rst;
input [1:0] en_mdr;
input [15:0] data_ram2mdr,data_reg2mdr;
output reg [15:0] data_mdr2reg, data_mdr2ram;

always@(posedge clk or negedge rst) begin
     if(!rst) begin
           data_mdr2reg <= 16'b000000000001;
           data_mdr2ram <= 16'b000000000000;
       end
       else begin
                   if(en_mdr== 2'b01) begin
                           data_mdr2reg <= data_ram2mdr;
                       end
                       else begin
                            if(en_mdr == 2'b10) begin
                                data_mdr2ram <= data_reg2mdr;
                       end
                       else begin
                             data_mdr2reg <= 16'b000000000001;
                             data_mdr2ram <= 16'b000000000000;
                       end
                   end
             end
end
endmodule