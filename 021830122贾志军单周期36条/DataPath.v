module DataPath(clk,rst,Branch,Jump,RegDst,ALUSrc,MemtoReg,RegWr,MemWr,ExtOp,ALUctr,op,func,Rt);

input clk,rst,Branch,Jump,RegDst,ALUSrc,MemtoReg,RegWr,MemWr,ExtOp;
input [4:0] ALUctr;
output [5:0] op,func;
output [4:0] Rt;


wire [31:0] pc,NPC;
wire[31:0] instructions;
PC  PC(NPC,pc,rst,clk);
im_4k im(pc[11:2],instructions);

wire [4:0] Rs,Rt,Rd,shamt;
wire[15:0] imm16;
wire[25:0]  Target;

instruction instruction(instructions,op,Rs,Rt,Rd,shamt,func,imm16,Target);
wire [31:0] Result;
wire[31:0] busW,busA,busB;
wire[4:0] Rw,Ra,Rb;
assign Rw=RegDst?Rd:Rt;
assign Ra=Rs;
assign Rb=Rt;

wire RegWr_new;
wire  overflow;
assign RegWr_new=(RegWr&!overflow);
register register(Result,RegWr_new,Rw,Ra,Rb,busW,clk,busA,busB,op,func,Rd,pc);

wire[31:0] imm32;
ext ext(imm16,imm32,ExtOp);//ext模块还没写

wire zero;
wire[31:0] tempBus;
assign tempBus=ALUSrc?imm32:busB;

O_ALU alu(ALUctr,busA,tempBus,shamt,Result,zero,overflow);

wire[31:0] dout;
dm_4k dm(Result,busB,MemWr,op,clk,dout);

assign busW=MemtoReg?dout:Result;

npc npc(pc,NPC,Target,Jump,Branch,zero,imm16,op,func,busA,Rt);



endmodule
// module DataPath(clk,rst,Branch,Jump,RegDst,ALUSrc,MemtoReg,RegWr,MemWr,ExtOp,ALUctr,op,func,Rt);

// input clk,rst,Branch,Jump,RegDst,ALUSrc,MemtoReg,RegWr,MemWr,ExtOp;
// input [4:0] ALUctr;
// output [5:0] op,func;
// output [4:0] Rt;


// wire [31:0] pc,NPC;
// wire[31:0] instructions;
// PC  PC(NPC,pc,rst,clk);
// im_4k im(pc[11:2],instructions);

// wire [4:0] Rs,Rt,Rd,shamt;
// wire[15:0] imm16;
// wire[25:0]  Target;

// instruction instruction(instructions,op,Rs,Rt,Rd,shamt,func,imm16,Target);
// wire [31:0] Result;
// wire[31:0] busW,busA,busB;
// wire[4:0] Rw,Ra,Rb;
// assign Rw=RegDst?Rd:Rt;
// assign Ra=Rs;
// assign Rb=Rt;
// register register(Result,RegWr,Rw,Ra,Rb,busW,clk,busA,busB,op,func,Rd,pc);

// wire[31:0] imm32;
// ext ext(imm16,imm32,ExtOp);//ext模块还没写

// wire zero;
// wire[31:0] tempBus;
// assign tempBus=ALUSrc?imm32:busB;
// wire  overflow;
// O_ALU alu(ALUctr,busA,tempBus,shamt,Result,zero,overflow);

// wire[31:0] dout;
// dm_4k dm(Result,busB,MemWr,op,clk,dout);

// assign busW=MemtoReg?dout:Result;

// npc npc(pc,NPC,Target,Jump,Branch,zero,imm16,op,func,busA,Rt);



// endmodule
