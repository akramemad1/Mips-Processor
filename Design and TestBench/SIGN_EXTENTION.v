module sign_extention (
 input [31:0] instruction,
 output [31:0]immediate_signed
);
  assign  immediate_signed = { {16{instruction[15]}} ,{instruction[15:0]} } ;
endmodule
