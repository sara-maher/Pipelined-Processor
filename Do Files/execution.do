vsim -gui work.excute(a_excute)
add wave -position insertpoint  \
sim:/excute/AluOp_a \
sim:/excute/AluOp_b \
sim:/excute/Alu_out \
sim:/excute/JmpAddress \
sim:/excute/buffer_in \
sim:/excute/buffer_out \
sim:/excute/c \
sim:/excute/c_mem \
sim:/excute/clk \
sim:/excute/enable \
sim:/excute/ex_mem_reg_dst \
sim:/excute/ex_mem_reg_val \
sim:/excute/ex_mem_reg_write_1 \
sim:/excute/frwd_a \
sim:/excute/frwd_b \
sim:/excute/id_ex_dst_val \
sim:/excute/id_ex_reg_dst \
sim:/excute/id_ex_reg_src \
sim:/excute/id_ex_src_val \
sim:/excute/immediate_val \
sim:/excute/load_address \
sim:/excute/load_value \
sim:/excute/mem_wb_reg_dst_alu \
sim:/excute/mem_wb_reg_val_alu \
sim:/excute/mem_wb_reg_write_1 \
sim:/excute/mem_wb_reg_dst_ld \
sim:/excute/mem_wb_reg_val_ld \
sim:/excute/mem_wb_reg_write_2 \
sim:/excute/n \
sim:/excute/n_mem \
sim:/excute/neg \
sim:/excute/opcode_alu \
sim:/excute/opcode_load \
sim:/excute/pcsrc \
sim:/excute/port_wire \
sim:/excute/rst \
sim:/excute/z \
sim:/excute/z_mem
force -freeze sim:/excute/clk 1 0, 0 {50 ps} -r 100
force -freeze sim:/excute/enable 0 0
force -freeze sim:/excute/ex_mem_reg_dst 2 0
force -freeze sim:/excute/ex_mem_reg_val 1111 0
force -freeze sim:/excute/ex_mem_reg_write_1 1 0
force -freeze sim:/excute/id_ex_dst_val 0001 0
force -freeze sim:/excute/id_ex_reg_dst 1 0
force -freeze sim:/excute/id_ex_reg_src 0 0
force -freeze sim:/excute/id_ex_src_val 0000 0
force -freeze sim:/excute/immediate_val 5555 0
force -freeze sim:/excute/load_address 0 0
force -freeze sim:/excute/load_value 0000 0
force -freeze sim:/excute/load_address 7 0
force -freeze sim:/excute/mem_wb_reg_dst_alu 3 0
force -freeze sim:/excute/mem_wb_reg_val_alu 3333 0
force -freeze sim:/excute/mem_wb_reg_write_1 0 0
force -freeze sim:/excute/opcode_alu 09 0
force -freeze sim:/excute/opcode_load 0F 0
force -freeze sim:/excute/rst 1 0
run
force -freeze sim:/excute/rst 0 0
run
force -freeze sim:/excute/opcode_load 11 0
run


