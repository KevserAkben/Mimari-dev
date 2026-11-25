// 8-bit register tanimi
module register_8bit (
    input  logic       clk,
    input  logic       rst,
    input  logic       en,
    input  logic [7:0] d,
    output logic [7:0] q
);
    always_ff @(posedge clk or posedge rst) begin
        if (rst == 1'b1) begin
            q <= 8'h00; // asenkron sifirlama
        end
        else if (en == 1'b1) begin
            q <= d;     // yeni degeri yaz
        end
    end
endmodule

// Program Sayaci modulu
module program_counter (
    input  logic       clk,
    input  logic       rst,
    input  logic       en,
    input  logic       jump_en,
    input  logic [7:0] jump_addr,
    output logic [7:0] pc
);
    logic [7:0] sonraki_pc;

    // jump aktifse hedef adresi, degilse bir sonraki adresi sec
    assign sonraki_pc = (jump_en) ? jump_addr : (8'd1 + pc);

    // register modulunu cagir
    register_8bit reg_birimi (
        .clk (clk),
        .rst (rst),
        .en  (en),
        .d   (sonraki_pc),
        .q   (pc)
    );
endmodule
