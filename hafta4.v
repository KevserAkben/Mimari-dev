
module adder4 (
    input  [3:0] A,
    input  [3:0] B,
    input        Cin,
    output [3:0] Sum,
    output       Cout
);

    assign {Cout, Sum} =
        {1'b0, A} + {1'b0, B} + Cin;

endmodule
