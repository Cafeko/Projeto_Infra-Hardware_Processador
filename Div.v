module Div(
    input   wire  [31:0]  dividend,
    input   wire [31:0]  divisor,
    input   wire    Clock,
    input   wire    Reset,
    input   wire    [1:0]   State,
    output  reg [31:0]  quotient_hi,
    output  reg [31:0]  quotient_lo,
    output  reg DivToControl
);

// Estados
    //0 = 2'b00;
    //1 = 2'b01;
    //FIM = 2'b10;

// Registradores internos
reg [1:0] current_State;
reg [32:0] temp_dividend;
reg [31:0] temp_quotient;
reg [31:0] remainder;


always @(posedge Clock or posedge Reset)
begin
    if (Reset)
    begin
        current_State <= 2'b00;
        DivToControl <= 0;
        quotient_hi <= 0;
        quotient_lo <= 0;
        temp_dividend <= 0;
        temp_quotient <= 0;
        remainder <= 0;
    end
    else
    begin
        case (current_State)
            //ESTADO 0
            2'b00:
                begin
                    //Variaveis
                    quotient_hi <= 0;
                    quotient_lo <= 0;
                    temp_dividend <= {1'b0, dividend};
                    temp_quotient <= 0;
                    remainder <= 0;

                    //Divisao por nao-zero
                    if (divisor != 0)
                        current_State <= 2'b01;
                    //Divisao por zero retorna 1 e sinaliza FIM DivToControl
                    else
                        current_State <= 2'b10;
                end
            //ESTADO 1
            2'b01:
                begin
                    //Divisão por partes
                    remainder <= temp_remainder - divisor;
                    temp_dividend <= temp_dividend << 1;
                    temp_dividend[0] <= remainder[31];
                    temp_quotient <= temp_quotient << 1;

                    //bit mais significante == 1
                    if (remainder[31])
                        temp_quotient[0] <= 0;
                    else
                        temp_quotient[0] <= 1;
                    //Divisão acabou ou atingiu valor-limite 32-bits
                    if (temp_dividend == 0 || temp_quotient == 32'b11111111111111111111111111111111)
                        current_State <= 2'b10;
                end
            //ESTADO FIM
            2'b10:
                begin
                    //Divisão concluida
                    current_State <= 2'b00;
                    DivToControl <= 1;
                    quotient_hi <= temp_quotient[31];
                    quotient_lo <= temp_quotient[31:0];
                end
            default: current_State <= 2'b00;
        endcase
    end
end

endmodule