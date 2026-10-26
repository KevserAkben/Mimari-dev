`timescale 1ns/1ps

module tb_alu_4bit;

    logic [3:0] A;
    logic [3:0] B;
    logic [1:0] sel;
    logic [4:0] result;

    alu_4bit dut (
        .A(A),
        .B(B),
        .sel(sel),
        .result(result)
    );

    initial begin
        $monitor(
            "t=%0t A=%h B=%h sel=%b result=%b",
            $time, A, B, sel, result
        );

        // toplama
        A = 4'd7; B = 4'd5; sel = 2'b00;
        #10;

        A = 4'd15; B = 4'd1; sel = 2'b00;
        #10;

        // and
        A = 4'b1100; B = 4'b1010; sel = 2'b01;
        #10;

        // or
        A = 4'b1100; B = 4'b1010; sel = 2'b10;
        #10;

        // cikarma
        A = 4'd9; B = 4'd4; sel = 2'b11;
        #10;

        A = 4'd3; B = 4'd7; sel = 2'b11;
        #10;

        $finish;
    end

endmodule
