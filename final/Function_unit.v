module Function_unit (
    input [3:0] FS,
    input [7:0] A, B,
    output V, C, N, Z,
    output reg [7:0] F
);
    wire [7:0] ALU_data, sh_data;
    wire Cout, Overflow, MF; 
    //ALU
    ALU(A, B, FS[0], FS[3:1], ALU_data, Cout, Overflow);
    //Shifter
    shifter(B, FS[1:0], 0, 0, sh_data);

    //MF = FS[3] AND FS[2]
    assign MF = FS[3] & FS[2];

    //MUX for select data from ALU or shifter
    always@(*) begin
        case (MF)
            1: F =  sh_data;
            0: F = ALU_data;
            default: F = ALU_data;
        endcase
    end
    
    //assign for C(Carry out), V(Overflow), N(negative), Z(zero)
    assign C = Cout;
    assign V = Overflow;
    assign N = ALU_data[7] ^ V;
    assign Z = (ALU_data == 8'd0) ? 1 : 0;
endmodule