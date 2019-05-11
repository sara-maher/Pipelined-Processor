LIBRARY IEEE;
USE IEEE.std_logic_1164.all;

ENTITY Mux4xx1 IS
	Generic (M:integer:=32);
	Port(in0,in1,in2,in3: in std_logic_vector(M-1 downto 0);
		sel : in std_logic_vector(1 downto 0);
		out1 : out std_logic_vector(M-1 downto 0));
END ENTITY Mux4xx1;

Architecture ArchMux4xx1 OF Mux4xx1 IS

-------------------------------Components--------------------------
COMPONENT Mux2x1 IS
	Generic (n:integer:=16);
	PORT ( op1,op2: IN std_logic_vector(N-1 DOWNTO 0);
		s : IN  std_logic; 
		output : OUT std_logic_vector(N-1 DOWNTO 0));
END COMPONENT Mux2x1;
----------------------------------------------------------------------

signal a,b :  std_logic_vector(m-1 downto 0);

BEGIN
	M1 : Mux2x1 Generic map (m) port map(in0,in1,sel(0),a);
	M2 : Mux2x1 Generic map (m) port map(in2,in3,sel(0),b);
	M3 : Mux2x1 Generic map (m) port map(a,b,sel(1),out1);

End Architecture;
