module lab6 (
    input [7:0] A, B,
    input Cin, clk,
    input [2:0] S,
    output reg [7:0] Data
    output Cout;
);

    always@(posedge clk) begin
        case(S[2])
            0:begin
                case (S[1:0])
                    0: Data = A + Cin; 
                    1: Data = A + B + Cin; 
                    2: Data = A + ~B + Cin; 
                    3: Data = A - 1 + Cin; 
                endcase
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
