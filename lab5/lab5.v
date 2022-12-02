module lab5(clk, count_d_b, start_b, fast_b, slow_b, seg0, seg1, seg2, seg3, spdseg0, spdseg1);
    input clk, count_d_b, start_b, fast_b, slow_b;
    output [6:0] seg0, seg1, seg2, seg3, spdseg0, spdseg1;
    reg [3:0] Q0, Q1, Q2, Q3, sQ0, sQ1;
    reg [25:0] counter;
    reg [1:0] speed;
    reg tick, count_d, start;
    wire count_d_w, start_w, fast_w, slow_w;
    parameter sec = 12500000;

    debounce cd(clk, count_d_b, count_d_w);
    debounce st(clk, start_b, start_w);
    debounce fst(clk, fast_b, fast_w);
    debounce slw(clk, slow_b, slow_w);
    
    seg7 s0(Q0, seg0);
    seg7 s1(Q1, seg1);
    seg7 m0(Q2, seg2);
    seg7 m1(Q3, seg3);
    seg7 spd0(sQ0, spdseg0);
    seg7 spd1(sQ1, spdseg1);

    always@(posedge clk) begin
        if (fast_w) 
            speed <= speed - 1;
        if (slow_w) 
            speed <=  speed + 1;
        case(speed)
            0: begin
                sQ0 <= 3'd0;
                sQ1 <= 3'd2;
            end
            1: begin
                sQ0 <= 3'd0;
                sQ1 <= 3'd1;
            end 
            2: begin
                sQ0 <= 3'd5;
                sQ1 <= 3'd0;
            end
            default: speed <= 1;
        endcase
    end

    always@(posedge clk) begin
        if (counter != (sec << speed)) 
            counter <= counter + 1;
        else begin
            counter <= 0;
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
            if (count_d) begin
                Q0 <= Q0 - 1;
                if (Q0 == 0) begin
                    Q1 <= Q1 - 1;
                    Q0 <= 9;
                end
                if (Q1 == 0 && Q0 == 0) begin
                    Q2 <= Q2 - 1;
                    Q1 <= 5;
                end
                if (Q2 == 0 && Q1 == 0 && Q0 == 0) begin
                    Q3 <= Q3 - 1;
                    Q2 <= 9;
                end
                if (Q3 == 0 && Q2 == 0 && Q1 == 0 && Q0 == 0)
                    Q3 <= 5;
            end else begin
                Q0 <= Q0 + 1;
                if (Q0 == 9) begin
                    Q1 <= Q1 + 1;
                    Q0 <= 0;
                end
                if (Q1 == 5 && Q0 == 9) begin
                    Q2 <= Q2 + 1;
                    Q1 <= 0;
                end
                if (Q2 == 9 && Q1 == 5 && Q0 == 9) begin
                    Q3 <= Q3 + 1;
                    Q2 <= 0;
                end
                if (Q3 == 5 && Q2 == 9 && Q1 == 5 && Q0 == 9)
                    Q3 <= 0;
            end
        end
    end
endmodule
