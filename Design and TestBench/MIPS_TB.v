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

    $display ("pc_in= %h", mips1.pc_in);
    $display ("pc_out= %h", mips1.pc_out);
    $display ("register= %p", mips1.register_file1.register);
    $display ("memory file= %p", mips1.memory_file1.memory);
    reset = 0;
/*    // Test 1
    initialize S1,S2,S3
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

 /*
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
*/

/*
 DDCA Test Bench
*/

/*
    // addi $2, $0, 5 # initialize $2 5 0 20020005                 
    mips1.instruction_memory1.instruction_file[0] = 8'h 20;
    mips1.instruction_memory1.instruction_file[1] = 8'h 02;
    mips1.instruction_memory1.instruction_file[2] = 8'h 00;
    mips1.instruction_memory1.instruction_file[3] = 8'h 05;
    //addi $3, $0, 12 # initialize $3 12 4 2003000c        
    mips1.instruction_memory1.instruction_file[4] = 8'h 20;
    mips1.instruction_memory1.instruction_file[5] = 8'h 03;
    mips1.instruction_memory1.instruction_file[6] = 8'h 00;
    mips1.instruction_memory1.instruction_file[7] = 8'h 0c;
    //addi $7, $3, 9 # initialize $7 3 8 2067fff7 
    mips1.instruction_memory1.instruction_file[8] = 8'h 20;
    mips1.instruction_memory1.instruction_file[9] = 8'h 67;
    mips1.instruction_memory1.instruction_file[10] = 8'h ff;
    mips1.instruction_memory1.instruction_file[11] = 8'h f7;
    // or   $4, $7, $2 # $4 3 or 5 7 c 00e22025
    mips1.instruction_memory1.instruction_file[12] = 8'h 00;
    mips1.instruction_memory1.instruction_file[13] = 8'h e2;
    mips1.instruction_memory1.instruction_file[14] = 8'h 20;
    mips1.instruction_memory1.instruction_file[15] = 8'h 25;
    //and  $5, $3, $4 # $5 12 and 7 4 10 00642824
    mips1.instruction_memory1.instruction_file[16] = 8'h 00;
    mips1.instruction_memory1.instruction_file[17] = 8'h 64;
    mips1.instruction_memory1.instruction_file[18] = 8'h 28;
    mips1.instruction_memory1.instruction_file[19] = 8'h 24;
    //add  $5, $5, $4 # $5 4 7 11 14 00a42820
    mips1.instruction_memory1.instruction_file[20] = 8'h 00;
    mips1.instruction_memory1.instruction_file[21] = 8'h a4;
    mips1.instruction_memory1.instruction_file[22] = 8'h 28;
    mips1.instruction_memory1.instruction_file[23] = 8'h 20;
    //beq  $5, $7, end # shouldn’t be taken 18 10a7000a
    mips1.instruction_memory1.instruction_file[24] = 8'h 10;
    mips1.instruction_memory1.instruction_file[25] = 8'h a7;
    mips1.instruction_memory1.instruction_file[26] = 8'h 00;
    mips1.instruction_memory1.instruction_file[27] = 8'h 0a;
    //slt  $4, $3, $4 # $4 12 7 0 1c 0064202a
    mips1.instruction_memory1.instruction_file[28] = 8'h 00;
    mips1.instruction_memory1.instruction_file[29] = 8'h 64;
    mips1.instruction_memory1.instruction_file[30] = 8'h 20;
    mips1.instruction_memory1.instruction_file[31] = 8'h 2a;
    //beq  $4, $0, around # should be taken 20 10800001
    mips1.instruction_memory1.instruction_file[32] = 8'h 10;
    mips1.instruction_memory1.instruction_file[33] = 8'h 80;
    mips1.instruction_memory1.instruction_file[34] = 8'h 00;
    mips1.instruction_memory1.instruction_file[35] = 8'h 01;
    //addi $5, $0, 0 # shouldn’t happen 24 20050000
    mips1.instruction_memory1.instruction_file[36] = 8'h 20;
    mips1.instruction_memory1.instruction_file[37] = 8'h 05;
    mips1.instruction_memory1.instruction_file[38] = 8'h 00;
    mips1.instruction_memory1.instruction_file[39] = 8'h 00;
    // slt  $4, $7, $2 # $4 3 5 1 28 00e2202a
    mips1.instruction_memory1.instruction_file[40] = 8'h 00;
    mips1.instruction_memory1.instruction_file[41] = 8'h e2;
    mips1.instruction_memory1.instruction_file[42] = 8'h 20;
    mips1.instruction_memory1.instruction_file[43] = 8'h 2a;
    //add  $7, $4, $5 # $7 1 11 12 2c 00853820
    mips1.instruction_memory1.instruction_file[44] = 8'h 00;
    mips1.instruction_memory1.instruction_file[45] = 8'h 85;
    mips1.instruction_memory1.instruction_file[46] = 8'h 38;
    mips1.instruction_memory1.instruction_file[47] = 8'h 20;
    // sub  $7, $7, $2 # $7 12 5 7 30 00e23822
    mips1.instruction_memory1.instruction_file[48] = 8'h 00;
    mips1.instruction_memory1.instruction_file[49] = 8'h e2;
    mips1.instruction_memory1.instruction_file[50] = 8'h 38;
    mips1.instruction_memory1.instruction_file[51] = 8'h 22;
    // sw   $7, 68($3) # [80] 7 34 ac670044
    mips1.instruction_memory1.instruction_file[52] = 8'h ac;
    mips1.instruction_memory1.instruction_file[53] = 8'h 67;
    mips1.instruction_memory1.instruction_file[54] = 8'h 00;
    mips1.instruction_memory1.instruction_file[55] = 8'h 44;
    //lw   $2, 80($0) # $2 [80] 7 38 8c020050
    mips1.instruction_memory1.instruction_file[56] = 8'h 8c;
    mips1.instruction_memory1.instruction_file[57] = 8'h 02;
    mips1.instruction_memory1.instruction_file[58] = 8'h 00;
    mips1.instruction_memory1.instruction_file[59] = 8'h 50;
    // j end # should be taken 3c 08000011
    mips1.instruction_memory1.instruction_file[60] = 8'h 08;
    mips1.instruction_memory1.instruction_file[61] = 8'h 00;
    mips1.instruction_memory1.instruction_file[62] = 8'h 00;
    mips1.instruction_memory1.instruction_file[63] = 8'h 11;
    //addi $2, $0, 1 # shouldn’t happen 40 20020001
    mips1.instruction_memory1.instruction_file[64] = 8'h 20;
    mips1.instruction_memory1.instruction_file[65] = 8'h 02;
    mips1.instruction_memory1.instruction_file[66] = 8'h 00;
    mips1.instruction_memory1.instruction_file[67] = 8'h 01;
    //sw $2, 84($0) # write adr 84 7 44 ac020054
    mips1.instruction_memory1.instruction_file[68] = 8'h ac;
    mips1.instruction_memory1.instruction_file[69] = 8'h 02;
    mips1.instruction_memory1.instruction_file[70] = 8'h 00;
    mips1.instruction_memory1.instruction_file[71] = 8'h 54;




    //Check ADDI
    @(negedge clk);
    $display ("pc_in= %h", mips1.pc_in);
    $display ("pc_out= %h", mips1.pc1.pc_out);
    $display ("instruction=0x %h", mips1.instruction_memory1.instruction);
    $display ("ALU_in1= %h", mips1.read_data1);
    $display ("ALU_in2= %h", mips1.alu_in_2);
    $display ("ALU_result= %h", mips1.alu_result);
    $display ("write_data= %d", mips1.register_file1.write_data);
    $display ("Regdst= %h", mips1.register_file1.regdst);
    $display ("write_register= %d", mips1.register_file1.write_register);
    @(negedge clk);
    $display ("pc_out= %h", mips1.pc_out);
    $display ("pc_next= %h", mips1.pc_in);
    $display ("instruction=0x %h", mips1.instruction_memory1.instruction);
    $display ("register= %p", mips1.register_file1.register); //store first value, fetch the second instruction
    @(negedge clk);
    $display ("pc_out= %h", mips1.pc_out);
    $display ("pc_next= %h", mips1.pc_in);
    $display ("instruction=0x %h", mips1.instruction_memory1.instruction);
    $display ("register= %p", mips1.register_file1.register); //store 2nd value, fetch the 3rd instruction
    @(negedge clk);
    $display ("pc_out= %h", mips1.pc_out);
    $display ("pc_next= %h", mips1.pc_in);
    $display ("instruction=0x %h", mips1.instruction_memory1.instruction);
    $display ("register= %p", mips1.register_file1.register); //store 3rd value, fetch 4th instruction
    @(negedge clk);
    $display ("pc_out= %h", mips1.pc_out);
    $display ("pc_next= %h", mips1.pc_in);
    $display ("instruction=0x %h", mips1.instruction_memory1.instruction);
    $display ("register= %p", mips1.register_file1.register); //store 4th value, fetch 5th instruction
    @(negedge clk);
    $display ("pc_out= %h", mips1.pc_out);
    $display ("pc_next= %h", mips1.pc_in);
    $display ("instruction=0x %h", mips1.instruction_memory1.instruction);
    $display ("register= %p", mips1.register_file1.register); //store 5th value, fetch 6th instruction
    @(negedge clk);
    $display ("pc_out= %h", mips1.pc_out);
    $display ("pc_next= %h", mips1.pc_in);
    $display ("instruction=0x %h", mips1.instruction_memory1.instruction);
    $display ("register= %p", mips1.register_file1.register); //store 6th value, fetch 7th instruction
    @(negedge clk);
    $display ("This Cursed Test");
    $display ("pc_out= %h", mips1.pc_out);
    $display("instruction = %h", mips1.instruction);
    $display ("pc_next= %h", mips1.pc_in);
    $display ("pcsrc= %h", mips1.branch_control1.pcsrc);
    $display ("branch= %h", mips1.branch);    
    $display ("mux_upper_2_in2 =%h",mips1.mux_upper_2_in2);
    @(negedge clk);
    $display ("pc_out= %h", mips1.pc_out);
    $display ("pc_next= %h", mips1.pc_in);
    $display("instruction = %h", mips1.instruction);
    $display ("register= %p", mips1.register_file1.register); //store SLT value, fetch beq instruction    
    $display ("ALU_in1= %h", mips1.read_data1);
    $display ("ALU_in2= %h", mips1.alu_in_2);
    $display ("ALU_result= %h", mips1.alu_result);
    $display ("pcsrc= %h", mips1.branch_control1.pcsrc);    
    $display ("mux_upper_2_in2 =%h",mips1.mux_upper_2_in2);

    @(negedge clk);
    $display ("SLT Instruction");
    $display("instruction = %h", mips1.instruction);
    $display ("pc_out= %h", mips1.instruction_memory1.pc_out);
    $display ("pc_next= %h", mips1.pc_in);
    $display ("ALU_in1= %h", mips1.read_data1);
    $display ("ALU_in2= %h", mips1.alu_in_2);
    $display ("ALU_result= %h", mips1.alu_result);
    @(negedge clk);
    $display ("pc_out= %h", mips1.pc_out);
    $display ("pc_next= %h", mips1.pc_in);
    $display("instruction = %h", mips1.instruction);
    $display ("register= %p", mips1.register_file1.register); //store SLT value, fetch add instruction    

    @(negedge clk);
    $display ("pc_out= %h", mips1.pc_out);
    $display ("pc_next= %h", mips1.pc_in);
      $display("instruction = %h", mips1.instruction);
    $display ("register= %p", mips1.register_file1.register); //store add value, fetch sub instruction        
    $display ("memory file Check= %p", mips1.memory_file1.memory);
    @(negedge clk);
    $display ("pc_out= %h", mips1.pc_out);
    $display ("pc_next= %h", mips1.pc_in);
      $display("instruction = %h", mips1.instruction);
    $display ("register= %p", mips1.register_file1.register); //store sub value, fetch SW instruction   
    $display ("memory file Before= %p", mips1.memory_file1.memory); 
    @(negedge clk); 
    
    $display ("pc_out= %h", mips1.pc_out);
    $display ("pc_next= %h", mips1.pc_in);
      $display("instruction = %h", mips1.instruction);
      $display ("memory file After= %p", mips1.memory_file1.memory);
    $display ("memory file= %p", mips1.memory_file1.memory);//store complete, fetch lw
    @(negedge clk);
    $display ("pc_out= %h", mips1.pc_out);
    $display ("pc_next= %h", mips1.pc_in);
      $display("instruction = %h", mips1.instruction);
    $display ("register= %p", mips1.register_file1.register); //Load complete , fetch j instruction  
    @(negedge clk);
    $display ("pc_out= %h", mips1.pc_out);
    $display ("pc_next= %h", mips1.pc_in);                  //J comlete, fetch SW
    $display("instruction = %h", mips1.instruction);
    $display ("memory file Before= %p", mips1.memory_file1.memory);
    @(negedge clk);
    $display ("pc_out= %h", mips1.pc_out);
    $display ("pc_next= %h", mips1.pc_in);
      $display("instruction = %h", mips1.instruction);
    $display ("memory file After= %p", mips1.memory_file1.memory);//store complete, fetch Nothing
    $stop;
*/

/*
  //Test 2
    //addi $1, $0, 0x0F0F 0x20010F0F
    mips1.instruction_memory1.instruction_file[0] = 8'h 20;
    mips1.instruction_memory1.instruction_file[1] = 8'h 01;
    mips1.instruction_memory1.instruction_file[2] = 8'h 0F;
    mips1.instruction_memory1.instruction_file[3] = 8'h 0F;
    //andi $2, $1, 0x00FF 0x302200FF          
    mips1.instruction_memory1.instruction_file[4] = 8'h 30;
    mips1.instruction_memory1.instruction_file[5] = 8'h 22;
    mips1.instruction_memory1.instruction_file[6] = 8'h 00;
    mips1.instruction_memory1.instruction_file[7] = 8'h FF;
    //ori $3, $1, 0xF000  0x3423F000
    mips1.instruction_memory1.instruction_file[8] = 8'h 34;
    mips1.instruction_memory1.instruction_file[9] = 8'h 23;
    mips1.instruction_memory1.instruction_file[10] = 8'h F0;
    mips1.instruction_memory1.instruction_file[11] = 8'h 00;
    //nor $4, $1, $2 0x00222027        
    mips1.instruction_memory1.instruction_file[12] = 8'h 00;
    mips1.instruction_memory1.instruction_file[13] = 8'h 22;
    mips1.instruction_memory1.instruction_file[14] = 8'h 20;
    mips1.instruction_memory1.instruction_file[15] = 8'h 27;
    //addi $5, $0, 10 0x2005000A
    mips1.instruction_memory1.instruction_file[16] = 8'h 20;
    mips1.instruction_memory1.instruction_file[17] = 8'h 05;
    mips1.instruction_memory1.instruction_file[18] = 8'h 00;
    mips1.instruction_memory1.instruction_file[19] = 8'h 0A;
    //addi $6, $0, 20 0x20060014
    mips1.instruction_memory1.instruction_file[20] = 8'h 20;
    mips1.instruction_memory1.instruction_file[21] = 8'h 06;
    mips1.instruction_memory1.instruction_file[22] = 8'h 00;
    mips1.instruction_memory1.instruction_file[23] = 8'h 14;
    //bne $5, $6, skip (offset=1) 0x14A60001
    mips1.instruction_memory1.instruction_file[24] = 8'h 14;
    mips1.instruction_memory1.instruction_file[25] = 8'h A6;
    mips1.instruction_memory1.instruction_file[26] = 8'h 00;
    mips1.instruction_memory1.instruction_file[27] = 8'h 01;
    //addi $7, $0, 99 0x20070063
    mips1.instruction_memory1.instruction_file[28] = 8'h 20;
    mips1.instruction_memory1.instruction_file[29] = 8'h 07;
    mips1.instruction_memory1.instruction_file[30] = 8'h 00;
    mips1.instruction_memory1.instruction_file[31] = 8'h 63;
    //jal 0x00000017 0x0C000017   jal 0x00000017
    mips1.instruction_memory1.instruction_file[32] = 8'h 0C;
    mips1.instruction_memory1.instruction_file[33] = 8'h 00;
    mips1.instruction_memory1.instruction_file[34] = 8'h 00;
    mips1.instruction_memory1.instruction_file[35] = 8'h 17;
    //nop 0x00000000
    mips1.instruction_memory1.instruction_file[36] = 8'h 00;
    mips1.instruction_memory1.instruction_file[37] = 8'h 00;
    mips1.instruction_memory1.instruction_file[38] = 8'h 00;
    mips1.instruction_memory1.instruction_file[39] = 8'h 00;
    //lbu $11, 1($10) 0x914B0001 
    mips1.instruction_memory1.instruction_file[40] = 8'h 91;
    mips1.instruction_memory1.instruction_file[41] = 8'h 4B;
    mips1.instruction_memory1.instruction_file[42] = 8'h 00;
    mips1.instruction_memory1.instruction_file[43] = 8'h 01;
    //lhu $12, 2($10)   0x954C0002
    mips1.instruction_memory1.instruction_file[44] = 8'h 95;
    mips1.instruction_memory1.instruction_file[45] = 8'h 4C;
    mips1.instruction_memory1.instruction_file[46] = 8'h 00;
    mips1.instruction_memory1.instruction_file[47] = 8'h 02;
    //lui $13, 0xABCD 0x3C0DABCD          
    mips1.instruction_memory1.instruction_file[48] = 8'h 3C;
    mips1.instruction_memory1.instruction_file[49] = 8'h 0D;
    mips1.instruction_memory1.instruction_file[50] = 8'h AB;
    mips1.instruction_memory1.instruction_file[51] = 8'h CD;
    //sb $12, 4($10)  0xA28C0004
    mips1.instruction_memory1.instruction_file[52] = 8'h A2;
    mips1.instruction_memory1.instruction_file[53] = 8'h 8C;
    mips1.instruction_memory1.instruction_file[54] = 8'h 00;
    mips1.instruction_memory1.instruction_file[55] = 8'h 04;
    //sh $12, 6($10)  0xA6AC0006
    mips1.instruction_memory1.instruction_file[56] = 8'h A6;
    mips1.instruction_memory1.instruction_file[57] = 8'h AC;
    mips1.instruction_memory1.instruction_file[58] = 8'h 00;
    mips1.instruction_memory1.instruction_file[59] = 8'h 06;
    //slti $14, $5, 15 0x28AE000F
    mips1.instruction_memory1.instruction_file[60] = 8'h 28;
    mips1.instruction_memory1.instruction_file[61] = 8'h AE;
    mips1.instruction_memory1.instruction_file[62] = 8'h 00;
    mips1.instruction_memory1.instruction_file[63] = 8'h 0F;
    //sll $15, $5, 2 0x00057880       0000 0000 0000 0101 0111 1000 1000 0000
    mips1.instruction_memory1.instruction_file[64] = 8'h 00;
    mips1.instruction_memory1.instruction_file[65] = 8'h 05;
    mips1.instruction_memory1.instruction_file[66] = 8'h 78;
    mips1.instruction_memory1.instruction_file[67] = 8'h 80;
    //sra $16, $6, 1 0x00068043       0000  0000  0000 0110 1000 0000 0100 0011
    mips1.instruction_memory1.instruction_file[68] = 8'h 00;
    mips1.instruction_memory1.instruction_file[69] = 8'h 06;
    mips1.instruction_memory1.instruction_file[70] = 8'h 80;
    mips1.instruction_memory1.instruction_file[71] = 8'h 43;
    //srl $17, $6, 1  0x00068842      0000  0000  0000  0110 1000  1000  0100 0010
    mips1.instruction_memory1.instruction_file[72] = 8'h 00;
    mips1.instruction_memory1.instruction_file[73] = 8'h 06;
    mips1.instruction_memory1.instruction_file[74] = 8'h 88;
    mips1.instruction_memory1.instruction_file[75] = 8'h 42;
    //nop
    mips1.instruction_memory1.instruction_file[76] = 8'h 00;
    mips1.instruction_memory1.instruction_file[77] = 8'h 00;
    mips1.instruction_memory1.instruction_file[78] = 8'h 00;
    mips1.instruction_memory1.instruction_file[79] = 8'h 00;
    //nop
    mips1.instruction_memory1.instruction_file[80] = 8'h 00;
    mips1.instruction_memory1.instruction_file[81] = 8'h 00;
    mips1.instruction_memory1.instruction_file[82] = 8'h 00;
    mips1.instruction_memory1.instruction_file[83] = 8'h 00;
    //Jr $31 0x03E00008
    mips1.instruction_memory1.instruction_file[84] = 8'h 03;
    mips1.instruction_memory1.instruction_file[85] = 8'h E0;
    mips1.instruction_memory1.instruction_file[86] = 8'h 00;
    mips1.instruction_memory1.instruction_file[87] = 8'h 08;
    //nop
    mips1.instruction_memory1.instruction_file[88] = 8'h 00;
    mips1.instruction_memory1.instruction_file[89] = 8'h 00;
    mips1.instruction_memory1.instruction_file[90] = 8'h 00;
    mips1.instruction_memory1.instruction_file[91] = 8'h 00;
    //addi $18, $0, 42 0x2012002A
    mips1.instruction_memory1.instruction_file[92] = 8'h 20;
    mips1.instruction_memory1.instruction_file[93] = 8'h 12;
    mips1.instruction_memory1.instruction_file[94] = 8'h 00;
    mips1.instruction_memory1.instruction_file[95] = 8'h 2A;
    //jr $31 0x03E00008       0000 00   11 111  0 0000   0000 0   000 00  00 1000
    mips1.instruction_memory1.instruction_file[96] = 8'h 03;
    mips1.instruction_memory1.instruction_file[97] = 8'h E0;
    mips1.instruction_memory1.instruction_file[98] = 8'h 00;
    mips1.instruction_memory1.instruction_file[99] = 8'h 08;
    //nop
    mips1.instruction_memory1.instruction_file[100] = 8'h 00;
    mips1.instruction_memory1.instruction_file[101] = 8'h 00;
    mips1.instruction_memory1.instruction_file[102] = 8'h 00;
    mips1.instruction_memory1.instruction_file[103] = 8'h 00;
  
  

    // Memory Initial
    mips1.memory_file1.memory[0]= 8'h 12;
    mips1.memory_file1.memory[1]= 8'h 34;
    mips1.memory_file1.memory[2]= 8'h 56;
    mips1.memory_file1.memory[3]= 8'h 78;



  @(negedge clk);
    $display ("pc_in= %h", mips1.pc_in);
    $display ("pc_out= %h", mips1.pc1.pc_out);
    $display ("instruction=0x %h", mips1.instruction_memory1.instruction);
    $display ("ALU_in1= %h", mips1.register_file1.read_data1);
    $display ("ALU_in2= %h", mips1.alu_in_2);
    $display ("ALU_result= %h", mips1.alu_result);
    $display ("write_data= %d", mips1.register_file1.write_data);
    $display ("Regdst= %h", mips1.register_file1.regdst);
    $display ("write_register= %d", mips1.register_file1.write_register);
    $display ("register= %p", mips1.register_file1.register);
    
  @(negedge clk);

    $display ("register= %p", mips1.register_file1.register);    //ANDI Is Done , Fetching ORI
    $display ("pc_in= %h", mips1.pc_in);
    $display ("pc_out= %h", mips1.pc1.pc_out);
    $display ("instruction=0x %h", mips1.instruction_memory1.instruction);
    $display ("ALU_in1= %h", mips1.register_file1.read_data1);
    $display ("ALU_in2= %h", mips1.alu_in_2);
    $display ("ALU_result= %h", mips1.alu_result);
   
  @(negedge clk);

    $display ("register= %p", mips1.register_file1.register);    //Storing ORI Fetching Nor
    $display ("pc_in= %h", mips1.pc_in);
    $display ("pc_out= %h", mips1.pc1.pc_out);
    $display ("instruction=0x %h", mips1.instruction_memory1.instruction);
    $display ("ALU_in1= %h", mips1.register_file1.read_data1);
    $display ("ALU_in2= %h", mips1.alu_in_2);
    $display ("ALU_result= %h", mips1.alu_result);
  @(negedge clk);
    $display ("register= %p", mips1.register_file1.register);    //Storing NOR Fetching ADDI
    $display ("pc_in= %h", mips1.pc_in);
    $display ("pc_out= %h", mips1.pc1.pc_out);
    $display ("instruction=0x %h", mips1.instruction_memory1.instruction);
    $display ("ALU_in1= %h", mips1.register_file1.read_data1);
    $display ("ALU_in2= %h", mips1.alu_in_2);
    $display ("ALU_result= %h", mips1.alu_result);
  @(negedge clk);
    $display ("register= %p", mips1.register_file1.register);    //Storing ADDI Fetching ADDI
    $display ("pc_in= %h", mips1.pc_in);
    $display ("pc_out= %h", mips1.pc1.pc_out);
    $display ("instruction=0x %h", mips1.instruction_memory1.instruction);
    $display ("ALU_in1= %h", mips1.register_file1.read_data1);
    $display ("ALU_in2= %h", mips1.alu_in_2);
    $display ("ALU_result= %h", mips1.alu_result);
  @(negedge clk);
    $display ("register= %p", mips1.register_file1.register);    //Storing ADDI Fetching BNE
    $display ("pc_in= %h", mips1.pc_in);
    $display ("pc_out= %h", mips1.pc1.pc_out);
    $display ("instruction=0x %h", mips1.instruction_memory1.instruction);
    $display ("ALU_in1= %h", mips1.register_file1.read_data1);
    $display ("ALU_in2= %h", mips1.alu_in_2);
    $display ("ALU_result= %h", mips1.alu_result);
  @(negedge clk);
    $display ("pc_in= %h", mips1.pc_in);
    $display ("pc_out= %h", mips1.pc1.pc_out);
    $display ("instruction=0x %h", mips1.instruction_memory1.instruction);
  @(negedge clk);
    $display ("pc_in= %h", mips1.pc_in);
    $display ("pc_out= %h", mips1.pc1.pc_out);
    $display ("instruction=0x %h", mips1.instruction_memory1.instruction);
  @(negedge clk);
    $display ("pc_in= %h", mips1.pc_in);
    $display ("pc_out= %h", mips1.pc1.pc_out);
    $display ("instruction=0x %h", mips1.instruction_memory1.instruction);
  @(negedge clk);
    $display ("pc_in= %h", mips1.pc_in);
    $display ("pc_out= %h", mips1.pc1.pc_out);
    $display ("instruction=0x %h", mips1.instruction_memory1.instruction);
    $display ("register= %p", mips1.register_file1.register);
  @(negedge clk);
    $display ("pc_in= %h", mips1.pc_in);
    $display ("pc_out= %h", mips1.pc1.pc_out);
    $display ("instruction=0x %h", mips1.instruction_memory1.instruction);
    $display ("ALU_in1= %h", mips1.register_file1.read_data1);
    $display ("ALU_in2= %h", mips1.alu_in_2);
    $display ("ALU_result= %h", mips1.alu_result);


  @(negedge clk);
    $display ("pc_in= %h", mips1.pc_in);
    $display ("pc_out= %h", mips1.pc1.pc_out);
    $display ("instruction=0x %h", mips1.instruction_memory1.instruction);
    $display ("register= %p", mips1.register_file1.register); //LBU stroe , fetch lhu
  @(negedge clk);
    $display ("pc_in= %h", mips1.pc_in);
    $display ("pc_out= %h", mips1.pc1.pc_out);
    $display ("instruction=0x %h", mips1.instruction_memory1.instruction);
    $display ("register= %p", mips1.register_file1.register); //LHU stroe , fetch lui
    $display ("ALU_in1= %h", mips1.register_file1.read_data1);
    $display ("ALU_in2= %h", mips1.alu_in_2);
    $display ("ALU_result= %h", mips1.alu_result);

  @(negedge clk);
    $display ("pc_in= %h", mips1.pc_in);
    $display ("pc_out= %h", mips1.pc1.pc_out);
    $display ("instruction=0x %h", mips1.instruction_memory1.instruction);
    $display ("register= %p", mips1.register_file1.register); //Lui stroe , fetch sb

    $display ("ALU_in1= %h", mips1.register_file1.read_data1);
    $display ("ALU_in2= %h", mips1.alu_in_2);
    $display ("ALU_result= %h", mips1.alu_result);
    $display ("Write data= %h", mips1.memory_file1.write_data);
  @(negedge clk);
    $display ("pc_in= %h", mips1.pc_in);
    $display ("pc_out= %h", mips1.pc1.pc_out);
    $display ("instruction=0x %h", mips1.instruction_memory1.instruction);
    $display ("register= %p", mips1.register_file1.register); //sb stroe , fetch sh
  @(negedge clk);
    $display ("pc_in= %h", mips1.pc_in);
    $display ("pc_out= %h", mips1.pc1.pc_out);
    $display ("instruction=0x %h", mips1.instruction_memory1.instruction);
    $display ("register= %p", mips1.register_file1.register); //Lsh stroe , fetch SLTI
    $display ("memory file= %p", mips1.memory_file1.memory);

  @(negedge clk);
    $display ("pc_in= %h", mips1.pc_in);
    $display ("pc_out= %h", mips1.pc1.pc_out);
    $display ("instruction=0x %h", mips1.instruction_memory1.instruction);
    $display ("register= %p", mips1.register_file1.register); //SLTI stroe , fetch Sll
    $display ("ALU_in1= %h", mips1.register_file1.read_data1);
    $display ("ALU_in2= %h", mips1.alu_in_2);
    $display ("ALU_result= %h", mips1.alu_result);

  @(negedge clk);
    $display ("pc_in= %h", mips1.pc_in);
    $display ("pc_out= %h", mips1.pc1.pc_out);
    $display ("instruction=0x %h", mips1.instruction_memory1.instruction);
    $display ("register= %p", mips1.register_file1.register); //SLL stroe , fetch Sra
  @(negedge clk);
    $display ("pc_in= %h", mips1.pc_in);
    $display ("pc_out= %h", mips1.pc1.pc_out);
    $display ("instruction=0x %h", mips1.instruction_memory1.instruction);
    $display ("register= %p", mips1.register_file1.register); //Sra stroe , fetch srl
  @(negedge clk);
    $display ("pc_in= %h", mips1.pc_in);
    $display ("pc_out= %h", mips1.pc1.pc_out);
    $display ("instruction=0x %h", mips1.instruction_memory1.instruction);
    $display ("register= %p", mips1.register_file1.register); //Srl stroe , fetch nop

 $stop;
 */
    
// all instruction excute at the same negative edge of the clk, but it stored at the next negative edge of the clock "it's positive edge but we check the simulation at each negative edge"


end


endmodule