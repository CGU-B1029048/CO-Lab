module CPU(IR,Data_in,PC,Address_out,Data_out,MW,clk,reset);
	input clk,reset;
	input [15:0] IR;
	input [7:0] Data_in;
	output MW;
	output [7:0] PC,Address_out,Data_out;
	wire [15:0] control_word;
	wire PL, JB, BC;
	reg [7:0] PC,OP,AD,Constant_in;
	reg [6:0] Opcode;
	//reg [7:0] R [0:7];
	reg [2:0] DR,SA,SB;
	reg MW;

	always @(*) begin
		Opcode = IR[15:9];
		DR = IR[8:6];
		SA = IR[5:3];
		SB = IR[2:0];
		OP = {5'b00000,IR[2:0]};
		Constant_in = OP;
		AD = {{2{IR[8]}},IR[8:6],IR[2:0]};
		MW = IR[14]&&!IR[15];
	end
	
	// OPcode decode to control word for datapath
	assign control_word[15:7] = {DR, SA, SB}; //DA, AA, BA
	assign control_word[6] = IR[15]; //MB
	assign control_word[5:2] = {IR[11:9], IR[9]&~PL}; //FS
	assign control_word[1] = IR[13]; //MD
	assign control_word[0] = ~IR[14]; //RW
	assign PL = IR[15] & IR[14];
	assign JB = IR[13];
	assign BC = IR[9];

	// insert datapath
	Datapath(control_word, reset, clk, Data_in, Constant_in, Data_out, Address_out, V, C, D, Z);

	// Comment the following two lines after insesrting the datapath circuit
	// assign Address_out = R[SA];
	// assign Data_out = IR[15] ? Constant_in : R[SB];

	always @ (posedge clk) begin
		if(reset)begin
			PC <= 0;
		end
		else begin
			if ((IR[15]&&IR[14])==0)
				PC <= PC+1;
			// Comment the following case...endcase statement after insesrting the datapath circuit
			// case(Opcode)
			// 	7'b0000000: R[DR]<=R[SA];//MOVA
			// 	7'b0000001: R[DR]<=R[SA]+1;//INC
			// 	7'b0000010: R[DR]<=R[SA]+R[SB];//ADD
			// 	7'b0000101: R[DR]<=R[SA]-R[SB];//SUB
			// 	7'b0000110: R[DR]<=R[SA]-1;//DEC
			// 	7'b0001000: R[DR]<=R[SA]&R[SB];//AND
			// 	7'b0001001: R[DR]<=R[SA]|R[SB];//OR
			// 	7'b0001010: R[DR]<=R[SA]^R[SB];//XOR
			// 	7'b0001011: R[DR]<=~R[SA];//NOT
			// 	7'b0001100: R[DR]<=R[SB];//MOVB
			// 	7'b0001101: R[DR]<=R[SB]>>1;//SHR
			// 	7'b0001110: R[DR]<=R[SB]<<1;//SHL
			// 	7'b1001100: R[DR]<=OP;//LDI
			// 	7'b1000010: R[DR]<=R[SA]+OP;//ADI
			// 	7'b0010000: R[DR]<=Data_in;//LD
			// 	7'b0100000: Data_out<=R[SB];//ST
			// 	7'b1100000: 
			// 		begin
			// 			if(R[SA]==0) PC <= PC+AD;
			// 			else PC <= PC+1;
			// 		end//BRZ
			// 	7'b1100001: 
			// 		begin
			// 			if(R[SA]<0) PC <= PC+AD;
			// 			else PC <= PC+1;
			// 		end //BRN
			// 	7'b1110000: PC <= R[SA];//JMP
			// endcase
		end
	end
endmodule
