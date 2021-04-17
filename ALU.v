module alu(ALUctr,busA,tempBus,shamt,Result,Zero); 
 
 input [4:0] ALUctr; 
 input [31:0] busA,tempBus;  //busB is after selected  
 input [4:0]shamt;  
 output reg [31:0] Result; 
 output Zero; 
 
 always@(busA or tempBus or ALUctr) begin
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
   //5'b01010 : ; jalr:there's no pc
   //5'b01011 : ; jr:there's no pc
   5'b01100 : Result <= tempBus << busA;  //sllv 
   5'b01101 : Result <= ($signed(tempBus)) >>> shamt; //sra 
   5'b01110 : Result <= ($signed(tempBus)) >>> busA; //srav
   5'b01111 : Result <= tempBus >> busA;  //slrv
   5'b10000 : Result <= tempBus << 16; //lui
   // beq bne
   // sw
   endcase
 end

 assign Zero = (Result==0);

endmodule 
