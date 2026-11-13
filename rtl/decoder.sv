module decoder (
    input  logic [31:0] instruction,

    output logic [4:0]  rs1_addr,
    output logic [4:0]  rs2_addr,
    output logic [4:0]  rd_addr,

    output logic [2:0]  alu_op,
    output logic        alu_src,
    output logic        mem_read,
    output logic        mem_write,
    output logic [1:0]  result_src,
    output logic        reg_write,
    output logic        branch,
    output logic        jump,
    output logic        jalr
);

    logic [6:0] opcode;
    logic [2:0] funct3;
    logic [6:0] funct7;

    assign opcode   = instruction[6:0];
    assign funct3   = instruction[14:12];
    assign funct7   = instruction[31:25];

    assign rs1_addr = instruction[19:15];
    assign rs2_addr = instruction[24:20];
    assign rd_addr  = instruction[11:7];

    always_comb begin
        // Default control signals
        alu_op     = 3'b000;
        alu_src    = 1'b0; // 0 = rs2_data, 1 = imm_out
        mem_read   = 1'b0;
        mem_write  = 1'b0;
        result_src = 2'b00; // 00 = ALU, 01 = DMEM, 10 = PC + 4
        reg_write  = 1'b0;
        branch     = 1'b0;
        jump       = 1'b0;
        jalr       = 1'b0;

        case (opcode)
            // R-type instructions (ADD, SUB, AND, OR, XOR, SLL, SRL)
            7'b0110011: begin
                reg_write = 1'b1;
                alu_src   = 1'b0;
                case ({funct7, funct3})
                    {7'b0000000, 3'b000}: alu_op = 3'b000; // ADD
                    {7'b0100000, 3'b000}: alu_op = 3'b001; // SUB
                    {7'b0000000, 3'b111}: alu_op = 3'b010; // AND
                    {7'b0000000, 3'b110}: alu_op = 3'b011; // OR
                    {7'b0000000, 3'b100}: alu_op = 3'b100; // XOR
                    {7'b0000000, 3'b001}: alu_op = 3'b101; // SLL
                    {7'b0000000, 3'b101}: alu_op = 3'b110; // SRL
                    default:              alu_op = 3'b000;
                endcase
            end

            // I-type ALU instructions (ADDI)
            7'b0010011: begin
                reg_write = 1'b1;
                alu_src   = 1'b1;
                case (funct3)
                    3'b000:  alu_op = 3'b000; // ADDI
                    default: alu_op = 3'b000;
                endcase
            end

            // I-type Load instruction (LW)
            7'b0000011: begin
                reg_write  = 1'b1;
                alu_src    = 1'b1;
                alu_op     = 3'b000;
                mem_read   = 1'b1;
                result_src = 2'b01;   // write-back = DMEM
            end

            // S-type Store instruction (SW)
            7'b0100011: begin
                reg_write  = 1'b0;
                alu_src    = 1'b1;
                alu_op     = 3'b000;
                mem_write  = 1'b1;
            end

            // B-type Branch instructions (BEQ)
            7'b1100011: begin
                reg_write  = 1'b0;    // Do not write to regfile
                alu_src    = 1'b0;    // Compare rs1 and rs2
                alu_op     = 3'b001;  // SUB (rs1 - rs2) to test equality
                branch     = 1'b1;    // Enable branch control
            end

            // J-type Jump instruction (JAL)
            7'b1101111: begin
                reg_write  = 1'b1;    // rd = PC + 4
                result_src = 2'b10;   // write-back = PC + 4
                jump       = 1'b1;    // always taken, target = PC + imm
            end

            // I-type Jump instruction (JALR)
            7'b1100111: begin
                reg_write  = 1'b1;    // rd = PC + 4
                alu_src    = 1'b1;    // ALU: rs1 + imm
                alu_op     = 3'b000;  // ADD
                result_src = 2'b10;   // write-back = PC + 4
                jump       = 1'b1;
                jalr       = 1'b1;    // target = ALU result (bit 0 gewist)
            end

            default: begin
                alu_op     = 3'b000;
                alu_src    = 1'b0;
                mem_read   = 1'b0;
                mem_write  = 1'b0;
                result_src = 2'b00;
                reg_write  = 1'b0;
                branch     = 1'b0;
                jump       = 1'b0;
                jalr       = 1'b0;
            end
        endcase
    end

endmodule