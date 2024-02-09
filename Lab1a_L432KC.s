/*Author - Wing Hoy. Last edited on Jan 14, 2022 */
/*-----------------DO NOT MODIFY--------*/
.global TestAsmCall
.global printf
.global cr
.syntax unified

.text
TestAsmCall:
PUSH {lr}
/*--------------------------------------*/

//Defining labels for the dedicated memory locations
.EQU dataStart, 0x20001000 //start of data to read
.EQU writtenDataStart, 0x20003000 //start of writing addresses

//loading memory locations into registers for read/write 
LDR R4, =dataStart
LDR R6, =writtenDataStart

//Loop through program until exit code is read
LOOP:
LDR R5, [R4]
CMP R4, 0x0D
BEQ EXIT //exit loop when exit code is read
B VALIDATE57 //if exit code was not read, check that the value is in range

// if not convert the character to the appropriate value
//write to memory and increment mem counter

//Checking upper limit of letters

VALIDATE102:
CMP R5, #102 //compare to decimal 102
BGT ERROR
B VALIDATE97

//Lower limit of letters
VALIDATE97:
CMP R5, #0X61 //check if value is less than 65
BLT VALIDATE70
B TO_UPPER

TO_UPPER:
SUB R5, R5, #32
B LETTER_TO_HEX

VALIDATE65:
CMP R5, #65
BGE LETTER_TO_HEX
B ERROR

VALIDATE70:
CMP R5, #70
BGT ERROR
B VALIDATE65

LETTER_TO_HEX:
SUB R5, R5, #0X37 //subtract decimal 55 from values that represent letters
B WRITEMEM

//Upper limit of digits
VALIDATE57:
CMP R5, #0X39 //check if value is less than 57
BGT ERROR
B VALIDATE48

//Lower limit of digits
VALIDATE48: //check that value is greater than 48
CMP R5, #48
BGE DIGIT_TO_HEX
BLT ERROR
B VALIDATE102

DIGIT_TO_HEX:
SUB R5, R5, #48
B WRITEMEM

WRITEMEM:
STR R5, [R6] //store R5 in memory and shift index by 4
ADD R6, #4
ADD R4, R4, #0X04
B LOOP

ERROR:
MOV R5, #-1 //replace register value with -1 if (converted to upper) it was greater than 70
STR R5, [R6], +0x04
ADD R4, R4, #0X04
B LOOP

//Exit sequence
EXIT:
POP {PC}

/*
.data
exitCode:
.LONG 0x0D
errorCode:
.LONG 0xFFFFFFFF
*/

/*--------------------------------------*/

