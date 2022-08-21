all:*.asm
	nasm -f bin mbr.asm -o mbr.bin
	nasm -f bin core.asm -o core.bin
	nasm -f bin sum.asm -o sum.bin
	nasm -f bin factorial.asm -o factorial.bin
	dd if=/dev/zero of=sum.img count=10000
	dd if=mbr.bin of=sum.img conv=notrunc
	dd if=core.bin of=sum.img seek=1 conv=notrunc
	dd if=diskdata.txt of=sum.img seek=100 conv=notrunc
	cp sum.img factorial.img
	dd if=sum.bin of=sum.img seek=50 conv=notrunc
	dd if=factorial.bin of=factorial.img seek=50 conv=notrunc
	rm *.bin
	rm *.vhd
	VBoxManage convertfromraw sum.img sum.vhd --format VHD
	VBoxManage convertfromraw factorial.img factorial.vhd --format VHD
	rm *.img
