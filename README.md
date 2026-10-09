RISC-V Mini Core
A simple RISC-V inspired processor designed and verified in SystemVerilog as a hands-on digital design project.

The objective of this project is to gain practical experience with RTL development, hardware verification, simulation, debugging, and ASIC design flows. Rather than focusing on advanced microarchitectural features, the project emphasizes clean design practices, modular development, thorough testing, and a solid understanding of the complete hardware development process.

The processor is developed from individual building blocks including an Arithmetic Logic Unit (ALU), register file, instruction decoder, and program counter. Each module is verified independently using dedicated testbenches before integration into the complete CPU.

Development is carried out using Verilator for simulation, GTKWave for waveform analysis, Git for version control, and GitHub for documentation and project management.

Current Features
Implemented Modules
Arithmetic Logic Unit (ALU)
Register File (32 × 32-bit registers)
Program Counter (PC)
Instruction Decoder
Supported ALU Operations
ADD
SUB
AND
OR
XOR
SLL (Shift Left Logical)
SRL (Shift Right Logical)
Verification
Dedicated testbench for every module
Assertion-based verification
Verilator simulation environment
Modular verification before integration
Repository Structure
riscv-mini-core
│
├── rtl
│   ├── alu.sv
│   ├── regfile.sv
│   ├── pc.sv
│   └── decoder.sv
│
├── tb
│   ├── tb_alu.sv
│   ├── tb_regfile.sv
│   ├── tb_pc.sv
│   └── tb_decoder.sv
│
├── docs
│
└── README.md
Verification Status
Module	Status
ALU	✅ Verified
Register File	✅ Verified
Program Counter	✅ Verified
Decoder	✅ Verified
CPU Top Level	🚧 In Progress
Project Goals
This project is intended to provide practical experience with:

Digital hardware design
Computer architecture
RTL development in SystemVerilog
Testbench development
Functional verification
Hardware debugging using waveform analysis
Git and GitHub workflows
Engineering documentation
Development Flow
The project follows a structured hardware design methodology:

RTL Design
    ↓
Module Verification
    ↓
CPU Integration
    ↓
System Verification
    ↓
ASIC Flow Exploration
Each module is first designed, then verified independently through simulation and assertions before being integrated into the processor.

Long-Term Goal
After completing the processor implementation, the design will be taken through a complete open-source ASIC flow using OpenLane, OpenROAD, and the Sky130 Process Design Kit (PDK).

Planned design flow:

RTL Design
    ↓
Logic Synthesis
    ↓
Static Timing Analysis
    ↓
Floorplanning
    ↓
Placement
    ↓
Clock Tree Synthesis
    ↓
Routing
    ↓
Physical Verification
    ↓
GDSII Generation
The ultimate objective is to gain hands-on experience with the complete RTL-to-GDSII workflow used in modern digital integrated circuit design.

Tools
SystemVerilog
Verilator
GTKWave
Git
GitHub
Visual Studio Code
Ubuntu (WSL)
Future Work
CPU top-level integration
Instruction execution flow
Basic RISC-V instruction support
Expanded verification environment
Waveform documentation
RTL-to-GDSII ASIC implementation flow
OpenLane/OpenROAD integration
Author
Tijs Boeckxstaens

Bachelor Electrical Engineering Student

Interests:

ASIC Design
Digital IC Design
Computer Architecture
Verification
Physical Design ``