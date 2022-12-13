module lab6 (
    input [7:0] A, B,
    input Cin, clk,
    input [2:0] S,
    output reg [7:0] Data,
    output Cout
    );
    reg [7:0] AddB;

    always@(posedge clk) begin
        case(S[2])
            0:begin
                case (S[1:0])
                    0: AddB = 8'b0;
                    1: AddB = B;
                    2: AddB = ~B;
                    3: AddB = 8'b11111111;
                endcase
                Data = A + AddB + Cin;
            end
            1: begin
                case({S[0], Cin})
                    0: Data = A&B;
                    1: Data = A|B;
                    2: Data = A^B;
                    3: Data = ~A;
                endcase                
            end
        endcase
    end
    
endmodule
