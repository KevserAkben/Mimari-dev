
module mux4to1 (
    input  logic [7:0] A,
    input  logic [7:0] B,
    input  logic [7:0] C,
    input  logic [7:0] D,
    input  logic [1:0] sel,
    output logic [7:0] Y
);

    always_comb begin
        case (sel)
            2'b00: Y = A;
            2'b01: Y = B;
            2'b10: Y = C;
            2'b11: Y = D;
            default: Y = 8'b00000000;
        endcase
    end

endmodule
