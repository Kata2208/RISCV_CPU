module decoder (
    input  logic [2:0] opcode,
    output logic [2:0] alu_op
);

    always_comb begin

        case (opcode)

            3'b000: alu_op = 3'b000; // ADD
            3'b001: alu_op = 3'b001; // SUB
            3'b010: alu_op = 3'b010; // AND
            3'b011: alu_op = 3'b011; // OR
            3'b100: alu_op = 3'b100; // XOR
            3'b101: alu_op = 3'b101; // SLL
            3'b110: alu_op = 3'b110; // SRL

            default: alu_op = 3'b000;

        endcase

    end

endmodule
