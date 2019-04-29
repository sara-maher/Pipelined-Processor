library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith;
Use ieee.numeric_std.all;
--use IEEE.STD_LOGIC_SIGNED.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity excute is
    generic (n: integer := 16);
  port ( a , b : in std_logic_vector(n-1 downto 0) ;
            --port_wire : inout std_logic_vector(n-1 downto 0) ;
            pc_src: out std_logic;
            JmpAddress: out std_logic_vector(n-1 downto 0) ;
          f : out std_logic_vector(n-1 downto 0));
        end ;
        
Architecture a_excute of excute is
    
begin
    ALU_instance: entity work.alu
        generic (n=> n)
      port ( a , b : in std_logic_vector(n-1 downto 0) ;
                --cin: in std_logic;
                aluop: in std_logic_vector(3 downto 0);
                --port_wire : inout std_logic_vector(n-1 downto 0) ;
                c,neg,z: out std_logic;
              f : out std_logic_vector(n-1 downto 0));
            end ;
           
--port_wire <= f when aluop = "0110" else --set port_wire, should this be an output and then muxed   ?
--(others=>'Z');



end architecture a_excute;

