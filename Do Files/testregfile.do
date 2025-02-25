vsim work.registerfile
add wave -position insertpoint  \
sim:/registerfile/clk \
sim:/registerfile/rst \
sim:/registerfile/readAdd11 \
sim:/registerfile/readAdd12 \
sim:/registerfile/readAdd21 \
sim:/registerfile/readAdd22 \
sim:/registerfile/writeAdd1 \
sim:/registerfile/writeAdd2 \
sim:/registerfile/writeData1 \
sim:/registerfile/writeData2 \
sim:/registerfile/writeEn1 \
sim:/registerfile/writeEn2 \
sim:/registerfile/readData11 \
sim:/registerfile/readData12 \
sim:/registerfile/readData21 \
sim:/registerfile/readData22 \
sim:/registerfile/decoderOutput1 \
sim:/registerfile/decoderOutput2 \
sim:/registerfile/enable0 \
sim:/registerfile/enable1 \
sim:/registerfile/enable2 \
sim:/registerfile/enable3 \
sim:/registerfile/enable4 \
sim:/registerfile/enable5 \
sim:/registerfile/enable6 \
sim:/registerfile/enable7 \
sim:/registerfile/reg0output \
sim:/registerfile/reg1output \
sim:/registerfile/reg2output \
sim:/registerfile/reg3output \
sim:/registerfile/reg4output \
sim:/registerfile/reg5output \
sim:/registerfile/reg6output \
sim:/registerfile/reg7output
force -freeze sim:/registerfile/clk 1 0, 0 {50 ps} -r 100
force -freeze sim:/registerfile/rst 1 0
run
run
run
force -freeze sim:/registerfile/rst 0 0
force -freeze sim:/registerfile/readAdd11 0 0
force -freeze sim:/registerfile/readAdd12 1 0
force -freeze sim:/registerfile/readAdd21 2 0
force -freeze sim:/registerfile/readAdd22 3 0

force -freeze sim:/registerfile/writeAdd1 1 0
force -freeze sim:/registerfile/writeAdd2 2 0
force -freeze sim:/registerfile/writeData1 A 0
force -freeze sim:/registerfile/writeData2 B 0
force -freeze sim:/registerfile/writeEn1 0 0
force -freeze sim:/registerfile/writeEn2 0 0
run
force -freeze sim:/registerfile/writeEn1 1 0
force -freeze sim:/registerfile/writeEn2 1 0
run

