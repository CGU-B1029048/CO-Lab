module lab5(clk, count_d_b, start_b, fast_b, slow_b, seg0, seg1, seg2, seg3, spdseg0, spdseg1);
    input clk, count_d_b, start_b, fast_b, slow_b;
    output [6:0] seg0, seg1, seg2, seg3, spdseg0, spdseg1;
    reg [3:0] s0, s1, m0, m1, sQ0, sQ1;
	 reg [5:0] sec, min;
    reg [25:0] counter;
	 reg [11:0] seconds;
    reg [1:0] speed;
    reg tick, count_d, start;
    wire count_d_w, start_w, fast_w, slow_w;
    parameter clk_spd = 6250000;

    debounce cd(clk, count_d_b, count_d_w);
    debounce st(clk, start_b, start_w);
    debounce fst(clk, fast_b, fast_w);
    debounce slw(clk, slow_b, slow_w);
    
    seg7 S0(s0, seg0);
    seg7 S1(s1, seg1);
    seg7 M0(m0, seg2);
    seg7 M1(m1, seg3);
    seg7 spd0(sQ0, spdseg0);
    seg7 spd1(sQ1, spdseg1);

    always@(posedge clk) begin
        if (fast_w) begin
				if (speed == 0)
					 speed <= 0;
				else
                speed <= speed - 1;
		  end
        if (slow_w) begin
		      if (speed == 3)
					 speed <= 3;
            else
				    speed <=  speed + 1;
		  end
        case(speed)
            0: begin
                sQ0 <= 3'd0;
                sQ1 <= 3'd4;
            end
            1: begin
                sQ0 <= 3'd0;
                sQ1 <= 3'd2;
            end 
            2: begin
                sQ0 <= 3'd0;
                sQ1 <= 3'd1;
            end
			3: begin
				sQ0 <= 3'd5;
                sQ1 <= 3'd0;
            end
            default: speed <= 2;
        endcase
    end

    always@(posedge clk) begin
        if (counter != (clk_spd << speed)) 
            counter <= counter + 1;
        else begin
            counter <= 1;
            tick <= ~tick;
        end
    end

    always@(posedge start_w) begin
        start <= ~start;
    end

    always@(posedge count_d_w) begin
        count_d <= ~count_d;
    end

    always@(posedge tick) begin
        if (start) begin
            case (count_d) 
                1: begin
					     seconds <= seconds - 1; 
						  if (seconds == 0)
				            seconds <= 12'd3599;
						end
                0: begin
					     seconds <= seconds + 1;
						  if (seconds >= 12'd3599)
					         seconds <= 0;
						end
			   endcase
        end
    end
	 
	 always@(posedge clk) begin
        min = seconds / 60;
		  sec = seconds % 60;
		  m1 = min / 10;
		  m0 = min % 10;
		  s1 = sec / 10;
		  s0 = sec % 10;
	 end
endmodule
