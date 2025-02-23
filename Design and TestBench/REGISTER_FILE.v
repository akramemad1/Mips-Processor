module register_file (
input [31:0] instruction,
input [31:0]write_data,
input regwrite,reset,clk,
input [1:0] regdst,
output  [31:0] read_data1,
output  [31:0] read_data2
);

reg [4:0] write_register;
reg [31:0]register [0:31];
integer i=0;
assign    read_data1 = register [instruction [25:21]];
assign    read_data2 = register [instruction [20:16]];
    
always @(*) begin
    case (regdst)
    2'b 00: write_register = instruction [20:16];
    2'b 01: write_register = instruction [15:11];
    2'b 10: write_register = 5'd 31;
        default: write_register = instruction [20:16];
    endcase
end

always @(posedge clk or posedge reset) begin
    if (reset) begin
        for (i=0;i<32;i=i+1) begin
            register[i] = 0;
            end
    end else if (regwrite) begin
        register[write_register] <= write_data;
    end
end


endmodule
