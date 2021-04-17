module ctrl(op,func,Branch,Jump,RegDst,ALUSrc,MemtoReg,RegWr,MemWr,ExtOp,Rtype,ALUop,funcop,ALUctr);

input [5:0] op,func;
output Branch,Jump,RegDst,ALUSrc,MemtoReg,RegWr,MemWr,ExtOp,Rtype;
output[4:0] ALUop,funcop,ALUctr;


assign Branch=(!op[5]&!op[4]&!op[3]&op[2]&!op[1]&!op[0])|(!op[5]&!op[4]&!op[3]&op[2]&!op[1]&op[0])|(!op[5]&!op[4]&!op[3]&!op[2]&!op[1]&op[0])|(!op[5]&!op[4]&!op[3]&op[ 2]&op[1]&op[0])|(!op[5]&!op[4]&!op[3]&op[2]&op[1]&!op[0]);


assign Jump=(!op[5]&!op[4]&!op[3]&!op[2]&op[1]&!op[0])|(!op[5]&!op[4]&!op[3]&!op[2]&op[ 1]&op[0]); 
assign RegDst=!op[5]&!op[4]&!op[3]&!op[2]&!op[1]&!op[0]; 
assign ALUSrc=(!op[5]&!op[4]&op[3]&!op[2]&!op[1]&op[0])|(op[5]&!op[4]&!op[3]&!op[2]&op[1]&op[0])|(op[5]&!op[4]&op[3]&!op[2]&op[1]&op[0])|(!op[5]&!op[4]&op[3]&op[2]&op[1]&op[0])|(!op[5]&!op[4]&op[3]&!op[2]&op[1]&!op[0])|(!op[5]&!op[4]&op[3]&!op[2]&op[1]&op[0])|(op[5]&!op[4]&!op[3]&!op[2]&!op[1]&!op[0])|(op[5]&!op[4]&!op[3]&op[2]&!op[1]&!op[0])|(op[5]&!op[4]&op[3]&!op[2]&!op[1]&!op[0])|(!op[5]&!op[4]&op[3]&op[2]&!op[1]&!op[0])|(!op[5]&!op[4]&op[3]&op[2]&!op[1]&op[0])|(!op[5]&!op[4]&op[3]&op[2]&op[1]&!op[0]);
assign MemtoReg=(op[5]&!op[4]&!op[3]&!op[2]&op[1]&op[0])|(op[5]&!op[4]&!op[3]&!op[2]&!op[1]&!op[0])|(op[5]&!op[4]&!op[3]&op[2]&!op[1]&!op[0]); 
assign RegWr=((op==6'b000000 )&&(func!=6'b001000))|(!op[5]&!op[4]&op[3]&!op[2]&!op[1]&op[0])|(op[5]&!op[4]&!op[3]&!op[2]&op[1]&op[0])|(!op[5]&!op[4]&op[3]&op[2]&op[1]&op[0])|(!op[5]&!op[4]&op[3]&!op[2]&op[1]&!op[0])|(!op[5]&!op[4]&op[3]&!op[2]&op[1]&op[0])|(op[5]&!op[4]&!op[3]&!op[2]&!op[1]&!op[0])|(op[5]&!op[4]&!op[3]&op[2]&!op[1]&!op[0])|(!op[5]&!op[4]&op[3]&op[2]&!op[1]&!op[0])|(!op[5]&!op[4]&op[3]&op[2]&!op[1]&op[0])|(!op[5]&!op[4]&op[3]&op[2]&op[1]&!op[0])|(!op[5]&!op[4]&!op[3]&!op[2]&op[1]&op[0]);
assign MemWr=(op[5]&!op[4]&op[3]&!op[2]&op[1]&op[0])|(op[5]&!op[4]&op[3]&!op[2]&!op[1]& !op[0]); 
assign ExtOp=(op[5]&!op[4]&!op[3]&!op[2]&op[1]&op[0])|(op[5]&!op[4]&op[3]&!op[2]&op[1]& op[0])|(!op[5]&!op[4]&op[3]&!op[2]&!op[1]&op[0])|(!op[5]&!op[4]&op[3]&!op[2]&op[ 1]&!op[0])|(!op[5]&!op[4]&op[3]&!op[2]&op[1]&op[0]); 
assign Rtype=!op[5]&!op[4]&!op[3]&!op[2]&!op[1]&!op[0]; 
assign ALUop[0]=(!op[5]&!op[4]&!op[3]&op[2]&!op[1]&!op[0])|(!op[5]&!op[4]&!op[3]&op[2]& !op[1]&op[0])|(!op[5]&!op[4]&op[3]&!op[2]&op[1]&op[0])|(!op[5]&!op[4]&op[3]&op[2 ]&!op[1]&!op[0])|(!op[5]&!op[4]&op[3]&op[2]&!op[1]&op[0]); 
assign ALUop[1]=(!op[5]&!op[4]&op[3]&!op[2]&op[1]&!op[0])|(!op[5]&!op[4]&op[3]&op[2]&!op[1]&!op[0])|(!op[5]&!op[4]&op[3]&op[2]&op[1]&!op[0])|(!op[5]&!op[4]&!op[3]&!op[2]&op[1]&op[0]);
assign ALUop[2]=(!op[5]&!op[4]&op[3]&op[2]&!op[1]&op[0])|(!op[5]&!op[4]&op[3]&op[2]&op[1]&!op[0]);
assign ALUop[3]=(!op[5]&!op[4]&op[3]&!op[2]&op[1]&op[0])|(!op[5]&!op[4]&!op[3]&!op[2]&op[1]&op[0]);
assign ALUop[4]=(!op[5]&!op[4]&op[3]&op[2]&op[1]&op[0]); 
assign funcop[0]=(func[5]&!func[4]&!func[3]&!func[2]&func[1]&func[0])|(func[5]&!func[4]&!func[3]&func[2]&!func[1]&!func[0])|(func[5]&!func[4]&!func[3]&func[2]&!func[1]&func[0])|(!func[5]&!func[4]&!func[3]&!func[2]&!func[1]&!func[0])|(func[5]&!func[4]&func[3]&!func[2]&func[1]&func[0])|(!func[5]&!func[4]&func[3]&!func[2]&!func[1]&!func[0])|(!func[5]&!func[4]&!func[3]&!func[2]&func[1]&func[0])|(!func[5]&!func[4]&!func[3]&func[2]&func[1]&!func[0]);
assign funcop[1]=(func[5]&!func[4]&func[3]&!func[2]&func[1]&!func[0])|(func[5]&!func[4] &!func[3]&func[2]&!func[1]&!func[0])|(func[5]&!func[4]&!func[3]&func[2]&func[1]& !func[0])|(!func[5]&!func[4]&!func[3]&!func[2]&!func[1]&!func[0])|(!func[5]&!func[4]&!func[3]&func[2]&func[1]&func[0])|(!func[5]&!func[4]&!func[3]&func[2]&func[ 1]&!func[0])|(!func[5]&!func[4]&func[3]&!func[2]&!func[1]&func[0])|(!func[5]&!func[4]&func[3]&!func[2]&!func[1]&!func[0]); 
assign funcop[2]=(func[5]&!func[4]&!func[3]&func[2]&func[1]&func[0])|(func[5]&!func[4]&!func[3]&func[2]&!func[1]&func[0])|(func[5]&!func[4]&!func[3]&func[2]&func[1]&!func[0])|(!func[5]&!func[4]&!func[3]&!func[2]&!func[1]&!func[0])|(!func[5]&!func[4]&!func[3]&func[2]&!func[1]&!func[0])|(!func[5]&!func[4]&!func[3]&!func[2]&func[1]&func[0])|(!func[5]&!func[4]&!func[3]&func[2]&func[1]&func[0])|(!func[5]&!func[4]&!func[3]&func[2]&func[1]&!func[0]);
assign funcop[3]=(!func[5]&!func[4]&!func[3]&!func[2]&func[1]&!func[0])|(func[5]&!func[4]&func[3]&!func[2]&func[1]&func[0])|(!func[5]&!func[4]&func[3]&!func[2]&!func[1]&func[0])|(!func[5]&!func[4]&func[3]&!func[2]&!func[1]&!func[0])|(!func[5]&!func[4]&!func[3]&func[2]&!func[1]&!func[0])|(!func[5]&!func[4]&!func[3]&!func[2]&func[1]&func[0])|(!func[5]&!func[4]&!func[3]&func[2]&func[1]&!func[0])|(!func[5]&!func[4]&!func[3]&func[2]&func[1]&func[0]);
assign funcop[4]=0;
assign ALUctr=(Rtype)?funcop:ALUop;
endmodule
