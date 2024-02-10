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
/*Author - Wing Hoy. Last edited on Jan 14, 2022 */

/*--------------------------------------*/



/*-------Students write their code here ------------*/

.equ MemStart, 0x20001000

.equ MemEnd, 0x20003000

ldr r1,=MemStart

ldr r3,=MemEnd

mov r4,#70



Repeat:

ldr r2,[r1]

cmp r2,#0x60

bhi smallTest

cmp r2, #0x40

bhi capTest

b ErrorTest



capTest:

cmp r2,#0x5A

bhi ErrorTest

add r2,#0x20

str r2,[r3]

add r1,#0x4

add r3,#0x4

sub r4,#1

cmp r4,#0

beq END

B Repeat



smallTest:

cmp r2,#0x7A

bhi ErrorTest

sub r2,#0x20

str r2,[r3]

add r1,#0x4

add r3,#0x4

sub r4,#1

cmp r4,#0

beq END

B Repeat



ErrorTest:

mov r2,#0x2A

str r2,[r3]

add r1,#0x4

add r3,#0x4

sub r4,#1

cmp r4,#0

beq END

B Repeat



END:
/*-------Students write their code here ------------*/























/*-------Code ends here ---------------------*/

/*-----------------DO NOT MODIFY--------*/
POP {PC}

.data
/*--------------------------------------*/
