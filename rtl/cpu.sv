module cpu (
    input logic clk,
    input logic reset
);

    // Program Counter signals
    logic [31:0] pc_out;
    logic [31:0] pc_plus_4;
    logic [31:0] pc_branch;
    logic [31:0] next_pc;
    logic        pc_src;

    // Instruction Memory signal
    logic [31:0] instruction;

    // Decoder outputs
    logic [2:0]  alu_op;
    logic        alu_src;
    logic        mem_read;
    logic        mem_write;
    logic        mem_to_reg;
    logic        reg_write;
    logic        branch;
    logic [4:0]  rs1_addr;
    logic [4:0]  rs2_addr;
    logic [4:0]  rd_addr;

    // Immediate Generator output
    logic [31:0] imm_out;

    // Register File signals
    logic [31:0] rs1_data;
    logic [31:0] rs2_data;
    logic [31:0] rd_data;

    // ALU signals
    logic [31:0] alu_b;
    logic [31:0] alu_result;
    logic        zero;

    // Data Memory output
    logic [31:0] ram_read_data;

    // Control & Datapath Logic
    assign pc_plus_4 = pc_out + 32'd4;
    assign pc_branch = pc_out + imm_out;
    assign pc_src    = branch & zero;
    assign next_pc   = pc_src ? pc_branch : pc_plus_4;

    assign alu_b     = alu_src ? imm_out : rs2_data;
    assign rd_data   = mem_to_reg ? ram_read_data : alu_result;

    // ====================
    // Module Instantiations
    // ====================

    pc pc_inst (
        .clk(clk),
        .reset(reset),
        .next_pc(next_pc),
        .pc_out(pc_out)
    );

    instruction_memory imem_inst (
        .addr(pc_out),
        .instruction(instruction)
    );

    decoder decoder_inst (
        .instruction(instruction),
        .rs1_addr   (rs1_addr),
        .rs2_addr   (rs2_addr),
        .rd_addr    (rd_addr),
        .alu_op     (alu_op),
        .alu_src    (alu_src),
        .mem_read   (mem_read),
        .mem_write  (mem_write),
        .mem_to_reg (mem_to_reg),
        .reg_write  (reg_write),
        .branch     (branch)
    );

    imm_gen imm_gen_inst (
        .instruction(instruction),
        .imm_out    (imm_out)
    );

    regfile regfile_inst (
        .clk(clk),
        .we(reg_write),
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
        .result(alu_result),
        .zero(zero)
    );

    data_memory dmem_inst (
        .clk(clk),
        .mem_write(mem_write),
        .mem_read(mem_read),
        .addr(alu_result),
        .write_data(rs2_data),
        .read_data(ram_read_data)
    );

endmodule
