vsim work.wb
# vsim work.wb 
# Start time: 14:33:35 on May 01,2019
# Loading std.standard
# Loading std.textio(body)
# Loading ieee.std_logic_1164(body)
# Loading work.wb(dataflow)
# Loading work.mux2x1(archmux2x1)
add wave -position end  sim:/wb/MemToReg1
add wave -position end  sim:/wb/MemToReg2
add wave -position end  sim:/wb/Read1Data
add wave -position end  sim:/wb/Immediate
add wave -position end  sim:/wb/MemToReg2
add wave -position end  sim:/wb/LoadData
add wave -position end  sim:/wb/Write1Data
add wave -position end  sim:/wb/Reg1Write
add wave -position end  sim:/wb/Write2Data
add wave -position end  sim:/wb/Reg1Write
add wave -position end  sim:/wb/Reg2Write
add wave -position end  sim:/wb/Write1Add
add wave -position end  sim:/wb/Write2Add
force -freeze sim:/wb/MemToReg1 1 0
force -freeze sim:/wb/Read1Data 16'h1111 0
force -freeze sim:/wb/Immediate 15'h100000000000000 0
force -freeze sim:/wb/MemToReg2 1 0
force -freeze sim:/wb/LoadData 16'h0001 0
run
run
force -freeze sim:/wb/Immediate 15'h4000 0
run
# Error: invalid command name "::.main_pane.dataflow.interior.cs.body.pw.df.c"
force -freeze sim:/wb/MemToReg1 0 0
run
# Error: invalid command name "::.main_pane.dataflow.interior.cs.body.pw.df.c"
force -freeze sim:/wb/MemToReg2 0 0
run
force -freeze sim:/wb/LoadData 16'h0003 0
run
force -freeze sim:/wb/MemToReg2 1 0
run

