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
	mov r2, r0
	mov r4, r2
	movw r1, #:lower16:.read_scratch
	movt r1, #:upper16:.read_scratch
	movw r0, #:lower16:.READ_FMT
	movt r0, #:upper16:.READ_FMT
	bl scanf
	movw r2, #:lower16:.read_scratch
	movt r2, #:upper16:.read_scratch
	ldr r3, [r2]
	mov r2, r4
	str r3, [r2]
	movw r1, #:lower16:.read_scratch
	movt r1, #:upper16:.read_scratch
	movw r0, #:lower16:.READ_FMT
	movt r0, #:upper16:.READ_FMT
	bl scanf
	movw r2, #:lower16:.read_scratch
	movt r2, #:upper16:.read_scratch
	ldr r3, [r2]
	mov r2, #0
	cmp r3, #0
	movlt r2, #1
	cmp r2, #1
	beq .LU6
	b .LU7
.LU6:
	movw r2, #:lower16:-1
	movt r2, #:upper16:-1
	b .LU4
.LU7:
	b .LU8
.LU8:
	add r2, r4, #4
	str r3, [r2]
	movw r2, #0
	movw r3, #0
	movw r1, #1
	cmp r1, #1
	beq .LU9
	b .LU10
.LU9:
	mov r2, r3
	add r5, r2, #1
	mov r2, r4
	ldr r6, [r2]
	add r2, r4, #4
	ldr r0, [r2]
	b .inline0_LU1
.inline0_LU1:
	mov r1, #0
	cmp r0, #0
	movgt r1, #1
	movw r2, #1
	movw r3, #1
	cmp r1, #1
	beq .inline0_LU2
	b .inline0_LU3
.inline0_LU2:
	mov r2, r0
	mul r3, r3, r6
	sub r0, r2, #1
	mov r1, #0
	cmp r0, #0
	movgt r1, #1
	mov r2, r3
	cmp r1, #1
	beq .inline0_LU2
	b .inline0_LU3
.inline0_LU3:
	b .inline0_LU0
.inline0_LU0:
	b .next0
.next0:
	movw r3, #:lower16:1000000
	movt r3, #:upper16:1000000
	mov r1, #0
	cmp r5, r3
	movlt r1, #1
	mov r3, r5
	cmp r1, #1
	beq .LU9
	b .LU10
.LU10:
	mov r1, r2
	movw r0, #:lower16:.PRINTLN_FMT
	movt r0, #:upper16:.PRINTLN_FMT
	bl printf
	movw r2, #0
	b .LU4
.LU4:
	mov r0, r2
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
