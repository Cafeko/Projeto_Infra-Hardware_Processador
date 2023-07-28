// Unidade de controle

module Control_Unit (
    // -- Outputs ---------------- //
    // PC:
    output reg        PCWrite,
    output reg  [2:0] PCSource,

    // Memória:
    output reg        MemWrRd,
    output reg  [2:0] MemAdrsSrc,
    output reg  [1:0] WDControl,
    
    // Registrador de instrução:
    output reg        IRWrite,

    // Registrador MD:
    output reg        MDWrite,
    output reg  [1:0] MDControl,

    // Banco de Registradores:
    output reg  [1:0] WriteIn,
    output reg  [2:0] WriteDataSrc,
    output reg        RegWrite,

    // Registradores A e B:
    output reg        AWrite,
    output reg        BWrite,

    // ALU:
    output reg  [2:0] ALUControl,
    output reg  [1:0] ALUSrcA,
    output reg  [1:0] ALUSrcB,
    output reg        ALUOutWrite,
    output reg        EPCWrite,

    // Registrador de shift:
    output reg  [2:0] ShiftControl,
    output reg        ShiftEntry,

    // Div/Mult:
    output reg        DivMultTempWrite,
    output reg        DivMultEntry,
    output reg  [1:0] Div,
    output reg  [1:0] Mult,
    output reg        DivorMult,
    output reg        WriteHi,
    output reg        WriteLo,

    // -- inputs --------------- //
    // Externos:
    input  wire       Clock,
    input  wire       Reset,

    // Div/Mult:
    input  wire       MulttoControl,
    input  wire [1:0] DivtoControl,

    // Instruções:
    input  wire [5:0] Funct,
    input  wire [5:0] Opcode,

    // Flags:
    input  wire       Z,
    input  wire       N,
    input  wire       O,
    input  wire       ET,
    input  wire       GT,
    input  wire       LT
);

    parameter BUSCA1   = 6'd0;
    parameter BUSCA2   = 6'd1;
    parameter LEITURA1 = 6'd2;
    parameter LEITURA2 = 6'd3;
    parameter ESCREVE1 = 6'd4;
    parameter OVERFLOW = 6'd5;
    parameter ADD      = 6'd6;
    parameter SUB      = 6'd7;
    // parameter X = 6'd0;

    reg [5:0] State;
    reg [1:0] Counter;
    

    initial begin
        State = BUSCA1;
        Counter = 2'b00;
        PCWrite = 0;
        PCSource = 3'b000;
        MemWrRd = 0;
        MemAdrsSrc = 3'b000;
        WDControl = 2'b00;
        IRWrite = 0;
        MDWrite = 0;
        MDControl = 2'b00;
        WriteIn = 2'b00;
        WriteDataSrc = 3'b000;
        RegWrite = 0;
        AWrite = 0;
        BWrite = 0;
        ALUControl = 3'b000;
        ALUSrcA = 2'b00;
        ALUSrcB = 2'b00;
        ALUOutWrite = 0;
        EPCWrite = 0;
        ShiftControl = 3'b000;
        ShiftEntry = 0;
        DivMultTempWrite = 0;
        DivMultEntry = 0;
        Div = 2'b00;
        Mult = 2'b00;
        DivorMult = 0;
        WriteHi = 0;
        WriteLo = 0;
    end


    always @(posedge Clock or posedge Reset) begin
        if (Reset) begin
            State = BUSCA1;
            Counter = 2'b00;
            PCWrite = 0;
            PCSource = 3'b000;
            MemWrRd = 0;
            MemAdrsSrc = 3'b000;
            WDControl = 2'b00;
            IRWrite = 0;
            MDWrite = 0;
            MDControl = 2'b00;
            WriteIn = 2'b00;
            WriteDataSrc = 3'b000;
            RegWrite = 0;
            AWrite = 0;
            BWrite = 0;
            ALUControl = 3'b000;
            ALUSrcA = 2'b00;
            ALUSrcB = 2'b00;
            ALUOutWrite = 0;
            EPCWrite = 0;
            ShiftControl = 3'b000;
            ShiftEntry = 0;
            DivMultTempWrite = 0;
            DivMultEntry = 0;
            Div = 2'b00;
            Mult = 2'b00;
            DivorMult = 0;
            WriteHi = 0;
            WriteLo = 0;
        end
        else if (State == BUSCA1) begin
            PCWrite = 0;
            PCSource = 3'b001;//
            MemWrRd = 0;//
            MemAdrsSrc = 3'b000;//
            IRWrite = 0;
            MDWrite = 0;
            RegWrite = 0;
            AWrite = 0;
            BWrite = 0;
            ALUControl = 3'b001;//
            ALUSrcA = 2'b00;//
            ALUSrcB = 2'b01;//
            ALUOutWrite = 0;
            EPCWrite = 0;
            ShiftControl = 3'b000;
            DivMultTempWrite = 0;
            Div = 2'b00;
            Mult = 2'b00;
            WriteHi = 0;
            WriteLo = 0;

            if (Counter == 2'b01) begin
            Counter = 2'b00;
            State = BUSCA2;
            end
            else begin
                Counter = Counter + 1;
            end
        end
        else if (State == BUSCA2) begin
            PCWrite = 1;//
            PCSource = 3'b001;//
            MemWrRd = 0;//
            MemAdrsSrc = 3'b000;//
            IRWrite = 1;//
            MDWrite = 0;
            RegWrite = 0;
            AWrite = 0;
            BWrite = 0;
            ALUControl = 3'b001;//
            ALUSrcA = 2'b00;//
            ALUSrcB = 2'b01;//
            ALUOutWrite = 0;
            EPCWrite = 0;
            ShiftControl = 3'b000;
            DivMultTempWrite = 0;
            Div = 2'b00;
            Mult = 2'b00;
            WriteHi = 0;
            WriteLo = 0;
            
            Counter = 2'b00;
            State = LEITURA1;
        end
        else if (State == LEITURA1) begin
            PCWrite = 0;
            MemWrRd = 0;
            IRWrite = 0;
            MDWrite = 0;
            RegWrite = 0;
            AWrite = 0;
            BWrite = 0;
            ALUControl = 3'b001;//
            ALUSrcA = 2'b00;//
            ALUSrcB = 2'b11;//
            ALUOutWrite = 0;
            EPCWrite = 0;
            ShiftControl = 3'b000;
            DivMultTempWrite = 0;
            Div = 2'b00;
            Mult = 2'b00;
            WriteHi = 0;
            WriteLo = 0;

            Counter = 2'b00;
            State = LEITURA2;
        end
        else if (State == LEITURA2) begin
            PCWrite = 0;
            MemWrRd = 0;
            IRWrite = 0;
            MDWrite = 0;
            RegWrite = 0;
            AWrite = 1;//
            BWrite = 1;//
            ALUControl = 3'b001;//
            ALUSrcA = 2'b00;//
            ALUSrcB = 2'b11;//
            ALUOutWrite = 1;//
            EPCWrite = 0;
            ShiftControl = 3'b000;
            DivMultTempWrite = 0;
            Div = 2'b00;
            Mult = 2'b00;
            WriteHi = 0;
            WriteLo = 0;

            Counter = 2'b00;

            if (Opcode == 6'h0) begin
                if (Funct == 6'h20)
                    State = ADD;
                if (Funct == 6'h22)
                    State = SUB;
            end
        end
        else if (State == ESCREVE1) begin
            PCWrite = 0;
            MemWrRd = 0;
            IRWrite = 0;
            MDWrite = 0;
            WriteIn = 2'b01;//
            WriteDataSrc = 3'b000;//
            RegWrite = 1;//
            AWrite = 0;
            BWrite = 0;
            ALUControl = 3'b000;
            ALUOutWrite = 0;
            EPCWrite = 0;
            ShiftControl = 3'b000;
            DivMultTempWrite = 0;
            Div = 2'b00;
            Mult = 2'b00;
            WriteHi = 0;
            WriteLo = 0;

            Counter = 2'b00;
            State = BUSCA1;
        end
        else if (State == ADD) begin
            PCWrite = 0;
            MemWrRd = 0;
            IRWrite = 0;
            MDWrite = 0;
            RegWrite = 0;
            AWrite = 0;
            BWrite = 0;
            ALUControl = 3'b001;//
            ALUSrcA = 2'b01;//
            ALUSrcB = 2'b00;//
            ALUOutWrite = 1;//
            EPCWrite = 0;
            ShiftControl = 3'b000;
            DivMultTempWrite = 0;
            Div = 2'b00;
            Mult = 2'b00;
            WriteHi = 0;
            WriteLo = 0;

            Counter = 2'b00;
            if (O == 1)
                State = OVERFLOW;
            else
                State = ESCREVE1;
        end
        else if (State == SUB) begin
            PCWrite = 0;
            MemWrRd = 0;
            IRWrite = 0;
            MDWrite = 0;
            RegWrite = 0;
            AWrite = 0;
            BWrite = 0;
            ALUControl = 3'b010;//
            ALUSrcA = 2'b01;//
            ALUSrcB = 2'b00;//
            ALUOutWrite = 1;//
            EPCWrite = 0;
            ShiftControl = 3'b000;
            DivMultTempWrite = 0;
            Div = 2'b00;
            Mult = 2'b00;
            WriteHi = 0;
            WriteLo = 0;

            Counter = 2'b00;
            if (O == 1)
                State = OVERFLOW;
            else
                State = ESCREVE1;
        end
    end
endmodule



