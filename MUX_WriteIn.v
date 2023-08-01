// MUX para o Write data do banco de registradores.

module MUX_WriteIn (
    output wire [4:0] O,
    input  wire [4:0] I0,
    input  wire [15:0] I1,
    input  wire [1:0] Select
);

assign O = (Select == 2'b00) ? I0:    // Instrução [20-16]
           (Select == 2'b01) ? I1[15:11]:    // Instrução [15-11]
           (Select == 2'b10) ? 5'd29: // Registrador sp(Stack Pointer)
                               5'd31; // Registrador ra(Return address)
    
endmodule