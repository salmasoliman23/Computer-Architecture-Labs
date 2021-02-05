`timescale 1ns / 1ps


module ALU_Control(input [1:0]aluop, input [14:12]intr1,input  instr2 ,output reg[3:0]aluS);
always @(*)
begin
if(aluop==2'b00)
aluS=4'b0010;
else if(aluop==2'b01 )
aluS=4'b0110;
else if (aluop==2'b10 && intr1==3'b000 && instr2==1'b0)
aluS=4'b0010;
else if (aluop==2'b10&&intr1==3'b000&&instr2==1)
aluS=4'b0110;
else if (aluop==2'b10&&intr1==3'b111&&instr2==0)
aluS=4'b0000;
else if (aluop==2'b10&&intr1==3'b110&&instr2==0)
aluS=4'b0001;

end
endmodule

