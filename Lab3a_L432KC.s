/*Author - Wing Hoy. Last edited on Jan 17, 2022 */
/*-----------------DO NOT MODIFY--------*/
.global Welcomeprompt
.global printf
.global cr
.extern value
.extern getstring
.syntax unified

.text
Welcomeprompt:
/*-----------------Students write their subroutine here--------------------*/
PUSH {lr}
PUSH {r0}
PUSH {r1}
PUSH {r2}
PUSH {r3}
PUSH {r4}
PUSH {r5}
PUSH {r6}
PUSH {r7}
.equ memstart, 0x20001000
ldr r5,=memstart

bl cr
ldr r0,=WelcomeString
bl printf
bl cr
ldr r0,=Prompt
bl printf
bl cr
bl getstring
mov r4,r0
bl value
bl cr
cmp r4,#3
blt low
cmp r4,#10
bgt high
b continue

low:
ldr r0,=Prompt3
bl printf
bl cr
bl getstring
mov r4,r0
bl value
bl cr
cmp r4,#3
blt low
cmp r4,#10
bgt high
b continue

high:
ldr r0,=Prompt4
bl printf
bl cr
bl getstring
mov r4,r0
bl value
bl cr
cmp r4,#3
blt low
cmp r4,#10
bgt high
b continue

continue:
mov r6,r4

collect:
cmp r6,#0
beq End

cmp r6,#1
beq lastone
bhi regular

regular:
ldr r0,=Prompt1
b next

lastone:
ldr r0,=Prompt2
b next

next:
bl printf
bl cr
bl getstring
mov r7,r0
bl value
bl cr
cmp r7,#0
blt negative
str r7,[r5],#4
sub r6,#1


b collect

negative:
ldr r0,=Prompt5
bl printf
bl cr
b collect


End:
str r4,[sp,#36]
POP {r7}
POP {r6}
POP {r5}
POP {r4}
POP {r3}
POP {r2}
POP {r1}
POP {r0}
POP {PC}

/*-------Code ends here ---------------------*/

/*-----------------DO NOT MODIFY--------*/
.data
/*--------------------------------------*/
WelcomeString:
.string "Welcome to Wing's Bubble Sort Program"
Prompt:
.string "Please enter the number(3min-10max) of enteries followed by `enter'"
Prompt1:
.string "Please enter a number(positive only) followed by `enter'"
Prompt2:
.string "Please enter the last number(positive only) followed by `enter'"
Prompt3:
.string "Invalid entry, Please enter more than 2 entry"
Prompt4:
.string "Too many entries"
Prompt5:
.string "Negative value entered, only postive ones accepted"

