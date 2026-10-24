module tb_imm_gen;

    logic [31:0] instruction;
    logic [31:0] imm_out;

    imm_gen dut (
        .instruction(instruction),
        .imm_out(imm_out)
    );

    initial begin
        // 1. Test positive I-type: ADDI x1, x0, 5
        instruction = 32'h00500093;
        #1;
        assert(imm_out == 32'd5)
            else $error("ImmGen Test 1 Failed! Expected 5, got %d", imm_out);

        // 2. Test negative I-type: ADDI x1, x0, -1
        instruction = 32'hfff00093;
        #1;
        assert($signed(imm_out) == -1)
            else $error("ImmGen Test 2 Failed! Expected -1, got %d", $signed(imm_out));

        // 3. Test S-type immediate: SW x2, 4(x1)
        instruction = 32'h0020a223;
        #1;
        assert(imm_out == 32'd4)
            else $error("ImmGen Test 3 (S-type) Failed! Expected 4, got %d", imm_out);

        // 4. Test B-type immediate: BEQ x1, x2, 8 -> Machine code: 0x00208463 (offset = +8)
        instruction = 32'h00208463;
        #1;
        assert(imm_out == 32'd8)
            else $error("ImmGen Test 4 (B-type) Failed! Expected 8, got %d", imm_out);

        $display("SUCCESS: All Immediate Generator unit tests passed!");
        $finish;
    end

endmodule
