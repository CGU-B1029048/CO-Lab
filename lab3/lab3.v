module lab3(clk, button, LED_out);
    input clk, button;
    output reg LED_out;
	wire button_out;
    reg EN;
	reg [1:0] S;
    reg [25:0] counter;
	debounce Deb(clk, button, button_out);
	 
    always@(posedge clk) begin
		  if (button_out) begin
			  case (S)
					0: S <= 1;
					1: S <= 2;
					2: S <= 0;
					default: S <= 0;
			  endcase
		  end
    end

    always@(posedge clk) begin
		if (S==2) begin
            if (counter < 26'd50000000) begin
                counter <= counter+1;
                end
            else begin
                counter <= 26'd0;
                EN = ~EN;
                end
        end
	end

    always@(*) begin
        case (S)
            0: LED_out <= 0;
            1: LED_out <= 1;
			2: LED_out <= EN;
			default: LED_out <= 0;
        endcase 
    end
endmodule