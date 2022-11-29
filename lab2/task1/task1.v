module task1(A, B, R, G);
 input A, B;
 output reg R, G;
 
 always@(*) begin
   R <= A & B;
   G <= A | B;
 end
endmodule