module cpu (
    input  logic        clk,
    input  logic        reset,
    input  logic [31:0] instruction
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

    // Data Memory signals
    logic mem_we;
    logic mem_read;
    logic mem_to_reg;
    logic [31:0] mem_read_data;

    // ====================
    // Datapath glue
    // ====================

    // voorlopig enkel ALU instructions
    assign we         = 1'b1;
    assign mem_we     = 1'b0;
    assign mem_to_reg = 1'b0;

    assign alu_b = alu_src ? imm_out : rs2_data;

    // writeback mux
    assign rd_data = mem_to_reg
                   ? mem_read_data
                   : alu_result;

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
        .rs1_addr(rs1_addr),
        .rs2_addr(rs2_addr),
        .rd_addr(rd_addr),
        .alu_op(alu_op),
        .alu_src(alu_src)
    );

    imm_gen imm_gen_inst (
        .instruction(instruction),
        .imm_out(imm_out)
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

    data_memory dmem_inst (
        .clk(clk),
        .mem_write(mem_we),
        .mem_read(mem_read),
        .addr(alu_result),
        .write_data(rs2_data),
        .read_data(mem_read_data)
    );

endmodule
