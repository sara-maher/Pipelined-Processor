LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.numeric_std.all;

ENTITY IssueUnit IS
Port(
	Ins1: IN std_logic_vector(15 downto 0);
	Ins2 : IN std_logic_vector(15 downto 0);
	enable : IN std_logic;
	Issueadder : OUT std_logic_vector(31 downto 0);
	InsWord : OUT std_logic_vector(31 downto 0));
END IssueUnit;

ARCHITECTURE ArchIssueUnit OF IssueUnit IS
SIGNAL NOP : std_logic_vector (15 downto 0);
SIGNAL Src2: std_logic_vector (2 downto 0);
SIGNAL Dest1: std_logic_vector (2 downto 0);
SIGNAL zero : std_logic_vector(31 downto 0);
BEGIN
	NOP <= (others=>'0');
	Src2 <= Ins2(7 downto 5);
	Dest1 <= Ins1(4 downto 2);
	zero <= (others =>'0');

					InsWord(15 downto 0) <= Ins1 When Ins1(15) ='1' and enable ='1'	else
							        Ins2 when Ins2(15) ='1' and ( Src2 /= Dest1) and( Ins2(12 downto 8) /= "10001" ) and enable ='1'
								Else NOP;
	
					InsWord(31 downto 16) <= Ins1 When Ins1(15) ='0' and enable ='1' else
							         Ins2 when Ins2(15) ='0' and (Src2 /= Dest1) and enable ='1'
      								 Else NOP;						     
	
	
					Issueadder <= zero(31 downto 2)&"10" when ((Ins1(15) ='1' and Ins2(15) ='0')or (Ins2(15) ='1' and Ins1(15) ='0' and Ins2(12 downto 8) /= "10001")) and (enable ='1' )else
						 zero(31 downto 1) &'1' when  enable ='1'
						else zero;

END ArchIssueUnit;
