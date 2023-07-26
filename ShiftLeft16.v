// Faz shift e extende a entrada de 16 para 32 bits.

module ShiftLeft16 (
    output wire [31:0] O,
    input  wire [15:0] I
);

assign O = {I[15:0], 16'd0};

endmodule