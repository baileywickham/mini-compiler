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
	str r2, [sp, #0]
	str r1, [sp, #4]
	movw r1, #1
	str r1, [sp, #12]
	ldr r1, [sp, #4]
	mov r2, #0
	cmp r1, #0
	movgt r2, #1
	cmp r2, #1
	beq .LU2
	b .LU3
.LU2:
	ldr r1, [sp, #12]
	ldr r2, [sp, #0]
	mul r1, r1, r2
	str r1, [sp, #12]
	ldr r1, [sp, #4]
	sub r1, r1, #1
	str r1, [sp, #4]
	ldr r2, [sp, #4]
	mov r1, #0
	cmp r2, #0
	movgt r1, #1
	cmp r1, #1
	beq .LU2
	b .LU3
.LU3:
	ldr r1, [sp, #12]
	str r1, [sp, #8]
	b .LU0
.LU0:
	ldr r1, [sp, #8]
	mov r0, r1
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
	ldr r2, [sp, #8]
	ldr r1, [sp, #4]
	str r2, [r1]
	add r1, sp, #8
	movw r0, #:lower16:.READ_FMT
	movt r0, #:upper16:.READ_FMT
	bl scanf
	ldr r1, [sp, #8]
	mov r2, #0
	cmp r1, #0
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
	ldr r2, [sp, #8]
	ldr r1, [sp, #4]
	add r1, r1, #4
	str r2, [r1]
	movw r2, #0
	str r2, [sp, #16]
	ldr r2, [sp, #16]
	movw r0, #:lower16:1000000
	movt r0, #:upper16:1000000
	mov r1, #0
	cmp r2, r0
	movlt r1, #1
	cmp r1, #1
	beq .LU8
	b .LU9
.LU8:
	ldr r2, [sp, #16]
	add r2, r2, #1
	str r2, [sp, #16]
	ldr r2, [sp, #4]
	ldr r2, [r2]
	ldr r1, [sp, #4]
	add r1, r1, #4
	ldr r1, [r1]
	mov r0, r2
	bl calcPower
	mov r2, r0
	str r2, [sp, #12]
	ldr r0, [sp, #16]
	movw r2, #:lower16:1000000
	movt r2, #:upper16:1000000
	mov r1, #0
	cmp r0, r2
	movlt r1, #1
	cmp r1, #1
	beq .LU8
	b .LU9
.LU9:
	ldr r2, [sp, #12]
	mov r1, r2
	movw r0, #:lower16:.PRINTLN_FMT
	movt r0, #:upper16:.PRINTLN_FMT
	bl printf
	movw r2, #0
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
