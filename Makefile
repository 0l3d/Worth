build:
	mkdir -p build
	../easy/easy -c src/boot.asm -a "nokernel" -o build/boot.bin
	../easy/easy -c src/kernel.asm -a "nokernel" -o build/kernel.bin

start:
	../easy/easy -i build/boot.bin -a "build/kernel.bin"

clean:
	rm -rf build


