
module IM_P(input [31:0] Adr,output  [31:0] instructions);

 reg [31:0] im[1023:0];   //IM_P

initial begin
   $readmemb("codep.txt",im);  //inst loaded
end

assign instructions=im[Adr[11:2]];  



endmodule


