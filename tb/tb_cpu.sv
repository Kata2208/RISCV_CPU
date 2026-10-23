module tb_cpu;

    logic        clk;
    logic        reset;
    logic [31:0] instruction;

    // DUT
    cpu dut (
        .clk(clk),
        .reset(reset),
        .instruction(instruction)
    );

    // Clock generation
    initial begin
        clk = 0;
        forever #5 clk = ~clk;
    end

    initial begin

        // ====================
        // Reset
        // ====================
        reset = 1;
        instruction = 32'h00000013; // NOP
        @(posedge clk);

        reset = 0;
        @(posedge clk);

        // ====================
        // ADDI x1, x0, 5
        // ====================
        instruction = 32'h00500093;
        @(posedge clk);

        // ====================
        // ADDI x2, x0, 3
        // ====================
        instruction = 32'h00300113;
        @(posedge clk);

        // ====================
        // ADD x3, x1, x2
        // ====================
        instruction = 32'h002081B3;
        @(posedge clk);

        // Laat writeback gebeuren
        @(posedge clk);

        // ====================
        // Checks
        // ====================

        assert(dut.regfile_inst.regs[1] == 32'd5)
            else $fatal("x1 incorrect: got %0d expected 5",
                        dut.regfile_inst.regs[1]);

        assert(dut.regfile_inst.regs[2] == 32'd3)
            else $fatal("x2 incorrect: got %0d expected 3",
                        dut.regfile_inst.regs[2]);

        assert(dut.regfile_inst.regs[3] == 32'd8)
            else $fatal("x3 incorrect: got %0d expected 8",
                        dut.regfile_inst.regs[3]);

        $display("--------------------------------");
        $display("CPU TEST PASSED");
        $display("x1 = %0d", dut.regfile_inst.regs[1]);
        $display("x2 = %0d", dut.regfile_inst.regs[2]);
        $display("x3 = %0d", dut.regfile_inst.regs[3]);
        $display("--------------------------------");

        $finish;
    end

endmodule
