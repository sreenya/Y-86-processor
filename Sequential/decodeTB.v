`include "fetch.v"
`include "decode.v"

module fetchdecodeTB;
  reg clk;
  reg [63:0] PC;
  reg [63:0] reg_mem[0:14];

  wire [3:0] icode, ifun, rA, rB; 
  wire [63:0] valC, valP, valA, valB, valE;
  wire [0:79] instruction;
  wire instr_valid, imem_error;
  wire [63:0] R0, R1, R2, R3, R4, R5, R6, R7, R8, R9, R10, R11, R12, R13, R14;

  decode DUT(clk, icode, valA, valB, valM, valE, rA, rB,
 R0, R1, R2, R3, R4, R5, R6, R7, R8, R9, R10, R11, R12, R13, R14);
  fetch g1(clk,PC,icode,ifun,rA,rB,valC,valP,instr_valid,imem_error, instruction);


  initial begin
    $dumpfile("decode.vcd");
    $dumpvars(0,decode_testbench);
  	$monitor("clk=%d icode=%b ifun=%b rA=%b rB=%b valA=%d valB=%d\n",clk,icode,ifun,rA,rB,valA,valB);

    clk=0;
    PC=64'd0;

    #10 clk=~clk;PC=64'd0;
    #10 clk=~clk;
    #10 clk=~clk;PC=valP;
    #10 clk=~clk;
    #10 clk=~clk;PC=valP;
    #10 clk=~clk;
    #10 clk=~clk;PC=valP;
    #10 clk=~clk;
    #10 clk=~clk;PC=valP;
    #10 clk=~clk;
    #10 clk=~clk;PC=valP;
    #10 clk=~clk;
    #10 clk=~clk;PC=valP;
    #10 clk=~clk;
    #10 clk=~clk;PC=valP;
    #10 clk=~clk;
    #10 clk=~clk;PC=valP;
    #10 clk=~clk;
    #10 clk=~clk;PC=valP;
    #10 clk=~clk;
    #10 clk=~clk;PC=valP;
    #10 clk=~clk;
    #10 clk=~clk;PC=valP;
    #10 clk=~clk;
    #10 clk=~clk;PC=valP;
    #10 clk=~clk;
    #10 clk=~clk;
  end 
  

endmodule