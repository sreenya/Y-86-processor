module fetchreg(clk, predictedPC, f_predictedPC);

input clk;
input [63:0] predictedPC;

output reg [63:0]f_predictedPC;

always @(posedge clk ) 
begin
    f_predictedPC<=predictedPC;
end

endmodule
