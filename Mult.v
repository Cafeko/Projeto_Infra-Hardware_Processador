module Mult (
    output reg  [31:0] Hi,
    output reg  [31:0] Lo,
    output reg        MulttoControl,
    input  wire        Clock,
    input  wire        Reset,
    input  wire [1:0]  State,
    input  wire [31:0] Multiplying,
    input  wire [31:0] Multiplier
);

    reg [5:0]  Counter;
    reg [31:0] Multiplying_reg;
    reg [63:0] Product;
    reg        Operation;
    reg        Product_signal;

initial begin
    MulttoControl = 0;
    Counter = 6'd0;
    Multiplying_reg <= 32'd0;
    Product <= 64'd0;
end

always @(posedge Clock or posedge Reset) begin
    if (Reset) begin
        MulttoControl = 0;
        Counter = 6'd0;
        Multiplying_reg <= 32'd0;
        Product <= 64'd0;
    end
    else if (State == 2'b01) begin
        Multiplying_reg = Multiplying;
        MulttoControl = 0;
        Counter = 6'd0;

        if (Multiplying[31] == Multiplier[31])
            Product_signal = 0;
        else
            Product_signal = 1;

        if (Multiplier[31] == 0) begin
            Operation = 0;
            Product = {32'd0, Multiplier};
        end
        else begin 
            Operation = 1;
            Product = {32'd0, ((~Multiplier) + 1)};
        end
    end
    else if (State == 2'b10) begin
        if (Counter <= 31) begin
            if (Product[0] == 1) begin
                if (Operation == 0)
                    Product[63:32] = Product[63:32] + Multiplying_reg;
                else 
                    Product[63:32] = Product[63:32] - Multiplying_reg;
            end
            
            Product = {Product_signal, Product[63:1]};
            Counter = Counter + 1;
        end

        if (Counter >= 32) begin
            MulttoControl = 1;
        end
    end
end

always @(*) begin
    Hi = Product[63:32];
    Lo = Product[31:0];
end
    
endmodule