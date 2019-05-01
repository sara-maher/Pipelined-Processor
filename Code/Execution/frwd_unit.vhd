library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith;
Use ieee.numeric_std.all;
--use IEEE.STD_LOGIC_SIGNED.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity frwd_unit is -- takes registers address, outs if we forward or not
    generic (n: integer := 3);
  port ( clk: in std_logic;
  opcode_load: in std_logic_vector (4 downto 0);
  id_ex_reg_src, id_ex_reg_dst, ex_mem_reg_dst : in std_logic_vector(n-1 downto 0) ;
  mem_wb_reg_dst : in std_logic_vector(n-1 downto 0) ;
  mem_wb_reg_write_1, ex_mem_reg_write_1: in std_logic;          
  frwd_a, frwd_b: out std_logic_vector(1 downto 0));
        end ;
        
Architecture a_frwd_unit of frwd_unit is
signal mem_raw_a, mem_raw_b, wb_raw_a, wb_raw_b: std_logic;
signal a,b: std_logic_vector(1 downto 0);
begin
    -- check if reg a is dst in the instr in mem stage
mem_raw_a <= '1' when ( id_ex_reg_src = ex_mem_reg_dst)
else '0';
 -- check if reg a is dst in the instr in wb stage
wb_raw_a <= '1' when (id_ex_reg_src = mem_wb_reg_dst)
else '0';
 -- check if reg b is dst in the instr in mem stage
mem_raw_b <= '1' when (id_ex_reg_dst = ex_mem_reg_dst)
else '0';
 -- check if reg b is dst in the instr in wb stage
wb_raw_b <= '1' when (id_ex_reg_dst = mem_wb_reg_dst)
else '0';

process (clk )  --i tried working the process with inputs instead of clk but it didn't work
    --variable a,b: std_logic_vector(1 downto 0);
    begin
        if  ex_mem_reg_write_1 ='1' and mem_raw_a ='1' then
            a<="01";
        elsif mem_wb_reg_write_1='1' and wb_raw_a='1' then
            a<="10";
        elsif opcode_load = "10001" then 
            a<="11";
        else
            a<="00";
        end if;
        if ex_mem_reg_write_1='1' and mem_raw_b='1' then
            b<="01";
        elsif mem_wb_reg_write_1='1' and wb_raw_b='1' then
            b<="10";
        else
            b<="00";
        end if;
end process; 
frwd_a <= a;
frwd_b <= b;
end architecture a_frwd_unit;

