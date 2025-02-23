module jump_mux (
    input [31:0] mux_upper_2_in1, mux_upper_2_in2, read_data1,
    input [1:0] jump,
    output reg [31:0] pc_in
);
always @(*) begin
    case (jump)
    2'b 00: pc_in = mux_upper_2_in2;
    2'b 01: pc_in = mux_upper_2_in1;
    2'b 10: pc_in = read_data1;
        default: pc_in = mux_upper_2_in2;
    endcase
end    
endmodule
