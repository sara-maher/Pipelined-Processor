LIBRARY IEEE;
USE IEEE.std_logic_1164.all;

ENTITY RegisterFile IS
Port(
	clk,rst: IN std_logic;

	writeAdd1: IN std_logic_vector(2 DOWNTO 0); --reg name
	writeAdd2: IN std_logic_vector(2 DOWNTO 0); --reg name

	writeData1 : IN std_logic_vector(15 DOWNTO 0);
	writeData2 : IN std_logic_vector(15 DOWNTO 0);

	writeEn1: IN std_logic;
	writeEn2: IN std_logic;

	readAdd11: IN std_logic_vector(2 DOWNTO 0); --reg name
	readAdd12: IN std_logic_vector(2 DOWNTO 0); --reg name

	readAdd21: IN std_logic_vector(2 DOWNTO 0); --reg name
	readAdd22: IN std_logic_vector(2 DOWNTO 0); --reg name

	readData11 : OUT std_logic_vector(15 DOWNTO 0);
	readData12 : OUT std_logic_vector(15 DOWNTO 0);

	readData21 : OUT std_logic_vector(15 DOWNTO 0);
	readData22 : OUT std_logic_vector(15 DOWNTO 0)
 );
END RegisterFile;

ARCHITECTURE ArchRegisterFile OF RegisterFile IS
--------------------------------SIGNALS--------------------------
SIGNAL enable0: STD_LOGIC;
SIGNAL data0: STD_LOGIC_VECTOR(15 DOWNTO 0);
SIGNAL reg0output: STD_LOGIC_VECTOR(15 DOWNTO 0);

SIGNAL enable1: STD_LOGIC;
SIGNAL data1: STD_LOGIC_VECTOR(15 DOWNTO 0);
SIGNAL reg1output: STD_LOGIC_VECTOR(15 DOWNTO 0);

SIGNAL enable2: STD_LOGIC;
SIGNAL data2: STD_LOGIC_VECTOR(15 DOWNTO 0);
SIGNAL reg2output: STD_LOGIC_VECTOR(15 DOWNTO 0);


SIGNAL enable3: STD_LOGIC;
SIGNAL data3: STD_LOGIC_VECTOR(15 DOWNTO 0);
SIGNAL reg3output: STD_LOGIC_VECTOR(15 DOWNTO 0);


SIGNAL enable4: STD_LOGIC;
SIGNAL data4: STD_LOGIC_VECTOR(15 DOWNTO 0);
SIGNAL reg4output: STD_LOGIC_VECTOR(15 DOWNTO 0);


SIGNAL enable5: STD_LOGIC;
SIGNAL data5: STD_LOGIC_VECTOR(15 DOWNTO 0);
SIGNAL reg5output: STD_LOGIC_VECTOR(15 DOWNTO 0);


SIGNAL enable6: STD_LOGIC;
SIGNAL data6: STD_LOGIC_VECTOR(15 DOWNTO 0);
SIGNAL reg6output: STD_LOGIC_VECTOR(15 DOWNTO 0);


SIGNAL enable7: STD_LOGIC;
SIGNAL data7: STD_LOGIC_VECTOR(15 DOWNTO 0);
SIGNAL reg7output: STD_LOGIC_VECTOR(15 DOWNTO 0);

SIGNAL decoderOutput1: STD_LOGIC_VECTOR(7 DOWNTO 0);
SIGNAL decoderOutput2: STD_LOGIC_VECTOR(7 DOWNTO 0);
------------------------------COMPONENT---------------------------------
COMPONENT NRegister IS
GENERIC (N:integer:=16);
Port(
	clk,rst,enable : IN std_logic;
	data : IN std_logic_vector(N-1 DOWNTO 0);
	output : OUT std_logic_vector(N-1 DOWNTO 0));
END COMPONENT NRegister;
-------------------------------------------------------------------------
COMPONENT NDecoder IS
	GENERIC (N : integer := 4);
	PORT(   input: IN std_logic_vector (N-1 DOWNTO 0);
	 	output: OUT  std_logic_vector ((2**N)-1 DOWNTO 0)
		);
END COMPONENT NDecoder;
--------------------------------------------------------------------------
COMPONENT Mux8x1 IS 
	Generic (N:integer:=16);
	PORT ( op0,op1,op2 ,op3,op4,op5,op6,op7: IN std_logic_vector(N-1 DOWNTO 0);
			s : IN  std_logic_vector(2 DOWNTO 0); --selector
			oput : OUT std_logic_vector(N-1 DOWNTO 0));
END COMPONENT Mux8x1;

---------------------------------------------------------------------------
BEGIN

enable0 <= (decoderOutput1(0) OR decoderOutput2(0)) AND (writeEn1 OR writeEn2);
enable1 <= (decoderOutput1(1) OR decoderOutput2(1)) AND (writeEn1 OR writeEn2);
enable2 <= (decoderOutput1(2) OR decoderOutput2(2)) AND (writeEn1 OR writeEn2);
enable3 <= (decoderOutput1(3) OR decoderOutput2(3)) AND (writeEn1 OR writeEn2);
enable4 <= (decoderOutput1(4) OR decoderOutput2(4)) AND (writeEn1 OR writeEn2);
enable5 <= (decoderOutput1(5) OR decoderOutput2(5)) AND (writeEn1 OR writeEn2);
enable6 <= (decoderOutput1(6) OR decoderOutput2(6)) AND (writeEn1 OR writeEn2);
enable7 <= (decoderOutput1(7) OR decoderOutput2(7)) AND (writeEn1 OR writeEn2);

Reg0: NRegister Generic map (16) port map(clk,rst,enable0,data0,reg0output);
Reg1: NRegister Generic map (16) port map(clk,rst,enable1,data1,reg1output);
Reg2: NRegister Generic map (16) port map(clk,rst,enable2,data2,reg2output);
Reg3: NRegister Generic map (16) port map(clk,rst,enable3,data3,reg3output);
Reg4: NRegister Generic map (16) port map(clk,rst,enable4,data4,reg4output);
Reg5: NRegister Generic map (16) port map(clk,rst,enable5,data5,reg5output);
Reg6: NRegister Generic map (16) port map(clk,rst,enable6,data6,reg6output);
Reg7: NRegister Generic map (16) port map(clk,rst,enable7,data7,reg7output);

MUXread11: Mux8x1 Generic map (16) port map(reg0output, reg1output, reg2output, reg3output, reg4output, reg5output, reg6output, reg7output, readAdd11, readData11);

MUXread12: Mux8x1 Generic map (16) port map(reg0output, reg1output, reg2output, reg3output, reg4output, reg5output, reg6output, reg7output, readAdd12, readData12);

MUXread21: Mux8x1 Generic map (16) port map(reg0output, reg1output, reg2output, reg3output, reg4output, reg5output, reg6output, reg7output, readAdd21, readData21);

MUXread22: Mux8x1 Generic map (16) port map(reg0output, reg1output, reg2output, reg3output, reg4output, reg5output, reg6output, reg7output, readAdd22, readData22);


Decode1: NDecoder Generic map (3) port map(writeAdd1, decoderOutput1);
Decode2: NDecoder Generic map (3) port map(writeAdd2, decoderOutput2);



data0 <= writeData1 WHEN writeAdd1 = "000"
ELSE  writeData2;

data1 <= writeData1 WHEN writeAdd1 = "001"
ELSE  writeData2;

data2 <= writeData1 WHEN writeAdd1 = "010"
ELSE  writeData2;

data3 <= writeData1 WHEN writeAdd1 = "011"
ELSE  writeData2;

data4 <= writeData1 WHEN writeAdd1 = "100"
ELSE  writeData2;

data5 <= writeData1 WHEN writeAdd1 = "101"
ELSE  writeData2;

data6 <= writeData1 WHEN writeAdd1 = "110"
ELSE  writeData2;

data7 <= writeData1 WHEN writeAdd1 = "111"
ELSE  writeData2;


END ArchRegisterFile;
