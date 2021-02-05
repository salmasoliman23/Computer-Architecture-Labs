`timescale 1ns / 1ps
module DataCacheController( input rst,
input clk, input MemRead, input MemWrite,
 input [4:0] index,input [2:0] tag,
 input MsReady,output reg stall,
 output reg fill,output reg update,output  reg MsRead
    );
    
    reg [2:0] tags [0:31];
    reg valid_bits [0:31];
    
    wire hit;
    reg [1:0] current;
    reg [1:0] next;
    parameter [1:0] idle = 2'b00,read = 2'b10,write = 2'b01;
    
    integer i ;
    initial begin 
    for (i=0;i<32;i=i+1)begin
    
    valid_bits[i] = 1'b0;
    
    tags[i]=0;
    end
    end
    
    assign hit = valid_bits[index] && tags[index]==index ;
    always @(posedge clk or posedge rst)
    begin
    if (rst)
    current = idle;
    else
    current = next;
    end
    
    
    //FSM
    always @(*)
    begin
    stall=0;
    case (current)
    
    
    idle:
    if (MemRead && !hit)
    begin
    next = read;
    stall = 1;
    MsRead = 1;
    end 
    else if (MemWrite)
    begin
    next = write;
    stall =1;
   
    if (hit)
    update = 1;
    else
    update =0;
    end
    else 
    begin 
    next=idle;
    stall=0;
    fill=0;
    update=0;
     MsRead=0;
     end
     
    
    
    
    
    
    read:
    if (MsReady)
    begin
    next = idle;
    stall=1;
    MsRead=0;
    fill=1;
    //??
    valid_bits[index] =1;
    tags[index] = tag;
    end
    else 
    begin
    next = read;
    stall=1;
    end
 
 
 
    write:
    if  (MsReady)
    begin
    next = idle;
    stall=0;
     MsRead=0;
     fill=0;
     update=0;
     end
     else begin
     next=write;
     stall=1;
     end
     
 default:
 begin
 stall=0;
 next=current;
 end
 endcase    
    
    end
endmodule

