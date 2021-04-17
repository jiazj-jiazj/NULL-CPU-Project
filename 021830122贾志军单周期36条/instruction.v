module instruction(Instruction,op,rs,rt,rd,shamt,func,imm16,Target);
input [31:0] Instruction;
output [31:26] op;
output [25:21] rs;
output [20:16] rt;
output [15:11] rd;
output [10:6] shamt;
output [5:0] func;
output [15:0] imm16;
output [25:0] Target;

assign op=Instruction[31:26];
assign rs=Instruction[25:21];
assign rt=Instruction[20:16];
assign rd=Instruction[15:11];
assign shamt=Instruction[10:6];
assign func=Instruction[5:0];
assign imm16=Instruction[15:0];
assign Target=Instruction[25:0];
    
endmodule
