LIBRARY IEEE;
USE IEEE.std_logic_1164.all;
USE IEEE.numeric_std.all;

ENTITY NDecoder IS
	GENERIC (N : integer := 4);
	PORT(   input: IN std_logic_vector (N-1 DOWNTO 0);
	 	output: OUT  std_logic_vector ((2**N)-1 DOWNTO 0)
		);
END ENTITY NDecoder;



ARCHITECTURE ArchNDecoder OF NDecoder is
BEGIN
	PROCESS(input)
	BEGIN
		output <= (others => '0');
		output(to_integer(unsigned(input))) <= '1';

	End PROCESS;
	
END ArchNDecoder;
