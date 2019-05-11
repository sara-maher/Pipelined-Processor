LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.numeric_std.all;

Entity MEM IS
	PORT 
	(
		clk : IN std_logic;
		MemRead: IN std_logic;
		MemWrite: IN std_logic;
		Address:  IN std_logic_vector(31 downto 0);
		WriteData: IN std_logic_vector (15 downto 0);
		ReadData : OUT std_logic_vector (15 downto 0)
	);
End MEM;

Architecture ArchMEM of MEM IS

Component DataRAM IS
	PORT(
		clk : IN std_logic;
		we  : IN std_logic;
		re : IN std_logic;
		address : IN  std_logic_vector(31 DOWNTO 0);
		datain  : IN  std_logic_vector(15 DOWNTO 0);
		dataout : OUT std_logic_vector(15 DOWNTO 0)
		);

END Component;

BEGIN 

	MEM2 : DataRAM port map( clk, MemWrite,MemRead,Address,WriteData,ReadData);


END ArchMEM;