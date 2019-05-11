library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith;
Use ieee.numeric_std.all;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity ctrl_unit is -- takes registers address, outs if we forward or not
    generic (n: integer := 32);
  port ( ir: in std_logic_vector (n-1 downto 0);
  	reg1_write, reg2_write, memwrite, memread: out std_logic;
  	dst1_address, dst2_address, src1_address, src2_address : out std_logic_vector (2 downto 0);
	MemToReg: OUT std_logic;
	opCode1,opCode2: OUT std_logic_vector(4 downto 0);
	immediate1: out std_logic_vector(4 downto 0);--immediate val for SHL, SHR
	immediate2:out std_logic_vector(15 downto 0));--for LDM
end ;
        
Architecture a_ctrl_unit of ctrl_unit is
begin

process (ir)

variable wr1, wr2, mw, mr: std_logic:='0';
variable dst1:  std_logic_vector (2 downto 0);
variable dst2:  std_logic_vector (2 downto 0);
variable src1:  std_logic_vector (2 downto 0);
variable src2:  std_logic_vector (2 downto 0);
variable sel:  std_logic;
variable imm1:  std_logic_vector(4 downto 0);
variable imm2:  std_logic_vector(15 downto 0);
variable add: std_logic_vector(31 downto 0);

begin

    if ir(28 downto 24) = "00000" OR ir(28 downto 24) = "00001" OR ir(28 downto 24) = "00010" OR ir(28 downto 24) = "10100" OR ir(28 downto 24) = "10101" OR ir(28 downto 24) = "10110" OR ir(28 downto 24) = "10111" then --NOP, SETC, CLRC, jz, jn, jc, jmp
        wr1 := '0';
    else  --NOT, INC, DEC, MOV, ADD, SUB, AND, OR, SHL, SHR
        wr1 := '1';
    end if ;

    if ir(12 downto 8) = "00110" OR ir(12 downto 8) = "01111" OR ir(12 downto 8) = "10011" OR ir(12 downto 8) = "11011" then --out,push,std,reset
        wr2 := '0';
    else  -- in, pop, ldm, ldd, call, ret, rti, reset, interrupt
        wr2 := '1';
    end if ;

    if ir(12 downto 8) = "01111" OR ir(12 downto 8) = "10011" OR ir(12 downto 8) = "11000" OR ir(12 downto 8) = "11100" then --push, std, call, interrupt
        mw := '1';
    else  --out, in, pop, ldm, ldd, ret, rti, reset
        mw := '0';
    end if ;

    if ir(12 downto 8) = "10000" OR ir(12 downto 8) = "10010" OR ir(12 downto 8) = "11001" OR ir(12 downto 8) = "11010" then -- pop, ldd, ret, rti
        mr := '1';
    else  --in, out, push, ldm, std, call, reset, interrupt
        mr := '0';
    end if ;

    if ir (30 downto 29) = "01" then
        dst1 := ir(23 downto 21);
    elsif ir (30 downto 29) = "10" then
	dst1 := ir(20 downto 18);
    else
        dst1 := (others => '0');
    end if;

    if ir (14 downto 13) = "01" then
        dst2 := ir(7 downto 5);
    elsif ir (14 downto 13) = "10" then
	dst2 := ir(4 downto 2);
    else
        dst2 := (others => '0');
    end if;

     if ir (30 downto 29) = "10" then
        src1 := ir(23 downto 21);
    elsif ir (30 downto 29) = "01" then
	src1 := ir(20 downto 18);
    else
        src1 := (others => '0');
    end if;

     if ir (14 downto 13) = "10" then
        src2 := ir(7 downto 5);
    elsif ir (14 downto 13) = "01" then
	src2 := ir(4 downto 2);
    else
        src2 := (others => '0');
    end if;

	
     if ir (12 downto 8) = "10001" then
        sel := '1';
    elsif ir (12 downto 8) = "10010" then
	sel := '0';
    else
        sel := '0';
    end if;

    if  ir(28 downto 24) = "01101" or ir(28 downto 24) = "01110" then
	imm1 := ir(20 downto 16);
    else
	imm1 := (others=>'0');
    end if;

    if  ir(12 downto 8) = "10001" then
	imm2 := ir(31 downto 16);
    else
	imm2 := (others=>'0');
    end if;

   	

    reg1_write <=wr1;
    reg2_write <=wr2;
    memwrite <=mw;
    memread <= mr;
    dst1_address <= dst1;
    dst2_address <= dst2;
    src1_address <= src1;
    src2_address <= src2;
    MemToReg <= sel;
    opCode1 <= ir(28 downto 24);
    opCode2 <= ir(12 downto 8);
    immediate1 <= imm1;
    immediate2 <= imm2;

end process;
end architecture a_ctrl_unit;

