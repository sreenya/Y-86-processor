module decodeReg(clk,f_icode,f_ifun,f_rA,f_rB,f_valC,f_valP,d_icode,d_ifun,d_rA,d_rB,d_valC,d_valP);

    input clk;
    input [3:0] f_icode,f_ifun,f_rA,f_rB;
    input [63:0] f_valC,f_valP;

    output [3:0] d_icode,d_ifun,d_rA,d_rB;
    output [63:0] d_valC,d_valP;

    always @(posedge clk) begin //non blocking statements - update register simultaneously at posedge
        d_icode <= f_icode;
        d_ifun <= f_ifun;
        d_rA <= f_rA;
        d_rB <= f_rB;
        d_valC <= f_valC;
        d_valP <= f_valP;
    end

endmodule
