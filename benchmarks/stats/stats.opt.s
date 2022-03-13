	.arch armv7-a
	.comm	.read_scratch,4,4

	.text
	.align 2
	.global main
main:
.LU33:
	push {fp, lr}
	add fp, sp, #4
	push {r4, r5, r6, r7, r8}
	movw r1, #:lower16:.read_scratch
	movt r1, #:upper16:.read_scratch
	movw r0, #:lower16:.READ_FMT
	movt r0, #:upper16:.READ_FMT
	bl scanf
	movw r2, #:lower16:.read_scratch
	movt r2, #:upper16:.read_scratch
	ldr r4, [r2]
	movw r1, #:lower16:.read_scratch
	movt r1, #:upper16:.read_scratch
	movw r0, #:lower16:.READ_FMT
	movt r0, #:upper16:.READ_FMT
	bl scanf
	movw r2, #:lower16:.read_scratch
	movt r2, #:upper16:.read_scratch
	ldr r6, [r2]
	b .inline1_LU1
.inline1_LU1:
	mul r5, r4, r4
	movw r0, #8
	bl malloc
	mov r2, r0
	mov r3, r2
	mov r2, r3
	str r5, [r2]
	add r2, r3, #4
	movw r0, #0
	str r0, [r2]
	sub r6, r6, #1
	mov r0, #0
	cmp r6, #0
	movgt r0, #1
	movw r7, #0
	mov r2, r5
	mov r1, r4
	mov r5, r6
	cmp r0, #1
	beq .inline1_LU2
	b .inline1_LU3
.inline1_LU2:
	mov r7, r5
	mov r4, r3
	mov r5, r1
	mul r2, r2, r2
	mov r1, r5
	mov r0, r2
	bl __aeabi_idiv
	mov r6, r0
	movw r1, #2
	mov r0, r5
	bl __aeabi_idiv
	mov r2, r0
	mul r2, r6, r2
	add r6, r2, #1
	movw r1, #:lower16:1000000000
	movt r1, #:upper16:1000000000
	mov r0, r6
	bl __aeabi_idiv
	mov r3, r0
	movw r2, #:lower16:1000000000
	movt r2, #:upper16:1000000000
	mul r2, r3, r2
	sub r6, r6, r2
	movw r0, #8
	bl malloc
	mov r2, r0
	mov r3, r2
	mov r2, r3
	str r6, [r2]
	add r2, r3, #4
	str r4, [r2]
	sub r0, r7, #1
	mov r4, #0
	cmp r0, #0
	movgt r4, #1
	mov r7, r3
	mov r2, r6
	mov r1, r5
	mov r5, r0
	cmp r4, #1
	beq .inline1_LU2
	b .inline1_LU3
.inline1_LU3:
	b .inline1_LU0
.inline1_LU0:
	b .next1
.next1:
	b .inline2_LU5
.inline2_LU5:
	mov r2, #0
	cmp r7, #0
	movne r2, #1
	movw r6, #0
	movw r4, #0
	movw r5, #0
	movw r1, #0
	movw r0, #0
	mov r8, r7
	movw r3, #0
	cmp r2, #1
	beq .inline2_LU6
	b .inline2_LU7
.inline2_LU6:
	mov r2, r8
	add r1, r1, #1
	mov r4, r2
	ldr r4, [r4]
	add r0, r0, r4
	add r2, r2, #4
	ldr r8, [r2]
	mov r2, #0
	cmp r8, #0
	movne r2, #1
	mov r6, r1
	mov r4, r0
	mov r5, r3
	cmp r2, #1
	beq .inline2_LU6
	b .inline2_LU7
.inline2_LU7:
	mov r2, r5
	mov r3, r4
	mov r0, r6
	mov r1, #0
	cmp r0, #0
	movne r1, #1
	cmp r1, #1
	beq .inline2_LU8
	b .inline2_LU9
.inline2_LU8:
	mov r1, r0
	mov r0, r3
	bl __aeabi_idiv
	mov r2, r0
	b .inline2_LU10
.inline2_LU9:
	b .inline2_LU10
.inline2_LU10:
	b .inline2_LU4
.inline2_LU4:
	b .next2
.next2:
	mov r1, r2
	movw r0, #:lower16:.PRINTLN_FMT
	movt r0, #:upper16:.PRINTLN_FMT
	bl printf
	b .inline3_LU20
.inline3_LU20:
	mov r1, #0
	cmp r7, #0
	movne r1, #1
	movw r6, #0
	movw r4, #0
	movw r2, #1
	mov r0, r7
	movw r3, #0
	movw r5, #0
	cmp r1, #1
	beq .inline3_LU21
	b .inline3_LU22
.inline3_LU21:
	mov r1, r5
	mov r4, r0
	mov r5, r2
	mov r2, r5
	cmp r2, #1
	beq .inline3_LU23
	b .inline3_LU24
.inline3_LU23:
	mov r2, r4
	ldr r3, [r2]
	mov r2, r4
	ldr r2, [r2]
	mov r0, r4
	mov r4, r2
	movw r2, #0
	b .inline3_LU25
.inline3_LU24:
	mov r2, r4
	ldr r0, [r2]
	mov r2, #0
	cmp r0, r3
	movlt r2, #1
	cmp r2, #1
	beq .inline3_LU26
	b .inline3_LU27
.inline3_LU26:
	mov r2, r4
	ldr r3, [r2]
	mov r2, r4
	mov r0, r1
	mov r1, r5
	b .inline3_LU28
.inline3_LU27:
	mov r2, r4
	ldr r0, [r2]
	mov r2, #0
	cmp r0, r1
	movgt r2, #1
	cmp r2, #1
	beq .inline3_LU29
	b .inline3_LU30
.inline3_LU29:
	mov r2, r4
	ldr r0, [r2]
	mov r2, r4
	mov r1, r5
	b .inline3_LU31
.inline3_LU30:
	mov r2, r4
	mov r0, r1
	mov r1, r5
	b .inline3_LU31
.inline3_LU31:
	b .inline3_LU28
.inline3_LU28:
	mov r4, r0
	mov r0, r2
	mov r2, r1
	b .inline3_LU25
.inline3_LU25:
	mov r5, r4
	add r0, r0, #4
	ldr r0, [r0]
	mov r1, #0
	cmp r0, #0
	movne r1, #1
	mov r6, r3
	mov r4, r5
	cmp r1, #1
	beq .inline3_LU21
	b .inline3_LU22
.inline3_LU22:
	mov r2, r6
	mov r1, r2
	movw r0, #:lower16:.PRINTLN_FMT
	movt r0, #:upper16:.PRINTLN_FMT
	bl printf
	mov r1, r4
	movw r0, #:lower16:.PRINTLN_FMT
	movt r0, #:upper16:.PRINTLN_FMT
	bl printf
	b .inline3_LU19
.inline3_LU19:
	b .next3
.next3:
	b .inline4_LU16
.inline4_LU16:
	mov r2, #0
	cmp r7, #0
	movne r2, #1
	mov r3, r7
	cmp r2, #1
	beq .inline4_LU17
	b .inline4_LU18
.inline4_LU17:
	mov r4, r3
	mov r2, r4
	ldr r3, [r2]
	b .inline4_inline0_LU12
.inline4_inline0_LU12:
	movw r2, #0
	mov r1, #0
	cmp r2, r3
	movlt r1, #1
	movw r2, #1
	movw r0, #1
	cmp r1, #1
	beq .inline4_inline0_LU13
	b .inline4_inline0_LU14
.inline4_inline0_LU13:
	mov r2, r0
	mul r0, r2, r2
	add r1, r2, #1
	mov r5, #0
	cmp r0, r3
	movlt r5, #1
	mov r0, r1
	cmp r5, #1
	beq .inline4_inline0_LU13
	b .inline4_inline0_LU14
.inline4_inline0_LU14:
	b .inline4_inline0_LU11
.inline4_inline0_LU11:
	b .inline4_next0
.inline4_next0:
	mov r1, r2
	movw r0, #:lower16:.PRINTLN_FMT
	movt r0, #:upper16:.PRINTLN_FMT
	bl printf
	add r2, r4, #4
	ldr r3, [r2]
	mov r2, #0
	cmp r3, #0
	movne r2, #1
	cmp r2, #1
	beq .inline4_LU17
	b .inline4_LU18
.inline4_LU18:
	b .inline4_LU15
.inline4_LU15:
	b .next4
.next4:
	b .LU32
.LU32:
	movw r0, #0
	pop {r4, r5, r6, r7, r8}
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
