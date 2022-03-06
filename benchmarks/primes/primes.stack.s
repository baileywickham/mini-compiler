	.arch armv7-a


	.text
	.align 2
	.global isqrt
isqrt:
.LU1:
	push {fp, lr}
	add fp, sp, #4
	sub sp, sp, #16
	mov r2, r0
	str r2, [sp, #0]
	movw r2, #1
	str r2, [sp, #8]
	movw r2, #3
	str r2, [sp, #12]
	ldr r0, [sp, #8]
	ldr r3, [sp, #0]
	mov r2, #0
	cmp r0, r3
	movle r2, #1
	cmp r2, #1
	beq .LU2
	b .LU3
.LU2:
	ldr r2, [sp, #8]
	ldr r0, [sp, #12]
	add r2, r2, r0
	str r2, [sp, #8]
	ldr r2, [sp, #12]
	add r2, r2, #2
	str r2, [sp, #12]
	ldr r0, [sp, #8]
	ldr r3, [sp, #0]
	mov r2, #0
	cmp r0, r3
	movle r2, #1
	cmp r2, #1
	beq .LU2
	b .LU3
.LU3:
	ldr r2, [sp, #12]
	movw r1, #2
	mov r0, r2
	bl __aeabi_idiv
	mov r2, r0
	sub r2, r2, #1
	str r2, [sp, #4]
	b .LU0
.LU0:
	ldr r2, [sp, #4]
	mov r0, r2
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
	mov r3, r0
	str r3, [sp, #0]
	ldr r3, [sp, #0]
	mov r0, #0
	cmp r3, #2
	movlt r0, #1
	cmp r0, #1
	beq .LU6
	b .LU7
.LU6:
	movw r3, #0
	str r3, [sp, #4]
	b .LU4
.LU7:
	ldr r3, [sp, #0]
	mov r0, r3
	bl isqrt
	mov r3, r0
	str r3, [sp, #8]
	movw r3, #2
	str r3, [sp, #12]
	ldr r0, [sp, #12]
	ldr r3, [sp, #8]
	mov r2, #0
	cmp r0, r3
	movle r2, #1
	cmp r2, #1
	beq .LU9
	b .LU10
.LU9:
	ldr r4, [sp, #0]
	ldr r3, [sp, #0]
	ldr r0, [sp, #12]
	mov r1, r0
	mov r0, r3
	bl __aeabi_idiv
	ldr r3, [sp, #12]
	mul r3, r0, r3
	sub r3, r4, r3
	str r3, [sp, #16]
	ldr r3, [sp, #16]
	mov r0, #0
	cmp r3, #0
	moveq r0, #1
	cmp r0, #1
	beq .LU11
	b .LU12
.LU11:
	movw r3, #0
	str r3, [sp, #4]
	b .LU4
.LU12:
	ldr r3, [sp, #12]
	add r3, r3, #1
	str r3, [sp, #12]
	ldr r3, [sp, #12]
	ldr r2, [sp, #8]
	mov r0, #0
	cmp r3, r2
	movle r0, #1
	cmp r0, #1
	beq .LU9
	b .LU10
.LU10:
	movw r3, #1
	str r3, [sp, #4]
	b .LU4
.LU8:
	b .LU4
.LU4:
	ldr r3, [sp, #4]
	mov r0, r3
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
	movw r2, #0
	str r2, [sp, #8]
	ldr r3, [sp, #8]
	ldr r1, [sp, #4]
	mov r2, #0
	cmp r3, r1
	movle r2, #1
	cmp r2, #1
	beq .LU15
	b .LU16
.LU15:
	ldr r2, [sp, #8]
	mov r0, r2
	bl prime
	mov r2, r0
	cmp r2, #1
	beq .LU17
	b .LU18
.LU17:
	ldr r2, [sp, #8]
	mov r1, r2
	movw r0, #:lower16:.PRINTLN_FMT
	movt r0, #:upper16:.PRINTLN_FMT
	bl printf
	b .LU18
.LU18:
	ldr r2, [sp, #8]
	add r2, r2, #1
	str r2, [sp, #8]
	ldr r3, [sp, #8]
	ldr r1, [sp, #4]
	mov r2, #0
	cmp r3, r1
	movle r2, #1
	cmp r2, #1
	beq .LU15
	b .LU16
.LU16:
	movw r2, #0
	str r2, [sp, #0]
	b .LU13
.LU13:
	ldr r2, [sp, #0]
	mov r0, r2
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
