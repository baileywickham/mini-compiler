	.arch armv7-a


	.text
	.align 2
	.global getRands
getRands:
.LU1:
	push {fp, lr}
	add fp, sp, #4
	push {r4}
	sub sp, sp, #28
	mov r2, r0
	mov r3, r1
	str r2, [sp, #0]
	str r3, [sp, #4]
	movw r2, #0
	str r2, [sp, #20]
	ldr r3, [sp, #0]
	ldr r2, [sp, #0]
	mul r2, r3, r2
	str r2, [sp, #12]
	movw r0, #8
	bl malloc
	mov r2, r0
	str r2, [sp, #24]
	ldr r3, [sp, #12]
	ldr r2, [sp, #24]
	str r3, [r2]
	ldr r2, [sp, #24]
	add r3, r2, #4
	movw r2, #0
	str r2, [r3]
	ldr r2, [sp, #4]
	sub r2, r2, #1
	str r2, [sp, #4]
	ldr r2, [sp, #12]
	str r2, [sp, #16]
	ldr r2, [sp, #4]
	mov r3, #0
	cmp r2, #0
	movgt r3, #1
	cmp r3, #1
	beq .LU2
	b .LU3
.LU2:
	ldr r3, [sp, #16]
	ldr r2, [sp, #16]
	mul r2, r3, r2
	ldr r3, [sp, #0]
	mov r1, r3
	mov r0, r2
	bl __aeabi_idiv
	mov r4, r0
	ldr r2, [sp, #0]
	movw r1, #2
	mov r0, r2
	bl __aeabi_idiv
	mov r2, r0
	mul r2, r4, r2
	add r2, r2, #1
	str r2, [sp, #12]
	ldr r4, [sp, #12]
	ldr r2, [sp, #12]
	movw r1, #:lower16:1000000000
	movt r1, #:upper16:1000000000
	mov r0, r2
	bl __aeabi_idiv
	mov r3, r0
	movw r2, #:lower16:1000000000
	movt r2, #:upper16:1000000000
	mul r2, r3, r2
	sub r2, r4, r2
	str r2, [sp, #12]
	movw r0, #8
	bl malloc
	mov r2, r0
	str r2, [sp, #20]
	ldr r3, [sp, #12]
	ldr r2, [sp, #20]
	str r3, [r2]
	ldr r3, [sp, #24]
	ldr r2, [sp, #20]
	add r2, r2, #4
	str r3, [r2]
	ldr r2, [sp, #20]
	str r2, [sp, #24]
	ldr r2, [sp, #4]
	sub r2, r2, #1
	str r2, [sp, #4]
	ldr r2, [sp, #12]
	str r2, [sp, #16]
	ldr r3, [sp, #4]
	mov r2, #0
	cmp r3, #0
	movgt r2, #1
	cmp r2, #1
	beq .LU2
	b .LU3
.LU3:
	ldr r2, [sp, #20]
	str r2, [sp, #8]
	b .LU0
.LU0:
	ldr r2, [sp, #8]
	mov r0, r2
	add sp, sp, #28
	pop {r4}
	pop {fp, pc}
	.size getRands, .-getRands
	.align 2
	.global calcMean
calcMean:
.LU5:
	push {fp, lr}
	add fp, sp, #4
	sub sp, sp, #20
	mov r2, r0
	str r2, [sp, #0]
	movw r2, #0
	str r2, [sp, #8]
	movw r2, #0
	str r2, [sp, #12]
	movw r2, #0
	str r2, [sp, #16]
	ldr r2, [sp, #0]
	mov r3, #0
	cmp r2, #0
	movne r3, #1
	cmp r3, #1
	beq .LU6
	b .LU7
.LU6:
	ldr r2, [sp, #12]
	add r2, r2, #1
	str r2, [sp, #12]
	ldr r3, [sp, #8]
	ldr r2, [sp, #0]
	ldr r2, [r2]
	add r2, r3, r2
	str r2, [sp, #8]
	ldr r2, [sp, #0]
	add r2, r2, #4
	ldr r2, [r2]
	str r2, [sp, #0]
	ldr r3, [sp, #0]
	mov r2, #0
	cmp r3, #0
	movne r2, #1
	cmp r2, #1
	beq .LU6
	b .LU7
.LU7:
	ldr r3, [sp, #12]
	mov r2, #0
	cmp r3, #0
	movne r2, #1
	cmp r2, #1
	beq .LU8
	b .LU9
.LU8:
	ldr r2, [sp, #8]
	ldr r3, [sp, #12]
	mov r1, r3
	mov r0, r2
	bl __aeabi_idiv
	mov r2, r0
	str r2, [sp, #16]
	b .LU9
.LU9:
	ldr r2, [sp, #16]
	str r2, [sp, #4]
	b .LU4
.LU4:
	ldr r2, [sp, #4]
	mov r0, r2
	add sp, sp, #20
	pop {fp, pc}
	.size calcMean, .-calcMean
	.align 2
	.global approxSqrt
approxSqrt:
.LU11:
	push {fp, lr}
	add fp, sp, #4
	sub sp, sp, #20
	mov r2, r0
	str r2, [sp, #0]
	movw r2, #1
	str r2, [sp, #8]
	ldr r2, [sp, #8]
	str r2, [sp, #16]
	movw r2, #0
	str r2, [sp, #12]
	ldr r0, [sp, #12]
	ldr r2, [sp, #0]
	mov r3, #0
	cmp r0, r2
	movlt r3, #1
	cmp r3, #1
	beq .LU12
	b .LU13
.LU12:
	ldr r2, [sp, #8]
	ldr r3, [sp, #8]
	mul r2, r2, r3
	str r2, [sp, #12]
	ldr r2, [sp, #8]
	str r2, [sp, #16]
	ldr r2, [sp, #8]
	add r2, r2, #1
	str r2, [sp, #8]
	ldr r2, [sp, #12]
	ldr r3, [sp, #0]
	mov r0, #0
	cmp r2, r3
	movlt r0, #1
	cmp r0, #1
	beq .LU12
	b .LU13
.LU13:
	ldr r2, [sp, #16]
	str r2, [sp, #4]
	b .LU10
.LU10:
	ldr r2, [sp, #4]
	mov r0, r2
	add sp, sp, #20
	pop {fp, pc}
	.size approxSqrt, .-approxSqrt
	.align 2
	.global approxSqrtAll
approxSqrtAll:
.LU15:
	push {fp, lr}
	add fp, sp, #4
	sub sp, sp, #4
	mov r2, r0
	str r2, [sp, #0]
	ldr r0, [sp, #0]
	mov r2, #0
	cmp r0, #0
	movne r2, #1
	cmp r2, #1
	beq .LU16
	b .LU17
.LU16:
	ldr r2, [sp, #0]
	ldr r2, [r2]
	mov r0, r2
	bl approxSqrt
	mov r2, r0
	mov r1, r2
	movw r0, #:lower16:.PRINTLN_FMT
	movt r0, #:upper16:.PRINTLN_FMT
	bl printf
	ldr r2, [sp, #0]
	add r2, r2, #4
	ldr r2, [r2]
	str r2, [sp, #0]
	ldr r0, [sp, #0]
	mov r2, #0
	cmp r0, #0
	movne r2, #1
	cmp r2, #1
	beq .LU16
	b .LU17
.LU17:
	b .LU14
.LU14:
	add sp, sp, #4
	pop {fp, pc}
	.size approxSqrtAll, .-approxSqrtAll
	.align 2
	.global range
range:
.LU19:
	push {fp, lr}
	add fp, sp, #4
	sub sp, sp, #16
	mov r2, r0
	str r2, [sp, #0]
	movw r2, #0
	str r2, [sp, #4]
	movw r2, #0
	str r2, [sp, #8]
	movw r2, #1
	str r2, [sp, #12]
	ldr r2, [sp, #0]
	mov r0, #0
	cmp r2, #0
	movne r0, #1
	cmp r0, #1
	beq .LU20
	b .LU21
.LU20:
	ldr r2, [sp, #12]
	cmp r2, #1
	beq .LU22
	b .LU23
.LU22:
	ldr r2, [sp, #0]
	ldr r2, [r2]
	str r2, [sp, #4]
	ldr r2, [sp, #0]
	ldr r2, [r2]
	str r2, [sp, #8]
	movw r2, #0
	str r2, [sp, #12]
	b .LU24
.LU23:
	ldr r2, [sp, #0]
	ldr r0, [r2]
	ldr r2, [sp, #4]
	mov r1, #0
	cmp r0, r2
	movlt r1, #1
	cmp r1, #1
	beq .LU25
	b .LU26
.LU25:
	ldr r2, [sp, #0]
	ldr r2, [r2]
	str r2, [sp, #4]
	b .LU27
.LU26:
	ldr r2, [sp, #0]
	ldr r0, [r2]
	ldr r2, [sp, #8]
	mov r1, #0
	cmp r0, r2
	movgt r1, #1
	cmp r1, #1
	beq .LU28
	b .LU29
.LU28:
	ldr r2, [sp, #0]
	ldr r2, [r2]
	str r2, [sp, #8]
	b .LU29
.LU29:
	b .LU27
.LU27:
	b .LU24
.LU24:
	ldr r2, [sp, #0]
	add r2, r2, #4
	ldr r2, [r2]
	str r2, [sp, #0]
	ldr r2, [sp, #0]
	mov r0, #0
	cmp r2, #0
	movne r0, #1
	cmp r0, #1
	beq .LU20
	b .LU21
.LU21:
	ldr r2, [sp, #4]
	mov r1, r2
	movw r0, #:lower16:.PRINTLN_FMT
	movt r0, #:upper16:.PRINTLN_FMT
	bl printf
	ldr r2, [sp, #8]
	mov r1, r2
	movw r0, #:lower16:.PRINTLN_FMT
	movt r0, #:upper16:.PRINTLN_FMT
	bl printf
	b .LU18
.LU18:
	add sp, sp, #16
	pop {fp, pc}
	.size range, .-range
	.align 2
	.global main
main:
.LU31:
	push {fp, lr}
	add fp, sp, #4
	sub sp, sp, #20
	add r1, sp, #4
	movw r0, #:lower16:.READ_FMT
	movt r0, #:upper16:.READ_FMT
	bl scanf
	add r1, sp, #8
	movw r0, #:lower16:.READ_FMT
	movt r0, #:upper16:.READ_FMT
	bl scanf
	ldr r2, [sp, #4]
	ldr r0, [sp, #8]
	mov r1, r0
	mov r0, r2
	bl getRands
	mov r2, r0
	str r2, [sp, #16]
	ldr r2, [sp, #16]
	mov r0, r2
	bl calcMean
	mov r2, r0
	str r2, [sp, #12]
	ldr r2, [sp, #12]
	mov r1, r2
	movw r0, #:lower16:.PRINTLN_FMT
	movt r0, #:upper16:.PRINTLN_FMT
	bl printf
	ldr r2, [sp, #16]
	mov r0, r2
	bl range
	ldr r2, [sp, #16]
	mov r0, r2
	bl approxSqrtAll
	movw r2, #0
	str r2, [sp, #0]
	b .LU30
.LU30:
	ldr r2, [sp, #0]
	mov r0, r2
	add sp, sp, #20
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
