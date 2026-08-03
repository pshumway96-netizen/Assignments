section .data
    filename db 'quotes.txt', 0

    ; Initial quotes (Task 1)
    quote1 db "To be, or not to be, that is the question.", 10
    len1 equ $ - quote1

    quote2 db "A fool thinks himself to be wise, but a wise man knows himself to be a fool.", 10
    len2 equ $ - quote2

    ; Additional quotes to append (Task 2)
    quote3 db "Better three hours too soon than a minute too late.", 10
    len3 equ $ - quote3

    quote4 db "No legacy is so rich as honesty.", 10
    len4 equ $ - quote4

section .bss
    fd_out resd 1

section .text
    global _start

_start:
    ; sys_open (eax=5): create file with permissions rw-r--r-- (0644 octal)
    ; Flags: O_CREAT (64) | O_WRONLY (1) | O_TRUNC (512) = 577 (0x241)
    mov eax, 5
    mov ebx, filename
    mov ecx, 577         ; O_CREAT | O_WRONLY | O_TRUNC
    mov edx, 0644q       ; Mode: -rw-r--r--
    int 0x80

    mov [fd_out], eax    ; Store file descriptor

    ; Write Quote 1
    mov eax, 4           ; sys_write
    mov ebx, [fd_out]    ; File descriptor
    mov ecx, quote1      ; Buffer address
    mov edx, len1        ; Buffer length
    int 0x80

    ; Write Quote 2
    mov eax, 4           ; sys_write
    mov ebx, [fd_out]    ; File descriptor
    mov ecx, quote2      ; Buffer address
    mov edx, len2        ; Buffer length
    int 0x80

    ; sys_close (eax=6)
    mov eax, 6
    mov ebx, [fd_out]
    int 0x80

    ; sys_open (eax=5): open file in read/write mode (O_RDWR = 2)
    mov eax, 5
    mov ebx, filename
    mov ecx, 2           ; O_RDWR
    mov edx, 0
    int 0x80

    mov [fd_out], eax    ; Store file descriptor

    ; sys_lseek (eax=19): seek to end of file (SEEK_END = 2)
    mov eax, 19          ; sys_lseek
    mov ebx, [fd_out]    ; File descriptor
    mov ecx, 0           ; Offset: 0 bytes
    mov edx, 2           ; Reference position: End of file
    int 0x80

    ; Write Quote 3
    mov eax, 4           ; sys_write
    mov ebx, [fd_out]    ; File descriptor
    mov ecx, quote3      ; Buffer address
    mov edx, len3        ; Buffer length
    int 0x80

    ; Write Quote 4
    mov eax, 4           ; sys_write
    mov ebx, [fd_out]    ; File descriptor
    mov ecx, quote4      ; Buffer address
    mov edx, len4        ; Buffer length
    int 0x80

    ; sys_close (eax=6)
    mov eax, 6
    mov ebx, [fd_out]
    int 0x80

    ; Exit program gracefully (sys_exit)
    mov eax, 1
    xor ebx, ebx
    int 0x80
