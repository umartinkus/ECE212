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
BNE VALIDATE102 //if exit code was not read, check that the value is in range

//Checking upper limit of letters
VALIDATE102:
CMP R5, #102 //compare to decimal 102
BGT ERROR
BLT VALIDATE97

//Lower limit of letters
VALIDATE97:
CMP R5, #97 //check if value is less than 65
BGE TO_UPPER
BLT VALIDATE70

//Upper limit of upper case digits
VALIDATE70:
CMP R5, #70
BGT ERROR //check next upper limit for lower case letters
BLT VALIDATE65

//checking lower limit of lower case digits
VALIDATE65:
CMP R5, #65
BGE LETTER_TO_HEX //conver to hex digit if were greater than or equal to 65
BLT VALIDATE57

//Upper limit of digits
VALIDATE57:
CMP R5, #57 //check if value is less than 57
BGT ERROR //branch to check lower bound if were under 57
BLT VALIDATE48 //branch to check next upper bound if were too big

//Lower limit of digits
VALIDATE48: //check that value is greater than 48
CMP R5, #48
BGE DIGIT_TO_HEX //greater than or equal to 48 means its a decimal digit
BLT ERROR //if less than 48, its not a valid hex digit

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

