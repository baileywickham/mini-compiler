	.arch armv7-a


	.text
	.align 2
	.global calcPower
calcPower:
.LU1:
	push {fp, lr}
	add fp, sp, #4
	sub sp, sp, #16
	mov r2, r0
	mov r0, r1
	str r2, [sp, #0]
	str r0, [sp, #4]
	movw r2, #1
	str r2, [sp, #12]
	ldr r2, [sp, #4]
	mov r0, #0
	cmp r2, #0
	movgt r0, #1
	cmp r0, #1
	beq .LU2
	b .LU3
.LU2:
	ldr r2, [sp, #12]
	ldr r0, [sp, #0]
	mul r2, r2, r0
	str r2, [sp, #12]
	ldr r2, [sp, #4]
	sub r2, r2, #1
	str r2, [sp, #4]
	ldr r2, [sp, #4]
	mov r0, #0
	cmp r2, #0
	movgt r0, #1
	cmp r0, #1
	beq .LU2
	b .LU3
.LU3:
	ldr r2, [sp, #12]
	str r2, [sp, #8]
	b .LU0
.LU0:
	ldr r2, [sp, #8]
	mov r0, r2
	add sp, sp, #16
	pop {fp, pc}
	.size calcPower, .-calcPower
	.align 2
	.global main
main:
.LU5:
	push {fp, lr}
	add fp, sp, #4
	sub sp, sp, #20
	movw r2, #0
	str r2, [sp, #12]
	movw r0, #8
	bl malloc
	mov r2, r0
	str r2, [sp, #4]
	add r1, sp, #8
	movw r0, #:lower16:.READ_FMT
	movt r0, #:upper16:.READ_FMT
	bl scanf
	ldr r0, [sp, #8]
	ldr r2, [sp, #4]
	str r0, [r2]
	add r1, sp, #8
	movw r0, #:lower16:.READ_FMT
	movt r0, #:upper16:.READ_FMT
	bl scanf
	ldr r0, [sp, #8]
	mov r2, #0
	cmp r0, #0
	movlt r2, #1
	cmp r2, #1
	beq .LU6
	b .LU7
.LU6:
	movw r2, #0
	sub r2, r2, #1
	str r2, [sp, #0]
	b .LU4
.LU7:
	ldr r0, [sp, #8]
	ldr r2, [sp, #4]
	add r2, r2, #4
	str r0, [r2]
	movw r2, #0
	str r2, [sp, #16]
	ldr r2, [sp, #16]
	movw r3, #:lower16:1000000
	movt r3, #:upper16:1000000
	mov r0, #0
	cmp r2, r3
	movlt r0, #1
	cmp r0, #1
	beq .LU8
	b .LU9
.LU8:
	ldr r2, [sp, #16]
	add r2, r2, #1
	str r2, [sp, #16]
	ldr r2, [sp, #4]
	ldr r2, [r2]
	ldr r0, [sp, #4]
	add r0, r0, #4
	ldr r0, [r0]
	mov r1, r0
	mov r0, r2
	bl calcPower
	mov r2, r0
	str r2, [sp, #12]
	ldr r0, [sp, #16]
	movw r3, #:lower16:1000000
	movt r3, #:upper16:1000000
	mov r2, #0
	cmp r0, r3
	movlt r2, #1
	cmp r2, #1
	beq .LU8
	b .LU9
.LU9:
	ldr r2, [sp, #12]
	mov r1, r2
	movw r0, #:lower16:.PRINTLN_FMT
	movt r0, #:upper16:.PRINTLN_FMT
	bl printf
	movw r2, #1
	str r2, [sp, #0]
	b .LU4
.LU4:
	ldr r2, [sp, #0]
	mov r0, r2
	add sp, sp, #20
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
