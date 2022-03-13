	.arch armv7-a
	.comm	.read_scratch,4,4
	.comm	globalfoo,4,4

	.text
	.align 2
	.global tailrecursive
tailrecursive:
.LU1:
	push {fp, lr}
	add fp, sp, #4
	mov r3, r0
	mov r2, #0
	cmp r3, #0
	movle r2, #1
	cmp r2, #1
	beq .LU2
	b .LU3
.LU2:
	b .LU0
.LU3:
	b .LU4
.LU4:
	sub r2, r3, #1
	mov r0, r2
	bl tailrecursive
	b .LU0
.LU0:
	pop {fp, pc}
	.size tailrecursive, .-tailrecursive
	.align 2
	.global ackermann
ackermann:
.LU16:
	push {fp, lr}
	add fp, sp, #4
	push {r4}
	mov r2, r0
	mov r3, r1
	mov r1, #0
	cmp r2, #0
	moveq r1, #1
	cmp r1, #1
	beq .LU17
	b .LU18
.LU17:
	add r2, r3, #1
	b .LU15
.LU18:
	b .LU19
.LU19:
	mov r1, #0
	cmp r3, #0
	moveq r1, #1
	cmp r1, #1
	beq .LU20
	b .LU21
.LU20:
	sub r2, r2, #1
	movw r1, #1
	mov r0, r2
	bl ackermann
	mov r2, r0
	b .LU15
.LU21:
	sub r4, r2, #1
	sub r3, r3, #1
	mov r1, r3
	mov r0, r2
	bl ackermann
	mov r2, r0
	mov r1, r2
	mov r0, r4
	bl ackermann
	mov r2, r0
	b .LU15
.LU15:
	mov r0, r2
	pop {r4}
	pop {fp, pc}
	.size ackermann, .-ackermann
	.align 2
	.global main
main:
.LU24:
	push {fp, lr}
	add fp, sp, #4
	push {r4, r5, r6, r7, r8, r9}
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
	ldr r5, [r2]
	movw r1, #:lower16:.read_scratch
	movt r1, #:upper16:.read_scratch
	movw r0, #:lower16:.READ_FMT
	movt r0, #:upper16:.READ_FMT
	bl scanf
	movw r2, #:lower16:.read_scratch
	movt r2, #:upper16:.read_scratch
	ldr r8, [r2]
	movw r1, #:lower16:.read_scratch
	movt r1, #:upper16:.read_scratch
	movw r0, #:lower16:.READ_FMT
	movt r0, #:upper16:.READ_FMT
	bl scanf
	movw r2, #:lower16:.read_scratch
	movt r2, #:upper16:.read_scratch
	ldr r6, [r2]
	movw r1, #:lower16:.read_scratch
	movt r1, #:upper16:.read_scratch
	movw r0, #:lower16:.READ_FMT
	movt r0, #:upper16:.READ_FMT
	bl scanf
	movw r2, #:lower16:.read_scratch
	movt r2, #:upper16:.read_scratch
	ldr r7, [r2]
	mov r0, r4
	bl tailrecursive
	mov r1, r4
	movw r0, #:lower16:.PRINTLN_FMT
	movt r0, #:upper16:.PRINTLN_FMT
	bl printf
	b .inline2_LU8
.inline2_LU8:
	movw r0, #12
	bl malloc
	mov r2, r0
	mov r9, r2
	movw r0, #4
	bl malloc
	mov r2, r0
	mov r3, r2
	add r2, r9, #8
	str r3, [r2]
	movw r0, #12
	bl malloc
	mov r2, r0
	mov r4, r2
	movw r0, #4
	bl malloc
	mov r2, r0
	mov r3, r2
	add r2, r4, #8
	str r3, [r2]
	mov r2, r9
	str r5, [r2]
	mov r2, r4
	movw r3, #3
	str r3, [r2]
	mov r2, r9
	ldr r3, [r2]
	add r2, r9, #8
	ldr r2, [r2]
	str r3, [r2]
	mov r2, r4
	ldr r3, [r2]
	add r2, r4, #8
	ldr r2, [r2]
	str r3, [r2]
	mov r3, #0
	cmp r5, #0
	movgt r3, #1
	mov r1, r9
	mov r2, r4
	mov r0, r4
	mov r4, r5
	cmp r3, #1
	beq .inline2_LU9
	b .inline2_LU10
.inline2_LU9:
	mov r2, r4
	b .inline2_inline0_LU6
.inline2_inline0_LU6:
	b .inline2_inline0_LU5
.inline2_inline0_LU5:
	b .inline2_next0
.inline2_next0:
	sub r4, r2, #1
	mov r3, #0
	cmp r4, #0
	movgt r3, #1
	mov r1, r9
	mov r2, r0
	cmp r3, #1
	beq .inline2_LU9
	b .inline2_LU10
.inline2_LU10:
	mov r4, r2
	mov r9, r1
	add r2, r9, #8
	ldr r2, [r2]
	mov r0, r2
	bl free
	add r2, r4, #8
	ldr r2, [r2]
	mov r0, r2
	bl free
	mov r2, r9
	mov r0, r2
	bl free
	mov r2, r4
	mov r0, r2
	bl free
	b .inline2_LU7
.inline2_LU7:
	b .next2
.next2:
	mov r1, r5
	movw r0, #:lower16:.PRINTLN_FMT
	movt r0, #:upper16:.PRINTLN_FMT
	bl printf
	b .inline1_LU12
.inline1_LU12:
	mov r3, #0
	cmp r8, #0
	movgt r3, #1
	mov r2, r8
	cmp r3, #1
	beq .inline1_LU13
	b .inline1_LU14
.inline1_LU13:
	mov r4, r2
	movw r0, #12
	bl malloc
	mov r2, r0
	mov r0, r2
	bl free
	sub r2, r4, #1
	mov r3, #0
	cmp r2, #0
	movgt r3, #1
	cmp r3, #1
	beq .inline1_LU13
	b .inline1_LU14
.inline1_LU14:
	b .inline1_LU11
.inline1_LU11:
	b .next1
.next1:
	mov r1, r8
	movw r0, #:lower16:.PRINTLN_FMT
	movt r0, #:upper16:.PRINTLN_FMT
	bl printf
	mov r1, r7
	mov r0, r6
	bl ackermann
	mov r2, r0
	mov r1, r2
	movw r0, #:lower16:.PRINTLN_FMT
	movt r0, #:upper16:.PRINTLN_FMT
	bl printf
	b .LU23
.LU23:
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
