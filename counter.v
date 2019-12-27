`timescale 10ms / 1s
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    16:47:28 11/21/2019 
// Design Name: 
// Module Name:    l 
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description: 
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////


module counter(
	 input clk_in,
	 output clk_out,
	 input button_up,
	 input button_down,
	 output button_deb,
	 output [7:0] wynik,
	 input button_res
);
	 wire button_up_deb, button_down_deb;
	 reg [7:0] l;
	 prescaler h(clk_in, clk_out);
	 debounce b1(button_up,clk_in,button_up_deb);
	 debounce b2(button_down,clk_in,button_down_deb);
    always @(posedge clk_out)
	 begin
	 if(button_up_deb)
       l <= l + 1;
	 if(button_res)
		 l <= 8'b00000000;
	 if(button_down_deb)
		 l <= l - 1;
	 end
		 
assign wynik = l;

endmodule
