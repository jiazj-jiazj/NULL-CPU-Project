module IDEX_P(input clk,
input [31:0]pc_id,
input xiaoc_id,
input loaduse, 


input [31:0]busA_id,
input [31:0] busB_id,
                        //
input [31:0] Lo_out_id,
input [31:0] Hi_out_id,
input [31:0] CPR_out_id,
input [5:0]  op_id,
input [5:0] func_id,
input [4:0] Rs_id,
input [4:0] Rt_id,
input [4:0] Rd_id,
input [4:0] shamt_id,
input [15:0] imm16_id,

output reg [5:0]  op,
output reg [5:0] func,




output [4:0] ALUctr_ex,
output reg [31:0] busA_ex,
output reg [31:0] busB_ex,
output reg loaduse_ex,
output reg [4:0] shamt_ex,

output  reg  [4:0] Rs_ex,
output reg  [4:0] Rt_ex,
output  reg [4:0] Rd_ex,
output ExtOp_ex,
output RegDst_ex,
output reg MemRead_ex ,
output reg [15:0]imm16_ex,
output ALUSrc_ex,

output reg xiaoc_ex,
output reg [31:0]pc_ex, //
output reg [31:0] Lo_out_ex,
output reg [31:0] Hi_out_ex,
output reg [31:0] CPR_out_ex
);



wire [4:0] funcop,ALUop;
wire Rtype;


assign funcop[0]=(!func[5]&func[4]&func[3]&!func[2]&!func[1]&!func[0])|(func[5]&!func[4]&!func[3]&!func[2]&func[1]&func[0])|(func[5]&!func[4]&!func[3]&func[2]&!func[1]&!func[0])|(func[5]&!func[4]&!func[3]&func[2]&!func[1]&func[0])|(!func[5]&!func[4]&!func[3]&!func[2]&!func[1]&!func[0])|(func[5]&!func[4]&func[3]&!func[2]&func[1]&func[0])|(!func[5]&!func[4]&func[3]&!func[2]&!func[1]&!func[0])|(!func[5]&!func[4]&!func[3]&!func[2]&func[1]&func[0])|(!func[5]&!func[4]&!func[3]&func[2]&func[1]&!func[0]);
assign funcop[1]=(func[5]&!func[4]&func[3]&!func[2]&func[1]&!func[0])|(func[5]&!func[4] &!func[3]&func[2]&!func[1]&!func[0])|(func[5]&!func[4]&!func[3]&func[2]&func[1]& !func[0])|(!func[5]&!func[4]&!func[3]&!func[2]&!func[1]&!func[0])|(!func[5]&!func[4]&!func[3]&func[2]&func[1]&func[0])|(!func[5]&!func[4]&!func[3]&func[2]&func[ 1]&!func[0])|(!func[5]&!func[4]&func[3]&!func[2]&!func[1]&func[0])|(!func[5]&!func[4]&func[3]&!func[2]&!func[1]&!func[0]); 
assign funcop[2]=(func[5]&!func[4]&!func[3]&func[2]&func[1]&func[0])|(func[5]&!func[4]&!func[3]&func[2]&!func[1]&func[0])|(func[5]&!func[4]&!func[3]&func[2]&func[1]&!func[0])|(!func[5]&!func[4]&!func[3]&!func[2]&!func[1]&!func[0])|(!func[5]&!func[4]&!func[3]&func[2]&!func[1]&!func[0])|(!func[5]&!func[4]&!func[3]&!func[2]&func[1]&func[0])|(!func[5]&!func[4]&!func[3]&func[2]&func[1]&func[0])|(!func[5]&!func[4]&!func[3]&func[2]&func[1]&!func[0]);
assign funcop[3]=(!func[5]&!func[4]&!func[3]&!func[2]&func[1]&!func[0])|(func[5]&!func[4]&func[3]&!func[2]&func[1]&func[0])|(!func[5]&!func[4]&func[3]&!func[2]&!func[1]&func[0])|(!func[5]&!func[4]&func[3]&!func[2]&!func[1]&!func[0])|(!func[5]&!func[4]&!func[3]&func[2]&!func[1]&!func[0])|(!func[5]&!func[4]&!func[3]&!func[2]&func[1]&func[0])|(!func[5]&!func[4]&!func[3]&func[2]&func[1]&!func[0])|(!func[5]&!func[4]&!func[3]&func[2]&func[1]&func[0]);
assign funcop[4]=!func[5]&func[4]&func[3]&!func[2]&!func[1]&!func[0];//

assign Rtype=!op[5]&!op[4]&!op[3]&!op[2]&!op[1]&!op[0];   
assign ALUop[0]=(!op[5]&!op[4]&!op[3]&op[2]&!op[1]&!op[0])|(!op[5]&!op[4]&!op[3]&op[2]& !op[1]&op[0])|(!op[5]&!op[4]&op[3]&!op[2]&op[1]&op[0])|(!op[5]&!op[4]&op[3]&op[2 ]&!op[1]&!op[0])|(!op[5]&!op[4]&op[3]&op[2]&!op[1]&op[0]); 
assign ALUop[1]=(!op[5]&!op[4]&op[3]&!op[2]&op[1]&!op[0])|(!op[5]&!op[4]&op[3]&op[2]&!op[1]&!op[0])|(!op[5]&!op[4]&op[3]&op[2]&op[1]&!op[0])|(!op[5]&!op[4]&!op[3]&!op[2]&op[1]&op[0]);
assign ALUop[2]=(!op[5]&!op[4]&op[3]&op[2]&!op[1]&op[0])|(!op[5]&!op[4]&op[3]&op[2]&op[1]&!op[0]);
assign ALUop[3]=(!op[5]&!op[4]&op[3]&!op[2]&op[1]&op[0])|(!op[5]&!op[4]&!op[3]&!op[2]&op[1]&op[0]);
assign ALUop[4]=(!op[5]&!op[4]&op[3]&op[2]&op[1]&op[0]); 

assign ExtOp_ex=(op[5]&!op[4]&!op[3]&!op[2]&op[1]&op[0])|(op[5]&!op[4]&op[3]&!op[2]&op[1]& op[0])|(!op[5]&!op[4]&op[3]&!op[2]&!op[1]&op[0])|(!op[5]&!op[4]&op[3]&!op[2]&op[ 1]&!op[0])|(!op[5]&!op[4]&op[3]&!op[2]&op[1]&op[0]); 
assign RegDst_ex=(!op[5]&!op[4]&!op[3]&!op[2]&!op[1]&!op[0]==1)?0:1; 

assign ALUctr_ex=Rtype?funcop:ALUop;


assign ALUSrc_ex=(!op[5]&!op[4]&op[3]&!op[2]&!op[1]&op[0])|(op[5]&!op[4]&!op[3]&!op[2]&op[1]&op[0])|(op[5]&!op[4]&op[3]&!op[2]&op[1]&op[0])|(!op[5]&!op[4]&op[3]&op[2]&op[1]&op[0])|(!op[5]&!op[4]&op[3]&!op[2]&op[1]&!op[0])|(!op[5]&!op[4]&op[3]&!op[2]&op[1]&op[0])|(op[5]&!op[4]&!op[3]&!op[2]&!op[1]&!op[0])|(op[5]&!op[4]&!op[3]&op[2]&!op[1]&!op[0])|(op[5]&!op[4]&op[3]&!op[2]&!op[1]&!op[0])|(!op[5]&!op[4]&op[3]&op[2]&!op[1]&!op[0])|(!op[5]&!op[4]&op[3]&op[2]&!op[1]&op[0])|(!op[5]&!op[4]&op[3]&op[2]&op[1]&!op[0]);

always @(negedge clk)
begin
  loaduse_ex<= loaduse;
  // instructions_ex<=instructions_id;
  busA_ex<=busA_id;
  busB_ex<=busB_id;
  xiaoc_ex<=xiaoc_id;
  pc_ex<=pc_id;
                                      //
  Hi_out_ex<=Hi_out_id;
  Lo_out_ex<=Lo_out_id;
  CPR_out_ex<=CPR_out_id;
  Rd_ex<=Rd_id;
  Rs_ex<=Rs_id;
  Rt_ex<=Rt_id;
  shamt_ex<=shamt_id;
  imm16_ex<=imm16_id;
  op<=op_id;
  func<=func_id;

end
initial
loaduse_ex=0;

always @(*)
 MemRead_ex=(loaduse_ex==1)?0:(op==6'b100011);  

initial
begin
 MemRead_ex<=0;  
end



endmodule
