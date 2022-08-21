    program_length  dd program_end
    entry_point     dd start
    salt_position   dd salt_begin
    salt_items      dd (salt_end-salt_begin)/256

salt_begin:

    PrintString         db '@PrintString'
    times 256-($-PrintString) db 0
    TerminateProgram    db '@TerminateProgram'
    times 256-($-TerminateProgram) db 0
    ReadDiskData        db '@ReadDiskData'
    times 256-($-ReadDiskData) db 0
    PrintDwordAsHex     db '@PrintDwordAsHexString'
    times 256-($-PrintDwordAsHex) db 0

salt_end:

    message_0   db '  User task A->1+2+3+...+1000=',0
    message_1   db 0,0,0,0,0,0,0,0,0,0,0,0,0
    message_2   db 0x0d,0x0a,0

[bits 32]

start:

    mov ebx,message_0
    call far [PrintString]
    xor eax,eax
    mov ecx,1000
@f:
    add eax,ecx
    loop @f

    mov ebx,10
    xor ecx,ecx
@d:
    xor edx,edx
    div ebx
    add edx,0x30
    inc ecx
    push edx
    cmp eax,0
    jne @d

    xor di,di

@a:
    pop edx
    mov [message_1+di],dl
    inc di
    loop @a

    mov ebx,message_1
    call far [fs:PrintString]
    mov ebx,message_2
    call far [fs:PrintString]

    jmp start

    call far [TerminateProgram]

program_end: