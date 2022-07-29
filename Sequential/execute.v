`timescale 1ns / 1ps

`include "alu.v"

module execute(clk, icode, ifun, valA, valB, valC, valE, cnd, zero, sign, overflow);
    input clk;
    input [3:0] icode, ifun;
    input [63:0] valA, valB, valC;

    output reg [63:0] valE;
    output reg cnd, zero, sign, overflow;

    initial begin
        zero = 0;
        sign = 0;
        overflow = 0;
    end

    wire sxoro, sxoroorz;

    xor g1(sxoro, sign, overflow);
    or g2(sxoroorz, sxoro, zero);
    reg [63:0] a, b;
    wire [63:0] answer;
    wire over;
    reg [1:0] control;
    ALU g3(answer, over, a, b, control);

    always@(*)
    begin
        case(icode)
            4'b0010: begin
                valE = valA;
                case(ifun)
                    4'b0000: cnd = 1;
                    4'b0001: if(sxoroorz) cnd = 1;
                    4'b0010: if(sxoro) cnd = 1;
                    4'b0011: if(zero) cnd = 1;
                    4'b0100: if(!zero) cnd = 1;
                    4'b0101: if(!sxoro) cnd = 1;
                    4'b0110: if(!sxoroorz) cnd = 1;
                endcase
            end
            4'b0011: valE = valC;
            4'b0100: valE = valB + valC;
            4'b0101: valE = valB + valC;
            4'b0110: begin
                case(ifun)
                    4'b0000: begin
                        a = valA;
                        b = valB;
                        control = 2'b00;
                    end
                    4'b0001: begin
                        a = valA;
                        b = valB;
                        control = 2'b01;
                    end
                    4'b0010: begin
                        a = valA;
                        b = valB;
                        control = 2'b10;
                    end
                    4'b0011: begin
                        a = valA;
                        b = valB;
                        control = 2'b11;
                    end
                endcase
                valE = answer;                    
            end
            4'b0111: begin
                case(ifun)
                    4'b0000: cnd = 1;
                    4'b0001: if(sxoroorz) cnd = 1;
                    4'b0010: if(sxoro) cnd = 1;
                    4'b0011: if(zero) cnd = 1;
                    4'b0100: if(!zero) cnd = 1;
                    4'b0101: if(!sxoro) cnd = 1;
                    4'b0110: if(!sxoroorz) cnd = 1;
                endcase
            end
            4'b1000: valE = valB - 64'd8;
            4'b1001: valE = valB + 64'd8;
            4'b1010: valE = valB - 64'd8;
            4'b1011: valE = valB + 64'd8;
        endcase
    end
endmodule