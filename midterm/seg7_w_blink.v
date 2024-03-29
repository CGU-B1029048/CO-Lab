module seg7_w_blink(clk, in, blink, out);
    input [3:0] in;
    input blink, clk;
    reg dark;
    reg [25:0] counter;
    output reg [6:0] out;
    parameter gap = 25000000;  //blink freq

    always@(posedge clk) begin 
        //blink = 1 will blink
        if (counter >= gap) begin
		      counter <= 0; 
            if (blink)
                dark <= ~dark;
            else
                dark <= 0;
        end else 
				counter <= counter + 1;
		  
    end

    always@(*) begin
        if (dark)
            out = 7'b1111111; //all dark 
        else begin
            case(in)
            4'b0000: out = 7'b1000000; //0
            4'b0001: out = 7'b1111001; //1
            4'b0010: out = 7'b0100100; //2
            4'b0011: out = 7'b0110000; //3
            4'b0100: out = 7'b0011001; //4
            4'b0101: out = 7'b0010010; //5
            4'b0110: out = 7'b0000010; //6
            4'b0111: out = 7'b1011000; //7
            4'b1000: out = 7'b0000000; //8
            4'b1001: out = 7'b0010000; //9
            4'b1010: out = 7'b0001000; //A
            4'b1011: out = 7'b0000011; //B
            4'b1100: out = 7'b1000110; //C
            4'b1101: out = 7'b0100001; //D
            4'b1110: out = 7'b0000110; //E
            4'b1111: out = 7'b0001110; //F
            default: out = 7'bx;
            endcase
        end
    end
endmodule
