module lab4(clk, Load, Shift_en, Shift_dir, Add__b, dip_sw, LED, segL, segR);
    input Load, Shift_en, Shift_dir, Add__b, clk;
    input [7:0] dip_sw;
    output reg [7:0] LED;
    output [6:0] segL, segR;
    wire Load_w, Shift_en_w, Add_b_w;
    
    debounce PLoad(clk, Load, Load_w);
    debounce ENShift(clk, Shift_en, Shift_en_w);
    debounce ADDB(clk, Add__b, Add_b_w);

    sevseg seg1(LED[3:0], segR);
    sevseg seg2(LED[7:4], segL);

    always@(posedge clk) begin
        if (Load_w)
            LED <= dip_sw;
        if (Shift_en_w) begin
            if (Shift_dir) begin
					 LED <= LED >> 1;            
            end else begin
					 LED <= LED << 1;        
            end
        end
        if (Add_b_w)
            LED <= LED + dip_sw;
    end
endmodule
