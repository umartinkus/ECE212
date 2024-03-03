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
LDR R0, =0x20001000 //loading number of data points
LDR R0, [R0]
SUB R0, R0, #1 //read only n-1 data points
LDR R1, =0X2000100C //loading temp storage address
LDR R2, =0X20001004 //loading x data points (addresses)
LDR R2, [R2] //loading x data points (addresses)
LDR R3, =0X20001008 //loading y data points (addresses)
LDR R3, [R3] //loading y data points (addresses)
MOV R4, #0			//register holding cumulative area
MOV R5, #0			//calculation register
MOV R6, #0			//counting register
MOV R7, #0			//calculation register 2

LOOP:
//LDR R5, [R0] //load number of points into calc register
//SUB R5, R5, #1 //we should only read n-1 data points
CMP R6,R0 //check if we have read all of the points
BGT END //exit program if we have
B INTEGRATE //integrate until all data points have been addressed

INTEGRATE:
LDR R5, [R2], #4 //bring nth x point into calc register 1
LDR R7, [R2], #4 //bring n+1th x point into calc register 2
SUB R7, R7, R5 //getting delta(x) value
/*divide by 2; gives 2,1,0 for delta(x) = 4,2,1 respectively
This will determine the LSL value for calculating area of trapezoid*/
LSR R7, R7, #1
STR R7,[R1]//place the LSL value into buffer memory location
LDR R5, [R3], #4 //load the first y data point
LDR R7, [R3], #4 //load the second y data point
ADD R7, R7, R5 //calculate sum and store in register 7; will be used for trapezoid area
LDR R5, [R1] //pull delta x LSL value from memory --> can maybe remove the memory here, register will do
LSL R7, R5 // multiplying delta(x) by (y1+y2)/2
ADD R4, R4, R7 //add trapezoid area to cumulative sum
ADD R6,#1 //increment counter by 1
B LOOP

/*-------Students write their code here ------------*/


/*-------Code ends here ---------------------*/

/*-----------------DO NOT MODIFY--------*/
END:
POP {PC}

.data
/*--------------------------------------*/
