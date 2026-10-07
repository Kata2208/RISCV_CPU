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

    logic [31:0] regs [31:0];

    // Write port
    always_ff @(posedge clk) begin
        if (we && rd_addr != 0)
            regs[rd_addr] <= rd_data;
    end

    // Read ports
    assign rs1_data = regs[rs1_addr];
    assign rs2_data = regs[rs2_addr];

endmodule
