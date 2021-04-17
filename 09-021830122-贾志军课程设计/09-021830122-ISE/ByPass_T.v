
module ByPass_T(                 //busA_id,Result_ex,Result_me,Do_me,busA_end   //busB_id,Result_ex,Result_me,Do_me,busB_end
    input [5:0] op,//op_ex        
    input [5:0] op_id,       
    input [5:0] op_me,       
    input [5:0] func_id,    

    input [4:0] Rw_me,
    input [4:0] Rw_ex,
    input [4:0] Rs_id,
    input [4:0] Rt_id,
    // input RegWr_ex,
 
    input RegWr_me,


    output reg [1:0] Ce_A,    //MUX ctrl
    output reg [1:0] Ce_B 
    
);


wire RegWr_ex;
assign RegWr_ex=(!op[5]&!op[4]&!op[3]&!op[2]&!op[1]&!op[0])|(!op[5]&!op[4]&op[3]&!op[2]&!op[1]&op[0])|(op[5]&!op[4]&!op[3]&!op[2]&op[1]&op[0])|(!op[5]&!op[4]&op[3]&op[2]&op[1]&op[0])|(!op[5]&!op[4]&op[3]&!op[2]&op[1]&!op[0])|(!op[5]&!op[4]&op[3]&!op[2]&op[1]&op[0])|(op[5]&!op[4]&!op[3]&!op[2]&!op[1]&!op[0])|(op[5]&!op[4]&!op[3]&op[2]&!op[1]&!op[0])|(!op[5]&!op[4]&op[3]&op[2]&!op[1]&!op[0])|(!op[5]&!op[4]&op[3]&op[2]&!op[1]&op[0])|(!op[5]&!op[4]&op[3]&op[2]&op[1]&!op[0])|(!op[5]&!op[4]&!op[3]&!op[2]&op[1]&op[0]);




always @(*)
begin
    if(RegWr_ex&&(op_id==6'b000100|op_id==6'b000101|op_id==6'b000001|op_id==6'b000111|(op_id==6'b000000 && func_id==6'b001001)|op_id==6'b000110|op_id==6'b000001)&&(Rs_id==Rw_ex)) //jalr BYPASS

    Ce_A<=2'b01;//Result_me
    else if((op_me==6'b100011)&&(op_id==6'b000100|op_id==6'b000101|op_id==6'b000001|op_id==6'b000111|op_id==6'b000110|op_id==6'b000001)&&(Rs_id==Rw_me))
    Ce_A<=2'b11;  //Do_me
    else if(RegWr_me&&(op_id==6'b000100|op_id==6'b000101|op_id==6'b000001|op_id==6'b000111|op_id==6'b000110|op_id==6'b000001)&&(Rs_id==Rw_me))
    Ce_A<=2'b10; //Result_ex
    else Ce_A<=2'b00;//busA_id

    if(RegWr_ex&&(op_id==6'b000100|op_id==6'b000101|op_id==6'b000001|op_id==6'b000111|op_id==6'b000110|op_id==6'b000001)&&(Rt_id==Rw_ex))
    Ce_B<=2'b01;//Result_ex
    else if(RegWr_me&&(op_id==6'b000100|op_id==6'b000101|op_id==6'b000001|op_id==6'b000111|op_id==6'b000110|op_id==6'b000001)&&(Rt_id==Rw_me))
    Ce_B<=2'b10;//Result_me
     else if((op_me==6'b100011)&&(op_id==6'b000100|op_id==6'b000101|op_id==6'b000001|op_id==6'b000111|op_id==6'b000110|op_id==6'b000001)&&(Rt_id==Rw_me))
    Ce_B<=2'b11;//Do_me
    else Ce_B<=2'b00;//busB_id
end
endmodule


