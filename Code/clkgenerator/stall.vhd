LIBRARY IEEE;
USE IEEE.std_logic_1164.all;
ENTITY stall IS
	PORT(
	OpCode : IN std_logic_vector(4 downto 0); --I want to know the actual size of the opcode of the instructions
	clk1 : IN std_logic;
	stall2 : OUT std_logic
 	);

END stall;

Architecture DataFlow OF stall IS
	signal cnt1_enable: std_logic;
	signal cnt1_reset: std_logic;
	signal cnt2_enable: std_logic;
	signal cnt2_reset: std_logic;
	signal counter1: std_logic_vector(1 downto 0);
	signal counter2:std_logic_vector(2 downto 0);
	Begin
		--stall2
 		cnt: entity work.counter 
		Generic map(N =>2)
		port map(clk => clk1, rst=>cnt1_reset, enable=> cnt1_enable,count=>counter1 );
		Process(OpCode, cnt1_enable, cnt1_reset, counter2,cnt2_enable,cnt2_reset,counter1)
			Begin
			 --STALL2
			IF (OpCode = "01111" or OPCOde = "10000" or OpCode ="11001") then --Add then push, pop RET
				stall2 <= '1';
				cnt1_enable <= '1';
				cnt1_reset <= '1';
		
				if (counter1 ="01") then
					stall2 <= '0';
					cnt1_reset <= '1';
					cnt1_enable <= '0';
				END IF;
			ELSIF(OpCode = "11100" or OpCOde= "11010")then --Add laterInterrupt and RTI opcodes
			       stall2 <= '1';
			       cnt2_enable <= '1';
			       cnt2_reset <='1';	
			       	if (counter2 ="10") then
				    stall2 <= '0';
				    cnt2_reset <= '1';
				    cnt2_enable <= '0';	
				end if;		
			end if;
		END PROCESS;
END DataFLow;