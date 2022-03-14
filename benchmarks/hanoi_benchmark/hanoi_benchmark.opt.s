	.arch armv7-a
	.comm	.read_scratch,4,4
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
	mov r2, r0
	mov r0, #0
	cmp r2, #1
	moveq r0, #1
	cmp r0, #1
	beq .LU2
	b .LU3
.LU2:
	movw r2, #:lower16:peg1
	movt r2, #:upper16:peg1
	ldr r2, [r2]
	movw r0, #:lower16:peg1
	movt r0, #:upper16:peg1
	ldr r0, [r0]
	add r0, r0, #4
	ldr r3, [r0]
	movw r0, #:lower16:peg1
	movt r0, #:upper16:peg1
	str r3, [r0]
	mov r0, r1
	mov r1, r2
	b .LU4
.LU3:
	mov r0, #0
	cmp r2, #2
	moveq r0, #1
	cmp r0, #1
	beq .LU5
	b .LU6
.LU5:
	movw r2, #:lower16:peg2
	movt r2, #:upper16:peg2
	ldr r2, [r2]
	movw r0, #:lower16:peg2
	movt r0, #:upper16:peg2
	ldr r0, [r0]
	add r0, r0, #4
	ldr r3, [r0]
	movw r0, #:lower16:peg2
	movt r0, #:upper16:peg2
	str r3, [r0]
	mov r0, r1
	mov r1, r2
	b .LU7
.LU6:
	movw r2, #:lower16:peg3
	movt r2, #:upper16:peg3
	ldr r2, [r2]
	movw r0, #:lower16:peg3
	movt r0, #:upper16:peg3
	ldr r0, [r0]
	add r0, r0, #4
	ldr r3, [r0]
	movw r0, #:lower16:peg3
	movt r0, #:upper16:peg3
	str r3, [r0]
	mov r0, r1
	mov r1, r2
	b .LU7
.LU7:
	mov r2, r0
	mov r0, r2
	b .LU4
.LU4:
	mov r2, r0
	mov r0, #0
	cmp r2, #1
	moveq r0, #1
	cmp r0, #1
	beq .LU8
	b .LU9
.LU8:
	movw r2, #:lower16:peg1
	movt r2, #:upper16:peg1
	ldr r2, [r2]
	add r0, r1, #4
	str r2, [r0]
	movw r2, #:lower16:peg1
	movt r2, #:upper16:peg1
	str r1, [r2]
	b .LU10
.LU9:
	mov r0, #0
	cmp r2, #2
	moveq r0, #1
	cmp r0, #1
	beq .LU11
	b .LU12
.LU11:
	movw r2, #:lower16:peg2
	movt r2, #:upper16:peg2
	ldr r0, [r2]
	add r2, r1, #4
	str r0, [r2]
	movw r2, #:lower16:peg2
	movt r2, #:upper16:peg2
	str r1, [r2]
	b .LU13
.LU12:
	movw r2, #:lower16:peg3
	movt r2, #:upper16:peg3
	ldr r0, [r2]
	add r2, r1, #4
	str r0, [r2]
	movw r2, #:lower16:peg3
	movt r2, #:upper16:peg3
	str r1, [r2]
	b .LU13
.LU13:
	b .LU10
.LU10:
	movw r1, #:lower16:numMoves
	movt r1, #:upper16:numMoves
	ldr r1, [r1]
	add r1, r1, #1
	movw r2, #:lower16:numMoves
	movt r2, #:upper16:numMoves
	str r1, [r2]
	pop {fp, pc}
	.size move, .-move
	.align 2
	.global hanoi
hanoi:
.LU15:
	push {fp, lr}
	add fp, sp, #4
	push {r4, r5, r6, r7}
	mov r7, r0
	mov r4, r1
	mov r5, r2
	mov r6, r3
	mov r1, #0
	cmp r7, #1
	moveq r1, #1
	cmp r1, #1
	beq .LU16
	b .LU17
.LU16:
	mov r1, r5
	mov r0, r4
	bl move
	b .LU18
.LU17:
	sub r0, r7, #1
	mov r3, r5
	mov r2, r6
	mov r1, r4
	bl hanoi
	mov r1, r5
	mov r0, r4
	bl move
	sub r7, r7, #1
	mov r3, r4
	mov r2, r5
	mov r1, r6
	mov r0, r7
	bl hanoi
	b .LU18
.LU18:
	pop {r4, r5, r6, r7}
	pop {fp, pc}
	.size hanoi, .-hanoi
	.align 2
	.global printPeg
printPeg:
.LU20:
	push {fp, lr}
	add fp, sp, #4
	push {r4}
	mov r4, #0
	cmp r0, #0
	movne r4, #1
	cmp r4, #1
	beq .LU21
	b .LU22
.LU21:
	mov r4, r0
	mov r0, r4
	ldr r0, [r0]
	mov r1, r0
	movw r0, #:lower16:.PRINTLN_FMT
	movt r0, #:upper16:.PRINTLN_FMT
	bl printf
	add r4, r4, #4
	ldr r0, [r4]
	mov r4, #0
	cmp r0, #0
	movne r4, #1
	cmp r4, #1
	beq .LU21
	b .LU22
.LU22:
	pop {r4}
	pop {fp, pc}
	.size printPeg, .-printPeg
	.align 2
	.global main
main:
.LU24:
	push {fp, lr}
	add fp, sp, #4
	push {r4, r5}
	movw r5, #0
	movw r4, #:lower16:peg1
	movt r4, #:upper16:peg1
	str r5, [r4]
	movw r5, #0
	movw r4, #:lower16:peg2
	movt r4, #:upper16:peg2
	str r5, [r4]
	movw r5, #0
	movw r4, #:lower16:peg3
	movt r4, #:upper16:peg3
	str r5, [r4]
	movw r5, #0
	movw r4, #:lower16:numMoves
	movt r4, #:upper16:numMoves
	str r5, [r4]
	movw r1, #:lower16:.read_scratch
	movt r1, #:upper16:.read_scratch
	movw r0, #:lower16:.READ_FMT
	movt r0, #:upper16:.READ_FMT
	bl scanf
	movw r4, #:lower16:.read_scratch
	movt r4, #:upper16:.read_scratch
	ldr r4, [r4]
	mov r5, #0
	cmp r4, #1
	movge r5, #1
	cmp r5, #1
	beq .LU25
	b .LU26
.LU25:
	mov r2, #0
	cmp r4, #0
	movne r2, #1
	mov r5, r4
	mov r1, r4
	cmp r2, #1
	beq .LU28
	b .LU29
.LU28:
	mov r5, r1
	movw r0, #8
	bl malloc
	mov r1, r0
	mov r2, r1
	str r5, [r2]
	movw r2, #:lower16:peg1
	movt r2, #:upper16:peg1
	ldr r2, [r2]
	add r0, r1, #4
	str r2, [r0]
	movw r2, #:lower16:peg1
	movt r2, #:upper16:peg1
	str r1, [r2]
	sub r1, r5, #1
	mov r2, #0
	cmp r1, #0
	movne r2, #1
	mov r5, r4
	cmp r2, #1
	beq .LU28
	b .LU29
.LU29:
	mov r4, r5
	movw r1, #1
	movw r0, #:lower16:.PRINTLN_FMT
	movt r0, #:upper16:.PRINTLN_FMT
	bl printf
	movw r5, #:lower16:peg1
	movt r5, #:upper16:peg1
	ldr r5, [r5]
	mov r0, r5
	bl printPeg
	movw r1, #2
	movw r0, #:lower16:.PRINTLN_FMT
	movt r0, #:upper16:.PRINTLN_FMT
	bl printf
	movw r5, #:lower16:peg2
	movt r5, #:upper16:peg2
	ldr r5, [r5]
	mov r0, r5
	bl printPeg
	movw r1, #3
	movw r0, #:lower16:.PRINTLN_FMT
	movt r0, #:upper16:.PRINTLN_FMT
	bl printf
	movw r5, #:lower16:peg3
	movt r5, #:upper16:peg3
	ldr r5, [r5]
	mov r0, r5
	bl printPeg
	movw r3, #2
	movw r2, #3
	movw r1, #1
	mov r0, r4
	bl hanoi
	movw r1, #1
	movw r0, #:lower16:.PRINTLN_FMT
	movt r0, #:upper16:.PRINTLN_FMT
	bl printf
	movw r4, #:lower16:peg1
	movt r4, #:upper16:peg1
	ldr r4, [r4]
	mov r0, r4
	bl printPeg
	movw r1, #2
	movw r0, #:lower16:.PRINTLN_FMT
	movt r0, #:upper16:.PRINTLN_FMT
	bl printf
	movw r4, #:lower16:peg2
	movt r4, #:upper16:peg2
	ldr r4, [r4]
	mov r0, r4
	bl printPeg
	movw r1, #3
	movw r0, #:lower16:.PRINTLN_FMT
	movt r0, #:upper16:.PRINTLN_FMT
	bl printf
	movw r4, #:lower16:peg3
	movt r4, #:upper16:peg3
	ldr r4, [r4]
	mov r0, r4
	bl printPeg
	movw r4, #:lower16:numMoves
	movt r4, #:upper16:numMoves
	ldr r4, [r4]
	mov r1, r4
	movw r0, #:lower16:.PRINTLN_FMT
	movt r0, #:upper16:.PRINTLN_FMT
	bl printf
	movw r4, #:lower16:peg3
	movt r4, #:upper16:peg3
	ldr r5, [r4]
	mov r4, #0
	cmp r5, #0
	movne r4, #1
	cmp r4, #1
	beq .LU30
	b .LU31
.LU30:
	movw r4, #:lower16:peg3
	movt r4, #:upper16:peg3
	ldr r4, [r4]
	movw r5, #:lower16:peg3
	movt r5, #:upper16:peg3
	ldr r5, [r5]
	add r5, r5, #4
	ldr r5, [r5]
	movw r1, #:lower16:peg3
	movt r1, #:upper16:peg3
	str r5, [r1]
	mov r0, r4
	bl free
	movw r4, #:lower16:peg3
	movt r4, #:upper16:peg3
	ldr r5, [r4]
	mov r4, #0
	cmp r5, #0
	movne r4, #1
	cmp r4, #1
	beq .LU30
	b .LU31
.LU31:
	b .LU27
.LU26:
	b .LU27
.LU27:
	movw r0, #0
	pop {r4, r5}
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
