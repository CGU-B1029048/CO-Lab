module lab6 (
    input [4:0] A, B,
    input Cin,
    input [2:0] S,
    output [7:0] Data,
    output Cout,
    output [6:0] segA, seg_signA, segB, seg_signB, segData, seg_signData
);
    //seg7 output A
    seg7_w_sign(1, {4{A[4]}}, seg_signA);
    seg7_w_sign(0, A[3:0], seg_A);
    //seg7 output B
    seg7_w_sign(1, {4{B[4]}}, seg_signB);
    seg7_w_sign(0, B[3:0], seg_B);
    //seg7 output Data
    seg7_w_sign(1, {4{Data[4]}}, seg_signData);
    seg7_w_sign(0, Data[3:0], seg_Data);

    //input to ALU module
    ALU({{3{A[4]}}, A[4:0]}, {{3{B[4]}}, B[4:0]}, Cin, S, Data, Cout); 
endmodule