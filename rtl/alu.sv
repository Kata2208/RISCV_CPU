module alu (
    input  logic [31:0] a,
    input  logic [31:0] b,
    input  logic [2:0]  op,
    output logic [31:0] result,
    output logic        zero
);

    always_comb begin
        case (op)
            3'b000:  result = a + b;                  // ADD / ADDI
            3'b001:  result = a - b;                  // SUB / BEQ comparison
            3'b010:  result = a & b;                  // AND
            3'b011:  result = a | b;                  // OR
            3'b100:  result = a ^ b;                  // XOR
            3'b101:  result = a << b[4:0];            // SLL
            3'b110:  result = a >> b[4:0];            // SRL
            default: result = 32'd0;
        endcase
    end

    // Zero flag: 1 if result is zero
    assign zero = (result == 32'd0);

endmodule
