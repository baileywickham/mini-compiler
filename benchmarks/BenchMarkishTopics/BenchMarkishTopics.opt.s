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
	mov r1, #0
	cmp r0, #0
	moveq r1, #1
	cmp r1, #1
	beq .LU2
	b .LU3
.LU2:
	movw r0, #0
	b .LU0
.LU3:
	add r0, r0, #4
	ldr r0, [r0]
	bl length
	mov r1, r0
	movw r0, #1
	add r0, r0, r1
	b .LU0
.LU0:
	pop {fp, pc}
	.size length, .-length
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
	ldr r5, [r4]
	movw r4, #:lower16:intList
	movt r4, #:upper16:intList
	str r5, [r4]
	movw r4, #:lower16:intList
	movt r4, #:upper16:intList
	ldr r4, [r4]
	mov r5, #0
	cmp r4, #0
	movgt r5, #1
	movw r2, #0
	movw r1, #0
	movw r0, #0
	movw r4, #0
	cmp r5, #1
	beq .LU17
	b .LU18
.LU17:
	mov r6, r0
	movw r5, #:lower16:intList
	movt r5, #:upper16:intList
	ldr r5, [r5]
	mov r1, #0
	cmp r6, #0
	moveq r1, #1
	cmp r1, #1
	beq .inline0_LU7
	b .inline0_LU8
.inline0_LU7:
	movw r0, #8
	bl malloc
	mov r6, r0
	mov r1, r6
	str r5, [r1]
	add r1, r6, #4
	movw r5, #0
	str r5, [r1]
	mov r5, r6
	b .inline0_LU5
.inline0_LU8:
	movw r0, #8
	bl malloc
	mov r1, r0
	mov r2, r1
	str r5, [r2]
	add r5, r1, #4
	str r6, [r5]
	mov r5, r1
	b .inline0_LU5
.inline0_LU5:
	mov r6, r5
	ldr r6, [r6]
	mov r1, r6
	movw r0, #:lower16:.PRINT_FMT
	movt r0, #:upper16:.PRINT_FMT
	bl printf
	movw r6, #:lower16:intList
	movt r6, #:upper16:intList
	ldr r6, [r6]
	sub r6, r6, #1
	movw r1, #:lower16:intList
	movt r1, #:upper16:intList
	str r6, [r1]
	movw r6, #:lower16:intList
	movt r6, #:upper16:intList
	ldr r1, [r6]
	mov r6, #0
	cmp r1, #0
	movgt r6, #1
	mov r2, r5
	mov r1, r4
	mov r0, r5
	cmp r6, #1
	beq .LU17
	b .LU18
.LU18:
	mov r5, r1
	mov r4, r2
	mov r0, r4
	bl length
	mov r6, r0
	mov r1, r6
	movw r0, #:lower16:.PRINT_FMT
	movt r0, #:upper16:.PRINT_FMT
	bl printf
	mov r0, r4
	bl length
	mov r1, r0
	mov r6, #0
	cmp r1, #0
	movgt r6, #1
	mov r1, r5
	mov r2, r5
	cmp r6, #1
	beq .LU19
	b .LU20
.LU19:
	mov r5, r4
	mov r4, r2
	mov r6, r5
	ldr r6, [r6]
	add r4, r4, r6
	mov r0, r5
	bl length
	mov r6, r0
	mov r1, r6
	movw r0, #:lower16:.PRINT_FMT
	movt r0, #:upper16:.PRINT_FMT
	bl printf
	mov r6, #0
	cmp r5, #0
	moveq r6, #1
	cmp r6, #1
	beq .inline1_LU12
	b .inline1_LU13
.inline1_LU12:
	movw r5, #0
	b .inline1_LU10
.inline1_LU13:
	add r6, r5, #4
	ldr r6, [r6]
	mov r0, r5
	bl free
	mov r5, r6
	b .inline1_LU10
.inline1_LU10:
	mov r0, r5
	bl length
	mov r1, r0
	mov r6, #0
	cmp r1, #0
	movgt r6, #1
	mov r1, r4
	mov r2, r4
	mov r4, r5
	cmp r6, #1
	beq .LU19
	b .LU20
.LU20:
	mov r4, r1
	mov r1, r4
	movw r0, #:lower16:.PRINTLN_FMT
	movt r0, #:upper16:.PRINTLN_FMT
	bl printf
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
