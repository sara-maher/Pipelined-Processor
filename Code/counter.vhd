LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.STD_LOGIC_UNSIGNED.ALL;
        
ENTITY Counter IS
GENERIC (N: INTEGER := 4);
PORT(
	clk, rst, enable : IN STD_LOGIC;
        count : OUT STD_LOGIC_VECTOR(n-1 DOWNTO 0));
END Counter;
        
ARCHITECTURE ArchCounter OF Counter IS


BEGIN

PROCESS (clk, rst)
VARIABLE tmp: std_logic_vector(N-1 DOWNTO 0);
BEGIN
	IF (rst ='1' AND  FALLING_EDGE(clk)) then
                   tmp := (OTHERS => '0');
	 elsif (enable='1') THEN
   		 IF FALLING_EDGE(clk) THEN  
  			tmp := std_logic_vector(tmp + 1);
   			 
              	END IF;
	END IF;  

count <= tmp; 
END PROCESS;
END ArchCounter;
