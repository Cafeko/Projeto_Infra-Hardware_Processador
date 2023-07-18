module ShiftLeft16 (
    output wire [31:0] O,
    input  wire [15:0] I
);

assign O = {I[15:0], 16'd0};

endmodule