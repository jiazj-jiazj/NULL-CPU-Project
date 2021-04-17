module ByPass(input [5:0] op,   //op_ex           //add 1 1 2 add 1 1 3 add 1 1 4  /  add 1 1 2   addiu 1 imm16  addiu  1 imm16
  input [5:0] op_me,       //op_me
  input ExMem_RegWr,                                 //busA_ex,Result_me, Di
input ALUSrc,
input MemWr_RegWr,
input[4:0] ExMem_regRd,
input [4:0] MemWr_regRd,
input [4:0] Rs,        
input [4:0] Rt,
output reg [1:0] ALUSrcA,
output reg [1:0] ALUSrcB
);



always @(*)
begin
if(ExMem_RegWr&&ExMem_regRd&&(ExMem_regRd==Rs))  //
    ALUSrcA=2'b01;           //Result_me                                 //last instruction is sw or sb ， the third inst register use the first inst ending register
    else if(MemWr_RegWr&&MemWr_regRd&&(ExMem_regRd!=Rs|(ExMem_regRd==Rs&&(op_me==6'b101000|op_me==6'b101011)))&&(MemWr_regRd==Rs))
      ALUSrcA=2'b10;           //      Di      
    else ALUSrcA=2'b00; //busA_ex

  if(ExMem_RegWr&&ExMem_regRd&&(ExMem_regRd==Rt)&&(op==6'b101011|op==6'b101000))
    ALUSrcB=2'b11;//imm32_ex
 else if(ExMem_RegWr&&ExMem_regRd&&(ExMem_regRd==Rt)&&(op!=6'b001001)&&(op!=6'b001111)&&(op!=6'b100011)&&(op!=6'b100100))//addiu,lui,lw,lbu not included
    ALUSrcB=2'b01;//Result_me
    else if(MemWr_RegWr&&MemWr_regRd&&(ExMem_regRd!=Rt)&&(MemWr_regRd==Rt)&&(op==6'b101011|op==6'b101000))
    ALUSrcB=2'b11;//imm32_ex
    else if(MemWr_RegWr&&MemWr_regRd&&(ExMem_regRd!=Rt|(ExMem_regRd==Rt&&ExMem_RegWr==0))&&(MemWr_regRd==Rt)&&(op!=6'b001001)&&(op!=6'b001010)&&(op!=6'b001011)&&(op!=6'b100000)&&(op!=6'b100100)&&(op!=6'b001100)&&(op!=6'b001110))     //addiu，slti，sltiu, lb,lbu,addi,xori not included
    ALUSrcB=2'b10;//Di
    else if(ALUSrc)
    ALUSrcB=2'b11;//imm32_ex
    else ALUSrcB=2'b00;//busB_ex
end

endmodule

