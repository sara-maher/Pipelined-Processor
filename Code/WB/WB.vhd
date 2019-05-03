LIBRARY IEEE;
USE IEEE.std_logic_1164.all;
ENTITY WB IS
	PORT(
	     Reg1Write,Reg2Write :INOUT std_logic; --flag to write to reg in inst.1 or 2
	     MemToReg1,MemToReg2 :IN std_logic	;--flag 
	     Write1Add, Write2Add : INOUT std_logic_vector(2 downto 0);--address of the register to write into/ 3 bits
	     Read1Data : IN std_logic_vector(15 downto 0); -- data out from ALU (instruction 1 data)
             Immediate : IN std_logic_vector(14 downto 0);-- Immediate date (LDM)
	     LoadData : IN std_logic_vector (15 downto 0); -- data from load side (instruction 2 data)
	     Write1Data,Write2Data : out std_logic_vector(15 downto 0)
		);
END WB;

ARCHITECTURE Dataflow OF WB is
	signal largeImmediate : std_logic_vector(15 downto 0);

	Begin
	largeImmediate <= '0'& Immediate ;
	WriteData: entity work.Mux2x1 
	Generic map(N =>16)
	PORT map( op1 =>  Read1Data,
			op2 =>largeImmediate,
			s =>MemToReg1,
			output => Write1Data);

	process(LoadData,MemToReg2,Write2Add)
		Begin
			if(MemToReg2 = '1') then
				Write2Data <= LoadData;
			end if;
	END PROCESS;
           
END Dataflow;