library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity ff_register is
generic(N : integer := 16);
port( enable,clk,rst : in STD_LOGIC;
 a : in STD_LOGIC_VECTOR(N-1  downto 0);
b :out STD_LOGIC_VECTOR(N-1  downto 0));
end;

architecture a_ff_register of ff_register is 
begin
    process(clk, rst)
    begin
        if rst = '1' then
            b <= (others=> '0');
        elsif falling_edge(clk) and enable= '1' then
            b<= a;
        end if;
    end process;
end a_ff_register;