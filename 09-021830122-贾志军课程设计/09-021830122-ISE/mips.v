module mips(input clk,input rst);
//IF
wire [31:0] pc,npc;
wire loaduse,loaduse_ex,loaduse_me,loaduse_wr;
wire [31:0] instructions;
PC_P PC_P( clk, rst, loaduse, npc, pc);

IM_P IM_P(pc,instructions);
wire [5:0] func_id,func_ex,func_me,func_wr;
//ID
wire [5:0] op_id,op_ex,op_me,op_wr;
wire zero_ex,zero_me;
wire xiaoc,xiaoc_id,xiaoc_ex,xiaoc_me,xiaoc_wr;  
wire [31:0] Di;
wire [4:0] Rw_wr,Rw_id,Rw_ex,Rw_me;
wire RegWr_wr,RegWr_id,RegWr_ex,RegWr_me;
wire [31:0] busA_id,busA_ex,busA_me,busA_wr;
wire [31:0] busB_id,busB_ex,busB_me,busB_wr;
wire [31:0] busA_end,busB_end;
wire [31:0] busB_ex_end;
wire [31:0] pc_id,pc_ex,pc_me,pc_wr;
wire [4:0] Rs_ex,Rt_ex,Rd_ex,Rs_id,Rt_id,Rd_id,Rs_me,Rt_me,Rd_me,Rs_wr,Rt_wr,Rd_wr;
wire MemRead_ex,MemRead_id,MemRead_me,MemRead_wr;
wire ExtOp_id,ExtOp_ex,ExtOp_me,ExtOp_wr;
wire sb_id,sb_ex,sb_me,sb_wr;
wire MemWr_id,MemWr_ex,MemWr_me,MemWr_wr;
wire [31:0] Do_me,Do_wr;
wire [4:0] shamt_ex,shamt_id,shamt_me,shamt_wr;
wire [4:0] ALUctr_ex;
wire [15:0]imm16_ex,imm16_id,imm16_me,imm16_wr;
wire RegDst_ex,RegDst_ID;
wire ALUSrc_ex;
wire [31:0] imm32_ex;
wire [1:0] ALUSrcA_ex,ALUSrcB_ex;
wire MemtoReg_wr,MemtoReg_me;
wire [25:0] Target_id;

wire [31:0] Result_wr,Result_ex,Result_me,Result_next_ex,Result_next_me,Result_next_wr,Result_ex_new;
IFID_P IFID_P( clk, pc, instructions, loaduse , xiaoc,op_id,Rs_id,Rt_id,Rd_id,func_id,shamt_id,imm16_id,Target_id,xiaoc_id,  pc_id);
Loaduse Loaduse(MemRead_ex,Rs_id,Rt_id, Rt_ex, loaduse);

wire   WE_HI_wr,WE_LO_wr,WE_HI_LO_wr,WE_CPR_wr;

wire [31:0] A_ALU,B_ALU; //
wire [31:0] Lo_out,CPR_out,CPR_out_14,Hi_out;



RFile_P RFile_P(clk,Result_next_wr,Result_wr,func_id[2:0],Rd_id,op_wr,func_wr,Rd_wr,func_wr[2:0],pc_wr, Rs_id, Rt_id, Rw_wr, Di, RegWr_wr,WE_HI_wr,WE_LO_wr,WE_HI_LO_wr,WE_CPR_wr, busA_id,busB_id,Lo_out,Hi_out,CPR_out,CPR_out_14);

wire[1:0] Ce_A,Ce_B;




ByPass_T ByPass_T( op_ex, op_id,op_me,func_id, Rw_me, Rw_ex, Rs_id, Rt_id,RegWr_me, Ce_A,Ce_B);
MUX_B MUX_B_2(Ce_A,busA_id,Result_ex,Result_me,Do_me,busA_end);
MUX_B MUX_B_1(Ce_B,busB_id,Result_ex,Result_me,Do_me,busB_end);

reg  J_Q_1;
reg [31:0] NPC_J_1;
wire [31:0] NPC_J;

initial
begin
    NPC_J_1<=0;
    J_Q_1<=0;

end
wire J_Q;
always @(negedge clk) NPC_J_1=NPC_J;
always @(negedge clk)  J_Q_1=J_Q;

NPC_P NPC_P(CPR_out_14,Rd_ex,Rs_id,Result_ex,pc_id,pc, busA_end,busB_end,J_Q_1,NPC_J_1,B_ALU,op_ex,Rs_ex,instructions[5:0],func_id,imm16_id,instructions[15:0],Target_id,instructions[25:0],op_id,instructions[31:26],Rt_id,npc,NPC_J,xiaoc,J_Q);  //下条指令

//EX



wire [31:0] Lo_out_ex, Hi_out_ex, CPR_out_ex;
IDEX_P IDEX_P(clk, pc_id,xiaoc_id,loaduse,busA_id,busB_id,Lo_out,Hi_out,CPR_out,op_id,func_id,Rs_id,Rt_id,Rd_id,shamt_id,imm16_id,op_ex,func_ex,ALUctr_ex,busA_ex,busB_ex,loaduse_ex,shamt_ex,Rs_ex,
 Rt_ex,Rd_ex, ExtOp_ex, RegDst_ex,MemRead_ex,imm16_ex,ALUSrc_ex,xiaoc_ex,pc_ex,Lo_out_ex, Hi_out_ex, CPR_out_ex);




EXT_P  EXT_P(imm16_ex,imm32_ex,ExtOp_ex);
 MUX_A MUX_A(ALUSrcA_ex,busA_ex,Result_me, Di,A_ALU);
 MUX_B MUX_B(ALUSrcB_ex,busB_ex,Result_me,Di,imm32_ex,B_ALU);



ALU_P ALU_P(op_ex,func_ex,Rs_ex,pc_ex,busA_ex,busB_ex,Lo_out_ex,Hi_out_ex,CPR_out_ex,ALUctr_ex,A_ALU,B_ALU,shamt_ex,Result_ex,zero_ex,Result_next_ex);


assign Rw_ex=(RegDst_ex==1)?Rt_ex:Rd_ex;






ByPass_M ByPass_M( RegWr_wr,busB_ex,Rt_ex,Rd_wr,op_ex,Di,busB_ex_end);    
//MEM

wire CPR_wr_me,Hi_wr_me,Lo_wr_me,Hi_Lo_wr_me;


ByPass_X ByPass_X(func_ex,Result_ex,Result_me,Result_next_me,Result_wr,Result_next_wr,Hi_wr_me,WE_HI_wr,Lo_wr_me,WE_LO_wr,Hi_Lo_wr_me,WE_HI_LO_wr,Result_ex_new);  


ExMem ExMem(clk,RegWr_me,Rw_me,Rt_ex,Result_me,pc_ex,xiaoc_ex,zero_ex,Result_ex_new,Result_next_ex,busB_ex_end,loaduse_ex, Rw_ex, op_ex,func_ex,Rs_ex,Rd_ex, loaduse_me,op_me,
 func_me,Rs_me,Rt_me,Rd_me,zero_me,Result_me,  //Adr
busB_me,   //Datain
Rw_me,RegWr_me, sb_me,//控制信号 out
 MemWr_me ,//注意消除
 xiaoc_me,
 pc_me,
 Result_next_me,
 CPR_wr_me,
Hi_wr_me,
Lo_wr_me,
Hi_Lo_wr_me
);



DataMem DataMem( clk,sb_me,  MemWr_me, Result_me, busB_me, Do_me);

ByPass ByPass(op_ex,op_me,RegWr_me,ALUSrc_ex,RegWr_wr, Rw_me, Rw_wr,Rs_ex,Rt_ex,ALUSrcA_ex,ALUSrcB_ex);

//REGWR




MemWr MemWr_1( clk,pc_me,xiaoc_me,loaduse_me,op_me,func_me,Rd_me,Do_me, Result_me, Result_next_me,Rw_me,  CPR_wr_me,
Hi_wr_me,
Lo_wr_me,
Hi_Lo_wr_me,RegWr_me,loaduse_wr,op_wr,func_wr,Rd_wr, Do_wr,Result_wr,Rw_wr, MemtoReg_wr, RegWr_wr,xiaoc_wr,pc_wr,WE_CPR_wr,WE_HI_wr,WE_LO_wr,WE_HI_LO_wr,Result_next_wr);

assign Di=(MemtoReg_wr==1)?Do_wr:Result_wr;
endmodule

