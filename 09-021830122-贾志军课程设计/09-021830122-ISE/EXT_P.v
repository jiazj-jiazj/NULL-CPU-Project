module EXT_P(imm16,imm32,ExtOp);
input [15:0] imm16;
output [31:0] imm32;
input ExtOp;
assign imm32=(ExtOp==1)?{{16{imm16[15]}},imm16}:{16'b0,imm16};
endmodule

