/*Author - Wing Hoy. Last edited on Jan 17, 2022 */
/*-----------------DO NOT MODIFY--------*/
.global Display
.global printf
.global cr
.extern value
.extern getstring
.syntax unified

.text
Display:
/*-----------------Students write their subroutine here--------------------*/

PUSH {LR}
PUSH {R0} //register used to print values
PUSH {R1} //used as a counter
PUSH {R2} //used to hold memory address of stored values
PUSH {R3} //Number of values

LDR R0, =Hello //load r0 with first string
bl printf
bl cr //print hello string and start a new line
MOV R1, #0 //set counter to zero
LDR R2, [SP, #-24] //load R2 with address of array
LDR R3, [SP, #-20] //load R3 with number of vals

LDR R0, =Entries
bl printf
MOV R0, R3 //load r0 with number of values
bl value // print to terminal
bl cr
LDR R0, =Array
bl printf
bl cr

/*The following loop goes through array values and prints them until all values have been printed*/
LOOP:
CMP R1, R3 //check if we've read all values
BGE EXIT //go to exit routine if we've read all values
LDR R0, [R2], #4 //move first array value into R0 and increment by 4
bl printf
bl cr
ADD R1, #1 //incremend counter by 1
b LOOP //go back to the start of the loop

EXIT:
POP {R3}
POP {R2}
POP {R1}
POP {R0}
POP {PC}

/*-------Code ends here ---------------------*/

/*-----------------DO NOT MODIFY--------*/
.data
/*--------------------------------------*/
Hello:
.string "The numbers are sorted with bubblesort algorithm"
Entries:
.string "The number of entries was "
Array:
.string "Sorted from smallest to biggest, the numbers are:"
endmsg:
.string "program ended"
