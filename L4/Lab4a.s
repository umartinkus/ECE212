/*Author - Wing Hoy. Last edited on Mar 22, 2022 */
/*-----------------DO NOT MODIFY--------*/
.global Welcomeprompt
.global printf
.global cr
.extern value
.extern getstring
.extern getchar
.extern putchar
.syntax unified
.text

Welcomeprompt:
/*--------------------------------------*/
PUSH {LR}
PUSH {R0}

MAIN:
LDR R0, =prompt //load the prompt for user to enter a value
bl printf
bl getchar //entered character is now in R0
CMP R0, #90 //check if char is greater than ASCII Z
BGT ERROR
CMP R0, #65 //check if char greater than ASCII A
BGE EXIT //character entered was an uppercase letter
CMP R0, #57 //check if greater than 57 (9) or less than 65 (A)
BGT ERROR
CMP R0, #48 //check if 48 <= char <= 57
BGT EXIT //go to exit sequence if in valid range
B ERROR //throw error if not in valid range

ERROR:
LDR R0, =error
bl printf
bl cr
B MAIN

EXIT:
bl printf
STR R0, [SP, #8]
POP {R0}
POP {LR}
/*-------Students write their code here ------------*/

/*-----------------DO NOT MODIFY--------*/
.data
prompt:
.string "Enter an uppercase letter (A-Z) or a digit (0-9):"
error:
.string "Invalid entry. Try again."
/*--------------------------------------*/

