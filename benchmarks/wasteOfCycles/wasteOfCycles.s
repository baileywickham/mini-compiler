	.arch armv7-a


	.text
	.align 2
	.global function
function:
.LU1:
	push {fp, lr}
	add fp, sp, #4
	sub sp, sp, #16
	mov r3, r0
	str r3, [sp, #0]
	ldr r0, [sp, #0]
	mov r3, #0
	cmp r0, #0
	movle r3, #1
	cmp r3, #1
	beq .LU2
	b .LU3
.LU2:
	movw r3, #0
	str r3, [sp, #4]
	b .LU0
.LU3:
	movw r3, #0
	str r3, [sp, #8]
	ldr r3, [sp, #8]
	ldr r1, [sp, #0]
	ldr r0, [sp, #0]
	mul r1, r1, r0
	mov r0, #0
	cmp r3, r1
	movlt r0, #1
	cmp r0, #1
	beq .LU4
	b .LU5
.LU4:
	ldr r3, [sp, #8]
	ldr r0, [sp, #0]
	add r3, r3, r0
	str r3, [sp, #12]
	ldr r3, [sp, #12]
	mov r1, r3
	movw r0, #:lower16:.PRINT_FMT
	movt r0, #:upper16:.PRINT_FMT
	bl printf
	ldr r3, [sp, #8]
	add r3, r3, #1
	str r3, [sp, #8]
	ldr r1, [sp, #8]
	ldr r3, [sp, #0]
	ldr r0, [sp, #0]
	mul r3, r3, r0
	mov r0, #0
	cmp r1, r3
	movlt r0, #1
	cmp r0, #1
	beq .LU4
	b .LU5
.LU5:
	ldr r3, [sp, #0]
	sub r3, r3, #1
	mov r0, r3
	bl function
	mov r3, r0
	str r3, [sp, #4]
	b .LU0
.LU0:
	ldr r3, [sp, #4]
	mov r0, r3
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
