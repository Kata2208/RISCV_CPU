module regfile (
    input  logic        clk,
    input  logic        we,

    input  logic [4:0]  rs1_addr,
    input  logic [4:0]  rs2_addr,
    input  logic [4:0]  rd_addr,

    input  logic [31:0] rd_data,

    output logic [31:0] rs1_data,
    output logic [31:0] rs2_data
);

    // 32 registers, 32-bits wide
    logic [31:0] regs [31:0];

    // --------------------------------------------------------
    // PHASE 1 VERIFICATION: Temporary Initialization
    // --------------------------------------------------------
    initial begin
        // Zero out all registers to prevent 'X' (unknown) states in simulation
        for (int i = 0; i < 32; i++) begin
            regs[i] = 32'd0;
        end
    end

    // --------------------------------------------------------
    // Write Port (Synchronous)
    // --------------------------------------------------------
    always_ff @(posedge clk) begin
        // Write if write-enable is high AND destination is not x0
        if (we && rd_addr != 5'd0) begin
            regs[rd_addr] <= rd_data;
        end
    end

    // --------------------------------------------------------
    // Read Ports (Asynchronous / Combinational)
    // --------------------------------------------------------
    // Ensure x0 always reads as 0, bypassing the memory array entirely
    assign rs1_data = (rs1_addr == 5'd0) ? 32'd0 : regs[rs1_addr];
    assign rs2_data = (rs2_addr == 5'd0) ? 32'd0 : regs[rs2_addr];

endmodule
