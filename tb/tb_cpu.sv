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

        // 2. Run for 25 clock cycles to allow the loop to finish
        #250;

        // 3. Verification check
        #1;
        assert(dut.regfile_inst.regs[2] == 15)
            else $error("Loop Test Failed! Expected x2 = 15 (1+2+3+4+5), got %d", dut.regfile_inst.regs[2]);

        $display("--------------------------------------------------");
        $display("SUCCESS: CPU successfully executed a hardware loop!");
        $display("Sum (x2) = %d (Expected 15)", dut.regfile_inst.regs[2]);
        $display("Counter (x1) = %d (Expected 0)", dut.regfile_inst.regs[1]);
        $display("Final PC = 0x%08h", dut.pc_inst.pc_out);
        $display("--------------------------------------------------");

        $finish;
    end

endmodule
