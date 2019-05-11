LIBRARY IEEE;
USE IEEE.std_logic_1164.all;

ENTITY FullAdder64 IS
	PORT (a,b: IN  std_logic_vector(31 downto 0);--two operands
		cin : IN std_logic;--carry in
		 s : OUT std_logic_vector(31 downto 0); --summation 
		  cout : OUT std_logic ); --carry out
END FullAdder64;

ARCHITECTURE ArchFullAdder OF FullAdder64 IS

	component Adder IS
	PORT (a,b,cin : IN  std_logic;
		  s, cout : OUT std_logic );
	END component;

	signal tempCout: std_logic_vector(32 downto 0);

	BEGIN

	tempCout(0) <= cin;
	loop1: for i in 0 to 31 generate
		Add1: Adder port map(a(i), b(i), tempCout(i), s(i), tempCout(i+1));
	END generate;

	cout <= tempCout(32); --final carry out

END ArchFullAdder;
