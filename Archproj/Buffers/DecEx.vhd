LIBRARY IEEE;
USE IEEE.std_logic_1164.all;

ENTITY DecEx IS
GENERIC (N:integer:=16);
Port(
	clk,rst : IN std_logic;
	--PC: IN std_logic_vector(31 downto 0);
	opCode1,opCode2: IN std_logic_vector(4 downto 0);
	RegAdd11,RegAdd12,RegAdd21,RegAdd22: IN std_logic_vector(2 downto 0);--src1,dst1,src2,dst2
	Reg11,Reg12,Reg21,Reg22: IN std_logic_vector(15 downto 0);---src1,dst1,src2,dst2
	immediate1: IN std_logic_vector(4 downto 0);
	immediate2: IN std_logic_vector(15 downto 0);
	writeEn1, writeEn2, memWrite, memRead: IN std_logic;
        MemtoRegSel: IN std_logic;
	MemtoRegSelOutput: OUT std_logic;
	--PCOutput: OUT std_logic_vector(31 downto 0);
	opCode1Output,opCode2Output: OUT std_logic_vector(4 downto 0);
	RegAdd11Output,RegAdd12Output,RegAdd21Output,RegAdd22Output:OUT std_logic_vector(2 downto 0);
	Reg11Output,Reg12Output,Reg21Output,Reg22Output: OUT std_logic_vector(15 downto 0);
	immediate1Output: OUT std_logic_vector(4 downto 0);
	immediate2Output: OUT std_logic_vector(15 downto 0);
	writeEn1Output, writeEn2Output, memWriteOutput, memReadOutput: OUT std_logic
);
END DecEx;

ARCHITECTURE ArchDecEx OF DecEx IS
-------------------Component---------------------------
COMPONENT NRegister IS
GENERIC (N:integer:=16);
Port(
	clk,rst,enable : IN std_logic;
	data : IN std_logic_vector(N-1 DOWNTO 0);
	output : OUT std_logic_vector(N-1 DOWNTO 0) );
END COMPONENT NRegister;
--------------------------------------
COMPONENT BitRegister IS
Port(
	clk,rst,enable : IN std_logic;
	data : IN std_logic;
	output : OUT std_logic);
END COMPONENT BitRegister;
---------------------------------------------------
BEGIN

--PCReg: NRegister Generic Map(32) Port MAP(clk,rst,'1',PC,PCOutput);
opCode1Reg: NRegister Generic Map(5) Port MAP(clk,rst,'1',opCode1,opCode1Output);
opCode2Reg: NRegister Generic Map(5) Port MAP(clk,rst,'1',opCode2,opCode2Output);
Reg11Reg: NRegister Generic Map(16) Port MAP(clk,rst,'1',Reg11,Reg11Output);
Reg12Reg: NRegister Generic Map(16) Port MAP(clk,rst,'1',Reg12,Reg12Output);
Reg21Reg: NRegister Generic Map(16) Port MAP(clk,rst,'1',Reg21,Reg21Output);
Reg22Reg: NRegister Generic Map(16) Port MAP(clk,rst,'1',Reg22,Reg22Output);
immediate1Reg: NRegister Generic Map(5) Port MAP(clk,rst,'1',immediate1,immediate1Output);
immediate2Reg: NRegister Generic Map(16) Port MAP(clk,rst,'1',immediate2,immediate2Output);
writeEn1Reg: BitRegister  Port MAP(clk,rst,'1',writeEn1,writeEn1Output);
writeEn2Reg: BitRegister  Port MAP(clk,rst,'1',writeEn2,writeEn2Output);
memWriteReg: BitRegister Port MAP(clk,rst,'1',memWrite,memWriteOutput);
memReadReg: BitRegister Port MAP(clk,rst,'1',memRead,memReadOutput);
MemtoRegReg: BitRegister port MAP(clk, rst ,'1', MemtoRegSel, MemtoRegSelOutput);
RegAdd11Reg: NRegister Generic Map(3) Port MAP(clk,rst,'1',RegAdd11,RegAdd11Output);
RegAdd12Reg: NRegister Generic Map(3) Port MAP(clk,rst,'1',RegAdd12,RegAdd12Output);
RegAdd21Reg: NRegister Generic Map(3) Port MAP(clk,rst,'1',RegAdd21,RegAdd21Output);
RegAdd22Reg: NRegister Generic Map(3) Port MAP(clk,rst,'1',RegAdd22,RegAdd22Output);

END ArchDecEx;
