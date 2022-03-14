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
	mov r4, r0
	str r4, [sp, #0]
	str r1, [sp, #4]
	movw r1, #0
	str r1, [sp, #20]
	ldr r4, [sp, #0]
	ldr r1, [sp, #0]
	mul r1, r4, r1
	str r1, [sp, #12]
	movw r0, #8
	bl malloc
	mov r1, r0
	str r1, [sp, #24]
	ldr r1, [sp, #12]
	ldr r4, [sp, #24]
	str r1, [r4]
	ldr r1, [sp, #24]
	add r1, r1, #4
	movw r4, #0
	str r4, [r1]
	ldr r1, [sp, #4]
	sub r1, r1, #1
	str r1, [sp, #4]
	ldr r1, [sp, #12]
	str r1, [sp, #16]
	ldr r4, [sp, #4]
	mov r1, #0
	cmp r4, #0
	movgt r1, #1
	cmp r1, #1
	beq .LU2
	b .LU3
.LU2:
	ldr r1, [sp, #16]
	ldr r4, [sp, #16]
	mul r4, r1, r4
	ldr r1, [sp, #0]
	mov r0, r4
	bl __aeabi_idiv
	mov r4, r0
	ldr r2, [sp, #0]
	movw r1, #2
	mov r0, r2
	bl __aeabi_idiv
	mov r1, r0
	mul r1, r4, r1
	add r1, r1, #1
	str r1, [sp, #12]
	ldr r4, [sp, #12]
	ldr r2, [sp, #12]
	movw r1, #:lower16:1000000000
	movt r1, #:upper16:1000000000
	mov r0, r2
	bl __aeabi_idiv
	mov r1, r0
	movw r2, #:lower16:1000000000
	movt r2, #:upper16:1000000000
	mul r1, r1, r2
	sub r1, r4, r1
	str r1, [sp, #12]
	movw r0, #8
	bl malloc
	mov r1, r0
	str r1, [sp, #20]
	ldr r1, [sp, #12]
	ldr r4, [sp, #20]
	str r1, [r4]
	ldr r1, [sp, #24]
	ldr r4, [sp, #20]
	add r4, r4, #4
	str r1, [r4]
	ldr r1, [sp, #20]
	str r1, [sp, #24]
	ldr r1, [sp, #4]
	sub r1, r1, #1
	str r1, [sp, #4]
	ldr r1, [sp, #12]
	str r1, [sp, #16]
	ldr r1, [sp, #4]
	mov r4, #0
	cmp r1, #0
	movgt r4, #1
	cmp r4, #1
	beq .LU2
	b .LU3
.LU3:
	ldr r1, [sp, #20]
	str r1, [sp, #8]
	b .LU0
.LU0:
	ldr r1, [sp, #8]
	mov r0, r1
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
	mov r1, r0
	str r1, [sp, #0]
	movw r1, #0
	str r1, [sp, #8]
	movw r1, #0
	str r1, [sp, #12]
	movw r1, #0
	str r1, [sp, #16]
	ldr r2, [sp, #0]
	mov r1, #0
	cmp r2, #0
	movne r1, #1
	cmp r1, #1
	beq .LU6
	b .LU7
.LU6:
	ldr r1, [sp, #12]
	add r1, r1, #1
	str r1, [sp, #12]
	ldr r1, [sp, #8]
	ldr r2, [sp, #0]
	ldr r2, [r2]
	add r1, r1, r2
	str r1, [sp, #8]
	ldr r1, [sp, #0]
	add r1, r1, #4
	ldr r1, [r1]
	str r1, [sp, #0]
	ldr r2, [sp, #0]
	mov r1, #0
	cmp r2, #0
	movne r1, #1
	cmp r1, #1
	beq .LU6
	b .LU7
.LU7:
	ldr r2, [sp, #12]
	mov r1, #0
	cmp r2, #0
	movne r1, #1
	cmp r1, #1
	beq .LU8
	b .LU9
.LU8:
	ldr r2, [sp, #8]
	ldr r1, [sp, #12]
	mov r0, r2
	bl __aeabi_idiv
	mov r1, r0
	str r1, [sp, #16]
	b .LU9
.LU9:
	ldr r1, [sp, #16]
	str r1, [sp, #4]
	b .LU4
.LU4:
	ldr r1, [sp, #4]
	mov r0, r1
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
	mov r1, r0
	str r1, [sp, #0]
	movw r1, #1
	str r1, [sp, #8]
	ldr r1, [sp, #8]
	str r1, [sp, #16]
	movw r1, #0
	str r1, [sp, #12]
	ldr r0, [sp, #12]
	ldr r2, [sp, #0]
	mov r1, #0
	cmp r0, r2
	movlt r1, #1
	cmp r1, #1
	beq .LU12
	b .LU13
.LU12:
	ldr r2, [sp, #8]
	ldr r1, [sp, #8]
	mul r1, r2, r1
	str r1, [sp, #12]
	ldr r1, [sp, #8]
	str r1, [sp, #16]
	ldr r1, [sp, #8]
	add r1, r1, #1
	str r1, [sp, #8]
	ldr r1, [sp, #12]
	ldr r2, [sp, #0]
	mov r0, #0
	cmp r1, r2
	movlt r0, #1
	cmp r0, #1
	beq .LU12
	b .LU13
.LU13:
	ldr r1, [sp, #16]
	str r1, [sp, #4]
	b .LU10
.LU10:
	ldr r1, [sp, #4]
	mov r0, r1
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
	str r0, [sp, #0]
	ldr r1, [sp, #0]
	mov r0, #0
	cmp r1, #0
	movne r0, #1
	cmp r0, #1
	beq .LU16
	b .LU17
.LU16:
	ldr r0, [sp, #0]
	ldr r0, [r0]
	bl approxSqrt
	mov r1, r0
	movw r0, #:lower16:.PRINTLN_FMT
	movt r0, #:upper16:.PRINTLN_FMT
	bl printf
	ldr r0, [sp, #0]
	add r0, r0, #4
	ldr r0, [r0]
	str r0, [sp, #0]
	ldr r0, [sp, #0]
	mov r1, #0
	cmp r0, #0
	movne r1, #1
	cmp r1, #1
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
	mov r1, r0
	str r1, [sp, #0]
	movw r1, #0
	str r1, [sp, #4]
	movw r1, #0
	str r1, [sp, #8]
	movw r1, #1
	str r1, [sp, #12]
	ldr r1, [sp, #0]
	mov r2, #0
	cmp r1, #0
	movne r2, #1
	cmp r2, #1
	beq .LU20
	b .LU21
.LU20:
	ldr r1, [sp, #12]
	cmp r1, #1
	beq .LU22
	b .LU23
.LU22:
	ldr r1, [sp, #0]
	ldr r1, [r1]
	str r1, [sp, #4]
	ldr r1, [sp, #0]
	ldr r1, [r1]
	str r1, [sp, #8]
	movw r1, #0
	str r1, [sp, #12]
	b .LU24
.LU23:
	ldr r1, [sp, #0]
	ldr r1, [r1]
	ldr r2, [sp, #4]
	mov r0, #0
	cmp r1, r2
	movlt r0, #1
	cmp r0, #1
	beq .LU25
	b .LU26
.LU25:
	ldr r1, [sp, #0]
	ldr r1, [r1]
	str r1, [sp, #4]
	b .LU27
.LU26:
	ldr r1, [sp, #0]
	ldr r1, [r1]
	ldr r2, [sp, #8]
	mov r0, #0
	cmp r1, r2
	movgt r0, #1
	cmp r0, #1
	beq .LU28
	b .LU29
.LU28:
	ldr r1, [sp, #0]
	ldr r1, [r1]
	str r1, [sp, #8]
	b .LU29
.LU29:
	b .LU27
.LU27:
	b .LU24
.LU24:
	ldr r1, [sp, #0]
	add r1, r1, #4
	ldr r1, [r1]
	str r1, [sp, #0]
	ldr r2, [sp, #0]
	mov r1, #0
	cmp r2, #0
	movne r1, #1
	cmp r1, #1
	beq .LU20
	b .LU21
.LU21:
	ldr r1, [sp, #4]
	movw r0, #:lower16:.PRINTLN_FMT
	movt r0, #:upper16:.PRINTLN_FMT
	bl printf
	ldr r1, [sp, #8]
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
	ldr r0, [sp, #4]
	ldr r1, [sp, #8]
	bl getRands
	mov r1, r0
	str r1, [sp, #16]
	ldr r1, [sp, #16]
	mov r0, r1
	bl calcMean
	mov r1, r0
	str r1, [sp, #12]
	ldr r1, [sp, #12]
	movw r0, #:lower16:.PRINTLN_FMT
	movt r0, #:upper16:.PRINTLN_FMT
	bl printf
	ldr r1, [sp, #16]
	mov r0, r1
	bl range
	ldr r1, [sp, #16]
	mov r0, r1
	bl approxSqrtAll
	movw r1, #0
	str r1, [sp, #0]
	b .LU30
.LU30:
	ldr r1, [sp, #0]
	mov r0, r1
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
