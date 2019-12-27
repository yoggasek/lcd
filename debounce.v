module debounce(input pb_1,input clk, output pb_out);
wire Q1,Q2,Q2_bar;
prescaler n1(clk, clk_out);
dflipflop d1(clk_out, pb_1,Q1 );
dflipflop d2(clk_out, Q1,Q2 );
assign Q2_bar = ~Q2;
assign pb_out = Q1 & Q2_bar;
endmodule
