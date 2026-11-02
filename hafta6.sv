module bir_bit_toplayici(
    input  logic x, y, c_in,
    output logic s, c_out
);
    assign s     = x ^ y ^ c_in;
    assign c_out = (x & y) | (c_in & (x ^ y));
endmodule

module toplayici_4bit (
    input  logic [3:0] in1, in2,
    input  logic c_giris,
    output logic [3:0] toplam,
    output logic c_cikis
);
    logic [2:0] ara_elde;

    bir_bit_toplayici fa0 (.x(in1[0]), .y(in2[0]), .c_in(c_giris),    .s(toplam[0]), .c_out(ara_elde[0]));
    bir_bit_toplayici fa1 (.x(in1[1]), .y(in2[1]), .c_in(ara_elde[0]), .s(toplam[1]), .c_out(ara_elde[1]));
    bir_bit_toplayici fa2 (.x(in1[2]), .y(in2[2]), .c_in(ara_elde[1]), .s(toplam[2]), .c_out(ara_elde[2]));
    bir_bit_toplayici fa3 (.x(in1[3]), .y(in2[3]), .c_in(ara_elde[2]), .s(toplam[3]), .c_out(c_cikis));
endmodule

module carpici_4bit(
    input  logic [3:0] a_in,
    input  logic [3:0] b_in,
    output logic [7:0] carpim_sonuc
);
    logic [3:0] satir0, satir1, satir2, satir3;
    
    logic [3:0] t1, t2, t3;
    logic e1, e2, e3;

    assign satir0 = a_in & {4{b_in[0]}};
    assign satir1 = a_in & {4{b_in[1]}};
    assign satir2 = a_in & {4{b_in[2]}};
    assign satir3 = a_in & {4{b_in[3]}};

    assign carpim_sonuc[0] = satir0[0];

    toplayici_4bit top1 (
        .in1({1'b0, satir0[3:1]}), 
        .in2(satir1), 
        .c_giris(1'b0), 
        .toplam(t1), 
        .c_cikis(e1)
    );
    assign carpim_sonuc[1] = t1[0];

    toplayici_4bit top2 (
        .in1({e1, t1[3:1]}), 
        .in2(satir2), 
        .c_giris(1'b0), 
        .toplam(t2), 
        .c_cikis(e2)
    );
    assign carpim_sonuc[2] = t2[0];

    toplayici_4bit top3 (
        .in1({e2, t2[3:1]}), 
        .in2(satir3), 
        .c_giris(1'b0), 
        .toplam(t3), 
        .c_cikis(e3)
    );
    assign carpim_sonuc[3] = t3[0];

    assign carpim_sonuc[7:4] = {e3, t3[3:1]};
endmodule"
