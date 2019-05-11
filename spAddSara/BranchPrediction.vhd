LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.numeric_std.all;

ENTITY BranchPrediction IS
	PORT(
		c,neg,z : IN std_logic;  --from excute/memory buffer
		opcodeAlu, opcodeLoad : IN  std_logic_vector(4 DOWNTO 0);
		flush  : out std_logic
		);

END Entity BranchPrediction;

ARCHITECTURE ArchBranchPrediction OF BranchPrediction IS

	BEGIN
		PROCESS (opcodeAlu,opcodeLoad,c,neg,z) IS
		variable f: std_logic;
			BEGIN
				IF (opcodeAlu = "10111" or opcodeLoad = "11000" or opcodeLoad = "11001" or opcodeLoad = "11010" or opcodeLoad = "11011" or opcodeLoad = "11100") THEN  --jmp, call, interrupt, ret, rti, reset
					f  := '1';
				ELSIF (opcodeAlu = "10110" and c = '1') THEN  --jc
					f :='1';
				ELSIF (opcodeAlu = "10100" and z = '1') THEN  --jz
					f :='1';
				ELSIF (opcodeAlu = "10101" and neg = '1') THEN  --jn
					f :='1';
				ELSE
					f:= '0';
				END IF;
				flush <= f;
		END PROCESS;
END ArchBranchPrediction;