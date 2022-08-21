all:*.asm
	nasm -f bin mbr.asm -o mbr.bin
	nasm -f bin c02.asm -o c02.bin
	dd if=/dev/zero of=mbr.img count=10000
	dd if=mbr.bin of=mbr.img conv=notrunc
	dd if=c02.bin of=mbr.img seek=100 conv=notrunc
	rm *.bin
	rm *.vhd
	VBoxManage convertfromraw mbr.img c02.vhd --format VHD
	rm *.img
