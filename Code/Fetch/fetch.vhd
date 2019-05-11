LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.numeric_std.all;

Entity Fetch is
	PORT(
	       		clk : IN std_logic; 
			rst : IN std_logic;
	      		Pcsrc : IN std_logic_vector( 1 downto 0);
			IR  : OUT std_logic_vector( 31 downto 0);
			Jump_add : IN std_logic_vector(31 downto 0);
			stall: IN std_logic;		
			PC  : OUT std_logic_vector( 31 downto 0)
	     );
END Fetch;

Architecture ArchFetch Of Fetch is
-------------------SIGNALS------------------
SIGNAL not_stall : std_logic;
SIGNAL pcnew : std_logic_vector(31 downto 0);
--SIGNAL pcnew_in  : std_logic_vector(63 downto 0);
--SIGNAL jump_out  : std_logic;
--SIGNAL jump_in   : std_logic;
SIGNAL reset_add : std_logic_vector(31 downto 0);
--SIGNAL reset_in  : std_logic;
SIGNAL interrupt_add : std_logic_vector(31 downto 0);
--SIGNAL interrupt_in : std_logic;
SIGNAL zero_in :std_logic_vector(15 downto 0);
SIGNAL Ins1 :std_logic_vector(15 downto 0);
SIGNAL Ins2 :std_logic_vector(15 downto 0);

SIGNAL issueunit_adder : std_logic_vector (31 downto 0);
SIGNAL pc_out : std_logic_vector(31 downto 0);
SIGNAL pc_in : std_logic_vector(31 downto 0);
SIGNAL instruction1 : std_logic_vector(15 downto 0);
SIGNAL instruction2 : std_logic_vector(15 downto 0);
SIGNAL issueunit_instruction : std_logic_vector(31 downto 0);
SIGNAL cout : std_logic;
SIGNAL not_rst :std_logic;
SIGNAL issue_en :std_logic;
-----------------Components-------------------
Component NReg IS
GENERIC (N:integer:=16);
Port(
	clk,rst,enable : IN std_logic;
	data : IN std_logic_vector(N-1 DOWNTO 0);
	output : OUT std_logic_vector(N-1 DOWNTO 0) );
END Component;

Component Mux4x1 IS
	Generic (M:integer:=32);
	Port(in0,in1,in2,in3: in std_logic_vector(M-1 downto 0);
		sel : in std_logic_vector(1 downto 0);
		out1 : out std_logic_vector(M-1 downto 0));
END Component;

Component RAM IS
	PORT(
		clk : IN std_logic;
		we  : IN std_logic;
		address : IN  std_logic_vector(31 DOWNTO 0);
		datain  : IN  std_logic_vector(15 DOWNTO 0);
		resetadd : OUT std_logic_vector(15 downto 0);
		interruptadd : OUT std_logic_Vector (15 downto 0);
		dataout1 : OUT std_logic_vector(15 DOWNTO 0);
		dataout2 : OUT std_logic_vector(15 DOWNTO 0)
		);

END Component;

Component FullAdder64 IS
	PORT (a,b: IN  std_logic_vector(31 downto 0);--two operands
		cin : IN std_logic;--carry in
		 s : OUT std_logic_vector(31 downto 0); --summation 
		  cout : OUT std_logic ); --carry out
END Component;

Component IssueUnit IS
Port(
	Ins1: IN std_logic_vector(15 downto 0);
	Ins2 : IN std_logic_vector(15 downto 0);
	enable : IN std_logic ; 
	Issueadder : OUT std_logic_vector(31 downto 0);
	InsWord : OUT std_logic_vector(31 downto 0));
END Component;
----------------------------------------------
BEGIN
	not_stall <= not stall;
	not_rst <= not rst;
	issue_en <= not_rst and not_stall;
	zero_in <= (others=>'0');
	reset_add(31 downto 16) <= (others=>'0');
	interrupt_add(31 downto 16) <=(others =>'0');
	PcReg : NReg generic map(32) port map(clk,rst,not_stall,pc_in,pc_out);
	MUX : Mux4x1 Generic map (32) port map(pcnew,Jump_add,reset_add,interrupt_add,Pcsrc,pc_in);
	MEMORY : RAM port map(clk,'0',pc_out,zero_in,reset_add(15 downto 0),interrupt_add(15 downto 0),Ins1,Ins2); --Ram input=0, RAM enable write =0
	instruction1<= (others=>'0') when Pcsrc ="10"
			else Ins1;
	instruction2<= (others=>'0') when Pcsrc ="10"
			else Ins2;
	Adder : FullAdder64 port map(pc_out,issueunit_adder,'0',pcnew,cout);
	Issue : IssueUnit port map(instruction1,instruction2,issue_en,issueunit_adder,issueunit_instruction);
	PC <= pcnew;
	IR <= issueunit_instruction;
END Architecture;
		