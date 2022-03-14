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
	str r0, [sp, #0]
	ldr r0, [sp, #0]
	mov r1, #0
	cmp r0, #0
	movle r1, #1
	cmp r1, #1
	beq .LU2
	b .LU3
.LU2:
	b .LU0
.LU3:
	ldr r0, [sp, #0]
	sub r0, r0, #1
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
	str r0, [sp, #0]
	str r1, [sp, #4]
	ldr r1, [sp, #0]
	ldr r0, [sp, #4]
	add r1, r1, r0
	str r1, [sp, #8]
	b .LU4
.LU4:
	ldr r1, [sp, #8]
	mov r0, r1
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
	mov r1, r0
	str r1, [sp, #0]
	movw r0, #12
	bl malloc
	mov r1, r0
	str r1, [sp, #4]
	movw r0, #4
	bl malloc
	mov r1, r0
	ldr r2, [sp, #4]
	add r2, r2, #8
	str r1, [r2]
	movw r0, #12
	bl malloc
	mov r1, r0
	str r1, [sp, #8]
	movw r0, #4
	bl malloc
	mov r1, r0
	ldr r2, [sp, #8]
	add r2, r2, #8
	str r1, [r2]
	ldr r1, [sp, #0]
	ldr r2, [sp, #4]
	str r1, [r2]
	ldr r1, [sp, #8]
	mov r2, r1
	movw r1, #3
	str r1, [r2]
	ldr r1, [sp, #4]
	ldr r1, [r1]
	ldr r2, [sp, #4]
	add r2, r2, #8
	ldr r2, [r2]
	str r1, [r2]
	ldr r1, [sp, #8]
	ldr r1, [r1]
	ldr r2, [sp, #8]
	add r2, r2, #8
	ldr r2, [r2]
	str r1, [r2]
	ldr r1, [sp, #0]
	mov r2, #0
	cmp r1, #0
	movgt r2, #1
	cmp r2, #1
	beq .LU8
	b .LU9
.LU8:
	ldr r1, [sp, #4]
	ldr r1, [r1]
	ldr r2, [sp, #8]
	ldr r2, [r2]
	mul r1, r1, r2
	str r1, [sp, #12]
	ldr r1, [sp, #12]
	ldr r2, [sp, #4]
	add r2, r2, #8
	ldr r2, [r2]
	ldr r2, [r2]
	mul r2, r1, r2
	ldr r1, [sp, #8]
	ldr r1, [r1]
	mov r0, r2
	bl __aeabi_idiv
	mov r1, r0
	str r1, [sp, #12]
	ldr r1, [sp, #8]
	add r1, r1, #8
	ldr r1, [r1]
	ldr r2, [r1]
	ldr r1, [sp, #4]
	ldr r1, [r1]
	mov r0, r2
	bl add
	mov r1, r0
	str r1, [sp, #12]
	ldr r1, [sp, #8]
	ldr r1, [r1]
	ldr r2, [sp, #4]
	ldr r2, [r2]
	sub r1, r1, r2
	str r1, [sp, #12]
	ldr r1, [sp, #0]
	sub r1, r1, #1
	str r1, [sp, #0]
	ldr r1, [sp, #0]
	mov r2, #0
	cmp r1, #0
	movgt r2, #1
	cmp r2, #1
	beq .LU8
	b .LU9
.LU9:
	ldr r1, [sp, #4]
	add r1, r1, #8
	ldr r1, [r1]
	mov r0, r1
	bl free
	ldr r1, [sp, #8]
	add r1, r1, #8
	ldr r1, [r1]
	mov r0, r1
	bl free
	ldr r1, [sp, #4]
	mov r0, r1
	bl free
	ldr r1, [sp, #8]
	mov r0, r1
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
	str r0, [sp, #0]
	ldr r1, [sp, #0]
	mov r0, #0
	cmp r1, #0
	movgt r0, #1
	cmp r0, #1
	beq .LU12
	b .LU13
.LU12:
	movw r0, #12
	bl malloc
	str r0, [sp, #4]
	ldr r0, [sp, #4]
	bl free
	ldr r0, [sp, #0]
	sub r0, r0, #1
	str r0, [sp, #0]
	ldr r1, [sp, #0]
	mov r0, #0
	cmp r1, #0
	movgt r0, #1
	cmp r0, #1
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
	mov r4, r1
	str r2, [sp, #0]
	str r4, [sp, #4]
	ldr r4, [sp, #0]
	mov r1, #0
	cmp r4, #0
	moveq r1, #1
	cmp r1, #1
	beq .LU16
	b .LU17
.LU16:
	ldr r4, [sp, #4]
	add r4, r4, #1
	str r4, [sp, #8]
	b .LU14
.LU17:
	ldr r4, [sp, #4]
	mov r1, #0
	cmp r4, #0
	moveq r1, #1
	cmp r1, #1
	beq .LU18
	b .LU19
.LU18:
	ldr r4, [sp, #0]
	sub r4, r4, #1
	movw r1, #1
	mov r0, r4
	bl ackermann
	mov r4, r0
	str r4, [sp, #8]
	b .LU14
.LU19:
	ldr r4, [sp, #0]
	sub r4, r4, #1
	ldr r2, [sp, #0]
	ldr r1, [sp, #4]
	sub r1, r1, #1
	mov r0, r2
	bl ackermann
	mov r1, r0
	mov r0, r4
	bl ackermann
	mov r4, r0
	str r4, [sp, #8]
	b .LU14
.LU20:
	b .LU14
.LU14:
	ldr r4, [sp, #8]
	mov r0, r4
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
	ldr r1, [sp, #4]
	mov r0, r1
	bl tailrecursive
	ldr r1, [sp, #4]
	movw r0, #:lower16:.PRINTLN_FMT
	movt r0, #:upper16:.PRINTLN_FMT
	bl printf
	ldr r1, [sp, #8]
	mov r0, r1
	bl domath
	ldr r1, [sp, #8]
	movw r0, #:lower16:.PRINTLN_FMT
	movt r0, #:upper16:.PRINTLN_FMT
	bl printf
	ldr r1, [sp, #12]
	mov r0, r1
	bl objinstantiation
	ldr r1, [sp, #12]
	movw r0, #:lower16:.PRINTLN_FMT
	movt r0, #:upper16:.PRINTLN_FMT
	bl printf
	ldr r0, [sp, #16]
	ldr r1, [sp, #20]
	bl ackermann
	mov r1, r0
	movw r0, #:lower16:.PRINTLN_FMT
	movt r0, #:upper16:.PRINTLN_FMT
	bl printf
	movw r1, #0
	str r1, [sp, #0]
	b .LU21
.LU21:
	ldr r1, [sp, #0]
	mov r0, r1
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
