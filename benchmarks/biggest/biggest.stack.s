	.arch armv7-a


	.text
	.align 2
	.global getIntList
getIntList:
.LU1:
	push {fp, lr}
	add fp, sp, #4
	sub sp, sp, #12
	movw r0, #8
	bl malloc
	mov r1, r0
	str r1, [sp, #4]
	add r1, sp, #8
	movw r0, #:lower16:.READ_FMT
	movt r0, #:upper16:.READ_FMT
	bl scanf
	ldr r1, [sp, #8]
	movw r2, #0
	sub r2, r2, #1
	mov r0, #0
	cmp r1, r2
	moveq r0, #1
	cmp r0, #1
	beq .LU2
	b .LU3
.LU2:
	ldr r1, [sp, #8]
	ldr r2, [sp, #4]
	str r1, [r2]
	ldr r1, [sp, #4]
	add r1, r1, #4
	movw r2, #0
	str r2, [r1]
	ldr r1, [sp, #4]
	str r1, [sp, #0]
	b .LU0
.LU3:
	ldr r1, [sp, #8]
	ldr r2, [sp, #4]
	str r1, [r2]
	bl getIntList
	mov r1, r0
	ldr r2, [sp, #4]
	add r2, r2, #4
	str r1, [r2]
	ldr r1, [sp, #4]
	str r1, [sp, #0]
	b .LU0
.LU4:
	b .LU0
.LU0:
	ldr r1, [sp, #0]
	mov r0, r1
	add sp, sp, #12
	pop {fp, pc}
	.size getIntList, .-getIntList
	.align 2
	.global biggest
biggest:
.LU6:
	push {fp, lr}
	add fp, sp, #4
	sub sp, sp, #12
	str r0, [sp, #0]
	str r1, [sp, #4]
	ldr r0, [sp, #0]
	ldr r1, [sp, #4]
	mov r2, #0
	cmp r0, r1
	movgt r2, #1
	cmp r2, #1
	beq .LU7
	b .LU8
.LU7:
	ldr r1, [sp, #0]
	str r1, [sp, #8]
	b .LU5
.LU8:
	ldr r1, [sp, #4]
	str r1, [sp, #8]
	b .LU5
.LU9:
	b .LU5
.LU5:
	ldr r1, [sp, #8]
	mov r0, r1
	add sp, sp, #12
	pop {fp, pc}
	.size biggest, .-biggest
	.align 2
	.global biggestInList
biggestInList:
.LU11:
	push {fp, lr}
	add fp, sp, #4
	sub sp, sp, #12
	mov r1, r0
	str r1, [sp, #0]
	ldr r1, [sp, #0]
	ldr r1, [r1]
	str r1, [sp, #8]
	ldr r1, [sp, #0]
	add r1, r1, #4
	ldr r1, [r1]
	mov r2, #0
	cmp r1, #0
	movne r2, #1
	cmp r2, #1
	beq .LU12
	b .LU13
.LU12:
	ldr r2, [sp, #8]
	ldr r1, [sp, #0]
	ldr r1, [r1]
	mov r0, r2
	bl biggest
	mov r1, r0
	str r1, [sp, #8]
	ldr r1, [sp, #0]
	add r1, r1, #4
	ldr r1, [r1]
	str r1, [sp, #0]
	ldr r1, [sp, #0]
	add r1, r1, #4
	ldr r2, [r1]
	mov r1, #0
	cmp r2, #0
	movne r1, #1
	cmp r1, #1
	beq .LU12
	b .LU13
.LU13:
	ldr r1, [sp, #8]
	str r1, [sp, #4]
	b .LU10
.LU10:
	ldr r1, [sp, #4]
	mov r0, r1
	add sp, sp, #12
	pop {fp, pc}
	.size biggestInList, .-biggestInList
	.align 2
	.global main
main:
.LU15:
	push {fp, lr}
	add fp, sp, #4
	sub sp, sp, #8
	bl getIntList
	str r0, [sp, #4]
	ldr r0, [sp, #4]
	bl biggestInList
	mov r1, r0
	movw r0, #:lower16:.PRINTLN_FMT
	movt r0, #:upper16:.PRINTLN_FMT
	bl printf
	movw r0, #0
	str r0, [sp, #0]
	b .LU14
.LU14:
	ldr r0, [sp, #0]
	add sp, sp, #8
	pop {fp, pc}
	.size main, .-main
	.section	.rodata
	.align	2
.PRINTLN_FMT:
	.asciz	"%ld\n"
	.align	2
.PRINT_FMT:
	.asciz	"%ld "
	.align	2
.READ_FMT:
	.asciz	"%ld"
	.global	__aeabi_idiv
