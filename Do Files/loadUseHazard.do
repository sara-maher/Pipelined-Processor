vsim work.loadusehazard
# vsim work.loadusehazard 
# Start time: 03:42:32 on May 07,2019
# Loading std.standard
# Loading std.textio(body)
# Loading ieee.std_logic_1164(body)
# Loading work.loadusehazard(dataflow)
add wave -position end  sim:/loadusehazard/clk1
add wave -position end  sim:/loadusehazard/DEMemRead1
add wave -position end  sim:/loadusehazard/DERegister1dist
add wave -position end  sim:/loadusehazard/FDRegister2dest
add wave -position end  sim:/loadusehazard/FDRegister2src
add wave -position end  sim:/loadusehazard/stall1
force -freeze sim:/loadusehazard/clk1 1 0, 0 {50 ps} -r 100
force -freeze sim:/loadusehazard/DEMemRead1 1 0
force -freeze sim:/loadusehazard/DERegister1dist 3'h3 0
force -freeze sim:/loadusehazard/FDRegister2dest 3'h1 0
force -freeze sim:/loadusehazard/FDRegister2src 3'h3 0
run
force -freeze sim:/loadusehazard/FDRegister2dest 3'h3 0
run
force -freeze sim:/loadusehazard/DERegister1dist 3'h1 0
run
force -freeze sim:/loadusehazard/FDRegister2dest 3'h1 0
run
force -freeze sim:/loadusehazard/DEMemRead1 0 0
run

