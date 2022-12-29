`timescale 1ns/1ps
module Top_tb;
	reg clk,reset;
	wire [7:0] PC,Address_out,Data_out,Data_in;
	wire [15:0] IR;
	wire MW;
    Top DUT(clk,reset,PC,Address_out,Data_out,Data_in,IR,MW);

	initial begin
		clk = 0;
		reset = 1;
		#15 reset = 0;
	end
	always begin
		#10 clk = ~clk;
	end

endmodule
