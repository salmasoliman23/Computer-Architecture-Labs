    `timescale 1ns / 1ps
    module DataMem
    (input clk, input MemRead, input MemWrite,
    input[9:0] addr, input [31:0] data_in, output reg [127:0] MsDataOut, output reg Msready);
    reg [31:0] mem [0:1023];//4KB memory
    wire[9:0] bAddr;
    assign bAddr = {addr[9:2],2'b00};
    
    always  @(posedge clk)
    begin
    Msready <= 0;
    if (MemWrite)
     begin 
     repeat (3) begin// Wait for 3 clock cycles
     @ (posedge clk);
     end
     mem[addr] <= data_in;
     Msready <= 1;
     end
     else if (MemRead) 
     begin
     repeat (3) begin
     @ (posedge clk);
     end
     MsDataOut <={mem[bAddr+3],mem[bAddr+2],mem[bAddr+1],mem[bAddr+0]};
     Msready <= 1;
     end
     end
    initial
     begin
     mem[0]=32'd17;
     mem[1]=32'd9;
     mem[2]=32'd25; 
     end
    
    
     endmodule
