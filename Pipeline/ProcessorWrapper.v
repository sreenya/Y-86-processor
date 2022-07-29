`include "fetch.v"
`include "fetchreg.v"
`include "decode.v"
`include "decodeReg.v"
`include "execute.v"
`include "executeReg.v"
`include "memory.v"
`include "memoryReg.v"
`include "WriteBack.v"
`include "writebackReg.v"  
`include "pcupdate.v"

module ProcessorWrapper;

    reg clk;
    reg [63:0] pc

    wire [63:0] newPC, f_predicted_pc;
    wire [3:0] f_icode,f_ifun,f_rA,f_rB;
    wire [3:0] d_icode,d_ifun,d_rA,d_rB;
    wire [3:0] e_icode,e_ifun,e_rA,e_rB;
    wire [3:0] m_icode,m_rA,m_rB;
    wire [3:0] w_icode,w_rA,w_rB;
    wire [63:0] f_valC,f_valP;
    wire [63:0] d_valC,d_valP,d_valA,d_valB;
    wire [63:0] e_valC,e_valP,e_valA,e_valB,e_valE;
    wire [63:0] m_valC,m_valP,m_valE,m_valA,m_valB,m_valM;
    wire [63:0] v_valC,v_valP,v_valE,v_valA,v_valB,v_valM;

    wire imem_error, halt, instr_valid;
    wire e_cnd; m_cnd; w_cnd;

    wire [63:0] R0,R1,R2,R3,R4,R5,R6,R7,R8,R9,R10,R11,R12,R13,R14,Data;

    pcupdate DUT(clk, PC, icode, cnd, valC, valM, valP, newPC);

    fetchreg DUT(clk, predictedPC, f_predictedPC);
    fetch DUT(clk,PC,icode,ifun,rA,rB,valC,valP,instr_valid,imem_error, instruction);

    decodeReg DUT(clk,f_icode,f_ifun,f_rA,f_rB,f_valC,f_valP,d_icode,d_ifun,d_rA,d_rB,d_valC,d_valP);
    decode DUT(clk, icode, valA, valB, valM, valE, rA, rB, R0, R1, R2, R3, R4, R5, R6, R7, R8, R9, R10, R11, R12, R13, R14);

    executeReg DUT(clk,d_icode,d_ifun,d_rA,d_rB,d_valC,d_valP,d_valA,d_valB,e_icode,e_ifun,e_rA,e_rB,e_valC,e_valP,e_valA,e_valB);
    execute DUT(clk, icode, ifun, valA, valB, valC, valE, cnd, zero, sign, overflow);

    memoryReg DUT(clk,e_icode,e_rA,e_rB,e_valC,e_valP,e_valA,e_valB,e_cnd,e_valE,m_icode,m_rA,m_rB,m_valC,m_valP,m_valA,m_valB,m_cnd,m_valE);
    memory DUT(clk, icode, valA, valB, valP, valM, valE, datamemory);

    writebackReg DUT(clk,m_icode,m_rA,m_rB,m_valC,m_valP,m_valA,m_valB,m_cnd,m_valE,m_valM,w_icode,w_rA,w_rB,w_valC,w_valP,w_valA,w_valB,w_cnd,w_valE,w_valM);
    WriteBack DUT(icode,clk,rA,rB,valA,valB,valE,valM);

    always #10 clk = ~clk;

    initial begin
        $dumpfile("ProcessorWrapper.vcd");
        $dumpvars(0,ProcessorWrapper);
        $monitor("clk=%d R0=%d R1=%d R2=%d R3=%d R4=%d ZF=%d SF=%d OF=%d halt=%d \n icode=%b ifun=%b rA=%b rB=%b valA=%d valB=%d valC=%d valE=%d valM=%d insval=%d memerr=%d cnd=%d ",clk,R0,R1,R2,R3,R4,zf,sf,of,halt,icode,ifun,rA,rB,valA,valB,valC,valE,valM,instr_valid,imem_error,cnd);

        clk = 1;
        PC = 64'd31;

    end

    always@(*) begin
        PC = newPC;
    end

    always@(*) begin
        if(halts) begin
            PC = 64'd0;
        end
        else begin
            PC = PC + 1;
        end
    end

    always@(*) begin
        if(PC==0) begin
            $finish;
        end
    end

endmodule
