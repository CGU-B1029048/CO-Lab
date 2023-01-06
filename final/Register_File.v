module Register_File (
    input [7:0] Data,
    input [2:0] DA, AA, BA,
    input RW, reset, clk,
    output reg [7:0] A, B,
    output reg [7:0] R0, R1, R2, R3, R4, R5, R6, R7
);

    //register load & reset w/ clk
    always@(posedge clk) begin
        //Load while RW is true
        if (RW) begin
            case(DA)
                0: R0 <= Data;
                1: R1 <= Data;
                2: R2 <= Data;
                3: R3 <= Data;
                4: R4 <= Data;
                5: R5 <= Data;
                6: R6 <= Data;
                7: R7 <= Data;
            endcase
        end

        //reset
        if (reset) begin
            R0 <= 8'd0;
            R1 <= 8'd0;
            R2 <= 8'd0;
            R3 <= 8'd0;
            R4 <= 8'd0;
            R5 <= 8'd0;
            R6 <= 8'd0;
            R7 <= 8'd0;
        end
    end

    //MUX A select and B select
    always@(*) begin
        //A select
        case (AA)
            0: A = R0; 
            1: A = R1; 
            2: A = R2; 
            3: A = R3; 
            4: A = R4; 
            5: A = R5; 
            6: A = R6; 
            7: A = R7; 
        endcase
        //B select
        case (BA)
            0: B = R0;
            1: B = R1;
            2: B = R2;
            3: B = R3;
            4: B = R4;
            5: B = R5;
            6: B = R6;
            7: B = R7;
        endcase
    end
endmodule
