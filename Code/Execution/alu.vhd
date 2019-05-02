library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith;
Use ieee.numeric_std.all;
--use IEEE.STD_LOGIC_SIGNED.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity alu is
    generic (n: integer := 16);
  port ( a , b : in std_logic_vector(n-1 downto 0) ;
            aluop: in std_logic_vector(4 downto 0);
            c,neg,z: out std_logic :='0';
          f : out std_logic_vector(n-1 downto 0));
        end ;
        
Architecture a_alu of alu is
begin
    process(a,b,aluop)
    variable temp : std_logic_vector( n downto 0);
    variable c_temp, n_temp, z_temp: std_logic := '0';
    begin
        --temp(n) :='0'
        if (aluop = "00000") then    -- NOP 00000 - 0 6
            temp(n-1 downto 0) := X"0000";
        elsif (aluop = "00001") then    -- SETC 00001 - 0 6
            c<='1';
        elsif (aluop = "00010") then   -- CLRC 00010 - 0 6
            c<='0';
        elsif (aluop = "00011") then     -- NOT Rdst 00011 xxx 0 9
            temp(n-1 downto 0) := not(a);
        elsif (aluop = "00100") then     -- INC Rdst 00100 xxx 0 9
            temp := std_logic_vector(("0" & unsigned(a)+'1'));
	        --f <= temp(n-1 downto 0);
	        c <= temp(n);
        elsif (aluop = "00101") then     -- DEC Rdst 00101 xxx 0 9
            temp := std_logic_vector(("0" & unsigned(a)-'1'));
	        --f <= temp(n-1 downto 0);
	        c <= temp(n);
        elsif (aluop = "01001") then     -- ADD Rsrc, Rdst 01001 xxx xxx 0 12
            temp := std_logic_vector(("0" & unsigned(a)) + unsigned(b));
	        --f <= temp(n-1 downto 0);
	        c <= temp(n);
        elsif (aluop = "01010") then     -- SUB Rsrc, Rdst 01010 xxx xxx 0 12
            temp := std_logic_vector(("0" & unsigned(a)) - unsigned(b));
	        --f <= temp(n-1 downto 0);
	        c <= temp(n);
        elsif (aluop = "01011") then -- AND Rsrc, Rdst 01011 xxx xxx 0 12
            temp(n-1 downto 0) := a and b;
        elsif (aluop = "01100") then     -- OR Rsrc, Rdst 01100 xxx xxx 0 12
            temp(n-1 downto 0) :=a or b;
        elsif (aluop = "01101") then    -- SHL Rsrc, Rdst 01101 xxx xxx 0 12
            c<= a(n-to_integer(unsigned(b)));
            temp(n-1 downto 0) := std_logic_vector(unsigned(a) sll to_Integer(unsigned(b)));
        elsif (aluop = "1110") then     -- SHR Rsrc, Rdst 01110 xxx xxx 0 12
            c<= a(to_integer(unsigned(b)-'1'));
            temp (n-1 downto 0 ):=std_logic_vector(unsigned(a) srl to_Integer(unsigned(b))); 
        -- MOV Rsrc, Rdst 01000 xxx xxx 0 12
        -- JZ Rdst 10100 xxx 0 9
        -- JN Rdst 10101 xxx 0 9
        -- JC Rdst 10110 xxx 0 9
        -- JMP Rdst 10111 xxx 0 9
        elsif (aluop = "01000" or aluop = "10100" or aluop = "10101" or aluop = "10110" or aluop = "10111") then  -- should have a signal indicating that this is a port value
            temp (n-1 downto 0 ):=a;
        -- Reset 11011 - 1 6
        else  -- never should be here
            temp (n-1 downto 0 ) :=(others=>'Z');
        end if;
        if (aluop ="00011" or aluop ="00100" or aluop ="00101" or aluop ="01001" or aluop ="01011" or aluop ="01010" or aluop ="01100" or aluop ="01101" or aluop ="01110") then
            if (temp (n-1 downto 0 ) = X"0000") then
                z_temp :='1';
            else
                z_temp :='0';
            --c_temp := temp(n);
            n_temp := temp(n-1);
            end if;
        end if;
        --c <= temp(n);
        z <= z_temp;
        neg <= n_temp;
        f <= temp(n-1 downto 0);
    end process;
--port_wire <= f when aluop = "0110" else --set port_wire, should this be an output and then muxed   ?
--(others=>'Z');
-- z <= '1' when f = "0000" else
-- '0';



end architecture a_alu;

