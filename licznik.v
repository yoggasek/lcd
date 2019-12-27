module prescaler(input clk,output clk_out);
parameter N = 24; // 2^N = 100MHZ / F_out // F_out = 5Hz //
reg [N-1:0] count = 0;
assign clk_out = count[N-1];
	always @(posedge(clk)) begin
			  count <= count + 1;
			end
endmodule

module debounce(input pb_1,input clk, output pb_out);
wire Q1,Q2,Q2_bar;
prescaler n1(clk, clk_out);
dflipflop d1(clk_out, pb_1,Q1 );
dflipflop d2(clk_out, Q1,Q2 );
assign Q2_bar = ~Q2;
assign pb_out = Q1 & Q2_bar;
endmodule

module dflipflop(input DFF_CLOCK, D, output reg Q);
    always @ (posedge DFF_CLOCK) begin
        Q <= D;
    end

endmodule

module counter(
	 input clk,
	 output clk_out,
	 input button,
	 output button_deb,
    output reg [3:0] l
);
	 prescaler na(clk, clk_out);
	 debounce b1(button,clk,button_deb);
    always @(posedge clk_out)
	 if(button_deb)
       l <= l + 1;

endmodule
