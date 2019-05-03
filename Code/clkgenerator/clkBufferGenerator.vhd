LIBRARY IEEE;
USE IEEE.std_logic_1164.all;
ENTITY clkBufferGenerator IS
	PORT(clk: IN std_logic;
	     stall1,stall2: IN std_logic;
	     clkFD, clkDE ,clkEM, clkMW: OUT std_logic   
	);
END clkBufferGenerator;

Architecture DataFlow OF clkBufferGenerator IS
	Begin
		clkFD	<= (clk and (not stall1) and (not stall2));
		clkDE <= (clk and (not stall1) and (not stall2));
		clkEM <=  (clk and (not stall2));
		clkMW <= clk;
END architecture;
