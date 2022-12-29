module seg7_w_sign(sign ,in, out);
    input sign;
    input [3:0] in;
    output reg [6:0] out;

    always@(*) begin
        //sign bit display
        if (sign) begin
            case (in)
                4'b0000: out = 7'b1111111;
                4'b1111: out = 7'b0111111; 
                default: out = 7'bx;
            endcase
        //digit display         
        end else begin
            case(in)
            4'b0000: out = 7'b1000000;
            4'b0001: out = 7'b1111001;
            4'b0010: out = 7'b0100100;
            4'b0011: out = 7'b0110000;
            4'b0100: out = 7'b0011001;
            4'b0101: out = 7'b0010010;
            4'b0110: out = 7'b0000010;
            4'b0111: out = 7'b1011000;
            4'b1000: out = 7'b0000000;
            4'b1001: out = 7'b0010000;
            4'b1010: out = 7'b0001000;
            4'b1011: out = 7'b0000011;
            4'b1100: out = 7'b1000110;
            4'b1101: out = 7'b0100001;
            4'b1110: out = 7'b0000110;
            4'b1111: out = 7'b0001110;
            default: out = 7'bx;
            endcase
        end
    end
endmodule