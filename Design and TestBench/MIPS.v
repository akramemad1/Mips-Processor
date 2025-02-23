module mips (
input clk, reset);

wire memread,memwrite,regwrite;
wire zero_flag;
wire pcsrc;
wire [1:0] jump;
wire [1:0] branch; //0 = Off, 1 = beq, 2= bne
wire [1:0] regdst; //0= rt, 1= rd, 2=31
wire [1:0] memtoreg;
wire [1:0]alusrc;
wire [2:0]mode;
wire [3:0]aluop;
wire [3:0]alu_control_line;
wire [4:0] shift;
wire [31:0] instruction;
wire [31:0] pc_out;
wire [31:0]pc_plus_four = pc_out + 4;
wire [31:0]mux_upper_2_in1, mux_upper_2_in2;
wire [31:0] read_data1,read_data2;
wire [31:0] alu_result;
wire [31:0] memory_out;
wire [31:0] pc_in;
wire [31:0] alu_in_2;
wire [31:0] write_data;
wire [31:0] immediate_signed;
wire [31:0] immediate_zero_extend;

assign mux_upper_2_in1 = { {pc_plus_four[31:28]}, (instruction [25:0])<<2};

assign mux_upper_2_in2 = (pcsrc)? ( pc_plus_four +  ( ({ {16{instruction[15]}} ,{instruction[15:0]}})<<2 ) ): (pc_plus_four) ;

jump_mux jump_mux1(.*);
branch_control branch_control1 (.*);
sign_extention sign_extention1 (.*);
zero_extension zero_extension1 (.*);
alu_mux alu_mux1 (.*);
write_data_mux write_data_mux1 (.*);
pc pc1(.reset(reset),.pc_in(pc_in),.pc_out(pc_out),.clk(clk));

instruction_memory instruction_memory1(.pc_out(pc_out),.reset(reset),.instruction(instruction),.clk(clk));

register_file register_file1(.reset(reset),.regwrite(regwrite),.regdst(regdst), .instruction(instruction), .write_data(write_data),
                             .read_data1(read_data1),.read_data2(read_data2),.clk(clk));


alu alu1(.alu_in_1(read_data1), .alu_in_2(alu_in_2),.alu_control_line(alu_control_line),.alu_result(alu_result),.zero_flag(zero_flag),.shift(shift));

memory_file memory_file1 (.address(alu_result),.write_data(read_data2),.memread(memread),.memwrite(memwrite),.memory_out(memory_out),.reset(reset),.clk(clk),.mode(mode));

control control1(.*);
alu_control alu_control1(.*);
endmodule 