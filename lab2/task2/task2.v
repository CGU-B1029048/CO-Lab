module task2(sw, LED);
 input [2:0] sw;
 output reg [7:0] LED;
 
 always@(*) begin
 LED <= 8'd0;
	 case(sw)
		3'b000: LED[0] <= 1'b1;
		3'b001: LED[1] <= 1'b1;
		3'b010: LED[2] <= 1'b1;
		3'b011: LED[3] <= 1'b1;
		3'b100: LED[4] <= 1'b1;
		3'b101: LED[5] <= 1'b1;
		3'b110: LED[6] <= 1'b1;
		3'b111: LED[7] <= 1'b1;
		default: LED <= 8'd0;
	 endcase
 end
endmodule