SECTION header vstart=0
    program_length  dd program_end
    head_len        dd header_end
    stack_seg       dd 0
    stack_len       dd 1
    prgentry        dd start
    code_seg        dd section.code.start
    code_len        dd code_end
    data_seg        dd section.data.start
    data_len        dd data_end
    salt_items      dd (header_end-salt)/256

salt:
    PrintString         db '@PrintString'
    times 256-($-PrintString) db 0
    TerminateProgram    db '@TerminateProgram'
    times 256-($-TerminateProgram) db 0
    ReadDiskData        db '@ReadDiskData'
    times 256-($-ReadDiskData) db 0

header_end:

SECTION data vstart=0

    message_0   db 0x0d,0x0a
                db '[USER TASK]: Hi! nice to meet you,'
                db 'I am run at CPL=',0
    message_1   db 0,' and 1+2+3+...+1000='
    message_2   db 0,0,0,0,0,0,0,0,0,0,0,0,0
    message_3   db '.Now,I must exit...',0x0d,0x0a,0

data_end:

    [bits 32]

SECTION code vstart=0
start:

    mov eax,ds
    mov fs,eax

    mov eax,[data_seg]
    mov ds,eax

    mov ebx,message_0
    call far [fs:PrintString]

    mov ax,cs
    and al,0000_0011B
    or al,0x0030
    mov [message_1],al

    mov ebx,message_1
    call far [fs:PrintString]

    mov eax,0
    mov ecx,1000
@f:
    add eax,ecx
    loop @f

    mov ebx,10
    mov ecx,0
@d:
    xor edx,edx
    div ebx
    add edx,0x30
    inc ecx
    push edx
    cmp eax,0
    jne @d

    mov di,0

@a:
    pop edx
    mov [message_2+di],dl
    inc di
    loop @a

    mov ebx,message_2
    call far [fs:PrintString]

    jmp near $

    mov ebx,message_3
    call far [fs:PrintString]
    call far [fs:TerminateProgram]

code_end:

SECTION trail

program_end: