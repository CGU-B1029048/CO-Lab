module midterm(clk, pause_b, acc_b, seg0, seg1, seg2, seg3);
    input clk, pause_b;
    output [6:0] seg0, seg1, seg2, seg3;
    reg [11:0] timer;
    wire pause, custom_clk, blink;

    debounce PB(clk, pause_b, pause);
    seg7_w_blink S0(clk, s0, blink, seg0);
    seg7_w_blink S1(clk, s1, blink, seg1);
    seg7_w_blink M0(clk, m0, blink, seg2);
    seg7_w_blink M1(clk, m1, blink, seg3);

    clock var_clk(clk, acc_b, custom_clk);
    decoder dec(timer, s0, s1, m0, m1, blink);
 
    always@(posedge pause)
        pause <= ~pause;

    always@(posedge custom_clk) begin
        if (!pause) begin
            if (!timer) 
                timer <= 3599;
            else
                timer <= timer - 1;
        end
    end
endmodule