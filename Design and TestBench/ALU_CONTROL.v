module alu_control (
input [1:0] aluop,
input [31:0]instruction,
output reg [3:0] alu_control_line
);
wire [5:0] alu_control_input;
assign alu_control_input = instruction [5:0];

always @(*) begin
    case (aluop)
    2'b 00: alu_control_line = 4'b 0010; //add (I_format) LW,SW
    2'b 01: alu_control_line = 4'b 0110; //sub (I_format) BEQ,BNE
    2'b 10: begin                        //for R_format
        case (alu_control_input)        
        //6'd 0 : alu_control_line = 4'b      //SLL_R_format
        //6'd 2 : alu_control_line = 4'b      //SLL_R_format
        //6'd 3 : alu_control_line = 4'b      //SLL_R_format
        6'd 32: alu_control_line = 4'b 0010; //add_R_format
        6'd 34: alu_control_line = 4'b 0110; //sub_R_format
        6'd 36: alu_control_line = 4'b 0000; //and_R_format
        6'd 37: alu_control_line = 4'b 0001; //Or_R_format
        6'd 38: alu_control_line = 4'b 1000; //Xor_R_format 
        6'd 39: alu_control_line = 4'b 1100; //NOR_R_format
        6'd 42: alu_control_line = 4'b 0111; //SLT_R_format
        endcase
     end
    endcase
end
endmodule
