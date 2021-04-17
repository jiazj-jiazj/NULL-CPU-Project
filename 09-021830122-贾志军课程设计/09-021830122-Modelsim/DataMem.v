module DataMem(input clk,
input sb_me,   //sb inst?
input MemWr_me,
input [31:0] Result_me,// Adr
input[31:0] busB_me, //data is stored

output [31:0] Do);//DataMem-outdata

reg [31:0] dm[1023:0];
integer i;
initial
begin
    for(i=0;i<1024;i=i+1)
    dm[i]=32'b0;
end



assign Do=dm[Result_me[11:2]];

always @(posedge clk)
if(MemWr_me)
    begin  
   if(sb_me) //sb  store byte
   begin
     if(Result_me[1:0]==2'b00)
     dm[Result_me[11:2]][7:0]<=busB_me[7:0];
     if(Result_me[1:0]==2'b01)
     dm[Result_me[11:2]][15:8]<=busB_me[7:0];
     if(Result_me[1:0]==2'b10)
     dm[Result_me[11:2]][23:16]<=busB_me[7:0];
     if(Result_me[1:0]==2'b11)
     dm[Result_me[11:2]][31:24]<=busB_me[7:0];
   end
   else
   dm[Result_me[11:2]]<=busB_me; //store  word
end


endmodule
