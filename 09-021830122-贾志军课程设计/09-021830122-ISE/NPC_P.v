module NPC_P(   //delay slot 45
input [31:0] ID_CPR_out_14,
input [4:0] Rd_ex,
input [4:0] Rs_id,
input [31:0] Result_ex,

input [31:0]ID_PC,
input [31:0] IF_PC,
// input [31:0] IF_inst,
// input [31:0] ID_inst,
input [31:0] ID_busA,
input [31:0] ID_busB,

input  J_Q_1, // J,JAL delay slot inst
input [31:0] NPC_J_1,// last branch/jump inst


input [31:0] B_ALU,

input [5:0] EX_OP,
input  [4:0] Rs_ex,
input [5:0] IF_FUNC,
input [5:0] ID_FUNC,
input  [15:0] ID_imm16,
input [15:0] IF_imm16,
input [25:0] ID_Target,
input [25:0] IF_Target,
input [5:0] ID_OP,
input [5:0] IF_OP,
input [4:0] rt,                  ////Rt_id

output reg [31:0] NPC,
output reg [31:0] NPC_J,
output reg xiaoc,
output reg J_Q
);

// wire [4:0]rt;
// assign rt=ID_inst[20:16];

wire[31:0] ID_imm32,IF_imm32;



assign ID_imm32={{14{ID_imm16[15]}},ID_imm16,2'b00};  //Branch 地址
assign IF_imm32={{14{IF_imm16[15]}},IF_imm16,2'b00};

wire [31:0] ID_BNC,IF_BNC,ID_JNC,IF_JNC;

wire [31:0] ID_PC_4,IF_PC_4;
assign ID_PC_4=ID_PC+4;
assign IF_PC_4=IF_PC+4;

// assign ID_FUNC=ID_inst[5:0];

assign ID_BNC=ID_PC+ID_imm32+4;
assign IF_BNC=IF_PC+IF_imm32;
assign ID_JNC={ID_PC_4[31:28],ID_Target,2'b00};
assign IF_JNC={IF_PC_4[31:28],IF_Target,2'b00};

always @(*)
begin
    if(J_Q_1)
    begin
        NPC<=NPC_J_1;
        J_Q<=0;
        xiaoc<=0;
    end
    else 
    begin
        

    if(IF_OP==6'b000000 && IF_FUNC==6'b001100)  //SYSCALL
    begin
        NPC<=0;
        J_Q<=0;
       xiaoc<=0;
    end
    else if(ID_OP==6'b010000&&ID_FUNC==6'b011000)  //ERET
    begin
        if(EX_OP==6'b010000 && Rs_ex==5'b00100)
        NPC<=B_ALU;
        else NPC<=ID_CPR_out_14;

        J_Q<=0;    
        xiaoc<=1;                              //
    end
    else if((ID_OP==6'b000100)&&(ID_busA==ID_busB))  //BEQ
    begin
     NPC<=ID_BNC;
     J_Q<=0;
     xiaoc<=0;
    end
     else if((ID_OP==6'b000101)&&(ID_busA!=ID_busB))//BNE
     begin
     NPC<=ID_BNC;
     J_Q<=0;
     xiaoc<=0;
     end
     else if((ID_OP==6'b000000)&&(ID_FUNC==6'b001000)&&(Rd_ex==Rs_id)) //JR  转发
     begin
     NPC<=Result_ex;
     J_Q<=0;
     xiaoc<=0;
     end
     else if((ID_OP==6'b000000)&&ID_FUNC==6'b001000)
     begin
     NPC<=ID_busA;   //JR
     J_Q=0;
     xiaoc<=0;
     end
     else if((ID_OP==6'b000000)&&(ID_FUNC==6'b001001)&&(Rd_ex==Rs_id)) //JALR  转发
     begin
     NPC<=Result_ex;
     J_Q<=0;
     xiaoc<=0;
     end
      else if((ID_OP==6'b000000)&&(ID_FUNC==6'b001001)) //JALR
     begin
     NPC<=ID_busA;
     J_Q<=0;
     xiaoc<=0;
     end
     else if((ID_OP==6'b000001)&&(rt==5'b00001)&&(ID_busA[31]!=1))  //bgez
     begin
     NPC<=ID_BNC;
     J_Q<=0;
     xiaoc<=0;
     end
     else if((ID_OP==6'b000111)&&((ID_busA[31]==0)&&(ID_busA!=0)))  // bgtz
     begin
     NPC<=ID_BNC;
     J_Q<=0;
     xiaoc<=0;
     end
     else if((ID_OP==6'b000110)&&((ID_busA[31]==1)|(ID_busA==0)))  //blez
     begin
     NPC<=ID_BNC;
     J_Q<=0;
     xiaoc<=0;
     end
     else if((ID_OP==6'b000001)&&(rt==5'b00000)&&((ID_busA[31]==1)&&(ID_busA!=0)))//bltz  小于0跳转
     begin
     NPC<=ID_BNC;
     J_Q<=0;
     xiaoc<=0;
     end
     else if((IF_OP==6'b000010))  //j
     begin
     NPC<=IF_PC+4;
     NPC_J<=IF_JNC;
     J_Q<=1;
     xiaoc<=0;
     end 
     else if((IF_OP==6'b000011))  //jal
     begin
        NPC<=IF_PC+4;
     NPC_J<=IF_JNC;   //有延迟槽的分支跳转指令
         J_Q<=1;
         xiaoc<=0;
     end
     else begin 
     NPC<=IF_PC+4; //其他
     J_Q<=0;
     xiaoc<=0;
     end

    end
     
end
initial 
     NPC_J<=0;
initial 
     J_Q<=0;
initial 
     xiaoc<=0;
endmodule


