// Pega parte dos dados de Memory Data.

module MD_Control (
    output wire [31:0] O,
    input  wire [31:0] I,
    input  wire [1:0]  Selector
);

    assign O = (Selector == 2'b00) ?                I: // Word
               (Selector == 2'b01) ? {16'd0, I[15:0]}: // Halfword
               (Selector == 2'b10) ?  {24'd0, I[7:0]}: // Byte
                                                32'bx;

endmodule