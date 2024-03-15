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
PUSH{LR} // Must pop LR to PC at end of subroutine to return POP{PC}
PUSH{R0} // For size
PUSH{R1} // For curr pointer
PUSH{R3} // For Truth var
PUSH{R4} //For Counter
PUSH{R5} // to store curr temp data
PUSH{R6} // To store next temp data

LDR R0, [SP, #-32]
LDR R1, =0x20001000 // Init pointer
MOV R3, #0 // register for the sorted flag
MOV R4, R0 // Init counter to size.

loopRST:
CMP R3, #1
BEQ END
// Reset pointers to the start of the data
LDR R1, =0x20001000 // Init Curr pointer
MOV R4, R0 // reset counter to zero
MOV R3, #1 // Start assuming sorted

MAINLOOP:
CMP R4, #0 // end of array condition
BEQ loopRST
LDR R5, [R1] // Curr
LDR R6, [R1, #4] // Next
CMP R5, R6
BGT HIGH //
B LOW

LOW:
// Executes if lower than or equal
// No swapping occurs, Increments pointer, Decrement counter
SUB R4, #-1
ADD R1, #4
B MAINLOOP
HIGH:
// Executes if greater than condition is met
// Swapping occurs, Increments pointer, Decrements counter
MOV R3, #0 // Set Sorted flag to false
STR R5, [R1, #4] //Swap Two values in memory
STR R6, [R1]
SUB R4, #-1 // Decrement counter
ADD R1, #4 // Increment data pointer
B MAINLOOP





END:
POP{R6}
POP{R5}
POP{R4}
POP{R3}
POP{R1}
POP{R0}
POP{PC}


/*-------Code ends here ---------------------*/



/*-----------------DO NOT MODIFY--------*/

.data

/*--------------------------------------*/