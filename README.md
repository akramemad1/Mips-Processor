# Mips-Processor
## What is MIPS?
Mips is a **RISC (Reduced Instruction Set Computing)** architecture that has been widely used in embedded systems, networking hardware, and early computer workstations. It was originally developed by MIPS Computer Systems in the 1980s. The Target Of this project is to design a MIPS Processor That is capable of executing Basic Instructions of MIPS.

## Features
1. RISC Design
2. Load/Store Architecture
3. Fixed Instruction Length: 32 bits

## MIPS instruction Types
- R-Type (Register-Register Operations)
  - ` opcode (6) | rs (5) | rt (5) | rd (5) | shamt (5) | funct (6) `
- I-Type (Immediate and Load/Store Operations)
  - `opcode (6) | rs (5) | rt (5) | immediate (16)`
- J-Type (Jump Instructions)
  - `opcode (6) | address (26)`

## Supportted instructions

<details>
  <summary>R-Type</summary>

 
  - and
  - or
  - add
  - sll
  - srl
  - sra
  - sub
  - slt
  - xor
  - nor
  - jr
    
  
</details>

<details>
  <summary>I-Type</summary>

 
  - lw
  - sw
  - beq
  - bne
  - addi
  - slti
  - andi
  - ori
  - xori
  - lui
  - lb
  - lh
  - lbu
  - lhu
  - sb
  - sh
    
  
</details>
<details>
  <summary>J-Type</summary>

 
  - j
  - jal
    
  
</details>

## ALU Operations

| ALU Control Line  | Operation |
| ------------- | :-------------: |
| 0000          | AND  |
| 0001          | OR   |
| 0010          | ADD  |
| 0011          | SLL  |
| 0100          | SRL  |
| 0101          | SRA  |
| 0110          | SUB  |
| 0111          | SLT  |
| 1000          | XOR  |
| 1100          | NOR  |


## Architecture Overview
![info](/Documentation/Architecture.png)

## Improvements Could Be Applied
- Provide Proper Testbench
  - This is a Directed Input Test, Where You Initialize the Instruction Memory directly by decoding the instructions manualy. A proper Testing is to make the Test Bench read the instructions automatically from a separate file 
- Check if the design is synthesizabile
  - the ability to turn the design into chip
- Support Piplining and exception

## To Use The Design
- Make Sure you have ModelSim/QuestaSim for simulation
