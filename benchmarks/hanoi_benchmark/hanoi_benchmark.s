	.arch armv7-a
	.comm	peg1,4,4
	.comm	peg2,4,4
	.comm	peg3,4,4
	.comm	numMoves,4,4

	.text
	.align 2
	.global move
move:
.LU1:
	push {fp, lr}
	add fp, sp, #4
	sub sp, sp, #12
	mov r3, r0
	mov r0, r1
	str r3, [sp, #0]
	str r0, [sp, #4]
	ldr r3, [sp, #0]
	mov r0, #0
	cmp r3, #1
	moveq r0, #1
	cmp r0, #1
	beq .LU2
	b .LU3
.LU2:
	movw r3, #:lower16:peg1
	movt r3, #:upper16:peg1
	ldr r3, [r3]
	str r3, [sp, #8]
	movw r3, #:lower16:peg1
	movt r3, #:upper16:peg1
	ldr r3, [r3]
	add r3, r3, #4
	ldr r3, [r3]
	movw r0, #:lower16:peg1
	movt r0, #:upper16:peg1
	str r3, [r0]
	b .LU4
.LU3:
	ldr r3, [sp, #0]
	mov r0, #0
	cmp r3, #2
	moveq r0, #1
	cmp r0, #1
	beq .LU11
	b .LU12
.LU11:
	movw r3, #:lower16:peg2
	movt r3, #:upper16:peg2
	ldr r3, [r3]
	str r3, [sp, #8]
	movw r3, #:lower16:peg2
	movt r3, #:upper16:peg2
	ldr r3, [r3]
	add r3, r3, #4
	ldr r0, [r3]
	movw r3, #:lower16:peg2
	movt r3, #:upper16:peg2
	str r0, [r3]
	b .LU13
.LU12:
	movw r3, #:lower16:peg3
	movt r3, #:upper16:peg3
	ldr r3, [r3]
	str r3, [sp, #8]
	movw r3, #:lower16:peg3
	movt r3, #:upper16:peg3
	ldr r3, [r3]
	add r3, r3, #4
	ldr r0, [r3]
	movw r3, #:lower16:peg3
	movt r3, #:upper16:peg3
	str r0, [r3]
	b .LU13
.LU13:
	b .LU4
.LU4:
	ldr r3, [sp, #4]
	mov r0, #0
	cmp r3, #1
	moveq r0, #1
	cmp r0, #1
	beq .LU5
	b .LU6
.LU5:
	movw r3, #:lower16:peg1
	movt r3, #:upper16:peg1
	ldr r0, [r3]
	ldr r3, [sp, #8]
	add r3, r3, #4
	str r0, [r3]
	ldr r0, [sp, #8]
	movw r3, #:lower16:peg1
	movt r3, #:upper16:peg1
	str r0, [r3]
	b .LU7
.LU6:
	ldr r0, [sp, #4]
	mov r3, #0
	cmp r0, #2
	moveq r3, #1
	cmp r3, #1
	beq .LU8
	b .LU9
.LU8:
	movw r3, #:lower16:peg2
	movt r3, #:upper16:peg2
	ldr r0, [r3]
	ldr r3, [sp, #8]
	add r3, r3, #4
	str r0, [r3]
	ldr r3, [sp, #8]
	movw r0, #:lower16:peg2
	movt r0, #:upper16:peg2
	str r3, [r0]
	b .LU10
.LU9:
	movw r3, #:lower16:peg3
	movt r3, #:upper16:peg3
	ldr r3, [r3]
	ldr r0, [sp, #8]
	add r0, r0, #4
	str r3, [r0]
	ldr r3, [sp, #8]
	movw r0, #:lower16:peg3
	movt r0, #:upper16:peg3
	str r3, [r0]
	b .LU10
.LU10:
	b .LU7
.LU7:
	movw r3, #:lower16:numMoves
	movt r3, #:upper16:numMoves
	ldr r3, [r3]
	add r3, r3, #1
	movw r0, #:lower16:numMoves
	movt r0, #:upper16:numMoves
	str r3, [r0]
	b .LU0
.LU0:
	add sp, sp, #12
	pop {fp, pc}
	.size move, .-move
	.align 2
	.global hanoi
hanoi:
.LU15:
	push {fp, lr}
	add fp, sp, #4
	sub sp, sp, #16
	str r0, [sp, #0]
	str r1, [sp, #4]
	str r2, [sp, #8]
	str r3, [sp, #12]
	ldr r3, [sp, #0]
	mov r2, #0
	cmp r3, #1
	moveq r2, #1
	cmp r2, #1
	beq .LU16
	b .LU17
.LU16:
	ldr r2, [sp, #4]
	ldr r3, [sp, #8]
	mov r1, r3
	mov r0, r2
	bl move
	b .LU18
.LU17:
	ldr r2, [sp, #0]
	sub r0, r2, #1
	ldr r1, [sp, #4]
	ldr r2, [sp, #12]
	ldr r3, [sp, #8]
	bl hanoi
	ldr r2, [sp, #4]
	ldr r3, [sp, #8]
	mov r1, r3
	mov r0, r2
	bl move
	ldr r2, [sp, #0]
	sub r0, r2, #1
	ldr r1, [sp, #12]
	ldr r2, [sp, #8]
	ldr r3, [sp, #4]
	bl hanoi
	b .LU18
.LU18:
	b .LU14
.LU14:
	add sp, sp, #16
	pop {fp, pc}
	.size hanoi, .-hanoi
	.align 2
	.global printPeg
printPeg:
.LU20:
	push {fp, lr}
	add fp, sp, #4
	sub sp, sp, #8
	mov r2, r0
	str r2, [sp, #0]
	ldr r2, [sp, #0]
	str r2, [sp, #4]
	ldr r2, [sp, #4]
	mov r0, #0
	cmp r2, #0
	movne r0, #1
	cmp r0, #1
	beq .LU21
	b .LU22
.LU21:
	ldr r2, [sp, #4]
	ldr r2, [r2]
	mov r1, r2
	movw r0, #:lower16:.PRINTLN_FMT
	movt r0, #:upper16:.PRINTLN_FMT
	bl printf
	ldr r2, [sp, #4]
	add r2, r2, #4
	ldr r2, [r2]
	str r2, [sp, #4]
	ldr r0, [sp, #4]
	mov r2, #0
	cmp r0, #0
	movne r2, #1
	cmp r2, #1
	beq .LU21
	b .LU22
.LU22:
	b .LU19
.LU19:
	add sp, sp, #8
	pop {fp, pc}
	.size printPeg, .-printPeg
	.align 2
	.global main
main:
.LU24:
	push {fp, lr}
	add fp, sp, #4
	sub sp, sp, #16
	movw r3, #0
	movw r2, #:lower16:peg1
	movt r2, #:upper16:peg1
	str r3, [r2]
	movw r2, #0
	movw r3, #:lower16:peg2
	movt r3, #:upper16:peg2
	str r2, [r3]
	movw r3, #0
	movw r2, #:lower16:peg3
	movt r2, #:upper16:peg3
	str r3, [r2]
	movw r3, #0
	movw r2, #:lower16:numMoves
	movt r2, #:upper16:numMoves
	str r3, [r2]
	add r1, sp, #8
	movw r0, #:lower16:.READ_FMT
	movt r0, #:upper16:.READ_FMT
	bl scanf
	ldr r3, [sp, #8]
	mov r2, #0
	cmp r3, #1
	movge r2, #1
	cmp r2, #1
	beq .LU25
	b .LU26
.LU25:
	ldr r2, [sp, #8]
	str r2, [sp, #4]
	ldr r3, [sp, #4]
	mov r2, #0
	cmp r3, #0
	movne r2, #1
	cmp r2, #1
	beq .LU27
	b .LU28
.LU27:
	movw r0, #8
	bl malloc
	mov r2, r0
	str r2, [sp, #12]
	ldr r3, [sp, #4]
	ldr r2, [sp, #12]
	str r3, [r2]
	movw r2, #:lower16:peg1
	movt r2, #:upper16:peg1
	ldr r3, [r2]
	ldr r2, [sp, #12]
	add r2, r2, #4
	str r3, [r2]
	ldr r2, [sp, #12]
	movw r3, #:lower16:peg1
	movt r3, #:upper16:peg1
	str r2, [r3]
	ldr r2, [sp, #4]
	sub r2, r2, #1
	str r2, [sp, #4]
	ldr r2, [sp, #4]
	mov r3, #0
	cmp r2, #0
	movne r3, #1
	cmp r3, #1
	beq .LU27
	b .LU28
.LU28:
	movw r1, #1
	movw r0, #:lower16:.PRINTLN_FMT
	movt r0, #:upper16:.PRINTLN_FMT
	bl printf
	movw r2, #:lower16:peg1
	movt r2, #:upper16:peg1
	ldr r2, [r2]
	mov r0, r2
	bl printPeg
	movw r1, #2
	movw r0, #:lower16:.PRINTLN_FMT
	movt r0, #:upper16:.PRINTLN_FMT
	bl printf
	movw r2, #:lower16:peg2
	movt r2, #:upper16:peg2
	ldr r2, [r2]
	mov r0, r2
	bl printPeg
	movw r1, #3
	movw r0, #:lower16:.PRINTLN_FMT
	movt r0, #:upper16:.PRINTLN_FMT
	bl printf
	movw r2, #:lower16:peg3
	movt r2, #:upper16:peg3
	ldr r2, [r2]
	mov r0, r2
	bl printPeg
	ldr r0, [sp, #8]
	movw r3, #2
	movw r2, #3
	movw r1, #1
	bl hanoi
	movw r1, #1
	movw r0, #:lower16:.PRINTLN_FMT
	movt r0, #:upper16:.PRINTLN_FMT
	bl printf
	movw r2, #:lower16:peg1
	movt r2, #:upper16:peg1
	ldr r2, [r2]
	mov r0, r2
	bl printPeg
	movw r1, #2
	movw r0, #:lower16:.PRINTLN_FMT
	movt r0, #:upper16:.PRINTLN_FMT
	bl printf
	movw r2, #:lower16:peg2
	movt r2, #:upper16:peg2
	ldr r2, [r2]
	mov r0, r2
	bl printPeg
	movw r1, #3
	movw r0, #:lower16:.PRINTLN_FMT
	movt r0, #:upper16:.PRINTLN_FMT
	bl printf
	movw r2, #:lower16:peg3
	movt r2, #:upper16:peg3
	ldr r2, [r2]
	mov r0, r2
	bl printPeg
	movw r2, #:lower16:numMoves
	movt r2, #:upper16:numMoves
	ldr r2, [r2]
	mov r1, r2
	movw r0, #:lower16:.PRINTLN_FMT
	movt r0, #:upper16:.PRINTLN_FMT
	bl printf
	movw r2, #:lower16:peg3
	movt r2, #:upper16:peg3
	ldr r2, [r2]
	mov r3, #0
	cmp r2, #0
	movne r3, #1
	cmp r3, #1
	beq .LU29
	b .LU30
.LU29:
	movw r2, #:lower16:peg3
	movt r2, #:upper16:peg3
	ldr r2, [r2]
	str r2, [sp, #12]
	movw r2, #:lower16:peg3
	movt r2, #:upper16:peg3
	ldr r2, [r2]
	add r2, r2, #4
	ldr r2, [r2]
	movw r3, #:lower16:peg3
	movt r3, #:upper16:peg3
	str r2, [r3]
	ldr r2, [sp, #12]
	mov r0, r2
	bl free
	movw r2, #:lower16:peg3
	movt r2, #:upper16:peg3
	ldr r2, [r2]
	mov r3, #0
	cmp r2, #0
	movne r3, #1
	cmp r3, #1
	beq .LU29
	b .LU30
.LU30:
	b .LU26
.LU26:
	movw r2, #0
	str r2, [sp, #0]
	b .LU23
.LU23:
	ldr r2, [sp, #0]
	mov r0, r2
	add sp, sp, #16
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
