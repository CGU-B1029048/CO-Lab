module decoder(timer, sec0, sec1, min0, min1, blink);
    input [11:0] timer;
    output reg sec0, sec1, min0, min1;
    output blink;
    reg [5:0] min, sec;

    always@(*) begin
        if (!timer)
            blink = 1;
        else
            blink = 0;
    end

    always@(*) begin
        min = timer / 60;
        sec = timer % 60;
        min1 = min / 10;
        min0 = min % 10;
        sec1 = sec / 10;
        sec0 = sec % 10;
    end
endmodule