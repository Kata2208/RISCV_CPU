module decoder (
    input  logic [31:0] instruction,

    output logic [4:0]  rs1_addr,
    output logic [4:0]  rs2_addr,
    output logic [4:0]  rd_addr,

    output logic [2:0]  alu_op,
    output logic        alu_src,
    output logic        mem_read,
    output logic        mem_write,
    output logic        mem_to_reg,
    output logic        reg_write
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
        // Standaardwaarden (Default control signals)
        alu_op     = 3'b000;
        alu_src    = 1'b0; // 0 = rs2_data, 1 = imm_out
        mem_read   = 1'b0;
        mem_write  = 1'b0;
        mem_to_reg = 1'b0; // 0 = ALU result, 1 = RAM read_data
        reg_write  = 1'b0;

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
                alu_src    = 1'b1;    // Gebruik immediate offset
                alu_op     = 3'b000;  // ALU berekent adres: rs1 + offset
                mem_read   = 1'b1;    // Lees uit RAM
                mem_to_reg = 1'b1;    // Schrijf RAM data naar Register File
            end

            // S-type Store instruction (SW)
            7'b0100011: begin
                reg_write  = 1'b0;    // Schrijf NIETS naar Register File!
                alu_src    = 1'b1;    // Gebruik immediate offset
                alu_op     = 3'b000;  // ALU berekent adres: rs1 + offset
                mem_write  = 1'b1;    // Schrijf naar RAM
            end

            default: begin
                alu_op     = 3'b000;
                alu_src    = 1'b0;
                mem_read   = 1'b0;
                mem_write  = 1'b0;
                mem_to_reg = 1'b0;
                reg_write  = 1'b0;
            end
        endcase
    end

endmodule
