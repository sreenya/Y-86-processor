module memoryReg(clk,e_icode,e_rA,e_rB,e_valC,e_valP,e_valA,e_valB,e_cnd,e_valE,m_icode,m_rA,m_rB,m_valC,m_valP,m_valA,m_valB,m_cnd,m_valE);

input clk,e_cnd;
input [3:0] e_icode,e_rA,e_rB;
input [63:0] e_valC,e_valP,e_valA,e_valB,e_valE;

output reg m_cnd;
output reg [3:0] m_icode,m_rA,m_rB;
output reg [63:0] m_valC,m_valP,m_valA,m_valB,m_valE;

always @(posedge clk) begin
    m_icode <= e_icode;
    m_rA <= e_rA;
    m_rB <= e_rB;
    m_valC <= e_valC;
    m_valP <= e_valP;
    m_valA <= e_valA;
    m_valB <= e_valB;
    m_valE <= e_valE;
    m_cnd <= e_cnd;
end

    
endmodule
