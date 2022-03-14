	.arch armv7-a
	.comm	.read_scratch,4,4

	.text
	.align 2
	.global isqrt
isqrt:
.LU1:
	push {fp, lr}
	add fp, sp, #4
	push {r4, r5}
	mov r3, r0
	movw r1, #1
	mov r0, #0
	cmp r1, r3
	movle r0, #1
	movw r1, #3
	movw r2, #1
	movw r5, #3
	mov r4, r3
	cmp r0, #1
	beq .LU2
	b .LU3
.LU2:
	mov r0, r4
	mov r1, r5
	add r2, r2, r1
	add r4, r1, #2
	mov r3, #0
	cmp r2, r0
	movle r3, #1
	mov r1, r4
	mov r5, r4
	mov r4, r0
	cmp r3, #1
	beq .LU2
	b .LU3
.LU3:
	mov r2, r1
	movw r1, #2
	mov r0, r2
	bl __aeabi_idiv
	mov r1, r0
	sub r1, r1, #1
	b .LU0
.LU0:
	mov r0, r1
	pop {r4, r5}
	pop {fp, pc}
	.size isqrt, .-isqrt
	.align 2
	.global prime
prime:
.LU5:
	push {fp, lr}
	add fp, sp, #4
	push {r4, r5, r6}
	mov r4, r0
	mov r5, #0
	cmp r4, #2
	movlt r5, #1
	cmp r5, #1
	beq .LU6
	b .LU7
.LU6:
	movw r4, #0
	b .LU4
.LU7:
	mov r0, r4
	bl isqrt
	mov r2, r0
	movw r5, #2
	mov r1, #0
	cmp r5, r2
	movle r1, #1
	mov r5, r4
	movw r6, #2
	mov r4, r2
	cmp r1, #1
	beq .LU9
	b .LU10
.LU9:
	mov r1, r6
	mov r0, r5
	bl __aeabi_idiv
	mov r1, r0
	mul r1, r1, r6
	sub r2, r5, r1
	mov r1, #0
	cmp r2, #0
	moveq r1, #1
	cmp r1, #1
	beq .LU11
	b .LU12
.LU11:
	movw r4, #0
	b .LU4
.LU12:
	b .LU13
.LU13:
	add r6, r6, #1
	mov r1, #0
	cmp r6, r4
	movle r1, #1
	cmp r1, #1
	beq .LU9
	b .LU10
.LU10:
	movw r4, #1
	b .LU4
.LU4:
	mov r0, r4
	pop {r4, r5, r6}
	pop {fp, pc}
	.size prime, .-prime
	.align 2
	.global main
main:
.LU15:
	push {fp, lr}
	add fp, sp, #4
	push {r4, r5}
	movw r1, #:lower16:.read_scratch
	movt r1, #:upper16:.read_scratch
	movw r0, #:lower16:.READ_FMT
	movt r0, #:upper16:.READ_FMT
	bl scanf
	movw r4, #:lower16:.read_scratch
	movt r4, #:upper16:.read_scratch
	ldr r5, [r4]
	movw r1, #0
	mov r4, #0
	cmp r1, r5
	movle r4, #1
	movw r1, #0
	mov r2, r5
	cmp r4, #1
	beq .LU16
	b .LU17
.LU16:
	mov r4, r2
	mov r5, r1
	mov r0, r5
	bl prime
	mov r1, r0
	cmp r1, #1
	beq .LU18
	b .LU19
.LU18:
	mov r1, r5
	movw r0, #:lower16:.PRINTLN_FMT
	movt r0, #:upper16:.PRINTLN_FMT
	bl printf
	b .LU20
.LU19:
	b .LU20
.LU20:
	add r1, r5, #1
	mov r5, #0
	cmp r1, r4
	movle r5, #1
	mov r2, r4
	cmp r5, #1
	beq .LU16
	b .LU17
.LU17:
	b .LU14
.LU14:
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
