module im_4k(
   addr,//Address in
   dout//Data Out
);
input [11:2] addr;
output [31:0] dout;
reg[31:0] im[1023:0];//1024*4=4096

initial begin
   $readmemh("code.txt",im);  //主存去指令
end

assign dout=im[addr];

endmodule
