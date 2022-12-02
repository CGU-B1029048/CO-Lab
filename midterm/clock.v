module clock(clk, acc, clock_out);
    input clk, acc;
    output reg clock_out;
    reg S;
    reg [25:0] counter;
    parameter clk_freq1 = 2500000;
    parameter clk_freq0 = 25000000;

    always@(posedge clk) begin
        if (acc)
		      S <= ~S;
    end
	 
    always@(posedge clk) begin
        case(S)
        0: begin
            if (counter >= clk_freq0) begin
                counter <= 1;
                clock_out <= ~clock_out;
            end else
                counter <= counter + 1;
        end
        1: begin
            if (counter >= clk_freq1) begin
                counter <= 1;
                clock_out <= ~clock_out;
            end else
                counter <= counter + 1;
        end
        endcase
    end
endmodule
