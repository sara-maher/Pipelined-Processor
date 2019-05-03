LIBRARY IEEE;
USE IEEE.std_logic_1164.all;

ENTITY NRegister IS
GENERIC (N:integer:=16);
Port(
	clk,rst,enable : IN std_logic;
	data : IN std_logic_vector(N-1 DOWNTO 0);
	output : OUT std_logic_vector(N-1 DOWNTO 0) );
END NRegister;

ARCHITECTURE ArchNRegister OF NRegister IS
BEGIN

PROCESS(clk,rst)
BEGIN
	IF  (clk'event and clk='0')
	THEN
		IF(rst = '1')
			THEN output <= (OTHERS=>'0');


		ELSIF(enable = '1')
			THEN	output <= data;
		END IF;
	END IF;
END PROCESS;

END ArchNRegister;
