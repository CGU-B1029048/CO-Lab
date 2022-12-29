module Top(clk,reset, PC,Address_out,Data_out,Data_in,IR,MW);
	input clk,reset;
	output [7:0] PC,Address_out,Data_out,Data_in;
	output [15:0] IR;
	output MW;
	CPU cpu(IR,Data_in,PC,Address_out,Data_out,MW,clk,reset);
	IMEM imem(.Address(PC),.Instruction_out(IR));
	DMEM dmem(.MW(MW),.Address(Address_out),.Data_in(Data_out),.Data_out(Data_in),.clk(clk));
endmodule
