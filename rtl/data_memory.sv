module data_memory (
    input  logic        clk,
    input  logic        mem_write,
    input  logic        mem_read,
    input  logic [31:0] addr,
    input  logic [31:0] write_data,
    output logic [31:0] read_data
);

    // 64 words of 32-bit RAM (256 bytes total)
    logic [31:0] mem [0:63];

    // Initialize RAM with zeros
    initial begin
        for (int i = 0; i < 64; i++) begin
            mem[i] = 32'd0;
        end
    end

    // Synchronous Write on clock rising edge
    always_ff @(posedge clk) begin
        if (mem_write) begin
            mem[addr[7:2]] <= write_data; // 6-bit index (bits 7:2)
        end
    end

    // Combinational Read
    assign read_data = mem_read ? mem[addr[7:2]] : 32'd0; // 6-bit index (bits 7:2)

endmodule
