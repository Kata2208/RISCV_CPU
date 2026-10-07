module tb_regfile;

    logic        clk;
    logic        we;

    logic [4:0]  rs1_addr;
    logic [4:0]  rs2_addr;
    logic [4:0]  rd_addr;

    logic [31:0] rd_data;

    logic [31:0] rs1_data;
    logic [31:0] rs2_data;

    regfile dut (
        .clk(clk),
        .we(we),
        .rs1_addr(rs1_addr),
        .rs2_addr(rs2_addr),
        .rd_addr(rd_addr),
        .rd_data(rd_data),
        .rs1_data(rs1_data),
        .rs2_data(rs2_data)
    );

    // Clock generation
    initial begin
        clk = 0;
        forever #5 clk = ~clk;
    end

    initial begin

        // Initial values
        we = 0;
        rs1_addr = 0;
        rs2_addr = 0;
        rd_addr = 0;
        rd_data = 0;

        #10;

        // Write 123 to x5
        we = 1;
        rd_addr = 5;
        rd_data = 123;

        #10;

        we = 0;

        // Read x5
        rs1_addr = 5;

        #1;
        assert(rs1_data == 123)
            else $error("x5 should contain 123");

        // Write 42 to x10
        we = 1;
        rd_addr = 10;
        rd_data = 42;

        #10;

        we = 0;

        // Read x5 and x10
        rs1_addr = 5;
        rs2_addr = 10;

        #1;

        assert(rs1_data == 123)
            else $error("x5 should contain 123");

        assert(rs2_data == 42)
            else $error("x10 should contain 42");

        $display("All tests passed!");

        $finish;
    end

endmodule
