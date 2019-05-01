vsim -gui work.frwd_unit(a_frwd_unit)
add wave -position insertpoint  \
sim:/frwd_unit/clk \
sim:/frwd_unit/ex_mem_reg_dst \
sim:/frwd_unit/ex_mem_reg_write_1 \
sim:/frwd_unit/frwd_a \
sim:/frwd_unit/frwd_b \
sim:/frwd_unit/id_ex_reg_dst \
sim:/frwd_unit/id_ex_reg_src \
sim:/frwd_unit/mem_raw_a \
sim:/frwd_unit/mem_raw_b \
sim:/frwd_unit/mem_wb_reg_dst \
sim:/frwd_unit/mem_wb_reg_write_1 \
sim:/frwd_unit/n \
sim:/frwd_unit/wb_raw_a \
sim:/frwd_unit/wb_raw_b

force -freeze sim:/frwd_unit/clk 1 0, 0 {50 ps} -r 100
# frwd_a = 00, frwd_b=00
force -freeze sim:/frwd_unit/ex_mem_reg_dst 000 0
force -freeze sim:/frwd_unit/ex_mem_reg_write_1 0 0
force -freeze sim:/frwd_unit/id_ex_reg_dst 001 0
force -freeze sim:/frwd_unit/id_ex_reg_src 010 0
force -freeze sim:/frwd_unit/mem_wb_reg_dst 111 0
force -freeze sim:/frwd_unit/mem_wb_reg_write_1 0 0
run
# frwd_a = 00, frwd_b=00
force -freeze sim:/frwd_unit/ex_mem_reg_dst 000 0
force -freeze sim:/frwd_unit/ex_mem_reg_write_1 1 0
force -freeze sim:/frwd_unit/id_ex_reg_dst 001 0
force -freeze sim:/frwd_unit/id_ex_reg_src 010 0
force -freeze sim:/frwd_unit/mem_wb_reg_dst 111 0
force -freeze sim:/frwd_unit/mem_wb_reg_write_1 1 0
run
# frwd_a = 01, frwd_b=00
force -freeze sim:/frwd_unit/ex_mem_reg_dst 000 0
force -freeze sim:/frwd_unit/ex_mem_reg_write_1 1 0
force -freeze sim:/frwd_unit/id_ex_reg_dst 001 0
force -freeze sim:/frwd_unit/id_ex_reg_src 000 0
force -freeze sim:/frwd_unit/mem_wb_reg_dst 111 0
force -freeze sim:/frwd_unit/mem_wb_reg_write_1 0 0
run
# frwd_a = 10, frwd_b=00
force -freeze sim:/frwd_unit/ex_mem_reg_dst 000 0
force -freeze sim:/frwd_unit/ex_mem_reg_write_1 0 0
force -freeze sim:/frwd_unit/id_ex_reg_dst 001 0
force -freeze sim:/frwd_unit/id_ex_reg_src 111 0
force -freeze sim:/frwd_unit/mem_wb_reg_dst 111 0
force -freeze sim:/frwd_unit/mem_wb_reg_write_1 1 0
run
# frwd_a = 00, frwd_b=01
force -freeze sim:/frwd_unit/ex_mem_reg_dst 000 0
force -freeze sim:/frwd_unit/ex_mem_reg_write_1 1 0
force -freeze sim:/frwd_unit/id_ex_reg_dst 000 0
force -freeze sim:/frwd_unit/id_ex_reg_src 010 0
force -freeze sim:/frwd_unit/mem_wb_reg_dst 111 0
force -freeze sim:/frwd_unit/mem_wb_reg_write_1 0 0
run
# frwd_a = 00, frwd_b=10
force -freeze sim:/frwd_unit/ex_mem_reg_dst 000 0
force -freeze sim:/frwd_unit/ex_mem_reg_write_1 0 0
force -freeze sim:/frwd_unit/id_ex_reg_dst 111 0
force -freeze sim:/frwd_unit/id_ex_reg_src 010 0
force -freeze sim:/frwd_unit/mem_wb_reg_dst 111 0
force -freeze sim:/frwd_unit/mem_wb_reg_write_1 1 0
run
# frwd_a = 01, frwd_b=01
force -freeze sim:/frwd_unit/ex_mem_reg_dst 000 0
force -freeze sim:/frwd_unit/ex_mem_reg_write_1 1 0
force -freeze sim:/frwd_unit/id_ex_reg_dst 000 0
force -freeze sim:/frwd_unit/id_ex_reg_src 000 0
force -freeze sim:/frwd_unit/mem_wb_reg_dst 111 0
force -freeze sim:/frwd_unit/mem_wb_reg_write_1 1 0
run
# frwd_a = 01, frwd_b=10
force -freeze sim:/frwd_unit/ex_mem_reg_dst 000 0
force -freeze sim:/frwd_unit/ex_mem_reg_write_1 1 0
force -freeze sim:/frwd_unit/id_ex_reg_dst 111 0
force -freeze sim:/frwd_unit/id_ex_reg_src 000 0
force -freeze sim:/frwd_unit/mem_wb_reg_dst 111 0
force -freeze sim:/frwd_unit/mem_wb_reg_write_1 1 0
run
# frwd_a = 10, frwd_b=01
force -freeze sim:/frwd_unit/ex_mem_reg_dst 000 0
force -freeze sim:/frwd_unit/ex_mem_reg_write_1 1 0
force -freeze sim:/frwd_unit/id_ex_reg_dst 000 0
force -freeze sim:/frwd_unit/id_ex_reg_src 111 0
force -freeze sim:/frwd_unit/mem_wb_reg_dst 111 0
force -freeze sim:/frwd_unit/mem_wb_reg_write_1 1 0
run
# frwd_a = 10, frwd_b=10
force -freeze sim:/frwd_unit/ex_mem_reg_dst 000 0
force -freeze sim:/frwd_unit/ex_mem_reg_write_1 1 0
force -freeze sim:/frwd_unit/id_ex_reg_dst 111 0
force -freeze sim:/frwd_unit/id_ex_reg_src 111 0
force -freeze sim:/frwd_unit/mem_wb_reg_dst 111 0
force -freeze sim:/frwd_unit/mem_wb_reg_write_1 1 0
run
run