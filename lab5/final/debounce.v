module debounce(clk, button_in, button_out);
    input clk, button_in;
    output reg button_out;

    reg [25:0] counter;

    parameter divn_num = 5000000;

    always@(posedge clk) begin
        if (button_in) 
            counter <= 0;
        else if (counter != divn_num)
            counter <= counter + 1; 
    end

    always@(*) begin
        if (counter == divn_num - 1)
            button_out = 1'b1;
        else
            button_out = 1'b0;
    end
endmodule
