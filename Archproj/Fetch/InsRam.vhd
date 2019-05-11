LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.numeric_std.all;

ENTITY RAM IS
	PORT(
		clk : IN std_logic;
		we  : IN std_logic;
		address : IN  std_logic_vector(31 DOWNTO 0);
		datain  : IN  std_logic_vector(15 DOWNTO 0);
		resetadd : OUT std_logic_vector(15 downto 0);
		interruptadd : OUT std_logic_vector(15 downto 0);
		dataout1 : OUT std_logic_vector(15 DOWNTO 0);
		dataout2 : OUT std_logic_vector(15 DOWNTO 0)
		);

END ENTITY RAM;

ARCHITECTURE ArchRAM OF RAM IS

	TYPE ram_type IS ARRAY(0 TO 1048576 ) OF std_logic_vector(15 DOWNTO 0);
	SIGNAL ram : ram_type ;
	
	BEGIN
		PROCESS(clk) IS
			BEGIN
				IF rising_edge(clk) THEN  
					IF we = '1' THEN
						ram(to_integer(unsigned(address))) <= datain;
					END IF;
				END IF;
		END PROCESS;
		dataout1 <= ram(to_integer(unsigned(address)));
		dataout2 <= ram(to_integer(unsigned(address)+1));
		resetadd <= ram(0);
		interruptadd <= ram(2);
END ArchRAM;