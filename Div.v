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

// Estados
    //0 = 2'b00;
    //1 = 2'b01;
    //FIM = 2'b10;

// Registradores internos
reg [64:0] A;
reg [64:0] P;
reg [4:0] Count;

initial begin
    A <= 65'd0;
    P <= 65'd0;
    Count <= 5'b11111;
    DivtoControl = 0;
end

always @(posedge Clock or posedge Reset) begin
    if (Reset) begin
        A <= 65'd0;
        P <= 65'd0;
        Count <= 5'b11111;
        DivtoControl = 0;
    end

    else if (State == 2'b00) begin
        if(Divider == 32'd0) begin
            DivtoControl = 2'b10;
        end else begin
            DivtoControl = 2'b00;
        end
    end

    else if (State == 2'b01) begin
        DivtoControl = 2'b00;
        Count = 5'b11111;
        if (Divider[31] == 1'b0)begin
            A = {{1'b0},Divider,{32{1'b0}}};
        end else begin
            A = {{1'b1},Divider,{32{1'b0}}};
        end
        if (Dividend[31] == 1'b0)begin
            P = {{33{1'b0}}, Dividend};
        end else begin
            P = {{33{1'b1}}, Dividend};
        end
        if (Divider[31] == 1'b1) begin 
            A = -A;
            P = -P;
        end
        P = P << 1;
        if (P[64] == 1'b1)begin
            P = P + A;
        end else begin 
            P = P - A;
        end
        if (P[64] == 1'b0)begin
            P[0] = 1'b1;
        end
        Count = Count - 1;
    end

    else if (State == 2'b10) begin
        P = P << 1;
        if (P[64] == 1'b1)begin
            P = P + A;
        end else begin 
        P = P - A;
        end
        if (P[64] == 1'b0)begin
            P[0] = 1'b1;
        end
        Count = Count - 1;
        if (Count == 5'b00000) begin
            DivtoControl = 2'b01
        end
    end

    else if (State == 2'b11) begin
        P = P << 1;
        if (P[64] == 1'b1)begin
            P = P + A;
        end else begin 
            P = P - A;
        end
        if (P[64] == 1'b0)begin
            P[0] = 1'b1;
        end
        if (P[64] == 1'b1)begin
            P = P + A;
        end else begin 
            P = P - A;
        end
        Hi = P[63:32];
        Lo = P[31:0];
    end
end

endmodule