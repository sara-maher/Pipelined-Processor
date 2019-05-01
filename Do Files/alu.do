vsim -gui work.alu(a_alu)
add wave -position insertpoint  \
sim:/alu/a \
sim:/alu/aluop \
sim:/alu/b \
sim:/alu/c \
sim:/alu/f \
sim:/alu/n \
sim:/alu/neg \
sim:/alu/temp \
sim:/alu/z
force -freeze sim:/alu/a 0005 0
force -freeze sim:/alu/b 0005 0
force -freeze sim:/alu/aluop 0 0
run
force -freeze sim:/alu/aluop 1 0
run
force -freeze sim:/alu/aluop 2 0
run
force -freeze sim:/alu/aluop 3 0
run
force -freeze sim:/alu/aluop 4 0
run
force -freeze sim:/alu/aluop 5 0
run
force -freeze sim:/alu/aluop 6 0
run
force -freeze sim:/alu/aluop 7 0
run
force -freeze sim:/alu/aluop 8 0
run
force -freeze sim:/alu/aluop 9 0
run
force -freeze sim:/alu/aluop A 0
run
force -freeze sim:/alu/aluop B 0
run
force -freeze sim:/alu/aluop C 0
run
force -freeze sim:/alu/aluop D 0
run
force -freeze sim:/alu/aluop E 0
run
force -freeze sim:/alu/aluop F 0
run
force -freeze sim:/alu/aluop 10 0
run
force -freeze sim:/alu/aluop 11 0
run
force -freeze sim:/alu/aluop 12 0
run
force -freeze sim:/alu/aluop 13 0
run
force -freeze sim:/alu/aluop 14 0
run
force -freeze sim:/alu/aluop 15 0
run
force -freeze sim:/alu/aluop 16 0
run
force -freeze sim:/alu/aluop 17 0
run
force -freeze sim:/alu/aluop 18 0
run
force -freeze sim:/alu/aluop 19 0
run
force -freeze sim:/alu/aluop 1A 0
run
force -freeze sim:/alu/aluop 1B 0
run
force -freeze sim:/alu/aluop 1C 0
run
force -freeze sim:/alu/aluop 1D 0
run
force -freeze sim:/alu/a FFFF 0
force -freeze sim:/alu/b 0001 0
force -freeze sim:/alu/aluop 9 0
run