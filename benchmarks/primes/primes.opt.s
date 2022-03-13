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
	movw r0, #:lower16:.read_scratch
	movt r0, #:upper16:.read_scratch
	ldr r3, [r0]
	movw r0, #0
	mov r4, #0
	cmp r0, r3
	movle r4, #1
	movw r0, #0
	cmp r4, #1
	beq .LU16
	b .LU17
.LU16:
	mov r8, r3
	mov r7, r0
	b .inline1_LU5
.inline1_LU5:
	mov r0, #0
	cmp r7, #2
	movlt r0, #1
	cmp r0, #1
	beq .inline1_LU6
	b .inline1_LU7
.inline1_LU6:
	movw r0, #0
	b .inline1_LU4
.inline1_LU7:
	b .inline1_inline0_LU1
.inline1_inline0_LU1:
	movw r0, #1
	mov r5, #0
	cmp r0, r7
	movle r5, #1
	movw r6, #3
	movw r4, #1
	movw r0, #3
	mov r3, r7
	cmp r5, #1
	beq .inline1_inline0_LU2
	b .inline1_inline0_LU3
.inline1_inline0_LU2:
	add r4, r4, r0
	add r0, r0, #2
	mov r5, #0
	cmp r4, r3
	movle r5, #1
	mov r6, r0
	cmp r5, #1
	beq .inline1_inline0_LU2
	b .inline1_inline0_LU3
.inline1_inline0_LU3:
	mov r0, r6
	movw r1, #2
	bl __aeabi_idiv
	sub r5, r0, #1
	b .inline1_inline0_LU0
.inline1_inline0_LU0:
	b .inline1_next0
.inline1_next0:
	movw r0, #2
	mov r3, #0
	cmp r0, r5
	movle r3, #1
	mov r4, r7
	movw r0, #2
	cmp r3, #1
	beq .inline1_LU9
	b .inline1_LU10
.inline1_LU9:
	mov r6, r5
	mov r5, r0
	mov r1, r5
	mov r0, r4
	bl __aeabi_idiv
	mul r0, r0, r5
	sub r3, r4, r0
	mov r0, #0
	cmp r3, #0
	moveq r0, #1
	cmp r0, #1
	beq .inline1_LU11
	b .inline1_LU12
.inline1_LU11:
	movw r0, #0
	b .inline1_LU4
.inline1_LU12:
	b .inline1_LU13
.inline1_LU13:
	add r0, r5, #1
	mov r3, #0
	cmp r0, r6
	movle r3, #1
	mov r5, r6
	cmp r3, #1
	beq .inline1_LU9
	b .inline1_LU10
.inline1_LU10:
	movw r0, #1
	b .inline1_LU4
.inline1_LU4:
	b .next1
.next1:
	cmp r0, #1
	beq .LU18
	b .LU19
.LU18:
	mov r1, r7
	movw r0, #:lower16:.PRINTLN_FMT
	movt r0, #:upper16:.PRINTLN_FMT
	bl printf
	mov r0, r7
	mov r4, r8
	b .LU20
.LU19:
	mov r0, r7
	mov r4, r8
	b .LU20
.LU20:
	mov r3, r4
	add r0, r0, #1
	mov r4, #0
	cmp r0, r3
	movle r4, #1
	cmp r4, #1
	beq .LU16
	b .LU17
.LU17:
	b .LU14
.LU14:
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
