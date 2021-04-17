module ByPass_M(      //add 7,1,3,+ nop +sw 7    
 input RegWr_wr, 
 input[31:0] busB_ex,
 input [4:0] rt_ex,    
 input [4:0] rd_wr,   
  input [5:0] op_ex,   
  input [31:0] Result_wr,
  output [31:0] busB_ex_end

);




assign busB_ex_end=(op_ex==6'b101011 && RegWr_wr==1 &&  rt_ex==rd_wr)? Result_wr:busB_ex  ;

endmodule












