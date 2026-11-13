module tb_cpu;

    logic clk;
    logic reset;

    cpu dut (
        .clk(clk),
        .reset(reset)
    );

    // Clock generation (10ns period)
    initial begin
        clk = 0;
        forever #5 clk = ~clk;
    end

    initial begin
        // Waveform dump setup for GTKWave
        $dumpfile("waveform.vcd");
        $dumpvars(0, tb_cpu);

        // 1. Reset Phase + wacht #1 zodat initial-blokken van mem eerst klaar zijn
        reset = 1;
        #1;
        $readmemh("program.hex", dut.imem_inst.mem);
        #9;

        reset = 0;

        // 2. C-Runtime setup: start bij <main> (0x9c), sp bovenaan 256B RAM, ra op eindadres
        force dut.pc_inst.pc_out = 32'h0000_009c;
        #1;
        release dut.pc_inst.pc_out;

        dut.regfile_inst.regs[2] = 32'h0000_0100; // sp (x2) = 256 (top van 64-word RAM)
        dut.regfile_inst.regs[1] = 32'h0000_0FFC; // ra (x1) = herkenbaar eindadres na main()

        // 3. Run simulation totdat main() returnt naar ra (0x0000_0FFC) of timeout
        fork
            begin
                wait (dut.pc_inst.pc_out == 32'h0000_0FFC);
            end
            begin
                #5000; // Timeout na 500 clock cycles
                $error("TIMEOUT: CPU bereikte het einde van main() niet! Huidige PC = 0x%08h", dut.pc_inst.pc_out);
                $finish;
            end
        join_any
        disable fork;

        // 4. Verification check (return-waarde van main staat in a0 = x10)
        #1;
        assert(dut.regfile_inst.regs[10] == 32'd15)
            else $error("Test Failed! Expected a0 (x10) = 15, got %d", dut.regfile_inst.regs[10]);

        $display("--------------------------------------------------");
        $display("SUCCESS: RISC-V C-programma (sum(5)) succesvol uitgevoerd!");
        $display("Return value a0 (x10) = %0d (Expected: 15)", dut.regfile_inst.regs[10]);
        $display("Stack pointer sp (x2) = 0x%08h (Expected: 0x00000100)", dut.regfile_inst.regs[2]);
        $display("Final PC              = 0x%08h", dut.pc_inst.pc_out);
        $display("--------------------------------------------------");

        $finish;
    end

endmodule