module instruction_memory (
    input  logic [31:0] addr,
    output logic [31:0] instruction
);

    logic [31:0] mem [0:63];

    initial begin
        mem[0] = 32'h00500093; // ADDI x1, x0, 5     (PC = 0x00)
        mem[1] = 32'h00300113; // ADDI x2, x0, 3     (PC = 0x04)
        mem[2] = 32'h00208463; // BEQ  x1, x2, +8    (PC = 0x08) -> Branch NOT taken
        mem[3] = 32'h00500113; // ADDI x2, x0, 5     (PC = 0x0C)
        mem[4] = 32'h00208463; // BEQ  x1, x2, +8    (PC = 0x10) -> Branch TAKEN! Target = 0x18 (mem[6])
        mem[5] = 32'h06300193; // ADDI x3, x0, 99    (PC = 0x14) -> SHOULD BE SKIPPED
        mem[6] = 32'h02a00193; // ADDI x3, x0, 42    (PC = 0x18) -> Executed! x3 = 42

        for (int i = 7; i < 64; i++) begin
            mem[i] = 32'h00000013; // NOP
        end
    end

    assign instruction = mem[addr[7:2]];

endmodule
