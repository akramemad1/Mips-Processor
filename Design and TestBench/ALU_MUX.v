module alu_mux (
input [1:0] alusrc,
input [31:0] read_data2, immediate_signed, immediate_zero_extend,
output reg[31:0] alu_in_2
);
    
   always @(*) begin
    case (alusrc)
        2'b 00: alu_in_2 = read_data2;
        2'b 01: alu_in_2 = immediate_signed;
        2'b 10: alu_in_2 = immediate_zero_extend;
        default: alu_in_2 = 0;
    endcase    
   end 
endmodule
