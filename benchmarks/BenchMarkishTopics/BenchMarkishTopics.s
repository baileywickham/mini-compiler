	.arch armv7-a
	.comm	.read_scratch,4,4
	.comm	intList,4,4

	.text
	.align 2
	.global length
length:
.LU1:
	push {fp, lr}
	add fp, sp, #4
	mov r2, r0
	mov r3, #0
	cmp r2, #0
	moveq r3, #1
	cmp r3, #1
	beq .LU2
	b .LU3
.LU2:
	movw r2, #0
	b .LU0
.LU3:
	b .LU4
.LU4:
	add r2, r2, #4
	ldr r2, [r2]
	mov r0, r2
	bl length
	mov r3, r0
	movw r2, #1
	add r2, r2, r3
	b .LU0
.LU0:
	mov r0, r2
	pop {fp, pc}
	.size length, .-length
	.align 2
	.global addToFront
addToFront:
.LU6:
	push {fp, lr}
	add fp, sp, #4
	push {r4, r5}
	mov r4, r0
	mov r5, r1
	mov r2, #0
	cmp r4, #0
	moveq r2, #1
	cmp r2, #1
	beq .LU7
	b .LU8
.LU7:
	movw r0, #8
	bl malloc
	mov r2, r0
	mov r0, r2
	str r5, [r0]
	add r0, r2, #4
	movw r4, #0
	str r4, [r0]
	b .LU5
.LU8:
	b .LU9
.LU9:
	movw r0, #8
	bl malloc
	mov r2, r0
	mov r0, r2
	mov r2, r0
	str r5, [r2]
	add r2, r0, #4
	str r4, [r2]
	mov r2, r0
	b .LU5
.LU5:
	mov r0, r2
	pop {r4, r5}
	pop {fp, pc}
	.size addToFront, .-addToFront
	.align 2
	.global deleteFirst
deleteFirst:
.LU11:
	push {fp, lr}
	add fp, sp, #4
	push {r4}
	mov r3, r0
	mov r0, #0
	cmp r3, #0
	moveq r0, #1
	cmp r0, #1
	beq .LU12
	b .LU13
.LU12:
	movw r3, #0
	b .LU10
.LU13:
	b .LU14
.LU14:
	add r0, r3, #4
	ldr r4, [r0]
	mov r0, r3
	bl free
	mov r3, r4
	b .LU10
.LU10:
	mov r0, r3
	pop {r4}
	pop {fp, pc}
	.size deleteFirst, .-deleteFirst
	.align 2
	.global main
main:
.LU16:
	push {fp, lr}
	add fp, sp, #4
	push {r4, r5, r6}
	movw r1, #:lower16:.read_scratch
	movt r1, #:upper16:.read_scratch
	movw r0, #:lower16:.READ_FMT
	movt r0, #:upper16:.READ_FMT
	bl scanf
	movw r4, #:lower16:.read_scratch
	movt r4, #:upper16:.read_scratch
	ldr r1, [r4]
	movw r4, #:lower16:intList
	movt r4, #:upper16:intList
	str r1, [r4]
	movw r4, #:lower16:intList
	movt r4, #:upper16:intList
	ldr r4, [r4]
	mov r3, #0
	cmp r4, #0
	movgt r3, #1
	movw r1, #0
	movw r2, #0
	movw r4, #0
	movw r5, #0
	cmp r3, #1
	beq .LU17
	b .LU18
.LU17:
	movw r1, #:lower16:intList
	movt r1, #:upper16:intList
	ldr r6, [r1]
	mov r1, #0
	cmp r4, #0
	moveq r1, #1
	cmp r1, #1
	beq .inline0_LU7
	b .inline0_LU8
.inline0_LU7:
	movw r0, #8
	bl malloc
	mov r4, r0
	mov r1, r4
	mov r4, r1
	str r6, [r4]
	add r2, r1, #4
	movw r4, #0
	str r4, [r2]
	mov r4, r1
	b .inline0_LU5
.inline0_LU8:
	b .inline0_LU9
.inline0_LU9:
	movw r0, #8
	bl malloc
	mov r1, r0
	mov r2, r1
	str r6, [r2]
	add r2, r1, #4
	str r4, [r2]
	mov r4, r1
	b .inline0_LU5
.inline0_LU5:
	mov r1, r4
	ldr r1, [r1]
	movw r0, #:lower16:.PRINT_FMT
	movt r0, #:upper16:.PRINT_FMT
	bl printf
	movw r1, #:lower16:intList
	movt r1, #:upper16:intList
	ldr r1, [r1]
	sub r1, r1, #1
	movw r2, #:lower16:intList
	movt r2, #:upper16:intList
	str r1, [r2]
	movw r1, #:lower16:intList
	movt r1, #:upper16:intList
	ldr r1, [r1]
	mov r3, #0
	cmp r1, #0
	movgt r3, #1
	mov r1, r4
	mov r2, r5
	cmp r3, #1
	beq .LU17
	b .LU18
.LU18:
	mov r4, r2
	mov r5, r1
	mov r0, r5
	bl length
	mov r1, r0
	movw r0, #:lower16:.PRINT_FMT
	movt r0, #:upper16:.PRINT_FMT
	bl printf
	mov r0, r4
	bl length
	mov r1, r0
	mov r3, #0
	cmp r1, #0
	movgt r3, #1
	mov r1, r4
	mov r2, r4
	mov r4, r5
	cmp r3, #1
	beq .LU19
	b .LU20
.LU19:
	mov r5, r2
	mov r1, r4
	ldr r1, [r1]
	add r6, r5, r1
	mov r0, r4
	bl length
	mov r1, r0
	movw r0, #:lower16:.PRINT_FMT
	movt r0, #:upper16:.PRINT_FMT
	bl printf
	mov r1, #0
	cmp r4, #0
	moveq r1, #1
	cmp r1, #1
	beq .inline1_LU12
	b .inline1_LU13
.inline1_LU12:
	movw r4, #0
	b .inline1_LU10
.inline1_LU13:
	b .inline1_LU14
.inline1_LU14:
	add r1, r4, #4
	ldr r5, [r1]
	mov r0, r4
	bl free
	mov r4, r5
	b .inline1_LU10
.inline1_LU10:
	mov r0, r4
	bl length
	mov r1, r0
	mov r5, #0
	cmp r1, #0
	movgt r5, #1
	mov r1, r6
	mov r2, r6
	cmp r5, #1
	beq .LU19
	b .LU20
.LU20:
	mov r4, r1
	mov r1, r4
	movw r0, #:lower16:.PRINTLN_FMT
	movt r0, #:upper16:.PRINTLN_FMT
	bl printf
	b .LU15
.LU15:
	movw r0, #0
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
