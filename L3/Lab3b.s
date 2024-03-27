/*Author - Wing Hoy. Last edited on Jan 17, 2022 */

/*-----------------DO NOT MODIFY--------*/

.global Sort

.global printf

.global cr

.extern value

.extern getstring

.syntax unified



.text

Sort:

/*-----------------Students write their subroutine here--------------------*/

INIT:
PUSH {LR} // Must pop LR to PC at end of subroutine to return POP{PC}
PUSH {R1} // For curr pointer
PUSH {R3} // For Truth var
PUSH {R4} // For Counter
PUSH {R5} // to store curr temp data
PUSH {R6} // To store next temp data
PUSH {R7} // to store size of the data
LDR R7, [SP, #28] // holding the size o the data

MOV R3, #0 // register for the sorted flag start assuming unsorted

loopRST: // outer loop
CMP R3, #1 // check to see if the array is sorted
BEQ END // if sorted branch to end of the program

// Reset pointers to the start of the data
MOV R1, R0 // Init Curr pointer to first element in array
SUB R4, R7, #1 // reset counter to size of array less one
MOV R3, #1 // Start assuming sorted

MAINLOOP:
CMP R4, #0 // end of array condition
BEQ loopRST // branch to outer loop to reset loop condition if end of array
LDR R5, [R1] // Curr element in array
LDR R6, [R1, #4] // Next element in array
CMP R5, R6 // compare curr and next elements 
BGT HIGH // swap elements if Curr > Next
B LOW // Otherwise dont swap

LOW:
// Executes if lower than or equal
// No swapping occurs, Increments pointer, Decrement counter
SUB R4, #1 // decrement counter 
ADD R1, #4 // increment pointer
B MAINLOOP // branch back to main loop

HIGH:
// Executes if greater than condition is met
// Swapping occurs, Increments pointer, Decrements counter
MOV R3, #0 // Set Sorted flag to false
STR R5, [R1, #4] // change curr to next's memory location
STR R6, [R1]  // change next to currs memory location
SUB R4, #1 // Decrement counter
ADD R1, #4 // Increment data pointer
B MAINLOOP // branch back to main loop

END:
// pop registers off the stack
POP {R7}
POP {R6}
POP {R5}
POP {R4}
POP {R3}
POP {R1}
POP {PC}



/*-------Code ends here ---------------------*/



/*-----------------DO NOT MODIFY--------*/

.data

/*--------------------------------------*/
