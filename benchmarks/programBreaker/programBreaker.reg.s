	.arch armv7-a
	.comm	.read_scratch,4,4
	.comm	GLOBAL,4,4
	.comm	count,4,4

	.text
	.align 2
	.global fun2
fun2:
.LU1:
	push {fp, lr}
	add fp, sp, #4
	mov r2, r1
	mov r1, #0
	cmp r0, #0
	moveq r1, #1
	cmp r1, #1
	beq .LU2
	b .LU3
.LU2:
	mov r0, r2
	b .LU0
.LU3:
	sub r0, r0, #1
	mov r1, r2
	bl fun2
	b .LU0
.LU0:
	pop {fp, pc}
	.size fun2, .-fun2
	.align 2
	.global fun1
fun1:
.LU6:
	push {fp, lr}
	add fp, sp, #4
	push {r4, r5, r6, r7}
	mov r7, r0
	mov r6, r1
	mov r5, r2
	movw r2, #5
	add r1, r2, #6
	movw r2, #2
	mul r2, r7, r2
	sub r4, r1, r2
	mov r1, r6
	movw r0, #4
	bl __aeabi_idiv
	mov r2, r0
	add r2, r4, r2
	add r2, r2, r5
	mov r1, #0
	cmp r2, r6
	movgt r1, #1
	cmp r1, #1
	beq .LU7
	b .LU8
.LU7:
	mov r1, r7
	mov r0, r2
	bl fun2
	mov r2, r0
	b .LU5
.LU8:
	movw r1, #5
	mov r3, #0
	cmp r1, #6
	movlt r3, #1
	mov r1, #0
	cmp r2, r6
	movle r1, #1
	and r1, r3, r1
	cmp r1, #1
	beq .LU10
	b .LU11
.LU10:
	mov r1, r6
	mov r0, r2
	bl fun2
	mov r2, r0
	b .LU5
.LU11:
	b .LU12
.LU12:
	b .LU9
.LU9:
	b .LU5
.LU5:
	mov r0, r2
	pop {r4, r5, r6, r7}
	pop {fp, pc}
	.size fun1, .-fun1
	.align 2
	.global main
main:
.LU14:
	push {fp, lr}
	add fp, sp, #4
	push {r4}
	movw r1, #:lower16:.read_scratch
	movt r1, #:upper16:.read_scratch
	movw r0, #:lower16:.READ_FMT
	movt r0, #:upper16:.READ_FMT
	bl scanf
	movw r3, #:lower16:.read_scratch
	movt r3, #:upper16:.read_scratch
	ldr r1, [r3]
	movw r3, #10000
	mov r0, #0
	cmp r1, r3
	movlt r0, #1
	mov r3, r1
	cmp r0, #1
	beq .LU15
	b .LU16
.LU15:
	mov r4, r3
	movw r2, #5
	mov r1, r4
	movw r0, #3
	bl fun1
	mov r3, r0
	mov r1, r3
	movw r0, #:lower16:.PRINTLN_FMT
	movt r0, #:upper16:.PRINTLN_FMT
	bl printf
	add r0, r4, #1
	movw r3, #10000
	mov r1, #0
	cmp r0, r3
	movlt r1, #1
	mov r3, r0
	cmp r1, #1
	beq .LU15
	b .LU16
.LU16:
	b .LU13
.LU13:
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
