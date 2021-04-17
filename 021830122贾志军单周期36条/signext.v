module signext #(parameter WIDTH=16 ,BIGWIDTH=32)(input [WIDTH-1:0]x,output[BIGWIDTH-1:0]y);
assign y={{BIGWIDTH-WIDTH{x[WIDTH-1]}},x};

endmodule
