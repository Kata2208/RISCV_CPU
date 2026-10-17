module cpu (
    input logic        clk,
    input logic        reset,
    input logic [31:0] instruction
);

    // Program Counter
    logic [31:0] pc_out;

    // Decoder outputs
    logic [2:0]  alu_op;
    logic        alu_src;
    logic [4:0]  rs1_addr;
    logic [4:0]  rs2_addr;
    logic [4:0]  rd_addr;

    // Immediate Generator output
    logic [31:0] imm_out;

    // Register File signals
    logic        we;
    logic [31:0] rs1_data;
    logic [31:0] rs2_data;
    logic [31:0] rd_data;

    // ALU signals
    logic [31:0] alu_b;
    logic [31:0] alu_result;

    // Control & Datapath Glue
    assign we      = 1'b1;                         // Always write for ALU instructions
    assign alu_b   = alu_src ? imm_out : rs2_data; // Mux: selects between rs2 and immediate
    assign rd_data = alu_result;                   // Write ALU result back to regfile

    // ====================
    // Module Instantiations
    // ====================

    pc pc_inst (
        .clk(clk),
        .reset(reset),
        .pc_out(pc_out)
    );

    decoder decoder_inst (
        .instruction(instruction),
        .rs1_addr   (rs1_addr),
        .rs2_addr   (rs2_addr),
        .rd_addr    (rd_addr),
        .alu_op     (alu_op),
        .alu_src    (alu_src)
    );

    imm_gen imm_gen_inst (
        .instruction(instruction),
        .imm_out    (imm_out)
    );

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

    alu alu_inst (
        .a(rs1_data),
        .b(alu_b),
        .op(alu_op),
        .result(alu_result)
    );

endmodule
