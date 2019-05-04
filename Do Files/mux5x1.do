vsim -gui work.mux5x1(a_mux5x1)
add wave -position insertpoint  \
sim:/mux5x1/a \
sim:/mux5x1/b \
sim:/mux5x1/c \
sim:/mux5x1/d \
sim:/mux5x1/e \
sim:/mux5x1/f \
sim:/mux5x1/sel
force -freeze sim:/mux5x1/a 0000000000000000 0
force -freeze sim:/mux5x1/b 0000000000000001 0
force -freeze sim:/mux5x1/c 0000000000000010 0
force -freeze sim:/mux5x1/d 0000000000000011 0
force -freeze sim:/mux5x1/e 0000100 0
force -freeze sim:/mux5x1/sel 000 0
run
force -freeze sim:/mux5x1/sel 001 0
run
force -freeze sim:/mux5x1/sel 010 0
run
force -freeze sim:/mux5x1/sel 011 0
run
force -freeze sim:/mux5x1/sel 100 0
run