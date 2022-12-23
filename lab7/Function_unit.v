module Function_unit (
    input [3:0] FS,
    input [7:0] A, B,
    output V, C, N, Z,
    output [7:0] F
);
    wire [7:0] ALU_data, sh_data;
    wire Cout, Overflow;
    //ALU
    ALU(A, B, FS[0], FS[3:1], ALU_data, Cout, Overflow);
    //Shifter
    Shifter(B, FS[1:0], 0, 0, sh_data);

    //MUX for select data from ALU or shifter
    always@(*) begin
        case (FS[3:2])
            3: F =  sh_data;
            default: F = ALU_data;
        endcase
    end
    
    //assign for C(Carry out), V(Overflow), N(negative), Z(zero)
    assign C = Cout;
    assign V = Overflow;
    assign N = F[7];
    assign Z = (F == 8'd0) ? 1 : 0;
endmodule