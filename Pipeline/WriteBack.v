module writeBack(icode,clk,rA,rB,valA,valB,valE,valM);

input clk;
input [3:0] icode,rA,rB;
input [63:0] valA,valB,valE,valM;

reg [63:0] reg_mem[0:14];

always@(*)
begin
    case(icode)
        //cmmovXX rA rB
        4'b0010: begin
            reg_mem[rB]=valE;
        end

        //irmovq
        4'b0011: begin
            reg_mem[rB]=valE;
        end

        //rmmovq
        4'b0101:  begin
            reg_mem[rA]=valM;
        end

        //OPq
        4'b0110: begin
            reg_mem[rB]=valE;
        end

        //call
        4'b1000: begin
            reg_mem[4]=valE;
        end

        //ret
        4'b1001: begin
            reg_mem[4]=valE;
        end

        //pushq
        4'b1010: begin
            reg_mem[4]=valE;
        end

        //popq
        4'b1011: begin
            reg_mem[4]=valE;
            reg_mem[rA]=valM;
        end
    endcase
end


endmodule
