module WD_Control (
    output wire [31:0] O,
    input  wire [31:0] I,
    input  wire [31:0] Data,
    input  wire [1:0]  Selector
);

    assign O = (Selector == 2'b00) ?                      I:
               (Selector == 2'b01) ? {Data[31:16], I[15:0]}:
               (Selector == 2'b10) ?   {Data[31:8], I[7:0]}:
                                                      32'bx;

endmodule