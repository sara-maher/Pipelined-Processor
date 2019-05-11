library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith;
Use ieee.numeric_std.all;
--use IEEE.STD_LOGIC_SIGNED.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity mux5x1 is -- takes registers address, outs if we forward or not
    generic (n: integer := 16);
  port ( a,b,c,d: in std_logic_vector(n-1 downto 0) ;
  e : in std_logic_vector(4 downto 0) ;
  sel : in std_logic_vector(2 downto 0) ;
  f: out std_logic_vector(n-1 downto 0));
        end ;
        
Architecture a_mux5x1 of mux5x1 is
begin
   f <= a when (sel = "000")
   else b when (sel = "001")
   else c when (sel = "010")
   else d when (sel = "011")
   else "00000000000"&e;
end architecture a_mux5x1;

