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


