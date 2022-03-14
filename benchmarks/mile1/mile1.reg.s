	.arch armv7-a
	.comm	.read_scratch,4,4

	.text
	.align 2
	.global calcPower
calcPower:
.LU1:
	push {fp, lr}
	add fp, sp, #4
	push {r4}
	mov r4, r1
	mov r3, #0
	cmp r4, #0
	movgt r3, #1
	movw r1, #1
	movw r2, #1
	cmp r3, #1
	beq .LU2
	b .LU3
.LU2:
	mov r1, r4
	mul r2, r2, r0
	sub r4, r1, #1
	mov r3, #0
	cmp r4, #0
	movgt r3, #1
	mov r1, r2
	cmp r3, #1
	beq .LU2
	b .LU3
.LU3:
	b .LU0
.LU0:
	mov r0, r1
	pop {r4}
	pop {fp, pc}
	.size calcPower, .-calcPower
	.align 2
	.global main
main:
.LU5:
	push {fp, lr}
	add fp, sp, #4
	push {r4, r5}
	movw r0, #8
	bl malloc
	mov r4, r0
	movw r1, #:lower16:.read_scratch
	movt r1, #:upper16:.read_scratch
	movw r0, #:lower16:.READ_FMT
	movt r0, #:upper16:.READ_FMT
	bl scanf
	movw r5, #:lower16:.read_scratch
	movt r5, #:upper16:.read_scratch
	ldr r5, [r5]
	mov r1, r4
	str r5, [r1]
	movw r1, #:lower16:.read_scratch
	movt r1, #:upper16:.read_scratch
	movw r0, #:lower16:.READ_FMT
	movt r0, #:upper16:.READ_FMT
	bl scanf
	movw r5, #:lower16:.read_scratch
	movt r5, #:upper16:.read_scratch
	ldr r5, [r5]
	mov r1, #0
	cmp r5, #0
	movlt r1, #1
	cmp r1, #1
	beq .LU6
	b .LU7
.LU6:
	movw r4, #0
	sub r4, r4, #1
	b .LU4
.LU7:
	b .LU8
.LU8:
	add r1, r4, #4
	str r5, [r1]
	movw r2, #0
	movw r1, #:lower16:1000000
	movt r1, #:upper16:1000000
	mov r5, #0
	cmp r2, r1
	movlt r5, #1
	movw r2, #0
	movw r0, #0
	cmp r5, #1
	beq .LU9
	b .LU10
.LU9:
	mov r5, r0
	add r5, r5, #1
	mov r1, r4
	ldr r2, [r1]
	add r1, r4, #4
	ldr r1, [r1]
	mov r0, r2
	bl calcPower
	movw r2, #:lower16:1000000
	movt r2, #:upper16:1000000
	mov r1, #0
	cmp r5, r2
	movlt r1, #1
	mov r2, r0
	mov r0, r5
	cmp r1, #1
	beq .LU9
	b .LU10
.LU10:
	mov r4, r2
	mov r1, r4
	movw r0, #:lower16:.PRINTLN_FMT
	movt r0, #:upper16:.PRINTLN_FMT
	bl printf
	movw r4, #0
	b .LU4
.LU4:
	mov r0, r4
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
