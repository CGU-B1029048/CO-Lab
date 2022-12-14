module decoder(timer, sec0, sec1, min0, min1);
    input [11:0] timer;
    output reg [3:0] sec0, sec1, min0, min1;
    reg [5:0] min, sec;

    always@(*) begin
        min = timer / 60;
        sec = timer % 60;
        min1 = min / 10;
        min0 = min % 10;
        sec1 = sec / 10;
        sec0 = sec % 10;
    end
endmodule
