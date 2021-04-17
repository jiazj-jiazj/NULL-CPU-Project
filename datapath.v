
module datapath(clk,rst,Branch,Jump,RegDst,ALUSrc,MemtoReg,RegWr,MemWr,ExtOp,ALUctr,op,func,Rt); 

  input clk,rst,Branch,Jump,RegDst,ALUSrc,MemtoReg,RegWr,MemWr,ExtOp; 
  input [4:0]ALUctr; 
 
  output[5:0] op,func;
  output[4:0] Rt;

  wire[31:0] PC, NPC;
  wire[31:0] instructions;
  pc pc(NPC, PC, rst, clk);
  im im(PC[11:2], instructions);

  wire[4:0] Rs, Rt, Rd, shamt;
  wire[15:0] imm16;
  wire[25:0] Target;
  instruction instruction(instructions, op, Rs, Rt, Rd, shamt, func, imm16, Target);
 
  wire[31:0] Result;
  wire[31:0] busW, busA, busB;
  wire[4:0] Rw, Ra, Rb;
  assign Rw = RegDst ? Rd : Rt;
  assign Ra = Rs;
  assign Rb = Rt;
  reg_file reg_file(Result, RegWr, Rw, Ra, Rb, busW, clk, busA,busB,op,func,Rd,PC);

  wire[31:0] imm32;
  ext ext(imm16, imm32, ExtOp);
 
  wire Zero;
  wire[31:0] tempBus;
  assign tempBus = ALUSrc ? imm32 : busB;
  alu alu(ALUctr,busA,tempBus,shamt,Result,Zero); 

  wire[31:0] dout;
  dm dm(Result, busB, MemWr,op,clk,dout);
  assign busW = MemtoReg ? dout : Result;
 
  npc npc(PC,NPC,Target,Jump,Branch,Zero,imm16,op,func,busA,Rt);

endmodule 
