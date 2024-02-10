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
.EQU writtenDataStart, 0x20002000 //start of writing addresses

//loading memory locations into registers for read/write 
LDR R4, =dataStart
LDR R6, =writtenDataStart

//Loop through program until exit code is read
LOOP:
LDR R5, [R4]
CMP R5, #13 //check for exit code
BEQ EXIT
BNE VALIDATE //if exit code was not read, check that the value is in range

//Checking upper limit of letters
VALIDATE:
CMP R5, #102 //compare to decimal 102
BGT ERROR
CMP R5, #97
BGE TO_UPPER
CMP R5, #70
BGT ERROR
CMP R5, #65
BGE LETTER_TO_HEX
CMP R5, #57
BGT ERROR
CMP R5, #48
BGE DIGIT_TO_HEX
BLT ERROR

TO_UPPER:
SUB R5, R5, #32
B LETTER_TO_HEX

//convert from an ascii digit between 65 and 70 to a digit between 10 and 15
LETTER_TO_HEX:
SUB R5, R5, #55 //subtract decimal 55 from values that represent letters
B WRITEMEM

//convert from ascii 48-57 to a digit from 0-9
DIGIT_TO_HEX:
SUB R5, R5, #48
B WRITEMEM

//procedure to write words into memory
WRITEMEM:
STR R5, [R6]
ADD R6, R6, #4 //store R5 in memory
ADD R4, R4, #4 //shift reading index by 4
B LOOP

//subroutine writing error codes into memory
ERROR:
MOV R5, #-1 //replace register value with -1 if (converted to upper) it was greater than 70
STR R5, [R6]
ADD R6, R6, #4
ADD R4, R4, #4
B LOOP

//Exit sequence
EXIT:
POP {PC}
.data
/*--------------------------------------*/

