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
	.global main
main:
.LU16:
	push {fp, lr}
	add fp, sp, #4
	push {r4, r5, r6, r7}
	movw r1, #:lower16:.read_scratch
	movt r1, #:upper16:.read_scratch
	movw r0, #:lower16:.READ_FMT
	movt r0, #:upper16:.READ_FMT
	bl scanf
	movw r2, #:lower16:.read_scratch
	movt r2, #:upper16:.read_scratch
	ldr r4, [r2]
	movw r2, #:lower16:intList
	movt r2, #:upper16:intList
	str r4, [r2]
	movw r2, #:lower16:intList
	movt r2, #:upper16:intList
	ldr r2, [r2]
	mov r3, #0
	cmp r2, #0
	movgt r3, #1
	movw r2, #0
	movw r5, #0
	movw r4, #0
	movw r1, #0
	cmp r3, #1
	beq .LU17
	b .LU18
.LU17:
	mov r6, r1
	mov r7, r4
	movw r2, #:lower16:intList
	movt r2, #:upper16:intList
	ldr r4, [r2]
	movw r1, #1111
	movw r0, #:lower16:.PRINTLN_FMT
	movt r0, #:upper16:.PRINTLN_FMT
	bl printf
	mov r2, #0
	cmp r7, #0
	moveq r2, #1
	cmp r2, #1
	beq .inline0_LU7
	b .inline0_LU8
.inline0_LU7:
	movw r1, #2222
	movw r0, #:lower16:.PRINTLN_FMT
	movt r0, #:upper16:.PRINTLN_FMT
	bl printf
	movw r0, #8
	bl malloc
	mov r2, r0
	mov r5, r2
	mov r2, r5
	str r4, [r2]
	add r4, r5, #4
	movw r2, #0
	str r2, [r4]
	mov r2, r5
	b .inline0_LU5
.inline0_LU8:
	b .inline0_LU9
.inline0_LU9:
	movw r1, #3333
	movw r0, #:lower16:.PRINTLN_FMT
	movt r0, #:upper16:.PRINTLN_FMT
	bl printf
	movw r0, #8
	bl malloc
	mov r2, r0
	mov r5, r2
	movw r1, #4444
	movw r0, #:lower16:.PRINTLN_FMT
	movt r0, #:upper16:.PRINTLN_FMT
	bl printf
	mov r2, r5
	str r4, [r2]
	movw r1, #5555
	movw r0, #:lower16:.PRINTLN_FMT
	movt r0, #:upper16:.PRINTLN_FMT
	bl printf
	add r2, r5, #4
	str r7, [r2]
	movw r1, #6666
	movw r0, #:lower16:.PRINTLN_FMT
	movt r0, #:upper16:.PRINTLN_FMT
	bl printf
	mov r2, r5
	b .inline0_LU5
.inline0_LU5:
	mov r4, r2
	movw r1, #7777
	movw r0, #:lower16:.PRINTLN_FMT
	movt r0, #:upper16:.PRINTLN_FMT
	bl printf
	mov r2, r4
	ldr r2, [r2]
	mov r1, r2
	movw r0, #:lower16:.PRINT_FMT
	movt r0, #:upper16:.PRINT_FMT
	bl printf
	movw r1, #8888
	movw r0, #:lower16:.PRINTLN_FMT
	movt r0, #:upper16:.PRINTLN_FMT
	bl printf
	movw r2, #:lower16:intList
	movt r2, #:upper16:intList
	ldr r2, [r2]
	sub r2, r2, #1
	movw r5, #:lower16:intList
	movt r5, #:upper16:intList
	str r2, [r5]
	movw r1, #9999
	movw r0, #:lower16:.PRINTLN_FMT
	movt r0, #:upper16:.PRINTLN_FMT
	bl printf
	movw r2, #:lower16:intList
	movt r2, #:upper16:intList
	ldr r2, [r2]
	mov r3, #0
	cmp r2, #0
	movgt r3, #1
	mov r2, r4
	mov r5, r6
	mov r1, r6
	cmp r3, #1
	beq .LU17
	b .LU18
.LU18:
	mov r4, r5
	mov r5, r2
	movw r1, #111
	movw r0, #:lower16:.PRINTLN_FMT
	movt r0, #:upper16:.PRINTLN_FMT
	bl printf
	mov r0, r5
	bl length
	mov r2, r0
	mov r1, r2
	movw r0, #:lower16:.PRINT_FMT
	movt r0, #:upper16:.PRINT_FMT
	bl printf
	movw r1, #222
	movw r0, #:lower16:.PRINTLN_FMT
	movt r0, #:upper16:.PRINTLN_FMT
	bl printf
	mov r0, r5
	bl length
	mov r2, r0
	mov r1, #0
	cmp r2, #0
	movgt r1, #1
	mov r2, r4
	mov r3, r4
	mov r4, r5
	cmp r1, #1
	beq .LU19
	b .LU20
.LU19:
	mov r5, r4
	mov r4, r3
	movw r1, #333
	movw r0, #:lower16:.PRINTLN_FMT
	movt r0, #:upper16:.PRINTLN_FMT
	bl printf
	mov r2, r5
	ldr r2, [r2]
	add r6, r4, r2
	movw r1, #444
	movw r0, #:lower16:.PRINTLN_FMT
	movt r0, #:upper16:.PRINTLN_FMT
	bl printf
	mov r0, r5
	bl length
	mov r2, r0
	mov r1, r2
	movw r0, #:lower16:.PRINT_FMT
	movt r0, #:upper16:.PRINT_FMT
	bl printf
	movw r1, #555
	movw r0, #:lower16:.PRINTLN_FMT
	movt r0, #:upper16:.PRINTLN_FMT
	bl printf
	mov r2, #0
	cmp r5, #0
	moveq r2, #1
	cmp r2, #1
	beq .inline1_LU12
	b .inline1_LU13
.inline1_LU12:
	movw r2, #0
	b .inline1_LU10
.inline1_LU13:
	b .inline1_LU14
.inline1_LU14:
	add r2, r5, #4
	ldr r4, [r2]
	mov r2, r5
	mov r0, r2
	bl free
	mov r2, r4
	b .inline1_LU10
.inline1_LU10:
	mov r4, r2
	movw r1, #666
	movw r0, #:lower16:.PRINTLN_FMT
	movt r0, #:upper16:.PRINTLN_FMT
	bl printf
	mov r0, r4
	bl length
	mov r2, r0
	mov r5, #0
	cmp r2, #0
	movgt r5, #1
	mov r2, r6
	mov r3, r6
	cmp r5, #1
	beq .LU19
	b .LU20
.LU20:
	mov r1, r2
	movw r0, #:lower16:.PRINTLN_FMT
	movt r0, #:upper16:.PRINTLN_FMT
	bl printf
	b .LU15
.LU15:
	movw r0, #0
	pop {r4, r5, r6, r7}
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
