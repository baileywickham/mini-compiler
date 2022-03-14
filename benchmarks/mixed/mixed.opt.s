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
	mov r2, #0
	cmp r0, #0
	movle r2, #1
	cmp r2, #1
	beq .LU2
	b .LU3
.LU2:
	b .LU0
.LU3:
	sub r2, r0, #1
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
	mov r4, #0
	cmp r2, #0
	moveq r4, #1
	cmp r4, #1
	beq .LU17
	b .LU18
.LU17:
	add r4, r1, #1
	b .LU15
.LU18:
	mov r4, #0
	cmp r1, #0
	moveq r4, #1
	cmp r4, #1
	beq .LU20
	b .LU21
.LU20:
	sub r4, r2, #1
	movw r1, #1
	mov r0, r4
	bl ackermann
	mov r4, r0
	b .LU15
.LU21:
	sub r4, r2, #1
	sub r1, r1, #1
	mov r0, r2
	bl ackermann
	mov r1, r0
	mov r0, r4
	bl ackermann
	mov r4, r0
	b .LU15
.LU15:
	mov r0, r4
	pop {r4}
	pop {fp, pc}
	.size ackermann, .-ackermann
	.align 2
	.global main
main:
.LU24:
	push {fp, lr}
	add fp, sp, #4
	push {r4, r5, r6, r7, r8, r9, r10}
	movw r1, #:lower16:.read_scratch
	movt r1, #:upper16:.read_scratch
	movw r0, #:lower16:.READ_FMT
	movt r0, #:upper16:.READ_FMT
	bl scanf
	movw r4, #:lower16:.read_scratch
	movt r4, #:upper16:.read_scratch
	ldr r8, [r4]
	movw r1, #:lower16:.read_scratch
	movt r1, #:upper16:.read_scratch
	movw r0, #:lower16:.READ_FMT
	movt r0, #:upper16:.READ_FMT
	bl scanf
	movw r4, #:lower16:.read_scratch
	movt r4, #:upper16:.read_scratch
	ldr r7, [r4]
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
	ldr r5, [r5]
	movw r1, #:lower16:.read_scratch
	movt r1, #:upper16:.read_scratch
	movw r0, #:lower16:.READ_FMT
	movt r0, #:upper16:.READ_FMT
	bl scanf
	movw r6, #:lower16:.read_scratch
	movt r6, #:upper16:.read_scratch
	ldr r6, [r6]
	mov r0, r8
	bl tailrecursive
	mov r1, r8
	movw r0, #:lower16:.PRINTLN_FMT
	movt r0, #:upper16:.PRINTLN_FMT
	bl printf
	movw r0, #12
	bl malloc
	mov r8, r0
	movw r0, #4
	bl malloc
	mov r9, r0
	mov r1, r9
	add r9, r8, #8
	str r1, [r9]
	movw r0, #12
	bl malloc
	mov r9, r0
	movw r0, #4
	bl malloc
	mov r1, r0
	mov r2, r1
	add r1, r9, #8
	str r2, [r1]
	mov r1, r8
	str r7, [r1]
	mov r1, r9
	movw r2, #3
	str r2, [r1]
	mov r1, r8
	ldr r1, [r1]
	add r2, r8, #8
	ldr r2, [r2]
	str r1, [r2]
	mov r1, r9
	ldr r1, [r1]
	add r2, r9, #8
	ldr r2, [r2]
	str r1, [r2]
	mov r10, #0
	cmp r7, #0
	movgt r10, #1
	mov r1, r8
	mov r2, r9
	mov r0, r9
	mov r3, r7
	cmp r10, #1
	beq .inline2_LU9
	b .inline2_LU10
.inline2_LU9:
	mov r9, r3
	sub r3, r9, #1
	mov r9, #0
	cmp r3, #0
	movgt r9, #1
	mov r1, r8
	mov r2, r0
	cmp r9, #1
	beq .inline2_LU9
	b .inline2_LU10
.inline2_LU10:
	mov r8, r2
	mov r9, r1
	add r1, r9, #8
	ldr r1, [r1]
	mov r0, r1
	bl free
	add r1, r8, #8
	ldr r1, [r1]
	mov r0, r1
	bl free
	mov r0, r9
	bl free
	mov r0, r8
	bl free
	mov r1, r7
	movw r0, #:lower16:.PRINTLN_FMT
	movt r0, #:upper16:.PRINTLN_FMT
	bl printf
	mov r8, #0
	cmp r4, #0
	movgt r8, #1
	mov r7, r4
	cmp r8, #1
	beq .inline1_LU13
	b .inline1_LU14
.inline1_LU13:
	movw r0, #12
	bl malloc
	mov r8, r0
	mov r0, r8
	bl free
	sub r7, r7, #1
	mov r8, #0
	cmp r7, #0
	movgt r8, #1
	cmp r8, #1
	beq .inline1_LU13
	b .inline1_LU14
.inline1_LU14:
	mov r1, r4
	movw r0, #:lower16:.PRINTLN_FMT
	movt r0, #:upper16:.PRINTLN_FMT
	bl printf
	mov r1, r6
	mov r0, r5
	bl ackermann
	mov r4, r0
	mov r1, r4
	movw r0, #:lower16:.PRINTLN_FMT
	movt r0, #:upper16:.PRINTLN_FMT
	bl printf
	movw r0, #0
	pop {r4, r5, r6, r7, r8, r9, r10}
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
