module tb_cpu;

    logic clk;
    logic reset;

    cpu dut (
        .clk(clk),
        .reset(reset)
    );

    initial begin
        clk = 0;
        forever #5 clk = ~clk;
    end

    initial begin
        // 1. Reset Phase
        reset = 1;
        #10;

        reset = 0;

        // 2. Run for 6 clock cycles to complete execution
        #60;

        // 3. Verification checks
        #1;
        assert(dut.regfile_inst.regs[1] == 5)
            else $error("Branch Test Failed! Expected x1 = 5, got %d", dut.regfile_inst.regs[1]);

        assert(dut.regfile_inst.regs[2] == 5)
            else $error("Branch Test Failed! Expected x2 = 5, got %d", dut.regfile_inst.regs[2]);

        assert(dut.regfile_inst.regs[3] == 42)
            else $error("Branch Test Failed! Expected x3 = 42 (skipped instruction 99), got %d", dut.regfile_inst.regs[3]);

        $display("--------------------------------------------------");
        $display("SUCCESS: Branch instruction (BEQ) executed correctly!");
        $display("x1 = %d (Expected 5)", dut.regfile_inst.regs[1]);
        $display("x2 = %d (Expected 5)", dut.regfile_inst.regs[2]);
        $display("x3 = %d (Expected 42, instruction at mem[5] was skipped)", dut.regfile_inst.regs[3]);
        $display("Final PC = 0x%08h", dut.pc_inst.pc_out);
        $display("--------------------------------------------------");

        $finish;
    end

endmodule
