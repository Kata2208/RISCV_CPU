module tb_cpu;

    logic clk;
    logic reset;

    cpu dut (
        .clk(clk),
        .reset(reset)
    );

    // Clock generation
    initial begin
        clk = 0;
        forever #5 clk = ~clk;
    end

    initial begin

        // Start in reset
        reset = 1;

        // Wacht op eerste klokflank
        #10;

        assert(dut.pc_out == 0)
            else $error("PC should be 0 after reset");

        // Reset loslaten
        reset = 0;

        // 1e klokflank
        #10;

        assert(dut.pc_out == 4)
            else $error("PC should be 4");

        // 2e klokflank
        #10;

        assert(dut.pc_out == 8)
            else $error("PC should be 8");

        // 3e klokflank
        #10;

        assert(dut.pc_out == 12)
            else $error("PC should be 12");

        $display("All CPU tests passed!");

        $finish;

    end

endmodule
