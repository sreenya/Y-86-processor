`timescale 1ns / 1ps

module memory(clk, icode, valA, valB, valP, valM, valE, datamemory);

    input clk;
    input [3:0] icode;
    input [63:0] valA, valB, valE, valP;

    output reg [63:0] valM, datamemory;

    reg [63:0] mem[0:1023];

    always@(*) begin
        case(icode)
            4'b0100: mem[valE] = valA;
            4'b0101: valM = mem[valE];
            4'b1000: mem[valE] = valP;
            4'b1001: valM = mem[valA];
            4'b1010: mem[valE] = valA;
            4'b1011: valM = mem[valA];
        endcase
        datamemory = mem[valE];
    end

endmodule