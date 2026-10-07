# RISC-V Mini Core

A simple RISC-V processor designed and verified in SystemVerilog as a hands-on digital design project.

The objective of this project is to gain practical experience with RTL development, hardware verification, simulation, debugging, and ASIC design flows. Rather than focusing on advanced microarchitectural features, the project emphasizes clean design practices, modular development, thorough testing, and a solid understanding of the complete hardware development process.

The processor is built from individual modules including an Arithmetic Logic Unit (ALU), register file, instruction decoder, and program counter. Each module is verified independently using dedicated testbenches before being integrated into the complete CPU.

Development is carried out using Verilator for simulation, GTKWave for waveform analysis, Git for version control, and GitHub for project management and documentation.

## Current Features

- SystemVerilog RTL implementation
- Modular processor architecture
- Arithmetic and logical ALU operations
- 32-register register file
- Instruction decoding
- Program counter and control logic
- Verilator-based simulation
- GTKWave waveform debugging
- Module-level verification through testbenches

## Project Goals

This project is intended to provide practical experience with:

- Digital hardware design
- Computer architecture
- RTL development in SystemVerilog
- Testbench creation and verification methodologies
- Hardware debugging using waveform analysis
- Git and GitHub workflows
- Engineering documentation

## Long-Term Goal

After completing the functional processor implementation, the design will be taken through a complete open-source ASIC flow using OpenLane, OpenROAD, and the Sky130 Process Design Kit (PDK).

The planned flow includes:

RTL Design → Synthesis → Static Timing Analysis → Floorplanning → Placement → Clock Tree Synthesis → Routing → Physical Verification → GDSII Generation

The ultimate objective is to gain exposure to the complete RTL-to-GDSII workflow used in modern digital integrated circuit design.

## Tools

- SystemVerilog
- Verilator
- GTKWave
- Git
- GitHub
- Visual Studio Code
- Ubuntu (WSL)

## Author

Tijs Boeckxstaens

Bachelor Electrical Engineering Student

Interests:
- ASIC Design
- Digital IC Design
- Computer Architecture
- Verification
- Physical Design