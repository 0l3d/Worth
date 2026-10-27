build:
	mkdir -p build
	../easy/easy -c src/rom.asm -a "nohead"  -o build/rom.bin
	../easy/easy -c src/kernel.asm -o build/kernel.bin

debug:
	../easy/easy -i build/rom.bin -a "debug,build/kernel.bin"

run:
	../easy/easy -i build/rom.bin -a "build/kernel.bin"

clean:
	rm -rf build


