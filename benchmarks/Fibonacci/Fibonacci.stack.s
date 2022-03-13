	.arch armv7-a


	.text
	.align 2
	.global computeFib
computeFib:
.LU1:
	push {fp, lr}
	add fp, sp, #4
	push {r4}
	sub sp, sp, #8
	mov r4, r0
	str r4, [sp, #0]
	ldr r4, [sp, #0]
	mov r1, #0
	cmp r4, #0
	moveq r1, #1
	cmp r1, #1
	beq .LU2
	b .LU3
.LU2:
	movw r4, #0
	str r4, [sp, #4]
	b .LU0
.LU3:
	ldr r4, [sp, #0]
	mov r1, #0
	cmp r4, #2
	movle r1, #1
	cmp r1, #1
	beq .LU5
	b .LU6
.LU5:
	movw r4, #1
	str r4, [sp, #4]
	b .LU0
.LU6:
	ldr r4, [sp, #0]
	sub r4, r4, #1
	mov r0, r4
	bl computeFib
	mov r4, r0
	ldr r1, [sp, #0]
	sub r1, r1, #2
	mov r0, r1
	bl computeFib
	mov r1, r0
	add r4, r4, r1
	str r4, [sp, #4]
	b .LU0
.LU7:
	b .LU4
.LU4:
	b .LU0
.LU0:
	ldr r4, [sp, #4]
	mov r0, r4
	add sp, sp, #8
	pop {r4}
	pop {fp, pc}
	.size computeFib, .-computeFib
	.align 2
	.global main
main:
.LU9:
	push {fp, lr}
	add fp, sp, #4
	sub sp, sp, #8
	add r1, sp, #4
	movw r0, #:lower16:.READ_FMT
	movt r0, #:upper16:.READ_FMT
	bl scanf
	ldr r2, [sp, #4]
	mov r0, r2
	bl computeFib
	mov r2, r0
	mov r1, r2
	movw r0, #:lower16:.PRINTLN_FMT
	movt r0, #:upper16:.PRINTLN_FMT
	bl printf
	movw r2, #0
	str r2, [sp, #0]
	b .LU8
.LU8:
	ldr r2, [sp, #0]
	mov r0, r2
	add sp, sp, #8
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
