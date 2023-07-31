module CPU (
    input wire clock,
    input wire reset
);

//Flags
    wire Z;
    wire N;
    wire O;
    wire ET;
    wire GT;
    wire LT;

//Control wires
    wire PCWrite;
    wire MemWrRd;
    wire IRWrite;
    wire RegWrite;
    wire AB_w;
    wire ALUSrcA;
    wire ALUSrcB;
    wire MDWrite;
    wire [1:0] WriteIn;
    wire [1:0] MDControl;
    wire [1:0] WDControl;
    wire [2:0] PCSource;
    wire [2:0] MemAdrsSrc;
    wire [2:0] ALUControl;
    wire [2:0] WriteDataSrc;

//Data wires
    wire [31:0] M_PCSource_out;
    wire [31:0] JumpAdrs;
    wire [31:0] ALU;
    wire [31:0] EPC;
    wire [31:0] ALU_out;
    wire [31:0] MDControl_out;
    wire [31:0] MuxMem_out;
    wire [31:0] PC_out;
    wire [31:0] A;
    wire [31:0] B;
    wire [31:0] WDControl_out;
    wire [31:0] MemData_out;
    wire [31:0] MemDataReg_out;
    wire [5:0] Opcode;
    wire [4:0] Instr25_21;
    wire [4:0] Instr20_16;
    wire [15:0] Instr15_0;
    wire [4:0] M_WriteIn_out;
    wire [31:0] SL16_out;
    wire [31:0] Extd_1to32_out;
    wire [31:0] ShiftReg_out;
    wire [31:0] M_WriteData_out;
    wire [31:0] BReg_to_A;
    wire [31:0] BReg_to_B;
    wire [31:0] MuxA_out;
    wire [31:0] MuxB_out;
    wire [31:0] Extend_16to32_out;
    wire [31:0] SL2_out;
    
    MUX_PCSource M_PCSource_(
        M_PCSource_out,
        JumpAdrs,
        ALU,
        EPC,
        ALU_out,
        MDControl_out,
        PCSource
    );

    Registrador PC_(
        clock,
        reset,
        PCWrite,
        M_PCSource_out,
        PC_out
    );

    MUX_MemAdrsSrc MuxMem_ (
        MuxMem_out,
        PC_out,
        ALU_out,
        A,
        B,
        MemAdrsSrc
    );

    Memoria MEM_ (
        MuxMem_out,
        clock,
        MemWrRd,
        WDControl_out,
        MemData_out
    );

    Instr_Reg IR_(
        clock,
        reset,
        IRWrite,
        MemData_out,
        Opcode,
        Instr25_21,
        Instr20_16,
        Instr15_0
    );

    MUX_WriteIn M_WriteIn_(
        M_WriteIn_out,
        Instr20_16,
        Instr15_0,
        WriteIn
    );

    ShiftLeft16 SL16_(
        SL16_out,
        Instr15_0,
    );

    Extend_1to32 Extd_1to32_(
        Extd_1to32_out,
        LT
    );

    MUX_WriteDataSrc M_WriteData_(
        M_WriteData_out,
        ALU_out,
        MDControl_out,
        SL16_out,
        Lo,
        Hi,
        ShiftReg_out,
        Extd_1to32_out,
        WriteDataSrc
    );

    Banco_reg BReg_(
        clock,
        reset,
        RegWrite,
        Instr25_21,
        Instr20_16,
        M_WriteIn_out,
        M_WriteData_out,
        BReg_to_A,
        BReg_to_B
    );

    Registrador A_(
        clock,
        reset,
        AB_w,
        BReg_to_A,
        A
    );
    
    Registrador B_(
        clock,
        reset,
        AB_w,
        BReg_to_B,
        B
    );

    MUX_ALUSrcA MuxA_(
        MuxA_out,
        PC_out,
        A,
        MemDataReg_out
        ALUSrcA
    );

    SignExtend_16to32 Extend_16to32_(
        Extend_16to32_out,
        Instr15_0
    );

    ShiftLeft2_32bits SL2_(
        SL2_out,
        Extend_16to32_out
    );

    MUX_ALUSrcB MuxB_(
        MuxB_out,
        B,
        Extend_16to32_out,
        SL2_out,
        ALUSrcB
    );

    Ula32 ALU_(
        MuxA_out,
        MuxB_out,
        ALUControl,
        ALU,
        O,
        N,
        Z,
        ET,
        GT,
        LT
    );

    Registrador EPC_(
        clock,
        reset,
        EPCWrite,
        ALU,
        EPC
    );

    Registrador ALU_out_(
        clock,
        reset,
        ALUOutWrite,
        ALU,
        ALU_out
    );

    Registrador MemDataReg_(
        clock,
        reset,
        MDWrite,
        MemData_out,
        MemDataReg_out
    );

    MD_Control MemDataControl_(
        MDControl_out,
        MemDataReg_out,
        MDControl
    );

    WD_Control WriteDataControl_(
        WDControl_out,
        B,
        MemDataReg_out,
        WDControl
    );
endmodule