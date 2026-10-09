module tb_decoder;

    logic [2:0] opcode;
    logic [2:0] alu_op;

    decoder dut (
        .opcode(opcode),
        .alu_op(alu_op)
    );

    initial begin

        opcode = 3'b000;
        #1;
        assert(alu_op == 3'b000)
            else $error("ADD decode failed");

        opcode = 3'b001;
        #1;
        assert(alu_op == 3'b001)
            else $error("SUB decode failed");

        opcode = 3'b010;
        #1;
        assert(alu_op == 3'b010)
            else $error("AND decode failed");

        opcode = 3'b011;
        #1;
        assert(alu_op == 3'b011)
            else $error("OR decode failed");

        opcode = 3'b100;
        #1;
        assert(alu_op == 3'b100)
            else $error("XOR decode failed");

        opcode = 3'b101;
        #1;
        assert(alu_op == 3'b101)
            else $error("SLL decode failed");

        opcode = 3'b110;
        #1;
        assert(alu_op == 3'b110)
            else $error("SRL decode failed");

        $display("All tests passed!");

        $finish;

    end

endmodule
