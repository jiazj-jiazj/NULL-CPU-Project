module MemWr(
    input clk,
input [31:0] pc_me,
    input xiaoc_me,
input loaduse_me,
// input [31:0] instructions_me,
input [5:0] op_me,           /////////op_wr_wr
input [5:0] func_me,
input [4:0] rd_me, 
// input MemtoReg_me,
input [31:0] Do_me,//DataMem -data stored
input [31:0] Result_me,//Adr/register stored
input [31:0] Result_next_me,
input [4:0] Rw_me,
  /////
input  CPR_wr_me,
input  Hi_wr_me,
input  Lo_wr_me,
input  Hi_Lo_wr_me,
input RegWr_me,


output reg loaduse_wr,

output reg [5:0] op_wr,           /////////op_wr_wr
output reg [5:0] func_wr,
output reg [4:0] rd_wr, 
output reg [31:0] Do_wr,
output reg [31:0] Result_wr,
output reg [4:0] Rw_wr,
output   MemtoReg_wr,
output  reg RegWr_wr,
output reg xiaoc_wr,
output reg [31:0] pc_wr,//
output  reg CPR_wr,
output  reg Hi_wr,
output  reg Lo_wr,
output  reg Hi_Lo_wr,
output reg [31:0] Result_next_wr
);
// wire [5:0] op_wr;
// wire RegWr_wr_1;
// assign op_wr=instructions_wr[31:26];
assign MemtoReg_wr=(op_wr[5]&!op_wr[4]&!op_wr[3]&!op_wr[2]&op_wr[1]&op_wr[0])|(op_wr[5]&!op_wr[4]&!op_wr[3]&!op_wr[2]&!op_wr[1]&!op_wr[0])|(op_wr[5]&!op_wr[4]&!op_wr[3]&op_wr[2]&!op_wr[1]&!op_wr[0]); 
// assign RegWr_wr_1=(!op_wr[5]&!op_wr[4]&!op_wr[3]&!op_wr[2]&!op_wr[1]&!op_wr[0])|(!op_wr[5]&!op_wr[4]&op_wr[3]&!op_wr[2]&!op_wr[1]&op_wr[0])|(op_wr[5]&!op_wr[4]&!op_wr[3]&!op_wr[2]&op_wr[1]&op_wr[0])|(!op_wr[5]&!op_wr[4]&op_wr[3]&op_wr[2]&op_wr[1]&op_wr[0])|(!op_wr[5]&!op_wr[4]&op_wr[3]&!op_wr[2]&op_wr[1]&!op_wr[0])|(!op_wr[5]&!op_wr[4]&op_wr[3]&!op_wr[2]&op_wr[1]&op_wr[0])|(op_wr[5]&!op_wr[4]&!op_wr[3]&!op_wr[2]&!op_wr[1]&!op_wr[0])|(op_wr[5]&!op_wr[4]&!op_wr[3]&op_wr[2]&!op_wr[1]&!op_wr[0])|(!op_wr[5]&!op_wr[4]&op_wr[3]&op_wr[2]&!op_wr[1]&!op_wr[0])|(!op_wr[5]&!op_wr[4]&op_wr[3]&op_wr[2]&!op_wr[1]&op_wr[0])|(!op_wr[5]&!op_wr[4]&op_wr[3]&op_wr[2]&op_wr[1]&!op_wr[0])|(!op_wr[5]&!op_wr[4]&!op_wr[3]&!op_wr[2]&op_wr[1]&op_wr[0]);

// assign RegWr_wr=((instructions_wr==32'h11111111)|(loaduse_wr==1)|(xiaoc_wr==1))?0:RegWr_wr_1;
//
// wire CPR_wr_1,Hi_wr_1,Lo_wr_1,Hi_Lo_wr_1;


initial
begin
   loaduse_wr<=0;    
end


// assign CPR_wr_1=(op_wr==6'b010000&&instructions_wr[25:21]==5'b00100&&instructions_wr[10:3]==8'b00000000)==1?1:0;
// assign Hi_wr_1=(op_wr==6'b000000&&instructions_wr[5:0]==6'b010001&&instructions_wr[20:6]==15'b000000000000000)==1?1:0;
// assign Lo_wr_1=(op_wr==6'b000000&&instructions_wr[5:0]==6'b010011&&instructions_wr[20:6]==15'b000000000000000)==1?1:0;
// assign Hi_Lo_wr_1=(op_wr==6'b000000&&instructions_wr[15:6]==10'b0000000000&&instructions_wr[5:0]==6'b011000)==1?1:0;

// assign CPR_wr=((instructions_wr==32'h11111111)|(loaduse_wr==1)|(xiaoc_wr==1))==1?0:CPR_wr_1;
// assign Hi_wr=((instructions_wr==32'h11111111)|(loaduse_wr==1)|(xiaoc_wr==1))==1?0:Hi_wr_1;
// assign Lo_wr=((instructions_wr==32'h11111111)|(loaduse_wr==1)|(xiaoc_wr==1))==1?0:Lo_wr_1;
// assign Hi_Lo_wr=((instructions_wr==32'h11111111)|(loaduse_wr==1)|(xiaoc_wr==1))==1?0:Hi_Lo_wr_1;
always @(negedge clk)
begin
    Result_next_wr<=Result_next_me;
    Do_wr<=Do_me;
    Result_wr<=Result_me;
    Rw_wr<=Rw_me;
    loaduse_wr<=loaduse_me;
    // instructions_wr<=instructions_me;
    xiaoc_wr<=xiaoc_me;
    pc_wr<=pc_me;

    // MemtoReg_wr<=MemtoReg_me;
    RegWr_wr<=RegWr_me;

    CPR_wr<=CPR_wr_me;
    Hi_wr<=Hi_wr_me;
    Lo_wr<=Lo_wr_me;
    Hi_Lo_wr<=Hi_Lo_wr_me;



    op_wr<=op_me ;         /////////op_wr_wr
    func_wr<=func_me;
    rd_wr<=rd_me;
end
endmodule




