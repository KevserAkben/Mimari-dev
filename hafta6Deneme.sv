"module tb_carpici();

logic [3:0] test_a;
logic [3:0] test_b;
logic [7:0] test_sonuc;

carpici_4bit uut (
    .a_in(test_a),
    .b_in(test_b),
    .carpim_sonuc(test_sonuc)
);

initial begin
    $monitor("Simulasyon Zamani=%0t | Sayi 1=%d, Sayi 2=%d => Sonuc=%d", $time, test_a, test_b, test_sonuc);

    test_a = 4'd3;  test_b = 4'd4;  #10; // 3 x 4 = 12
    test_a = 4'd7;  test_b = 4'd5;  #10; // 7 x 5 = 35
    test_a = 4'd12; test_b = 4'd10; #10; // 12 x 10 = 120
    test_a = 4'd15; test_b = 4'd15; #10; // 15 x 15 = 225 

    $finish;
end

endmodule"
