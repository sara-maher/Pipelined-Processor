vsim -gui work.jmp_ctrl(a_jmp_ctrl)
add wave -position insertpoint  \
sim:/jmp_ctrl/c_old \
sim:/jmp_ctrl/n \
sim:/jmp_ctrl/n_old \
sim:/jmp_ctrl/opcode \
sim:/jmp_ctrl/pcsrc \
sim:/jmp_ctrl/z_old
#pc_src = 0
force -freeze sim:/jmp_ctrl/c_old 0 0
force -freeze sim:/jmp_ctrl/n_old 0 0
force -freeze sim:/jmp_ctrl/z_old 0 0
force -freeze sim:/jmp_ctrl/opcode 0000 0
run
force -freeze sim:/jmp_ctrl/c_old 1 0
force -freeze sim:/jmp_ctrl/n_old 1 0
force -freeze sim:/jmp_ctrl/z_old 1 0
force -freeze sim:/jmp_ctrl/opcode 0000 0
run
#pc_src = 1
force -freeze sim:/jmp_ctrl/opcode 10100 0
run
force -freeze sim:/jmp_ctrl/opcode 10101 0
run
force -freeze sim:/jmp_ctrl/opcode 10110 0
run
force -freeze sim:/jmp_ctrl/opcode 10111 0
run
force -freeze sim:/jmp_ctrl/opcode 11000 0
run
#pc_src = 2
force -freeze sim:/jmp_ctrl/opcode 11011 0
run
#pc_src = 3
force -freeze sim:/jmp_ctrl/opcode 11100 0
run