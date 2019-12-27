module number2bcd(				//ten modul odpowiada za konwersje liczb binarnych (kolejno setek dziesiatek jednosci) na kod bcd
										//kod bcd to taki kod za pomoca ktorego mozemy przedstawic liczbe dziesietna zamiast na 8 bitach to na 4
	number,							//number to tutaj otrzymana z poprzedniego modulu zmienna out					
	bcd_0,							//za pomoca tej zmiennej liczba binarna jednosci przekazywana jest z modulu glownego do tego modulu zeby ja skonwertowac do bcd
	bcd_1,							//tak samo jak poprzednio tylko liczba dziesiatek
	bcd_2								//tak samo jak poprzednio tylko liczba setek
	);
	input  [7:0] number;			//number jest liczba binarna otrzymana w danej chwili przez licznik i to ja konwertujemy na kod bcd
	output reg [3:0] bcd_0;		//tutaj wpiszemy skonnwertowana liczbe jednosci i wyslemy dalej do modulu ascii
	output reg [3:0] bcd_1;		//tutaj wpiszemy skonnwertowana liczbe dziesiatek i wyslemy dalej do modulu ascii
	output reg [3:0] bcd_2;		//tutaj wpiszemy skonnwertowana liczbe setek i wyslemy dalej do modulu ascii
	
	integer i;
	always@(number)						//przykad z neta, to jest troche skomplikowane wiec nie trzeba umiec dokladnie co sie dzieje
	begin
		bcd_0 = 4'd0;	//JEDNOSCI
		bcd_1 = 4'd0;	//DZIESIATKI
		bcd_2 = 4'd0;	//SETKI
		
		for(i=7; i>=0; i=i-1)begin
			if(bcd_2 >= 5)
				bcd_2=bcd_2+3;
			if(bcd_1 >= 5)
				bcd_1=bcd_1+3;
			if(bcd_0 >= 5)
				bcd_0=bcd_0+3;
				
			bcd_2=bcd_2<<1;
			bcd_2[0]=bcd_1[3];
			bcd_1=bcd_1<<1;
			bcd_1[0]=bcd_0[3];
			bcd_0=bcd_0<<1;
			bcd_0[0]=number[i];		
		end
	end
endmodule
