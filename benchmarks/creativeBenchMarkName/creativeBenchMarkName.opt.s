	.arch armv7-a
	.comm	.read_scratch,4,4

	.text
	.align 2
	.global recurseList
recurseList:
.LU11:
	push {fp, lr}
	add fp, sp, #4
	push {r4}
	mov r2, r0
	add r0, r2, #4
	ldr r1, [r0]
	mov r0, #0
	cmp r1, #0
	moveq r0, #1
	cmp r0, #1
	beq .LU12
	b .LU13
.LU12:
	ldr r2, [r2]
	b .LU10
.LU13:
	mov r0, r2
	ldr r4, [r0]
	add r2, r2, #4
	ldr r2, [r2]
	mov r0, r2
	bl recurseList
	mov r2, r0
	mul r2, r4, r2
	b .LU10
.LU10:
	mov r0, r2
	pop {r4}
	pop {fp, pc}
	.size recurseList, .-recurseList
	.align 2
	.global main
main:
.LU16:
	push {fp, lr}
	add fp, sp, #4
	push {r4, r5, r6, r7, r8, r9}
	b .inline0_LU1
.inline0_LU1:
	movw r0, #8
	bl malloc
	mov r2, r0
	mov r7, r2
	movw r0, #8
	bl malloc
	mov r2, r0
	mov r4, r2
	movw r0, #8
	bl malloc
	mov r2, r0
	mov r9, r2
	movw r0, #8
	bl malloc
	mov r2, r0
	mov r5, r2
	movw r0, #8
	bl malloc
	mov r2, r0
	mov r6, r2
	movw r0, #8
	bl malloc
	mov r2, r0
	mov r8, r2
	movw r1, #:lower16:.read_scratch
	movt r1, #:upper16:.read_scratch
	movw r0, #:lower16:.READ_FMT
	movt r0, #:upper16:.READ_FMT
	bl scanf
	movw r2, #:lower16:.read_scratch
	movt r2, #:upper16:.read_scratch
	ldr r2, [r2]
	mov r0, r7
	str r2, [r0]
	movw r1, #:lower16:.read_scratch
	movt r1, #:upper16:.read_scratch
	movw r0, #:lower16:.READ_FMT
	movt r0, #:upper16:.READ_FMT
	bl scanf
	movw r2, #:lower16:.read_scratch
	movt r2, #:upper16:.read_scratch
	ldr r0, [r2]
	mov r2, r4
	str r0, [r2]
	movw r1, #:lower16:.read_scratch
	movt r1, #:upper16:.read_scratch
	movw r0, #:lower16:.READ_FMT
	movt r0, #:upper16:.READ_FMT
	bl scanf
	movw r2, #:lower16:.read_scratch
	movt r2, #:upper16:.read_scratch
	ldr r2, [r2]
	mov r0, r9
	str r2, [r0]
	movw r1, #:lower16:.read_scratch
	movt r1, #:upper16:.read_scratch
	movw r0, #:lower16:.READ_FMT
	movt r0, #:upper16:.READ_FMT
	bl scanf
	movw r2, #:lower16:.read_scratch
	movt r2, #:upper16:.read_scratch
	ldr r2, [r2]
	mov r0, r5
	str r2, [r0]
	movw r1, #:lower16:.read_scratch
	movt r1, #:upper16:.read_scratch
	movw r0, #:lower16:.READ_FMT
	movt r0, #:upper16:.READ_FMT
	bl scanf
	movw r2, #:lower16:.read_scratch
	movt r2, #:upper16:.read_scratch
	ldr r2, [r2]
	mov r0, r6
	str r2, [r0]
	movw r1, #:lower16:.read_scratch
	movt r1, #:upper16:.read_scratch
	movw r0, #:lower16:.READ_FMT
	movt r0, #:upper16:.READ_FMT
	bl scanf
	movw r2, #:lower16:.read_scratch
	movt r2, #:upper16:.read_scratch
	ldr r0, [r2]
	mov r2, r8
	str r0, [r2]
	add r2, r7, #4
	str r4, [r2]
	add r2, r4, #4
	str r9, [r2]
	add r2, r9, #4
	str r5, [r2]
	add r2, r5, #4
	str r6, [r2]
	add r2, r6, #4
	str r8, [r2]
	add r2, r8, #4
	movw r4, #0
	str r4, [r2]
	b .inline0_LU0
.inline0_LU0:
	b .next0
.next0:
	b .inline1_LU3
.inline1_LU3:
	mov r2, r7
	ldr r4, [r2]
	add r2, r7, #4
	ldr r2, [r2]
	mov r3, r4
	mov r0, r4
	mov r4, r2
	movw r2, #0
	movw r5, #1
	cmp r5, #1
	beq .inline1_LU4
	b .inline1_LU5
.inline1_LU4:
	mov r6, r2
	mov r2, r4
	mov r4, r2
	ldr r4, [r4]
	mul r5, r0, r4
	add r2, r2, #4
	ldr r4, [r2]
	mov r1, r5
	movw r0, #:lower16:.PRINTLN_FMT
	movt r0, #:upper16:.PRINTLN_FMT
	bl printf
	add r2, r6, #1
	mov r6, #0
	cmp r2, #5
	movlt r6, #1
	mov r3, r5
	mov r0, r5
	cmp r6, #1
	beq .inline1_LU4
	b .inline1_LU5
.inline1_LU5:
	mov r4, r3
	b .inline1_LU2
.inline1_LU2:
	b .next1
.next1:
	b .inline2_LU7
.inline2_LU7:
	mov r2, r7
	ldr r2, [r2]
	add r0, r7, #4
	ldr r0, [r0]
	mov r8, r2
	mov r5, r0
	movw r6, #0
	movw r0, #1
	cmp r0, #1
	beq .inline2_LU8
	b .inline2_LU9
.inline2_LU8:
	mov r8, r6
	mov r0, r5
	mov r5, r2
	mov r2, r0
	ldr r2, [r2]
	add r6, r5, r2
	add r2, r0, #4
	ldr r5, [r2]
	mov r1, r6
	movw r0, #:lower16:.PRINTLN_FMT
	movt r0, #:upper16:.PRINTLN_FMT
	bl printf
	add r3, r8, #1
	mov r0, #0
	cmp r3, #5
	movlt r0, #1
	mov r8, r6
	mov r2, r6
	mov r6, r3
	cmp r0, #1
	beq .inline2_LU8
	b .inline2_LU9
.inline2_LU9:
	mov r2, r8
	b .inline2_LU6
.inline2_LU6:
	b .next2
.next2:
	movw r1, #2
	mov r0, r2
	bl __aeabi_idiv
	mov r2, r0
	sub r6, r4, r2
	movw r0, #0
	mov r5, r6
	movw r2, #0
	mov r4, r7
	movw r3, #0
	movw r7, #1
	cmp r7, #1
	beq .LU17
	b .LU18
.LU17:
	mov r7, r3
	mov r5, r2
	mov r0, r4
	bl recurseList
	mov r2, r0
	add r2, r5, r2
	add r3, r7, #1
	mov r7, #0
	cmp r3, #2
	movlt r7, #1
	mov r0, r2
	mov r5, r6
	cmp r7, #1
	beq .LU17
	b .LU18
.LU18:
	mov r4, r5
	mov r5, r0
	mov r1, r5
	movw r0, #:lower16:.PRINTLN_FMT
	movt r0, #:upper16:.PRINTLN_FMT
	bl printf
	mov r6, #0
	cmp r5, #0
	movne r6, #1
	mov r2, r4
	mov r0, r5
	cmp r6, #1
	beq .LU19
	b .LU20
.LU19:
	mov r2, r5
	sub r5, r2, #1
	mov r6, #0
	cmp r5, #0
	movne r6, #1
	mov r2, r4
	mov r0, r5
	cmp r6, #1
	beq .LU19
	b .LU20
.LU20:
	mov r4, r0
	mov r1, r2
	movw r0, #:lower16:.PRINTLN_FMT
	movt r0, #:upper16:.PRINTLN_FMT
	bl printf
	mov r1, r4
	movw r0, #:lower16:.PRINTLN_FMT
	movt r0, #:upper16:.PRINTLN_FMT
	bl printf
	b .LU15
.LU15:
	movw r0, #0
	pop {r4, r5, r6, r7, r8, r9}
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
