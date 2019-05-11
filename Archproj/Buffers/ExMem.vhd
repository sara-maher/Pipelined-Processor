LIBRARY IEEE;
USE IEEE.std_logic_1164.all;

ENTITY ExMem IS
Port(
	clk,rst : IN std_logic;

	RegAdd11,RegAdd12,RegAdd21,RegAdd22: IN std_logic_vector(2 downto 0);
	Reg11,Reg12,Reg21,Reg22: IN std_logic_vector(15 downto 0);

	immediate1: IN std_logic_vector(4 downto 0); --immediade val in SHL,SHR
	immediate2: IN std_logic_vector(15 downto 0); --immediade in LDM

	AluOutput: IN std_logic_vector(15 downto 0);

	MemWrite,MemRead: IN std_logic;
	writeEn1, writeEn2: IN std_logic;
	MemtoRegSel: IN std_logic;
        MemtoRegSelOutput:OUT std_logic;
	RegAdd11Output,RegAdd12Output,RegAdd21Output,RegAdd22Output: OUT std_logic_vector(2 downto 0);
	Reg11Output,Reg12Output,Reg21Output,Reg22Output:  OUT std_logic_vector(15 downto 0);

	immediate1Output: OUT std_logic_vector(4 downto 0);
	immediate2Output: OUT std_logic_vector(15 downto 0);
	AluOutOutput: OUT std_logic_vector(15 downto 0);
	MemWriteOutput,MemReadOutput: OUT std_logic;
	writeEn1Output, writeEn2Output: OUT std_logic
	
	);

END ExMem;

ARCHITECTURE ArchExMem OF ExMem IS
------------------Component------------------------------
COMPONENT NRegister IS
GENERIC (N:integer:=16);
Port(
	clk,rst,enable : IN std_logic;
	data : IN std_logic_vector(N-1 DOWNTO 0);
	output : OUT std_logic_vector(N-1 DOWNTO 0) );
END  COMPONENT NRegister;
------------------------------------------
COMPONENT BitRegister IS
Port(
	clk,rst,enable : IN std_logic;
	data : IN std_logic;
	output : OUT std_logic);
END COMPONENT BitRegister;
--------------------------------------------------------
BEGIN

MemWriteReg: BitRegister  port MAP(clk, rst ,'1', MemWrite, MemWriteOutput);
MemReadReg: BitRegister port MAP(clk, rst ,'1', MemRead, MemReadOutput);
writeEn1Reg: BitRegister  port MAP(clk, rst ,'1', writeEn1, writeEn1Output);
writeEn2Reg: BitRegister  port MAP(clk, rst ,'1', writeEn2, writeEn2Output);
AluOutReg: NRegister Generic map(16) port MAP(clk, rst ,'1', AluOutput, AluOutOutput);
RegAdd11Reg: NRegister Generic map(3) port MAP(clk, rst ,'1', RegAdd11, RegAdd11Output);
RegAdd12Reg: NRegister Generic map(3) port MAP(clk, rst ,'1', RegAdd12, RegAdd12Output);
RegAdd21Reg: NRegister Generic map(3) port MAP(clk, rst ,'1', RegAdd21, RegAdd21Output);
RegAdd22Reg: NRegister Generic map(3) port MAP(clk, rst ,'1', RegAdd22, RegAdd22Output);
Reg11Reg: NRegister Generic map(16) port MAP(clk, rst ,'1', Reg11, Reg11Output);
Reg12Reg: NRegister Generic map(16) port MAP(clk, rst ,'1', Reg12, Reg12Output);
Reg21Reg: NRegister Generic map(16) port MAP(clk, rst ,'1', Reg21, Reg21Output);
Reg22Reg: NRegister Generic map(16) port MAP(clk, rst ,'1', Reg22, Reg22Output);
imm1Reg: NRegister Generic map(5) port MAP(clk, rst ,'1', immediate1, immediate1Output);
imm2Reg: NRegister Generic map(16) port MAP(clk, rst ,'1', immediate2, immediate2Output);
MemtoRegReg: BitRegister Generic map(1) port MAP(clk, rst ,'1', MemtoRegSel, MemtoRegSelOutput);
END ArchExMem;
