module imm_gen (
    input  logic [31:0] instruction,
    output logic [31:0] imm_out
);

    always_comb begin
        // Sign-extend I-type immediate (bits [31:20]) to 32 bits
        imm_out = {{20{instruction[31]}}, instruction[31:20]};
    end

endmodule
