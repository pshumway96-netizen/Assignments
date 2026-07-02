section .data
    ; Variables for the equations (Adjust values as needed)
    var1        dd 10
    var2        dd 7        ; Chosen so var2 - 3 = 4 (for clean integer division)
    var3        dd 15
    var4        dd 5

section .bss
    ; Uninitialized storage for each separate result
    result1     resd 1
    result2     resd 1
    result3     resd 1
    result4     resd 1

section .text
    global _start

_start:
    ; ---------------------------------------------------------
    ; Equation 1: result1 = -var1 * 10
    ; ---------------------------------------------------------
    mov eax, [var1]
    neg eax
    imul eax, eax, 10
    mov [result1], eax

    ; ---------------------------------------------------------
    ; Equation 2: result2 = var1 + var2 + var3 + var4
    ; ---------------------------------------------------------
    mov eax, [var1]
    add eax, [var2]
    add eax, [var3]
    add eax, [var4]
    mov [result2], eax

    ; ---------------------------------------------------------
    ; Equation 3: result3 = (-var1 * var2) + var3
    ; ---------------------------------------------------------
    mov eax, [var1]
    neg eax
    imul eax, [var2]
    add eax, [var3]
    mov [result3], eax

    ; ---------------------------------------------------------
    ; Equation 4: result4 = (var1 * 2) / (var2 - 3)
    ; ---------------------------------------------------------
    ; Calculate Numerator (var1 * 2)
    mov eax, [var1]
    imul eax, 2

    ; Calculate Denominator (var2 - 3)
    mov ecx, [var2]
    sub ecx, 3

    ; Signed Division
    cdq                     ; Sign-extend EAX into EDX
    idiv ecx                ; EAX = quotient
    mov [result4], eax

    ; ---------------------------------------------------------
    ; Clean Exit Syscall (Linux x86_64)
    ; ---------------------------------------------------------
    mov eax, 60             ; sys_exit
    xor edi, edi            ; return code 0
    syscall
