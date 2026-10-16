module tb_decoder;

    logic [31:0] instruction;

    logic [4:0] rs1_addr;
    logic [4:0] rs2_addr;
    logic [4:0] rd_addr;

    logic [2:0] alu_op;

    decoder dut (
        .instruction(instruction),
        .rs1_addr(rs1_addr),
        .rs2_addr(rs2_addr),
        .rd_addr(rd_addr),
        .alu_op(alu_op)
    );

    initial begin

        // ADD x3, x1, x2
        instruction = {
            7'b0000000, // funct7
            5'd2,       // rs2
            5'd1,       // rs1
            3'b000,     // funct3
            5'd3,       // rd
            7'b0110011  // opcode
        };

        #1;

        assert(rs1_addr == 5'd1)
            else $error("rs1 decode failed");

        assert(rs2_addr == 5'd2)
            else $error("rs2 decode failed");

        assert(rd_addr == 5'd3)
            else $error("rd decode failed");

        assert(alu_op == 3'b000)
            else $error("ADD decode failed");

        $display("ADD test passed!");

        // SUB x4, x5, x6
        instruction = {
            7'b0100000, // funct7
            5'd6,       // rs2
            5'd5,       // rs1
            3'b000,     // funct3
            5'd4,       // rd
            7'b0110011  // opcode
        };

        #1;

        assert(rs1_addr == 5'd5)
            else $error("SUB rs1 decode failed");

        assert(rs2_addr == 5'd6)
            else $error("SUB rs2 decode failed");

        assert(rd_addr == 5'd4)
            else $error("SUB rd decode failed");

        assert(alu_op == 3'b001)
            else $error("SUB alu_op decode failed");

        $display("SUB test passed!");

        $display("All decoder tests passed!");

        $finish;

    end

endmodule
