	.arch armv7-a
	.comm	.read_scratch,4,4
	.comm	globalfoo,4,4

	.text
	.align 2
	.global tailrecursive
tailrecursive:
.LU1:
	push {fp, lr}
	add fp, sp, #4
	mov r3, r0
	mov r2, #0
	cmp r3, #0
	movle r2, #1
	cmp r2, #1
	beq .LU2
	b .LU3
.LU2:
	b .LU0
.LU3:
	b .LU4
.LU4:
	sub r2, r3, #1
	mov r0, r2
	bl tailrecursive
	b .LU0
.LU0:
	pop {fp, pc}
	.size tailrecursive, .-tailrecursive
	.align 2
	.global add
add:
.LU6:
	push {fp, lr}
	add fp, sp, #4
	mov r2, r0
	mov r0, r1
	add r2, r2, r0
	b .LU5
.LU5:
	mov r0, r2
	pop {fp, pc}
	.size add, .-add
	.align 2
	.global domath
domath:
.LU8:
	push {fp, lr}
	add fp, sp, #4
	push {r4, r5, r6}
	mov r4, r0
	movw r0, #12
	bl malloc
	mov r2, r0
	mov r6, r2
	movw r0, #4
	bl malloc
	mov r2, r0
	add r5, r6, #8
	str r2, [r5]
	movw r0, #12
	bl malloc
	mov r2, r0
	mov r5, r2
	movw r0, #4
	bl malloc
	mov r2, r0
	mov r1, r2
	add r2, r5, #8
	str r1, [r2]
	mov r2, r6
	str r4, [r2]
	mov r2, r5
	movw r1, #3
	str r1, [r2]
	mov r2, r6
	ldr r1, [r2]
	add r2, r6, #8
	ldr r2, [r2]
	str r1, [r2]
	mov r2, r5
	ldr r1, [r2]
	add r2, r5, #8
	ldr r2, [r2]
	str r1, [r2]
	mov r0, #0
	cmp r4, #0
	movgt r0, #1
	mov r1, r6
	mov r2, r5
	mov r3, r6
	cmp r0, #1
	beq .LU9
	b .LU10
.LU9:
	mov r6, r4
	mov r4, r3
	add r2, r5, #8
	ldr r2, [r2]
	ldr r2, [r2]
	mov r1, r4
	ldr r1, [r1]
	mov r0, r2
	bl add
	sub r6, r6, #1
	mov r0, #0
	cmp r6, #0
	movgt r0, #1
	mov r1, r4
	mov r2, r5
	mov r3, r4
	mov r4, r6
	cmp r0, #1
	beq .LU9
	b .LU10
.LU10:
	mov r4, r2
	mov r2, r1
	mov r0, r2
	bl free
	mov r0, r4
	bl free
	b .LU7
.LU7:
	pop {r4, r5, r6}
	pop {fp, pc}
	.size domath, .-domath
	.align 2
	.global objinstantiation
objinstantiation:
.LU12:
	push {fp, lr}
	add fp, sp, #4
	push {r4}
	mov r2, r0
	mov r4, #0
	cmp r2, #0
	movgt r4, #1
	cmp r4, #1
	beq .LU13
	b .LU14
.LU13:
	mov r4, r2
	movw r0, #12
	bl malloc
	mov r2, r0
	mov r0, r2
	bl free
	sub r2, r4, #1
	mov r4, #0
	cmp r2, #0
	movgt r4, #1
	cmp r4, #1
	beq .LU13
	b .LU14
.LU14:
	b .LU11
.LU11:
	pop {r4}
	pop {fp, pc}
	.size objinstantiation, .-objinstantiation
	.align 2
	.global ackermann
ackermann:
.LU16:
	push {fp, lr}
	add fp, sp, #4
	push {r4}
	mov r3, r0
	mov r0, r1
	mov r2, #0
	cmp r3, #0
	moveq r2, #1
	cmp r2, #1
	beq .LU17
	b .LU18
.LU17:
	add r3, r0, #1
	b .LU15
.LU18:
	b .LU19
.LU19:
	mov r2, #0
	cmp r0, #0
	moveq r2, #1
	cmp r2, #1
	beq .LU20
	b .LU21
.LU20:
	sub r3, r3, #1
	movw r1, #1
	mov r0, r3
	bl ackermann
	mov r3, r0
	b .LU15
.LU21:
	sub r4, r3, #1
	sub r0, r0, #1
	mov r1, r0
	mov r0, r3
	bl ackermann
	mov r3, r0
	mov r1, r3
	mov r0, r4
	bl ackermann
	mov r3, r0
	b .LU15
.LU15:
	mov r0, r3
	pop {r4}
	pop {fp, pc}
	.size ackermann, .-ackermann
	.align 2
	.global main
main:
.LU24:
	push {fp, lr}
	add fp, sp, #4
	push {r4, r5, r6, r7, r8}
	movw r1, #:lower16:.read_scratch
	movt r1, #:upper16:.read_scratch
	movw r0, #:lower16:.READ_FMT
	movt r0, #:upper16:.READ_FMT
	bl scanf
	movw r0, #:lower16:.read_scratch
	movt r0, #:upper16:.read_scratch
	ldr r5, [r0]
	movw r1, #:lower16:.read_scratch
	movt r1, #:upper16:.read_scratch
	movw r0, #:lower16:.READ_FMT
	movt r0, #:upper16:.READ_FMT
	bl scanf
	movw r0, #:lower16:.read_scratch
	movt r0, #:upper16:.read_scratch
	ldr r8, [r0]
	movw r1, #:lower16:.read_scratch
	movt r1, #:upper16:.read_scratch
	movw r0, #:lower16:.READ_FMT
	movt r0, #:upper16:.READ_FMT
	bl scanf
	movw r0, #:lower16:.read_scratch
	movt r0, #:upper16:.read_scratch
	ldr r4, [r0]
	movw r1, #:lower16:.read_scratch
	movt r1, #:upper16:.read_scratch
	movw r0, #:lower16:.READ_FMT
	movt r0, #:upper16:.READ_FMT
	bl scanf
	movw r0, #:lower16:.read_scratch
	movt r0, #:upper16:.read_scratch
	ldr r6, [r0]
	movw r1, #:lower16:.read_scratch
	movt r1, #:upper16:.read_scratch
	movw r0, #:lower16:.READ_FMT
	movt r0, #:upper16:.READ_FMT
	bl scanf
	movw r0, #:lower16:.read_scratch
	movt r0, #:upper16:.read_scratch
	ldr r7, [r0]
	mov r0, r5
	bl tailrecursive
	mov r1, r5
	movw r0, #:lower16:.PRINTLN_FMT
	movt r0, #:upper16:.PRINTLN_FMT
	bl printf
	mov r0, r8
	bl domath
	mov r1, r8
	movw r0, #:lower16:.PRINTLN_FMT
	movt r0, #:upper16:.PRINTLN_FMT
	bl printf
	mov r0, r4
	bl objinstantiation
	mov r1, r4
	movw r0, #:lower16:.PRINTLN_FMT
	movt r0, #:upper16:.PRINTLN_FMT
	bl printf
	mov r1, r7
	mov r0, r6
	bl ackermann
	mov r1, r0
	movw r0, #:lower16:.PRINTLN_FMT
	movt r0, #:upper16:.PRINTLN_FMT
	bl printf
	b .LU23
.LU23:
	movw r0, #0
	pop {r4, r5, r6, r7, r8}
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
