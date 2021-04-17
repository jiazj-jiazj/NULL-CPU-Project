module MUX_A(input [1:0] ALUSrcA,input [31:0]A,input[31:0] B,input[31:0] C,output reg [31:0] out);
always @(*)
begin
    case(ALUSrcA)
    2'b00:out<=A;
    2'b01:out<=B;
    2'b10:out<=C;
    endcase
end

endmodule
