	.arch armv7-a
	.comm	.read_scratch,4,4

	.text
	.align 2
	.global recursiveDecimalSum
recursiveDecimalSum:
.LU9:
	push {fp, lr}
	add fp, sp, #4
	push {r4, r5, r6, r7}
	mov r6, r0
	mov r5, r1
	mov r4, r2
	mov r1, #0
	cmp r6, #0
	movgt r1, #1
	cmp r1, #1
	beq .LU10
	b .LU11
.LU10:
	movw r1, #10
	mov r0, r6
	bl __aeabi_idiv
	mov r1, r0
	movw r2, #10
	mul r1, r1, r2
	sub r2, r6, r1
	mov r1, #0
	cmp r2, #1
	moveq r1, #1
	cmp r1, #1
	beq .LU13
	b .LU14
.LU13:
	mov r7, #0
	cmp r4, #0
	movgt r7, #1
	movw r1, #1
	movw r2, #1
	movw r0, #2
	mov r3, r4
	cmp r7, #1
	beq .inline0_LU6
	b .inline0_LU7
.inline0_LU6:
	mov r1, r2
	mul r2, r1, r0
	sub r3, r3, #1
	mov r7, #0
	cmp r3, #0
	movgt r7, #1
	mov r1, r2
	cmp r7, #1
	beq .inline0_LU6
	b .inline0_LU7
.inline0_LU7:
	add r5, r5, r1
	b .LU15
.LU14:
	b .LU15
.LU15:
	movw r1, #10
	mov r0, r6
	bl __aeabi_idiv
	mov r6, r0
	add r4, r4, #1
	mov r2, r4
	mov r1, r5
	mov r0, r6
	bl recursiveDecimalSum
	mov r4, r0
	b .LU8
.LU11:
	mov r4, r5
	b .LU8
.LU8:
	mov r0, r4
	pop {r4, r5, r6, r7}
	pop {fp, pc}
	.size recursiveDecimalSum, .-recursiveDecimalSum
	.align 2
	.global convertToDecimal
convertToDecimal:
.LU17:
	push {fp, lr}
	add fp, sp, #4
	movw r2, #0
	movw r1, #0
	bl recursiveDecimalSum
	mov r2, r0
	mov r0, r2
	pop {fp, pc}
	.size convertToDecimal, .-convertToDecimal
	.align 2
	.global main
main:
.LU19:
	push {fp, lr}
	add fp, sp, #4
	push {r4}
	movw r1, #:lower16:.read_scratch
	movt r1, #:upper16:.read_scratch
	movw r0, #:lower16:.READ_FMT
	movt r0, #:upper16:.READ_FMT
	bl scanf
	movw r1, #:lower16:.read_scratch
	movt r1, #:upper16:.read_scratch
	ldr r1, [r1]
	mov r0, r1
	bl convertToDecimal
	mul r3, r0, r0
	mov r1, #0
	cmp r3, #0
	movgt r1, #1
	mov r2, r0
	mov r4, r0
	cmp r1, #1
	beq .LU20
	b .LU21
.LU20:
	mov r1, r4
	mov r2, r3
	mov r0, #0
	cmp r2, #0
	movgt r0, #1
	mov r3, r2
	cmp r0, #1
	beq .inline1_LU2
	b .inline1_LU3
.inline1_LU2:
	mov r0, r3
	sub r3, r0, #1
	mov r0, #0
	cmp r3, #0
	movgt r0, #1
	cmp r0, #1
	beq .inline1_LU2
	b .inline1_LU3
.inline1_LU3:
	sub r3, r2, #1
	mov r0, #0
	cmp r3, #0
	movgt r0, #1
	mov r2, r1
	mov r4, r1
	cmp r0, #1
	beq .LU20
	b .LU21
.LU21:
	mov r1, r2
	movw r0, #:lower16:.PRINTLN_FMT
	movt r0, #:upper16:.PRINTLN_FMT
	bl printf
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
