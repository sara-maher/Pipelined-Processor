library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith;
Use ieee.numeric_std.all;
--use IEEE.STD_LOGIC_SIGNED.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity alu is
    generic (n: integer := 16);
  port ( a , b : in std_logic_vector(n-1 downto 0) ;
            --cin: in std_logic;
            aluop: in std_logic_vector(3 downto 0);
            --port_wire : inout std_logic_vector(n-1 downto 0) ;
            c,neg,z: out std_logic;
          f : out std_logic_vector(n-1 downto 0));
        end ;
        
Architecture a_alu of alu is

begin
    process(a,b,aluop)
    variable temp : std_logic_vector( n downto 0);
    begin
        if (aluop = "0001") then
            c<='1';
        elsif (aluop = "0010") then
            c <='0';
        elsif (aluop = "0011") then
            f <= not(a);
        elsif (aluop = "0100") then
            temp := std_logic_vector(("0" & unsigned(a)+'1'));
	        f <= temp(n-1 downto 0);
	        c <= temp(n);
        elsif (aluop = "0101") then
            temp := std_logic_vector(("0" & unsigned(a)-'1'));
	        f <= temp(n-1 downto 0);
	        c <= temp(n);
        elsif (aluop = "0110" or aluop = "0111" or aluop = "1000") then  -- should have a signal indicating that this is a port value
            f<=a;
        -- elsif (aluop = "0111") then
        --     f<=port_wire;
        elsif (aluop = "1001") then
            temp := std_logic_vector(("0" & unsigned(a)) + unsigned(b));
	        f <= temp(n-1 downto 0);
	        c <= temp(n);
        elsif (aluop = "1010") then
            temp := std_logic_vector(("0" & unsigned(a)) - unsigned(b));
	        f <= temp(n-1 downto 0);
	        c <= temp(n);
        elsif (aluop = "1011") then
            f<=a and b;
        elsif (aluop = "1100") then
            f<=a or b;
        elsif (aluop = "1101") then
            f<= std_logic_vector(unsigned(a) sll to_Integer(unsigned(b)));
        elsif (aluop = "1110") then
            f<=std_logic_vector(unsigned(a) srl to_Integer(unsigned(b))); 
        else 
            f<=(others=>'0');
        end if;
        neg <= f(n-1);
    end process;
--port_wire <= f when aluop = "0110" else --set port_wire, should this be an output and then muxed   ?
--(others=>'Z');
z <= '1' when f = "0000" else
'0';



end architecture a_alu;

