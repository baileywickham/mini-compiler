	.arch armv7-a


	.text
	.align 2
	.global isqrt
isqrt:
.LU1:
	push {fp, lr}
	add fp, sp, #4
	sub sp, sp, #16
	mov r1, r0
	str r1, [sp, #0]
	movw r1, #1
	str r1, [sp, #8]
	movw r1, #3
	str r1, [sp, #12]
	ldr r1, [sp, #8]
	ldr r0, [sp, #0]
	mov r2, #0
	cmp r1, r0
	movle r2, #1
	cmp r2, #1
	beq .LU2
	b .LU3
.LU2:
	ldr r1, [sp, #8]
	ldr r2, [sp, #12]
	add r1, r1, r2
	str r1, [sp, #8]
	ldr r1, [sp, #12]
	add r1, r1, #2
	str r1, [sp, #12]
	ldr r1, [sp, #8]
	ldr r2, [sp, #0]
	mov r0, #0
	cmp r1, r2
	movle r0, #1
	cmp r0, #1
	beq .LU2
	b .LU3
.LU3:
	ldr r2, [sp, #12]
	movw r1, #2
	mov r0, r2
	bl __aeabi_idiv
	mov r1, r0
	sub r1, r1, #1
	str r1, [sp, #4]
	b .LU0
.LU0:
	ldr r1, [sp, #4]
	mov r0, r1
	add sp, sp, #16
	pop {fp, pc}
	.size isqrt, .-isqrt
	.align 2
	.global prime
prime:
.LU5:
	push {fp, lr}
	add fp, sp, #4
	push {r4}
	sub sp, sp, #20
	mov r4, r0
	str r4, [sp, #0]
	ldr r4, [sp, #0]
	mov r1, #0
	cmp r4, #2
	movlt r1, #1
	cmp r1, #1
	beq .LU6
	b .LU7
.LU6:
	movw r4, #0
	str r4, [sp, #4]
	b .LU4
.LU7:
	ldr r4, [sp, #0]
	mov r0, r4
	bl isqrt
	mov r4, r0
	str r4, [sp, #8]
	movw r4, #2
	str r4, [sp, #12]
	ldr r2, [sp, #12]
	ldr r4, [sp, #8]
	mov r1, #0
	cmp r2, r4
	movle r1, #1
	cmp r1, #1
	beq .LU9
	b .LU10
.LU9:
	ldr r4, [sp, #0]
	ldr r2, [sp, #0]
	ldr r1, [sp, #12]
	mov r0, r2
	bl __aeabi_idiv
	mov r2, r0
	ldr r1, [sp, #12]
	mul r1, r2, r1
	sub r4, r4, r1
	str r4, [sp, #16]
	ldr r4, [sp, #16]
	mov r1, #0
	cmp r4, #0
	moveq r1, #1
	cmp r1, #1
	beq .LU11
	b .LU12
.LU11:
	movw r4, #0
	str r4, [sp, #4]
	b .LU4
.LU12:
	ldr r4, [sp, #12]
	add r4, r4, #1
	str r4, [sp, #12]
	ldr r4, [sp, #12]
	ldr r2, [sp, #8]
	mov r1, #0
	cmp r4, r2
	movle r1, #1
	cmp r1, #1
	beq .LU9
	b .LU10
.LU10:
	movw r4, #1
	str r4, [sp, #4]
	b .LU4
.LU8:
	b .LU4
.LU4:
	ldr r4, [sp, #4]
	mov r0, r4
	add sp, sp, #20
	pop {r4}
	pop {fp, pc}
	.size prime, .-prime
	.align 2
	.global main
main:
.LU14:
	push {fp, lr}
	add fp, sp, #4
	sub sp, sp, #12
	add r1, sp, #4
	movw r0, #:lower16:.READ_FMT
	movt r0, #:upper16:.READ_FMT
	bl scanf
	movw r1, #0
	str r1, [sp, #8]
	ldr r2, [sp, #8]
	ldr r1, [sp, #4]
	mov r0, #0
	cmp r2, r1
	movle r0, #1
	cmp r0, #1
	beq .LU15
	b .LU16
.LU15:
	ldr r1, [sp, #8]
	mov r0, r1
	bl prime
	mov r1, r0
	cmp r1, #1
	beq .LU17
	b .LU18
.LU17:
	ldr r1, [sp, #8]
	movw r0, #:lower16:.PRINTLN_FMT
	movt r0, #:upper16:.PRINTLN_FMT
	bl printf
	b .LU18
.LU18:
	ldr r1, [sp, #8]
	add r1, r1, #1
	str r1, [sp, #8]
	ldr r0, [sp, #8]
	ldr r2, [sp, #4]
	mov r1, #0
	cmp r0, r2
	movle r1, #1
	cmp r1, #1
	beq .LU15
	b .LU16
.LU16:
	movw r1, #0
	str r1, [sp, #0]
	b .LU13
.LU13:
	ldr r1, [sp, #0]
	mov r0, r1
	add sp, sp, #12
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
