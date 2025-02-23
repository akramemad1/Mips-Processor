module zero_extension (
 input [31:0] instruction,
 output [31:0]immediate_zero_extend
);
 assign immediate_zero_extend = { {16'b 0 } ,{instruction[15:0]}};    
endmodule
