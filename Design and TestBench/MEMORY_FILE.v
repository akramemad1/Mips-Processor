module memory_file (                    //We want it to be Byte Addressing
input [31:0] address,
input [31:0] write_data,
input memread, memwrite,clk,reset,
input [2:0] mode,
output reg [31:0] memory_out
);
integer i=0;
reg [7:0] memory [0:4095];

always @(*) begin
 if (memread) begin
    case (mode)
        3'b 000: memory_out = {memory[address],memory[address+1],memory[address+2],memory[address+3] };//Word
        3'b 001: memory_out = {{16 {memory[address][7]}} , memory[address] , memory[address+1] };                           //Half Word
        3'b 010: memory_out = {{16'b 0 , memory[address]} , memory[address+1] };                         //HWU 
        3'b 011: memory_out = {{24{memory[address][7]}},memory[address]};                                 //B
        3'b 100: memory_out = {24'b 0, memory[address]};                                                //BU
        default: memory_out = {memory[address],memory[address+1],memory[address+2],memory[address+3] };
    endcase
    
 end
 else begin
    memory_out = 32'h x;
 end
end


always @(posedge clk or posedge reset) begin
if (reset) begin
    for (i=0;i<4096;i=i+1) begin
    memory [i] <= 0;        
    end
end  else if(memwrite) begin
    case (mode)
    3'b 000:begin
         memory[address] <= write_data[31:24];
         memory[address+1]<= write_data[23:16];
         memory[address+2]<= write_data[15:8];
         memory[address+3]<= write_data[7:0];
    end
    3'b 001:begin
         memory[address] <= write_data[15:8];
         memory[address+1]<= write_data[7:0];
    end
    3'b 011:begin
         memory[address] <= write_data[7:0];    
    end
        default:begin
         memory[address] <= write_data[31:24];
         memory[address+1]<= write_data[23:16];
         memory[address+2]<= write_data[15:8];
         memory[address+3]<= write_data[7:0];

        end
    endcase
end
end


endmodule