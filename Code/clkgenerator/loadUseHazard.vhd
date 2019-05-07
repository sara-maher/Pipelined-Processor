LIBRARY IEEE;
USE IEEE.std_logic_1164.all;
ENTITY loadUseHazard IS
	PORT(
	clk1: IN std_logic;
	DEMemRead1 : IN std_logic;
	DERegister1dist, FDRegister2src,FDRegister2dest : IN std_logic_vector(2 downto 0);
 --A1: Instruction 1 Rdist, B1: Instruction 1 Rsrc //previous
 --A2: Instruction 2 Rdist, B2:Instruction 2 Rsrc
	stall1 : OUT std_logic
 	);

END loadUseHazard;

Architecture DataFlow OF loadUseHazard IS
	Begin
		--stall1
		Process(DEMemRead1, DERegister1dist, FDRegister2src, FDRegister2dest,cnt1_enable,cnt1_reset,counter1)
			Begin
			 --STALL1
			IF (DEMemRead1 ='1' and ((DERegister1dist = FDRegister2src) or(DERegister1dist = FDRegister2dest))) then
				stall1 <= '1';
			
			ELSE
				stall1 <= '0';
			end if;
		END PROCESS;
END DataFLow;