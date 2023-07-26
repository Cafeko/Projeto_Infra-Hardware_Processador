// MUX 4 para 1 usado como ALUSrcB.

module MUX_ALUSrcB (
    output wire [31:0] O,
    input  wire [31:0] I0,
    input  wire [31:0] I2,
    input  wire [31:0] I3,
    input  wire [1:0]  Select
);

assign O = (Select == 2'b00) ? I0:    // B
           (Select == 2'b01) ? 32'd4: // 4
           (Select == 2'b10) ? I2:    // Instrução [15-0] - extend 32
                               I3;    // Instrução [15-0] - extend 32 e shift left 2
    
endmodule
