module MUX_2to1_5bits (
    output wire [4:0] O,
    input  wire [4:0] I0,
    input  wire [4:0] I1,
    input  wire       Select
);

assign O = (Select == 1'b0) ? I0: I1;
    
endmodule