module SignExtend_16to32 (
    output wire [31:0] O,
    input  wire [15:0] I
);

assign O = (I[15] == 1) ? {16'b1111111111111111, I[15:0]}:
                          {16'b0000000000000000, I[15:0]};
    
endmodule