module MUX_7to1_32bits (
    output wire [31:0] O,
    input  wire [31:0] I0,
    input  wire [31:0] I1,
    input  wire [31:0] I2,
    input  wire [31:0] I3,
    input  wire [31:0] I4,
    input  wire [31:0] I5,
    input  wire [31:0] I6,
    input  wire [2:0]  Select
);

assign O = (Select == 3'b000) ? I0:
           (Select == 3'b001) ? I1:
           (Select == 3'b010) ? I2:
           (Select == 3'b011) ? I3:
           (Select == 3'b100) ? I4:
           (Select == 3'b101) ? I5:
           (Select == 3'b110) ? I6:
                             32'bx;
    
endmodule
