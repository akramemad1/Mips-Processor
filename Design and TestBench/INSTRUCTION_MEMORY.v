module instruction_memory (
input reset, clk,
input [31:0]pc_out,
output reg [31:0] instruction
);

reg [7:0] instruction_file [0:1023] ;
integer  i = 0;
always @(*) begin
    if (reset) begin
    for (i=0;i<1024;i=i+1) begin
    instruction_file [i] <= 32'b0 ;        
    end
    end else begin
    instruction  <= {instruction_file[pc_out],instruction_file[pc_out+1],instruction_file[pc_out+2],instruction_file[pc_out+3]};
end
end

endmodule
