LIBRARY IEEE;
USE IEEE.std_logic_1164.all;

ENTITY Mux2x1 IS 
	Generic (N:integer:=16);
	PORT ( op1,op2 : IN std_logic_vector(N-1 DOWNTO 0);
			s : IN  std_logic; --selector
			oput : OUT std_logic_vector(N-1 DOWNTO 0));
END Mux2x1;

ARCHITECTURE ArchMux2x1 OF Mux2x1 is
BEGIN
	PROCESS(op1,op2,s)
		BEGIN
			IF(s = '0') THEN
				oput <= op1 ;
			ELSE
				oput <= op2;
			END IF;
		END PROCESS;
END ArchMux2x1;

