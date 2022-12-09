module midterm(clk, pause_b, acc_b, mode_b, inc_b, seg0, seg1, seg2, seg3);
    input clk, pause_b, acc_b, mode_b, inc_b;
    output [6:0] seg0, seg1, seg2, seg3;
	reg pause, small_counter;
    reg [1:0] mode;
    reg [11:0] timer;
    reg [3:0] blink;
    wire pause_w, acc_w, custom_clk, mode_w, inc_w;
	wire [3:0] s0, s1, m0, m1;

    debounce PB(clk, pause_b, pause_w);
	debounce ACC(clk, acc_b, acc_w);
    debounce MODE(clk, mode_b, mode_w);
    debounce INC(clk, inc_b, inc_w);
    seg7_w_blink S0(clk, s0, blink[0], seg0);
    seg7_w_blink S1(clk, s1, blink[1], seg1);
    seg7_w_blink M0(clk, m0, blink[2], seg2);
    seg7_w_blink M1(clk, m1, blink[3], seg3);

    clock var_clk(clk, acc_w, custom_clk);
    decoder dec(timer, s0, s1, m0, m1);
    
    always@(posedge clk) begin
		if (pause_w)
            pause <= ~pause;
        else if (!timer && !small_counter)
            pause <= 1;
				
		if (!timer)
			 small_counter <= 1;
		else
			 small_counter <= 0;
        //mode 1/2 pause clock
        if (mode == 1 || mode == 2)
            pause <= 1;
	end

    always@(posedge clk) begin
        case (mode)
            //count down
            0: begin
                if (custom_clk) begin
                    if (!pause) begin
                        if (!timer && small_counter) begin
                            timer <= 3599;
                        end
                        else begin
                            timer <= timer - 1;
                        end
                    end
                end
                //set blink when 00:00
                if (!timer)
                    blink = 4'b1111;
                else
                    blink = 4'd0;
                if (mode_w)
                    mode <= 1;                
            end
            //change min
            1: begin
                blink = 4'b1100;
                if (inc_w)
                    timer <= ((((timer/60) + 1)%60)*60)+ (timer%60);
                if (mode_w)
                    mode <= 2;
            end
            //change sec
            2: begin
                blink = 4'b0011;
                if (inc_w)
                    timer <= (((timer%60) + 1)%60) + (timer/60)*60;
                if (mode_w)
                    mode <= 0;                
            end
            default: begin
                if (mode_w)
                    mode <= 0;
            end
        endcase
    end
endmodule
