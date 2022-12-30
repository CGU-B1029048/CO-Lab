module lab7 (
    input [4:0] Data_in,
    input [2:0] DA, AA, BA,
    input start_b, reset_b, mode_b, clk,
    output C, V, N, Z,
    output reg [1:0] mode,
    output [6:0] segA, seg_signA, segData0, segData1, seg_signData
);
    wire [7:0] Data, Address_out;
    wire start, reset, mode_w;
    reg [7:0] Data1c;
    reg [4:0] Data_in1c;
    reg [15:0] Control_word_in;
    reg [15:0] Control_word;

    debounce(clk, start_b, start);
    debounce(clk, reset_b, reset);
    debounce(clk, mode_b, mode_w);

    //state diagram of mode
    always@(posedge clk) begin
        if (mode_w) begin
            mode <= mode + 1;
        end
        // Control_word_in[15:13] <= DA;
        // Control_word_in[12:10] <= AA;
        // Control_word_in[9:7] <= BA;
        // Control_word_in[6] <= 0; //MB
        // Control_word_in[0] <= 1; //RW
        case(mode)
            0: begin //load A
                Control_word_in[15:13] <= 3'b000; //DA = R0
                Control_word_in[12:10] <= 3'b000; //AA = R0
                Control_word_in[9:7] <= 3'b000; //BA = R0
                Control_word_in[6] <= 0; //MB = 0, Register
                Control_word_in[5:2] <= 4'b0000; //FS = 0000 MOVA
                Control_word_in[1] <= 1; //MD = 1, Data in
                Control_word_in[0] <= 1; //RW = 1, Write 
            end
            1: begin //load B
                Control_word_in[15:13] <= 3'b001; //DA = R1
                Control_word_in[12:10] <= 3'b001; //AA = R1
                Control_word_in[9:7] <= 3'b001; //BA = R1
                Control_word_in[6] <= 0; //MB = 0, Register
                Control_word_in[5:2] <= 4'b0000; //FS = 0000 MOVA
                Control_word_in[1] <= 1; //MD = 1, Data in
                Control_word_in[0] <= 1; //RW = 1, Write 
            end
            2: begin //add
                Control_word_in[15:13] <= 3'b010; //DA = R2
                Control_word_in[12:10] <= 3'b001; //AA = R1
                Control_word_in[9:7] <= 3'b000; //BA = R0
                Control_word_in[6] <= 0; //MB = 0, Register
                Control_word_in[5:2] <= 4'b0010; //FS = 0010 ADD
                Control_word_in[1] <= 0; //MD = 1, Function
                Control_word_in[0] <= 1; //RW = 1, Write 
            end
            3: begin //reset
                Control_word_in[15:13] <= 3'b010; //DA = R2
                Control_word_in[12:10] <= 3'b000; //AA = R0
                Control_word_in[9:7] <= 3'b000; //BA = R0
                Control_word_in[6] <= 1; //MB = 1, Constant
                Control_word_in[5:2] <= 4'b1100; //FS = 1100 MOVB
                Control_word_in[1] <= 0; //MD = 1, Function
                Control_word_in[0] <= 1; //RW = 1, Write 

            end
            default:
                Control_word_in[5:1] <= 5'b00000;
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
        .N(N),
        .Z(Z)
        );
endmodule
