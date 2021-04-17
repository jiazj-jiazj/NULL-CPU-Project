module ByPass_X(      //mflo 23 +mfhi30+ mtlo26                 func_ex
    input [5:0] func_ex,          
    input [31:0]  Result_ex,
    input [31:0] Result_me,
    
    input [31:0] Resultnextme,
    input [31:0] Result_wr,
    input [31:0] Rusultnextwr,


    input Hi_wr_me,
    input Hi_wr_wr,
    input Lo_wr_me,
    input Lo_wr_wr,
    input Hi_Lo_wr__me,
    input  Hi_Lo_wr_wr,

    output  reg  [31:0] Result_ex_new


);

 always @(*)
 begin
     if((Lo_wr_me|Hi_Lo_wr__me) && func_ex==6'b010010)               //MFLO,  LO->register
        Result_ex_new<=Resultnextme;                                 //alu resultnextme[31:0]
        else if((Hi_wr_wr|Hi_Lo_wr_wr) && func_ex==6'b010000 )        //MFHI  Hi->register
        Result_ex_new<=Result_wr;
        else Result_ex_new<=Result_ex;                            //  alu result
 end


endmodule









