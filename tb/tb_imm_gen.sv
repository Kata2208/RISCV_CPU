module tb_imm_gen;

    logic [31:0] instruction;
    logic [31:0] imm_out;

    // Instantiate Immediate Generator
    imm_gen dut (
        .instruction(instruction),
        .imm_out(imm_out)
    );

    initial begin
        // 1. Test positive I-type immediate: ADDI x1, x0, 5
        instruction = 32'h00500093; // imm = 5
        #1;
        assert(imm_out == 32'd5)
            else $error("ImmGen Test 1 Failed! Expected 5, got %d", imm_out);

        // 2. Test negative I-type immediate: ADDI x1, x0, -1
        instruction = 32'hfff00093; // imm = -1 (12 bits 0xFFF -> extended to 32-bit 0xFFFFFFFF)
        #1;
        assert($signed(imm_out) == -1)
            else $error("ImmGen Test 2 Failed! Expected -1, got %d", $signed(imm_out));

        // 3. Test positive I-type immediate: ADDI x2, x0, 100
        instruction = 32'h06400093; // imm = 100
        #1;
        assert(imm_out == 32'd100)
            else $error("ImmGen Test 3 Failed! Expected 100, got %d", imm_out);

        $display("SUCCESS: All Immediate Generator unit tests passed!");
        $finish;
    end

endmodule
