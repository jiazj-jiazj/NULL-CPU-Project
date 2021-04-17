module  ALU_P(op_ex,func_ex,Rs_ex,pc_ex,busA_ex,busB_ex,Lo_out_ex,Hi_out_ex,CPR_out_ex,ALUctr,busA,tempBus,shamt,Result,Zero,Result_next   //
);
// input [31:0] Ex_inst;
input [5:0] op_ex,func_ex;
input [4:0] Rs_ex;
input [31:0] busA_ex;
input [31:0] busB_ex;
input [31:0] Lo_out_ex;
input [31:0] Hi_out_ex;
input [31:0] CPR_out_ex;
input [31:0] pc_ex;


input[4:0] ALUctr;   
input [31:0] busA,tempBus;
input [4:0] shamt;
output reg[31:0] Result;
output Zero;
output reg [31:0] Result_next;

assign Zero=(Result==0);

wire   [63:0] Alto;
assign  Alto=($signed(busA))*($signed(tempBus));      //MULT ->HI,LO



always @(*)
begin
        if (op_ex==6'b000000 &&func_ex==6'b010010)  //Lo->GPR
         begin
                Result<=Lo_out_ex;
        end
        else if (op_ex==6'b000000 &&func_ex==6'b010000)   //Hi->GPR
        begin
                Result<=Hi_out_ex;
        end
        else  if (op_ex==6'b010000 && Rs_ex==5'b00000 )    //CPR->GPR
        begin
                Result<=CPR_out_ex;
        end 
        else if(op_ex==6'b000000 &&func_ex==6'b001100)    // SYSACLL pc->CPR
         begin
                 Result<=pc_ex;
         end 
         else if(op_ex==6'b010000 && Rs_ex==5'b00100 )  //  MTCO GPR->CPR
         begin
             Result<=tempBus;     
         end  
         else if(op_ex==6'b000000 && (func_ex==6'b010011 |func_ex==6'b010001))   //GPR->Lo,GPR->Hi
         begin
                 Result<=busA;
         end
 
        else
        begin
        case(ALUctr)
         //R Type
   5'b00000 : Result <= busA + tempBus; // addu 
   5'b00001 : Result <= busA - tempBus; // subu
   5'b00010 : Result <= busA < tempBus;// slt
   5'b00011 : Result <= busA & tempBus; // and
   5'b00100 : Result <= ~(busA | tempBus); // nor
   5'b00101 : Result <= busA | tempBus; // or
   5'b00110 : Result <= busA ^ tempBus; // xor 
   5'b00111 : Result <= tempBus << shamt; //sll 
   5'b01000 : Result <= tempBus >> shamt;// srl 
   5'b01001 : Result <= (busA <tempBus)?1:0; // sltu return 0 
   5'b10001 :begin
       
      Result<=Alto[63:32];   //Hi_out
      Result_next<=Alto[31:0];//Lo_out

   end 
   //5'b01010 : ; jalr:there's no pc
   //5'b01011 : ; jr:there's no pc
   5'b01100 : Result <= tempBus << busA;  //sllv 
   5'b01101 : Result <= ($signed(tempBus)) >>> shamt; //sra 
   5'b01110 : Result <=($signed(tempBus)) >>> busA; //srav
   5'b01111 : Result <= tempBus >> busA;  //srlv
   5'b10000 : Result <= (tempBus << 5'b10000); //lui
        
        endcase
        end
end



endmodule


