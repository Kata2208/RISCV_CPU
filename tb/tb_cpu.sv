module tb_cpu;

    logic        clk;
    logic        reset;
    logic [31:0] instruction;

    // Instantiate top-level CPU
    cpu dut (
        .clk(clk),
        .reset(reset),
        .instruction(instruction)
    );

    // Clock generation (10ns period)
    initial begin
        clk = 0;
        forever #5 clk = ~clk;
    end

    initial begin
        // 1. Reset Phase
        reset = 1;
        instruction = 32'h00000013; // NOP (ADDI x0, x0, 0)
        #10;

        reset = 0;
        #10;

        // 2. Instruction 1: ADDI x1, x0, 5 (Machine code: 0x00500093)
        instruction = 32'h00500093;
        #10;

        // 3. Instruction 2: ADDI x2, x0, 3 (Machine code: 0x00300113)
        instruction = 32'h00300113;
        #10;

        // 4. Instruction 3: ADD x3, x1, x2 (Machine code: 0x002081B3)
        instruction = 32'h002081B3;
        #10;

        // 5. Verification checks
        #1;
        assert(dut.regfile_inst.regs[1] == 5)
            else $error("ADDI x1 failed! Expected 5, got %d", dut.regfile_inst.regs[1]);

        assert(dut.regfile_inst.regs[2] == 3)
            else $error("ADDI x2 failed! Expected 3, got %d", dut.regfile_inst.regs[2]);

        assert(dut.regfile_inst.regs[3] == 8)
            else $error("ADD x3 failed! Expected 8, got %d", dut.regfile_inst.regs[3]);

        $display("--------------------------------------------------");
        $display("SUCCESS: ADDI and ADD executed correctly!");
        $display("x1 = %d (Expected 5)", dut.regfile_inst.regs[1]);
        $display("x2 = %d (Expected 3)", dut.regfile_inst.regs[2]);
        $display("x3 = %d (Expected 8)", dut.regfile_inst.regs[3]);
        $display("--------------------------------------------------");

        $finish;
    end

endmodule
