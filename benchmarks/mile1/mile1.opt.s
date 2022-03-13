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
	mov r3, r0
	mov r0, r1
	mov r2, #0
	cmp r0, #0
	movgt r2, #1
	movw r4, #1
	movw r1, #1
	cmp r2, #1
	beq .LU2
	b .LU3
.LU2:
	mov r2, r0
	mul r1, r1, r3
	sub r0, r2, #1
	mov r2, #0
	cmp r0, #0
	movgt r2, #1
	mov r4, r1
	cmp r2, #1
	beq .LU2
	b .LU3
.LU3:
	mov r1, r4
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
	mov r3, r0
	mov r4, r3
	movw r1, #:lower16:.read_scratch
	movt r1, #:upper16:.read_scratch
	movw r0, #:lower16:.READ_FMT
	movt r0, #:upper16:.READ_FMT
	bl scanf
	movw r3, #:lower16:.read_scratch
	movt r3, #:upper16:.read_scratch
	ldr r3, [r3]
	mov r0, r4
	str r3, [r0]
	movw r1, #:lower16:.read_scratch
	movt r1, #:upper16:.read_scratch
	movw r0, #:lower16:.READ_FMT
	movt r0, #:upper16:.READ_FMT
	bl scanf
	movw r3, #:lower16:.read_scratch
	movt r3, #:upper16:.read_scratch
	ldr r0, [r3]
	mov r3, #0
	cmp r0, #0
	movlt r3, #1
	cmp r3, #1
	beq .LU6
	b .LU7
.LU6:
	movw r3, #:lower16:-1
	movt r3, #:upper16:-1
	b .LU4
.LU7:
	b .LU8
.LU8:
	add r3, r4, #4
	str r0, [r3]
	movw r0, #0
	movw r5, #0
	movw r3, #1
	cmp r3, #1
	beq .LU9
	b .LU10
.LU9:
	mov r3, r5
	add r5, r3, #1
	mov r3, r4
	ldr r3, [r3]
	add r0, r4, #4
	ldr r0, [r0]
	mov r1, r0
	mov r0, r3
	bl calcPower
	movw r1, #:lower16:1000000
	movt r1, #:upper16:1000000
	mov r3, #0
	cmp r5, r1
	movlt r3, #1
	cmp r3, #1
	beq .LU9
	b .LU10
.LU10:
	mov r3, r0
	mov r1, r3
	movw r0, #:lower16:.PRINTLN_FMT
	movt r0, #:upper16:.PRINTLN_FMT
	bl printf
	movw r3, #0
	b .LU4
.LU4:
	mov r0, r3
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
