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
	mov r1, r0
	add r4, r1, #4
	ldr r4, [r4]
	mov r2, #0
	cmp r4, #0
	moveq r2, #1
	cmp r2, #1
	beq .LU12
	b .LU13
.LU12:
	mov r4, r1
	ldr r4, [r4]
	b .LU10
.LU13:
	mov r4, r1
	ldr r4, [r4]
	add r1, r1, #4
	ldr r1, [r1]
	mov r0, r1
	bl recurseList
	mov r1, r0
	mul r4, r4, r1
	b .LU10
.LU10:
	mov r0, r4
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
	movw r0, #8
	bl malloc
	mov r4, r0
	movw r0, #8
	bl malloc
	mov r5, r0
	mov r9, r5
	movw r0, #8
	bl malloc
	mov r5, r0
	movw r0, #8
	bl malloc
	mov r6, r0
	movw r0, #8
	bl malloc
	mov r7, r0
	movw r0, #8
	bl malloc
	mov r8, r0
	movw r1, #:lower16:.read_scratch
	movt r1, #:upper16:.read_scratch
	movw r0, #:lower16:.READ_FMT
	movt r0, #:upper16:.READ_FMT
	bl scanf
	movw r1, #:lower16:.read_scratch
	movt r1, #:upper16:.read_scratch
	ldr r2, [r1]
	mov r1, r4
	str r2, [r1]
	movw r1, #:lower16:.read_scratch
	movt r1, #:upper16:.read_scratch
	movw r0, #:lower16:.READ_FMT
	movt r0, #:upper16:.READ_FMT
	bl scanf
	movw r1, #:lower16:.read_scratch
	movt r1, #:upper16:.read_scratch
	ldr r2, [r1]
	mov r1, r9
	str r2, [r1]
	movw r1, #:lower16:.read_scratch
	movt r1, #:upper16:.read_scratch
	movw r0, #:lower16:.READ_FMT
	movt r0, #:upper16:.READ_FMT
	bl scanf
	movw r1, #:lower16:.read_scratch
	movt r1, #:upper16:.read_scratch
	ldr r1, [r1]
	mov r2, r5
	str r1, [r2]
	movw r1, #:lower16:.read_scratch
	movt r1, #:upper16:.read_scratch
	movw r0, #:lower16:.READ_FMT
	movt r0, #:upper16:.READ_FMT
	bl scanf
	movw r1, #:lower16:.read_scratch
	movt r1, #:upper16:.read_scratch
	ldr r1, [r1]
	mov r2, r6
	str r1, [r2]
	movw r1, #:lower16:.read_scratch
	movt r1, #:upper16:.read_scratch
	movw r0, #:lower16:.READ_FMT
	movt r0, #:upper16:.READ_FMT
	bl scanf
	movw r1, #:lower16:.read_scratch
	movt r1, #:upper16:.read_scratch
	ldr r1, [r1]
	mov r2, r7
	str r1, [r2]
	movw r1, #:lower16:.read_scratch
	movt r1, #:upper16:.read_scratch
	movw r0, #:lower16:.READ_FMT
	movt r0, #:upper16:.READ_FMT
	bl scanf
	movw r1, #:lower16:.read_scratch
	movt r1, #:upper16:.read_scratch
	ldr r2, [r1]
	mov r1, r8
	str r2, [r1]
	add r1, r4, #4
	str r9, [r1]
	add r9, r9, #4
	str r5, [r9]
	add r5, r5, #4
	str r6, [r5]
	add r5, r6, #4
	str r7, [r5]
	add r5, r7, #4
	str r8, [r5]
	add r5, r8, #4
	movw r6, #0
	str r6, [r5]
	mov r5, r4
	ldr r5, [r5]
	add r6, r4, #4
	ldr r7, [r6]
	mov r6, r5
	movw r9, #0
	movw r8, #1
	cmp r8, #1
	beq .inline1_LU4
	b .inline1_LU5
.inline1_LU4:
	mov r6, r9
	mov r8, r7
	ldr r8, [r8]
	mul r5, r5, r8
	add r7, r7, #4
	ldr r7, [r7]
	mov r1, r5
	movw r0, #:lower16:.PRINTLN_FMT
	movt r0, #:upper16:.PRINTLN_FMT
	bl printf
	add r9, r6, #1
	mov r8, #0
	cmp r9, #5
	movlt r8, #1
	mov r6, r5
	cmp r8, #1
	beq .inline1_LU4
	b .inline1_LU5
.inline1_LU5:
	mov r5, r6
	mov r6, r4
	ldr r7, [r6]
	add r6, r4, #4
	ldr r8, [r6]
	mov r6, r7
	mov r9, r8
	movw r1, #0
	movw r8, #1
	cmp r8, #1
	beq .inline2_LU8
	b .inline2_LU9
.inline2_LU8:
	mov r6, r1
	mov r8, r9
	mov r9, r8
	ldr r9, [r9]
	add r7, r7, r9
	add r8, r8, #4
	ldr r9, [r8]
	mov r1, r7
	movw r0, #:lower16:.PRINTLN_FMT
	movt r0, #:upper16:.PRINTLN_FMT
	bl printf
	add r1, r6, #1
	mov r8, #0
	cmp r1, #5
	movlt r8, #1
	mov r6, r7
	cmp r8, #1
	beq .inline2_LU8
	b .inline2_LU9
.inline2_LU9:
	movw r1, #2
	mov r0, r6
	bl __aeabi_idiv
	mov r6, r0
	sub r9, r5, r6
	movw r5, #0
	mov r6, r9
	movw r7, #0
	mov r8, r4
	movw r1, #0
	mov r4, r9
	movw r9, #1
	cmp r9, #1
	beq .LU17
	b .LU18
.LU17:
	mov r5, r1
	mov r0, r8
	bl recurseList
	mov r6, r0
	add r7, r7, r6
	add r1, r5, #1
	mov r9, #0
	cmp r1, #2
	movlt r9, #1
	mov r5, r7
	mov r6, r4
	cmp r9, #1
	beq .LU17
	b .LU18
.LU18:
	mov r8, r6
	mov r6, r5
	mov r1, r6
	movw r0, #:lower16:.PRINTLN_FMT
	movt r0, #:upper16:.PRINTLN_FMT
	bl printf
	mov r7, #0
	cmp r6, #0
	movne r7, #1
	mov r4, r8
	mov r5, r6
	cmp r7, #1
	beq .LU19
	b .LU20
.LU19:
	mov r4, r6
	sub r6, r4, #1
	mov r7, #0
	cmp r6, #0
	movne r7, #1
	mov r4, r8
	mov r5, r6
	cmp r7, #1
	beq .LU19
	b .LU20
.LU20:
	mov r1, r4
	movw r0, #:lower16:.PRINTLN_FMT
	movt r0, #:upper16:.PRINTLN_FMT
	bl printf
	mov r1, r5
	movw r0, #:lower16:.PRINTLN_FMT
	movt r0, #:upper16:.PRINTLN_FMT
	bl printf
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
