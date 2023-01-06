module Top(clk,reset, PC,Address_out,Data_out,Data_in,IR,MW, R0, R1, R2, R3, R4, R5, R6, R7,DR,SA,SB);
	input clk,reset;
	output [7:0] PC,Address_out,Data_out,Data_in;
	output [7:0] R0, R1, R2, R3, R4, R5, R6, R7;
	output [15:0] IR;
	output [2:0] DR,SA,SB;
	output MW;
	CPU cpu(IR,Data_in,PC,Address_out,Data_out,MW,clk,reset, R0, R1, R2, R3, R4, R5, R6, R7,DR,SA,SB);
	IMEM imem(.Address(PC),.Instruction_out(IR));
	DMEM dmem(.MW(MW),.Address(Address_out),.Data_in(Data_out),.Data_out(Data_in),.clk(clk));
endmodule
