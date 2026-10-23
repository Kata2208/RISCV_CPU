module instruction_memory (
    input  logic [31:0] addr,
    output logic [31:0] instruction
);

    logic [31:0] mem [0:63];

    initial begin
        mem[0] = 32'h00500093; // ADDI x1, x0, 5
        mem[1] = 32'h00300113; // ADDI x2, x0, 3
        mem[2] = 32'h002081B3; // ADD  x3, x1, x2 (x3 = 8)
        mem[3] = 32'h00302223; // SW   x3, 4(x0)  (RAM[4] = 8)
        mem[4] = 32'h00402203; // LW   x4, 4(x0)  (x4 = RAM[4] = 8)

        for (int i = 5; i < 64; i++) begin
            mem[i] = 32'h00000013; // NOP (ADDI x0, x0, 0)
        end
    end

    // 6-bit index (bits 7:2) om truncation warnings te voorkomen
    assign instruction = mem[addr[7:2]];

endmodule
