module task3(clk, LED);
	input clk;
	output reg LED;
	reg [25:0] counter;
	
	always@(posedge clk) begin
		if (counter < 26'd50000000)
			begin
			counter <= counter+1;
			end
		else
			begin
			counter <= 26'd0;
			LED = ~LED;
			end
	end
endmodule
		