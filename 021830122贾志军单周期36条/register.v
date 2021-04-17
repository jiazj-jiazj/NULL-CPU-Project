module  register(addr,RegWr,Rw,Ra,Rb,busW,clk,busA,busB,op,func,rd,PC);
     input clk,RegWr;
     input[31:0] addr;
     input [4:0] Rw,Ra,Rb,rd;
     input [5:0] op,func;
     input [31:0] busW,PC;
     output[31:0] busA,busB;

     reg[31:0]  regist[31:0];  //寄存器

integer  i;
      initial      //                注意！！！！！
      begin
    
    
       i=0;
      for(i=0;i<32;i=i+1)
      regist[i]=0;
 
      end
     
       always@(posedge clk)
       begin
           if(RegWr)
           case(op)
           6'b100011://lw 
           begin
               regist[Rw]<=busW;
           end
           6'b100000:
           begin
               if(addr[1:0]==2'b00)
               regist[Rw]<={{24{busW[7]}},busW[7:0]};
               if(addr[1:0]==2'b01)
               regist[Rw]<={{24{busW[15]}},busW[15:8]};
               if(addr[1:0]==2'b10)
               regist[Rw]<={{24{busW[23]}},busW[23:16]};
               if(addr[1:0]==2'b11)
               regist[Rw]<={{24{busW[31]}},busW[31:24]};
           end
           6'b100100://lbu
           begin
               if(addr[1:0]==2'b00)
               regist[Rw]<={{24'b0},busW[7:0]};
               if(addr[1:0]==2'b01)
               regist[Rw]<={{24'b0},busW[15:8]};
               if(addr[1:0]==2'b10)
               regist[Rw]<={{24'b0},busW[23:16]};
               if(addr[1:0]==2'b11)
               regist[Rw]<={{24'b0},busW[31:24]};
           end
           
           
           6'b000011:regist[31]<=PC+4;//jal          注意下！
           default://jalr
           begin
               if(func==6'b001001&&rd==5'b11111)
                regist[31]<=PC+4;     
                else 
               regist[Rw]<=busW;    //lw  Rtype
          

               

           end
           endcase
       end
       assign busA=(Ra!=0)?regist[Ra]:0;
       assign busB=(Rb!=0)?regist[Rb]:0;
endmodule
