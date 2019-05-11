vsim work.main
mem load -i /home/ayman/Desktop/Archproj/one.mem -format mti /main/FechComp/MEMORY/ram
mem load -filltype value -filldata 0 -fillradix hexadecimal -skip 0 /main/DataMEM/ram
add wave -position insertpoint  \
sim:/main/clk \
sim:/main/cntOutput \
sim:/main/IR \
sim:/main/PC \
sim:/main/reg0output \
sim:/main/reg1output \
sim:/main/reg2output \
sim:/main/reg3output \
sim:/main/reg4output \
sim:/main/reg5output \
sim:/main/reg6output \
sim:/main/reg7outpu \
sim:/main/inputPort \
sim:/main/interruptSig \
sim:/main/rst \
sim:/main/outputPort \
sim:/main/ALuC \
sim:/main/AluFlags \
sim:/main/ALUn \
sim:/main/AluOutput \
sim:/main/ALUz \
sim:/main/DataAddress \
sim:/main/DataMemOutput \
sim:/main/DecExdst1Address \
sim:/main/DecExdst1Data \
sim:/main/DecExdst2Address \
sim:/main/DecExdst2Data \
sim:/main/DECEXimmediate1Output \
sim:/main/DECEXimmediate2Output \
sim:/main/DecExMemAddressOutput \
sim:/main/DecExMemDataOutput \
sim:/main/DECEXmemReadOutput \
sim:/main/DecExMemtoRegSel \
sim:/main/DECEXmemWriteOutput \
sim:/main/DECEXopCode1Output \
sim:/main/DECEXopCode2Output \
sim:/main/DECEXPCOutput \
sim:/main/DecExsrc1Address \
sim:/main/DecExsrc1Data \
sim:/main/DecExsrc2Address \
sim:/main/DecExsrc2Data \
sim:/main/DECEXwriteAdd1Output \
sim:/main/DECEXwriteAdd2Output \
sim:/main/DECEXwriteEn1Output \
sim:/main/DECEXwriteEn2Output \
sim:/main/dst1Address \
sim:/main/dst1Data \
sim:/main/dst2Address \
sim:/main/dst2Data \
sim:/main/ExDecMemtoRegSel \
sim:/main/ExMemAluOutput \
sim:/main/ExMemdst1Address \
sim:/main/ExMemdst1Data \
sim:/main/ExMemdst2Address \
sim:/main/ExMemdst2Data \
sim:/main/ExMemimmediate1 \
sim:/main/ExMemimmediate2 \
sim:/main/ExMemMemRead \
sim:/main/ExMemMemWrite \
sim:/main/ExMemsrc1Address \
sim:/main/ExMemsrc1Data \
sim:/main/ExMemsrc2Address \
sim:/main/ExMemsrc2Data \
sim:/main/ExMemwriteEn1 \
sim:/main/ExMemwriteEn2 \
sim:/main/EXPCSrc \
sim:/main/FlagRegOutput \
sim:/main/IfDecIRout \
sim:/main/IfDecPcout \
sim:/main/immediate1 \
sim:/main/immediate2 \
sim:/main/Jump_add \
sim:/main/memRead \
sim:/main/MemtoRegSel \
sim:/main/MemWbAluOutput \
sim:/main/MemWbDataMemOutput \
sim:/main/MemWbdst1Address \
sim:/main/MemWbdst1Data \
sim:/main/MemWbdst2Address \
sim:/main/MemWbdst2Data \
sim:/main/MemWbimmediate2 \
sim:/main/MemWbMemtoRegSel \
sim:/main/MemWbwriteEn1 \
sim:/main/MemWbwriteEn2 \
sim:/main/memWrite \
sim:/main/opCode1 \
sim:/main/opCode2 \
sim:/main/PCSrc \
sim:/main/src1Address \
sim:/main/src1Data \
sim:/main/src2Address \
sim:/main/src2Data \
sim:/main/stall \
sim:/main/tempSig \
sim:/main/tempSig2 \
sim:/main/Write1Data \
sim:/main/Write2Data \
sim:/main/writeEn1 \
sim:/main/writeEn2
force -freeze sim:/main/clk 1 0, 0 {50 ps} -r 100
force -freeze sim:/main/inputPort A 0
force -freeze sim:/main/interruptSig 0 0
force -freeze sim:/main/rst 1 0
run
force -freeze sim:/main/rst 0 0
run
