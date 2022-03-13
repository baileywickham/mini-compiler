	.arch armv7-a
	.comm	.read_scratch,4,4

	.text
	.align 2
	.global getIntList
getIntList:
.LU1:
	push {fp, lr}
	add fp, sp, #4
	push {r4}
	movw r0, #8
	bl malloc
	mov r4, r0
	movw r1, #:lower16:.read_scratch
	movt r1, #:upper16:.read_scratch
	movw r0, #:lower16:.READ_FMT
	movt r0, #:upper16:.READ_FMT
	bl scanf
	movw r1, #:lower16:.read_scratch
	movt r1, #:upper16:.read_scratch
	ldr r1, [r1]
	movw r2, #0
	sub r2, r2, #1
	mov r0, #0
	cmp r1, r2
	moveq r0, #1
	cmp r0, #1
	beq .LU2
	b .LU3
.LU2:
	mov r2, r4
	str r1, [r2]
	add r1, r4, #4
	movw r2, #0
	str r2, [r1]
	b .LU0
.LU3:
	mov r2, r4
	str r1, [r2]
	bl getIntList
	mov r1, r0
	add r2, r4, #4
	str r1, [r2]
	b .LU0
.LU0:
	mov r0, r4
	pop {r4}
	pop {fp, pc}
	.size getIntList, .-getIntList
	.align 2
	.global biggest
biggest:
.LU6:
	push {fp, lr}
	add fp, sp, #4
	mov r2, r1
	mov r1, #0
	cmp r0, r2
	movgt r1, #1
	cmp r1, #1
	beq .LU7
	b .LU8
.LU7:
	mov r1, r0
	b .LU5
.LU8:
	mov r1, r2
	b .LU5
.LU5:
	mov r0, r1
	pop {fp, pc}
	.size biggest, .-biggest
	.align 2
	.global biggestInList
biggestInList:
.LU11:
	push {fp, lr}
	add fp, sp, #4
	push {r4}
	mov r1, r0
	mov r4, r1
	ldr r0, [r4]
	add r4, r1, #4
	ldr r4, [r4]
	mov r2, #0
	cmp r4, #0
	movne r2, #1
	mov r4, r0
	mov r3, r0
	mov r0, r1
	cmp r2, #1
	beq .LU12
	b .LU13
.LU12:
	mov r4, r0
	mov r2, r3
	mov r1, r4
	ldr r1, [r1]
	mov r0, r2
	bl biggest
	mov r2, r0
	add r4, r4, #4
	ldr r0, [r4]
	add r4, r0, #4
	ldr r4, [r4]
	mov r1, #0
	cmp r4, #0
	movne r1, #1
	mov r4, r2
	mov r3, r2
	cmp r1, #1
	beq .LU12
	b .LU13
.LU13:
	b .LU10
.LU10:
	mov r0, r4
	pop {r4}
	pop {fp, pc}
	.size biggestInList, .-biggestInList
	.align 2
	.global main
main:
.LU15:
	push {fp, lr}
	add fp, sp, #4
	bl getIntList
	mov r2, r0
	mov r0, r2
	bl biggestInList
	mov r2, r0
	mov r1, r2
	movw r0, #:lower16:.PRINTLN_FMT
	movt r0, #:upper16:.PRINTLN_FMT
	bl printf
	b .LU14
.LU14:
	movw r0, #0
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
