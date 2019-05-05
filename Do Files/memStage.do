vsim -gui work.mem(archmem)
add wave -position insertpoint  \
sim:/mem/Address \
sim:/mem/AddressSig \
sim:/mem/Flags \
sim:/mem/MemRead \
sim:/mem/MemWrite \
sim:/mem/PC \
sim:/mem/ReadData \
sim:/mem/SP \
sim:/mem/Stall \
sim:/mem/WriteData \
sim:/mem/clk \
sim:/mem/count \
sim:/mem/data_in \
sim:/mem/opcode \
sim:/mem/rst
force -freeze sim:/mem/PC 00000010 0
force -freeze sim:/mem/Address 00001000 0
force -freeze sim:/mem/Flags 111 0
force -freeze sim:/mem/MemRead 0 0
force -freeze sim:/mem/MemWrite 1 0
force -freeze sim:/mem/WriteData 1111 0
force -freeze sim:/mem/clk 1 0, 0 {50 ps} -r 100
force -freeze sim:/mem/opcode 1C 0
force -freeze sim:/mem/Stall 1 0
run
force -freeze sim:/mem/Stall 0 0
run
force -freeze sim:/mem/Stall 1 0
force -freeze sim:/mem/SP 00000005 0
run
force -freeze sim:/mem/SP 00000004 0
run
force -freeze sim:/mem/SP 00000003 0
run

