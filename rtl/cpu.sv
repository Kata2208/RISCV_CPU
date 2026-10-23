module cpu (
    input logic clk,
    input logic reset
);

    // Program Counter
    logic [31:0] pc_out;

    // Instruction Memory
    logic [31:0] instruction;

    // Decoder outputs
    logic [2:0]  alu_op;
    logic        alu_src;
    logic        mem_read;
    logic        mem_write;
    logic        mem_to_reg;
    logic        reg_write;
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

    // Data Memory output
    logic [31:0] ram_read_data;

    // Control & Datapath Glue
    assign alu_b   = alu_src ? imm_out : rs2_data;                  // Mux ALU Ingang B
    assign rd_data = mem_to_reg ? ram_read_data : alu_result;      // Mux Writeback Data

    // ====================
    // Module Instantiations
    // ====================

    pc pc_inst (
        .clk(clk),
        .reset(reset),
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
        .reg_write  (reg_write)
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
        .result(alu_result)
    );

    data_memory dmem_inst (
        .clk(clk),
        .mem_write(mem_write),
        .mem_read(mem_read),
        .addr(alu_result),      // Adres komt uit de ALU (rs1 + offset)
        .write_data(rs2_data),  // SW schrijft de inhoud van rs2
        .read_data(ram_read_data)
    );

endmodule
