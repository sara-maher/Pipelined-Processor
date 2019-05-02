library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith;
Use ieee.numeric_std.all;
--use IEEE.STD_LOGIC_SIGNED.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity mux4x1 is -- takes registers address, outs if we forward or not
    generic (n: integer := 16);
  port ( a,b,c,d : in std_logic_vector(n-1 downto 0) ;
  sel : in std_logic_vector(1 downto 0) ;
  f: out std_logic_vector(n-1 downto 0));
        end ;
        
Architecture a_mux4x1 of mux4x1 is
begin
   f <= a when (sel = "00")
   else b when (sel = "01")
   else c when (sel = "10")
   else d;
end architecture a_mux4x1;

