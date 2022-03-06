	.arch armv7-a
	.comm	.read_scratch,4,4

	.text
	.align 2
	.global wait
wait:
.LU1:
	push {fp, lr}
	add fp, sp, #4
	mov r3, r0
	mov r0, #0
	cmp r3, #0
	movgt r0, #1
	cmp r0, #1
	beq .LU2
	b .LU3
.LU2:
	sub r3, r3, #1
	mov r0, #0
	cmp r3, #0
	movgt r0, #1
	cmp r0, #1
	beq .LU2
	b .LU3
.LU3:
	b .LU0
.LU0:
	movw r0, #0
	pop {fp, pc}
	.size wait, .-wait
	.align 2
	.global power
power:
.LU5:
	push {fp, lr}
	add fp, sp, #4
	push {r4}
	mov r2, r0
	mov r0, r1
	mov r3, #0
	cmp r0, #0
	movgt r3, #1
	movw r4, #1
	movw r1, #1
	cmp r3, #1
	beq .LU6
	b .LU7
.LU6:
	mov r3, r0
	mul r1, r1, r2
	sub r0, r3, #1
	mov r3, #0
	cmp r0, #0
	movgt r3, #1
	mov r4, r1
	cmp r3, #1
	beq .LU6
	b .LU7
.LU7:
	mov r2, r4
	b .LU4
.LU4:
	mov r0, r2
	pop {r4}
	pop {fp, pc}
	.size power, .-power
	.align 2
	.global recursiveDecimalSum
recursiveDecimalSum:
.LU9:
	push {fp, lr}
	add fp, sp, #4
	push {r4, r5, r6}
	mov r4, r0
	mov r5, r1
	mov r6, r2
	mov r3, #0
	cmp r4, #0
	movgt r3, #1
	cmp r3, #1
	beq .LU10
	b .LU11
.LU10:
	movw r1, #10
	mov r0, r4
	bl __aeabi_idiv
	movw r3, #10
	mul r3, r0, r3
	sub r0, r4, r3
	mov r3, #0
	cmp r0, #1
	moveq r3, #1
	cmp r3, #1
	beq .LU13
	b .LU14
.LU13:
	mov r1, r6
	movw r0, #2
	bl power
	mov r3, r0
	add r0, r5, r3
	mov r3, r4
	mov r1, r6
	b .LU15
.LU14:
	mov r3, r4
	mov r0, r5
	mov r1, r6
	b .LU15
.LU15:
	mov r5, r1
	mov r4, r0
	movw r1, #10
	mov r0, r3
	bl __aeabi_idiv
	mov r3, r0
	add r0, r5, #1
	mov r2, r0
	mov r1, r4
	mov r0, r3
	bl recursiveDecimalSum
	mov r3, r0
	b .LU8
.LU11:
	b .LU12
.LU12:
	mov r3, r5
	b .LU8
.LU8:
	mov r0, r3
	pop {r4, r5, r6}
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
	b .LU16
.LU16:
	pop {fp, pc}
	.size convertToDecimal, .-convertToDecimal
	.align 2
	.global main
main:
.LU19:
	push {fp, lr}
	add fp, sp, #4
	push {r4, r5}
	movw r1, #:lower16:.read_scratch
	movt r1, #:upper16:.read_scratch
	movw r0, #:lower16:.READ_FMT
	movt r0, #:upper16:.READ_FMT
	bl scanf
	movw r3, #:lower16:.read_scratch
	movt r3, #:upper16:.read_scratch
	ldr r3, [r3]
	mov r0, r3
	bl convertToDecimal
	mov r3, r0
	mul r2, r3, r3
	mov r1, #0
	cmp r2, #0
	movgt r1, #1
	mov r0, r3
	cmp r1, #1
	beq .LU20
	b .LU21
.LU20:
	mov r5, r3
	mov r4, r2
	mov r0, r4
	bl wait
	sub r3, r4, #1
	mov r1, #0
	cmp r3, #0
	movgt r1, #1
	mov r0, r5
	mov r2, r3
	mov r3, r5
	cmp r1, #1
	beq .LU20
	b .LU21
.LU21:
	mov r3, r0
	mov r1, r3
	movw r0, #:lower16:.PRINTLN_FMT
	movt r0, #:upper16:.PRINTLN_FMT
	bl printf
	b .LU18
.LU18:
	movw r0, #0
	pop {r4, r5}
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
