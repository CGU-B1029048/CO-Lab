module ALU (
    input [7:0] A, B,
    input Cin,
    input [2:0] S,
    output reg [7:0] Data,
    output Cout, Overflow
    );
    wire [7:0] Data_logic, Data_arithmetic;
    //input to Logic unit
    Logic_unit lu(A, B, {S[0], Cin}, Data_logic);
    //input to Aeithmetic unit
    Arithmetic_unit au(A, B, Cin, S[1:0], Data_arithmetic, Cout, Overflow);
    
    //MUX for deciding output source
    always@(*) begin
        case(S[2])
            0: Data = Data_arithmetic;
            1: Data = Data_logic;
        endcase
    end

endmodule
