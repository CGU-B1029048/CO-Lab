module Datapath (
    input [2:0] DA, AA, BA,
    input [3:0] FS,
    input MB, MD, RW, reset, clk
    input [7:0] Data_in, constant_in,
    output [7:0] Data_out, Address_out,
    output V, C, D, Z
);
    wire [7:0] Bus_A, Bus_B, RFout_B, FU_Data, DA_Data;

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