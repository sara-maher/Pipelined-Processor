LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.numeric_std.all;

Entity MEM IS
	PORT 
	(
		clk : IN std_logic;
		MemRead: IN std_logic;
		MemWrite: IN std_logic;
		Stall: IN std_logic;
		Address,SP,PC:  IN std_logic_vector(31 downto 0);  -- this pc is the pc value +1
		opcode: IN std_logic_vector(4 downto 0);
		Flags: IN std_logic_vector(2 downto 0);
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
signal AddressSig, spSig: std_logic_vector (31 downto 0);
signal data_in: std_logic_vector (15 downto 0);
signal count: std_logic_vector (1 downto 0);
signal rst: std_logic;
BEGIN 
	--AddressSig <= sp when(opcode ="01111"or opcode = "10000")
	--else Address;
	rst<= not(Stall);
	MEM2 : DataRAM port map( clk, MemWrite,MemRead,AddressSig,data_in,ReadData);

	count_stall: ENTITY work.Counter
	GENERIC map(N => 2)
	PORT map(
		clk => clk, rst=> rst, enable => Stall,
			count => count);
	sp_alu: entity work.sp_op
    generic map(n => 32)
  port map( 
      sp_in => SP,
      opcode => opcode,
      dec_out => spSig
  );
	process(clk)
	begin
		if (count = "00") then
			if opcode = "01111" or opcode = "10000" or opcode = "11000" or opcode = "11100" then
				AddressSig <= SP;
			else
				AddressSig <= Address;
			end if;
			if  opcode = "11000" or opcode = "11100" then
				data_in <= pc(15 downto 0);
			else
				data_in <= WriteData;
			end if;
		elsif (count = "01") then
			if opcode = "01111" or opcode = "10000" or opcode = "11000" or opcode = "11100" then
				AddressSig <= SP;
			else
				AddressSig <= Address;
			end if;
			if  opcode = "11000" or opcode = "11100" then
				data_in <= pc(31 downto 16);
			else
				data_in <= WriteData;
			end if;
		elsif (count = "10") then
			if opcode = "01111" or opcode = "10000" or opcode = "11000" or opcode = "11100" then
				AddressSig <= SP;
			else
				AddressSig <= Address;
			end if;
			if  opcode = "11100" then
				data_in(2 downto 0) <= Flags;
				data_in(15 downto 3) <= (others => '0');
			else
				data_in <= WriteData;
			end if;
		else
			data_in <= (others => 'Z');
		end if;
	end process;
END ArchMEM;

-- 01111
-- 10000
-- 11000
-- 11001
-- 11010
-- 11100
