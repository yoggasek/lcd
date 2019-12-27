`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: Digilent Inc.
// Engineers: Andrew Skreen
//				  Josh Sackos
// 
// Create Date:    15:20:31 06/15/2012 
// Module Name:    PmodCLS_Demo 
// Project Name:	 PmodCLS_Demo
// Target Devices: Nexys3
// Tool versions:  ISE 14.1
// Description: 	 Prints "Hello From Digilent" on PmodCLS connected to Nexys3
//						 on pins JA1-JA4. SPI protocol is utilized for communications
//						 between the PmodCLS and the Nexys3, hence the appropriate
//						 jumpers should be set on the PmodCLS, for details see
//						 PmodCLS reference manual.
//
// Revision: 1.0
// Revision 0.01 - File Created
//
//////////////////////////////////////////////////////////////////////////////////
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



// ==============================================================================
// 										  Define Module
// ==============================================================================
module PmodCLS_Demo(
    input CLK,
    input [2:0] SW,
	 input switch,
    output [3:0] JA,
	 input [10:7] JB,
	 output [0:0] Led,
	 output clk_o,
	 input button_up,
	 input button_down,
	 input button_res,
    output [7:0] bufor
    );
	
	wire [3:0] bcd_j;
	wire [3:0] bcd_d;
	wire [3:0] bcd_s;
	
	wire [7:0] jednosci;
	wire [7:0] dziesiatki;
	wire [7:0] setki;
	
	wire [7:0] lcd_counter;
	wire slave_select;			// Active low signal for writing data to PmodCLS
	wire begin_transmission;	// Initializes data transfer with PmodCLS
	wire end_transmission;		// Handshake signal to signify data transfer done
	wire [5:0] sel;				// Selects which ASCII value to send to PmodCLS
	wire [7:0] temp_data;		// Output data from C2 to C0
	wire [7:0] send_data;		// Output data from C0 to C1
	
	wire START;						// Debounced start signal, SW[2]
	wire CLEAR;						// Debounced clear signal, SW[1]
	wire RST;						// Debounced reset signal, SW[0]
	wire GND = 0;					// Ground, i.e. logic low

	// ===========================================================================
	// 										Implementation
	// ===========================================================================
	// Debounces the input control signals from switches.
	
	wire clk_lcd;
	prescaler27 lcd(CLK,clk_lcd);

	counter x1(
	 .clk_in(CLK),
	 .switch(switch),
	 .JB(JB),
	 .wynik(bufor)
	 );
	
	assign lcd_counter = bufor;
	
	number2bcd x2(
	.number(lcd_counter),
	.bcd_0(bcd_j),
	.bcd_1(bcd_d),
	.bcd_2(bcd_s)
	);
	
	bcd2ascii x3(							//zeby wyswietlic liczby na wyswietlaczu musimy je miec skonwertowane do postaci ascii
		.bcd_0(bcd_j),							//zmienna przechowujaca liczbe jednosci w bcd
		.bcd_1(bcd_d),
		.bcd_2(bcd_s),								//zmienna przechowujaca liczbe setek w bcd
		.ascii_0(jednosci),								//poprzez te zmienne przekazemy wartosci do nastepnego modulu
		.ascii_1(dziesiatki),
		.ascii_2(setki)
		);
		
		
	// Contains the ASCII characters for commands
	command_lookup C2(
			.sel(sel),
			.data_j(jednosci),
			.data_d(dziesiatki),
			.data_s(setki),
			.data_out(temp_data)
		
	);
	
	Three_Bit_Debouncer DebounceInputs(
			.CLK(CLK),
			.RST(GND),
			.I0(SW[0]),
			.I1(SW[1]),
			.I2(clk_lcd),
			.D0(RST),
			.D1(CLEAR),
			.D2(START)
	);

	// Produces signals for controlling SPI interface, and selecting output data.
	master_interface C0( 
			.begin_transmission(begin_transmission),
			.end_transmission(end_transmission),
			.clk(CLK),
			.rst(RST),
			.start(START),
			.clear(CLEAR),
			.slave_select(slave_select),
			.temp_data(temp_data),
			.send_data(send_data),
			.sel(sel)
	);

	// Interface between the PmodCLS and FPGA, proeduces SCLK signal, etc.
	spi_interface C1(
			.begin_transmission(begin_transmission),
			.slave_select(slave_select),
			.send_data(send_data),
			.miso(JA[2]),
			.clk(CLK),
			.rst(RST),
			.end_transmission(end_transmission),
			.mosi(JA[1]),
			.sclk(JA[3])
	);

	//  Active low slave select signal
	assign JA[0] = slave_select;

	// Assign Led[0] the value of SW[0]
	assign Led[0] = SW[0];
	
	
	endmodule
