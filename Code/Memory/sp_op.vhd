library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith;
Use ieee.numeric_std.all;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity sp_op is -- takes registers address, outs if we forward or not
    generic (n: integer := 32);
  port ( 
      sp_in: in std_logic_vector(n-1 downto 0);
      opcode: in std_logic_vector(4 downto 0);
      dec_out: out std_logic_vector(n-1 downto 0)
  );
        end ;
        
Architecture a_sp_op of sp_op is
signal dec_sig,dec2_sig,inc_sig, inc2_sig: std_logic_vector (n-1 downto 0);
begin
dec_sig <= std_logic_vector(unsigned(sp_in)-"001");
--dec2_sig <= std_logic_vector(unsigned(sp_in)-"010");
inc_sig <= std_logic_vector(unsigned(sp_in)+"001");
--inc2_sig <= std_logic_vector(unsigned(sp_in)+"010");
dec_out <= dec_sig when (opcode = "01111" or opcode = "11000" or opcode ="11100") --push
--else dec2_sig when (opcode = "11000" or opcode ="11100") --call, interrupt
else inc_sig when (opcode = "10000" or opcode = "11001" or opcode ="11010") --pop
--else inc2_sig when (opcode = "11001" or opcode ="11010") --RET,RTI
else sp_in;
end architecture a_sp_op;

