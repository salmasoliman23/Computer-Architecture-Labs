`timescale 1ns / 1ps
module DataMemSys( input rst,
input clk, input MemRead, input MemWrite,
input [9:0] addr, input[31:0] data_in,
output [31:0] data_out, output stall);

wire[1:0] wordoffset = addr [1:0];
wire [127:0] MsDataIn;
wire fill;
wire update;
wire [4:0]index = addr [6:2];
wire [2:0]tag = addr[9:7];
wire MsReady;
DataCache cachhe (clk,update, fill, wordoffset,index,
                  data_in,data_out,MsDataIn );
                 
DataMem mm (clk,MsRead,MemWrite,addr,data_in, MsDataIn, MsReady);

DataCacheController cont( rst,clk,MemRead, MemWrite, index, tag, MsReady,stall,fill, update, MsRead );


endmodule

