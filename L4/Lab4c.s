/*Author - Wing Hoy. Last edited on Mar 22, 2022 */
/*-----------------DO NOT MODIFY--------*/
.global Display
.global printf
.global cr
.extern value
.extern getstring
.extern offled()
.extern onled()
.extern column()
.extern Column()
.extern row()
.extern Row()
.syntax unified

.text
Display:
/*--------------------------------------*/

/*-------Students write their code here ------------*/

INIT:
PUSH {LR}
PUSH {R0}
PUSH {R4}
PUSH {R5}
PUSH {R6}
PUSH {R7}
PUSH {R8}
PUSH {R10}

LDR R4, [SP, #32] // Address of Pattern (immediate index may need to be changed later)

// Display message on MTTTY

MOV R9, #1 // Delay time for HAL_DELAY Not sure if this is good.
MOV R8, #0 // Counter for the total amount of times we display the pattern

LOOP1:
MOV R6, #0 // Row counter Init to 0
MOV R7, #0 // Column counter Init to 0
LDR R10,=0b10000000 // Pattern Starting from Column 0;
LDR R4, [SP, #32] // Address of Pattern

LOOP2:
// Sweep Each Row
LDR R5, [R4] //Load Pattern into R5
AND R5, R10 // Get Pattern store into R5

CMP R5, #0 // Check to see if pattern matches
BNE TURNON // If LED in pattern turn it on
BackToLoop2: //Come Here After Turning on LED
ADD R7, #1 // Increment column indeex
LSR R10,#1
CMP R7, #7
BGT INCROW // Increment Row if Column index greater than 7
B LOOP2 // repeat loop 2 for next column in row


TURNON:
MOV R0, R6 // Move row value into R0 for Subroutine
BL Row // Set Row index
MOV R0, R7 // Move column value into R0
BL Column // Set Column Index

BL onled // Turn on LED
mov r0,r9
BL HAL_Delay // Delay...
BL offled // Turn LED off
B BackToLoop2 // Branch Back to position in LOOP2

INCROW:
ADD R6, #1 // Increment row index
MOV R7, #0 // Reset column index

ADD R4, #1 // Increment to next row's pattern

LDR R10,=0b10000000 // Reset R10 to first column

CMP R6, #7
BLE LOOP2
add r8,#1

CMP R8, #100 // Check if R8 has surpassed total number of iterations

BLT LOOP1


END:
POP {R10}
POP {R8}
POP {R7}
POP {R6}
POP {R5}
POP {R4}
POP {R0}
POP {PC}



/*-------Code ends here ---------------------*/

/*-----------------DO NOT MODIFY--------*/
.data
/*--------------------------------------*/
