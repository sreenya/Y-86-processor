module executeReg(clk,d_icode,d_ifun,d_rA,d_rB,d_valC,d_valP,d_valA,d_valB,e_icode,e_ifun,e_rA,e_rB,e_valC,e_valP,e_valA,e_valB);

input clk;
input [3:0] d_icode,d_ifun,d_rA,d_rB;
input [63:0] d_valC,d_valP,d_valA,d_valB;

output [3:0] e_icode,e_ifun,e_rA,e_rB;
output [63:0] e_valC,e_valP,e_valA,e_valB;

    always @(posedge clk ) begin //adding them as non blocking statements since all values get updated to the registers at the same time
    e_icode <= d_icode;
    e_ifun <= d_ifun;
    e_rA <= d_rA;
    e_rB <= d_rB;
    e_valC <= d_valC;
    e_valP <= d_valP;
    e_valA <= d_valA;
    e_valB <= d_valB;
end

endmodule
