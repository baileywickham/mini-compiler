	.arch armv7-a


	.text
	.align 2
	.global sum
sum:
.LU1:
	push {fp, lr}
	add fp, sp, #4
	sub sp, sp, #12
	mov r3, r0
	mov r0, r1
	str r3, [sp, #0]
	str r0, [sp, #4]
	ldr r0, [sp, #0]
	ldr r3, [sp, #4]
	add r3, r0, r3
	str r3, [sp, #8]
	b .LU0
.LU0:
	ldr r3, [sp, #8]
	mov r0, r3
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
	mov r2, r0
	str r2, [sp, #0]
	ldr r2, [sp, #0]
	mov r0, #0
	cmp r2, #1
	moveq r0, #1
	ldr r3, [sp, #0]
	mov r2, #0
	cmp r3, #0
	moveq r2, #1
	orr r2, r0, r2
	cmp r2, #1
	beq .LU4
	b .LU5
.LU4:
	movw r2, #1
	str r2, [sp, #4]
	b .LU2
.LU5:
	ldr r3, [sp, #0]
	mov r2, #0
	cmp r3, #1
	movle r2, #1
	cmp r2, #1
	beq .LU6
	b .LU7
.LU6:
	movw r2, #0
	sub r3, r2, #1
	ldr r2, [sp, #0]
	mul r2, r3, r2
	mov r0, r2
	bl fact
	mov r2, r0
	str r2, [sp, #4]
	b .LU2
.LU7:
	ldr r4, [sp, #0]
	ldr r2, [sp, #0]
	sub r2, r2, #1
	mov r0, r2
	bl fact
	mov r2, r0
	mul r2, r4, r2
	str r2, [sp, #8]
	ldr r2, [sp, #8]
	str r2, [sp, #4]
	b .LU2
.LU2:
	ldr r2, [sp, #4]
	mov r0, r2
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
	movw r3, #0
	str r3, [sp, #12]
	ldr r1, [sp, #12]
	movw r3, #0
	sub r3, r3, #1
	mov r0, #0
	cmp r1, r3
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
	ldr r3, [sp, #4]
	mov r0, r3
	bl fact
	mov r3, r0
	str r3, [sp, #4]
	ldr r3, [sp, #8]
	mov r0, r3
	bl fact
	mov r3, r0
	str r3, [sp, #8]
	ldr r3, [sp, #4]
	ldr r0, [sp, #8]
	mov r1, r0
	mov r0, r3
	bl sum
	mov r3, r0
	mov r1, r3
	movw r0, #:lower16:.PRINTLN_FMT
	movt r0, #:upper16:.PRINTLN_FMT
	bl printf
	add r1, sp, #12
	movw r0, #:lower16:.READ_FMT
	movt r0, #:upper16:.READ_FMT
	bl scanf
	ldr r1, [sp, #12]
	movw r3, #0
	sub r0, r3, #1
	mov r3, #0
	cmp r1, r0
	movne r3, #1
	cmp r3, #1
	beq .LU10
	b .LU11
.LU11:
	movw r3, #0
	str r3, [sp, #0]
	b .LU8
.LU8:
	ldr r3, [sp, #0]
	mov r0, r3
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
