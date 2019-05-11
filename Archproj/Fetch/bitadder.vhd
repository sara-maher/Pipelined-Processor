LIBRARY IEEE;
USE IEEE.std_logic_1164.all;

ENTITY Adder IS
	PORT (a,b,cin : IN  std_logic;
		  s, cout : OUT std_logic );
END Adder;

ARCHITECTURE Adder_a OF Adder IS
	BEGIN
		PROCESS ( a ,b , cin)
			BEGIN 
				s <= a XOR b XOR cin;
				cout <= (a AND b) OR (cin AND (a XOR b));
		END PROCESS;
END Adder_a;
