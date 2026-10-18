
`timescale 1ns/1ps

module tb_adder4;

    reg  [3:0] A;
    reg  [3:0] B;
    reg        Cin;
    wire [3:0] Sum;
    wire       Cout;

    integer i, j, k;
    integer expected;
    integer test_count;
    integer error_count;

    adder4 uut (
        .A(A),
        .B(B),
        .Cin(Cin),
        .Sum(Sum),
        .Cout(Cout)
    );

    initial begin
        test_count = 0;
        error_count = 0;

        for (i = 0; i < 16; i = i + 1) begin
            for (j = 0; j < 16; j = j + 1) begin
                for (k = 0; k < 2; k = k + 1) begin
                    A = i;
                    B = j;
                    Cin = k;

                    #10;
                    expected = i + j + k;
                    test_count = test_count + 1;

                    if ({Cout, Sum} !== expected) begin
                        error_count = error_count + 1;
                        $display(
                            "HATA: A=%d B=%d Cin=%d",
                            A, B, Cin
                        );
                        $display(
                            "Beklenen=%d, Gelen=%d",
                            expected, {Cout, Sum}
                        );
                    end
                end
            end
        end

        $display("Toplam test: %d", test_count);
        $display("Hata sayisi: %d", error_count);

        if (error_count == 0)
            $display("SONUC: BUTUN TESTLER BASARILI");
        else
            $display("SONUC: BAZI TESTLER BASARISIZ");

        $finish;
    end

endmodule
