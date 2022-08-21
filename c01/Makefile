all:*.asm
	nasm -f bin sum.asm -o sum.bin
	nasm -f bin factorial.asm -o factorial.bin
	rm *.vhd
	VBoxManage convertfromraw sum.bin sum.vhd --format VHD
	VBoxManage convertfromraw factorial.bin factorial.vhd --format VHD
	rm *.bin
