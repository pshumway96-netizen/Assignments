section .data
    ; Task 1 Data
    counter_limit dd 5

    ; Task 2 Data
    fib_count     dd 10             ; Target Nth Fibonacci number (10th = 55)

    ; Task 3 Data
    array3        dd 12, 89, 45     ; Integer array of length 3
    array_len     dd 3

section .bss
    ; Variables to store results for debugging in GDB
    fib_result    resd 1
    largest       resd 1

section .text
    global _start

_start:
    xor ebx, ebx                    ; Reset EBX counter to 0
    mov ecx, [counter_limit]        ; Load loop count

task1_loop:
    inc ebx                         ; Increment counter register
    loop task1_loop                 ; Decrement ECX and loop until ECX == 0


    mov eax, 0                      ; F(0)
    mov ebx, 1                      ; F(1)
    mov ecx, [fib_count]            ; Loop counter = 10

fib_loop:
    cmp ecx, 0
    jz store_fib

    mov edx, eax                    ; edx = current F(n-1)
    add edx, ebx                    ; edx = F(n-1) + F(n)
    mov eax, ebx                    ; Shift F(n) -> F(n-1)
    mov ebx, edx                    ; Shift new term -> F(n)

    dec ecx
    jmp fib_loop

store_fib:
    mov [fib_result], eax           ; Store 10th Fibonacci term (55)

    mov ecx, 1                      ; Index pointer starts at 1
    mov eax, [array3]               ; Assume first element [0] is largest

task3_loop:
    cmp ecx, [array_len]
    jge store_largest               ; Exit loop when all 3 elements checked

    mov ebx, [array3 + ecx * 4]     ; Load array[ecx] (4 bytes per int)
    cmp ebx, eax
    jle skip_largest_update

    mov eax, ebx                    ; Update largest value found

skip_largest_update:
    inc ecx
    jmp task3_loop

store_largest:
    mov [largest], eax              ; Store result (89)


exit_program:
    mov eax, 1                      ; sys_exit syscall
    xor ebx, ebx                    ; status = 0
    int 0x80
