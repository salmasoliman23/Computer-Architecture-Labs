`timescale 1ns / 1ps


module sixtyFour_reg #(parameter n=64)(input clk,input S,input [n-1:0] in,input rst, output [n-1:0] Q );
    genvar i;  
    generate 
    for (i=0;i<n;i=i+1)
    begin
        onebitReg mod1 (   in[i],  S, clk,  rst,   Q[i]);
        end 
       endgenerate 
    endmodule



