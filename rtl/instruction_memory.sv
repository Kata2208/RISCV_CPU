module instruction_memory (
    input  logic [31:0] addr,
    output logic [31:0] instruction
);

    logic [31:0] mem [0:63];

    initial begin
        // --- Setup registers ---
        mem[0] = 32'h00500093; // ADDI x1, x0, 5     (PC = 0x00) -> Counter = 5
        mem[1] = 32'h00000113; // ADDI x2, x0, 0     (PC = 0x04) -> Sum = 0
        mem[2] = 32'h00100193; // ADDI x3, x0, 1     (PC = 0x08) -> Decrement step = 1

        // --- LOOP starts at PC = 0x0C (mem[3]) ---
        mem[3] = 32'h00008863; // BEQ x1, x0, +16    (PC = 0x0C) -> If counter == 0, jump to END (PC = 0x1C)
        mem[4] = 32'h00110133; // ADD x2, x2, x1     (PC = 0x10) -> Sum = Sum + Counter
        mem[5] = 32'h403080b3; // SUB x1, x1, x3     (PC = 0x14) -> Counter = Counter - 1
        mem[6] = 32'hfe000ae3; // BEQ x0, x0, -12    (PC = 0x18) -> Always jump back to LOOP (PC = 0x0C)

        // --- END at PC = 0x1C (mem[7]) ---
        mem[7] = 32'h00000013; // NOP                (PC = 0x1C)

        for (int i = 8; i < 64; i++) begin
            mem[i] = 32'h00000013; // NOP
        end
    end

    assign instruction = mem[addr[7:2]];

endmodule
