`timescale 1ns / 1ps

module Control_unit(input [6:2]opcode, output reg branch,
output reg  memread,output reg  memtoreg,
output reg [1:0]aluop,output reg memwrite, output reg  alusrc,output reg regwrite );

always @(*)
begin
case(opcode) 
5'b01100 : 
begin 
 branch=0;
  memread=0;
   memtoreg=0;
 aluop=10;
  memwrite=0; 
   alusrc=0;
    regwrite=1;
end
5'b00000 :
begin 
 branch=0;
  memread=1;
   memtoreg=1;
 aluop=00;
  memwrite=0; 
   alusrc=1;
    regwrite=1;
end
5'b01000:
begin 
 branch=0;
  memread=0;
   memtoreg=1;
 aluop=00;
  memwrite=1; 
   alusrc=1;
    regwrite=0;
end
5'b11000:
begin 
 branch=1;
  memread=0;
  // memtoreg=1;
 aluop=01;
  memwrite=0; 
   alusrc=0;
    regwrite=0;
end
default :
begin
 branch=0;
 memread=0;
  memtoreg=0;
aluop=2'b00;
 memwrite=0; 
  alusrc=0;
   regwrite=0;
   end
endcase
end

endmodule

