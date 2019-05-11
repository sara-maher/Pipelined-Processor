vsim -gui work.fetch
# vsim -gui work.fetch 
# Start time: 14:02:36 on May 03,2019
# Loading std.standard
# Loading std.textio(body)
# Loading ieee.std_logic_1164(body)
# Loading ieee.numeric_std(body)
# Loading work.fetch(archfetch)
# Loading work.nreg(archnregister)
# Loading work.mux4x1(archmux4x1)
# Loading work.mux2x1(archmux2x1)
# Loading work.ram(archram)
# Loading work.fulladder64(archfulladder)
# Loading work.adder(adder_a)
# Loading work.issueunit(archissueunit)
# vsim -gui work.fetch 
# Start time: 13:49:30 on May 03,2019
# Loading std.standard
# Loading std.textio(body)
# Loading ieee.std_logic_1164(body)
# Loading ieee.numeric_std(body)
# Loading work.fetch(archfetch)
# Loading work.nreg(archnregister)
# Loading work.mux4x1(archmux4x1)
# Loading work.mux2x1(archmux2x1)
# Loading work.ram(archram)
# Loading work.fulladder64(archfulladder)
# Loading work.adder(adder_a)
# Loading work.issueunit(archissueunit)
add wave -position insertpoint  \
sim:/fetch/clk \
sim:/fetch/rst \
sim:/fetch/Pcsrc \
sim:/fetch/IR \
sim:/fetch/Jump_add \
sim:/fetch/stall \
sim:/fetch/PC \
sim:/fetch/not_stall \
sim:/fetch/pcnew \
sim:/fetch/reset_add \
sim:/fetch/interrupt_add \
sim:/fetch/zero_in \
sim:/fetch/Ins1 \
sim:/fetch/Ins2 \
sim:/fetch/issueunit_adder \
sim:/fetch/pc_out \
sim:/fetch/pc_in \
sim:/fetch/instruction1 \
sim:/fetch/instruction2 \
sim:/fetch/issueunit_instruction \
sim:/fetch/cout \
sim:/fetch/not_rst \
sim:/fetch/issue_en
# ** Warning: (vsim-WLF-5000) WLF file currently in use: vsim.wlf
#           File in use by: Esraa  Hostname: DESKTOP-Q9CDREV  ProcessID: 11300
#           Attempting to use alternate WLF file "./wlft7vb30e".
# ** Warning: (vsim-WLF-5001) Could not open WLF file: vsim.wlf
#           Using alternate file: ./wlft7vb30e
force -freeze sim:/fetch/clk 1 0, 0 {50 ps} -r 100
force -freeze sim:/fetch/rst 1 0
force -freeze sim:/fetch/Pcsrc 2 0
force -freeze sim:/fetch/Jump_add 0000A222 0
force -freeze sim:/fetch/stall 0 0
mem load -filltype rand -filldata 0 -fillradix hexadecimal -skip 0 /fetch/MEMORY/ram
run
# ** Warning: (vsim-WLF-5000) WLF file currently in use: vsim.wlf
#           File in use by: Esraa  Hostname: DESKTOP-Q9CDREV  ProcessID: 11300
#           Attempting to use alternate WLF file "./wlftaa0dcf".
# ** Warning: (vsim-WLF-5001) Could not open WLF file: vsim.wlf
#           Using alternate file: ./wlftaa0dcf
# ** Warning: NUMERIC_STD.TO_INTEGER: metavalue detected, returning 0
#    Time: 0 ps  Iteration: 0  Instance: /fetch/MEMORY
# ** Warning: NUMERIC_STD.TO_INTEGER: metavalue detected, returning 0
#    Time: 0 ps  Iteration: 0  Instance: /fetch/MEMORY
force -freeze sim:/fetch/rst 0 0
run
force -freeze sim:/fetch/Pcsrc 0 0
run
run
run
run
run
run
run
run
run
run
run
run
run
run
run
run
run
run
run
run
run
run
run
run
run
run
run
run
run
run
run
run
run
run
run
run
run
run
run
run
run
run
run
run
run
force -freeze sim:/fetch/Pcsrc 1 0
run
force -freeze sim:/fetch/Pcsrc 0 0
run
run
run
run
run
run
run