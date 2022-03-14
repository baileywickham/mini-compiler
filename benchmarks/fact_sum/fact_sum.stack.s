	.arch armv7-a


	.text
	.align 2
	.global sum
sum:
.LU1:
	push {fp, lr}
	add fp, sp, #4
	sub sp, sp, #12
	str r0, [sp, #0]
	str r1, [sp, #4]
	ldr r1, [sp, #0]
	ldr r0, [sp, #4]
	add r1, r1, r0
	str r1, [sp, #8]
	b .LU0
.LU0:
	ldr r1, [sp, #8]
	mov r0, r1
	add sp, sp, #12
	pop {fp, pc}
	.size sum, .-sum
	.align 2
	.global fact
fact:
.LU3:
	push {fp, lr}
	add fp, sp, #4
	push {r4}
	sub sp, sp, #12
	mov r4, r0
	str r4, [sp, #0]
	ldr r1, [sp, #0]
	mov r4, #0
	cmp r1, #1
	moveq r4, #1
	ldr r1, [sp, #0]
	mov r2, #0
	cmp r1, #0
	moveq r2, #1
	orr r4, r4, r2
	cmp r4, #1
	beq .LU4
	b .LU5
.LU4:
	movw r4, #1
	str r4, [sp, #4]
	b .LU2
.LU5:
	ldr r4, [sp, #0]
	mov r1, #0
	cmp r4, #1
	movle r1, #1
	cmp r1, #1
	beq .LU6
	b .LU7
.LU6:
	movw r4, #0
	sub r4, r4, #1
	ldr r1, [sp, #0]
	mul r4, r4, r1
	mov r0, r4
	bl fact
	mov r4, r0
	str r4, [sp, #4]
	b .LU2
.LU7:
	ldr r4, [sp, #0]
	ldr r1, [sp, #0]
	sub r1, r1, #1
	mov r0, r1
	bl fact
	mov r1, r0
	mul r4, r4, r1
	str r4, [sp, #8]
	ldr r4, [sp, #8]
	str r4, [sp, #4]
	b .LU2
.LU2:
	ldr r4, [sp, #4]
	mov r0, r4
	add sp, sp, #12
	pop {r4}
	pop {fp, pc}
	.size fact, .-fact
	.align 2
	.global main
main:
.LU9:
	push {fp, lr}
	add fp, sp, #4
	sub sp, sp, #16
	movw r1, #0
	str r1, [sp, #12]
	ldr r1, [sp, #12]
	movw r2, #0
	sub r2, r2, #1
	mov r0, #0
	cmp r1, r2
	movne r0, #1
	cmp r0, #1
	beq .LU10
	b .LU11
.LU10:
	add r1, sp, #4
	movw r0, #:lower16:.READ_FMT
	movt r0, #:upper16:.READ_FMT
	bl scanf
	add r1, sp, #8
	movw r0, #:lower16:.READ_FMT
	movt r0, #:upper16:.READ_FMT
	bl scanf
	ldr r1, [sp, #4]
	mov r0, r1
	bl fact
	mov r1, r0
	str r1, [sp, #4]
	ldr r1, [sp, #8]
	mov r0, r1
	bl fact
	mov r1, r0
	str r1, [sp, #8]
	ldr r2, [sp, #4]
	ldr r1, [sp, #8]
	mov r0, r2
	bl sum
	mov r1, r0
	movw r0, #:lower16:.PRINTLN_FMT
	movt r0, #:upper16:.PRINTLN_FMT
	bl printf
	add r1, sp, #12
	movw r0, #:lower16:.READ_FMT
	movt r0, #:upper16:.READ_FMT
	bl scanf
	ldr r1, [sp, #12]
	movw r2, #0
	sub r0, r2, #1
	mov r2, #0
	cmp r1, r0
	movne r2, #1
	cmp r2, #1
	beq .LU10
	b .LU11
.LU11:
	movw r1, #0
	str r1, [sp, #0]
	b .LU8
.LU8:
	ldr r1, [sp, #0]
	mov r0, r1
	add sp, sp, #16
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
