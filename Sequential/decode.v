`timescale 1ns / 1ps

module docode(clk, icode, valA, valB, valM, valE, rA, rB,
 R0, R1, R2, R3, R4, R5, R6, R7, R8, R9, R10, R11, R12, R13, R14);
    input [3:0] icode;
    input clk;
    input [63:0] valM, valE;
    input [3:0] rA, rB;
    output reg [63:0] valA, valB;
    output reg [63:0] R0, R1, R2, R3, R4, R5, R6, R7, R8, R9, R10, R11, R12, R13, R14;

    reg [63:0] RegMem[0:14];

    initial begin
        RegMem[0]=64'd0;
        RegMem[1]=64'd0;
        RegMem[2]=64'd0;
        RegMem[3]=64'd0;
        RegMem[4]=64'd0;
        RegMem[5]=64'd0;
        RegMem[6]=64'd0;
        RegMem[7]=64'd0;
        RegMem[8]=64'd0;
        RegMem[9]=64'd0;
        RegMem[10]=64'd0;
        RegMem[11]=64'd0;
        RegMem[12]=64'd0;
        RegMem[13]=64'd0;
        RegMem[14]=64'd0;
    end

    always@(*)
    begin
        case(icode)
            4'b0010: 
                valA = RegMem[rA];

            4'b0100:
            begin
                valA = RegMem[rA];
                valB = RegMem[rB];
            end

            4'b0101:
                valB = RegMem[rB];

            4'b0110:
            begin
                valA = RegMem[rA];
                valB = RegMem[rB];
            end

            4'b1000:
                valB = RegMem[4];

            4'b1001:
            begin
                valA = RegMem[4];
                valB = RegMem[4];
            end

            4'b1010:
            begin
                valA = RegMem[rA];
                valB = RegMem[4];
            end

            4'b1011:
            begin
                valA = RegMem[4];
                valB = RegMem[4];
            end

        endcase
        R0 = RegMem[0];
        R1 = RegMem[1];
        R2 = RegMem[2];
        R3 = RegMem[3];
        R4 = RegMem[4];
        R5 = RegMem[5];
        R6 = RegMem[6];
        R7 = RegMem[7];
        R8 = RegMem[8];
        R9 = RegMem[9];
        R10 = RegMem[10];
        R11 = RegMem[11];
        R12 = RegMem[12];
        R13 = RegMem[13];
        R14 = RegMem[14];
    end

endmodule