module Extend_1to32 (
    output wire [31:0] O,
    input  wire        I
);

assign O = {31'd0, I};
    
endmodule