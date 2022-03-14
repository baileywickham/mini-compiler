	.arch armv7-a
	.comm	.read_scratch,4,4

	.text
	.align 2
	.global main
main:
.LU33:
	push {fp, lr}
	add fp, sp, #4
	push {r4, r5, r6, r7, r8, r9}
	movw r1, #:lower16:.read_scratch
	movt r1, #:upper16:.read_scratch
	movw r0, #:lower16:.READ_FMT
	movt r0, #:upper16:.READ_FMT
	bl scanf
	movw r4, #:lower16:.read_scratch
	movt r4, #:upper16:.read_scratch
	ldr r4, [r4]
	movw r1, #:lower16:.read_scratch
	movt r1, #:upper16:.read_scratch
	movw r0, #:lower16:.READ_FMT
	movt r0, #:upper16:.READ_FMT
	bl scanf
	movw r5, #:lower16:.read_scratch
	movt r5, #:upper16:.read_scratch
	ldr r6, [r5]
	mul r5, r4, r4
	movw r0, #8
	bl malloc
	mov r7, r0
	mov r1, r7
	mov r7, r1
	str r5, [r7]
	add r7, r1, #4
	movw r2, #0
	str r2, [r7]
	sub r3, r6, #1
	mov r2, #0
	cmp r3, #0
	movgt r2, #1
	movw r6, #0
	mov r7, r5
	cmp r2, #1
	beq .inline1_LU2
	b .inline1_LU3
.inline1_LU2:
	mov r5, r3
	mov r6, r1
	mul r7, r7, r7
	mov r1, r4
	mov r0, r7
	bl __aeabi_idiv
	mov r7, r0
	movw r1, #2
	mov r0, r4
	bl __aeabi_idiv
	mov r1, r0
	mul r7, r7, r1
	add r7, r7, #1
	movw r1, #:lower16:1000000000
	movt r1, #:upper16:1000000000
	mov r0, r7
	bl __aeabi_idiv
	mov r2, r0
	movw r1, #:lower16:1000000000
	movt r1, #:upper16:1000000000
	mul r1, r2, r1
	sub r7, r7, r1
	movw r0, #8
	bl malloc
	mov r1, r0
	mov r2, r1
	str r7, [r2]
	add r2, r1, #4
	str r6, [r2]
	sub r2, r5, #1
	mov r5, #0
	cmp r2, #0
	movgt r5, #1
	mov r6, r1
	mov r3, r2
	cmp r5, #1
	beq .inline1_LU2
	b .inline1_LU3
.inline1_LU3:
	mov r4, r6
	mov r5, #0
	cmp r4, #0
	movne r5, #1
	movw r6, #0
	movw r7, #0
	movw r2, #0
	movw r1, #0
	movw r0, #0
	mov r8, r4
	movw r9, #0
	cmp r5, #1
	beq .inline2_LU6
	b .inline2_LU7
.inline2_LU6:
	mov r5, r9
	mov r6, r8
	mov r7, r0
	add r1, r1, #1
	mov r2, r6
	ldr r2, [r2]
	add r0, r7, r2
	add r6, r6, #4
	ldr r8, [r6]
	mov r3, #0
	cmp r8, #0
	movne r3, #1
	mov r6, r1
	mov r7, r0
	mov r2, r5
	mov r9, r5
	cmp r3, #1
	beq .inline2_LU6
	b .inline2_LU7
.inline2_LU7:
	mov r1, r2
	mov r5, r7
	mov r7, r6
	mov r6, #0
	cmp r7, #0
	movne r6, #1
	cmp r6, #1
	beq .inline2_LU8
	b .inline2_LU9
.inline2_LU8:
	mov r1, r7
	mov r0, r5
	bl __aeabi_idiv
	mov r5, r0
	b .inline2_LU10
.inline2_LU9:
	mov r5, r1
	b .inline2_LU10
.inline2_LU10:
	mov r1, r5
	movw r0, #:lower16:.PRINTLN_FMT
	movt r0, #:upper16:.PRINTLN_FMT
	bl printf
	mov r0, #0
	cmp r4, #0
	movne r0, #1
	movw r6, #0
	movw r7, #0
	movw r2, #1
	mov r3, r4
	movw r1, #0
	movw r5, #0
	cmp r0, #1
	beq .inline3_LU21
	b .inline3_LU22
.inline3_LU21:
	mov r7, r5
	mov r6, r3
	mov r5, r2
	mov r2, r5
	cmp r2, #1
	beq .inline3_LU23
	b .inline3_LU24
.inline3_LU23:
	mov r5, r6
	ldr r5, [r5]
	mov r7, r6
	ldr r7, [r7]
	mov r1, r5
	movw r5, #0
	b .inline3_LU25
.inline3_LU24:
	mov r2, r6
	ldr r3, [r2]
	mov r2, #0
	cmp r3, r1
	movlt r2, #1
	cmp r2, #1
	beq .inline3_LU26
	b .inline3_LU27
.inline3_LU26:
	mov r1, r6
	ldr r1, [r1]
	b .inline3_LU28
.inline3_LU27:
	mov r2, r6
	ldr r3, [r2]
	mov r2, #0
	cmp r3, r7
	movgt r2, #1
	cmp r2, #1
	beq .inline3_LU29
	b .inline3_LU30
.inline3_LU29:
	mov r7, r6
	ldr r7, [r7]
	b .inline3_LU31
.inline3_LU30:
	b .inline3_LU31
.inline3_LU31:
	b .inline3_LU28
.inline3_LU28:
	b .inline3_LU25
.inline3_LU25:
	mov r2, r5
	mov r5, r7
	add r6, r6, #4
	ldr r3, [r6]
	mov r0, #0
	cmp r3, #0
	movne r0, #1
	mov r6, r1
	mov r7, r5
	cmp r0, #1
	beq .inline3_LU21
	b .inline3_LU22
.inline3_LU22:
	mov r5, r7
	mov r1, r6
	movw r0, #:lower16:.PRINTLN_FMT
	movt r0, #:upper16:.PRINTLN_FMT
	bl printf
	mov r1, r5
	movw r0, #:lower16:.PRINTLN_FMT
	movt r0, #:upper16:.PRINTLN_FMT
	bl printf
	mov r5, #0
	cmp r4, #0
	movne r5, #1
	mov r6, r4
	cmp r5, #1
	beq .inline4_LU17
	b .inline4_LU18
.inline4_LU17:
	mov r4, r6
	mov r5, r4
	ldr r1, [r5]
	movw r5, #0
	mov r6, #0
	cmp r5, r1
	movlt r6, #1
	movw r5, #1
	movw r7, #1
	cmp r6, #1
	beq .inline4_inline0_LU13
	b .inline4_inline0_LU14
.inline4_inline0_LU13:
	mov r2, r1
	mov r5, r7
	mul r1, r5, r5
	add r7, r5, #1
	mov r6, #0
	cmp r1, r2
	movlt r6, #1
	mov r1, r2
	cmp r6, #1
	beq .inline4_inline0_LU13
	b .inline4_inline0_LU14
.inline4_inline0_LU14:
	mov r1, r5
	movw r0, #:lower16:.PRINTLN_FMT
	movt r0, #:upper16:.PRINTLN_FMT
	bl printf
	add r4, r4, #4
	ldr r5, [r4]
	mov r4, #0
	cmp r5, #0
	movne r4, #1
	mov r6, r5
	cmp r4, #1
	beq .inline4_LU17
	b .inline4_LU18
.inline4_LU18:
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
