module alu_control (
input [3:0] aluop,
input [31:0]instruction,
output reg [3:0] alu_control_line,
output reg [4:0] shift
);
wire [5:0] alu_control_input;
wire [4:0] shamt;
assign alu_control_input = instruction [5:0];
assign shamt = instruction [10:6];
always @(*) begin
    case (aluop)
    4'b 0000: alu_control_line = 4'b 0010;                        //add (I_format) LW,SW
    4'b 0001: alu_control_line = 4'b 0110;                        //sub (I_format) BEQ,BNE
    4'b 0010: begin                                               //for R_format
        case (alu_control_input)                        
        6'd 0 : begin alu_control_line = 4'b 0011; shift = shamt;   end                 //SLL_R_format
        6'd 2 : begin alu_control_line = 4'b 0100; shift = shamt;   end                 //SRL_R_format
        6'd 3 : begin alu_control_line = 4'b 0101; shift = shamt;   end                 //SRA_R_format
        6'd 32: alu_control_line = 4'b 0010;                    //add_R_format
        6'd 34: alu_control_line = 4'b 0110;                    //sub_R_format
        6'd 36: alu_control_line = 4'b 0000;                    //and_R_format
        6'd 37: alu_control_line = 4'b 0001;                    //Or_R_format
        6'd 38: alu_control_line = 4'b 1000;                    //Xor_R_format 
        6'd 39: alu_control_line = 4'b 1100;                    //NOR_R_format
        6'd 42: alu_control_line = 4'b 0111;                    //SLT_R_format
        endcase
     end
    4'b 0011: alu_control_line = 4'b 0000;                      //ANDI
    4'b 0100:begin                                              //LUI
        alu_control_line = 4'b 0011; shift = 5'd 16;
    end 
    4'b 0101: alu_control_line = 4'b 0111;                     //SLTI
    4'b 0110: alu_control_line = 4'b 1000;                     //XORI
    4'b 0111: alu_control_line = 4'b 0001;                     //ORI
    default: shift = 0;
    endcase
end
endmodule
