SOURCES := 1-Empty.sol 2-Fallback.sol 3-FallbackReturn.sol 4-FallbackReturnFalse.sol

.PHONY: asm bin clean

asm: $(SOURCES:.sol=.asm)

bin: $(SOURCES:.sol=.bin) $(SOURCES:.sol=.bin+opt)

clean:
	rm -f *.bin *.bin+opt

%.asm: %.sol
	solc --asm $< > $@

%.bin: %.sol
	solc --bin $< > $@

%.bin+opt: %.sol
	solc --bin --optimize $< > $@
