module Datapath (
    //Control Word
    input [15:0] control_word,
    //other inputs 
    input reset, clk,
    input [7:0] Data_in, constant_in,
    output [7:0] Data_out, Address_out,
    output V, C, N, Z,
	 output wire [7:0] R0, R1, R2, R3, R4, R5, R6, R7
);
    //Control Word decode
    wire [2:0] DA, AA, BA;
    wire MB;
    wire [3:0] FS;
    wire MD, RW;
    wire [7:0] Bus_A, RFout_B, FU_Data;
    reg [7:0] Bus_B, DA_Data;

    //Control Word decode assignment
    assign {DA, AA, BA, MB, FS, MD, RW} = control_word;     

    //register file
    Register_File ef(DA_Data, DA, AA, BA, RW, reset, clk, Bus_A, RFout_B, R0, R1, R2, R3, R4, R5, R6, R7);
    //Function Unit
    Function_unit fu(FS, Bus_A, Bus_B, V, C, N, Z, FU_Data);
    //output Bus A & B
    assign Data_out = Bus_B;
    assign Address_out = Bus_A;

    //MUX B
    always@(*) begin
        case (MB)
            0: Bus_B = RFout_B;
            1: Bus_B = constant_in;
            default: Bus_B = RFout_B;
        endcase
    end

    //MUX D
    always@(*) begin
        case (MD)
            0: DA_Data = FU_Data;
            1: DA_Data = Data_in; 
            default: DA_Data = FU_Data;
        endcase
    end

endmodule
