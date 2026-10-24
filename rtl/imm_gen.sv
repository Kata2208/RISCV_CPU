module imm_gen (
    input  logic [31:0] instruction,
    output logic [31:0] imm_out
);

    logic [6:0] opcode;
    assign opcode = instruction[6:0];

    always_comb begin
        case (opcode)
            // I-type (ADDI, LW)
            7'b0010011, 
            7'b0000011: begin
                imm_out = {{20{instruction[31]}}, instruction[31:20]};
            end

            // S-type (SW)
            7'b0100011: begin
                imm_out = {{20{instruction[31]}}, instruction[31:25], instruction[11:7]};
            end

            // B-type (BEQ, BNE)
            7'b1100011: begin
                imm_out = {{19{instruction[31]}}, instruction[31], instruction[7], instruction[30:25], instruction[11:8], 1'b0};
            end

            default: begin
                imm_out = 32'd0;
            end
        endcase
    end

endmodule
