// MUX De 2 entradas e uma saida de 32bits.

module MUX_2to1 (
    output wire [31:0] O,
    input  wire [31:0] I0,
    input  wire [31:0] I1,
    input  wire        Select
);

assign O = (Select == 1'b0) ? I0: I1;
    
endmodule
