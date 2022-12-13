module Logic_unit (
    input clk,
    input [7:0] A, B,
    input [1:0] S,
    output [7:0] Data
);
    //MUX for selecting logic operation
    always@(posedge clk) begin
        case(S)
            0: Data = A&B; //AND
            1: Data = A|B; //OR
            2: Data = A^B; //XOR
            3: Data = ~A;  //Not
        endcase         
    end
endmodule