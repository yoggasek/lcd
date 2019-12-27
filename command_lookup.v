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
	 data_j,
	 data_d,
	 data_s,
    data_out
    );

// ===========================================================================
// 										Port Declarations
// ===========================================================================
    input [5:0] sel;
	 input [7:0] data_j;
	 input [7:0] data_d;
	 input [7:0] data_s;
	 
    output [7:0] data_out;

// ===========================================================================
// 							  Parameters, Regsiters, and Wires
// ===========================================================================

	// Output wire

	
	//  Hexadecimal values below represent ASCII characters
	
		
		reg [7:0] command [0:5] = {
													// Clear the screen and set cursor position to home
													8'h1B,		// Esc		
													8'h5B,		// [
													8'h6A,		// j
													
													8'h30,		
													8'h31,				
													8'h32				

											};
	
	// Assign byte to output
	always @(*) begin
		command[5]= data_j;		
		command[4]= data_d;			
		command[3]= data_s;			
	end
	assign data_out = command[sel];

endmodule