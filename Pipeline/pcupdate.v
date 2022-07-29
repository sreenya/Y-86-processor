`timescale 1ns / 1ps

module pcupdate(clk, PC, icode, cnd, valC, valM, valP, newPC);
    input clk;
    input [63:0] PC, valC, valM, valP;
    input [3:0] icode;
    input cnd;
    output reg [63:0] newPC;

    always@(*) begin
        case(icode)
            4'b0000: newPC = 0;
            4'b0001: newPC = valP;
            4'b0010: newPC = valP;    
            4'b0011: newPC = valP;
            4'b0100: newPC = valP;
            4'b0101: newPC = valP;
            4'b0110: newPC = valP;
            4'b0111: begin
                newPC = valP;
                if(cnd) newPC = valC;
            end
            4'b1000: newPC = valC;
            4'b1001: newPC = valM;
            4'b1010: newPC = valP;
            4'b1011: newPC = valP;    
        endcase
    end
endmodule
