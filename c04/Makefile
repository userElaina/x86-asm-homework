all:*.asm
	nasm -f bin mbr.asm -o mbr.bin
	nasm -f bin core.asm -o core.bin
	nasm -f bin suma.asm -o suma.bin
	nasm -f bin sumb.asm -o sumb.bin
	nasm -f bin factoriala.asm -o factoriala.bin
	nasm -f bin factorialb.asm -o factorialb.bin
	dd if=/dev/zero of=sum.img count=10000
	dd if=mbr.bin of=sum.img conv=notrunc
	dd if=core.bin of=sum.img seek=1 conv=notrunc
	cp sum.img factorial.img
	dd if=suma.bin of=sum.img seek=50 conv=notrunc
	dd if=sumb.bin of=sum.img seek=100 conv=notrunc
	dd if=factoriala.bin of=factorial.img seek=50 conv=notrunc
	dd if=factorialb.bin of=factorial.img seek=100 conv=notrunc
	rm *.bin
	rm *.vhd
	VBoxManage convertfromraw sum.img sum.vhd --format VHD
	VBoxManage convertfromraw factorial.img factorial.vhd --format VHD
	rm *.img
