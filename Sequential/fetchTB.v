module fetch_testbench;

reg clk;
reg [63:0] PC;

wire [3:0] icode, ifun,rA, rB;
wire [63:0] valC, valP;
wire instr_valid, imem_error;
wire [79:0] instruction;

fetch DUT(clk,PC,icode,ifun,rA,rB,valC,valP,instr_valid,imem_error, instruction);

integer i;

initial begin
    $dumpfile("fetch.vcd");
    $dumpvars(0,fetch_testbench);
    $monitor($time," clk=%d, PC=%d, icode=%b, ifun=%b, rA=%b, rB=%b, valC=%d, valP=%d, instr_valid=%b, imem_error=%b instr = %d ",clk,PC,icode,ifun,rA,rB,valC,valP,instr_valid,imem_error, instruction);

    clk = 0;
    PC = 64'h0;

    // #5 clk = ~clk;
    // // PC = 64'h20;

    // #5 clk = ~clk;
    // #5 PC = valP;

    for (i = 1 ; i < 10;i = i + 1)
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