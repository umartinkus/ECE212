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
PUSH {R0}
PUSH {R4} //register used to print values
PUSH {R7} //used as a counter
PUSH {R5} //used to hold memory address of stored values
PUSH {R6} //Number of values

LDR R0, =Hello //load R4 with first string
bl printfbl cr //print hello string and start a new line
MOV R7, #0 //set counter to zero
LDR R5, [SP, #28] //load R5 with address of array
LDR R6, [SP, #24] //load R6 with number of vals

LDR R0, =Entries
bl printf
MOV R0, R6 //load R4 with number of values
bl value // print to terminal
bl cr
LDR R0, =Array
bl printf
bl cr


/*The following loop goes through array values and prints them until all values have been printed*/
LOOP:
CMP R7, R6 //check if we've read all values
BGE EXIT //go to exit routine if we've read all values
LDR R0, [R5], #4 //move first array value into R4 and increment by 4
bl value
bl cr
ADD R7, #1 //incremend counter by 1
b LOOP //go back to the start of the loop

EXIT:
POP {R6}
POP {R5}
POP {R7}
POP {R4}
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