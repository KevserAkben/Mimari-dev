// -----------------------------------------------------------------------------
// hafta9 icin testbench
// Beklenen sinifi da kontrol eder (PASS/FAIL) ve odevdeki tablo formatinda yazar.
// -----------------------------------------------------------------------------
`timescale 1ns/1ps

module test9;

    logic [31:0] data_i;
    logic        sign_o;
    logic [7:0]  exp_o;
    logic [22:0] frac_o;
    logic        is_zero_o, is_subnormal_o, is_normal_o, is_inf_o, is_nan_o;

    hafta9 dut (
        .data_i         (data_i),
        .sign_o         (sign_o),
        .exp_o          (exp_o),
        .frac_o         (frac_o),
        .is_zero_o      (is_zero_o),
        .is_subnormal_o (is_subnormal_o),
        .is_normal_o    (is_normal_o),
        .is_inf_o       (is_inf_o),
        .is_nan_o       (is_nan_o)
    );

    int errors = 0;

    // Bir test vektoru uygula, ciktiyi yazdir ve beklenenle karsilastir
    // exp_cls = {zero, subn, norm, inf, nan}
    task automatic run_test(input logic [31:0] val, input logic [4:0] exp_cls);
        logic [4:0] got;
        data_i = val;
        #10;
        got = {is_zero_o, is_subnormal_o, is_normal_o, is_inf_o, is_nan_o};
        $display("0x%08h | %b | %3d | %b    | %b    | %b    | %b   | %b   %s",
                 data_i, sign_o, exp_o,
                 is_zero_o, is_subnormal_o, is_normal_o, is_inf_o, is_nan_o,
                 (got === exp_cls) ? "" : "<-- HATA");
        if (got !== exp_cls) errors++;
    endtask

    initial begin
        $display("Hex Giris    | S | Exp | Zero | SubN | Norm | Inf | NaN");
        $display("-----------------------------------------------------------");

        //            deger          {Zero,SubN,Norm,Inf,NaN}
        run_test(32'h00000000, 5'b10000);  // +0
        run_test(32'h80000000, 5'b10000);  // -0
        run_test(32'h427d0000, 5'b00100);  // normal (63.25)
        run_test(32'hbfc00000, 5'b00100);  // normal (-1.5)
        run_test(32'h00000001, 5'b01000);  // subnormal (en kucuk)
        run_test(32'h7f800000, 5'b00010);  // +Inf
        run_test(32'hff800000, 5'b00010);  // -Inf
        run_test(32'h7fc00001, 5'b00001);  // NaN

        // Ek kenar durumlari
        run_test(32'h007fffff, 5'b01000);  // en buyuk subnormal
        run_test(32'h00800000, 5'b00100);  // en kucuk normal
        run_test(32'h7f7fffff, 5'b00100);  // en buyuk normal
        run_test(32'h7f800001, 5'b00001);  // sinyalli NaN
        run_test(32'hffffffff, 5'b00001);  // negatif NaN

        $display("-----------------------------------------------------------");
        if (errors == 0) $display("SONUC: TUM TESTLER BASARILI");
        else             $display("SONUC: %0d HATA", errors);
        $finish;
    end

endmodule
