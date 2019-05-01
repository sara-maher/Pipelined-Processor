sim -gui work.ff_register(a_ff_register)
add wave -position insertpoint  \
sim:/ff_register/a \
sim:/ff_register/b \
sim:/ff_register/clk \
sim:/ff_register/enable \
sim:/ff_register/rst
force -freeze sim:/ff_register/clk 1 0, 0 {50 ps} -r 100
force -freeze sim:/ff_register/rst 1 0
force -freeze sim:/ff_register/a 0005 0
run
force -freeze sim:/ff_register/rst 0 0
run
force -freeze sim:/ff_register/enable 1 0
run
force -freeze sim:/ff_register/enable 0 0
force -freeze sim:/ff_register/a 0007 0
run
force -freeze sim:/ff_register/enable 1 0
run
force -freeze sim:/ff_register/rst 1 0
run
