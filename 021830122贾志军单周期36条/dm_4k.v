module  dm_4k( //
    addr,// Address In
    din,//Data in
    we,//Write Enable
    // clock
    op,
    clk,
    dout//Data Out
);
input  [31:0] addr;
input wire we,clk;
input  [31:0] din;
input [5:0] op;
output  [31:0] dout;
reg [31:0] dm [1023:0];//1024*4=4096



integer i;
initial 
begin
  for(i=0;i<1024;i=i+1)
  dm[i]=32'b0;
  end

assign dout=dm[addr[11:2]];     
 
always @ (posedge clk)
begin
  if(we)    
 begin  
   if(op==6'b101000) //sb  主存存字节
   begin
     if(addr[1:0]==2'b00)
     dm[addr[11:2]][7:0]<=din[7:0];
     if(addr[1:0]==2'b01)
     dm[addr[11:2]][15:8]<=din[7:0];
     if(addr[1:0]==2'b10)
     dm[addr[11:2]][23:16]<=din[7:0];
     if(addr[1:0]==2'b11)
     dm[addr[11:2]][31:24]<=din[7:0];
   end
   else
   dm[addr[11:2]]<=din;
 end
    

   
end

endmodule
