// Faz shift e extende a entrada de 26 para 28 bits, usado para formar o jump address.

module ShiftLeft_26to28 (
    output wire [27:0] O,
    input  wire [25:0] I
);

assign O = {I[25:0], 2'b00};
    
endmodule