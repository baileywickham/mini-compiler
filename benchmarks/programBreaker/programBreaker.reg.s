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
	mov r2, r0
	mov r0, #0
	cmp r2, #0
	moveq r0, #1
	cmp r0, #1
	beq .LU2
	b .LU3
.LU2:
	b .LU0
.LU3:
	sub r0, r2, #1
	bl fun2
	mov r1, r0
	b .LU0
.LU0:
	mov r0, r1
	pop {fp, pc}
	.size fun2, .-fun2
	.align 2
	.global fun1
fun1:
.LU6:
	push {fp, lr}
	add fp, sp, #4
	push {r4, r5, r6, r7}
	mov r5, r0
	mov r4, r1
	mov r6, r2
	movw r7, #5
	add r7, r7, #6
	movw r1, #2
	mul r1, r5, r1
	sub r7, r7, r1
	mov r1, r4
	movw r0, #4
	bl __aeabi_idiv
	mov r1, r0
	add r7, r7, r1
	add r6, r7, r6
	mov r7, #0
	cmp r6, r4
	movgt r7, #1
	cmp r7, #1
	beq .LU7
	b .LU8
.LU7:
	mov r1, r5
	mov r0, r6
	bl fun2
	mov r4, r0
	b .LU5
.LU8:
	movw r7, #5
	mov r5, #0
	cmp r7, #6
	movlt r5, #1
	mov r7, #0
	cmp r6, r4
	movle r7, #1
	and r5, r5, r7
	cmp r5, #1
	beq .LU10
	b .LU11
.LU10:
	mov r1, r4
	mov r0, r6
	bl fun2
	mov r4, r0
	b .LU5
.LU11:
	b .LU12
.LU12:
	b .LU9
.LU9:
	mov r4, r6
	b .LU5
.LU5:
	mov r0, r4
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
	movw r4, #:lower16:.read_scratch
	movt r4, #:upper16:.read_scratch
	ldr r1, [r4]
	movw r0, #10000
	mov r4, #0
	cmp r1, r0
	movlt r4, #1
	mov r0, r1
	cmp r4, #1
	beq .LU15
	b .LU16
.LU15:
	mov r4, r0
	movw r2, #5
	mov r1, r4
	movw r0, #3
	bl fun1
	mov r1, r0
	movw r0, #:lower16:.PRINTLN_FMT
	movt r0, #:upper16:.PRINTLN_FMT
	bl printf
	add r0, r4, #1
	movw r1, #10000
	mov r4, #0
	cmp r0, r1
	movlt r4, #1
	cmp r4, #1
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
