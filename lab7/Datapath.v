module Datapath (
    //Control Word
    input [15:0] control_word,
    //other inputs 
    input reset, clk,
    input [7:0] Data_in, constant_in,
    output [7:0] Data_out, Address_out,
    output V, C, D, Z
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
    Register_File(DA_Data, DA, AA, BA, RW, reset, clk, Bus_A, RFout_B);
    //Function Unit
    Function_unit(FS, Bus_A, Bus_B, V, C, D, Z, FU_Data);
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