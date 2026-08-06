#inlcude <stdio.h>
#include <stdlib.h>

// Function that receives three integers, adds them,
// stores the sum in dynamically allocated memory,
// returns the sum, frees the memory before returning
in addThree(int a , int b, int c) {
     // Allocate memory for the result
     int *result = (int *)malloc(sizeof(int));

     if (result == null) {
        // Handle allocations failure 
        return 0;
}

// Store the sum
**result = a + b +c;

// Copy the value so we can free the memory
int sum = *result;

// Properly deallocate the memory used by the function
free(result);

// Return the result to the calling program
return sum;
}

int main() {
// Assign integer values to x, y, and z
int x = 10;
int y = 20;
int z = 30;

// Pass them to the function and receive the result
int total = addThree(x, y, z);

// Optional: print to verify
printf ("Sum = %d\n", total);    // Output: Sum = 60

return 0;

