module ExMem(input clk,       //  Rs_me,func_me,
//转发 sb，sw
input RegWr_me_j,
input [4:0] Rw_me_j,
input [4:0] Rt_ex,
input [31:0] Result_me_j, 
input [31:0] pc_ex,
input xiaoc_ex,
input zero_ex,
input [31:0] Result_ex,
input [31:0]  Result_next_ex,
input [31:0] busB_ex,
input loaduse_ex, //
input [4:0] Rw_ex,
input [5:0] op_ex, //////////////////
input [5:0] func_ex,  ///////////////////
input [4:0] Rs_ex, ///////////////////
input [4:0] Rd_ex, ////////////

// input [15:0] imm16_ex, ////////////
// input [25:0] Target_ex,//////////////

output reg loaduse_me,/////////////
output reg [5:0] op,  ///////////////op_me
output reg [5:0] func_me,   /////////////
output  reg [4:0] Rs_me,            ////////////
output reg [4:0] Rt_me,              ///////////
output reg [4:0] Rd_me,             ///////////
// output reg [15:0] imm16_me,         ///////////
// output reg [25:0] Target_me,       ///////////
output reg zero_me,
output reg [31:0] Result_me,  //Adr
output reg [31:0] busB_me,   //Datain
output reg [4:0] Rw_me,
output wire RegWr_me,
output wire sb_me,//控制信号 out
output wire MemWr_me ,//注意消除
output reg xiaoc_me,
output reg [31:0] pc_me,
output reg [31:0]  Result_next_me,    ///////
output  CPR_wr_me,
output  Hi_wr_me,
output  Lo_wr_me,
output  Hi_Lo_wr_me
);

////

assign CPR_wr_1=(op==6'b010000&&Rs_me==5'b00100)==1?1:0;
assign Hi_wr_1=(op==6'b000000&&func_me==6'b010001)==1?1:0;
assign Lo_wr_1=(op==6'b000000&&func_me==6'b010011)==1?1:0;
assign Hi_Lo_wr_1=(op==6'b000000&&func_me==6'b011000)==1?1:0;

assign CPR_wr_me=((loaduse_me==1)|(xiaoc_me==1))==1?0:CPR_wr_1;
assign Hi_wr_me=((loaduse_me==1)|(xiaoc_me==1))==1?0:Hi_wr_1;
assign Lo_wr_me=((loaduse_me==1)|(xiaoc_me==1))==1?0:Lo_wr_1;
assign Hi_Lo_wr_me=((loaduse_me==1)|(xiaoc_me==1))==1?0:Hi_Lo_wr_1;



wire RegWr_me_1,MemWr_me_1;

                              //并不是R型指令都要写寄存器了
assign RegWr_me_1=((op==6'b010000)&&(func_me[5:0]!=6'b011000))|((op==6'b000000)&&(func_me[5:0]!=6'b011000)&&(func_me[5:0]!=6'b010011)&&(func_me[5:0]!=6'b010001)&&(func_me[5:0]!=6'b001000))|(!op[5]&!op[4]&op[3]&!op[2]&!op[1]&op[0])|(op[5]&!op[4]&!op[3]&!op[2]&op[1]&op[0])|(!op[5]&!op[4]&op[3]&op[2]&op[1]&op[0])|(!op[5]&!op[4]&op[3]&!op[2]&op[1]&!op[0])|(!op[5]&!op[4]&op[3]&!op[2]&op[1]&op[0])|(op[5]&!op[4]&!op[3]&!op[2]&!op[1]&!op[0])|(op[5]&!op[4]&!op[3]&op[2]&!op[1]&!op[0])|(!op[5]&!op[4]&op[3]&op[2]&!op[1]&!op[0])|(!op[5]&!op[4]&op[3]&op[2]&!op[1]&op[0])|(!op[5]&!op[4]&op[3]&op[2]&op[1]&!op[0])|(!op[5]&!op[4]&!op[3]&!op[2]&op[1]&op[0]);
assign RegWr_me=((loaduse_me==1)|(xiaoc_me==1))?0:RegWr_me_1;
// assign RegWr_me=RegWr_me_1;


assign sb_me=(op==6'b101000);
assign MemWr_me_1=(op[5]&!op[4]&op[3]&!op[2]&op[1]&op[0])|(op[5]&!op[4]&op[3]&!op[2]&!op[1]& !op[0]); 
assign MemWr_me=((loaduse_me==1)|(xiaoc_me==1))?0:MemWr_me_1; 

always @(negedge clk)
begin

  Result_next_me<=Result_next_ex;
  // instructions_me<=instructions_ex;
  op<=op_ex;
  zero_me<=zero_ex;
  Result_me<=Result_ex;
  
   func_me<=func_ex;
   Rs_me<=Rs_ex;
   Rt_me<=Rt_ex;
   Rw_me<=Rw_ex;
   Rd_me<=Rd_ex;
  //  imm16_me<=imm16_ex;
  //  Target_me<=Target_ex;
   


   
  loaduse_me<=loaduse_ex;
  xiaoc_me<=xiaoc_ex;
  pc_me<=pc_ex;

  //转发 sw，sb的Di，上次指令的result
  if((op_ex==6'b101000|op_ex==6'b101011)&&RegWr_me_j&&(Rw_me_j==Rt_ex))
   busB_me<=Result_me_j;   //错误
   else 
   busB_me<=busB_ex;
end

endmodule




// module ExMem(input clk,       //
// //转发 sb，sw
// input RegWr_me_j,
// input [4:0] Rw_me_j,
// input [4:0] Rt_ex,
// input [31:0] Result_me_j, 


// input [31:0] pc_ex,
// input xiaoc_ex,

// input zero_ex,
// input [31:0] Result_ex,

// input [31:0]  Result_next_ex,


// input [31:0] busB_ex,
// input loaduse_ex, //
// input [4:0] Rw_ex,
// input [31:0] instructions_ex,

// output reg loaduse_me,//
// output reg [31:0] instructions_me,
// output reg zero_me,
// output reg [31:0] Result_me,  //Adr
// output reg [31:0] busB_me,   //Datain
// output reg [4:0] Rw_me,
// output wire RegWr_me,
// output wire sb_me,//控制信号 out
// output wire MemWr_me ,//注意消除
// output reg xiaoc_me,
// output reg [31:0] pc_me,

// output reg [31:0]  Result_next_me,    ///////

// output  CPR_wr_me,
// output  Hi_wr_me,
// output  Lo_wr_me,
// output  Hi_Lo_wr_me


// );

// ////

// assign CPR_wr_1=(instructions_me[31:26]==6'b010000&&instructions_me[25:21]==5'b00100&&instructions_me[10:3]==8'b00000000)==1?1:0;
// assign Hi_wr_1=(instructions_me[31:26]==6'b000000&&instructions_me[5:0]==6'b010001&&instructions_me[20:6]==15'b000000000000000)==1?1:0;
// assign Lo_wr_1=(instructions_me[31:26]==6'b000000&&instructions_me[5:0]==6'b010011&&instructions_me[20:6]==15'b000000000000000)==1?1:0;
// assign Hi_Lo_wr_1=(instructions_me[31:26]==6'b000000&&instructions_me[15:6]==10'b0000000000&&instructions_me[5:0]==6'b011000)==1?1:0;

// assign CPR_wr_me=((instructions_me==32'h11111111)|(loaduse_me==1)|(xiaoc_me==1))==1?0:CPR_wr_1;
// assign Hi_wr_me=((instructions_me==32'h11111111)|(loaduse_me==1)|(xiaoc_me==1))==1?0:Hi_wr_1;
// assign Lo_wr_me=((instructions_me==32'h11111111)|(loaduse_me==1)|(xiaoc_me==1))==1?0:Lo_wr_1;
// assign Hi_Lo_wr_me=((instructions_me==32'h11111111)|(loaduse_me==1)|(xiaoc_me==1))==1?0:Hi_Lo_wr_1;





// wire [5:0] op_ex;
// assign op_ex=instructions_ex[31:26];

// wire [5:0] op;
// wire RegWr_me_1,MemWr_me_1;
// assign op=instructions_me[31:26];
//                               //并不是R型指令都要写寄存器了
// assign RegWr_me_1=((op==6'b010000)&&(instructions_me[5:0]!=6'b011000))|((op==6'b000000)&&(instructions_me[5:0]!=6'b011000)&&(instructions_me[5:0]!=6'b010011)&&(instructions_me[5:0]!=6'b010001)&&(instructions_me[5:0]!=6'b001000))|(!op[5]&!op[4]&op[3]&!op[2]&!op[1]&op[0])|(op[5]&!op[4]&!op[3]&!op[2]&op[1]&op[0])|(!op[5]&!op[4]&op[3]&op[2]&op[1]&op[0])|(!op[5]&!op[4]&op[3]&!op[2]&op[1]&!op[0])|(!op[5]&!op[4]&op[3]&!op[2]&op[1]&op[0])|(op[5]&!op[4]&!op[3]&!op[2]&!op[1]&!op[0])|(op[5]&!op[4]&!op[3]&op[2]&!op[1]&!op[0])|(!op[5]&!op[4]&op[3]&op[2]&!op[1]&!op[0])|(!op[5]&!op[4]&op[3]&op[2]&!op[1]&op[0])|(!op[5]&!op[4]&op[3]&op[2]&op[1]&!op[0])|(!op[5]&!op[4]&!op[3]&!op[2]&op[1]&op[0]);
// assign RegWr_me=((loaduse_me==1)|(xiaoc_me==1))?0:RegWr_me_1;
// // assign RegWr_me=RegWr_me_1;


// assign sb_me=(op==6'b101000);
// assign MemWr_me_1=(op[5]&!op[4]&op[3]&!op[2]&op[1]&op[0])|(op[5]&!op[4]&op[3]&!op[2]&!op[1]& !op[0]); 
// assign MemWr_me=((loaduse_me==1)|(instructions_me==32'h11111111)|(xiaoc_me==1))?0:MemWr_me_1; 

// always @(negedge clk)
// begin

//   Result_next_me<=Result_next_ex;
//   instructions_me<=instructions_ex;
//   zero_me<=zero_ex;
//   Result_me<=Result_ex;
 
//   Rw_me<=Rw_ex;
//   loaduse_me<=loaduse_ex;
//   xiaoc_me<=xiaoc_ex;
//   pc_me<=pc_ex;

//   //转发 sw，sb的Di，上次指令的result
//   if((op_ex==6'b101000|op_ex==6'b101011)&&RegWr_me_j&&(Rw_me_j==Rt_ex))
//    busB_me<=Result_me_j;   //错误
//    else 
//    busB_me<=busB_ex;
// end

// endmodule

