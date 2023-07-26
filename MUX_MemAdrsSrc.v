// // MUX 7 para 1 usado como MemAdrsSrc.

module MUX_MemAdrsSrc (
    output wire [31:0] O,
    input  wire [31:0] I0,
    input  wire [31:0] I1,
    input  wire [31:0] I5,
    input  wire [31:0] I6,
    input  wire [2:0]  Select
);

assign O = (Select == 3'b000) ? I0:      // PC
           (Select == 3'b001) ? I1:      // ALU Out Register
           (Select == 3'b010) ? 32'd253: // 253
           (Select == 3'b011) ? 32'd254: // 254
           (Select == 3'b100) ? 32'd255: // 255
           (Select == 3'b101) ? I5:      // A
           (Select == 3'b110) ? I6:      // B
                             32'bx;
    
endmodule
