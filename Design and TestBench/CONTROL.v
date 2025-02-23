module control (
    input [31:0] instruction,
    input reset,
    output reg memread,memwrite,regwrite,
    output reg [1:0] branch, jump, regdst, memtoreg,
    output reg [1:0] alusrc,
    output reg [2:0] mode, // 0: Word, 1: Half Word, 2: HWU, 3:B, 4:BU
    output reg [3:0] aluop
);
    wire [5:0] opcode;
    assign opcode = instruction [31:26];
    always @(*) begin
    if (reset) begin
        jump        =   2'b 00;
        regdst      =   2'b 00;
        alusrc      =   2'b 00;
        memtoreg    =   2'b 00;
        regwrite    =        0;
        memread     =        0;
        memwrite    =        0;
        branch      =   2'b 00;
        aluop       = 4'b 0000;
        mode        =  3'b 000;
    end
    else begin
    case (opcode)
    6'b 000000: begin       //r_format
        regdst      =   2'b 01;
        alusrc      =   2'b 00;
        memtoreg    =   2'b 00;
    //    regwrite    =        1;
        memread     =        0;
        memwrite    =        0;
        branch      =   2'b 00;
        aluop       = 4'b 0010;
    //    jump        =        0;
        if(instruction[5:0] == 6'd 8) begin
            jump = 2'b 10;                  //JR
            regwrite    =        0;
        end else begin
            jump = 2'b 00;
            regwrite    =        1;
        end
        mode        =  3'b 000;
    end
    6'b 100011: begin       //lw OP Code: 35
        regdst      =   2'b 00;
        alusrc      =   2'b 01;
        memtoreg    =   2'b 01;
        regwrite    =        1;
        memread     =        1;
        memwrite    =        0;
        branch      =   2'b 00;
        aluop       = 4'b 0000;
        jump        =   2'b 00;
        mode        =  3'b 000;
    end
    6'b 101011 :begin        //sw Op Code: 43
        regdst      =   2'b 00;
        alusrc      =   2'b 01;
        memtoreg    =   2'b 00;
        regwrite    =        0;
        memread     =        0;
        memwrite    =        1;
        branch      =   2'b 00;
        aluop       = 4'b 0000;
        jump        =   2'b 00;
        mode        =  3'b 000;
    end

    6'b 000100: begin       //beq Op Code: 4
        regdst      =   2'b 00;
        alusrc      =   2'b 00;
        memtoreg    =   2'b 00;
        regwrite    =        0;
        memread     =        0;
        memwrite    =        0;
        branch      =   2'b 01;
        aluop       = 4'b 0001;
        jump        =   2'b 00;
        mode        =  3'b 000;
    end

    6'b 001000: begin       //Addi Op Code: 8
        regdst      =   2'b 00;
        alusrc      =   2'b 01;
        memtoreg    =   2'b 00;
        regwrite    =        1;
        memread     =        0; //Do not Care
        memwrite    =        0;
        branch      =   2'b 00;
        aluop       = 4'b 0000;
        jump        =   2'b 00;
        mode        =  3'b 000;
    end
    6'b 001100: begin       //Andi Op Code: 12
        regdst      =      2'b 00;
        alusrc      =      2'b 10;              //Zero Extend
        memtoreg    =      2'b 00;
        regwrite    =           1;
        memread     =           0;
        memwrite    =           0;
        branch      =      2'b 00;
        aluop       =    4'b 0011;
        jump        =      2'b 00;
        mode        =     3'b 000;
    end
    6'b 001111: begin       //LUI OP Code: 15
        regdst      =      2'b 00;
        alusrc      =      2'b 01;      // 01 or 10 "zero or sign extend it doesn't matter"
        memtoreg    =      2'b 00;
        regwrite    =           1;
        memread     =           0;
        memwrite    =           0;
        branch      =      2'b 00;
        aluop       =    4'b 0100;
        jump        =      2'b 00;
        mode        =     3'b 000;
    end
    6'b 001010: begin       //SLTI OP Code: 10
        regdst      =      2'b 00;
        alusrc      =      2'b 01;
        memtoreg    =      2'b 00;
        regwrite    =           1;
        memread     =           0;
        memwrite    =           0;
        branch      =      2'b 00;
        aluop       =    4'b 0101;
        jump        =      2'b 00;
        mode        =     3'b 000;
    end
    6'b 001110: begin       //XORI Op Code: 14
        regdst      =      2'b 00;
        alusrc      =      2'b 10;
        memtoreg    =      2'b 00;
        regwrite    =           1;
        memread     =           0;
        memwrite    =           0;
        branch      =      2'b 00;
        aluop       =    4'b 0110;
        jump        =      2'b 00;
        mode        =     3'b 000;
    end
    6'b 001101: begin       //ORI Op Code: 13
        regdst      =      2'b 00;
        alusrc      =      2'b 10;
        memtoreg    =      2'b 00;
        regwrite    =           1;
        memread     =           0;
        memwrite    =           0;
        branch      =      2'b 00;
        aluop       =    4'b 0111;
        jump        =      2'b 00;
        mode        =     3'b 000;
    end
    6'b 100000: begin       //lb Op Code: 32
        regdst      =      2'b 00;
        alusrc      =      2'b 01;
        memtoreg    =      2'b 01;
        regwrite    =           1;
        memread     =           1;
        memwrite    =           0;
        branch      =      2'b 00;
        aluop       =    4'b 0000;
        jump        =      2'b 00;
        mode        =     3'b 011;
    
    end
    6'b 100001: begin       //lh Op Code: 33
        regdst      =      2'b 00;
        alusrc      =      2'b 01;
        memtoreg    =      2'b 01;
        regwrite    =           1;
        memread     =           1;
        memwrite    =           0;
        branch      =      2'b 00;
        aluop       =    4'b 0000;
        jump        =      2'b 00;
        mode        =     3'b 001;
    
    end
    6'b 100100: begin       //lbu Op Code: 36
        regdst      =      2'b 00;
        alusrc      =      2'b 01;
        memtoreg    =      2'b 01;
        regwrite    =           1;
        memread     =           1;
        memwrite    =           0;
        branch      =      2'b 00;
        aluop       =    4'b 0000;
        jump        =      2'b 00;
        mode        =     3'b 100;
    
    end
    6'b 100101: begin       //lhu Op Code: 37
        regdst      =      2'b 00;
        alusrc      =      2'b 01;
        memtoreg    =      2'b 01;
        regwrite    =           1;
        memread     =           1;
        memwrite    =           0;
        branch      =      2'b 00;
        aluop       =    4'b 0000;
        jump        =      2'b 00;
        mode        =     3'b 010;
    
    end
    6'b 101000: begin       //sb Op Code: 40
        regdst      =      2'b 00;
        alusrc      =      2'b 01;
        memtoreg    =      2'b 00;
        regwrite    =           0;
        memread     =           0;
        memwrite    =           1;
        branch      =      2'b 00;
        aluop       =    4'b 0000;
        jump        =      2'b 00;
        mode        =     3'b 011;
    
    end
    6'b 101001: begin       //sh Op Code: 41
        regdst      =      2'b 00;
        alusrc      =      2'b 01;
        memtoreg    =      2'b 00;
        regwrite    =           0;
        memread     =           0;
        memwrite    =           1;
        branch      =      2'b 00;
        aluop       =    4'b 0000;
        jump        =      2'b 00;
        mode        =     3'b 001;
    
    end
    6'b 000101: begin       //bne Op Code: 5
        regdst      =   2'b 00;
        alusrc      =   2'b 00;
        memtoreg    =   2'b 00;
        regwrite    =        0;
        memread     =        0;
        memwrite    =        0;
        branch      =   2'b 10;
        aluop       = 4'b 0001;
        jump        =   2'b 00;
        mode        =  3'b 000;
    end
    6'b 000011: begin       //jal Op Code: 3
        regdst      =   2'b 10; //$ra 31
        alusrc      =   2'b 00; //Don't care
        memtoreg    =   2'b 10; //pc+4 into ra
        regwrite    =        1;
        memread     =        0;
        memwrite    =        0;
        branch      =   2'b 00; //Don't care
        aluop       = 4'b 0000; //Don't care
        jump        =   2'b 01;
        mode        =  3'b 000; //don't care 

    end
    6'b 000010: begin   //j Op Code: 2
        regdst      =   2'b 00; //don't care
        alusrc      =   2'b 00; //Don't care
        memtoreg    =   2'b 00; //don't care
        regwrite    =        0;
        memread     =        0;
        memwrite    =        0;
        branch      =   2'b 00; //Don't care
        aluop       = 4'b 0000; //Don't care
        jump        =   2'b 01;
        mode        =  3'b 000; //don't care 

    end


        default: begin
        regdst      =      2'b 00;
        alusrc      =      2'b 00;
        memtoreg    =      2'b 00;
        regwrite    =           0;
        memread     =           0;
        memwrite    =           0;
        branch      =      2'b 00;
        aluop       =    4'b 0000;
        jump        =      2'b 00;
        mode        =     3'b 000;
        end
    endcase
end
end
endmodule