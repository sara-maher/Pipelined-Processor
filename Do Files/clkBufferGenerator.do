vsim work.clkbuffergenerator
# vsim work.clkbuffergenerator 
# Start time: 04:28:24 on May 07,2019
# Loading std.standard
# Loading std.textio(body)
# Loading ieee.std_logic_1164(body)
# Loading work.clkbuffergenerator(dataflow)
add wave -position end  sim:/clkbuffergenerator/clk
add wave -position end  sim:/clkbuffergenerator/stall1
add wave -position end  sim:/clkbuffergenerator/stall2
add wave -position end  sim:/clkbuffergenerator/clkDE
add wave -position end  sim:/clkbuffergenerator/clkEM
add wave -position end  sim:/clkbuffergenerator/clkFD
add wave -position end  sim:/clkbuffergenerator/clkMW
force -freeze sim:/clkbuffergenerator/clk 1 0, 0 {50 ps} -r 100
force -freeze sim:/clkbuffergenerator/stall1 1 0
force -freeze sim:/clkbuffergenerator/stall2 0 0
run
force -freeze sim:/clkbuffergenerator/stall2 1 0
force -freeze sim:/clkbuffergenerator/stall1 0 0
run
force -freeze sim:/clkbuffergenerator/stall1 1 0
run
force -freeze sim:/clkbuffergenerator/stall1 0 0
force -freeze sim:/clkbuffergenerator/stall2 0 0
run
run

