section .data
    ; Task 1 Data: Starting value and ceiling limit
    seq_start dd 2           ; Change to 1 for odd, 2 for even sequence
    seq_limit dd 20          ; Ceiling value

    ; Task 2 Data: Array of 5 initialized integer values
    numbers   dd 15, -4, 82, 43, 67
    num_count dd 5

section .bss
    ; Task 2 Output: Uninitialized variable to store the largest result
    largest   resd 1

section .text
    global _start

_start:
    mov eax, [seq_start]     ; Current sequence register value
    mov ebx, [seq_limit]     ; Maximum threshold value

generate_loop:
    cmp eax, ebx             ; Compare current value against max limit
    jg task2_start           ; If current > 20, break out to Task 2

    ; [EAX holds the current sequence value]

    add eax, 2               ; Step forward by 2 to keep parity (even/odd)
    jmp generate_loop        ; Repeat iteration


task2_start:
    mov ecx, 1               ; ECX acts as loop counter / index (starts at index 1)
    mov eax, [numbers]       ; Assume first element (index 0) is the largest

find_largest_loop:
    cmp ecx, [num_count]     ; Check if all 5 values have been scanned
    jge store_result         ; If ecx >= 5, array traversal is complete

    mov ebx, [numbers + ecx * 4]  ; Fetch element at current offset (ecx * 4 bytes)
    cmp ebx, eax             ; Compare array value against current maximum
    jle skip_update          ; If ebx <= eax, skip assignment

    mov eax, ebx             ; Update register with new max integer value

skip_update:
    inc ecx                  ; Advance index counter
    jmp find_largest_loop

store_result:
    mov [largest], eax       ; Store final max value in uninitialized variable 'largest'

exit_program:
    mov eax, 1               ; Syscall: sys_exit
    xor ebx, ebx             ; Return code 0
    int 0x80
