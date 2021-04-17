module RFile_P(input clk,     //pc,op,func,rd

input [31:0] Result_next_wr,

input [31:0] Result_wr,
// input [31:0] instructions_id,
// input [31:0] instructions_wr,



input [2:0] sel_id,
input [4:0] rd_id,


input [5:0] op,           /////////op_wr
input [5:0] func,
input [4:0] rd,           /////////rd_wr
input [2:0] sel,     //sel_wr




input [31:0] pc_wr,

input [4:0] Ra,
input [4:0] Rb,
input [4:0] Rw,
input [31:0] Di,
input WE,
input WE_HI,
input WE_LO,
input WE_HI_LO,
input WE_CPR,
output [31:0] busA,
output [31:0] busB,
output [31:0] Lo_out,
output [31:0] Hi_out,
output [31:0] CPR_out,
output [31:0] CPR_out_14
);


reg [31:0] regist[31:0];
integer i,j;

initial    
begin
    i=0;
    for(i=0;i<32;i=i+1)
    regist[i]=0;
end

reg [31:0] Hi[0:0],Lo[0:0];
reg [31:0] CPR[255:0];

initial
begin
    Hi[0]=0;
    Lo[0]=0;
    for(j=0;j<256;j=j+1)
      CPR[j]=0;    
end


// wire [5:0] op;
// wire [5:0]func;
// wire [4:0] rd;

// assign op=op;
// assign func=func;
// assign rd=rd;

always@(posedge  clk)
       begin
           if(op==6'b000000 &&func==6'b001100)    //syscall
           begin
               CPR[14]<=Di;
               CPR[13][6:2]<=5'b01000;
               CPR[12][1:1]<=1;
           end
           else if(op==6'b010000 &&func==6'b011000)  //eret
           begin
               CPR[12][1:1]<=0;
           end
           else if(WE_HI)
           begin
               Hi[0]<=Di;
           end
           else if(WE_LO)
           begin
               Lo[0]<=Di;
           end
           else if(WE_HI_LO)
           begin
               Hi[0]<=Di;
               Lo[0]<=Result_next_wr;
           end
           else if(WE_CPR)
           begin
               CPR[(rd)*(sel+1)]<=Di;
           end
           else 
        if(WE)
           case(op)
           6'b100011://lw 
           begin
               regist[Rw]<=Di;
           end
           6'b100000:
           begin
               if(Result_wr[1:0]==2'b00)
               regist[Rw]<={{24{Di[7]}},Di[7:0]};
               if(Result_wr[1:0]==2'b01)
               regist[Rw]<={{24{Di[15]}},Di[15:8]};
               if(Result_wr[1:0]==2'b10)
               regist[Rw]<={{24{Di[23]}},Di[23:16]};
               if(Result_wr[1:0]==2'b11)
               regist[Rw]<={{24{Di[31]}},Di[31:24]};
           end
           6'b100100://lbu
           begin
               if(Result_wr[1:0]==2'b00)
               regist[Rw]<={{24'b0},Di[7:0]};
               if(Result_wr[1:0]==2'b01)
               regist[Rw]<={{24'b0},Di[15:8]};
               if(Result_wr[1:0]==2'b10)
               regist[Rw]<={{24'b0},Di[23:16]};
               if(Result_wr[1:0]==2'b11)
               regist[Rw]<={{24'b0},Di[31:24]};
           end
           
           
           6'b000011:regist[31]<=pc_wr+4+4;//jal          注意下！
           default://jalr
           begin
               if(func==6'b001001&&rd==5'b11111)
                regist[31]<=pc_wr+4+4;     
                else 
               regist[Rw]<=Di;    //lw  Rtype
          
           end
           endcase
    
       end

// wire [7:0] ww=(rd)*(sel+1);

 assign busA=regist[Ra];
  assign    busB=regist[Rb];
  assign   Lo_out=Lo[0];
  assign   Hi_out=Hi[0];
  assign   CPR_out=CPR[rd_id*(sel_id+1)];
  assign   CPR_out_14=CPR[14];
endmodule

