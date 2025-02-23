module alu (
input [31:0] alu_in_1,
input [31:0] alu_in_2,
input [3:0] alu_control_line,
input [4:0] shift,
output reg [31:0] alu_result,
output reg zero_flag
);
always @(*) begin
case (alu_control_line)
    4'b 0000 : alu_result = alu_in_1 & alu_in_2;                        //and Operation
    4'b 0001 : alu_result = alu_in_1 | alu_in_2;                        //Or  Operation
    4'b 0010 : alu_result = alu_in_1 + alu_in_2;                        //Add Operation
    4'b 0011 : alu_result = alu_in_2 << shift;                  //SLL Operation
    4'b 0100 : alu_result = alu_in_2 >> shift;                  //SRL Operation
    4'b 0101 : alu_result = alu_in_2 >>> shift;                      //SRA Operation
    4'b 0110 : alu_result = alu_in_1 - alu_in_2;                        //Sub Operation
    4'b 0111 : alu_result = (alu_in_1 < alu_in_2)? (32'h 01):(0);       //SLT Operation
    4'b 1000 : alu_result = alu_in_1 ^ alu_in_2;                        //Xor Operation
  //  4'b 1001 : alu_result = alu_in_2 << shift;      //LUI Operation
    4'b 1100 : alu_result = ~(alu_in_1 | alu_in_2);                     //Nor Operation
    default: alu_result =0;
endcase
zero_flag = (alu_result ==0);
end
endmodule