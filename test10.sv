`timescale 1ns/1ps

module testbench;

    logic       tb_clk;
    logic       tb_rst;
    logic       tb_en;
    logic       tb_jump_en;
    logic [7:0] tb_jump_addr;
    logic [7:0] tb_pc;

    // tasarimi bagla
    program_counter dut (
        .clk       (tb_clk),
        .rst       (tb_rst),
        .en        (tb_en),
        .jump_en   (tb_jump_en),
        .jump_addr (tb_jump_addr),
        .pc        (tb_pc)
    );

    // 10 ns saat uretimi
    initial begin
        tb_clk = 1'b0;
        forever #5 tb_clk = ~tb_clk;
    end

    initial begin
        // EPWave icin kayit
        $dumpfile("dump.vcd");
        $dumpvars(0, testbench);

        $monitor("T=%0t ns -> rst:%b | en:%b | jump:%b | hedef:%0d || PC_CIKIS=%0d",
                 $time, tb_rst, tb_en, tb_jump_en, tb_jump_addr, tb_pc);

        // baslangic reset durumu (0 - 14 ns)
        tb_rst = 1; tb_en = 0; tb_jump_en = 0; tb_jump_addr = 8'd0;
        #14;

        // saymaya basla: 1, 2, 3, 4 olacak (14 - 50 ns)
        tb_rst = 0; tb_en = 1;
        #36;

        // duraklatma testi: 4'te sabit kalacak (50 - 70 ns)
        tb_en = 0;
        #20;

        // 45 adresine atlama yap (70 - 80 ns)
        tb_en = 1; tb_jump_en = 1; tb_jump_addr = 8'd45;
        #10;

        // 45'ten itibaren saymaya devam et: 46, 47 (80 - 100 ns)
        tb_jump_en = 0;
        #20;

        $finish;
    end

endmodule
