module branch_control (
 input [1:0]branch,
 input zero_flag,
 output reg pcsrc
);
always @(*) begin
    case (branch)
    2'b 01: pcsrc = (zero_flag) ? (1) : (0);          //beq
    2'b 10: pcsrc = (~zero_flag) ? (1): (0);          //bne
        default: pcsrc = 0; 
    endcase
end
    
endmodule
