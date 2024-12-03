`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/10/11 19:57:17
// Design Name: 
// Module Name: tb_data_path
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


module tb_data_path(

    );
    reg clk,rst,en_ALUdec,alu_in_sel,en_pc,w_en;
    reg [7:0] offset;
    reg [1:0] rd,rs,pc_ctrl;
    reg [3:0] reg_en;
    reg [3:0] alu_func;
    wire [15:0] pc_out;
    
    
    data_path test_data_path(
                .clk(clk), 
                .rst(rst), 
                .alu_func(alu_func),
                .offset(offset),
                .alu_in_sel(alu_in_sel),
                .en_ALUdec(en_ALUdec),
                .rd(rd),
                .rs(rs), 
                .reg_en(reg_en), 
                .pc_ctrl(pc_ctrl), 
                .en_pc(en_pc), 
                .w_en(w_en), 
                .pc_out(pc_out)
    );
    
    parameter Tclk=10;
    initial
        begin
            clk=0;
            forever #(Tclk/2) clk=~clk;
        end
        
    initial//ϵͳ��ʼ��
        begin
            rst = 1'b0;
            en_pc = 1'b0;
            reg_en = 4'b0000;
            w_en = 1'b0;
            en_ALUdec = 1'b0;
            #(Tclk) rst =1'b1;
        end
        
    always @(negedge rst or posedge clk)//ÿ��ʱ�ӵ�en����
        begin;
            en_ALUdec =1'b1;
            en_pc = 1'b1;
            w_en = 1'b1;
            reg_en = 4'b0011;//д��0�żĴ���//д��1�żĴ���
            #(Tclk/8)en_pc = 1'b0;
            reg_en = 4'b0000;//�ر�д��Ĵ���
            w_en = 1'b0;
            en_ALUdec = 1'b0;
        end
        
     initial
        begin
            alu_in_sel = 0;//����������
            #(Tclk*20) alu_in_sel = 1;//�Ĵ�������
        end
        
     initial
        begin
            alu_func = 4'b0010;//�ӷ�
        end
        
     initial
        begin
            offset = 8'b00000001;//������
            #(Tclk*8)offset = 8'b00001001;
        end
      
      initial
        begin
            rs = 2'b00;//op_a = rs_q = 0�żĴ�����ֵ
            rd = 2'b01;//op_b = rd_q = 1�żĴ�����ֵ
        end  
        
      initial
        begin
            pc_ctrl = 2'b01;
        end
        
      initial
            begin
                #(Tclk*40)  $stop;
            end
endmodule
