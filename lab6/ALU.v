module ALU (
    input [7:0] A, B,
    input Cin, clk,
    input [2:0] S,
    output [7:0] Data,
    output Cout
    );
    wire Data_logic, Data_arithmetic;
    //input to Logic unit
    Logic_unit(clk, A, B, {S[0], Cin}, Data_logic);
    //input to Aeithmetic unit
    Arithmetic_unit(clk, A, B, Cin, S[1:0], Data_arithmetic, Cout);
    
    //MUX for deciding output source
    always@(posedge clk) begin
        case(S[2])
            0: Data = Data_arithmetic;
            1: Data = Data_logic;
        endcase
    end
    
endmodule
