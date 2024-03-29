module Arithmetic_unit (
    input [7:0] A, B,
    input Cin,
    input [1:0] S,
    output [7:0] Data,
    output Cout
);
    reg [7:0] AddB;
    //MUX for selecting B for adder
    always@(*) begin
        case (S)
            0: AddB = 8'b0;
            1: AddB = B;
            2: AddB = ~B;
            3: AddB = 8'b11111111; //-1
        endcase
    end
    //Adder with Cin & Cout
    assign {Cout, Data} = A + AddB + Cin;
endmodule