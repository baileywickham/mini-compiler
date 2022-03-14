	.arch armv7-a


	.text
	.align 2
	.global function
function:
.LU1:
	push {fp, lr}
	add fp, sp, #4
	sub sp, sp, #16
	mov r1, r0
	str r1, [sp, #0]
	ldr r1, [sp, #0]
	mov r2, #0
	cmp r1, #0
	movle r2, #1
	cmp r2, #1
	beq .LU2
	b .LU3
.LU2:
	movw r1, #0
	str r1, [sp, #4]
	b .LU0
.LU3:
	movw r1, #0
	str r1, [sp, #8]
	ldr r1, [sp, #8]
	ldr r2, [sp, #0]
	ldr r0, [sp, #0]
	mul r0, r2, r0
	mov r2, #0
	cmp r1, r0
	movlt r2, #1
	cmp r2, #1
	beq .LU4
	b .LU5
.LU4:
	ldr r2, [sp, #8]
	ldr r1, [sp, #0]
	add r1, r2, r1
	str r1, [sp, #12]
	ldr r1, [sp, #12]
	movw r0, #:lower16:.PRINT_FMT
	movt r0, #:upper16:.PRINT_FMT
	bl printf
	ldr r1, [sp, #8]
	add r1, r1, #1
	str r1, [sp, #8]
	ldr r1, [sp, #8]
	ldr r0, [sp, #0]
	ldr r2, [sp, #0]
	mul r0, r0, r2
	mov r2, #0
	cmp r1, r0
	movlt r2, #1
	cmp r2, #1
	beq .LU4
	b .LU5
.LU5:
	ldr r1, [sp, #0]
	sub r1, r1, #1
	mov r0, r1
	bl function
	mov r1, r0
	str r1, [sp, #4]
	b .LU0
.LU0:
	ldr r1, [sp, #4]
	mov r0, r1
	add sp, sp, #16
	pop {fp, pc}
	.size function, .-function
	.align 2
	.global main
main:
.LU7:
	push {fp, lr}
	add fp, sp, #4
	sub sp, sp, #8
	add r1, sp, #4
	movw r0, #:lower16:.READ_FMT
	movt r0, #:upper16:.READ_FMT
	bl scanf
	ldr r2, [sp, #4]
	mov r0, r2
	bl function
	movw r1, #0
	movw r0, #:lower16:.PRINTLN_FMT
	movt r0, #:upper16:.PRINTLN_FMT
	bl printf
	movw r2, #0
	str r2, [sp, #0]
	b .LU6
.LU6:
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
