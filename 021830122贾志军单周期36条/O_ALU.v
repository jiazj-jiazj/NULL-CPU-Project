
module  O_ALU(ALUctr,busA,tempBus,shamt,Result,Zero,overflow

);
input[4:0] ALUctr;
input [31:0] busA,tempBus;
input [4:0] shamt;
output reg[31:0] Result;
output Zero;
output reg overflow;
assign Zero=(Result==0);

// reg FuHao;

always @(busA or tempBus or ALUctr)
begin
        case(ALUctr)
         //R Type
   5'b00000 : 
   begin Result <= busA + tempBus; // addu 
   overflow<=0;
   end
   5'b00001 : begin 
       Result <= busA - tempBus; // subu
       overflow<=0;
   end
   5'b00010 : begin 
       Result <= busA < tempBus;// slt
       overflow<=0;
   end
   5'b00011 : begin Result <= busA & tempBus; 
   overflow<=0;
   end// and
   5'b00100 : begin 
       Result <= ~(busA | tempBus);
       overflow<=0;
   end // nor
   5'b00101 : begin Result <= busA | tempBus; // or
   overflow<=0;
   end
   5'b00110 : begin Result <= busA ^ tempBus; // xor 
   overflow<=0;
   end
   5'b00111 : begin Result <= tempBus << shamt; //sll
   overflow<=0;
   end 
   5'b01000 : begin Result <= tempBus >> shamt;// srl 
   overflow<=0;
   end
   5'b01001 : begin Result <= (busA <tempBus)?1:0; // sltu return 0 
   overflow<=0;
   end
   //5'b01010 : ; jalr:there's no pc
   //5'b01011 : ; jr:there's no pc
   5'b01100 : begin Result <= tempBus << busA;  //sllv 
   overflow<=0;
   end
   5'b01101 : begin Result <= ($signed(tempBus)) >>> shamt; //sra 
   overflow<=0;
   end
   5'b01110 : begin Result <=($signed(tempBus)) >>> busA; //srav
   overflow<=0;
   end
   5'b01111 : begin Result <= tempBus >> busA;  //srlv
   overflow<=0;
   end
   5'b10000 : begin Result <= (tempBus << 5'b10000); //lui
   overflow<=0;
   end
  

  //    5'b10001: begin             //busA,tempBus 传补码
//        {FuHao,Result}=busA+tempBus;
//        overflow<=FuHao==Result[31]?1:0;
//    end
        endcase
end




endmodule

