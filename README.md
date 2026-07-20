# Activity: First Assembly Language Code

## 1. Flowchart

START -> (Define Strings with Newlines) -> (Print Text) -> (Exit Program) -> END

## 2. Challenges 
* **Figuring out WSL:** The biggest problem I had was realizing I couldn't just run this code normally on Windows. It took some time to get Windows Subsystem for Linux (WSL) and Ubuntu set up properly so I had a place to actually run the program.
* **Using the Nano editor:** Working inside a terminal text editor like Nano was brand new to me. It was a bit confusing at first to figure out how to type my code, save the file, and exit back to the regular prompt without messing up the formatting.
* **Compiling through the command line:** Instead of just hitting a "Run" button in a normal coding program, I had to learn how to manually use NASM and the linker commands. Getting the syntax right for those commands and dealing with early typos took a few tries to get down.
* ---

## Activity 2: Variables and Constants

### 1. Flowchart
START -> (Define var1 and var2 in .data) -> (Reserve space for result in .bss) -> (Load var1 into EAX register) -> (Add var2 to EAX register) -> (Move EAX register value into result) -> (Exit Program) -> END

### 2. Challenges 
* **Moving data around in memory:** My biggest issue was trying to figure out that you can't just add two variables together directly in assembly (like `add result, var1`). It took me a second to realize I had to use a middleman register like `EAX` to hold the data, do the math there, and then pass it off to the final variable.
* **Dealing with sizes and specifiers:** Keeping track of data sizes was pretty confusing at first. Figuring out when to use `dd` for initializing data versus `resd` for reserving empty space in the `.bss` section took some trial and error to make sure everything lined up without throwing matching errors.

# Activity 3: Arithmetic Instructions

## 1. Flowchart
START -> (Define Initialized Variables) -> (Reserve Uninitialized Space for Results) -> (Execute Signed Arithmetic Operations) -> (Store Final Values in Output Variables) -> (Clean System Exit) -> END

## 2. Challenges
* **Dealing with signed division crashes:** My biggest problem was realizing you can't just throw an `idiv` command into the code right after multiplying. The program kept crashing with a floating-point exception until I realized I had to use `cdq` to sign-extend the registers first so the CPU didn't read random leftover data.
* **Finding the right numbers for division:** For the last equation, I had to be really careful on picking the starting values so that the math worked out to be a whole number. I also had to make sure the bottom half of the fraction didn't end up equaling 0, since dividing by zero would instantly crash the program.

## 1. Flowchart
START -> (Define Message String) -> (XOR rax with itself to clear to 0) -> (TEST rbx with 1 to check if odd) -> (Print Message via Syscall) -> (Exit Program) -> END

### 2. Challenges
* **Understanding bitwise masking:** My biggest issue was trying to figure out how the `TEST` instruction actually works under the hood. It took me a second to realize that it performs a bitwise AND operation to mask bits and updates the CPU flags without altering the value stored in the register itself.
* **Working with logical flags:** Keeping track of conditional jumps after a logical test was pretty confusing at first. Figuring out exactly how the Zero Flag is affected by `TEST` versus `XOR`, and managing how the program branches based on those flag states, took some trial and error to get right.

# Midterm Exam 

## Question 1 

### Task c: Register Usage Table
Based on the execution of the division instruction (`div bl`), the quotient and remainder are stored in the following registers:

| Register Name | Value | Description |
| :--- | :--- | :--- |
| **al** (or rax) | `0x2` (2) | Stores the **Quotient** |
| **ah** (or rax) | `0x0` (0) | Stores the **Remainder** |

### Question 1 - Task d: GDB Verification

Here is the GDB screenshot verifying the register values:

<img width="1917" height="1038" alt="image (12)" src="https://github.com/user-attachments/assets/825cd9a3-0b8f-4332-bed6-24c17f004386" />

## Question 2

**Given Equation:**
$$Y = a \cdot b + a' \cdot b + a \cdot b'$$

### 1. K-Map Setup
Since there are two variables ($a$ and $b$), a 2-variable Karnaugh Map is used. We place a `1` in the cells corresponding to the minterms present in the equation:
* $a \cdot b$ $\rightarrow$ Row $a=1$, Column $b=1$
* $a' \cdot b$ $\rightarrow$ Row $a=0$, Column $b=1$
* $a \cdot b'$ $\rightarrow$ Row $a=1$, Column $b=0$

| | $b = 0$ ($b'$) | $b = 1$ ($b$) |
|---|---|---|
| **$a = 0$ ($a'$)** | 0 | 1 |
| **$a = 1$ ($a$)** | 1 | 1 |

---

### 2. Grouping and Simplification
To simplify the expression, we loop the adjacent 1s into the largest possible groups of $2^n$ (groups of 2):

1. **Horizontal Group (Row $a = 1$):**
   * Combines cells $(a \cdot b')$ and $(a \cdot b)$.
   * $b$ changes from 0 to 1, so it is eliminated. $a$ remains constant at 1.
   * **Group Result = $a$**

2. **Vertical Group (Column $b = 1$):**
   * Combines cells $(a' \cdot b)$ and $(a \cdot b)$.
   * $a$ changes from 0 to 1, so it is eliminated. $b$ remains constant at 1.
   * **Group Result = $b$**

---

### 3. Final Simplified Equation
Combining the results of both groups using the OR operator yields the final simplified Boolean expression:

$$Y = a + b$$

## Question 3

### a. Detailed Design and Approach
To determine whether a number is odd or even without using the `AND` or `OR` logical instructions, we can look at the **Least Significant Bit (LSB)** of the number using bit-shifting or arithmetic division. 

**Approach: Using the `TEST` or `SHR`/`RCR` instruction**
* Every even number in binary ends with a `0` in its least significant bit (e.g., $4 = 0100_2$).
* Every odd number in binary ends with a `1` in its least significant bit (e.g., $5 = 0101_2$).
* Instead of using `AND`, we can use the `TEST` instruction against `1`. `TEST` performs a bitwise logical AND operation behind the scenes to set CPU flags (like the Zero Flag) but **does not alter the destination register**.
* Alternatively, we can use the `SHR` (Shift Right) instruction to move the lowest bit into the **Carry Flag (CF)**. If the Carry Flag becomes `1`, the number is odd. If it becomes `0`, the number is even. We will use this shifting approach as it completely avoids any logical "AND/OR" operations or concepts.

---

### b. & c. Assembly Code Implementation
Below is the x86 assembly implementation that checks the value of a number and prints the corresponding message.

```assembly
section .data
    even_msg db "even number", 10, 0   ; Message for even numbers (with newline)
    odd_msg  db "odd number", 10, 0    ; Message for odd numbers (with newline)

section .text
    global _start

_start:
    ; Example: Load the number to check into the EAX register
    mov eax, 7                ; Change this value to test different numbers

    ; Shift the lowest bit into the Carry Flag (CF)
    ; This avoids using any AND or OR logical instructions
    shr eax, 1                

    ; If the Carry Flag is 1, the number was odd. Jump to the odd label.
    jc print_odd              

print_even:
    ; System call to print "even number"
    mov eax, 4                ; sys_write
    mov ebx, 1                ; stdout
    mov ecx, even_msg         ; pointer to message
    mov edx, 12               ; message length
    int 0x80
    jmp exit                  ; skip past the odd printing block

print_odd:
    ; System call to print "odd number"
    mov eax, 4                ; sys_write
    mov ebx, 1                ; stdout
    mov ecx, odd_msg          ; pointer to message
    mov edx, 11               ; message length
    int 0x80

exit:
    ; System call to exit the program cleanly
    mov eax, 1                ; sys_exit
    mov ebx, 0                ; return 0
    int 0x80

# Conditional Instructions Assignment

## 1. Flowcharts

### Task 1: Generate Even or Odd Numbers up to 20
```mermaid
    Start([Start]) --> Init[Initialize Counter = 2 or 1\nStep = 2]
    Init --> Check{Counter <= 20?}
    Check -- Yes --> Print[Process / Hold Number in Register]
    Print --> Increment[Counter = Counter + Step]
    Increment --> Check
    Check -- No --> End([Task 1 Complete])

#### Task 2: Find the Largest Value Among Five Integers
''''mermaid
    Start([Start Task 2]) --> Init[EAX = array[0]\nIndex ECX = 1]
    Init --> LoopCheck{ECX < 5?}
    LoopCheck -- Yes --> Compare{array[ECX] > EAX?}
    Compare -- Yes --> Update[EAX = array[ECX]]
    Compare -- No --> Next[Increment ECX]
    Update --> Next
    Next --> LoopCheck
    LoopCheck -- No --> Store[Store EAX into 'largest']
    Store --> End([End Program])

##### Challenges
  Choosing the Right Jump Instructions: At the beginning I kept using the wrong jump instructions when comparing numbers, which made the program branch completely in the wrong direction. Then I realized that unsigned jumps like ja treat negative numbers as huge positive values, which ended up messing up the comparison. I switched over to signed jumps like jg which fixed the logic and allowed the program to correctly evaluate negetive integers.
  Tracking Variables in GDB: It was hard to tell if the largest number was actually sacing into the "largest" varible since the terminal doesn't print out the output by default. I had to learn how to set up hardwaare watchpoints in GDB to pause the execution right when the memory adress changed. This made it so much easier to step through the intructions line by line and confirm the final result was corrrect. 





