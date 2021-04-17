module test;
reg clk;
reg rst;
mips mips(clk,rst);

initial
begin
  rst=1;
  clk=1;
  #15;
  rst=0;
end
always 
begin
  #5;clk=~clk;
end
endmodule