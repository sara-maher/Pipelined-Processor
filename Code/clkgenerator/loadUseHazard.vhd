LIBRARY IEEE;
USE IEEE.std_logic_1164.all;
ENTITY loadUseHazard IS
	PORT(
	clk1: IN std_logic;
	DEMemRead1 : IN std_logic;
	DERegister1src, FDRegister2src,FDRegister2dest : IN std_logic_vector(2 downto 0);
 --A1: Instruction 1 Rsrc, B1: Instruction 1 Rd //previous
 --A2: Instruction 2 Rsrc, B2:Instruction 2 Rd
	stall1 : OUT std_logic
 	);

END loadUseHazard;

Architecture DataFlow OF loadUseHazard IS
	signal cnt1_enable: std_logic;
	signal cnt1_reset: std_logic;
	signal counter1: std_logic_vector(1 downto 0);
	Begin
		--stall1
 		cnt: entity work.counter 
		Generic map(N =>2)
		port map(clk => clk1, rst=>cnt1_reset, enable=> cnt1_enable,count=>counter1 );
		Process(DEMemRead1, DERegister1src, FDRegister2src, FDRegister2dest,cnt1_enable,cnt1_reset,counter1)
			Begin
			 --STALL1
			IF (DEMemRead1 ='1' and ((DERegister1src = FDRegister2src) or(DERegister1src = FDRegister2dest))) then
				stall1 <= '1';
				cnt1_enable <= '1';
				cnt1_reset <= '1';
			END IF;
			if (counter1 ="01") then
				stall1 <= '0';
			end if;
		END PROCESS;
END DataFLow;