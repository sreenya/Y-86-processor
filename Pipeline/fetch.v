module fetch(clk,PC,icode,ifun,rA,rB,valC,valP,instr_valid,imem_error, instruction);

input clk;
input [63:0] PC;
output reg [3:0] icode, ifun, rA, rB;
output reg [63:0] valC, valP;
output reg instr_valid, imem_error;

initial begin
    imem[0] = 8'b00110000; //30
    imem[1] = 8'b11100000; //E0
    imem[2] = 8'b00000000;
    imem[3] = 8'b00000000;
    imem[4] = 8'b00000000;
    imem[5] = 8'b00000000;
    imem[6] = 8'b00000000;
    imem[7] = 8'b00000000;
    imem[8] = 8'b00000000;
    imem[9] = 8'b00000000; // valC = 0
    imem[10] = 8'b00110000; //30
    imem[11] = 8'b11100011; //E3
    imem[12] = 8'b00000000;
    imem[13] = 8'b00000000;
    imem[14] = 8'b00000000;
    imem[15] = 8'b00000000;
    imem[16] = 8'b00000000;
    imem[17] = 8'b00000000;
    imem[18] = 8'b00000000;
    imem[19] = 8'b00010001; //v
    imem[20] = 8'b00100000; //20
    imem[21] = 8'b00000110; //06
    imem[22] = 8'b00100000; //20
    imem[23] = 8'b00110000; //30
    imem[24] = 8'b00100000; //20
    imem[25] = 8'b01100000; //60


end
reg [7:0] imem[0:1023];
output reg [0:79] instruction;

always@(posedge clk)
begin
    imem_error = PC>1024 ? 1 : 0;
    instruction = {imem[PC],imem[PC+1],imem[PC+2],imem[PC+3],imem[PC+4],
    imem[PC+5],imem[PC+6],imem[PC+7],imem[PC+8],imem[PC+9]};
    
    icode= instruction[0:3];
    ifun= instruction[4:7];

    instr_valid = 1'b0;

    case(icode)

        //nop
        4'b0001: begin
          valP = PC + 64'd1;
            instr_valid = 1'b1;
        end

        //cmmovxx
        4'b0010: begin
            rA=instruction[8:11];
            rB=instruction[12:15];
            valP=PC+64'd2;
            instr_valid = 1'b1;
        end

        //irmovq
        4'b0011: begin
            rA=instruction[8:11];
            rB=instruction[12:15];
            valC=instruction[16:79];
            valP=PC+64'd10;
            instr_valid = 1'b1;
        end

        //rmmovq
        4'b0100: begin
            rA=instruction[8:11];
            rB=instruction[12:15];
            valC=instruction[16:79];
            valP=PC+64'd10;
            instr_valid = 1'b1;
        end

        //mrmovq
        4'b0101: begin
            rA=instruction[8:11];
            rB=instruction[12:15];
            valC=instruction[16:79];
            valP=PC+64'd10;
            instr_valid = 1'b1;
        end

        //OPq
        4'b0110: begin
            rA = instruction[8:11];
            rB = instruction[12:15];
            valP = PC + 64'd2;
            instr_valid = 1'b1;
        end

        //jxx
        4'b0111: begin
            valC=instruction[8:71];
            valP=PC+64'd9;
            instr_valid = 1'b1;
        end

        //call
        4'b1000: begin
            valC=instruction[8:71];
            valP=PC+64'd9;
            instr_valid = 1'b1;
        end

        //ret
        4'b1001: begin
            valP=PC+64'd1;
            instr_valid = 1'b1;
        end

        //pushq
        4'b1010: begin
            rA=instruction[8:11];
            rB=instruction[12:15];
            valP=PC+64'd2;
            instr_valid = 1'b1;
        end

        //popq
        4'b1011: begin
            rA=instruction[8:11];
            rB=instruction[12:15];
            valP=PC+64'd2;
            instr_valid = 1'b1;
        end
    endcase


end

endmodule