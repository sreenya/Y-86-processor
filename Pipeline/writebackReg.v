module writebackReg(clk,m_icode,m_rA,m_rB,m_valC,m_valP,m_valA,m_valB,m_cnd,m_valE,m_valM,w_icode,w_rA,w_rB,w_valC,w_valP,w_valA,w_valB,w_cnd,w_valE,w_valM);

input clk;
input [3:0] m_icode,m_rA,m_rB;
input [63:0] m_valC,m_valP,m_valA,m_valB,m_valE,m_valM;
input m_cnd;

output reg [3:0] w_icode,w_rA,w_rB;
output reg [63:0] w_valC,w_valP,w_valA,w_valB,w_valE,w_valM;
output reg w_cnd;

always @(posedge clk ) begin
    w_icode <= m_icode;
    w_rA <= m_rA;
    w_rB <= m_rB;
    w_valC <= m_valC;
    w_valP <= m_valP;
    w_valA <= m_valA;
    w_valB <= m_valB;
    w_valE <= m_valE;
    w_valM <= m_valM;
    w_cnd <= m_cnd;
end

endmodule