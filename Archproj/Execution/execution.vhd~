library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith;
Use ieee.numeric_std.all;
--use IEEE.STD_LOGIC_SIGNED.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity excute is
  generic (n: integer := 16);
  port (clk, c_mem, z_mem, n_mem: in std_logic;
        id_ex_src_val, id_ex_dst_val , ex_mem_reg_val, mem_wb_reg_val_alu, mem_wb_reg_val_ld: in std_logic_vector(n-1 downto 0) ;
       	id_ex_reg_src, id_ex_reg_dst , ex_mem_reg_dst, mem_wb_reg_dst_alu, mem_wb_reg_dst_ld : in std_logic_vector(2 downto 0) ;
       	mem_wb_reg_write_1, ex_mem_reg_write_1, mem_wb_reg_write_2: in std_logic;
    	immediate_val: in std_logic_vector(4 downto 0);

    	opcode_alu, opcode_load: in std_logic_vector (4 downto 0);
    	port_wire : out std_logic_vector(n-1 downto 0) ;
    	pcsrc:out std_logic_vector(2 downto 0);
    	c,z,neg: out std_logic;
    	JmpAddress: out std_logic_vector(31 downto 0);
	AluOutput: OUT std_logic_vector(15 downto 0)
        );
end ;
        
Architecture a_excute of excute is
    signal AluOp_a, AluOp_b, Alu_out: std_logic_vector(n-1 downto 0) ;
    signal AluOp: std_logic_vector (4 downto 0);
    signal frwd_a, frwd_b: std_logic_vector(2 downto 0);
begin
  AluOp <= opcode_load when (opcode_load = "10001")
      else opcode_alu;
    forward_unit: entity work.frwd_unit
      generic map(n=> 3)
      port map( clk =>clk,
      opcode_load =>opcode_load, opcode_alu =>opcode_alu,
            id_ex_reg_src => id_ex_reg_src, id_ex_reg_dst =>id_ex_reg_dst,
            ex_mem_reg_dst =>ex_mem_reg_dst,
            mem_wb_reg_dst1 => mem_wb_reg_dst_alu, mem_wb_reg_dst2 => mem_wb_reg_dst_ld,
            mem_wb_reg_write_1 => mem_wb_reg_write_1, ex_mem_reg_write_1=> ex_mem_reg_write_1,
            mem_wb_reg_write_2=> mem_wb_reg_write_2,
            frwd_a => frwd_a, frwd_b=>frwd_b);
    
    mux_a: entity work.mux5x1
      generic map(n=> n)
      port map( a=>id_ex_src_val,b =>ex_mem_reg_val,c=> mem_wb_reg_val_alu, d=>mem_wb_reg_val_ld, e=>(others=>'0'),
        sel =>frwd_a, f => AluOp_a);
    
    mux_b: entity work.mux5x1
      generic map(n=> n)
      port map( a => id_ex_dst_val,b =>ex_mem_reg_val,c=>  mem_wb_reg_val_alu,d=>mem_wb_reg_val_ld, e=>immediate_val,
          sel =>frwd_b,
          f=>AluOp_b);

    ALU_instance: entity work.alu
      generic map(n=> n)
      port map( a =>AluOp_a, b =>AluOp_b,
          aluop => AluOp,
          c => c,neg => neg,z =>z,
          f => Alu_out);

    jmp_control: entity work.jmp_ctrl
      generic map (n=> 5)
      port map( opcode => opcode_alu,
          z_old =>z_mem, c_old=>c_mem, n_old=> n_mem,
          pcsrc=>pcsrc);

    port_wire <= Alu_out when opcode_alu = "00110" else --set port_wire, should this be an output and then muxed   ?
    (others=>'Z');

    JmpAddress(15 downto 0) <= Alu_out;
    JmpAddress (31 downto 16) <= (others =>Alu_out(15));
     AluOutput <= Alu_out;

-- operations
-- OUT Rdst 00110 xxx 1 9
-- IN Rdst 00111 xxx 1 9
-- PUSH Rdst 01111 xxx 1 9
-- POP Rdst 10000 xxx 1 9
-- LDM Rdst, Imm(15 bit) 10001 xxx ?? 1 9
-- LDD Rsrc, Rdst 10010 xxx xxx 1 12
-- STD Rsrc, Rdst 10011 xxx xxx 1 123
-- CALL Rdst 11000 xxx 1 9
-- RET 11001 - 1 6
-- RTI 11010 - 1 6
-- Reset 11011 - 1 6
-- Interrupt 11100 - 1 6


end architecture a_excute;

