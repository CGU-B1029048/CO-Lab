module clock(clk, acc_b, clock_out);
    input clk, acc_b;
    output reg clock_out;
    reg S;
    reg [25:0] counter;
    wire acc;
    parameter clk_freq1 = 2500000;
    parameter clk_freq0 = 25000000;

    debounce ACCB(clk, acc_b, acc);

    always@(posedge acc) begin
        S <= ~S;
    end
    always@(posedge clk) begin
        case(S)
        0: begin
            if (counter == clk_freq0) begin
                counter <= 0;
                clock_out <= ~clock_out
            end else
                counter <= counter + 1;
        end
        1: begin
            if (counter == clk_freq2) begin
                counter <= 0;
                clock_out <= ~clock_out
            end else
                counter <= counter + 1;
        end
        endcase
    end
endmodule