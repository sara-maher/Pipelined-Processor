library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith;
Use ieee.numeric_std.all;
--use IEEE.STD_LOGIC_SIGNED.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity jmp_ctrl is -- takes registers address, outs if we forward or not
    generic (n: integer := 5);
  port ( opcode : in std_logic_vector(n-1 downto 0) ;
  z_old, c_old, n_old: in std_logic;
  pcsrc: out std_logic_vector(2 downto 0));
        end ;
        
Architecture a_jmp_ctrl of jmp_ctrl is
begin
-- when do we change pc?
--  ret, rti, rst, interrupt
-- 11001,11010, 11011, 11100
-- pcsrc
-- 000 => continue
-- 001 => jmp to address
-- 010 => [0000] in memory
-- 011 => [0001] in memory
process (opcode)
variable pc: std_logic_vector (2 downto 0);
begin
if opcode = "10100"  and z_old = '1' then --jz
    pc := "001";
elsif opcode = "10101" and n_old = '1' then --jn
    pc := "001";
elsif opcode = "10110" and c_old ='1' then  --jc
    pc := "001";
elsif opcode = "10111" or opcode = "11000" then --jmp, call
    pc := "001";
  ----------------------------------------------------*********those depend on memory address jmp address = mem[sp], sp++
  --elsif opcode = "11001" or opcode = "11010" then
  --  pc :=
  -----------------------------------------------------
elsif opcode = "11011" then --rst
    pc := "010";
elsif  opcode = "11100"then --interrupt
    pc := "011";
else
    pc := "000";    --continue
end if ;
pcsrc <= pc;
end process;
end architecture a_jmp_ctrl;

