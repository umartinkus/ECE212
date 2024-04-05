/*Author - Wing Hoy. Last edited on Mar 22, 2022 */
/*-----------------DO NOT MODIFY--------*/
.global Display
.global printf
.global cr
.extern value
.extern getstring
.extern offled()
.extern onled()
.extern column()
.extern Column()
.extern row()
.extern Row()
.syntax unified

.text
Display:
/*--------------------------------------*/

/*-------Students write their code here ------------*/

push {lr}
push {r1}
push {r2}
push {r3}
push {r4}
push {r5}
push {r6}
push {r7}

ldr r7, [sp,#32]
mov r6, #0

Outerloop:
mov r1, #7 //column
mov r2, #0 //row
mov r3, #0 //delay
mov r5, #0 //address offset
mov r0, #0
add r6, #1
cmp r6, #100
bne Innerloop
b END

Innerloop:
ldr r4, [r7, r5]

next_bit:
LSRS r4, #1
sub r1, #1
BCS led_on
cmp r1, #0
blt row_next
b next_bit

led_on:
mov r0, r1
push {r0-r7}
bl column
pop {r0-r7}
mov r0, r2
push {r0-r7}
bl row
pop {r0-r7}
push {r0-r7}
bl onled
pop {r0-r7}
mov r0, r3
push {r0-r7}
bl HAL_Delay
pop {r0-r7}
push {r0-r7}
bl offled
pop {r0-r7}
b next_bit


row_next:
mov r1, #7
add r2, #1
cmp r2, #4
beq offset_increment
cmp r2, #8
beq Outerloop
b next_bit


offset_increment:
add r5, #4
b Innerloop

END:

pop {r7}
pop {r6}
pop {r5}
pop {r4}
pop {r3}
pop {r2}
pop {r1}
pop {PC}
/*-------Code ends here ---------------------*/

/*-----------------DO NOT MODIFY--------*/
.data
/*--------------------------------------*/

