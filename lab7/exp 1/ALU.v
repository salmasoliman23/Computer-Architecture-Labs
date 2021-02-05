`timescale 1ns / 1ps



module ALU (
input [31:0] in1, in2,
input [3:0] aluSel,
output reg [31:0] result, output zero );
wire c1, c2;
wire [31:0]sum;
ripple_carry plus( in1,in2, 0,sum,c1);

wire [31:0]sub;
ripple_carry subt( in1,~in2+1, 0,sub,c2);
always @(*)
begin
case(aluSel)
4'b0010: result= sum;//ripple  carry ;
4'b0110 :result= sub ;   
4'b0000 : result= in1 & in2  ;
4'b0001 :  result= in1 | in2 ;
default:result=0;
endcase
end
  assign zero={result==0?1:0};
endmodule

