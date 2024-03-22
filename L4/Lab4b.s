/*Author - Wing Hoy. Last edited on Mar 22, 2022 */
/*-----------------DO NOT MODIFY--------*/
.global Stat
.global printf
.global cr
.extern value
.extern getstring
.extern convert1
.syntax unified

.text
Stat:
/*--------------------------------------*/
PUSH {LR}
PUSH {R0}

LDR R0, [SP, #8]
PUSH {R0} //put ascii char back on stack in front of LR
bl convert1
POP {R0}
STR R0, [SP, #8] //store pattern in stack location that originally had ascii char
POP {PC}
/*-------Students write their code here ------------*/























/*-------Code ends here ---------------------*/

/*-----------------DO NOT MODIFY--------*/
.data
/*--------------------------------------*/
