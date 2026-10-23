module tb_data_memory;

    logic        clk;
    logic        mem_write;
    logic        mem_read;
    logic [31:0] addr;
    logic [31:0] write_data;
    logic [31:0] read_data;

    // Instantiate Data Memory
    data_memory dut (
        .clk(clk),
        .mem_write(mem_write),
        .mem_read(mem_read),
        .addr(addr),
        .write_data(write_data),
        .read_data(read_data)
    );

    // Clock generation (10ns period)
    initial begin
        clk = 0;
        forever #5 clk = ~clk;
    end

    initial begin
        // Initial control signals
        mem_write  = 0;
        mem_read   = 0;
        addr       = 32'd0;
        write_data = 32'd0;
        #10;

        // Test 1: Write 0xDEADBEEF to address 0x04 (word index 1)
        mem_write  = 1;
        addr       = 32'h00000004;
        write_data = 32'hDEADBEEF;
        #10; // Trigger posedge clk write

        mem_write  = 0;

        // Test 2: Read back from address 0x04
        mem_read   = 1;
        #1;
        assert(read_data == 32'hDEADBEEF)
            else $error("RAM Test Failed! Expected 0xDEADBEEF, got 0x%08h", read_data);

        $display("SUCCESS: Data Memory unit test passed!");
        $finish;
    end

endmodule
