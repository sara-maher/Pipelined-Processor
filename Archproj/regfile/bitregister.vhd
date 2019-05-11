LIBRARY IEEE;
USE IEEE.std_logic_1164.all;

ENTITY BitRegister IS
Port(
	clk,rst,enable : IN std_logic;
	data : IN std_logic;
	output : OUT std_logic);
END BitRegister;

ARCHITECTURE ArchBitRegister OF BitRegister IS
BEGIN

PROCESS(clk,rst)
BEGIN
	IF  (clk'event and clk='0')
	THEN
		IF(rst = '1')
			THEN output <= '0';


		ELSIF(enable = '1')
			THEN	output <= data;
		END IF;
	END IF;
END PROCESS;

END ArchBitRegister;
