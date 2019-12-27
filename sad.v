module prescaler29(input clk,output clk_out);
parameter N = 7; // 2^N = 100MHZ / F_out // F_out = 5Hz //
reg [N-1:0] count = 0;
assign clk_out = count[N-1];
	always @(posedge(clk)) begin
			  count <= count + 1;
			end
endmodule
