module tb_pc;

logic clk;
logic reset;
logic [31:0] pc_out;

pc dut (
    .clk(clk),
    .reset(reset),
    .pc_out(pc_out)
);

// clock generation
initial begin
    clk = 0;
    forever #5 clk = ~clk;
end

initial begin

    reset = 1;

    #10;    // eerste klokflank

    assert(pc_out == 0)
        else $error("PC should be 0 after reset");

    reset = 0;

    #10;    // volgende klokflank

    assert(pc_out == 4)
        else $error("PC should be 4");

    #10;

    assert(pc_out == 8)
        else $error("PC should be 8");

    #10;

    assert(pc_out == 12)
        else $error("PC should be 12");

    $display("All tests passed!");

    $finish;
end

endmodule
