LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.numeric_std.all;

ENTITY DataRAM IS
	PORT(
		clk : IN std_logic;
		we  : IN std_logic;
		re : IN std_logic;
		address : IN  std_logic_vector(31 DOWNTO 0);
		datain  : IN  std_logic_vector(15 DOWNTO 0);
		dataout : OUT std_logic_vector(15 DOWNTO 0)
		);

END Entity DataRAM;

ARCHITECTURE ArchDataRAM OF DataRAM IS

	TYPE ram_type IS ARRAY(0 TO 63) OF std_logic_vector(15 DOWNTO 0);
	SIGNAL ram : ram_type ;
	
	BEGIN
		PROCESS(clk) IS
			BEGIN
				IF rising_edge(clk) THEN  
					IF we = '1' THEN
						ram(to_integer(unsigned(address))) <= datain;
					END IF;
					IF re ='1' THEN
						dataout <= ram(to_integer(unsigned(address)));
					END IF;
				END IF;
		END PROCESS;
END ArchDataRAM;