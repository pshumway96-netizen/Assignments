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

