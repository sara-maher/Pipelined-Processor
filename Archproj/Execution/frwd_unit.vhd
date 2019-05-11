library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith;
Use ieee.numeric_std.all;
--use IEEE.STD_LOGIC_SIGNED.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity frwd_unit is -- takes registers address, outs if we forward or not
    generic (n: integer := 3);
  port ( clk: in std_logic;
  opcode_load, opcode_alu: in std_logic_vector (4 downto 0);
  id_ex_reg_src, id_ex_reg_dst, ex_mem_reg_dst : in std_logic_vector(n-1 downto 0) ;
  mem_wb_reg_dst1, mem_wb_reg_dst2 : in std_logic_vector(n-1 downto 0) ;
  mem_wb_reg_write_1,mem_wb_reg_write_2, ex_mem_reg_write_1: in std_logic;          
  frwd_a, frwd_b: out std_logic_vector(2 downto 0));
        end ;
        
Architecture a_frwd_unit of frwd_unit is
signal mem_raw_a, mem_raw_b, wb_raw_a1, wb_raw_b1, wb_raw_a2, wb_raw_b2: std_logic;
signal a,b: std_logic_vector(2 downto 0);
begin
    -- check if reg a is dst in the instr in mem stage
mem_raw_a <= '1' when ( id_ex_reg_src = ex_mem_reg_dst)
else '0';
 -- check if reg a is dst in the instr in wb stage
wb_raw_a1 <= '1' when (id_ex_reg_src = mem_wb_reg_dst1)
else '0';
wb_raw_a2 <= '1' when (id_ex_reg_src = mem_wb_reg_dst2)
else '0';
 -- check if reg b is dst in the instr in mem stage
mem_raw_b <= '1' when (id_ex_reg_dst = ex_mem_reg_dst)
else '0';
 -- check if reg b is dst in the instr in wb stage
wb_raw_b1 <= '1' when (id_ex_reg_dst = mem_wb_reg_dst1)
else '0';
wb_raw_b2 <= '1' when (id_ex_reg_dst = mem_wb_reg_dst2)
else '0';

process (clk )  --i tried working the process with inputs instead of clk but it didn't work
    --variable a,b: std_logic_vector(1 downto 0);
    begin
        if  ex_mem_reg_write_1 ='1' and mem_raw_a ='1' then
            a<="001";
        elsif mem_wb_reg_write_1='1' and wb_raw_a1='1' then
            a<="010";
        elsif mem_wb_reg_write_2='1' and wb_raw_a2='1' then
            a<="011";
        else
            a<="000";
        end if;
        if ex_mem_reg_write_1='1' and mem_raw_b='1' then
            b<="001";
        elsif mem_wb_reg_write_1='1' and wb_raw_b1='1' then
            b<="010";
        elsif mem_wb_reg_write_2='1' and wb_raw_b2='1' then
            b<="011";
        elsif opcode_load = "10001" or opcode_alu ="01101" or opcode_alu = "01110" then 
            b<="100";
        else
            b<="000";
        end if;
end process; 
frwd_a <= a;
frwd_b <= b;
end architecture a_frwd_unit;

