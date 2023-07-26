// Extende de 1bit para 32bits.

module Extend_1to32 (
    output wire [31:0] O,
    input  wire        I
);

assign O = {31'd0, I};
    
endmodule