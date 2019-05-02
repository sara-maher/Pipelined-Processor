library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith;
Use ieee.numeric_std.all;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity ctrl_unit is -- takes registers address, outs if we forward or not
    generic (n: integer := 32);
  port ( ir: in std_logic_vector (n-1 downto 0);
  reg1_write, reg2_write, memwrite, memread: out std_logic);
        end ;
        
Architecture a_ctrl_unit of ctrl_unit is
begin
process (ir)
variable wr1, wr2, mw, mr: std_logic:='0';
begin

    if ir(30 downto 26) = "00000" OR ir(30 downto 26) = "00001" OR ir(30 downto 26) = "00010" OR ir(30 downto 26) = "10100" OR ir(30 downto 26) = "10101" OR ir(30 downto 26) = "10110" OR ir(30 downto 26) = "10111" then --NOP, SETC, CLRC, jz, jn, jc, jmp
        wr1 := '0';
    else  --NOT, INC, DEC, MOV, ADD, SUB, AND, OR, SHL, SHR
        wr1 := '1';
    end if ;

    if ir(14 downto 10) = "00110" OR ir(14 downto 10) = "01111" OR ir(14 downto 10) = "10011" OR ir(14 downto 10) = "11011" then --out,push,std,reset
        wr2 := '0';
    else  --in, pop, ldm, ldd, call, ret, rti, reset, interrupt
        wr2 := '1';
    end if ;

    if ir(14 downto 10) = "01111" OR ir(14 downto 10) = "10011" OR ir(14 downto 10) = "11000" OR ir(14 downto 10) = "11100" then --push, std, call, interrupt
        mw := '1';
    else  --out, in, pop, ldm, ldd, ret, rti, reset
        mw := '0';
    end if ;

    if ir(14 downto 10) = "10000" OR ir(14 downto 10) = "10010" OR ir(14 downto 10) = "11001" OR ir(14 downto 10) = "11010" then -- pop, ldd, ret, rti
        mr := '1';
    else  --in, out, push, ldm, std, call, reset, interrupt
        mr := '0';
    end if ;
    reg1_write <=wr1;
    reg2_write <=wr2;
    memwrite <=mw;
    memread <= mr;
end process;
end architecture a_ctrl_unit;

