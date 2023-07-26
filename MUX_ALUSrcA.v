// MUX 3 para 1 usado como ALUSrcA.

module MUX_ALUSrcA (
    output wire [31:0] O,
    input  wire [31:0] I0,
    input  wire [31:0] I1,
    input  wire [31:0] I2,
    input  wire [1:0]  Select
);

assign O = (Select == 2'b00) ? I0: // PC
           (Select == 2'b01) ? I1: // A
           (Select == 2'b10) ? I2: // MD Register
                            32'bx;
    
endmodule
