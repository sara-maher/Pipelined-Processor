vsim work.stall
# vsim work.stall 
# Start time: 14:05:47 on May 07,2019
# Loading std.standard
# Loading std.textio(body)
# Loading ieee.std_logic_1164(body)
# Loading work.stall(dataflow)
add wave -position end  sim:/stall/clk1
add wave -position end  sim:/stall/OpCode
add wave -position end  sim:/stall/stall2
force -freeze sim:/stall/clk1 1 0, 0 {50 ps} -r 100
force -freeze sim:/stall/OpCode 7'h2F 0
run
run
force -freeze sim:/stall/OpCode 7'h00 0
run
run
force -freeze sim:/stall/OpCode 7'B0011010 0
run
run
force -freeze sim:/stall/OpCode 7'h00 0
run
run
force -freeze sim:/stall/OpCode 7'H2F 0
run
force -freeze sim:/stall/OpCode 7'h00 0
run

