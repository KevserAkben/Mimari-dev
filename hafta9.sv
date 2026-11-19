// -----------------------------------------------------------------------------
// 32-bit IEEE 754 (single precision) bit cozumleyici ve ozel durum tespit devresi
//
// Format: [31] isaret | [30:23] us (exponent) | [22:0] kesir (mantissa)
//
// Sinif tablosu:
//   Zero      : exp = 8'h00, frac == 0
//   Subnormal : exp = 8'h00, frac != 0
//   Normal    : exp = 8'h01 .. 8'hFE
//   Infinity  : exp = 8'hFF, frac == 0
//   NaN       : exp = 8'hFF, frac != 0
// -----------------------------------------------------------------------------
module hafta9 (
    input  logic [31:0] data_i,      // 32-bit IEEE 754 girisi

    // Cozumlenen alanlar
    output logic        sign_o,      // isaret biti
    output logic [7:0]  exp_o,       // us (biased exponent)
    output logic [22:0] frac_o,      // kesir / mantissa

    // Ozel durum / sinif bayraklari (one-hot: ayni anda yalnizca biri 1)
    output logic        is_zero_o,
    output logic        is_subnormal_o,
    output logic        is_normal_o,
    output logic        is_inf_o,
    output logic        is_nan_o
);

    // ---- Bit cozumleme ------------------------------------------------------
    assign sign_o = data_i[31];
    assign exp_o  = data_i[30:23];
    assign frac_o = data_i[22:0];

    // ---- Yardimci kosullar --------------------------------------------------
    logic exp_all_zeros, exp_all_ones, frac_zero;

    assign exp_all_zeros = (exp_o  == 8'h00);
    assign exp_all_ones  = (exp_o  == 8'hFF);
    assign frac_zero     = (frac_o == 23'd0);

    // ---- Ozel durum tespiti -------------------------------------------------
    assign is_zero_o      = exp_all_zeros &  frac_zero;
    assign is_subnormal_o = exp_all_zeros & ~frac_zero;
    assign is_inf_o       = exp_all_ones  &  frac_zero;
    assign is_nan_o       = exp_all_ones  & ~frac_zero;
    assign is_normal_o    = ~exp_all_zeros & ~exp_all_ones;  // 8'h01 - 8'hFE

endmodule
