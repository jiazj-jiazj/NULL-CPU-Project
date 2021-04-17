module mips(
    clk,
    rst
);
input  clk;
input  rst;

wire [5:0] op,func;
wire [4:0] ALUctr,funcop,ALUop;
wire RegWr,ALUSrc,RegDst,MemtoReg,MemWr,Branch,Jump,ExtOp,Rtype;

DataPath datap(clk,rst,Branch,Jump,RegDst,ALUSrc,MemtoReg,RegWr,MemWr,ExtOp,ALUctr,op,func);
ctrl ctrl(op,func,Branch,Jump,RegDst,ALUSrc,MemtoReg,RegWr,MemWr,ExtOp,Rtype,ALUop,funcop,ALUctr);





endmodule