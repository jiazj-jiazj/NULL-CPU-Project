module  PC_P(input clk,input rst,input loaduse,input [31:0] NPC,output reg [31:0] pc);

always@(negedge clk)
begin
    if(rst)
    pc<=32'h0000_0034;
    else 
    if(loaduse);   
    else
    pc<=NPC;
end
endmodule

