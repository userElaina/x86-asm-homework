    mov ax, 0xb800
    mov es, ax

    mov eax, 1
    mov ecx, 10
_mul:
    mul ecx
    loop _mul

    xor cx, cx
    mov ss, cx
    mov sp, cx

    mov ebx, 10
_push:
    inc cx
    xor edx, edx
    div ebx
    or dl, 0x30
    push edx
    cmp eax, 0
    jne _push

    xor di, di
_print:
    pop edx
    mov [es:di], dl
    inc di
    mov byte [es:di], 0x07
    inc di
    loop _print

    mov byte [es:di], 0x2e
    inc di
    mov byte [es:di], 0x07
    inc di

    jmp near $

times 510-($-$$) db 0
    db 0x55, 0xaa