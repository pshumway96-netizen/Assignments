section .data
    current_char db 'A'
    newline      db 10

section .text
    global _start

_start:
    mov ecx, 26

print_loop:
    push ecx

    call print_char
    call print_newline

    inc byte [current_char]

    pop ecx
    loop print_loop

    mov eax, 1
    xor ebx, ebx
    int 0x80

print_char:
    mov eax, 4
    mov ebx, 1
    mov ecx, current_char
    mov edx, 1
    int 0x80
    ret

print_newline:
    mov eax, 4
    mov ebx, 1
    mov ecx, newline
    mov edx, 1
    int 0x80
    ret
