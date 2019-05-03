
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
SIGNAL tmp: STD_LOGIC_VECTOR(n-1 DOWNTO 0); 
BEGIN

PROCESS (clk, rst,enable)

BEGIN
	IF (rst ='1') then
            tmp <= (OTHERS => '0');
	 elsif (enable='1') THEN
   		 IF RISING_EDGE(clk) THEN  
  			tmp <= std_logic_vector(tmp + 1);
   			 
         END IF;
	END IF;  
count <= tmp;
END PROCESS;
END ArchCounter;