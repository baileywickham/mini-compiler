	.arch armv7-a
	.comm	.read_scratch,4,4

	.text
	.align 2
	.global computeFib
computeFib:
.LU1:
	push {fp, lr}
	add fp, sp, #4
	push {r4, r5}
	mov r4, r0
	mov r2, #0
	cmp r4, #0
	moveq r2, #1
	cmp r2, #1
	beq .LU2
	b .LU3
.LU2:
	movw r2, #0
	b .LU0
.LU3:
	mov r2, #0
	cmp r4, #2
	movle r2, #1
	cmp r2, #1
	beq .LU5
	b .LU6
.LU5:
	movw r2, #1
	b .LU0
.LU6:
	sub r2, r4, #1
	mov r0, r2
	bl computeFib
	mov r5, r0
	sub r2, r4, #2
	mov r0, r2
	bl computeFib
	mov r2, r0
	add r2, r5, r2
	b .LU0
.LU0:
	mov r0, r2
	pop {r4, r5}
	pop {fp, pc}
	.size computeFib, .-computeFib
	.align 2
	.global main
main:
.LU9:
	push {fp, lr}
	add fp, sp, #4
	movw r1, #:lower16:.read_scratch
	movt r1, #:upper16:.read_scratch
	movw r0, #:lower16:.READ_FMT
	movt r0, #:upper16:.READ_FMT
	bl scanf
	movw r2, #:lower16:.read_scratch
	movt r2, #:upper16:.read_scratch
	ldr r2, [r2]
	mov r0, r2
	bl computeFib
	mov r2, r0
	mov r1, r2
	movw r0, #:lower16:.PRINTLN_FMT
	movt r0, #:upper16:.PRINTLN_FMT
	bl printf
	b .LU8
.LU8:
	movw r0, #0
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
