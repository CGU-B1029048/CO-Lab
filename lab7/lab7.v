module lab7 (
    input [4:0] Data_in,
    input [2:0] DA, AA, BA,
    input start_b, reset_b, mode_b, clk,
    output C, V, D, Z,
    output [6:0] segA, seg_signA, segData0, segData1, seg_signData
);
    wire [7:0] Data, Address_out;
    wire start, reset, mode_w;
    reg [1:0] mode;
    reg [7:0] Data1c;
    reg [4:0] Data_in1c;
    reg [15:0] Control_word_in,
    reg [15:0] Control_word;

    debounce(clk, start_b, start);
    debounce(clk, reset_b, reset);
    debounce(clk, mode_b, mode_w);

    //state diagram of mode
    always@(posedge clk) begin
        if (mode_w) begin
            mode <= mode + 1;
        end
        case(mode)
            0: begin //load from reg
                Control_word_in <= {DA, AA, BA, 0, 4'b0000, 0, 0};
            end
            1: begin //load from data in
                Control_word_in <= {DA, AA, BA, 0, 4'b1100, 1, 0};
            end
            2: begin //add
                Control_word_in <= {DA, AA, BA, 0, 4'b0010, 0, 0};
            end
            3: begin //inc
                Control_word_in <= {DA, AA, BA, 0, 4'b0001, 0, 0};
            end
            default:
                Control_word_in <= {DA, AA, BA, 0, 4'b0000, 0, 0};
        endcase
    end

    //enter Control_word which will later goto Datapath while start_b pressed
    always@(posedge clk) begin
        if (start)
            Control_word <= Control_word_in;
    end

    //transfrom Data_in from 2's complement to 7 seg dispaly
    always@(*) begin
        case (Data_in[4])
            1: Data_in1c = ~Data_in + 1;
            0: Data_in1c = Data_in;
        endcase
    end

    //transfrom Data from 2's complement to 7 seg dispaly
    always @(*) begin
        case (Data[7])
            1: Data1c = ~Data + 1;
            0: Data1c = Data;
        endcase
    end

    //seg7 output Data_in
    seg7_w_sign(1, {4{Data_in[4]}}, seg_signA);
    seg7_w_sign(0, Data_in1c[3:0], segA);
    //seg7 output Data
    seg7_w_sign(1, {4{Data[7]}}, seg_signData);
    seg7_w_sign(0, Data1c[3:0], segData0);
    seg7_w_sign(0, Data1c[7:4], segData1);

    //input to Datapath module
    Datapath(
        //Control_word
        .control_word(Control_word),
        //other input
        .reset(reset),
        .clk(clk),
        .Data_in({{4{Data_in[4]}}, Data_in[3:0]}),
        .constant_in(8'd0),
        //output data
        .Data_out(Data),
        .Address_out(Address_out),
        //output signal
        .V(V),
        .C(C),
        .D(D),
        .Z(Z)
        );
endmodule
