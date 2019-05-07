
LIBRARY IEEE;
USE IEEE.std_logic_1164.all;

ENTITY Mux3x1 IS 
	Generic (N:integer:=16);
	PORT ( op1,op2,op3: IN std_logic_vector(N-1 DOWNTO 0);
		s1,s2 : IN  std_logic; --s1 is lower and s2 is higher
		output : OUT std_logic_vector(N-1 DOWNTO 0));
END Mux3x1;

ARCHITECTURE ArchMux3x1 OF Mux3x1 is
BEGIN
	PROCESS(op1,op2,op3,s1,s2)
		BEGIN
			IF(s1 = '0' and s2 = '0') THEN
				output <= op1 ;
			ELSIF(s1 = '1' and s2 = '0') then
				output <= op2;
			ELSIF(s1 = '0' and s2 = '1') then
				output <= op3;
			END IF;
		END PROCESS;
END ArchMux3x1;