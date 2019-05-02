vsim -gui work.ctrl_unit(a_ctrl_unit)
add wave -position insertpoint  \
sim:/ctrl_unit/ir \
sim:/ctrl_unit/memread \
sim:/ctrl_unit/memwrite \
sim:/ctrl_unit/n \
sim:/ctrl_unit/reg1_write \
sim:/ctrl_unit/reg2_write
force -freeze sim:/ctrl_unit/ir 00000000000000001001100000000000 0
run
force -freeze sim:/ctrl_unit/ir 00000100000000001001110000000000 0
run
force -freeze sim:/ctrl_unit/ir 00001000000000001011110000000000 0
run
force -freeze sim:/ctrl_unit/ir 00001100000000001100000000000000 0
run
force -freeze sim:/ctrl_unit/ir 00010000000000001100010000000000 0
run
force -freeze sim:/ctrl_unit/ir 00010100000000001100100000000000 0
run
force -freeze sim:/ctrl_unit/ir 00100000000000001100110000000000 0
run
force -freeze sim:/ctrl_unit/ir 00100100000000001110000000000000 0
run
force -freeze sim:/ctrl_unit/ir 00101000000000001110010000000000 0
run
force -freeze sim:/ctrl_unit/ir 00101100000000001110100000000000 0
run
force -freeze sim:/ctrl_unit/ir 00110000000000001110110000000000 0
run
force -freeze sim:/ctrl_unit/ir 00110100000000001111000000000000 0
run
force -freeze sim:/ctrl_unit/ir 00111000000000001111000000000000 0
run
force -freeze sim:/ctrl_unit/ir 01010000000000001111000000000000 0
run
force -freeze sim:/ctrl_unit/ir 01010100000000001111000000000000 0
run
force -freeze sim:/ctrl_unit/ir 01011000000000001111000000000000 0
run
force -freeze sim:/ctrl_unit/ir 01011100000000001111000000000000 0
run