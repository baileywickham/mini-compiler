	.arch armv7-a
	.comm	.read_scratch,4,4

	.text
	.align 2
	.global main
main:
.LU15:
	push {fp, lr}
	add fp, sp, #4
	push {r4, r5, r6, r7, r8}
	movw r1, #:lower16:.read_scratch
	movt r1, #:upper16:.read_scratch
	movw r0, #:lower16:.READ_FMT
	movt r0, #:upper16:.READ_FMT
	bl scanf
	movw r4, #:lower16:.read_scratch
	movt r4, #:upper16:.read_scratch
	ldr r6, [r4]
	movw r5, #0
	mov r4, #0
	cmp r5, r6
	movle r4, #1
	movw r5, #0
	mov r7, r6
	cmp r4, #1
	beq .LU16
	b .LU17
.LU16:
	mov r4, r7
	mov r6, #0
	cmp r5, #2
	movlt r6, #1
	cmp r6, #1
	beq .inline1_LU6
	b .inline1_LU7
.inline1_LU6:
	movw r6, #0
	b .inline1_LU4
.inline1_LU7:
	movw r7, #1
	mov r6, #0
	cmp r7, r5
	movle r6, #1
	movw r7, #3
	movw r8, #1
	movw r2, #3
	mov r0, r5
	cmp r6, #1
	beq .inline1_inline0_LU2
	b .inline1_inline0_LU3
.inline1_inline0_LU2:
	mov r6, r0
	mov r1, r2
	mov r7, r8
	add r8, r7, r1
	add r2, r1, #2
	mov r1, #0
	cmp r8, r6
	movle r1, #1
	mov r7, r2
	mov r0, r6
	cmp r1, #1
	beq .inline1_inline0_LU2
	b .inline1_inline0_LU3
.inline1_inline0_LU3:
	mov r6, r7
	movw r1, #2
	mov r0, r6
	bl __aeabi_idiv
	mov r6, r0
	sub r8, r6, #1
	movw r7, #2
	mov r6, #0
	cmp r7, r8
	movle r6, #1
	mov r7, r5
	movw r2, #2
	mov r1, r8
	cmp r6, #1
	beq .inline1_LU9
	b .inline1_LU10
.inline1_LU9:
	mov r6, r1
	mov r8, r2
	mov r1, r8
	mov r0, r7
	bl __aeabi_idiv
	mov r1, r0
	mul r1, r1, r8
	sub r2, r7, r1
	mov r1, #0
	cmp r2, #0
	moveq r1, #1
	cmp r1, #1
	beq .inline1_LU11
	b .inline1_LU12
.inline1_LU11:
	movw r6, #0
	b .inline1_LU4
.inline1_LU12:
	add r1, r8, #1
	mov r8, #0
	cmp r1, r6
	movle r8, #1
	mov r2, r1
	mov r1, r6
	cmp r8, #1
	beq .inline1_LU9
	b .inline1_LU10
.inline1_LU10:
	movw r6, #1
	b .inline1_LU4
.inline1_LU4:
	cmp r6, #1
	beq .LU18
	b .LU19
.LU18:
	mov r1, r5
	movw r0, #:lower16:.PRINTLN_FMT
	movt r0, #:upper16:.PRINTLN_FMT
	bl printf
	b .LU20
.LU19:
	b .LU20
.LU20:
	add r5, r5, #1
	mov r6, #0
	cmp r5, r4
	movle r6, #1
	mov r7, r4
	cmp r6, #1
	beq .LU16
	b .LU17
.LU17:
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
