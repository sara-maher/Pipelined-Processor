vsim -gui work.mux4x1(a_mux4x1)
add wave -position insertpoint  \
sim:/mux4x1/a \
sim:/mux4x1/b \
sim:/mux4x1/c \
sim:/mux4x1/d \
sim:/mux4x1/f \
sim:/mux4x1/sel
force -freeze sim:/mux4x1/a 0000000000000000 0
force -freeze sim:/mux4x1/b 0000000000000001 0
force -freeze sim:/mux4x1/c 0000000000000010 0
force -freeze sim:/mux4x1/d 0000000000000011 0
force -freeze sim:/mux4x1/sel 00 0
run
force -freeze sim:/mux4x1/sel 01 0
run
force -freeze sim:/mux4x1/sel 10 0
run
force -freeze sim:/mux4x1/sel 11 0
run