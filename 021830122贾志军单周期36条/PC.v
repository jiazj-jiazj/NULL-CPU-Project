module  PC(input [31:0]NPC,output reg [31:0]pc,input rst,input clk);

always@(posedge clk)
begin
    if(rst)
    pc<=32'h0000_0000;
    else 
    pc<=NPC;
end
endmodule