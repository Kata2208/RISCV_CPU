module pc_monitor #(
    parameter string FILE = "funcs.txt",
    parameter int    MAXF = 256
)(
    input logic        clk,
    input logic        rst,
    input logic [31:0] pc
);
    logic [31:0] f_start [MAXF];
    logic [31:0] f_size  [MAXF];
    string       f_name  [MAXF];
    int          nf = 0;
    int          last_idx = -2;

    // tabel inladen bij t=0
    initial begin
        int fd;
        logic [31:0] a, s;
        string n;
        fd = $fopen(FILE, "r");
        if (fd == 0) $fatal(1, "monitor: kan %s niet openen", FILE);
        while ($fscanf(fd, "%h %h %s", a, s, n) == 3 && nf < MAXF) begin
            f_start[nf] = a;
            f_size[nf]  = s;
            f_name[nf]  = n;
            nf++;
        end
        $fclose(fd);
        $display("monitor: %0d functies geladen", nf);
    end

    // lookup: a_f <= pc < a_f + s_f  (-1 = onbekend)
    function automatic int lookup(input logic [31:0] p);
        for (int i = 0; i < nf; i++)
            if (p >= f_start[i] && p < f_start[i] + f_size[i]) return i;
        return -1;
    endfunction

    // bij elke klokflank: kijk mee, print enkel bij functiewissel
    always @(posedge clk) if (!rst) begin
        automatic int idx = lookup(pc);
        if (idx != last_idx) begin
            if (idx >= 0) $display("[%0t] PC=0x%08h -> %s", $time, pc, f_name[idx]);
            else          $display("[%0t] PC=0x%08h -> <unknown>", $time, pc);
            last_idx = idx;
        end
    end
endmodule
