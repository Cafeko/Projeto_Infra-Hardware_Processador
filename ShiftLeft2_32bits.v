module ShiftLeft2_32bits (
    output wire [31:0] O,
    input  wire [31:0] I
);

assign O = I << 2;

endmodule