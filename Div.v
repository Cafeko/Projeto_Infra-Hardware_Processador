module Div(
    output reg [31:0] Hi,
    output reg [31:0] Lo,
    output reg [1:0]  DivtoControl,
    input wire        Clock,
    input wire        Reset,
    input wire [1:0]  State,
    input wire [31:0] Dividend,
    input wire [31:0] Divider
);

// DivtoControl:
    // 00 = Neutro.
    // 01 = Fim da divisão.
    // 10 = Divisão por 0.
    

// Registradores internos
reg [63:0] Resto;
reg [31:0] Divider_reg;
reg [5:0] Counter;
reg Dividend_Sinal;
reg Divider_Sinal;
reg [31:0] Temp;

initial begin
    Resto = 64'd0;
    Divider_reg = 32'd0;
    Counter = 6'd0;
    DivtoControl = 2'b00;
end

always @(posedge Clock or posedge Reset) begin
    if (Reset) begin
        Resto = 64'd0;
        Divider_reg = 32'd0;
        Counter = 6'd0;
        DivtoControl = 2'b00;
        Dividend_Sinal = 0;
        Divider_Sinal = 0;
    end
    
    // Estado 0: Estado neutro.
    else if (State == 2'b00) begin
        Counter = 6'd0;
        DivtoControl = 2'b00;
        Dividend_Sinal = 0;
        Divider_Sinal = 0;
    end

    // Estado 1: Guardando valores e preparando para dividir.
    else if (State == 2'b01) begin
        if (Dividend[31] == 1) begin
            Resto = {32'd0, ((~Dividend) + 1)};
            Dividend_Sinal = 1;
        end
        else begin
            Resto = {32'd0, Dividend};
            Dividend_Sinal = 0;
        end

        if (Divider[31] == 1) begin
            Divider_reg = (~Divider) + 1;
            Divider_Sinal = 1;
        end
        else begin
            Divider_reg = Divider;
            Divider_Sinal = 0;
        end

        if (Divider_reg == 0)
            DivtoControl = 2'b10;
    end

    // Estado 2: Faz divisão.
    else if (State == 2'b10) begin
        if (Counter <= 32) begin
            Temp = Resto[63:32] - Divider_reg;

            if (Temp[31] == 1) begin
                Resto[63:32] = Resto[63:32];
                Resto = {Resto[62:0], 1'b0};
            end
            else begin
                Resto[63:32] = Temp;
                Resto = {Resto[62:0], 1'b1};
            end

            Counter = Counter + 1;
        end

        if (Counter >= 33) begin
            if (DivtoControl != 2'b01) begin
                if (Dividend_Sinal == Divider_Sinal) begin
                    Resto[31:0] = Resto[31:0];
                end
                else begin
                    Resto[31:0] = (~Resto[31:0]) + 1;
                end

                if (Resto[63:32] != 0) begin
                    Resto[63:32] = {1'b0, Resto[63:33]};
                    if (Dividend_Sinal == 0)
                        Resto[63:32] = Resto[63:32];
                    else 
                        Resto[63:32] = (~Resto[63:32]) + 1;
                end
            end

            DivtoControl = 2'b01;
        end
    end
end


always @(*) begin
        Hi = Resto[63:32];
        Lo = Resto[31:0];
    end

endmodule