LIBRARY IEEE;
USE IEEE.std_logic_1164.all;

ENTITY Main IS
GENERIC (N:integer:=16);
Port(
	clk,rst : IN std_logic;
	inputPort: IN std_logic_vector(15 downto 0);
	outputPort: OUT std_logic_vector(15 downto 0);
	interruptSig: IN std_logic
);
END Main;

ARCHITECTURE ArchMain OF Main IS
----------------------Signals------------------------
-----fetch----
SIGNAL IR,PC: std_logic_vector(31 downto 0);
-----------
---fecdecbuff---
SIGNAL IfDecPcout,IfDecIRout: std_logic_vector(31 downto 0);
---------------
-------------
----CU----
SIGNAL writeEn1,writeEn2,memWrite,memRead: std_logic;
SIGNAL dst1Address,dst2Address,src1Address,src2Address: std_logic_vector(2 downto 0);
SIGNAL opCode1, opCode2: std_logic_vector(4 downto 0);
SIGNAL immediate1:std_logic_vector(4 downto 0);
SIGNAL immediate2:std_logic_vector(15 downto 0);
SIGNAL MemtoRegSel: std_logic;
-----------
---regfile---
--SIGNAL readAdd11: std_logic;
--SIGNAL readAdd12: std_logic;
--SIGNAL readAdd21: std_logic;
--SIGNAL readAdd22: std_logic;
--SIGNAL readData11 : std_logic_vector(15 DOWNTO 0);
--SIGNAL readData12 : std_logic_vector(15 DOWNTO 0);
--SIGNAL readData21 : std_logic_vector(15 DOWNTO 0);
--SIGNAL readData22 : std_logic_vector(15 DOWNTO 0)

SIGNAL src1Data,dst1Data,src2Data,dst2Data: std_logic_vector(15 DOWNTO 0);
------
--------------------------------------------
SIGNAL PCSrc: std_logic_vector(1 downto 0); 
SIGNAL Jump_add: std_logic_vector(31 downto 0);
SIGNAL stall: std_logic;
-----------DECEX----
SIGNAL DECEXPCOutput:std_logic_vector(31 downto 0);
SIGNAL DECEXopCode1Output,DECEXopCode2Output: std_logic_vector(4 downto 0);
SIGNAL DECEXwriteAdd1Output,DECEXwriteAdd2Output: std_logic_vector(2 downto 0);
SIGNAL DecExsrc1Address,DecExdst1Address,DecExsrc2Address,DecExdst2Address:std_logic_vector(2 downto 0);
SIGNAL DecExsrc1Data,DecExdst1Data,DecExsrc2Data,DecExdst2Data:std_logic_vector(15 downto 0);
SIGNAL DECEXimmediate1Output: std_logic_vector(4 downto 0);
SIGNAL DECEXimmediate2Output: std_logic_vector(15 downto 0);
SIGNAL DECEXwriteEn1Output, DECEXwriteEn2Output, DECEXmemWriteOutput, DECEXmemReadOutput: std_logic;
SIGNAL DecExMemAddressOutput: std_logic_vector(31 downto 0);
SIGNAL DecExMemDataOutput:  std_logic_vector(15 downto 0);
SIGNAL DecExMemtoRegSel: std_logic;
---------------flag reg-------------------
SIGNAL AluFlags,FlagRegOutput: std_logic_vector(2 downto 0);
SIGNAL ALuC,ALUz,ALUn: std_logic;
-------------execute----------
SIGNAL AluOutput: std_logic_vector(15 downto 0);
SIGNAL EXPCSrc: std_logic_vector(2 downto 0);
---------EX/MEM---------
SIGNAL ExMemsrc1Address,ExMemdst1Address,ExMemsrc2Address,ExMemdst2Address:std_logic_vector(2 downto 0);
SIGNAL ExMemsrc1Data,ExMemdst1Data,ExMemsrc2Data,ExMemdst2Data: std_logic_vector(15 downto 0);
SIGNAL ExMemimmediate1: std_logic_vector(4 downto 0);
SIGNAL ExMemimmediate2: std_logic_vector(15 downto 0);
SIGNAL ExMemAluOutput: std_logic_vector(15 downto 0);
SIGNAL ExMemMemWrite,ExMemMemRead: std_logic;
SIGNAL ExMemwriteEn1, ExMemwriteEn2: std_logic;
SIGNAL ExDecMemtoRegSel: std_logic;
---------------memory----------------
SIGNAL DataMemOutput: std_logic_vector(15 downto 0);
SIGNAL DataAddress: std_logic_vector(31 downto 0);
-----------Mem/wb-----------
SIGNAL MemWbDataMemOutput: std_logic_vector(15 downto 0);
SIGNAL MemWbdst1Address, MemWbdst2Address: std_logic_vector(2 downto 0);
SIGNAL MemWbwriteEn1, MemWbwriteEn2: std_logic;
SIGNAL MemWbAluOutput: std_logic_vector(15 downto 0);
SIGNAL MemWbimmediate2: std_logic_vector(15 downto 0);
SIGNAL MemWbMemtoRegSel: std_logic;
SIGNAL MemWbdst1Data,MemWbdst2Data: std_logic_vector(15 downto 0);
------------------
SIGNAL tempSig: std_logic_vector(19 downto 0);
--------------------------wb-------------------

SIGNAL Write1Data,Write2Data : std_logic_vector(15 downto 0);
--------------------------cnt---------------------
SIGNAL cntOutput: std_logic_vector(19 downto 0);
SIGNAL tempSig2: std_logic_vector(19 downto 0);
----------------------Components---------------------
COMPONENT Fetch is
	PORT(
       		clk : IN std_logic; 
		rst : IN std_logic;
      		Pcsrc : IN std_logic_vector( 1 downto 0);
		IR  : OUT std_logic_vector( 31 downto 0);
		Jump_add : IN std_logic_vector(31 downto 0);
		stall: IN std_logic;		
		PC  : OUT std_logic_vector( 31 downto 0)
	     );
END COMPONENT Fetch;
--------------------------------------------------
COMPONENT IfDec IS
Port(
	clk,rst : IN std_logic;
	PC,IR: IN std_logic_vector(31 downto 0);
	PCOutput,IROutput: OUT std_logic_vector(31 downto 0)
);
END COMPONENT IfDec;
------------------------------------------------
COMPONENT NRegister IS
GENERIC (N:integer:=16);
Port(
	clk,rst,enable : IN std_logic;
	data : IN std_logic_vector(N-1 DOWNTO 0);
	output : OUT std_logic_vector(N-1 DOWNTO 0) );
END COMPONENT NRegister;
----------------------------------------------------
COMPONENT RegisterFile IS
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
END COMPONENT RegisterFile;
-----------------------------------------------------------
COMPONENT ctrl_unit is -- takes registers address, outs if we forward or not
    generic (n: integer := 32);
    port (
        ir: in std_logic_vector (n-1 downto 0);
  	reg1_write, reg2_write, memwrite, memread: out std_logic;
  	dst1_address, dst2_address, src1_address, src2_address : out std_logic_vector (2 downto 0);
	MemToReg: OUT std_logic;
	opCode1,opCode2: OUT std_logic_vector(4 downto 0);
	immediate1: out std_logic_vector(4 downto 0);--immediate val for SHL, SHR
	immediate2:out std_logic_vector(15 downto 0));--for LDM

END COMPONENT ctrl_unit;
-------------------------------------------------------------
COMPONENT DecEx IS
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
END COMPONENT DecEx;
--------------------------------------------------------------
COMPONENT excute is
    generic (n: integer := 16);
  port (clk, c_mem, z_mem, n_mem: in std_logic;
        id_ex_src_val, id_ex_dst_val , ex_mem_reg_val, mem_wb_reg_val_alu, mem_wb_reg_val_ld: in std_logic_vector(n-1 downto 0) ;
       	id_ex_reg_src, id_ex_reg_dst , ex_mem_reg_dst, mem_wb_reg_dst_alu, mem_wb_reg_dst_ld : in std_logic_vector(2 downto 0) ;
       	mem_wb_reg_write_1, ex_mem_reg_write_1, mem_wb_reg_write_2: in std_logic;
    	immediate_val: std_logic_vector(4 downto 0);

    	opcode_alu, opcode_load: in std_logic_vector (4 downto 0);
    	port_wire : out std_logic_vector(n-1 downto 0) ;
    	pcsrc:out std_logic_vector(2 downto 0);
    	c,z,neg: out std_logic;
    	JmpAddress: out std_logic_vector(n-1 downto 0);
	AluOutput: OUT std_logic_vector(15 downto 0)
        );
end COMPONENT excute;
--------------------Ex/Mem Buff------------------------------
COMPONENT ExMem IS
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
END COMPONENT ExMem;
-------------------DataMem----------------------------
COMPONENT DataRAM IS
	PORT(
		clk : IN std_logic;
		we  : IN std_logic;
		re : IN std_logic;
		address : IN  std_logic_vector(31 DOWNTO 0);
		datain  : IN  std_logic_vector(15 DOWNTO 0);
		dataout : OUT std_logic_vector(15 DOWNTO 0)
		);

END COMPONENT DataRAM;
------------------mem/wb-------------------------
COMPONENT MemWb IS
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
END COMPONENT MemWb;
-------------------WB------------------------------
COMPONENT WB IS
	PORT(
	     MemToReg1:IN std_logic;--flag
	     Read1Data : IN std_logic_vector(15 downto 0); -- from memory
             Immediate : IN std_logic_vector(15 downto 0);-- Immediate date (LDM)
	     LoadData : IN std_logic_vector (15 downto 0); -- data from ALU

	     Write1Data,Write2Data : out std_logic_vector(15 downto 0)
		);
END COMPONENT WB;
------------------counter-------------------------------
COMPONENT Counter IS
GENERIC (N: INTEGER := 4);
PORT(
	clk, rst, enable : IN STD_LOGIC;
        count : OUT STD_LOGIC_VECTOR(n-1 DOWNTO 0));
END COMPONENT Counter;
------------------Code-----------------------------------
BEGIN
-----------------------------------fetch---------------
cntCOMP: Counter GENERIC MAP(20) Port MAP(clk,rst,'1',cntOutput); 

tempSig <= (others=>'0');
tempSig2(19 downto 3) <= (others=>'0');
tempSig2(2 downto 0) <= "101";

PCSrc <= "10" WHEN cntOutput(19 downto 0) =  tempSig--cnt = 0
    Else "00" WHEN cntOutput < tempSig2 --cnt<5
    ELSE EXPCSrc(1 downto 0);

stall <= '0'; --modify

FechComp: Fetch Port MAP(clk, rst, PCSrc, IR, Jump_add, stall,PC);
IfDecBuff: IfDec Port MAP(clk, rst, PC, IR, IfDecPcout, IfDecIRout);
------------------------------------Decode-----------------------------------------------
-----------------------------------------------------------------------------------
--PCReg: NRegister Generic MAP(32) PORT MAP(clk,rst,'1',IfDecPcout,PCOutput);
CU: ctrl_unit PORT MAP(IfDecIRout, writeEn1, writeEn2, memWrite, memRead, dst1Address,dst2Address,src1Address,src2Address,MemtoRegSel,opCode1,opCode2,immediate1,immediate2);
-----------------------------------------------------------------------------------------------------------------
RegFileComp: RegisterFile PORT MAP(clk,rst,MemWbdst1Address, MemWbdst2Address,Write1Data,Write2Data,
					MemWbwriteEn1, MemWbwriteEn2,src1Address,dst1Address,src2Address,dst2Address,src1Data,dst1Data,src2Data,dst2Data);
--------------------------------------------------------------------------------------------------------------
DECEXBuff: DecEx Port MAP(clk,rst,opCode1,opCode2,src1Address,dst1Address,src2Address,dst2Address,src1Data,dst1Data,src2Data,dst2Data,
		          immediate1,immediate2, writeEn1, writeEn2,memWrite, memRead,
			  MemtoRegSel, 
			  DecExMemtoRegSel,
			  DecExopCode1Output,DecExopCode2Output,
			  DecExsrc1Address,DecExdst1Address,DecExsrc2Address,DecExdst2Address,
			  DecExsrc1Data,DecExdst1Data,DecExsrc2Data,DecExdst2Data,
			  DecEximmediate1Output,DecEximmediate2Output,
			  DecExwriteEn1Output, DecExwriteEn2Output, DecExmemWriteOutput, DecExmemReadOutput);
-----------------------------------Execute---------------------------------------------------
-------------------------------------------------------------------------------------
--ExMemFUDstVal <= ExMemReg11Output WHEN ExMemwriteAdd1Output = ExMemRegAdd11Output
--ELSE ExMemReg12Output WHEN ExMemwriteAdd1Output = ExMemRegAdd12Output 
--ELSE ExMemReg21Output WHEN ExMemwriteAdd1Output = ExMemRegAdd21Output
--ELSE ExMemReg22Output;

ExComp:  excute port MAP (clk, FlagRegOutput(0), FlagRegOutput(1), FlagRegOutput(2),
        		  DecExsrc1Data, DecExdst1Data, 

			  ExMemdst1Data, MemWbdst1Data, MemWbdst2Data,

       			  DecExsrc1Address, DecExdst1Address,

			  ExMemdst1Address, MemWbdst1Address, MemWbdst2Address,

		       	  MemWbWriteEn1, ExMemWriteEn1, MemWbWriteEn2,

		    	  DecEximmediate1Output,DecExopCode1Output,DecExopCode2Output,

		    	  outputPort, EXPCSrc, ALuC,AluZ,AluN,Jump_add,AluOutput);

AluFlags(0) <= ALuC;
AluFlags(1) <= ALuZ;
AluFlags(2) <= ALuN;
FlagReg: NRegister Generic MAP(3) PORT MAP(clk,rst,'1',AluFlags,FlagRegOutput);

ExMemBuff: ExMem port Map(clk,rst,

			  DecExsrc1Address,DecExdst1Address,DecExsrc2Address,DecExdst2Address,
			  DecExsrc1Data,DecExdst1Data,DecExsrc2Data,DecExdst2Data,
			  DecEximmediate1Output,DecEximmediate2Output,
			  AluOutput,
			  DecExMemWriteOutput,DecExMemReadOutput,
			  DecExwriteEn1Output, DECEXwriteEn2Output,
			  DecExMemtoRegSel, 
			  ExDecMemtoRegSel,  

			  ExMemsrc1Address,ExMemdst1Address,ExMemsrc2Address,ExMemdst2Address,
			  ExMemsrc1Data,ExMemdst1Data,ExMemsrc2Data,ExMemdst2Data,
			  ExMemimmediate1,ExMemimmediate2,
			  ExMemAluOutput,
			  ExMemMemWrite,ExMemMemRead,
			  ExMemwriteEn1, ExMemwriteEn2
			  );

----------------------------------Memory---------------------
-----------------------------------------------------------
DataAddress(15 downto 0) <=  ExMemsrc2Data;
DataAddress(31 downto 16) <= (others =>'0');

DataMEM: DataRAM PORT MAP(clk,ExMemMemWrite, ExMemMemRead, DataAddress,ExMemdst2Data,DataMemOutput); 

MemWbBuff: MemWb PORT MAP(
	clk,rst,
        ExMemAluOutput,
	DataMemOutput,
	ExMemdst1Address, ExMemdst2Address,
	ExMemdst1Data,ExMemdst2Data,
	ExMemwriteEn1, ExMemwriteEn2,

	ExMemimmediate2, 
	ExDecMemtoRegSel, 
	MemWbMemtoRegSel, 

	MemWbDataMemOutput,
	MemWbdst1Address, MemWbdst2Address,
	MemWbdst1Data,MemWbdst2Data, 
	MemWbwriteEn1, MemWbwriteEn2,MemWbAluOutput,
	MemWbimmediate2); 

---------------------------------WB---------------------------
------------------------------------------------------------
WbComp:WB PORT MAP(
	     MemWbMemtoRegSel,
	     MemWbDataMemOutput,
             MemWbimmediate2,
	     MemWbAluOutput,
	     Write1Data,Write2Data);


END ArchMain;
