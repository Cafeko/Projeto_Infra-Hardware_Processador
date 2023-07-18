module ShiftLeft2_32bits (
    output [31:0] O,
    input  [31:0] I
);

assign O = I << 2;

endmodule