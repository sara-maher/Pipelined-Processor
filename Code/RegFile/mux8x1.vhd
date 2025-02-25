LIBRARY IEEE;
USE IEEE.std_logic_1164.all;

ENTITY Mux8x1 IS 
	Generic (N:integer:=16);
	PORT ( op0,op1,op2 ,op3,op4,op5,op6,op7: IN std_logic_vector(N-1 DOWNTO 0);
			s : IN  std_logic_vector(2 DOWNTO 0); --selector
			oput : OUT std_logic_vector(N-1 DOWNTO 0));
END Mux8x1;

ARCHITECTURE ArchMux8x1 OF Mux8x1 is
BEGIN
	PROCESS(op0,op1,op2,op3,op4,op5,op6,op7)
		BEGIN
			IF(s = "000") THEN
				oput <= op0;
			ELSIF(s = "001") THEN
				oput <= op1;
			ELSIF(s = "010") THEN
				oput <= op2;
			ELSIF(s = "011") THEN
				oput <= op3;
			ELSIF(s = "100") THEN
				oput <= op4;
			ELSIF(s = "101") THEN
				oput <= op5;
			ELSIF(s = "110") THEN
				oput <= op6;
			ELSIF(s = "111") THEN
				oput <= op7;
			END IF;
		END PROCESS;
END ArchMux8x1;

