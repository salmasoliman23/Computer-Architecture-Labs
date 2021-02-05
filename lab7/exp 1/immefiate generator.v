`timescale 1ns / 1ps

module immediate_generator(output reg [31:0] gen_out, input [31:0] inst );
always @(*)
begin
if(inst[6]==0 && inst[5]==0) //lw
         begin
          gen_out={{inst[31]?20'hFFFFF:20'h00000},inst[31:20]};
          end
else if(inst[6]==0 && inst[5]==1)//sw
        begin
           gen_out={{inst[31]?20'hFFFFF:20'h00000},inst[31:25],inst[11:7]};
        end
else if(inst[6]==1)  //BEQ
        begin
           gen_out={{inst[31]?20'hFFFFF:20'h00000},inst[31],inst[7],inst[31:25],inst[11:8]};
         end
end 
endmodule

