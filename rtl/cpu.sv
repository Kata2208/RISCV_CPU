module cpu (
    input logic clk,
    input logic reset
);

    // Program Counter
    logic [31:0] pc_out;

    // Decoder
    logic [2:0] opcode;
    logic [2:0] alu_op;

    // Register File
    logic        we;
    logic [4:0]  rs1_addr;
    logic [4:0]  rs2_addr;
    logic [4:0]  rd_addr;

    logic [31:0] rs1_data;
    logic [31:0] rs2_data;
    logic [31:0] rd_data;

    // ALU
    logic [31:0] alu_result;

    // ====================
    // Program Counter
    // ====================

    pc pc_inst (
        .clk(clk),
        .reset(reset),
        .pc_out(pc_out)
    );

    // ====================
    // Decoder
    // ====================

    decoder decoder_inst (
        .opcode(opcode),
        .alu_op(alu_op)
    );

    // ====================
    // Register File
    // ====================

    regfile regfile_inst (
        .clk(clk),
        .we(we),
        .rs1_addr(rs1_addr),
        .rs2_addr(rs2_addr),
        .rd_addr(rd_addr),
        .rd_data(rd_data),
        .rs1_data(rs1_data),
        .rs2_data(rs2_data)
    );

    // ====================
    // ALU
    // ====================

    alu alu_inst (
        .a(rs1_data),
        .b(rs2_data),
        .op(alu_op),
        .result(alu_result)
    );

    // ====================
    // Temporary test values
    // ====================

    we = 1;
    rd_addr = 1;
    rd_data = 5;

    rd_addr = 2;
    rd_data = 3;

    assign opcode   = 3'b000; // ADD

    assign we       = 1'b1;

    assign rs1_addr = 5'd1;
    assign rs2_addr = 5'd2;
    assign rd_addr  = 5'd3;

    assign rd_data  = alu_result;
    

endmodule
