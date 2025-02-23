module write_data_mux (
    input [1:0] memtoreg,
    input [31:0]memory_out, alu_result, pc_plus_four,
    output reg [31:0] write_data
);
    always @(*) begin
        case (memtoreg)
        2'b 00: write_data = alu_result;
        2'b 01: write_data = memory_out;
        2'b 10: write_data = pc_plus_four;
            default: write_data = alu_result; 
        endcase
    end
endmodule
