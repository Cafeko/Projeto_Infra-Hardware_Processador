module MUX_4to1_5bits (
    output wire [4:0] O,
    input  wire [4:0] I0,
    input  wire [4:0] I1,
    input  wire [4:0] I2,
    input  wire [4:0] I3,
    input  wire [1:0] Select
);

assign O = (Select == 2'b00) ? I0:
           (Select == 2'b01) ? I1:
           (Select == 2'b10) ? I2:
                               I3;
    
endmodule