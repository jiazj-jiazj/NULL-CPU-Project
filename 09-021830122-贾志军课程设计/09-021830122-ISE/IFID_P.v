module IFID_P(input clk,
input [31:0] pc,
input [31:0] instructions,
input loaduse ,//load use 
input   xiaoc,  //id block


output reg [5:0] op_id,             
output reg [4:0] Rs_id,        
output reg [4:0] Rt_id,      
output reg [4:0] Rd_id,       
output reg [5:0] func_id,    
output reg [4:0] shamt_id,   
output reg [15:0] imm16_id,   
output reg [25:0] Target_id,  


output reg xiaoc_id,           
output reg [31:0] pc_id        




);



always @(negedge clk)
if(loaduse);



else
begin                        
   pc_id<=pc;
  
   xiaoc_id<=xiaoc;
    op_id<=instructions[31:26];           //////////
     Rs_id<=instructions[25:21];          /////////
     Rt_id<=instructions[20:16];        //////////
   Rd_id<=instructions[15:11];          ////////
     func_id<=instructions[5:0];      ///////////
      shamt_id<=instructions[10:6];    /////////
      imm16_id<=instructions[15:0];   //////////
      Target_id<=instructions[25:0];   ////////

end



endmodule



