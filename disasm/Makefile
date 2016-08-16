SOURCES := 1-Empty.sol 2-Fallback.sol 3-FallbackReturn.sol 4-FallbackReturnFalse.sol

.PHONY: asm bin clean

asm: $(SOURCES:.sol=.asm)

bin: $(SOURCES:.sol=.bin) $(SOURCES:.sol=.bin+opt)

clean:
	rm -f *.asm *.bin *.bin-runtime *.bin+opt *.disasm

disasm: $(SOURCES:.sol=.disasm)

%.asm: %.sol
	solc --asm $< > $@

%.bin: %.sol
	solc --bin $< > $@

%.bin+opt: %.sol
	solc --bin --optimize $< > $@

%.disasm: %.sol
	solc --bin-runtime -o `pwd` $<
	cat `ls *.bin-runtime` | evmdis > $@
	rm *.bin-runtime
