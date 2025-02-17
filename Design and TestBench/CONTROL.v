module control (
    input [31:0] instruction, reset,
    output reg regdst, jump,branch,memread,memtoreg,memwrite,alusrc,regwrite,
    output reg [1:0] aluop
);
    wire [5:0] opcode;
    assign opcode = instruction [31:26];
    always @(*) begin
    if (reset) begin
        jump =0; regdst =0;
        alusrc = 0;
        memtoreg=0;
        regwrite=0;
        memread=0;
        memwrite=0;
        branch=0;
        aluop = 2'b 00;
    end
    else begin
    case (opcode)
    6'b 000000: begin       //r_format
        regdst =1;
        alusrc = 0;
        memtoreg=0;
        regwrite=1;
        memread=0;
        memwrite=0;
        branch=0;
        aluop = 2'b 10;
        jump=0;
    end
    6'b 100011: begin       //lw
        regdst =0;
        alusrc = 1;
        memtoreg=1;
        regwrite=1;
        memread=1;
        memwrite=0;
        branch=0;
        aluop = 2'b 00;
        jump=0;
    end
    6'b 101011 :begin        //sw
        regdst =0;
        alusrc = 1;
        memtoreg=0;
        regwrite=0;
        memread=0;
        memwrite=1;
        branch=0;
        aluop = 2'b 00;
        jump=0;
    end

    6'b 000100: begin       //beq
        regdst =0;
        alusrc = 0;
        memtoreg=0;
        regwrite=0;
        memread=0;
        memwrite=0;
        branch=1;
        aluop = 2'b 01;
        jump=0;
        
    end

        default: begin
        regdst =0;
        alusrc = 0;
        memtoreg=0;
        regwrite=0;
        memread=0;
        memwrite=0;
        branch=0;
        aluop = 2'b 00;
        jump=0;
        end
    endcase
end
end
endmodule