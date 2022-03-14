	.arch armv7-a
	.comm	.read_scratch,4,4

	.text
	.align 2
	.global getRands
getRands:
.LU1:
	push {fp, lr}
	add fp, sp, #4
	push {r4, r5, r6, r7}
	mov r4, r0
	mov r6, r1
	mul r5, r4, r4
	movw r0, #8
	bl malloc
	mov r7, r0
	mov r1, r7
	mov r7, r1
	str r5, [r7]
	add r2, r1, #4
	movw r7, #0
	str r7, [r2]
	sub r0, r6, #1
	mov r2, #0
	cmp r0, #0
	movgt r2, #1
	movw r6, #0
	mov r7, r5
	cmp r2, #1
	beq .LU2
	b .LU3
.LU2:
	mov r5, r0
	mov r6, r1
	mul r7, r7, r7
	mov r1, r4
	mov r0, r7
	bl __aeabi_idiv
	mov r7, r0
	movw r1, #2
	mov r0, r4
	bl __aeabi_idiv
	mov r1, r0
	mul r7, r7, r1
	add r7, r7, #1
	movw r1, #:lower16:1000000000
	movt r1, #:upper16:1000000000
	mov r0, r7
	bl __aeabi_idiv
	mov r2, r0
	movw r1, #:lower16:1000000000
	movt r1, #:upper16:1000000000
	mul r1, r2, r1
	sub r7, r7, r1
	movw r0, #8
	bl malloc
	mov r1, r0
	mov r2, r1
	str r7, [r2]
	add r2, r1, #4
	str r6, [r2]
	sub r2, r5, #1
	mov r5, #0
	cmp r2, #0
	movgt r5, #1
	mov r6, r1
	mov r0, r2
	cmp r5, #1
	beq .LU2
	b .LU3
.LU3:
	mov r4, r6
	b .LU0
.LU0:
	mov r0, r4
	pop {r4, r5, r6, r7}
	pop {fp, pc}
	.size getRands, .-getRands
	.align 2
	.global calcMean
calcMean:
.LU5:
	push {fp, lr}
	add fp, sp, #4
	push {r4, r5, r6, r7, r8}
	mov r6, r0
	mov r1, #0
	cmp r6, #0
	movne r1, #1
	movw r2, #0
	movw r0, #0
	movw r4, #0
	movw r3, #0
	movw r5, #0
	mov r7, r6
	movw r8, #0
	cmp r1, #1
	beq .LU6
	b .LU7
.LU6:
	mov r1, r8
	mov r2, r7
	mov r0, r5
	add r3, r3, #1
	mov r4, r2
	ldr r4, [r4]
	add r5, r0, r4
	add r2, r2, #4
	ldr r7, [r2]
	mov r6, #0
	cmp r7, #0
	movne r6, #1
	mov r2, r3
	mov r0, r5
	mov r4, r1
	mov r8, r1
	cmp r6, #1
	beq .LU6
	b .LU7
.LU7:
	mov r3, r4
	mov r1, r2
	mov r2, #0
	cmp r1, #0
	movne r2, #1
	cmp r2, #1
	beq .LU8
	b .LU9
.LU8:
	bl __aeabi_idiv
	mov r1, r0
	b .LU10
.LU9:
	mov r1, r3
	b .LU10
.LU10:
	b .LU4
.LU4:
	mov r0, r1
	pop {r4, r5, r6, r7, r8}
	pop {fp, pc}
	.size calcMean, .-calcMean
	.align 2
	.global approxSqrt
approxSqrt:
.LU12:
	push {fp, lr}
	add fp, sp, #4
	push {r4}
	mov r3, r0
	movw r1, #0
	mov r0, #0
	cmp r1, r3
	movlt r0, #1
	movw r1, #1
	movw r2, #1
	cmp r0, #1
	beq .LU13
	b .LU14
.LU13:
	mov r1, r2
	mul r2, r1, r1
	add r4, r1, #1
	mov r0, #0
	cmp r2, r3
	movlt r0, #1
	mov r2, r4
	cmp r0, #1
	beq .LU13
	b .LU14
.LU14:
	mov r0, r1
	b .LU11
.LU11:
	pop {r4}
	pop {fp, pc}
	.size approxSqrt, .-approxSqrt
	.align 2
	.global approxSqrtAll
approxSqrtAll:
.LU16:
	push {fp, lr}
	add fp, sp, #4
	push {r4}
	mov r4, #0
	cmp r0, #0
	movne r4, #1
	cmp r4, #1
	beq .LU17
	b .LU18
.LU17:
	mov r4, r0
	mov r0, r4
	ldr r0, [r0]
	bl approxSqrt
	mov r1, r0
	movw r0, #:lower16:.PRINTLN_FMT
	movt r0, #:upper16:.PRINTLN_FMT
	bl printf
	add r4, r4, #4
	ldr r0, [r4]
	mov r4, #0
	cmp r0, #0
	movne r4, #1
	cmp r4, #1
	beq .LU17
	b .LU18
.LU18:
	b .LU15
.LU15:
	pop {r4}
	pop {fp, pc}
	.size approxSqrtAll, .-approxSqrtAll
	.align 2
	.global range
range:
.LU20:
	push {fp, lr}
	add fp, sp, #4
	push {r4, r5, r6, r7}
	movw r3, #1
	mov r2, #0
	cmp r0, #0
	movne r2, #1
	movw r1, #0
	movw r4, #0
	mov r7, r0
	movw r0, #0
	movw r6, #0
	cmp r2, #1
	beq .LU21
	b .LU22
.LU21:
	mov r2, r6
	mov r4, r7
	mov r1, r3
	mov r3, r1
	cmp r3, #1
	beq .LU23
	b .LU24
.LU23:
	mov r1, r4
	ldr r2, [r1]
	mov r1, r4
	ldr r0, [r1]
	movw r5, #0
	mov r1, r4
	mov r4, r2
	mov r3, r0
	mov r2, r5
	b .LU25
.LU24:
	mov r3, r4
	ldr r5, [r3]
	mov r3, #0
	cmp r5, r0
	movlt r3, #1
	cmp r3, #1
	beq .LU26
	b .LU27
.LU26:
	mov r0, r4
	ldr r0, [r0]
	mov r3, r2
	b .LU28
.LU27:
	mov r3, r4
	ldr r5, [r3]
	mov r3, #0
	cmp r5, r2
	movgt r3, #1
	cmp r3, #1
	beq .LU29
	b .LU30
.LU29:
	mov r2, r4
	ldr r2, [r2]
	b .LU31
.LU30:
	b .LU31
.LU31:
	mov r3, r2
	mov r2, r0
	mov r0, r2
	b .LU28
.LU28:
	mov r2, r1
	mov r1, r4
	mov r4, r0
	b .LU25
.LU25:
	mov r0, r2
	mov r2, r3
	mov r6, r4
	add r1, r1, #4
	ldr r7, [r1]
	mov r5, #0
	cmp r7, #0
	movne r5, #1
	mov r1, r6
	mov r4, r2
	mov r3, r0
	mov r0, r6
	mov r6, r2
	cmp r5, #1
	beq .LU21
	b .LU22
.LU22:
	movw r0, #:lower16:.PRINTLN_FMT
	movt r0, #:upper16:.PRINTLN_FMT
	bl printf
	mov r1, r4
	movw r0, #:lower16:.PRINTLN_FMT
	movt r0, #:upper16:.PRINTLN_FMT
	bl printf
	b .LU19
.LU19:
	pop {r4, r5, r6, r7}
	pop {fp, pc}
	.size range, .-range
	.align 2
	.global main
main:
.LU33:
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
	movw r1, #:lower16:.read_scratch
	movt r1, #:upper16:.read_scratch
	movw r0, #:lower16:.READ_FMT
	movt r0, #:upper16:.READ_FMT
	bl scanf
	movw r0, #:lower16:.read_scratch
	movt r0, #:upper16:.read_scratch
	ldr r0, [r0]
	mov r1, r0
	mov r0, r4
	bl getRands
	mov r4, r0
	mov r0, r4
	bl calcMean
	mov r1, r0
	movw r0, #:lower16:.PRINTLN_FMT
	movt r0, #:upper16:.PRINTLN_FMT
	bl printf
	mov r0, r4
	bl range
	mov r0, r4
	bl approxSqrtAll
	b .LU32
.LU32:
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
