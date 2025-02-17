module mips (
input clk, reset);

wire regdst, jump,branch,memread,memtoreg,memwrite,alusrc,regwrite;
wire zero_flag;
wire [1:0]aluop;
wire [3:0]alu_control_line;
wire [31:0] instruction;
wire [31:0] pc_out;
wire [31:0]pc_plus_four = pc_out + 4;
wire [31:0]mux_upper_2_in1, mux_upper_2_in2, mux_upper_1_in1,mux_upper_1_in2;
wire [31:0] read_data1,read_data2;
wire [31:0] alu_result;
wire [31:0] memory_out;
wire [31:0] pc_in;
wire [31:0] alu_in_2;
wire [31:0] write_data;

assign mux_upper_2_in1 = { {pc_plus_four[31:28]}, (instruction [25:0])<<2};

assign mux_upper_2_in2 = (branch&zero_flag)? ( pc_plus_four +  (({ {16{instruction[15]}} ,{instruction[15:0]}})<<2)  ): (pc_plus_four) ;

assign pc_in = (jump) ? (mux_upper_2_in1):( mux_upper_2_in2);

assign  alu_in_2 = (alusrc) ? ({ {16{instruction[15]}} ,{instruction[15:0]}}):(read_data2);
assign  write_data = (memtoreg)? (memory_out):(alu_result);

pc pc1(.reset(reset),.pc_in(pc_in),.pc_out(pc_out),.clk(clk));

instruction_memory instruction_memory1(.pc_out(pc_out),.reset(reset),.instruction(instruction),.clk(clk));

register_file register_file1(.reset(reset),.regwrite(regwrite),.regdst(regdst), .instruction(instruction), .write_data(write_data),
                             .read_data1(read_data1),.read_data2(read_data2),.clk(clk));


alu alu1(.alu_in_1(read_data1), .alu_in_2(alu_in_2),.alu_control_line(alu_control_line),.alu_result(alu_result),.zero_flag(zero_flag));

memory_file memory_file1 (.address(alu_result),.write_data(read_data2),.memread(memread),.memwrite(memwrite),.memory_out(memory_out),.reset(reset),.clk(clk));

control control1(.*);
alu_control alu_control1(.*);
endmodule 

module pc (
input reset, clk,
input  [31:0] pc_in,
output reg [31:0] pc_out
);

always @(posedge clk or posedge reset) begin
    if (reset) begin
        pc_out<=0;
    end else begin
     pc_out <= pc_in;
end
end
endmodule

module instruction_memory (
input reset, clk,
input [31:0]pc_out,
output reg [31:0] instruction
);

reg [7:0] instruction_file [0:1023] ;
integer  i = 0;
always @(posedge clk or posedge reset) begin
    if (reset) begin
    for (i=0;i<1024;i=i+1) begin
    instruction_file [i] <= 32'b0 ;        
    end
    end else begin
    instruction  <= {instruction_file[pc_out],instruction_file[pc_out+1],instruction_file[pc_out+2],instruction_file[pc_out+3]};
end
end

endmodule

module register_file (
input [31:0] instruction,
input [31:0]write_data,
input regwrite,reset,regdst, clk,
output  [31:0] read_data1,
output  [31:0] read_data2
);
wire [4:0]read_register1_rs, read_register2_rd, write_register_rt, write_register;
assign read_register1_rs = instruction [25:21];
assign read_register2_rd = instruction [20:16];
assign write_register_rt = instruction [15:11];

assign write_register = (regdst)? (write_register_rt): (read_register2_rd);

reg [31:0]register [0:31];
integer i=0;
assign    read_data1 = register [read_register1_rs];
assign    read_data2 = register [read_register2_rd];
    
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

module memory_file (
input [31:0] address,
input [31:0] write_data,
input memread, memwrite,clk,reset,
output [31:0] memory_out
);
integer i=0;
reg [31:0] memory [0:4095];
assign memory_out = (memread)? ( memory[address]) : (32'h x);

always @(posedge clk or posedge reset) begin
if (reset) begin
    for (i=0;i<4096;i=i+1) begin
    memory [i] <= 0;        
    end
end  else if(memwrite) begin
        memory[address] <= write_data;    
end
end


endmodule