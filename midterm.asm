; =========================================================
; Task a: Values statement comment near the beginning
; result = unknown (will be calculated dynamically)
; var1   = 4
; var2   = 2
; var3   = 5
; Equation calculation: (4 + 2) / (5 - 2) = 6 / 3 = 2
; =========================================================

section .data
    var1    db 4            
    var2    db 2            
    var3    db 5            
    result  db 0            

section .text
    global _start

_start:
    ; --- Step 1: Compute the Numerator (var1 + 2) ---
    mov al, [var1]          
    add al, 2               

    ; --- Step 2: Compute the Denominator (var3 - var2) ---
    mov bl, [var3]          
    sub bl, [var2]          

    ; --- Step 3: Perform Unsigned Division ---
    mov ah, 0               
    div bl                  

    ; Store the raw quotient integer
    mov [result], al        

    ; --- Task b: Convert and display result on console screen ---
    add al, '0'             
    mov [result], al        

    ; Native system call to write to stdout
    mov rax, 1              
    mov rdi, 1              
    mov rsi, result         
    mov rdx, 1              
    syscall                 

    ; --- Clean Exit ---
    mov rax, 60             
    xor rdi, rdi            
    syscall
