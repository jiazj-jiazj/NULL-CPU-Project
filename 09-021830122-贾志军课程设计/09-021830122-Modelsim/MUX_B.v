
module MUX_B(input [1:0] ALUSrcB,input [31:0]A,input[31:0] B,input[31:0] C,input [31:0] D,output reg [31:0] out);
always @(*)
begin
    case(ALUSrcB)
    2'b00:out<=A;
    2'b01:out<=B;
    2'b10:out<=C;
    2'b11:out<=D;
    endcase
end

endmodule
