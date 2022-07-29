module execute_tb;

reg clk;
reg [3:0] icode, ifun;
reg [63:0] valA, valB, valC;

wire [63:0] valE;
wire cnd, zero,sign,overflow;
 
fetch DUT(clk,PC,icode,ifun,rA,rB,valC,valP,instr_valid,imem_error, instruction);

decode DUT(clk, icode, valA, valB, valM, valE, rA, rB, R0, R1, R2, R3, R4, R5, R6, R7, R8, R9, R10, R11, R12, R13, R14);

execute DUT(clk, icode, ifun, valA, valB, valC, valE, cnd);

initial begin
    $dumpfile("execute.vcd");
    $dumpvars(0,execute_tb);
    $monitor($time,"clk = %d, icode= %b, ifun= %b, valA= %b, valB= %b, valC = %d, valE = %d, cnd = %d",clk, icode, ifun, valA, valB, valC, valE, cnd);

    R0 = 64'd0;
    R1 = 64'd1;
    R2 = 64'd2;
    R3 = 64'd3;
    R4 = 64'd4;
    R5 = 64'd5;
    R6 = 64'd6;
    R7 = 64'd7;
    R8 = 64'd8;
    R9 = 64'd9;
    R10 = 64'd10;
    R11 = 64'd11;
    R12 = 64'd12;
    R13 = 64'd13;
    R14 = 64'd14;

    clk=0;
    PC = 64'd0;

    PC = 64'h0;

    for (i = 1 ; i < 25;i = i + 1)
    begin
        #5;
        if (i%2 == 0)
        begin
            clk = ~clk;

            PC = valP;
        end
        else begin
            clk = ~clk;
        end
    end


end

endmodule
