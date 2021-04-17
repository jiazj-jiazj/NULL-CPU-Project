
module testbanch_single;
reg clk;
reg rst;
mips mips(clk,rst);


initial 
begin
 rst=1;
 clk=0;
 #10 rst=0;
end
always 
 #5 clk=~clk;

// reg [31:0] clk;
// initial
// clk=32'h0000000c << 5'b10000;

// reg [5:0] op,func;
// wire Branch,Jump,RegDst,ALUSrc,MemtoReg,RegWr,MemWr,ExtOp,Rtype;
// wire[4:0] ALUop,funcop,ALUctr;


// ctrl ctrl(op,func,Branch,Jump,RegDst,ALUSrc,MemtoReg,RegWr,MemWr,ExtOp,Rtype,ALUop,funcop,ALUctr);




// initial

    
//     op=6'b100011;
  


endmodule


