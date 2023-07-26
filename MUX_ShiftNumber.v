// MUX do numero de shift do registrador.
module MUX_ShiftNumber (
    output wire [4:0] O,
    input  wire [4:0] I0,
    input  wire [4:0] I1,
    input  wire       Select
);

assign O = (Select == 1'b0) ? I0: // Instrução [10-6]
                              I1; // B [4-0]
    
endmodule