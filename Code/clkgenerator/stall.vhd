LIBRARY IEEE;
USE IEEE.std_logic_1164.all;
ENTITY stall IS
	PORT(
	OpCode : IN std_logic_vector(6 downto 0); --I want to know the actual size of the opcode of the instructions
	clk1 : IN std_logic;
	stall2 : OUT std_logic
 	);

END stall;

Architecture DataFlow OF stall IS
	
	Begin
		Process(OpCode, clk1)
			variable counter : std_logic_vector(1 downto 0);
			variable flag : std_logic;
			Begin

			 --STALL2
		
			
			IF (OpCode = "0101111" or OPCOde = "0110000" or OpCode ="0011001") then
				stall2 <= '1';
				counter := "00";
				flag := '0';
			ELSIF(OpCode = "0011100" or OpCOde= "0011010")then
				stall2 <= '1';
				counter := "01";
				flag := '0';
			ELSIF (counter = "01" and (OpCode /= "0011100" or OpCode /= "0011010" or OpCode /="0011001" or OpCode /= "0110000" or OpCode /= "0101111") ) then
				stall2 <= '1';	
				flag := '1';			
				counter := "00";
				
			ELSIF (flag = '1') THEN
				stall2 <= '1';
				counter := "00";
				flag := '0';
			ELSE 
				stall2 <= '0';
				counter := "00";
				flag := '0';
			end if;
		
		END PROCESS;
END DataFLow;