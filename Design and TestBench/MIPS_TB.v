module mips_tb ();

reg clk;
reg reset;


mips mips1(.*);


initial begin
    clk=0;
    forever begin
        #10;
        clk =~clk;
    end
end
    
initial begin
    reset = 1;
    @(negedge clk);

    $display ("jump= %h", mips1.jump);
    $display ("pc_in= %h", mips1.pc_in);
    $display ("pc_out= %h", mips1.pc_out);
 //   $display ("instruction file = %p", mips1.instruction_memory1.instruction_file);
    $display ("register= %p", mips1.register_file1.register);
    $display ("memory file= %p", mips1.memory_file1.memory);
    reset = 0;
    //initialize S1,S2,S3
    mips1.register_file1.register[17]= 2;  //$s1
    mips1.register_file1.register[18]= 3;  //$s2
    mips1.register_file1.register[19]= 1;  //$s3
    //initialize instruction at instruction memory
//    mips1.instruction_memory1.instruction_file[0:3]= 32'b 00000010011100101000000000100000;
    mips1.instruction_memory1.instruction_file[0]= 8'b 00000010;
    mips1.instruction_memory1.instruction_file[1]= 8'b 00110010;
    mips1.instruction_memory1.instruction_file[2]= 8'b 10000000;
    mips1.instruction_memory1.instruction_file[3]= 8'b 00100000;
//sub $s4, $s0, $s3
    mips1.instruction_memory1.instruction_file[4]= 8'b 00000010;
    mips1.instruction_memory1.instruction_file[5]= 8'b 00010011;
    mips1.instruction_memory1.instruction_file[6]= 8'b 10100000;
    mips1.instruction_memory1.instruction_file[7]= 8'b 00100010;
//sw $s4, 32($s1)
    mips1.instruction_memory1.instruction_file[8]= 8'b 10101110;
    mips1.instruction_memory1.instruction_file[9]= 8'b 00110100;
    mips1.instruction_memory1.instruction_file[10]= 8'b 00000000;
    mips1.instruction_memory1.instruction_file[11]= 8'b 00100000;

//lw $t0, 32 ($s1)
    mips1.instruction_memory1.instruction_file[12]= 8'b 10001110;
    mips1.instruction_memory1.instruction_file[13]= 8'b 00101000;
    mips1.instruction_memory1.instruction_file[14]= 8'b 00000000;
    mips1.instruction_memory1.instruction_file[15]= 8'b 00100000;

//beq $s4, $t0, b1

    mips1.instruction_memory1.instruction_file[16]= 8'b 00010010;
    mips1.instruction_memory1.instruction_file[17]= 8'b 10001000;
    mips1.instruction_memory1.instruction_file[18]= 8'b 11111111;
    mips1.instruction_memory1.instruction_file[19]= 8'b 11111011;

// 




// all instruction excute at the same negative edge of the clk, but it stored at the next negative edge of the clock "it's positive edge but we check the simulation at each negative edge"


//    mips1.instruction_memory1.instruction_file[4:7]= 32'b 00000010 00010011 10100000 00100010;
    @(negedge clk);
    $display ("pc_in= %h", mips1.pc_in);
    $display ("pc_out= %h", mips1.pc1.pc_out);
//    $display ("instruction file = %p", mips1.instruction_memory1.instruction_file);
    $display ("instruction=0x %h", mips1.instruction_memory1.instruction);
    
    $display ("ALU_in1= %h", mips1.read_data1);
    $display ("ALU_in2= %h", mips1.alu_in_2);
    $display ("ALU_result= %h", mips1.alu_result);
    $display ("write_register= %d", mips1.register_file1.write_register);
    $display ("register= %p", mips1.register_file1.register);

    @(negedge clk);
    $display ("after storing the value");
    $display ("register= %p", mips1.register_file1.register);  
    $display ("instruction=0x %h", mips1.instruction_memory1.instruction);
    $display ("ALU_result_of_sub= %h", mips1.alu_result);
    @(negedge clk); 
    //storing value of sub, fetch sw instruction
    $display ("after storing the value of subtraction");
    $display ("register= %p", mips1.register_file1.register);
    $display ("memory address= %d",mips1.memory_file1.address);
    $display ("memory before store= %p",mips1.memory_file1.memory);
    @(negedge clk);
    // sw is done "notice the 4 value", fetching the lw instruction 
    $display ("memory after store= %p",mips1.memory_file1.memory);
    $display ("register before lw= %p", mips1.register_file1.register); 
    @(negedge clk);
    //lw instruction is done, we now fetch beq instruction
    $display ("register after lw= %p", mips1.register_file1.register);
    $display ("pc_in= %h", mips1.pc_in);
    $display ("pc_out= %h", mips1.pc1.pc_out);
    @(negedge clk);
    
    @(negedge clk);   
    $display ("Done");
$stop;
end

endmodule