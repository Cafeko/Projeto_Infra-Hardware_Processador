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
    parameter RESET1 = 7'd0;
    parameter RESET2 = 7'd1;
    parameter BUSCA1 = 7'd2;
    parameter BUSCA2 = 7'd3;
    parameter INSTRUCAOWRITE = 7'd4;
    parameter LEITURA1 = 7'd5;
    parameter LEITURA2 = 7'd6;
    parameter ESCREVE1 = 7'd7;
    parameter ESCREVE2 = 7'd8;
    parameter AND = 7'd9;
    parameter ADD = 7'd10;
    parameter SUB = 7'd11;
    parameter ADDIS = 7'd12;
    parameter JR = 7'd13;
    parameter J = 7'd14;
    parameter JAL1 = 7'd15;
    parameter JAL2 = 7'd16;
    parameter MFHI = 7'd17;
    parameter MFLO = 7'd18;
    parameter SLT = 7'd19;
    parameter BREAK = 7'd20;
    parameter RTE = 7'd21;
    parameter LUI = 7'd22;
    parameter SLTI = 7'd23;
    parameter BRANCHS = 7'd24;
    parameter DESVIO = 7'd25;
    parameter OFFSOMARS = 7'd26;
    parameter MEMTOMDR1 = 7'd27;
    parameter MEMTOMDR2 = 7'd28;
    parameter ADDM = 7'd29;
    parameter LB = 7'd30;
    parameter LH = 7'd31;
    parameter LW = 7'd32;
    parameter SB = 7'd33;
    parameter SH = 7'd34;
    parameter SW = 7'd35;
    parameter SHIFTSHAMT = 7'd36;
    parameter SHIFTREG = 7'd37;
    parameter SHIFTDIREITA = 7'd38;
    parameter SHIFTARITMETICO = 7'd39;
    parameter SHIFTESQUERDA = 7'd40;
    parameter SHIFTRESULT = 7'd41;
    parameter OVERFLOW = 7'd42;
    parameter OVERFLOW2 = 7'd43;
    parameter OVERFLOW3 = 7'd44;
    parameter OVERFLOW4 = 7'd45;
    parameter INEXISTENTE = 7'd46;
    parameter INEXISTENTE2 = 7'd47;
    parameter INEXISTENTE3 = 7'd48;
    parameter INEXISTENTE4 = 7'd49;
    parameter MULT1 = 7'd50;
    parameter MULT2 = 7'd51;
    parameter MULT3 = 7'd52;
    parameter DIV1 = 7'd53;
    parameter DIV2 = 7'd54;
    parameter DIV3 = 7'd55;
    parameter DIVM1 = 7'd56;
    parameter DIVM2 = 7'd57;
    parameter DIVM3 = 7'd58;
    parameter DIVM4 = 7'd59;
    parameter DIVM5 = 7'd60;
    parameter DIVZERO = 7'd61;
    parameter DIVZERO2 = 7'd62;
    parameter DIVZERO3 = 7'd63;
    parameter DIVZERO4 = 7'd64;

    
    reg [6:0] State;
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

            Counter <= 2'b00;
            if (Opcode == 6'h0) begin
                if (Funct == 6'h0 || Funct == 6'h2 ||
                    Funct == 6'h3)
                    State <= SHIFTSHAMT;
                else if (Funct == 6'h4 || Funct == 6'h7)
                    State <= SHIFTREG;
                else if (Funct == 6'h5)
                    State <= DIVM1;
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
                else if (Funct == 6'h1a)
                    State <= DIV1; 
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

            Counter <= 2'b00;
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

            Counter <= 2'b00;
            State <= BUSCA1;
        end
        else if (State == AND) begin
            ALUControl <= 3'b011;//
            ALUSrcA <= 2'b01;//
            ALUSrcB <= 2'b00;//
            ALUOutWrite <= 1;//

            State <= ESCREVE1;
        end
        else if (State == ADD) begin
            ALUControl <= 3'b001;//
            ALUSrcA <= 2'b01;//
            ALUSrcB <= 2'b00;//
            ALUOutWrite <= 1;//

            if (Counter == 2'b01) begin 
                if (O == 1)
                    State <= OVERFLOW;
                else
                    State <= ESCREVE1;
            end
            else
                Counter <= Counter + 1;
        end
        else if (State == SUB) begin
            ALUControl <= 3'b010;//
            ALUSrcA <= 2'b01;//
            ALUSrcB <= 2'b00;//
            ALUOutWrite <= 1;//
            
            if (Counter == 2'b01) begin 
                if (O == 1)
                    State <= OVERFLOW;
                else
                    State <= ESCREVE1;
            end
            else
                Counter <= Counter + 1;
        end
        else if (State == ADDIS) begin
            ALUControl <= 3'b001;//
            ALUSrcA <= 2'b01;//
            ALUSrcB <= 2'b10;//
            ALUOutWrite <= 1;//

            if (Counter == 2'b01) begin 
                if (Opcode == 6'h8 && O == 1)
                    State <= OVERFLOW;
                else
                    State <= ESCREVE2;
            end
            else
                Counter <= Counter + 1;
        end
        else if (State == JR) begin
            PCWrite <= 1;//
            PCSource <= 3'b001;//
            ALUControl <= 3'b000;//
            ALUSrcA <= 2'b01;//
            
            State <= BUSCA1;
        end
        else if (State == J) begin
            PCWrite <= 1;//
            PCSource <= 3'b000;//
            
            State <= BUSCA1;
        end
        else if (State == JAL1) begin
            ALUControl <= 3'b000;//
            ALUSrcA <= 2'b00;//
            ALUOutWrite <= 1;//
            
            State <= JAL2;
        end
        else if (State == JAL2) begin
            PCWrite <= 1;//
            PCSource <= 3'b000;//
            WriteIn <= 2'b11;//
            WriteDataSrc <= 3'b000;//
            RegWrite <= 1;//
            ALUControl <= 3'b000;
            ALUSrcA <= 2'b00;
            ALUOutWrite <= 0;

            State <= BUSCA1;
        end
        else if (State == MFHI) begin
            WriteIn <= 2'b01;//
            WriteDataSrc <= 3'b100;//
            RegWrite <= 1;//
            
            State <= BUSCA1;
        end
        else if (State == MFLO) begin
            WriteIn <= 2'b01;//
            WriteDataSrc <= 3'b011;//
            RegWrite <= 1;//
            
            State <= BUSCA1;
        end
        else if (State == SLT) begin
            WriteIn <= 2'b01;//
            WriteDataSrc <= 3'b111;//
            RegWrite <= 1;//
            ALUControl <= 3'b111;//
            ALUSrcA <= 2'b01;//
            ALUSrcB <= 2'b00;//
            
            State <= BUSCA1;
        end
        else if (State == BREAK) begin
            PCWrite <= 1;//
            PCSource <= 3'b001;//
            ALUControl <= 3'b010;//
            ALUSrcA <= 2'b00;//
            ALUSrcB <= 2'b01;//
            
            State <= BUSCA1;
        end
        else if (State == RTE) begin
            PCWrite <= 1;//
            PCSource <= 3'b010;//
            
            State <= BUSCA1;
        end
        else if (State == LUI) begin
            WriteIn <= 2'b00;//
            WriteDataSrc <= 3'b010;//
            RegWrite <= 1;//
            
            State <= BUSCA1;
        end
        else if (State == SLTI) begin
            WriteIn <= 2'b00;//
            WriteDataSrc <= 3'b111;//
            RegWrite <= 1;//
            ALUControl <= 3'b111;///
            ALUSrcA <= 2'b01;//
            ALUSrcB <= 2'b10;//
            
            State <= BUSCA1;
        end
        else if (State == BRANCHS) begin
            ALUControl <= 3'b111;//
            ALUSrcA <= 2'b01;//
            ALUSrcB <= 2'b00;//
            
            if (Counter == 2'b01) begin 
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
            else
                Counter <= Counter + 1;
        end
        else if (State == DESVIO) begin
            PCWrite <= 1;//
            PCSource <= 3'b011;//
            ALUControl <= 3'b000;
            ALUSrcA <= 2'b00;
            ALUSrcB <= 2'b00;

            Counter <= 2'b00;
            State <= BUSCA1;
        end
        else if (State == OFFSOMARS) begin
            ALUControl <= 3'b001;//
            ALUSrcA <= 2'b01;//
            ALUSrcB <= 2'b10;//
            ALUOutWrite <= 1;//
            
            State <= MEMTOMDR1;
        end
        else if (State == MEMTOMDR1) begin
            MemWrRd <= 0;//
            MemAdrsSrc <= 3'b001;//
            ALUControl <= 3'b000;
            ALUSrcA <= 2'b00;
            ALUSrcB <= 2'b00;
            ALUOutWrite <= 0;
            
            if (Counter == 2'b00) begin
                Counter <= Counter + 1;
            end
            else if (Counter == 2'b01) begin
                Counter <= 2'b00;
                State <= MEMTOMDR2;
            end
        end
        else if (State == MEMTOMDR2) begin
            MemWrRd <= 0;//
            MemAdrsSrc <= 3'b001;//
            MDWrite <= 1;//

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
            ALUControl <= 3'b001;//
            ALUSrcA <= 2'b10;//
            ALUSrcB <= 2'b00;//
            ALUOutWrite <= 1;//
            MemWrRd <= 0;
            MemAdrsSrc <= 3'b000;
            MDWrite <= 0;


            if (Counter == 2'b01) begin 
                if (O == 1)
                    State <= OVERFLOW;
                else
                    State <= ESCREVE2;
            end
            else
                Counter <= Counter + 1;
        end
        else if (State == LB) begin
            MDControl <= 2'b10;//
            WriteIn <= 2'b00;//
            WriteDataSrc <= 3'b001;//
            RegWrite <= 1;//
            MemWrRd <= 0;
            MemAdrsSrc <= 3'b000;
            MDWrite <= 0;

            State <= BUSCA1;
        end
        else if (State == LH) begin
            MDControl <= 2'b01;//
            WriteIn <= 2'b00;//
            WriteDataSrc <= 3'b001;//
            RegWrite <= 1;//
            MemWrRd <= 0;
            MemAdrsSrc <= 3'b000;
            MDWrite <= 0;

            State <= BUSCA1;
        end
        else if (State == LW) begin
            MDControl <= 2'b00;//
            WriteIn <= 2'b00;//
            WriteDataSrc <= 3'b001;//
            RegWrite <= 1;//
            MemWrRd <= 0;
            MemAdrsSrc <= 3'b000;
            MDWrite <= 0;
            
            State <= BUSCA1;
        end
        else if (State == SB) begin
            MemWrRd <= 1;//
            MemAdrsSrc <= 3'b001;//
            WDControl <= 2'b10;//
            
            State <= BUSCA1;
        end
        else if (State == SH) begin
            MemWrRd <= 1;//
            MemAdrsSrc <= 3'b001;//
            WDControl <= 2'b01;//
            
            State <= BUSCA1;
        end
        else if (State == SW) begin
            MemWrRd <= 1;//
            MemAdrsSrc <= 3'b001;//
            WDControl <= 2'b00;//
            
            State <= BUSCA1;
        end
        else if (State == SHIFTSHAMT) begin
            ShiftControl <= 3'b001;//
            ShiftEntry <= 0;//
            
            if (Funct == 6'h2)
                State <= SHIFTDIREITA;
            else if (Funct == 6'h3)
                State <= SHIFTARITMETICO;
            else if (Funct == 6'h0)
                State <= SHIFTESQUERDA;
        end
        else if (State == SHIFTREG) begin
            ShiftControl <= 3'b001;//
            ShiftEntry <= 1;//
            
            if (Funct == 6'h4)
                State <= SHIFTESQUERDA;
            else if (Funct == 6'h7)
                State <= SHIFTARITMETICO;
        end
        else if (State == SHIFTDIREITA) begin
            ShiftControl <= 3'b011;//
            ShiftEntry <= 0;

            State <= SHIFTRESULT;
        end
        else if (State == SHIFTARITMETICO) begin
            ShiftControl <= 3'b100;//
            ShiftEntry <= 0;
            
            State <= SHIFTRESULT;
        end
        else if (State == SHIFTESQUERDA) begin
            ShiftControl <= 3'b010;//
            ShiftEntry <= 0;
            
            State <= SHIFTRESULT;
        end
        else if (State == SHIFTRESULT) begin
            WriteIn <= 2'b01;//
            WriteDataSrc <= 3'b101;//
            RegWrite <= 1;//
            ShiftControl <= 3'b000;
            
            State <= BUSCA1;
        end
        else if (State == OVERFLOW) begin
            ALUControl <= 3'b010;//
            ALUSrcA <= 2'b00;//
            ALUSrcB <= 2'b01;//
            EPCWrite <= 1;//
            MemWrRd <= 0;//
            MemAdrsSrc <= 3'b011;//
            ALUOutWrite <= 0;

            State <= OVERFLOW2;
        end
        else if (State == OVERFLOW2) begin
            MemWrRd <= 0;//
            MemAdrsSrc <= 3'b011;//
            ALUControl <= 3'b000;
            ALUSrcA <= 2'b00;
            ALUSrcB <= 2'b00;
            EPCWrite <= 0;

            State <= OVERFLOW3;
        end
        else if (State == OVERFLOW3) begin
            MemWrRd <= 0;//
            MemAdrsSrc <= 3'b011;//
            MDWrite <= 1;//
            
            State <= OVERFLOW4;
        end
        else if (State == OVERFLOW4) begin
            PCWrite <= 1;//
            PCSource <= 3'b100;//
            MDControl <= 2'b10;//
            MemWrRd <= 0;
            MemAdrsSrc <= 3'b000;
            MDWrite <= 0;

            State <= BUSCA1;
        end
        else if (State == INEXISTENTE) begin
            ALUControl <= 3'b010;//
            ALUSrcA <= 2'b00;//
            ALUSrcB <= 2'b01;//
            EPCWrite <= 1;//
            MemWrRd <= 0;//
            MemAdrsSrc <= 3'b010;//
            ALUOutWrite <= 0;
            
            State <= INEXISTENTE2;
        end
        else if (State == INEXISTENTE2) begin
            MemWrRd <= 0;//
            MemAdrsSrc <= 3'b010;//
            ALUControl <= 3'b000;
            ALUSrcA <= 2'b00;
            ALUSrcB <= 2'b00;
            EPCWrite <= 0;

            State <= INEXISTENTE3;
        end
        else if (State == INEXISTENTE3) begin
            MemWrRd <= 0;//
            MemAdrsSrc <= 3'b010;//
            MDWrite <= 1;//

            State <= INEXISTENTE4;
        end
        else if (State == INEXISTENTE4) begin
            PCWrite <= 1;//
            PCSource <= 3'b100;//
            MDControl <= 2'b10;//
            MemWrRd <= 0;
            MemAdrsSrc <= 3'b000;
            MDWrite <= 0;

            State <= BUSCA1;
        end
        else if (State == MULT1) begin
            DivMultEntry <= 0;//
            Mult <= 2'b01;//
            
            State <= MULT2;
        end
        else if (State == MULT2) begin
            Mult <= 2'b10;//
            DivMultEntry <= 0;

            if (MulttoControl == 1)
                State <= MULT3;
        end
        else if (State == MULT3) begin
            DivorMult <= 1;//
            WriteHi <= 1;//
            WriteLo <= 1;//
            Mult <= 2'b00;

            State <= BUSCA1;
        end
        else if (State == DIV1) begin
            DivMultEntry <= 0;//
            Div <= 2'b01;//

            State <= DIV2;
        end
        else if (State == DIV2) begin
            Div <= 2'b10;//
            DivMultEntry <= 0;

            if (DivtoControl == 2'b01)
                State <= DIV3;
            else if (DivtoControl == 2'b10)
                State <= DIVZERO;
        end
        else if (State == DIV3) begin
            DivorMult <= 0;//
            WriteHi <= 1;//
            WriteLo <= 1;//
            Div <= 2'b00;

            State <= BUSCA1;
        end
        else if (Funct == DIVM1) begin
            MemAdrsSrc <= 3'b110;//
            MemWrRd <= 0;//

            if (Counter == 2'b01) begin 
                State <= DIVM2;
            end
            else
                Counter <= Counter + 1;
        end
        else if (Funct == DIVM2) begin
            MemAdrsSrc <= 3'b101;//
            MemWrRd <= 0;//
            MDWrite <= 1;//

            State <= DIVM3;
            
        end
        else if (Funct == DIVM3) begin
            MemAdrsSrc <= 3'b101;//
            MemWrRd <= 0;//
            DivMultTempWrite = 1;//
            MDWrite <= 0;

            State <= DIVM4;
            
        end
        else if (Funct == DIVM4) begin
            MemAdrsSrc <= 3'b101;//
            MemWrRd <= 0;//
            MDWrite <= 1;//
            DivMultTempWrite = 0;

            State <= DIVM5;
        end
        else if (Funct == DIVM5) begin
            DivMultEntry = 1;//
            Div = 2'b01;//
            MemAdrsSrc <= 3'b000;
            MemWrRd <= 0;
            MDWrite <= 0;

            State <= DIV2;
        end
        else if (State == DIVZERO) begin
            ALUControl <= 3'b010;//
            ALUSrcA <= 2'b00;//
            ALUSrcB <= 2'b01;//
            EPCWrite <= 1;//
            MemWrRd <= 0;//
            MemAdrsSrc <= 3'b100;//
            Div <= 2'b00;

            State <= DIVZERO2;  
        end
        else if (State == DIVZERO2) begin
            MemWrRd <= 0;//
            MemAdrsSrc <= 3'b100;//
            ALUControl <= 3'b000;
            ALUSrcA <= 2'b00;
            ALUSrcB <= 2'b00;
            EPCWrite <= 0;

            State <= DIVZERO3;  
        end
        else if (State == DIVZERO3) begin
            MemWrRd <= 0;//
            MemAdrsSrc <= 3'b100;//
            MDWrite <= 1;//

            State <= DIVZERO4;  
        end
        else if (State == DIVZERO4) begin
            PCWrite <= 1;//
            PCSource <= 3'b100;//
            MDControl <= 2'b10;//
            MemWrRd <= 0;
            MemAdrsSrc <= 3'b000;
            MDWrite <= 0;

            State <= BUSCA1;  
        end
    end
endmodule