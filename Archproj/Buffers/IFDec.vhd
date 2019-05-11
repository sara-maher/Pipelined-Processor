LIBRARY IEEE;
USE IEEE.std_logic_1164.all;

ENTITY IfDec IS
Port(
	clk,rst : IN std_logic;
	PC,IR: IN std_logic_vector(31 downto 0);
	PCOutput,IROutput: OUT std_logic_vector(31 downto 0)
);
END IfDec;

ARCHITECTURE ArchIfDec OF IfDec IS

--------------------COMPONENTS------------------
COMPONENT NRegister IS
GENERIC (N:integer:=16);
Port(
	clk,rst,enable : IN std_logic;
	data : IN std_logic_vector(N-1 DOWNTO 0);
	output : OUT std_logic_vector(N-1 DOWNTO 0) );
END COMPONENT NRegister;

------------------------------------------------
BEGIN

PCReg:NRegister Generic map(32) PORT MAP(clk,rst,'1',PC,PCOutput);
IRReg:NRegister Generic map(32) PORT MAP(clk,rst,'1',IR,IROutput);	

END ArchIfDec;
