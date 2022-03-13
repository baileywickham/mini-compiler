	.arch armv7-a
	.comm	.read_scratch,4,4

	.text
	.align 2
	.global getIntList
getIntList:
.LU1:
	push {fp, lr}
	add fp, sp, #4
	push {r4}
	movw r0, #8
	bl malloc
	mov r2, r0
	mov r4, r2
	movw r1, #:lower16:.read_scratch
	movt r1, #:upper16:.read_scratch
	movw r0, #:lower16:.READ_FMT
	movt r0, #:upper16:.READ_FMT
	bl scanf
	movw r2, #:lower16:.read_scratch
	movt r2, #:upper16:.read_scratch
	ldr r1, [r2]
	movw r0, #:lower16:-1
	movt r0, #:upper16:-1
	mov r2, #0
	cmp r1, r0
	moveq r2, #1
	cmp r2, #1
	beq .LU2
	b .LU3
.LU2:
	mov r2, r4
	str r1, [r2]
	add r2, r4, #4
	movw r0, #0
	str r0, [r2]
	mov r2, r4
	b .LU0
.LU3:
	mov r2, r4
	str r1, [r2]
	bl getIntList
	add r2, r4, #4
	str r0, [r2]
	mov r2, r4
	b .LU0
.LU0:
	mov r0, r2
	pop {r4}
	pop {fp, pc}
	.size getIntList, .-getIntList
	.align 2
	.global main
main:
.LU15:
	push {fp, lr}
	add fp, sp, #4
	bl getIntList
	mov r3, r0
	b .inline1_LU11
.inline1_LU11:
	mov r2, r3
	ldr r0, [r2]
	add r2, r3, #4
	ldr r2, [r2]
	mov r1, #0
	cmp r2, #0
	movne r1, #1
	mov r2, r0
	cmp r1, #1
	beq .inline1_LU12
	b .inline1_LU13
.inline1_LU12:
	mov r2, r3
	mov r1, r0
	mov r3, r2
	ldr r3, [r3]
	b .inline1_inline0_LU6
.inline1_inline0_LU6:
	mov r0, #0
	cmp r1, r3
	movgt r0, #1
	cmp r0, #1
	beq .inline1_inline0_LU7
	b .inline1_inline0_LU8
.inline1_inline0_LU7:
	mov r3, r1
	b .inline1_inline0_LU5
.inline1_inline0_LU8:
	b .inline1_inline0_LU5
.inline1_inline0_LU5:
	mov r0, r3
	b .inline1_next0
.inline1_next0:
	add r2, r2, #4
	ldr r3, [r2]
	add r2, r3, #4
	ldr r2, [r2]
	mov r1, #0
	cmp r2, #0
	movne r1, #1
	mov r2, r0
	cmp r1, #1
	beq .inline1_LU12
	b .inline1_LU13
.inline1_LU13:
	b .inline1_LU10
.inline1_LU10:
	b .next1
.next1:
	mov r1, r2
	movw r0, #:lower16:.PRINTLN_FMT
	movt r0, #:upper16:.PRINTLN_FMT
	bl printf
	b .LU14
.LU14:
	movw r0, #0
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
