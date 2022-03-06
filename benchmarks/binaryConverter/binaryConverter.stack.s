	.arch armv7-a


	.text
	.align 2
	.global wait
wait:
.LU1:
	push {fp, lr}
	add fp, sp, #4
	sub sp, sp, #8
	mov r3, r0
	str r3, [sp, #0]
	ldr r0, [sp, #0]
	mov r3, #0
	cmp r0, #0
	movgt r3, #1
	cmp r3, #1
	beq .LU2
	b .LU3
.LU2:
	ldr r3, [sp, #0]
	sub r3, r3, #1
	str r3, [sp, #0]
	ldr r0, [sp, #0]
	mov r3, #0
	cmp r0, #0
	movgt r3, #1
	cmp r3, #1
	beq .LU2
	b .LU3
.LU3:
	movw r3, #0
	str r3, [sp, #4]
	b .LU0
.LU0:
	ldr r3, [sp, #4]
	mov r0, r3
	add sp, sp, #8
	pop {fp, pc}
	.size wait, .-wait
	.align 2
	.global power
power:
.LU5:
	push {fp, lr}
	add fp, sp, #4
	sub sp, sp, #16
	mov r3, r0
	mov r0, r1
	str r3, [sp, #0]
	str r0, [sp, #4]
	movw r3, #1
	str r3, [sp, #12]
	ldr r3, [sp, #4]
	mov r0, #0
	cmp r3, #0
	movgt r0, #1
	cmp r0, #1
	beq .LU6
	b .LU7
.LU6:
	ldr r3, [sp, #12]
	ldr r0, [sp, #0]
	mul r3, r3, r0
	str r3, [sp, #12]
	ldr r3, [sp, #4]
	sub r3, r3, #1
	str r3, [sp, #4]
	ldr r0, [sp, #4]
	mov r3, #0
	cmp r0, #0
	movgt r3, #1
	cmp r3, #1
	beq .LU6
	b .LU7
.LU7:
	ldr r3, [sp, #12]
	str r3, [sp, #8]
	b .LU4
.LU4:
	ldr r3, [sp, #8]
	mov r0, r3
	add sp, sp, #16
	pop {fp, pc}
	.size power, .-power
	.align 2
	.global recursiveDecimalSum
recursiveDecimalSum:
.LU9:
	push {fp, lr}
	add fp, sp, #4
	push {r4}
	sub sp, sp, #24
	mov r3, r0
	mov r0, r1
	mov r1, r2
	str r3, [sp, #0]
	str r0, [sp, #4]
	str r1, [sp, #8]
	ldr r3, [sp, #0]
	mov r0, #0
	cmp r3, #0
	movgt r0, #1
	cmp r0, #1
	beq .LU10
	b .LU11
.LU10:
	movw r3, #2
	str r3, [sp, #20]
	ldr r3, [sp, #0]
	movw r1, #10
	mov r0, r3
	bl __aeabi_idiv
	mov r3, r0
	str r3, [sp, #16]
	ldr r0, [sp, #16]
	movw r3, #10
	mul r3, r0, r3
	str r3, [sp, #16]
	ldr r0, [sp, #0]
	ldr r3, [sp, #16]
	sub r3, r0, r3
	str r3, [sp, #16]
	ldr r3, [sp, #16]
	mov r0, #0
	cmp r3, #1
	moveq r0, #1
	cmp r0, #1
	beq .LU12
	b .LU13
.LU12:
	ldr r4, [sp, #4]
	ldr r3, [sp, #20]
	ldr r0, [sp, #8]
	mov r1, r0
	mov r0, r3
	bl power
	mov r3, r0
	add r3, r4, r3
	str r3, [sp, #4]
	b .LU13
.LU13:
	ldr r3, [sp, #0]
	movw r1, #10
	mov r0, r3
	bl __aeabi_idiv
	mov r3, r0
	ldr r0, [sp, #4]
	ldr r1, [sp, #8]
	add r1, r1, #1
	mov r2, r1
	mov r1, r0
	mov r0, r3
	bl recursiveDecimalSum
	mov r3, r0
	str r3, [sp, #12]
	b .LU8
.LU11:
	ldr r3, [sp, #4]
	str r3, [sp, #12]
	b .LU8
.LU8:
	ldr r3, [sp, #12]
	mov r0, r3
	add sp, sp, #24
	pop {r4}
	pop {fp, pc}
	.size recursiveDecimalSum, .-recursiveDecimalSum
	.align 2
	.global convertToDecimal
convertToDecimal:
.LU15:
	push {fp, lr}
	add fp, sp, #4
	sub sp, sp, #16
	mov r3, r0
	str r3, [sp, #0]
	movw r3, #0
	str r3, [sp, #8]
	movw r3, #0
	str r3, [sp, #12]
	ldr r3, [sp, #0]
	ldr r0, [sp, #12]
	ldr r2, [sp, #8]
	mov r1, r0
	mov r0, r3
	bl recursiveDecimalSum
	mov r3, r0
	str r3, [sp, #4]
	b .LU14
.LU14:
	ldr r3, [sp, #4]
	mov r0, r3
	add sp, sp, #16
	pop {fp, pc}
	.size convertToDecimal, .-convertToDecimal
	.align 2
	.global main
main:
.LU17:
	push {fp, lr}
	add fp, sp, #4
	sub sp, sp, #12
	add r1, sp, #4
	movw r0, #:lower16:.READ_FMT
	movt r0, #:upper16:.READ_FMT
	bl scanf
	ldr r2, [sp, #4]
	mov r0, r2
	bl convertToDecimal
	mov r2, r0
	str r2, [sp, #4]
	ldr r3, [sp, #4]
	ldr r2, [sp, #4]
	mul r2, r3, r2
	str r2, [sp, #8]
	ldr r3, [sp, #8]
	mov r2, #0
	cmp r3, #0
	movgt r2, #1
	cmp r2, #1
	beq .LU18
	b .LU19
.LU18:
	ldr r2, [sp, #8]
	mov r0, r2
	bl wait
	ldr r2, [sp, #8]
	sub r2, r2, #1
	str r2, [sp, #8]
	ldr r2, [sp, #8]
	mov r3, #0
	cmp r2, #0
	movgt r3, #1
	cmp r3, #1
	beq .LU18
	b .LU19
.LU19:
	ldr r2, [sp, #4]
	mov r1, r2
	movw r0, #:lower16:.PRINTLN_FMT
	movt r0, #:upper16:.PRINTLN_FMT
	bl printf
	movw r2, #0
	str r2, [sp, #0]
	b .LU16
.LU16:
	ldr r2, [sp, #0]
	mov r0, r2
	add sp, sp, #12
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
