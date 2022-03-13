	.arch armv7-a
	.comm	.read_scratch,4,4

	.text
	.align 2
	.global main
main:
.LU13:
	push {fp, lr}
	add fp, sp, #4
	push {r4}
	movw r1, #:lower16:.read_scratch
	movt r1, #:upper16:.read_scratch
	movw r0, #:lower16:.READ_FMT
	movt r0, #:upper16:.READ_FMT
	bl scanf
	movw r2, #:lower16:.read_scratch
	movt r2, #:upper16:.read_scratch
	ldr r2, [r2]
	b .inline1_LU3
.inline1_LU3:
	mov r3, r2
	movw r2, #1
	cmp r2, #1
	beq .inline1_LU4
	b .inline1_LU5
.inline1_LU4:
	mov r4, r3
	mov r1, r4
	movw r0, #:lower16:.PRINT_FMT
	movt r0, #:upper16:.PRINT_FMT
	bl printf
	b .inline1_inline0_LU1
.inline1_inline0_LU1:
	movw r1, #2
	mov r0, r4
	bl __aeabi_idiv
	mov r2, r0
	movw r3, #2
	mul r2, r2, r3
	sub r2, r4, r2
	b .inline1_inline0_LU0
.inline1_inline0_LU0:
	b .inline1_next0
.inline1_next0:
	mov r3, #0
	cmp r2, #1
	moveq r3, #1
	cmp r3, #1
	beq .inline1_LU6
	b .inline1_LU7
.inline1_LU6:
	movw r2, #3
	mul r2, r2, r4
	add r2, r2, #1
	b .inline1_LU8
.inline1_LU7:
	movw r1, #2
	mov r0, r4
	bl __aeabi_idiv
	mov r2, r0
	b .inline1_LU8
.inline1_LU8:
	mov r3, #0
	cmp r2, #1
	movle r3, #1
	cmp r3, #1
	beq .inline1_LU9
	b .inline1_LU10
.inline1_LU9:
	mov r1, r2
	movw r0, #:lower16:.PRINTLN_FMT
	movt r0, #:upper16:.PRINTLN_FMT
	bl printf
	b .inline1_LU2
.inline1_LU10:
	b .inline1_LU11
.inline1_LU11:
	mov r3, r2
	movw r2, #1
	cmp r2, #1
	beq .inline1_LU4
	b .inline1_LU5
.inline1_LU5:
	b .inline1_LU2
.inline1_LU2:
	b .next1
.next1:
	b .LU12
.LU12:
	movw r0, #0
	pop {r4}
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
