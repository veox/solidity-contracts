SOURCES := 1-Empty.solidity 2-Fallback.solidity 3-FallbackReturn.solidity 4-FallbackReturnFalse.solidity 5-FallbackThrow.solidity

.PHONY: asm bin clean

asm: $(SOURCES:.solidity=.asm)

bin: $(SOURCES:.solidity=.bin) $(SOURCES:.solidity=.bin+opt)

clean:
	rm -f *.asm *.bin *.bin-runtime *.bin+opt *.disasm

disasm: $(SOURCES:.solidity=.disasm)

%.asm: %.solidity
	solc --asm $< > $@

%.bin: %.solidity
	solc --bin $< > $@

%.bin+opt: %.solidity
	solc --bin --optimize $< > $@

%.disasm: %.solidity
	solc --bin-runtime -o `pwd` $<
	cat `ls *.bin-runtime` | evmdis > $@
	rm *.bin-runtime
