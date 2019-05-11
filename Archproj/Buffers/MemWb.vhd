LIBRARY IEEE;
USE IEEE.std_logic_1164.all;

ENTITY MemWb IS
Port(
	clk,rst : IN std_logic;
	AluOutput: IN std_logic_vector(15 downto 0);
	dataMem: IN  std_logic_vector(15 downto 0);
	write1Add, write2Add: IN std_logic_vector(2 downto 0);
	dst1Data,dst2Data: IN std_logic_vector(15 downto 0);
	writeEn1, writeEn2: IN std_logic;
	immediate2: IN std_logic_vector(15 downto 0);
	MemtoRegSel: IN std_logic;

	MemtoRegSelOutput: OUT std_logic;
	dataMemOutput: OUT std_logic_vector(15 downto 0);
	write1AddOutput, write2AddOutput: OUT std_logic_vector(2 downto 0);
	dst1DataOutput,dst2DataOutput: OUT std_logic_vector(15 downto 0);
	
	writeEn1Output, writeEn2Output: OUT std_logic;
	AluOutOutput: OUT std_logic_vector(15 downto 0);
	immediate2Output: OUT std_logic_vector(15 downto 0)
);
END MemWb;

ARCHITECTURE ArchMemWb OF MemWb IS
-------------------Component---------------------------
COMPONENT NRegister IS
GENERIC (N:integer:=16);
Port(
	clk,rst,enable : IN std_logic;
	data : IN std_logic_vector(N-1 DOWNTO 0);
	output : OUT std_logic_vector(N-1 DOWNTO 0) );
END COMPONENT NRegister;
----------------------------------------
COMPONENT BitRegister IS
Port(
	clk,rst,enable : IN std_logic;
	data : IN std_logic;
	output : OUT std_logic);
END COMPONENT BitRegister;
---------------------------------------------------
BEGIN
dataMemReg: NRegister Generic Map(16) PORT MAP(clk,rst,'1',dataMem,dataMemOutput);
write1AddOutputReg: NRegister Generic Map(3) PORT MAP(clk,rst,'1',write1Add,write1AddOutput);
write2AddOutputReg: NRegister Generic Map(3) PORT MAP(clk,rst,'1',write2Add,write2AddOutput);
writeEn1OutputReg: BitRegister PORT MAP(clk,rst,'1',writeEn1,writeEn1Output);
writeEn2OutputReg: BitRegister PORT MAP(clk,rst,'1',writeEn2,writeEn2Output);
AluOutputReg: NRegister Generic Map(16) PORT MAP(clk,rst,'1',AluOutput,AluOutOutput);
MemtoRegReg: BitRegister PORT MAP(clk,rst,'1',MemtoRegSel,MemtoRegSelOutput);
dst1DataReg: NRegister Generic Map(16) PORT MAP(clk,rst,'1',dst1Data,dst1DataOutput);
dst2DataReg: NRegister Generic Map(16) PORT MAP(clk,rst,'1',dst2Data,dst2DataOutput);
immediate2Reg: NRegister Generic Map(16) PORT MAP(clk,rst,'1',immediate2,immediate2Output);
END ArchMemWb;
