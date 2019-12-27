`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: Digilent Inc.
// Engineers: Andrew Skreen
//				  Josh Sackos
// 
// Create Date:    12:15:47 06/18/2012
// Module Name:    command_lookup
// Project Name: 	 PmodCLS Demo
// Target Devices: Nexys3
// Tool versions:  ISE 14.1
// Description: Contains the data commands to be sent to the PmodCLS.  Values
//					 are ASCII characters, for details on data format, etc., see
//					 the PmodCLS reference manual.
//
// Revision: 1.0
// Revision 0.01 - File Created
//
//////////////////////////////////////////////////////////////////////////////////

// ==============================================================================
// 										  Define Module
// ==============================================================================
module command_lookup(
    sel,
	 button,
	 data_in,
    data_out
    );

// ===========================================================================
// 										Port Declarations
// ===========================================================================
    input [5:0] sel;
	 input [7:0] data_in;
    output [7:0] data_out;

// ===========================================================================
// 							  Parameters, Regsiters, and Wires
// ===========================================================================

	// Output wire
	wire [7:0] data_out;
	//  Hexadecimal values below represent ASCII characters
	reg [7:0] command [0:5] = {
													// Clear the screen and set cursor position to home
													8'h1B,		// Esc
													8'h5B,		// [
													8'h6A,		// j

													8'h30, //0
													8'h30, //0
													8'h30 //0
											
// ===========================================================================
// 										Implementation
// ===========================================================================
	always @(*)
	begin
       case(data_in)
		 8'b00000000 : command[3:5]= 8'h30;
		 8'b00000001 : command[3:4]= 8'h30, command[5]=8'h31;
		 8'b00000010 : command[3:5]= 8'h30, command[4]=8'h31;
		 8'b00000011 : command[3]= 8'h30, command[4:5]=8'h31;
		 8'b00000100 : command[3:5]= 8'h30, command[3]=8'h31;
		 default : command[3:5]= 8'h30;
	endcase
	end
	// Assign byte to output
	assign data_out = command[sel];

endmodule
