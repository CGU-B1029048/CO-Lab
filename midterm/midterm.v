module midterm(clk, pause_b, acc_b, seg0, seg1, seg2, seg3);
    input clk, pause_b, acc_b;
    output [6:0] seg0, seg1, seg2, seg3;
	reg pause, start, small_counter;
    reg [11:0] timer;
    wire pause_w, acc_w, custom_clk, blink;
	wire [3:0] s0, s1, m0, m1;
	//debug
	//output reg pause;

    debounce PB(clk, pause_b, pause_w);
	debounce ACC(clk, acc_b, acc_w);
    seg7_w_blink S0(clk, s0, blink, seg0);
    seg7_w_blink S1(clk, s1, blink, seg1);
    seg7_w_blink M0(clk, m0, blink, seg2);
    seg7_w_blink M1(clk, m1, blink, seg3);

    clock var_clk(clk, acc_w, custom_clk);
    decoder dec(timer, s0, s1, m0, m1, blink);
 
    always@(posedge clk) begin
		if (pause_w)
            pause <= ~pause;
        else if (!timer)
            pause <= 1;
	end

    always@(posedge custom_clk) begin
        if (!pause) begin
            if (!timer) begin
                small_counter <= 1;
                if (small_counter && pause)
                    timer <= 3599;
            end
            else begin
                timer <= timer - 1;
                small_counter <= 0;
            end
        end
    end
endmodule
