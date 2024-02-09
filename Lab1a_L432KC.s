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
CMP R4, exitCode
BEQ EXIT
B VALIDATE70 //if exit code was not read, check that the value is in range

// if not convert the character to the appropriate value
//write to memory and increment mem counter

//Checking upper limit of letters
VALIDATE70:
LDR R5, [R4]
EOR R5, R5, #0X20 //flips the fifth bit to zero; enables checking upper and lower at same time
CMP R5, #0x46 //compare to decimal 70
ITE GT
LDR R5, errorCode //replace register value with -1 if (converted to upper) it was greater than 70
B VALIDATE65

//Lower limit of letters
VALIDATE65:
CMP R5, #0X41 //check if value is less than 65
ITEE LT
VALIDATE57
SUB R5, R5, #0X37 //subtract decimal 55 from values that represent letters
B WRITEMEM

//Upper limit of digits
VALIDATE57:
CMP R5, #0X39
ITEE GT
LDR R5, errorCode
SUB R5, R5, #0X30 //subtract 48 from value then compare to zero
B VALIDATE0

//Lower limit of digits
VALIDATE0:
CMP R5, 0X00
IT LT
LDR R5, errorCode
B WRITEMEM

WRITEMEM:
STR R5, R6 
ADD R6, R6, #0X04
ADD R4, R4, #0X04
B LOOP


//Exit sequence
EXIT:
POP {PC}

.data
exitCode:
.LONG 0x0D
errorCode:
.LONG 0xFFFFFFFF
/*--------------------------------------*/

