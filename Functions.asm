section .data
    num          dd 7
    msg_even     db 'The number is even.', 10
    len_even     equ $ - msg_even
    msg_odd      db 'The number is odd.', 10
    len_odd      equ $ - msg_odd

section .text
    global _start

_start:
    mov eax, [num]
    call check_odd_even

    mov eax, 1
    xor ebx, ebx
    int 0x80

check_odd_even:
    test eax, 1
    jnz print_odd

print_even:
    mov eax, 4
    mov ebx, 1
    mov ecx, msg_even
    mov edx, len_even
    int 0x80
    ret

print_odd:
    mov eax, 4
    mov ebx, 1
    mov ecx, msg_odd
    mov edx, len_odd
    int 0x80
    ret
