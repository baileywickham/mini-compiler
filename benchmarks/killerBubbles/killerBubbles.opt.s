	.arch armv7-a
	.comm	.read_scratch,4,4
	.comm	swapped,4,4

	.text
	.align 2
	.global main
main:
.LU16:
	push {fp, lr}
	add fp, sp, #4
	push {r4, r5, r6, r7}
	movw r4, #666
	movw r5, #:lower16:swapped
	movt r5, #:upper16:swapped
	str r4, [r5]
	movw r1, #:lower16:.read_scratch
	movt r1, #:upper16:.read_scratch
	movw r0, #:lower16:.READ_FMT
	movt r0, #:upper16:.READ_FMT
	bl scanf
	movw r4, #:lower16:.read_scratch
	movt r4, #:upper16:.read_scratch
	ldr r4, [r4]
	mov r5, #0
	cmp r4, #0
	movle r5, #1
	cmp r5, #1
	beq .LU17
	b .LU18
.LU17:
	movw r1, #:lower16:-1
	movt r1, #:upper16:-1
	movw r0, #:lower16:.PRINTLN_FMT
	movt r0, #:upper16:.PRINTLN_FMT
	bl printf
	movw r4, #:lower16:-1
	movt r4, #:upper16:-1
	b .LU15
.LU18:
	movw r5, #1000
	mul r4, r4, r5
	movw r0, #12
	bl malloc
	mov r5, r0
	mov r6, r5
	mov r5, r6
	str r4, [r5]
	add r5, r6, #4
	str r6, [r5]
	add r5, r6, #8
	str r6, [r5]
	sub r1, r4, #1
	mov r4, #0
	cmp r1, #0
	movgt r4, #1
	mov r5, r6
	mov r2, r1
	mov r1, r6
	mov r0, r6
	cmp r4, #1
	beq .LU20
	b .LU21
.LU20:
	mov r4, r0
	mov r6, r1
	mov r5, r2
	movw r0, #12
	bl malloc
	mov r1, r0
	mov r2, r1
	str r5, [r2]
	add r2, r1, #4
	str r6, [r2]
	add r2, r1, #8
	str r4, [r2]
	add r6, r6, #8
	str r1, [r6]
	sub r2, r5, #1
	mov r6, #0
	cmp r2, #0
	movgt r6, #1
	mov r5, r4
	mov r0, r4
	cmp r6, #1
	beq .LU20
	b .LU21
.LU21:
	mov r4, r5
	mov r6, r4
	movw r5, #1
	cmp r5, #1
	beq .inline2_LU4
	b .inline2_LU5
.inline2_LU4:
	mov r1, r6
	add r5, r1, #8
	ldr r6, [r5]
	mov r5, #0
	cmp r6, r1
	movne r5, #1
	movw r6, #0
	mov r2, r1
	mov r7, r1
	mov r3, r1
	movw r1, #0
	cmp r5, #1
	beq .inline2_LU6
	b .inline2_LU7
.inline2_LU6:
	mov r5, r3
	mov r6, r7
	add r2, r6, #8
	ldr r0, [r2]
	mov r2, r6
	ldr r2, [r2]
	ldr r0, [r0]
	sub r2, r2, r0
	mov r0, #0
	cmp r2, #0
	movgt r0, #1
	cmp r0, #1
	beq .inline2_LU8
	b .inline2_LU9
.inline2_LU8:
	mov r1, r6
	ldr r1, [r1]
	add r2, r6, #8
	ldr r2, [r2]
	ldr r0, [r2]
	mov r2, r6
	str r0, [r2]
	add r2, r6, #8
	ldr r2, [r2]
	str r1, [r2]
	mov r2, r6
	mov r6, r5
	movw r5, #1
	b .inline2_LU10
.inline2_LU9:
	mov r2, r6
	mov r6, r5
	mov r5, r1
	b .inline2_LU10
.inline2_LU10:
	mov r1, r6
	mov r6, r2
	add r6, r6, #8
	ldr r3, [r6]
	add r6, r3, #8
	ldr r6, [r6]
	mov r0, #0
	cmp r6, r1
	movne r0, #1
	mov r6, r5
	mov r2, r1
	mov r7, r3
	mov r3, r1
	mov r1, r5
	cmp r0, #1
	beq .inline2_LU6
	b .inline2_LU7
.inline2_LU7:
	mov r1, r2
	mov r5, #0
	cmp r6, #1
	moveq r5, #1
	mov r6, r1
	cmp r5, #1
	beq .inline2_LU4
	b .inline2_LU5
.inline2_LU5:
	add r5, r4, #8
	ldr r5, [r5]
	mov r6, r4
	ldr r6, [r6]
	mov r1, r6
	movw r0, #:lower16:.PRINTLN_FMT
	movt r0, #:upper16:.PRINTLN_FMT
	bl printf
	mov r6, r4
	mov r0, r6
	bl free
	mov r6, #0
	cmp r5, r4
	movne r6, #1
	cmp r6, #1
	beq .inline1_LU13
	b .inline1_LU14
.inline1_LU13:
	mov r6, r5
	ldr r6, [r6]
	mov r1, r6
	movw r0, #:lower16:.PRINTLN_FMT
	movt r0, #:upper16:.PRINTLN_FMT
	bl printf
	add r6, r5, #8
	ldr r6, [r6]
	mov r0, r5
	bl free
	mov r1, #0
	cmp r6, r4
	movne r1, #1
	mov r5, r6
	cmp r1, #1
	beq .inline1_LU13
	b .inline1_LU14
.inline1_LU14:
	movw r4, #0
	b .LU15
.LU15:
	mov r0, r4
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
