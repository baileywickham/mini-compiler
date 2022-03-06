	.arch armv7-a
	.comm	globalfoo,4,4

	.text
	.align 2
	.global tailrecursive
tailrecursive:
.LU1:
	push {fp, lr}
	add fp, sp, #4
	sub sp, sp, #4
	mov r2, r0
	str r2, [sp, #0]
	ldr r2, [sp, #0]
	mov r3, #0
	cmp r2, #0
	movle r3, #1
	cmp r3, #1
	beq .LU2
	b .LU3
.LU2:
	b .LU0
.LU3:
	ldr r2, [sp, #0]
	sub r2, r2, #1
	mov r0, r2
	bl tailrecursive
	b .LU0
.LU0:
	add sp, sp, #4
	pop {fp, pc}
	.size tailrecursive, .-tailrecursive
	.align 2
	.global add
add:
.LU5:
	push {fp, lr}
	add fp, sp, #4
	sub sp, sp, #12
	mov r3, r0
	mov r0, r1
	str r3, [sp, #0]
	str r0, [sp, #4]
	ldr r3, [sp, #0]
	ldr r0, [sp, #4]
	add r3, r3, r0
	str r3, [sp, #8]
	b .LU4
.LU4:
	ldr r3, [sp, #8]
	mov r0, r3
	add sp, sp, #12
	pop {fp, pc}
	.size add, .-add
	.align 2
	.global domath
domath:
.LU7:
	push {fp, lr}
	add fp, sp, #4
	sub sp, sp, #16
	mov r3, r0
	str r3, [sp, #0]
	movw r0, #12
	bl malloc
	mov r3, r0
	str r3, [sp, #4]
	movw r0, #4
	bl malloc
	mov r3, r0
	mov r0, r3
	ldr r3, [sp, #4]
	add r3, r3, #8
	str r0, [r3]
	movw r0, #12
	bl malloc
	mov r3, r0
	str r3, [sp, #8]
	movw r0, #4
	bl malloc
	mov r3, r0
	mov r0, r3
	ldr r3, [sp, #8]
	add r3, r3, #8
	str r0, [r3]
	ldr r3, [sp, #0]
	ldr r0, [sp, #4]
	str r3, [r0]
	ldr r3, [sp, #8]
	mov r0, r3
	movw r3, #3
	str r3, [r0]
	ldr r3, [sp, #4]
	ldr r0, [r3]
	ldr r3, [sp, #4]
	add r3, r3, #8
	ldr r3, [r3]
	str r0, [r3]
	ldr r3, [sp, #8]
	ldr r0, [r3]
	ldr r3, [sp, #8]
	add r3, r3, #8
	ldr r3, [r3]
	str r0, [r3]
	ldr r3, [sp, #0]
	mov r0, #0
	cmp r3, #0
	movgt r0, #1
	cmp r0, #1
	beq .LU8
	b .LU9
.LU8:
	ldr r3, [sp, #4]
	ldr r0, [r3]
	ldr r3, [sp, #8]
	ldr r3, [r3]
	mul r3, r0, r3
	str r3, [sp, #12]
	ldr r0, [sp, #12]
	ldr r3, [sp, #4]
	add r3, r3, #8
	ldr r3, [r3]
	ldr r3, [r3]
	mul r3, r0, r3
	ldr r0, [sp, #8]
	ldr r0, [r0]
	mov r1, r0
	mov r0, r3
	bl __aeabi_idiv
	mov r3, r0
	str r3, [sp, #12]
	ldr r3, [sp, #8]
	add r3, r3, #8
	ldr r3, [r3]
	ldr r3, [r3]
	ldr r0, [sp, #4]
	ldr r0, [r0]
	mov r1, r0
	mov r0, r3
	bl add
	mov r3, r0
	str r3, [sp, #12]
	ldr r3, [sp, #8]
	ldr r0, [r3]
	ldr r3, [sp, #4]
	ldr r3, [r3]
	sub r3, r0, r3
	str r3, [sp, #12]
	ldr r3, [sp, #0]
	sub r3, r3, #1
	str r3, [sp, #0]
	ldr r0, [sp, #0]
	mov r3, #0
	cmp r0, #0
	movgt r3, #1
	cmp r3, #1
	beq .LU8
	b .LU9
.LU9:
	ldr r3, [sp, #4]
	mov r0, r3
	bl free
	ldr r3, [sp, #8]
	mov r0, r3
	bl free
	b .LU6
.LU6:
	add sp, sp, #16
	pop {fp, pc}
	.size domath, .-domath
	.align 2
	.global objinstantiation
objinstantiation:
.LU11:
	push {fp, lr}
	add fp, sp, #4
	sub sp, sp, #8
	mov r2, r0
	str r2, [sp, #0]
	ldr r0, [sp, #0]
	mov r2, #0
	cmp r0, #0
	movgt r2, #1
	cmp r2, #1
	beq .LU12
	b .LU13
.LU12:
	movw r0, #12
	bl malloc
	mov r2, r0
	str r2, [sp, #4]
	ldr r2, [sp, #4]
	mov r0, r2
	bl free
	ldr r2, [sp, #0]
	sub r2, r2, #1
	str r2, [sp, #0]
	ldr r0, [sp, #0]
	mov r2, #0
	cmp r0, #0
	movgt r2, #1
	cmp r2, #1
	beq .LU12
	b .LU13
.LU13:
	b .LU10
.LU10:
	add sp, sp, #8
	pop {fp, pc}
	.size objinstantiation, .-objinstantiation
	.align 2
	.global ackermann
ackermann:
.LU15:
	push {fp, lr}
	add fp, sp, #4
	push {r4}
	sub sp, sp, #12
	mov r2, r0
	str r2, [sp, #0]
	str r1, [sp, #4]
	ldr r1, [sp, #0]
	mov r2, #0
	cmp r1, #0
	moveq r2, #1
	cmp r2, #1
	beq .LU16
	b .LU17
.LU16:
	ldr r2, [sp, #4]
	add r2, r2, #1
	str r2, [sp, #8]
	b .LU14
.LU17:
	ldr r1, [sp, #4]
	mov r2, #0
	cmp r1, #0
	moveq r2, #1
	cmp r2, #1
	beq .LU18
	b .LU19
.LU18:
	ldr r2, [sp, #0]
	sub r2, r2, #1
	movw r1, #1
	mov r0, r2
	bl ackermann
	mov r2, r0
	str r2, [sp, #8]
	b .LU14
.LU19:
	ldr r2, [sp, #0]
	sub r4, r2, #1
	ldr r2, [sp, #0]
	ldr r1, [sp, #4]
	sub r1, r1, #1
	mov r0, r2
	bl ackermann
	mov r2, r0
	mov r1, r2
	mov r0, r4
	bl ackermann
	mov r2, r0
	str r2, [sp, #8]
	b .LU14
.LU20:
	b .LU14
.LU14:
	ldr r2, [sp, #8]
	mov r0, r2
	add sp, sp, #12
	pop {r4}
	pop {fp, pc}
	.size ackermann, .-ackermann
	.align 2
	.global main
main:
.LU22:
	push {fp, lr}
	add fp, sp, #4
	sub sp, sp, #24
	add r1, sp, #4
	movw r0, #:lower16:.READ_FMT
	movt r0, #:upper16:.READ_FMT
	bl scanf
	add r1, sp, #8
	movw r0, #:lower16:.READ_FMT
	movt r0, #:upper16:.READ_FMT
	bl scanf
	add r1, sp, #12
	movw r0, #:lower16:.READ_FMT
	movt r0, #:upper16:.READ_FMT
	bl scanf
	add r1, sp, #16
	movw r0, #:lower16:.READ_FMT
	movt r0, #:upper16:.READ_FMT
	bl scanf
	add r1, sp, #20
	movw r0, #:lower16:.READ_FMT
	movt r0, #:upper16:.READ_FMT
	bl scanf
	ldr r2, [sp, #4]
	mov r0, r2
	bl tailrecursive
	ldr r2, [sp, #4]
	mov r1, r2
	movw r0, #:lower16:.PRINTLN_FMT
	movt r0, #:upper16:.PRINTLN_FMT
	bl printf
	ldr r2, [sp, #8]
	mov r0, r2
	bl domath
	ldr r2, [sp, #8]
	mov r1, r2
	movw r0, #:lower16:.PRINTLN_FMT
	movt r0, #:upper16:.PRINTLN_FMT
	bl printf
	ldr r2, [sp, #12]
	mov r0, r2
	bl objinstantiation
	ldr r2, [sp, #12]
	mov r1, r2
	movw r0, #:lower16:.PRINTLN_FMT
	movt r0, #:upper16:.PRINTLN_FMT
	bl printf
	ldr r2, [sp, #16]
	ldr r0, [sp, #20]
	mov r1, r0
	mov r0, r2
	bl ackermann
	mov r2, r0
	mov r1, r2
	movw r0, #:lower16:.PRINTLN_FMT
	movt r0, #:upper16:.PRINTLN_FMT
	bl printf
	movw r2, #0
	str r2, [sp, #0]
	b .LU21
.LU21:
	ldr r2, [sp, #0]
	mov r0, r2
	add sp, sp, #24
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
