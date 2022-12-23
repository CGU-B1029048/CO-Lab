module shifter (
    input [7:0] B,
    input [1:0] H_S,
    input I_L, I_R,
    output reg [7:0] Data
);
    //MUX for select shift left or right or NC
    always@(*) begin
        case(H_S)
            0: Data = B;
            1: Data = {I_R, B[7:1]};
            2: Data = {B[6:0], I_L};
            default: Data = B;
        endcase
    end
endmodule