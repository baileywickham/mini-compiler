	.arch armv7-a
	.comm	.read_scratch,4,4

	.text
	.align 2
	.global main
main:
.LU5:
	push {fp, lr}
	add fp, sp, #4
	push {r4, r5, r6}
	movw r0, #8
	bl malloc
	mov r4, r0
	movw r1, #:lower16:.read_scratch
	movt r1, #:upper16:.read_scratch
	movw r0, #:lower16:.READ_FMT
	movt r0, #:upper16:.READ_FMT
	bl scanf
	movw r1, #:lower16:.read_scratch
	movt r1, #:upper16:.read_scratch
	ldr r1, [r1]
	mov r2, r4
	str r1, [r2]
	movw r1, #:lower16:.read_scratch
	movt r1, #:upper16:.read_scratch
	movw r0, #:lower16:.READ_FMT
	movt r0, #:upper16:.READ_FMT
	bl scanf
	movw r1, #:lower16:.read_scratch
	movt r1, #:upper16:.read_scratch
	ldr r1, [r1]
	mov r2, #0
	cmp r1, #0
	movlt r2, #1
	cmp r2, #1
	beq .LU6
	b .LU7
.LU6:
	movw r4, #:lower16:-1
	movt r4, #:upper16:-1
	b .LU4
.LU7:
	add r2, r4, #4
	str r1, [r2]
	movw r0, #0
	movw r1, #0
	mov r3, r4
	movw r4, #1
	cmp r4, #1
	beq .LU9
	b .LU10
.LU9:
	mov r4, r3
	add r1, r1, #1
	mov r2, r4
	ldr r3, [r2]
	add r2, r4, #4
	ldr r6, [r2]
	mov r5, #0
	cmp r6, #0
	movgt r5, #1
	movw r2, #1
	movw r0, #1
	cmp r5, #1
	beq .inline0_LU2
	b .inline0_LU3
.inline0_LU2:
	mov r2, r6
	mul r0, r0, r3
	sub r6, r2, #1
	mov r5, #0
	cmp r6, #0
	movgt r5, #1
	mov r2, r0
	cmp r5, #1
	beq .inline0_LU2
	b .inline0_LU3
.inline0_LU3:
	mov r0, r2
	movw r3, #:lower16:1000000
	movt r3, #:upper16:1000000
	mov r2, #0
	cmp r1, r3
	movlt r2, #1
	mov r3, r4
	cmp r2, #1
	beq .LU9
	b .LU10
.LU10:
	mov r4, r0
	mov r1, r4
	movw r0, #:lower16:.PRINTLN_FMT
	movt r0, #:upper16:.PRINTLN_FMT
	bl printf
	movw r4, #0
	b .LU4
.LU4:
	mov r0, r4
	pop {r4, r5, r6}
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
