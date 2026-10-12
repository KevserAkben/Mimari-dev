
module tb_mux4to1;

    logic [7:0] A, B, C, D;
    logic [1:0] sel;
    logic [7:0] Y;

    mux4to1 uut (
        .A(A),
        .B(B),
        .C(C),
        .D(D),
        .sel(sel),
        .Y(Y)
    );

    initial begin
        A = 8'd10;
        B = 8'd20;
        C = 8'd30;
        D = 8'd40;

        sel = 2'b00;
        #10;
        $display("sel=%b, Y=%d", sel, Y);
        if (Y !== A) $error("Test 1 failed");

        sel = 2'b01;
        #10;
        $display("sel=%b, Y=%d", sel, Y);
        if (Y !== B) $error("Test 2 failed");

        sel = 2'b10;
        #10;
        $display("sel=%b, Y=%d", sel, Y);
        if (Y !== C) $error("Test 3 failed");

        sel = 2'b11;
        #10;
        $display("sel=%b, Y=%d", sel, Y);
        if (Y !== D) $error("Test 4 failed");

        $display("Testler tamamlandi.");
        $finish;
    end

endmodule
