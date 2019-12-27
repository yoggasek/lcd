`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    20:30:00 11/22/2019 
// Design Name: 
// Module Name:    automat 
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
module automat(
	input clk_in,
	output [7:0] l,
	input switch
    );

	reg [7:0] temp;
	wire clk_z;
	always@(posedge clk_z)
	begin
	if(switch==0)
       temp <= temp + 1;
	if(switch==1)
		temp <= temp - 1;
	 end

assign l = temp;
endmodule
