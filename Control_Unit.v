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
    output reg        ABWrite,

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
    parameter RESET1 = 6'd0;
    parameter RESET2 = 6'd1;
    parameter BUSCA1 = 6'd2;
    parameter BUSCA2 = 6'd3;
    parameter INSTRUCAOWRITE = 6'd4;
    parameter LEITURA1 = 6'd5;
    parameter LEITURA2 = 6'd6;
    parameter ESCREVE1 = 6'd7;
    parameter ESCREVE2 = 6'd8;
    parameter AND = 6'd9;
    parameter ADD = 6'd10;
    parameter SUB = 6'd11;
    parameter ADDIS = 6'd12;
    parameter JR = 6'd13;
    parameter J = 6'd14;
    parameter JAL1 = 6'd15;
    parameter JAL2 = 6'd16;
    parameter MFHI = 6'd17;
    parameter MFLO = 6'd18;
    parameter SLT = 6'd19;
    parameter BREAK = 6'd20;
    parameter RTE = 6'd21;
    parameter LUI = 6'd22;
    parameter SLTI = 6'd23;
    parameter BRANCHS = 6'd24;
    parameter DESVIO = 6'd25;
    parameter OFFSOMARS = 6'd26;
    parameter MEMTOMDR1 = 6'd27;
    parameter MEMTOMDR2 = 6'd28;
    parameter ADDM = 6'd29;
    parameter LB = 6'd30;
    parameter LH = 6'd31;
    parameter LW = 6'd32;
    parameter SB = 6'd33;
    parameter SH = 6'd34;
    parameter SW = 6'd35;
    parameter SHIFTSHAMT = 6'd36;
    parameter SHIFTREG = 6'd37;
    parameter SHIFTDIREITA = 6'd38;
    parameter SHIFTARITMETICO = 6'd39;
    parameter SHIFTESQUERDA = 6'd40;
    parameter SHIFTRESULT = 6'd41;
    parameter OVERFLOW = 6'd42;
    parameter OVERFLOW2 = 6'd43;
    parameter OVERFLOW3 = 6'd44;
    parameter OVERFLOW4 = 6'd45;
    parameter INEXISTENTE = 6'd46;
    parameter INEXISTENTE2 = 6'd47;
    parameter INEXISTENTE3 = 6'd48;
    parameter INEXISTENTE4 = 6'd49;
    parameter MULT1 = 6'd50;
    parameter MULT2 = 6'd51;
    parameter MULT3 = 6'd52;

    
    reg [5:0] State;
    reg [1:0] Counter;
    

    initial begin
        State <= BUSCA1;
        Counter <= 2'b00;
        PCWrite <= 0;
        PCSource <= 3'b000;
        MemWrRd <= 0;
        MemAdrsSrc <= 3'b000;
        WDControl <= 2'b00;
        IRWrite <= 0;
        MDWrite <= 0;
        MDControl <= 2'b00;
        WriteIn <= 2'b00;
        WriteDataSrc <= 3'b000;
        RegWrite <= 0;
        ABWrite <= 0;
        ALUControl <= 3'b000;
        ALUSrcA <= 2'b00;
        ALUSrcB <= 2'b00;
        ALUOutWrite <= 0;
        EPCWrite <= 0;
        ShiftControl <= 3'b000;
        ShiftEntry <= 0;
        DivMultTempWrite <= 0;
        DivMultEntry <= 0;
        Div <= 2'b00;
        Mult <= 2'b00;
        DivorMult <= 0;
        WriteHi <= 0;
        WriteLo <= 0;
    end


    always @(*) begin
        if (Reset) State <= RESET1;
    end


    always @(posedge Clock) begin
        if (State == RESET1) begin
            State <= RESET2;
            Counter <= 2'b00;
            PCWrite <= 0;
            PCSource <= 3'b000;
            MemWrRd <= 0;
            MemAdrsSrc <= 3'b000;
            WDControl <= 2'b00;
            IRWrite <= 0;
            MDWrite <= 0;
            MDControl <= 2'b00;
            WriteIn <= 2'b00;
            WriteDataSrc <= 3'b000;
            RegWrite <= 0;
            ABWrite <= 0;
            ALUControl <= 3'b000;
            ALUSrcA <= 2'b00;
            ALUSrcB <= 2'b00;
            ALUOutWrite <= 0;
            EPCWrite <= 0;
            ShiftControl <= 3'b000;
            ShiftEntry <= 0;
            DivMultTempWrite <= 0;
            DivMultEntry <= 0;
            Div <= 2'b00;
            Mult <= 2'b00;
            DivorMult <= 0;
            WriteHi <= 0;
            WriteLo <= 0;
        end
        else if (State == RESET2) begin
            WriteIn <= 2'b10;
            WriteDataSrc <= 3'b110;
            RegWrite <= 1;
            State <= BUSCA1;
        end
        else if (State == BUSCA1) begin
            PCWrite <= 1;//
            PCSource <= 3'b001;//
            MemWrRd <= 0;//
            MemAdrsSrc <= 3'b000;//
            WDControl <= 2'b00;
            IRWrite <= 0;
            MDWrite <= 0;
            MDControl <= 2'b00;
            WriteIn <= 2'b00;
            WriteDataSrc <= 3'b000;
            RegWrite <= 0;
            ABWrite <= 0;
            ALUControl <= 3'b001;//
            ALUSrcA <= 2'b00;//
            ALUSrcB <= 2'b01;//
            ALUOutWrite <= 0;
            EPCWrite <= 0;
            ShiftControl <= 3'b000;
            ShiftEntry <= 0;
            DivMultTempWrite <= 0;
            DivMultEntry <= 0;
            Div <= 2'b00;
            Mult <= 2'b00;
            DivorMult <= 0;
            WriteHi <= 0;
            WriteLo <= 0;
            
            Counter <= 2'b00;
            State <= BUSCA2;
        end
        else if (State == BUSCA2) begin
            PCWrite <= 0;
            PCSource <= 3'b000;
            MemWrRd <= 0;//
            MemAdrsSrc <= 3'b000;//
            ALUControl <= 3'b000;
            ALUSrcA <= 2'b00;
            ALUSrcB <= 2'b00;
            
            State <= INSTRUCAOWRITE;
        end
        else if (State == INSTRUCAOWRITE) begin
            MemWrRd <= 0;
            MemAdrsSrc <= 3'b000;
            IRWrite <= 1;//
            
            State <= LEITURA1;
        end
        else if (State == LEITURA1) begin
            IRWrite <= 0;
            ABWrite <= 1;//
            ALUControl <= 3'b001;//
            ALUSrcA <= 2'b00;//
            ALUSrcB <= 2'b11;//
            ALUOutWrite <= 1;//
            
            State <= LEITURA2;
        end
        else if (State == LEITURA2) begin
            ABWrite <= 0;
            ALUControl <= 3'b000;
            ALUSrcA <= 2'b00;
            ALUSrcB <= 2'b00;
            ALUOutWrite <= 0;

            if (Opcode == 6'h0) begin
                if (Funct == 6'h0 || Funct == 6'h2 ||
                    Funct == 6'h3)
                    State <= SHIFTSHAMT;
                if (Funct == 6'h4 || Funct == 6'h7)
                    State <= SHIFTREG;
                else if (Funct == 6'h8)
                    State <= JR;
                else if (Funct == 6'hd)
                    State <= BREAK;
                else if (Funct == 6'h10)
                    State <= MFHI;
                else if (Funct == 6'h12)
                    State= MFLO;
                else if (Funct == 6'h13)
                    State <= RTE;
                else if (Funct == 6'h18)
                    State <= MULT1;
                else if (Funct == 6'h20)
                    State <= ADD;
                else if (Funct == 6'h22)
                    State <= SUB;
                else if (Funct == 6'h24)
                    State <= AND;
                else if (Funct == 6'h2a)
                    State <= SLT;
                else 
                    State <= INEXISTENTE;
            end
            else if (Opcode == 6'h2)
                State <= J;
            else if (Opcode == 6'h3)
                State <= JAL1;
            else if (Opcode == 6'h4 || Opcode == 6'h5 ||
                     Opcode == 6'h6 || Opcode == 6'h7)
                State <= BRANCHS;
            else if (Opcode == 6'h8 || Opcode == 6'h9)
                State <= ADDIS;
            else if (Opcode == 6'ha)
                State <= SLTI;
            else if (Opcode == 6'hf)
                    State <= LUI;
            else if (Opcode == 6'h1  || Opcode == 6'h20 ||
                     Opcode == 6'h21 || Opcode == 6'h23 ||
                     Opcode == 6'h28 || Opcode == 6'h29 ||
                     Opcode == 6'h2b)
                State <= OFFSOMARS;
            else
                State <= INEXISTENTE;
        end
        else if (State == ESCREVE1) begin
            WriteIn <= 2'b01;//
            WriteDataSrc <= 3'b000;//
            RegWrite <= 1;//
            ALUControl <= 3'b000;
            ALUSrcA <= 2'b00;
            ALUSrcB <= 2'b00;
            ALUOutWrite <= 0;

            State <= BUSCA1;
        end
        else if (State == ESCREVE2) begin
            WriteIn <= 2'b00;//
            WriteDataSrc <= 3'b000;//
            RegWrite <= 1;//
            ALUControl <= 3'b000;
            ALUSrcA <= 2'b00;
            ALUSrcB <= 2'b00;
            ALUOutWrite <= 0;

            State <= BUSCA1;
        end
        else if (State == AND) begin
            PCWrite <= 0;
            MemWrRd <= 0;
            IRWrite <= 0;
            MDWrite <= 0;
            RegWrite <= 0;
            ABWrite <= 0;
            ALUControl <= 3'b011;//
            ALUSrcA <= 2'b01;//
            ALUSrcB <= 2'b00;//
            ALUOutWrite <= 1;//
            EPCWrite <= 0;
            ShiftControl <= 3'b000;
            DivMultTempWrite <= 0;
            Div <= 2'b00;
            Mult <= 2'b00;
            WriteHi <= 0;
            WriteLo <= 0;

            Counter <= 2'b00;
            State <= ESCREVE1;
        end
        else if (State == ADD) begin
            ALUControl <= 3'b001;//
            ALUSrcA <= 2'b01;//
            ALUSrcB <= 2'b00;//
            ALUOutWrite <= 1;//

            if (O == 1)
                State <= OVERFLOW;
            else
                State <= ESCREVE1;
        end
        else if (State == SUB) begin
            PCWrite <= 0;
            MemWrRd <= 0;
            IRWrite <= 0;
            MDWrite <= 0;
            RegWrite <= 0;
            ABWrite <= 0;
            ALUControl <= 3'b010;//
            ALUSrcA <= 2'b01;//
            ALUSrcB <= 2'b00;//
            ALUOutWrite <= 1;//
            EPCWrite <= 0;
            ShiftControl <= 3'b000;
            DivMultTempWrite <= 0;
            Div <= 2'b00;
            Mult <= 2'b00;
            WriteHi <= 0;
            WriteLo <= 0;

            Counter <= 2'b00;
            if (O == 1)
                State <= OVERFLOW;
            else
                State <= ESCREVE1;
        end
        else if (State == ADDIS) begin
            ALUControl <= 3'b001;//
            ALUSrcA <= 2'b01;//
            ALUSrcB <= 2'b10;//
            ALUOutWrite <= 1;//

            if (Opcode == 6'h8 && O == 1)
                State <= OVERFLOW;
            else
                State <= ESCREVE2;
        end
        else if (State == JR) begin
            PCWrite <= 1;//
            PCSource <= 3'b001;//
            MemWrRd <= 0;
            IRWrite <= 0;
            MDWrite <= 0;
            RegWrite <= 0;
            ABWrite <= 0;
            ALUControl <= 3'b000;//
            ALUSrcA <= 2'b01;//
            ALUOutWrite <= 0;
            EPCWrite <= 0;
            ShiftControl <= 3'b000;
            DivMultTempWrite <= 0;
            Div <= 2'b00;
            Mult <= 2'b00;
            WriteHi <= 0;
            WriteLo <= 0;

            Counter <= 2'b00;
            State <= BUSCA1;
        end
        else if (State == J) begin
            PCWrite <= 1;//
            PCSource <= 3'b000;//
            MemWrRd <= 0;
            IRWrite <= 0;
            MDWrite <= 0;
            RegWrite <= 0;
            ABWrite <= 0;
            ALUControl <= 3'b000;
            ALUOutWrite <= 0;
            EPCWrite <= 0;
            ShiftControl <= 3'b000;
            DivMultTempWrite <= 0;
            Div <= 2'b00;
            Mult <= 2'b00;
            WriteHi <= 0;
            WriteLo <= 0;

            Counter <= 2'b00;
            State <= BUSCA1;
        end
        else if (State == JAL1) begin
            PCWrite <= 0;
            MemWrRd <= 0;
            IRWrite <= 0;
            MDWrite <= 0;
            RegWrite <= 0;
            ABWrite <= 0;
            ALUControl <= 3'b000;//
            ALUSrcA <= 2'b00;//
            ALUOutWrite <= 1;//
            EPCWrite <= 0;
            ShiftControl <= 3'b000;
            DivMultTempWrite <= 0;
            Div <= 2'b00;
            Mult <= 2'b00;
            WriteHi <= 0;
            WriteLo <= 0;

            Counter <= 2'b00;
            State <= JAL2;
        end
        else if (State == JAL2) begin
            PCWrite <= 1;//
            PCSource <= 3'b000;//
            MemWrRd <= 0;
            IRWrite <= 0;
            MDWrite <= 0;
            WriteHi <= 2'b11;//
            WriteDataSrc <= 3'b000;//
            RegWrite <= 1;//
            ABWrite <= 0;
            ALUControl <= 3'b000;
            ALUOutWrite <= 0;
            EPCWrite <= 0;
            ShiftControl <= 3'b000;
            DivMultTempWrite <= 0;
            Div <= 2'b00;
            Mult <= 2'b00;
            WriteHi <= 0;
            WriteLo <= 0;

            Counter <= 2'b00;
            State <= BUSCA1;
        end
        else if (State == MFHI) begin
            PCWrite <= 0;
            MemWrRd <= 0;
            IRWrite <= 0;
            MDWrite <= 0;
            WriteHi <= 2'b01;//
            WriteDataSrc <= 3'b100;//
            RegWrite <= 1;//
            ABWrite <= 0;
            ALUControl <= 3'b000;
            ALUOutWrite <= 0;
            EPCWrite <= 0;
            ShiftControl <= 3'b000;
            DivMultTempWrite <= 0;
            Div <= 2'b00;
            Mult <= 2'b00;
            WriteHi <= 0;
            WriteLo <= 0;

            Counter <= 2'b00;
            State <= BUSCA1;
        end
        else if (State == MFLO) begin
            PCWrite <= 0;
            MemWrRd <= 0;
            IRWrite <= 0;
            MDWrite <= 0;
            WriteHi <= 2'b01;//
            WriteDataSrc <= 3'b011;//
            RegWrite <= 1;//
            ABWrite <= 0;
            ALUControl <= 3'b000;
            ALUOutWrite <= 0;
            EPCWrite <= 0;
            ShiftControl <= 3'b000;
            DivMultTempWrite <= 0;
            Div <= 2'b00;
            Mult <= 2'b00;
            WriteHi <= 0;
            WriteLo <= 0;

            Counter <= 2'b00;
            State <= BUSCA1;
        end
        else if (State == SLT) begin
            PCWrite <= 0;
            MemWrRd <= 0;
            IRWrite <= 0;
            MDWrite <= 0;
            WriteHi <= 2'b01;//
            WriteDataSrc <= 3'b111;//
            RegWrite <= 1;//
            ABWrite <= 0;
            ALUControl <= 3'b111;//
            ALUSrcA <= 2'b01;//
            ALUSrcB <= 2'b00;//
            ALUOutWrite <= 0;
            EPCWrite <= 0;
            ShiftControl <= 3'b000;
            DivMultTempWrite <= 0;
            Div <= 2'b00;
            Mult <= 2'b00;
            WriteHi <= 0;
            WriteLo <= 0;

            Counter <= 2'b00;
            State <= BUSCA1;
        end
        else if (State == BREAK) begin
            PCWrite <= 1;//
            PCSource <= 3'b001;//
            MemWrRd <= 0;
            IRWrite <= 0;
            MDWrite <= 0;
            RegWrite <= 0;
            ABWrite <= 0;
            ALUControl <= 3'b010;//
            ALUSrcA <= 2'b00;//
            ALUSrcB <= 2'b01;//
            ALUOutWrite <= 0;
            EPCWrite <= 0;
            ShiftControl <= 3'b000;
            DivMultTempWrite <= 0;
            Div <= 2'b00;
            Mult <= 2'b00;
            WriteHi <= 0;
            WriteLo <= 0;

            Counter <= 2'b00;
            State <= BUSCA1;
        end
        else if (State == RTE) begin
            PCWrite <= 1;//
            PCSource <= 3'b010;//
            MemWrRd <= 0;
            IRWrite <= 0;
            MDWrite <= 0;
            RegWrite <= 0;
            ABWrite <= 0;
            ALUControl <= 3'b000;
            ALUOutWrite <= 0;
            EPCWrite <= 0;
            ShiftControl <= 3'b000;
            DivMultTempWrite <= 0;
            Div <= 2'b00;
            Mult <= 2'b00;
            WriteHi <= 0;
            WriteLo <= 0;

            Counter <= 2'b00;
            State <= BUSCA1;
        end
        else if (State == LUI) begin
            PCWrite <= 0;
            MemWrRd <= 0;
            IRWrite <= 0;
            MDWrite <= 0;
            WriteHi <= 2'b00;//
            WriteDataSrc <= 3'b010;//
            RegWrite <= 1;//
            ABWrite <= 0;
            ALUControl <= 3'b000;
            ALUOutWrite <= 0;
            EPCWrite <= 0;
            ShiftControl <= 3'b000;
            DivMultTempWrite <= 0;
            Div <= 2'b00;
            Mult <= 2'b00;
            WriteHi <= 0;
            WriteLo <= 0;

            Counter <= 2'b00;
            State <= BUSCA1;
        end
        else if (State == SLTI) begin
            PCWrite <= 0;
            MemWrRd <= 0;
            IRWrite <= 0;
            MDWrite <= 0;
            WriteHi <= 2'b00;//
            WriteDataSrc <= 3'b111;//
            RegWrite <= 1;//
            ABWrite <= 0;
            ALUControl <= 3'b111;///
            ALUSrcA <= 2'b01;//
            ALUSrcB <= 2'b10;//
            ALUOutWrite <= 0;
            EPCWrite <= 0;
            ShiftControl <= 3'b000;
            DivMultTempWrite <= 0;
            Div <= 2'b00;
            Mult <= 2'b00;
            WriteHi <= 0;
            WriteLo <= 0;

            Counter <= 2'b00;
            State <= BUSCA1;
        end
        else if (State == BRANCHS) begin
            PCWrite <= 0;
            MemWrRd <= 0;
            IRWrite <= 0;
            MDWrite <= 0;
            RegWrite <= 0;
            ABWrite <= 0;
            ALUControl <= 3'b111;//
            ALUSrcA <= 2'b01;//
            ALUSrcB <= 2'b00;//
            ALUOutWrite <= 0;
            EPCWrite <= 0;
            ShiftControl <= 3'b000;
            DivMultTempWrite <= 0;
            Div <= 2'b00;
            Mult <= 2'b00;
            WriteHi <= 0;
            WriteLo <= 0;

            Counter <= 2'b00;
            if ((Opcode == 6'h4 && ET == 0) ||
                (Opcode == 6'h5 && ET == 1) ||
                (Opcode == 6'h6 && GT == 1) ||
                (Opcode == 6'h7 && GT == 0))
                State <= BUSCA1;
            else if ((Opcode == 6'h4 && ET == 1) ||
                (Opcode == 6'h5 && ET == 0) ||
                (Opcode == 6'h6 && (ET == 1 || LT == 1)) ||
                (Opcode == 6'h7 && GT == 1))
                State <= DESVIO;
        end
        else if (State == DESVIO) begin
            PCWrite <= 1;//
            PCSource <= 3'b011;//
            MemWrRd <= 0;
            IRWrite <= 0;
            MDWrite <= 0;
            RegWrite <= 0;
            ABWrite <= 0;
            ALUControl <= 3'b000;
            ALUOutWrite <= 0;
            EPCWrite <= 0;
            ShiftControl <= 3'b000;
            DivMultTempWrite <= 0;
            Div <= 2'b00;
            Mult <= 2'b00;
            WriteHi <= 0;
            WriteLo <= 0;

            Counter <= 2'b00;
            State <= BUSCA1;
        end
        else if (State == OFFSOMARS) begin
            PCWrite <= 0;
            MemWrRd <= 0;
            IRWrite <= 0;
            MDWrite <= 0;
            RegWrite <= 0;
            ABWrite <= 0;
            ALUControl <= 3'b001;//
            ALUSrcA <= 2'b01;//
            ALUSrcB <= 2'b10;//
            ALUOutWrite <= 1;//
            EPCWrite <= 0;
            ShiftControl <= 3'b000;
            DivMultTempWrite <= 0;
            Div <= 2'b00;
            Mult <= 2'b00;
            WriteHi <= 0;
            WriteLo <= 0;

            Counter <= 2'b00;
            State <= MEMTOMDR1;
        end
        else if (State == MEMTOMDR1) begin
            PCWrite <= 0;
            MemWrRd <= 0;//
            MemAdrsSrc <= 3'b001;//
            IRWrite <= 0;
            MDWrite <= 0;
            RegWrite <= 0;
            ABWrite <= 0;
            ALUControl <= 3'b000;
            ALUOutWrite <= 0;
            EPCWrite <= 0;
            ShiftControl <= 3'b000;
            DivMultTempWrite <= 0;
            Div <= 2'b00;
            Mult <= 2'b00;
            WriteHi <= 0;
            WriteLo <= 0;
            
            if (Counter == 2'b00) begin
                Counter <= Counter + 1;
            end
            else if (Counter == 2'b01) begin
                Counter <= 2'b00;
                State <= MEMTOMDR2;
            end
        end
        else if (State == MEMTOMDR2) begin
            PCWrite <= 0;
            MemWrRd <= 0;//
            MemAdrsSrc <= 3'b001;//
            IRWrite <= 0;
            MDWrite <= 1;//
            RegWrite <= 0;
            ABWrite <= 0;
            ALUControl <= 3'b000;
            ALUOutWrite <= 0;
            EPCWrite <= 0;
            ShiftControl <= 3'b000;
            DivMultTempWrite <= 0;
            Div <= 2'b00;
            Mult <= 2'b00;
            WriteHi <= 0;
            WriteLo <= 0;

            Counter <= 2'b00;
            if (Opcode == 6'h1)
                State <= ADDM;
            else if (Opcode == 6'h20)
                State <= LB;
            else if (Opcode == 6'h21)
                State <= LH;
            else if (Opcode == 6'h23)
                State <= LW;
            else if (Opcode == 6'h28)
                State <= SB;
            else if (Opcode == 6'h29)
                State <= SH;
            else if (Opcode == 6'h2b)
                State <= SW;
        end
        else if (State == ADDM) begin
            PCWrite <= 0;
            MemWrRd <= 0;
            IRWrite <= 0;
            MDWrite <= 0;
            RegWrite <= 0;
            ABWrite <= 0;
            ALUControl <= 3'b001;//
            ALUSrcA <= 2'b10;//
            ALUSrcB <= 2'b00;//
            ALUOutWrite <= 1;//
            EPCWrite <= 0;
            ShiftControl <= 3'b000;
            DivMultTempWrite <= 0;
            Div <= 2'b00;
            Mult <= 2'b00;
            WriteHi <= 0;
            WriteLo <= 0;

            Counter <= 2'b00;
            if (O == 1)
                State <= OVERFLOW;
            else
                State <= ESCREVE2;
        end
        else if (State == LB) begin
            PCWrite <= 0;
            MemWrRd <= 0;
            IRWrite <= 0;
            MDWrite <= 0;
            MDControl <= 2'b10;//
            WriteIn <= 2'b00;//
            WriteDataSrc <= 3'b001;//
            RegWrite <= 1;//
            ABWrite <= 0;
            ALUControl <= 3'b000;
            ALUOutWrite <= 0;
            EPCWrite <= 0;
            ShiftControl <= 3'b000;
            DivMultTempWrite <= 0;
            Div <= 2'b00;
            Mult <= 2'b00;
            WriteHi <= 0;
            WriteLo <= 0;

            Counter <= 2'b00;
            State <= BUSCA1;
        end
        else if (State == LH) begin
            PCWrite <= 0;
            MemWrRd <= 0;
            IRWrite <= 0;
            MDWrite <= 0;
            MDControl <= 2'b01;//
            WriteIn <= 2'b00;//
            WriteDataSrc <= 3'b001;//
            RegWrite <= 1;//
            ABWrite <= 0;
            ALUControl <= 3'b000;
            ALUOutWrite <= 0;
            EPCWrite <= 0;
            ShiftControl <= 3'b000;
            DivMultTempWrite <= 0;
            Div <= 2'b00;
            Mult <= 2'b00;
            WriteHi <= 0;
            WriteLo <= 0;

            Counter <= 2'b00;
            State <= BUSCA1;
        end
        else if (State == LW) begin
            PCWrite <= 0;
            MemWrRd <= 0;
            IRWrite <= 0;
            MDWrite <= 0;
            MDControl <= 2'b00;//
            WriteIn <= 2'b00;//
            WriteDataSrc <= 3'b001;//
            RegWrite <= 1;//
            ABWrite <= 0;
            ALUControl <= 3'b000;
            ALUOutWrite <= 0;
            EPCWrite <= 0;
            ShiftControl <= 3'b000;
            DivMultTempWrite <= 0;
            Div <= 2'b00;
            Mult <= 2'b00;
            WriteHi <= 0;
            WriteLo <= 0;

            Counter <= 2'b00;
            State <= BUSCA1;
        end
        else if (State == SB) begin
            PCWrite <= 0;
            MemWrRd <= 1;//
            MemAdrsSrc <= 3'b001;//
            WDControl <= 2'b10;//
            IRWrite <= 0;
            MDWrite <= 0;
            RegWrite <= 0;
            ABWrite <= 0;
            ALUControl <= 3'b000;
            ALUOutWrite <= 0;
            EPCWrite <= 0;
            ShiftControl <= 3'b000;
            DivMultTempWrite <= 0;
            Div <= 2'b00;
            Mult <= 2'b00;
            WriteHi <= 0;
            WriteLo <= 0;

            Counter <= 2'b00;
            State <= BUSCA1;
        end
        else if (State == SH) begin
            PCWrite <= 0;
            MemWrRd <= 1;//
            MemAdrsSrc <= 3'b001;//
            WDControl <= 2'b01;//
            IRWrite <= 0;
            MDWrite <= 0;
            RegWrite <= 0;
            ABWrite <= 0;
            ALUControl <= 3'b000;
            ALUOutWrite <= 0;
            EPCWrite <= 0;
            ShiftControl <= 3'b000;
            DivMultTempWrite <= 0;
            Div <= 2'b00;
            Mult <= 2'b00;
            WriteHi <= 0;
            WriteLo <= 0;

            Counter <= 2'b00;
            State <= BUSCA1;
        end
        else if (State == SW) begin
            PCWrite <= 0;
            MemWrRd <= 1;//
            MemAdrsSrc <= 3'b001;//
            WDControl <= 2'b00;//
            IRWrite <= 0;
            MDWrite <= 0;
            RegWrite <= 0;
            ABWrite <= 0;
            ALUControl <= 3'b000;
            ALUOutWrite <= 0;
            EPCWrite <= 0;
            ShiftControl <= 3'b000;
            DivMultTempWrite <= 0;
            Div <= 2'b00;
            Mult <= 2'b00;
            WriteHi <= 0;
            WriteLo <= 0;

            Counter <= 2'b00;
            State <= BUSCA1;
        end
        else if (State == SHIFTSHAMT) begin
            PCWrite <= 0;
            MemWrRd <= 0;
            IRWrite <= 0;
            MDWrite <= 0;
            RegWrite <= 0;
            ABWrite <= 0;
            ALUControl <= 3'b000;
            ALUOutWrite <= 0;
            EPCWrite <= 0;
            ShiftControl <= 3'b001;//
            ShiftEntry <= 0;//
            DivMultTempWrite <= 0;
            Div <= 2'b00;
            Mult <= 2'b00;
            WriteHi <= 0;
            WriteLo <= 0;

            Counter <= 2'b00;
            if (Funct == 6'h2)
                State <= SHIFTDIREITA;
            else if (Funct == 6'h3)
                State <= SHIFTARITMETICO;
            else if (Funct == 6'h0)
                State <= SHIFTESQUERDA;
        end
        else if (State == SHIFTREG) begin
            PCWrite <= 0;
            MemWrRd <= 0;
            IRWrite <= 0;
            MDWrite <= 0;
            RegWrite <= 0;
            ABWrite <= 0;
            ALUControl <= 3'b000;
            ALUOutWrite <= 0;
            EPCWrite <= 0;
            ShiftControl <= 3'b001;//
            ShiftEntry <= 1;//
            DivMultTempWrite <= 0;
            Div <= 2'b00;
            Mult <= 2'b00;
            WriteHi <= 0;
            WriteLo <= 0;

            Counter <= 2'b00;
            if (Funct == 6'h4)
                State <= SHIFTESQUERDA;
            else if (Funct == 6'h7)
                State <= SHIFTARITMETICO;
        end
        else if (State == SHIFTDIREITA) begin
            PCWrite <= 0;
            MemWrRd <= 0;
            IRWrite <= 0;
            MDWrite <= 0;
            RegWrite <= 0;
            ABWrite <= 0;
            ALUControl <= 3'b000;
            ALUOutWrite <= 0;
            EPCWrite <= 0;
            ShiftControl <= 3'b011;//
            DivMultTempWrite <= 0;
            Div <= 2'b00;
            Mult <= 2'b00;
            WriteHi <= 0;
            WriteLo <= 0;

            Counter <= 2'b00;
            State <= SHIFTRESULT;
        end
        else if (State == SHIFTARITMETICO) begin
            PCWrite <= 0;
            MemWrRd <= 0;
            IRWrite <= 0;
            MDWrite <= 0;
            RegWrite <= 0;
            ABWrite <= 0;
            ALUControl <= 3'b000;
            ALUOutWrite <= 0;
            EPCWrite <= 0;
            ShiftControl <= 3'b100;//
            DivMultTempWrite <= 0;
            Div <= 2'b00;
            Mult <= 2'b00;
            WriteHi <= 0;
            WriteLo <= 0;

            Counter <= 2'b00;
            State <= SHIFTRESULT;
        end
        else if (State == SHIFTESQUERDA) begin
            PCWrite <= 0;
            MemWrRd <= 0;
            IRWrite <= 0;
            MDWrite <= 0;
            RegWrite <= 0;
            ABWrite <= 0;
            ALUControl <= 3'b000;
            ALUOutWrite <= 0;
            EPCWrite <= 0;
            ShiftControl <= 3'b010;//
            DivMultTempWrite <= 0;
            Div <= 2'b00;
            Mult <= 2'b00;
            WriteHi <= 0;
            WriteLo <= 0;

            Counter <= 2'b00;
            State <= SHIFTRESULT;
        end
        else if (State == SHIFTRESULT) begin
            PCWrite <= 0;
            MemWrRd <= 0;
            IRWrite <= 0;
            MDWrite <= 0;
            WriteIn <= 2'b01;//
            WriteDataSrc <= 3'b101;//
            RegWrite <= 1;//
            ABWrite <= 0;
            ALUControl <= 3'b000;
            ALUOutWrite <= 0;
            EPCWrite <= 0;
            ShiftControl <= 3'b000;
            DivMultTempWrite <= 0;
            Div <= 2'b00;
            Mult <= 2'b00;
            WriteHi <= 0;
            WriteLo <= 0;

            Counter <= 2'b00;
            State <= BUSCA1;
        end
        else if (State == OVERFLOW) begin
            ALUControl <= 3'b010;//
            ALUSrcA <= 2'b00;//
            ALUSrcB <= 2'b01;//
            ALUOutWrite <= 0;
            EPCWrite <= 1;//

            State <= OVERFLOW2;
        end
        else if (State == OVERFLOW2) begin
            PCWrite <= 0;
            MemWrRd <= 0;//
            MemAdrsSrc <= 3'b011;//
            IRWrite <= 0;
            MDWrite <= 0;
            RegWrite <= 0;
            ABWrite <= 0;
            ALUControl <= 3'b000;
            ALUOutWrite <= 0;
            EPCWrite <= 0;
            ShiftControl <= 3'b000;
            DivMultTempWrite <= 0;
            Div <= 2'b00;
            Mult <= 2'b00;
            WriteHi <= 0;
            WriteLo <= 0;

            if (Counter == 2'b00) begin
                Counter <= Counter + 1;
            end
            else if (Counter == 2'b01) begin
                Counter <= 2'b00;
                State <= OVERFLOW3;
            end
        end
        else if (State == OVERFLOW3) begin
            PCWrite <= 0;
            MemWrRd <= 0;//
            MemAdrsSrc <= 3'b011;//
            IRWrite <= 0;
            MDWrite <= 1;//
            RegWrite <= 0;
            ABWrite <= 0;
            ALUControl <= 3'b000;
            ALUOutWrite <= 0;
            EPCWrite <= 0;
            ShiftControl <= 3'b000;
            DivMultTempWrite <= 0;
            Div <= 2'b00;
            Mult <= 2'b00;
            WriteHi <= 0;
            WriteLo <= 0;

            Counter <= 2'b00;
            State <= OVERFLOW4;
        end
        else if (State == OVERFLOW4) begin
            PCWrite <= 1;//
            PCSource <= 3'b100;//
            MemWrRd <= 0;
            IRWrite <= 0;
            MDWrite <= 0;
            MDControl <= 2'b10;//
            RegWrite <= 0;
            ABWrite <= 0;
            ALUControl <= 3'b000;
            ALUOutWrite <= 0;
            EPCWrite <= 0;
            ShiftControl <= 3'b000;
            DivMultTempWrite <= 0;
            Div <= 2'b00;
            Mult <= 2'b00;
            WriteHi <= 0;
            WriteLo <= 0;

            Counter <= 2'b00;
            State <= BUSCA1;
        end
        else if (State == INEXISTENTE) begin
            PCWrite <= 0;
            MemWrRd <= 0;
            IRWrite <= 0;
            MDWrite <= 0;
            RegWrite <= 0;
            ABWrite <= 0;
            ALUControl <= 3'b010;//
            ALUSrcA <= 2'b00;//
            ALUSrcB <= 2'b01;//
            ALUOutWrite <= 0;
            EPCWrite <= 1;//
            ShiftControl <= 3'b000;
            DivMultTempWrite <= 0;
            Div <= 2'b00;
            Mult <= 2'b00;
            WriteHi <= 0;
            WriteLo <= 0;

            Counter <= 2'b00;
            State <= INEXISTENTE2;
        end
        else if (State == INEXISTENTE2) begin
            PCWrite <= 0;
            MemWrRd <= 0;//
            MemAdrsSrc <= 3'b010;//
            IRWrite <= 0;
            MDWrite <= 0;
            RegWrite <= 0;
            ABWrite <= 0;
            ALUControl <= 3'b000;
            ALUOutWrite <= 0;
            EPCWrite <= 0;
            ShiftControl <= 3'b000;
            DivMultTempWrite <= 0;
            Div <= 2'b00;
            Mult <= 2'b00;
            WriteHi <= 0;
            WriteLo <= 0;

            if (Counter == 2'b00) begin
                Counter <= Counter + 1;
            end
            else if (Counter == 2'b01) begin
                Counter <= 2'b00;
                State <= INEXISTENTE3;
            end
        end
        else if (State == INEXISTENTE3) begin
            PCWrite <= 0;
            MemWrRd <= 0;//
            MemAdrsSrc <= 3'b010;//
            IRWrite <= 0;
            MDWrite <= 1;//
            RegWrite <= 0;
            ABWrite <= 0;
            ALUControl <= 3'b000;
            ALUOutWrite <= 0;
            EPCWrite <= 0;
            ShiftControl <= 3'b000;
            DivMultTempWrite <= 0;
            Div <= 2'b00;
            Mult <= 2'b00;
            WriteHi <= 0;
            WriteLo <= 0;

            Counter <= 2'b00;
            State <= INEXISTENTE4;
        end
        else if (State == INEXISTENTE4) begin
            PCWrite <= 1;//
            PCSource <= 3'b100;//
            MemWrRd <= 0;
            IRWrite <= 0;
            MDWrite <= 0;
            MDControl <= 2'b10;//
            RegWrite <= 0;
            ABWrite <= 0;
            ALUControl <= 3'b000;
            ALUOutWrite <= 0;
            EPCWrite <= 0;
            ShiftControl <= 3'b000;
            DivMultTempWrite <= 0;
            Div <= 2'b00;
            Mult <= 2'b00;
            WriteHi <= 0;
            WriteLo <= 0;

            Counter <= 2'b00;
            State <= BUSCA1;
        end
        else if (State == MULT1) begin
            PCWrite <= 0;
            MemWrRd <= 0;
            IRWrite <= 0;
            MDWrite <= 0;
            RegWrite <= 0;
            ABWrite <= 0;
            ALUControl <= 3'b000;
            ALUOutWrite <= 0;
            EPCWrite <= 0;
            ShiftControl <= 3'b000;
            DivMultTempWrite <= 0;
            DivMultEntry <= 0;//
            Div <= 2'b00;
            Mult <= 2'b01;//
            WriteHi <= 0;
            WriteLo <= 0;

            Counter <= 2'b00;
            State <= MULT2;
        end
        else if (State == MULT2) begin
            PCWrite <= 0;
            MemWrRd <= 0;
            IRWrite <= 0;
            MDWrite <= 0;
            RegWrite <= 0;
            ABWrite <= 0;
            ALUControl <= 3'b000;
            ALUOutWrite <= 0;
            EPCWrite <= 0;
            ShiftControl <= 3'b000;
            DivMultTempWrite <= 0;
            Div <= 2'b00;
            Mult <= 2'b10;//
            WriteHi <= 0;
            WriteLo <= 0;

            Counter <= 2'b00;
            if (MulttoControl == 1)
                State <= MULT3;
        end
        else if (State == MULT3) begin
            PCWrite <= 0;
            MemWrRd <= 0;
            IRWrite <= 0;
            MDWrite <= 0;
            RegWrite <= 0;
            ABWrite <= 0;
            ALUControl <= 3'b000;
            ALUOutWrite <= 0;
            EPCWrite <= 0;
            ShiftControl <= 3'b000;
            DivMultTempWrite <= 0;
            Div <= 2'b00;
            Mult <= 2'b00;
            DivorMult <= 1;//
            WriteHi <= 1;//
            WriteLo <= 1;//

            Counter <= 2'b00;
            State <= BUSCA1;
        end
    end
endmodule