module Loaduse(input MemRead_ex,input [4:0] Rs_id,input [4:0] Rt_id,input [4:0] Rt_ex,output reg loaduse);    //Rs,Rt

always @(*)
begin
    if(MemRead_ex==1'bx)
     loaduse<=0;
     else if((MemRead_ex==1 )&&((Rt_ex==Rs_id)|(Rt_ex==Rt_id)))
     loaduse<=1;
     else loaduse<=0;
end


initial
begin
    loaduse<=0;
end

endmodule


