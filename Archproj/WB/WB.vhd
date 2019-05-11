LIBRARY IEEE;
USE IEEE.std_logic_1164.all;
--NOTE: Write2Data keeps the value of previous load if Reg2Write ==0 (this value taken shouldn't be used if Reg2Write ==0// we must check 
--first not to take wrong old values)
ENTITY WB IS
	PORT(
	     MemToReg1:IN std_logic;--flag
	     Read1Data : IN std_logic_vector(15 downto 0); -- from memory
             Immediate : IN std_logic_vector(15 downto 0);-- Immediate date (LDM)
	     LoadData : IN std_logic_vector (15 downto 0); -- data from ALU

	     Write1Data,Write2Data : out std_logic_vector(15 downto 0)
		);
END WB;

ARCHITECTURE Dataflow OF WB is

	Begin
	WriteData: entity work.Mux2x1 
	Generic map(N =>16)
	PORT map( op1 =>  Read1Data,
			op2 =>Immediate,
			s =>MemToReg1,
			output => Write2Data);

			
	Write1Data <= LoadData;
			

END Dataflow;
	
