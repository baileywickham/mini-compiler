	.arch armv7-a


	.text
	.align 2
	.global mod
mod:
.LU1:
	push {fp, lr}
	add fp, sp, #4
	push {r4}
	sub sp, sp, #12
	mov r4, r0
	str r4, [sp, #0]
	str r1, [sp, #4]
	ldr r4, [sp, #0]
	ldr r0, [sp, #0]
	ldr r1, [sp, #4]
	bl __aeabi_idiv
	ldr r1, [sp, #4]
	mul r1, r0, r1
	sub r4, r4, r1
	str r4, [sp, #8]
	b .LU0
.LU0:
	ldr r4, [sp, #8]
	mov r0, r4
	add sp, sp, #12
	pop {r4}
	pop {fp, pc}
	.size mod, .-mod
	.align 2
	.global hailstone
hailstone:
.LU3:
	push {fp, lr}
	add fp, sp, #4
	sub sp, sp, #4
	mov r1, r0
	str r1, [sp, #0]
	movw r1, #1
	cmp r1, #1
	beq .LU4
	b .LU5
.LU4:
	ldr r1, [sp, #0]
	movw r0, #:lower16:.PRINT_FMT
	movt r0, #:upper16:.PRINT_FMT
	bl printf
	ldr r2, [sp, #0]
	movw r1, #2
	mov r0, r2
	bl mod
	mov r2, r0
	mov r1, #0
	cmp r2, #1
	moveq r1, #1
	cmp r1, #1
	beq .LU6
	b .LU7
.LU6:
	ldr r2, [sp, #0]
	movw r1, #3
	mul r1, r1, r2
	add r1, r1, #1
	str r1, [sp, #0]
	b .LU8
.LU7:
	ldr r2, [sp, #0]
	movw r1, #2
	mov r0, r2
	bl __aeabi_idiv
	mov r1, r0
	str r1, [sp, #0]
	b .LU8
.LU8:
	ldr r2, [sp, #0]
	mov r1, #0
	cmp r2, #1
	movle r1, #1
	cmp r1, #1
	beq .LU9
	b .LU10
.LU9:
	ldr r1, [sp, #0]
	movw r0, #:lower16:.PRINTLN_FMT
	movt r0, #:upper16:.PRINTLN_FMT
	bl printf
	b .LU2
.LU10:
	movw r1, #1
	cmp r1, #1
	beq .LU4
	b .LU5
.LU5:
	b .LU2
.LU2:
	add sp, sp, #4
	pop {fp, pc}
	.size hailstone, .-hailstone
	.align 2
	.global main
main:
.LU12:
	push {fp, lr}
	add fp, sp, #4
	sub sp, sp, #8
	add r1, sp, #4
	movw r0, #:lower16:.READ_FMT
	movt r0, #:upper16:.READ_FMT
	bl scanf
	ldr r2, [sp, #4]
	mov r0, r2
	bl hailstone
	movw r2, #0
	str r2, [sp, #0]
	b .LU11
.LU11:
	ldr r2, [sp, #0]
	mov r0, r2
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
