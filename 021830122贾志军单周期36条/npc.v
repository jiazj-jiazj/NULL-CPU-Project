module npc(
    pc,
    NPC,
    Target,
    jump,
    Branch,
    zero,
    imm16,
    op,
    func,
    busA,
    rt
);
input [31:0] pc,busA;
input [25:0] Target;
input jump,Branch,zero;
input[5:0] op,func;
input[4:0] rt;
input [15:0] imm16;
output [31:0] NPC;

wire [31:0]pc,busA;
reg [31:0] NPC;
wire [29:0] imm30,func30;
wire[25:0] Target;
wire jump,Branch,zero;
wire [5:0] op,func;
wire [4:0] rt;
wire[15:0] imm16;

wire[31:0] imm32,func32;
signext #(16,30) signext(imm16,imm30);

assign imm32={imm30,2'b00};

wire[31:0] N_NPC=pc+4;
wire[31:0] B_NPC=N_NPC-4+imm32;
wire[31:0] J_NPC={pc[31:28],Target[25:0],2'b00};
wire[31:0] BGEZ_NPC=pc+func32;

always@(*)
begin
    case(op)
    6'b000100:NPC=(zero&Branch)?B_NPC:N_NPC;  //
    6'b000101:NPC=(!zero&Branch)?B_NPC:N_NPC;
    6'b000110:NPC=(Branch&&(busA==0||busA[31]==1))?B_NPC:N_NPC;
    6'b000111:NPC=(Branch&&busA!=0&&busA[31]==0)?B_NPC:N_NPC;
    6'b000010:NPC=(jump)?J_NPC:N_NPC;
    6'b000011:NPC=(jump)?J_NPC:N_NPC;//jal
    6'B000001:
    begin
        if(Branch&&rt==0)                          //bgez  和  
          NPC=(busA[31]==1)?B_NPC:N_NPC;
          else 
          if(Branch&&rt==1)
          NPC=(busA==0|busA[31]==0)?B_NPC:N_NPC;
           
    end
    default:
    begin
        if(op==6'b000000&&((func==6'b001000)|(func==6'b001001)))
        begin
            NPC=busA;
        end
        else
         NPC=N_NPC;
    end
  
    endcase
end
endmodule
