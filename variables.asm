section .text
    global _start

_start:
    mov eax, [var1]       ; Move the value of var1 (10) into the EAX register
    add eax, [var2]       ; Add the value of var2 (15) to EAX (EAX now equals 25)
    mov [result], eax     ; Store the final sum into the result variable
    
    mov eax, 1            ; System call number for sys_exit
    mov ebx, 0            ; Return exit code 0
    int 0x80              ; Call the kernel to exit cleanly

segment .bss
    result resd 1         ; Reserve 1 double-word (4 bytes) for the final sum

segment .data
    var1 dd 10            ; Define double-word initialized to 10
    var2 dd 15            ; Define double-word initialized to 15
