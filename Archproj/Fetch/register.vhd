LIBRARY IEEE;
USE IEEE.std_logic_1164.all;

ENTITY NReg IS
GENERIC (N:integer:=16);
Port(
	clk,rst,enable : IN std_logic;
	data : IN std_logic_vector(N-1 DOWNTO 0);
	output : OUT std_logic_vector(N-1 DOWNTO 0) );
END NReg;

ARCHITECTURE ArchNRegister OF NReg IS
BEGIN

PROCESS(clk,rst)
VARIABLE tmp: STD_LOGIC_VECTOR(N-1 DOWNTO 0);
BEGIN
	IF  falling_edge(clk)
	THEN
		IF(rst = '1')
			THEN output <= (OTHERS=>'0');
		

		ELSIF(enable = '1')
			THEN	output <= data;
		END IF;
	END IF;
END PROCESS;

END ArchNRegister;