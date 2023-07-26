// MUX 8 para 1 usado como WriteDataSrc.

module MUX_WriteDataSrc (
    output wire [31:0] O,
    input  wire [31:0] I0,
    input  wire [31:0] I1,
    input  wire [31:0] I2,
    input  wire [31:0] I3,
    input  wire [31:0] I4,
    input  wire [31:0] I5,
    input  wire [31:0] I7,
    input  wire [2:0]  Select
);

assign O = (Select == 3'b000) ? I0:       // ALU Out Register
           (Select == 3'b001) ? I1:      // MD REgister + Control
           (Select == 3'b010) ? I2:      // Instrução [15-0] - shift left 16
           (Select == 3'b011) ? I3:      // Lo
           (Select == 3'b100) ? I4:      // Hi
           (Select == 3'b101) ? I5:      // Shift Register
           (Select == 3'b110) ? 32'd227: // 227
                                I7;      // LT - extend 32
    
endmodule
