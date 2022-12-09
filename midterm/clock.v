module clock(clk, acc, output_pulses);
    input clk, acc;
    output reg output_pulses;
    reg S ,clock_out;
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
                output_pulses <= 1;
            end else begin
                counter <= counter + 1;
                output_pulses <= 0;
            end
        end
        1: begin
            if (counter >= clk_freq1) begin
                counter <= 1;
                clock_out <= ~clock_out;
                output_pulses <= 1;
            end else begin
                counter <= counter + 1;
                output_pulses <= 0;
            end
        end
        endcase
    end
endmodule
