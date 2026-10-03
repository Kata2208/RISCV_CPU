module tb_alu;

logic [31:0] a;
logic [31:0] b;
logic [2:0] op;
logic [31:0] result;

alu dut (
    .a(a),
    .b(b),
    .op(op),
    .result(result)
);

initial begin

    a = 5;
    b = 3;

    op = 3'b000;
    #1;
    $display("ADD = %0d", result);

    op = 3'b001;
    #1;
    $display("SUB = %0d", result);

    op = 3'b010;
    #1;
    $display("AND = %0d", result);

    op = 3'b011;
    #1;
    $display("OR  = %0d", result);

    op = 3'b100;
    #1;
    $display("XOR = %0d", result);

    $finish;
end

endmodule
``
