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

* ### Question 1 - Task c: Register Table

| Register Name | Value | Description |
| :--- | :--- | :--- |
| **al** (or rax) | `0x2` | Stores the **Quotient** |
| **ah** (or rax) | `0x0` | Stores the **Remainder** |

### Question 1 - Task d: GDB Verification

Here is the GDB screenshot verifying the register values:

![GDB Screenshot](image (12)_2.png)
