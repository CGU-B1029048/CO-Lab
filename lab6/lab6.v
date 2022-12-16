module lab6 (
    input [4:0] A, B,
    input Cin,
    input [2:0] S,
    output Cout,
    output [6:0] segA, seg_signA, segB, seg_signB, segData0, segData1, seg_signData
);
    reg [7:0] Data;
    reg [4:0] A1c, B1c, Data1c;

    //transfrom A B to 1's complement for 7 seg dispaly
    always@(*) begin
        case (A[4])
            1: A1c = ~A + 5'b10001;
            0: A1c = A;
        endcase
        case (B[4])
            1: B1c = ~B + 5'b10001;
            0: B1c = B;
        endcase
    end

    //transfrom Data to 1's complement for 7 seg dispaly
    always @(*) begin
        case (Data[7]) begin
            1: Data1c = ~Data + 1;
            0: Data1c = Data;
        end
    end


    //seg7 output A
    seg7_w_sign(1, {4{A1c[4]}}, seg_signA);
    seg7_w_sign(0, A1c[3:0], segA);
    //seg7 output B
    seg7_w_sign(1, {4{B1c[4]}}, seg_signB);
    seg7_w_sign(0, B1c[3:0], segB);
    //seg7 output Data
    seg7_w_sign(1, {4{Data[7]}}, seg_signData);
    seg7_w_sign(0, Data1c[3:0], segData0);
    seg7_w_sign(0, Data1c[7:4], segData1);

    //input to ALU module
    ALU({{3{A[4]}}, A[4:0]}, {{3{B[4]}}, B[4:0]}, Cin, S, Data, Cout); 
endmodule