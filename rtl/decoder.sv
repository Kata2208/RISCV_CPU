module decoder (
    input  logic [31:0] instruction,

    output logic [4:0] rs1_addr,
    output logic [4:0] rs2_addr,
    output logic [4:0] rd_addr,

    output logic [2:0] alu_op
);

    assign rs1_addr = instruction[19:15];
    assign rs2_addr = instruction[24:20];
    assign rd_addr  = instruction[11:7];

    always_comb begin

    case ({instruction[31:25], instruction[14:12]})

        {7'b0000000, 3'b000}: alu_op = 3'b000; // ADD

        {7'b0100000, 3'b000}: alu_op = 3'b001; // SUB

        {7'b0000000, 3'b111}: alu_op = 3'b010; // AND

        {7'b0000000, 3'b110}: alu_op = 3'b011; // OR

        {7'b0000000, 3'b100}: alu_op = 3'b100; // XOR

        {7'b0000000, 3'b001}: alu_op = 3'b101; // SLL

        {7'b0000000, 3'b101}: alu_op = 3'b110; // SRL

        default: alu_op = 3'b000;

    endcase

    end
endmodule
