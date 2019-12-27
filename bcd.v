

module bcd2ascii(							//zeby wyswietlic liczby na wyswietlaczu musimy je miec skonwertowane do postaci ascii
		bcd_0,								//zmienna przechowujaca liczbe jednosci w bcd
		bcd_1,								//zmienna przechowujaca liczbe dziesiatek w bcd
		bcd_2,								//zmienna przechowujaca liczbe setek w bcd
		ascii_0,								//poprzez te zmienne przekazemy wartosci do nastepnego modulu
		ascii_1,	
		ascii_2	
	);
	
	input  [3:0] bcd_0;
	input  [3:0] bcd_1;
	input  [3:0] bcd_2;
	output reg [7:0] ascii_0;			//tu zapiszemy skonwertowana liczbe bcd do ascii
	output reg [7:0] ascii_1;			//tu zapiszemy skonwertowana liczbe bcd do ascii
	output reg [7:0] ascii_2;			//tu zapiszemy skonwertowana liczbe bcd do ascii

	always @(*) begin
   case (bcd_0)							//jesli wartosc bcd_0 (cyfra jednosci jest od 0-9 to przypisz ascii odpowiednia wartosc 
		4'h0: 	ascii_0 = 8'h30;
		4'h1: 	ascii_0 = 8'h31;
		4'h2: 	ascii_0 = 8'h32;
		4'h3: 	ascii_0 = 8'h33;		//dla bcd_0 = 3 przypisz w kodzie ascii ascii_0 = 33 bo liczba 3 jest reprezentowana przez taka liczbe w kodzie ascii itd
		4'h4: 	ascii_0 = 8'h34;
		4'h5: 	ascii_0 = 8'h35;
		4'h6: 	ascii_0 = 8'h36;
		4'h7: 	ascii_0 = 8'h37;
		4'h8: 	ascii_0 = 8'h38;
		4'h9: 	ascii_0 = 8'h39;
		default: ascii_0 = 8'h2B;
   endcase
   case (bcd_1)						//to samo dla cyfry dziesiatek
		4'h0: 	ascii_1 = 8'h30;
		4'h1: 	ascii_1 = 8'h31;
		4'h2: 	ascii_1 = 8'h32;
		4'h3: 	ascii_1 = 8'h33;
		4'h4: 	ascii_1 = 8'h34;
		4'h5: 	ascii_1 = 8'h35;
		4'h6: 	ascii_1 = 8'h36;
		4'h7: 	ascii_1 = 8'h37;
		4'h8: 	ascii_1 = 8'h38;
		4'h9: 	ascii_1 = 8'h39;
		default: ascii_1 = 8'h2B;
   endcase
	 case (bcd_2)						//to samo dla cyfry setek
		4'h0: 	ascii_2 = 8'h30;
		4'h1: 	ascii_2 = 8'h31;
		4'h2: 	ascii_2 = 8'h32;
		4'h3: 	ascii_2 = 8'h33;
		4'h4: 	ascii_2 = 8'h34;
		4'h5: 	ascii_2 = 8'h35;
		4'h6: 	ascii_2 = 8'h36;
		4'h7: 	ascii_2 = 8'h37;
		4'h8: 	ascii_2 = 8'h38;
		4'h9: 	ascii_2 = 8'h39;
		default: ascii_2 = 8'h2B;
   endcase
end
	
endmodule
