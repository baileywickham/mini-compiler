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
	movw r4, #:lower16:.read_scratch
	movt r4, #:upper16:.read_scratch
	ldr r4, [r4]
	movw r1, #1
	cmp r1, #1
	beq .inline1_LU4
	b .inline1_LU5
.inline1_LU4:
	mov r1, r4
	movw r0, #:lower16:.PRINT_FMT
	movt r0, #:upper16:.PRINT_FMT
	bl printf
	movw r1, #2
	mov r0, r4
	bl __aeabi_idiv
	mov r1, r0
	movw r2, #2
	mul r1, r1, r2
	sub r2, r4, r1
	mov r1, #0
	cmp r2, #1
	moveq r1, #1
	cmp r1, #1
	beq .inline1_LU6
	b .inline1_LU7
.inline1_LU6:
	movw r1, #3
	mul r4, r1, r4
	add r4, r4, #1
	b .inline1_LU8
.inline1_LU7:
	movw r1, #2
	mov r0, r4
	bl __aeabi_idiv
	mov r4, r0
	b .inline1_LU8
.inline1_LU8:
	mov r1, #0
	cmp r4, #1
	movle r1, #1
	cmp r1, #1
	beq .inline1_LU9
	b .inline1_LU10
.inline1_LU9:
	mov r1, r4
	movw r0, #:lower16:.PRINTLN_FMT
	movt r0, #:upper16:.PRINTLN_FMT
	bl printf
	b .inline1_LU2
.inline1_LU10:
	movw r1, #1
	cmp r1, #1
	beq .inline1_LU4
	b .inline1_LU5
.inline1_LU5:
	b .inline1_LU2
.inline1_LU2:
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
