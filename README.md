RISC-V Mini Core
A simple RISC-V inspired processor implemented and verified in SystemVerilog.

This project was created to gain practical experience with digital design, RTL development, verification, simulation, and ASIC design workflows. The focus is on understanding and implementing the fundamental building blocks of a processor rather than advanced microarchitectural optimizations.

Implemented Modules
Arithmetic Logic Unit (ALU)
Register File (32 × 32-bit)
Program Counter (PC)
Instruction Decoder
CPU Top-Level Integration
Supported ALU Operations
ADD
SUB
AND
OR
XOR
SLL
SRL
Verification
Each module is verified using a dedicated SystemVerilog testbench and assertion-based testing with Verilator.

Tools
SystemVerilog
Verilator
GTKWave
Git / GitHub
Visual Studio Code
Ubuntu (WSL)
Project Structure
rtl/
├── alu.sv
├── regfile.sv
├── pc.sv
├── decoder.sv
└── cpu.sv

tb/
├── tb_alu.sv
├── tb_regfile.sv
├── tb_pc.sv
├── tb_decoder.sv
└── tb_cpu.sv
Roadmap
Basic instruction execution
RISC-V instruction support
Instruction memory
Expanded verification
RTL-to-GDSII ASIC implementation using OpenLane and Sky130
Author
Tijs Boeckxstaens

Bachelor Electrical Engineering Student

Interested in ASIC Design, Digital IC Design, Computer Architecture and Verification.