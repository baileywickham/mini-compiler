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
	push {r4, r5, r6}
	movw r3, #666
	movw r1, #:lower16:swapped
	movt r1, #:upper16:swapped
	str r3, [r1]
	movw r1, #:lower16:.read_scratch
	movt r1, #:upper16:.read_scratch
	movw r0, #:lower16:.READ_FMT
	movt r0, #:upper16:.READ_FMT
	bl scanf
	movw r1, #:lower16:.read_scratch
	movt r1, #:upper16:.read_scratch
	ldr r3, [r1]
	mov r1, #0
	cmp r3, #0
	movle r1, #1
	cmp r1, #1
	beq .LU17
	b .LU18
.LU17:
	movw r1, #:lower16:-1
	movt r1, #:upper16:-1
	movw r0, #:lower16:.PRINTLN_FMT
	movt r0, #:upper16:.PRINTLN_FMT
	bl printf
	movw r1, #:lower16:-1
	movt r1, #:upper16:-1
	b .LU15
.LU18:
	b .LU19
.LU19:
	movw r1, #1000
	mul r4, r3, r1
	movw r0, #12
	bl malloc
	mov r1, r0
	mov r2, r1
	mov r1, r2
	str r4, [r1]
	add r1, r2, #4
	str r2, [r1]
	add r1, r2, #8
	str r2, [r1]
	sub r1, r4, #1
	mov r5, #0
	cmp r1, #0
	movgt r5, #1
	mov r0, r2
	mov r3, r1
	mov r1, r2
	mov r4, r2
	cmp r5, #1
	beq .LU20
	b .LU21
.LU20:
	mov r5, r4
	mov r6, r1
	mov r4, r3
	movw r0, #12
	bl malloc
	mov r1, r0
	mov r3, r1
	str r4, [r3]
	add r3, r1, #4
	str r6, [r3]
	add r3, r1, #8
	str r5, [r3]
	add r3, r6, #8
	str r1, [r3]
	sub r3, r4, #1
	mov r2, #0
	cmp r3, #0
	movgt r2, #1
	mov r0, r5
	mov r4, r5
	cmp r2, #1
	beq .LU20
	b .LU21
.LU21:
	mov r5, r0
	b .inline2_LU3
.inline2_LU3:
	mov r1, r5
	movw r3, #1
	cmp r3, #1
	beq .inline2_LU4
	b .inline2_LU5
.inline2_LU4:
	mov r3, r1
	add r1, r3, #8
	ldr r1, [r1]
	mov r0, #0
	cmp r1, r3
	movne r0, #1
	movw r1, #0
	mov r2, r3
	mov r6, r3
	mov r4, r3
	movw r3, #0
	cmp r0, #1
	beq .inline2_LU6
	b .inline2_LU7
.inline2_LU6:
	mov r1, r3
	mov r3, r4
	mov r2, r6
	add r0, r2, #8
	ldr r0, [r0]
	b .inline2_inline0_LU1
.inline2_inline0_LU1:
	mov r4, r2
	ldr r4, [r4]
	ldr r0, [r0]
	sub r0, r4, r0
	b .inline2_inline0_LU0
.inline2_inline0_LU0:
	b .inline2_next0
.inline2_next0:
	mov r4, #0
	cmp r0, #0
	movgt r4, #1
	cmp r4, #1
	beq .inline2_LU8
	b .inline2_LU9
.inline2_LU8:
	mov r1, r2
	ldr r1, [r1]
	add r0, r2, #8
	ldr r0, [r0]
	ldr r0, [r0]
	mov r4, r2
	str r0, [r4]
	add r0, r2, #8
	ldr r0, [r0]
	str r1, [r0]
	mov r0, r3
	movw r1, #1
	b .inline2_LU10
.inline2_LU9:
	mov r0, r3
	b .inline2_LU10
.inline2_LU10:
	mov r3, r1
	mov r4, r0
	mov r1, r2
	add r1, r1, #8
	ldr r6, [r1]
	add r1, r6, #8
	ldr r1, [r1]
	mov r0, #0
	cmp r1, r4
	movne r0, #1
	mov r1, r3
	mov r2, r4
	cmp r0, #1
	beq .inline2_LU6
	b .inline2_LU7
.inline2_LU7:
	mov r3, r2
	mov r2, #0
	cmp r1, #1
	moveq r2, #1
	mov r1, r3
	cmp r2, #1
	beq .inline2_LU4
	b .inline2_LU5
.inline2_LU5:
	b .inline2_LU2
.inline2_LU2:
	b .next2
.next2:
	b .inline1_LU12
.inline1_LU12:
	add r1, r5, #8
	ldr r4, [r1]
	mov r1, r5
	ldr r1, [r1]
	movw r0, #:lower16:.PRINTLN_FMT
	movt r0, #:upper16:.PRINTLN_FMT
	bl printf
	mov r1, r5
	mov r0, r1
	bl free
	mov r1, #0
	cmp r4, r5
	movne r1, #1
	mov r3, r4
	mov r2, r5
	cmp r1, #1
	beq .inline1_LU13
	b .inline1_LU14
.inline1_LU13:
	mov r5, r2
	mov r4, r3
	mov r1, r4
	ldr r1, [r1]
	movw r0, #:lower16:.PRINTLN_FMT
	movt r0, #:upper16:.PRINTLN_FMT
	bl printf
	add r1, r4, #8
	ldr r6, [r1]
	mov r1, r4
	mov r0, r1
	bl free
	mov r1, #0
	cmp r6, r5
	movne r1, #1
	mov r3, r6
	mov r2, r5
	cmp r1, #1
	beq .inline1_LU13
	b .inline1_LU14
.inline1_LU14:
	b .inline1_LU11
.inline1_LU11:
	b .next1
.next1:
	movw r1, #0
	b .LU15
.LU15:
	mov r0, r1
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
