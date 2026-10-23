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

        // 2. Run for 5 clock cycles
        #50; // 5 * 10ns = 50ns

        // 3. Verification checks
        #1;
        assert(dut.regfile_inst.regs[1] == 5)
            else $error("Execution failed! Expected x1 = 5, got %d", dut.regfile_inst.regs[1]);

        assert(dut.regfile_inst.regs[2] == 3)
            else $error("Execution failed! Expected x2 = 3, got %d", dut.regfile_inst.regs[2]);

        assert(dut.regfile_inst.regs[3] == 8)
            else $error("Execution failed! Expected x3 = 8, got %d", dut.regfile_inst.regs[3]);

        assert(dut.dmem_inst.mem[1] == 8) // Word index 1 = Address 0x04
            else $error("SW failed! Expected RAM[4] = 8, got %d", dut.dmem_inst.mem[1]);

        assert(dut.regfile_inst.regs[4] == 8)
            else $error("LW failed! Expected x4 = 8, got %d", dut.regfile_inst.regs[4]);

        $display("--------------------------------------------------");
        $display("SUCCESS: Full program with LW and SW executed!");
        $display("x1 = %d (Expected 5)", dut.regfile_inst.regs[1]);
        $display("x2 = %d (Expected 3)", dut.regfile_inst.regs[2]);
        $display("x3 = %d (Expected 8)", dut.regfile_inst.regs[3]);
        $display("RAM[0x04] = %d (Expected 8)", dut.dmem_inst.mem[1]);
        $display("x4 = %d (Expected 8, loaded from RAM)", dut.regfile_inst.regs[4]);
        $display("--------------------------------------------------");

        $finish;
    end

endmodule
