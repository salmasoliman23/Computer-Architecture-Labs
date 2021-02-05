`timescale 1ns / 1ps
module DataCache(input clk,input update,input fill,
                 input [1:0] wordoffset,input [4:0] index,
                 input [31:0] data_in,output [31:0] data_out,input [127:0] MsDataIn );
                 
                 reg [31:0] cache [0:31][0:3];
                 
always @(posedge clk)
begin
if (update)
//if i want to update a certain word of a certain block
cache[index][wordoffset]<= data_in;
if (fill)
// taking one block of the mem and put it into the cache
{cache [index][3],cache [index][2],cache [index][1],cache [index][0]} <= MsDataIn; 
  end  
// if i want to get a certain word from a certain blockfrom the cache  
  assign data_out = cache [index][wordoffset];
  
endmodule

