	.arch armv7-a
	.comm	intList,4,4

	.text
	.align 2
	.global length
length:
.LU1:
	push {fp, lr}
	add fp, sp, #4
	sub sp, sp, #8
	mov r3, r0
	str r3, [sp, #0]
	ldr r3, [sp, #0]
	mov r0, #0
	cmp r3, #0
	moveq r0, #1
	cmp r0, #1
	beq .LU2
	b .LU3
.LU2:
	movw r3, #0
	str r3, [sp, #4]
	b .LU0
.LU3:
	ldr r3, [sp, #0]
	add r3, r3, #4
	ldr r3, [r3]
	mov r0, r3
	bl length
	mov r3, r0
	movw r0, #1
	add r3, r0, r3
	str r3, [sp, #4]
	b .LU0
.LU0:
	ldr r3, [sp, #4]
	mov r0, r3
	add sp, sp, #8
	pop {fp, pc}
	.size length, .-length
	.align 2
	.global addToFront
addToFront:
.LU5:
	push {fp, lr}
	add fp, sp, #4
	sub sp, sp, #16
	mov r3, r0
	mov r0, r1
	str r3, [sp, #0]
	str r0, [sp, #4]
	ldr r3, [sp, #0]
	mov r0, #0
	cmp r3, #0
	moveq r0, #1
	cmp r0, #1
	beq .LU6
	b .LU7
.LU6:
	movw r0, #8
	bl malloc
	mov r3, r0
	str r3, [sp, #0]
	ldr r0, [sp, #4]
	ldr r3, [sp, #0]
	str r0, [r3]
	ldr r3, [sp, #0]
	add r0, r3, #4
	movw r3, #0
	str r3, [r0]
	ldr r3, [sp, #0]
	str r3, [sp, #8]
	b .LU4
.LU7:
	movw r0, #8
	bl malloc
	mov r3, r0
	str r3, [sp, #12]
	ldr r0, [sp, #4]
	ldr r3, [sp, #12]
	str r0, [r3]
	ldr r0, [sp, #0]
	ldr r3, [sp, #12]
	add r3, r3, #4
	str r0, [r3]
	ldr r3, [sp, #12]
	str r3, [sp, #8]
	b .LU4
.LU4:
	ldr r3, [sp, #8]
	mov r0, r3
	add sp, sp, #16
	pop {fp, pc}
	.size addToFront, .-addToFront
	.align 2
	.global deleteFirst
deleteFirst:
.LU9:
	push {fp, lr}
	add fp, sp, #4
	sub sp, sp, #12
	mov r2, r0
	str r2, [sp, #0]
	ldr r0, [sp, #0]
	mov r2, #0
	cmp r0, #0
	moveq r2, #1
	cmp r2, #1
	beq .LU10
	b .LU11
.LU10:
	movw r2, #0
	str r2, [sp, #4]
	b .LU8
.LU11:
	ldr r2, [sp, #0]
	str r2, [sp, #8]
	ldr r2, [sp, #0]
	add r2, r2, #4
	ldr r2, [r2]
	str r2, [sp, #0]
	ldr r2, [sp, #8]
	mov r0, r2
	bl free
	ldr r2, [sp, #0]
	str r2, [sp, #4]
	b .LU8
.LU8:
	ldr r2, [sp, #4]
	mov r0, r2
	add sp, sp, #12
	pop {fp, pc}
	.size deleteFirst, .-deleteFirst
	.align 2
	.global main
main:
.LU13:
	push {fp, lr}
	add fp, sp, #4
	sub sp, sp, #12
	movw r1, #:lower16:intList
	movt r1, #:upper16:intList
	movw r0, #:lower16:.READ_FMT
	movt r0, #:upper16:.READ_FMT
	bl scanf
	movw r2, #0
	str r2, [sp, #8]
	movw r2, #0
	str r2, [sp, #4]
	movw r2, #:lower16:intList
	movt r2, #:upper16:intList
	ldr r0, [r2]
	mov r2, #0
	cmp r0, #0
	movgt r2, #1
	cmp r2, #1
	beq .LU14
	b .LU15
.LU14:
	ldr r2, [sp, #4]
	movw r0, #:lower16:intList
	movt r0, #:upper16:intList
	ldr r0, [r0]
	mov r1, r0
	mov r0, r2
	bl addToFront
	mov r2, r0
	str r2, [sp, #4]
	ldr r2, [sp, #4]
	ldr r2, [r2]
	mov r1, r2
	movw r0, #:lower16:.PRINT_FMT
	movt r0, #:upper16:.PRINT_FMT
	bl printf
	movw r2, #:lower16:intList
	movt r2, #:upper16:intList
	ldr r2, [r2]
	sub r0, r2, #1
	movw r2, #:lower16:intList
	movt r2, #:upper16:intList
	str r0, [r2]
	movw r2, #:lower16:intList
	movt r2, #:upper16:intList
	ldr r0, [r2]
	mov r2, #0
	cmp r0, #0
	movgt r2, #1
	cmp r2, #1
	beq .LU14
	b .LU15
.LU15:
	ldr r2, [sp, #4]
	mov r0, r2
	bl length
	mov r2, r0
	mov r1, r2
	movw r0, #:lower16:.PRINT_FMT
	movt r0, #:upper16:.PRINT_FMT
	bl printf
	ldr r2, [sp, #4]
	mov r0, r2
	bl length
	mov r2, r0
	mov r0, #0
	cmp r2, #0
	movgt r0, #1
	cmp r0, #1
	beq .LU16
	b .LU17
.LU16:
	ldr r0, [sp, #8]
	ldr r2, [sp, #4]
	ldr r2, [r2]
	add r2, r0, r2
	str r2, [sp, #8]
	ldr r2, [sp, #4]
	mov r0, r2
	bl length
	mov r2, r0
	mov r1, r2
	movw r0, #:lower16:.PRINT_FMT
	movt r0, #:upper16:.PRINT_FMT
	bl printf
	ldr r2, [sp, #4]
	mov r0, r2
	bl deleteFirst
	mov r2, r0
	str r2, [sp, #4]
	ldr r2, [sp, #4]
	mov r0, r2
	bl length
	mov r2, #0
	cmp r0, #0
	movgt r2, #1
	cmp r2, #1
	beq .LU16
	b .LU17
.LU17:
	ldr r2, [sp, #8]
	mov r1, r2
	movw r0, #:lower16:.PRINTLN_FMT
	movt r0, #:upper16:.PRINTLN_FMT
	bl printf
	movw r2, #0
	str r2, [sp, #0]
	b .LU12
.LU12:
	ldr r2, [sp, #0]
	mov r0, r2
	add sp, sp, #12
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
