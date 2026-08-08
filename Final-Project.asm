section .data
    prompt_plain    db "Enter plain text: ", 0
    prompt_plain_l  equ $ - prompt_plain

    prompt_key      db "Enter key: ", 0
    prompt_key_l    equ $ - prompt_key

    lbl_plain       db "Plain text: ", 0
    lbl_plain_l     equ $ - lbl_plain

    lbl_key         db "Key: ", 0
    lbl_key_l       equ $ - lbl_key

    lbl_enc         db "Encrypted text: ", 0
    lbl_enc_l       equ $ - lbl_enc

    lbl_dec         db "Decrypted text: ", 0
    lbl_dec_l       equ $ - lbl_dec

    newline         db 10, 0
    filename        db "output.txt", 0

section .bss
    plaintext       resb 256
    keytext         resb 256
    encrypted       resb 256
    decrypted       resb 256
    plain_len       resq 1
    key_len         resq 1
    filedesc        resq 1

section .text
    global _start

_start:
    ; Prompt and Read Plaintext
    mov rax, 1                  ; sys_write
    mov rdi, 1                  ; stdout
    mov rsi, prompt_plain
    mov rdx, prompt_plain_l
    syscall

    mov rax, 0                  ; sys_read
    mov rdi, 0                  ; stdin
    mov rsi, plaintext
    mov rdx, 255
    syscall

    mov rcx, rax
    dec rcx
    cmp byte [plaintext + rcx], 10
    jne store_plain_len
    mov byte [plaintext + rcx], 0
store_plain_len:
    mov [plain_len], rcx

    ; Prompt and Read Key
    mov rax, 1                  ; sys_write
    mov rdi, 1                  ; stdout
    mov rsi, prompt_key
    mov rdx, prompt_key_l
    syscall

    mov rax, 0                  ; sys_read
    mov rdi, 0                  ; stdin
    mov rsi, keytext
    mov rdx, 255
    syscall

    mov rcx, rax
    dec rcx
    cmp byte [keytext + rcx], 10
    jne store_key_len
    mov byte [keytext + rcx], 0
store_key_len:
    mov [key_len], rcx

    ; XOR Logic Loop
    mov rcx, 0                  ; Index counter

xor_loop:
    cmp rcx, [plain_len]
    jge xor_done

    mov al, [plaintext + rcx]
    mov bl, [keytext + rcx]

    xor al, bl                  ; Encrypt
    mov [encrypted + rcx], al

    xor al, bl                  ; Decrypt
    mov [decrypted + rcx], al

    inc rcx
    jmp xor_loop

xor_done:
    mov byte [encrypted + rcx], 0
    mov byte [decrypted + rcx], 0

    ; Open output.txt
    mov rax, 2                  ; sys_open
    mov rdi, filename
    mov rsi, 577                ; O_WRONLY | O_CREAT | O_TRUNC
    mov rdx, 0644o
    syscall
    mov [filedesc], rax

    ; Write formatted content
    mov rsi, lbl_plain
    mov rdx, lbl_plain_l
    call write_to_file

    mov rsi, plaintext
    mov rdx, [plain_len]
    call write_to_file

    mov rsi, newline
    mov rdx, 1
    call write_to_file

    mov rsi, lbl_key
    mov rdx, lbl_key_l
    call write_to_file

    mov rsi, keytext
    mov rdx, [key_len]
    call write_to_file

    mov rsi, newline
    mov rdx, 1
    call write_to_file

    mov rsi, lbl_enc
    mov rdx, lbl_enc_l
    call write_to_file

    mov rsi, encrypted
    mov rdx, [plain_len]
    call write_to_file

    mov rsi, newline
    mov rdx, 1
    call write_to_file

    mov rsi, lbl_dec
    mov rdx, lbl_dec_l
    call write_to_file

    mov rsi, decrypted
    mov rdx, [plain_len]
    call write_to_file

    mov rsi, newline
    mov rdx, 1
    call write_to_file

    ; Close file & Exit
    mov rax, 3                  ; sys_close
    mov rdi, [filedesc]
    syscall

    mov rax, 60                 ; sys_exit
    mov rdi, 0
    syscall

write_to_file:
    mov rax, 1                  ; sys_write
    mov rdi, [filedesc]
    syscall
    ret
