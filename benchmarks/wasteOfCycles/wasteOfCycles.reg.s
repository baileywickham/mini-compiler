	.arch armv7-a
	.comm	.read_scratch,4,4

	.text
	.align 2
	.global function
function:
.LU1:
	push {fp, lr}
	add fp, sp, #4
	push {r4, r5}
	mov r4, r0
	mov r5, #0
	cmp r4, #0
	movle r5, #1
	cmp r5, #1
	beq .LU2
	b .LU3
.LU2:
	movw r4, #0
	b .LU0
.LU3:
	b .LU4
.LU4:
	mul r2, r4, r4
	movw r1, #0
	mov r5, #0
	cmp r1, r2
	movlt r5, #1
	mov r1, r4
	movw r2, #0
	cmp r5, #1
	beq .LU5
	b .LU6
.LU5:
	mov r5, r2
	add r1, r5, r4
	movw r0, #:lower16:.PRINT_FMT
	movt r0, #:upper16:.PRINT_FMT
	bl printf
	add r2, r5, #1
	mul r1, r4, r4
	mov r5, #0
	cmp r2, r1
	movlt r5, #1
	mov r1, r4
	cmp r5, #1
	beq .LU5
	b .LU6
.LU6:
	mov r4, r1
	sub r4, r4, #1
	mov r0, r4
	bl function
	mov r4, r0
	b .LU0
.LU0:
	mov r0, r4
	pop {r4, r5}
	pop {fp, pc}
	.size function, .-function
	.align 2
	.global main
main:
.LU8:
	push {fp, lr}
	add fp, sp, #4
	movw r1, #:lower16:.read_scratch
	movt r1, #:upper16:.read_scratch
	movw r0, #:lower16:.READ_FMT
	movt r0, #:upper16:.READ_FMT
	bl scanf
	movw r2, #:lower16:.read_scratch
	movt r2, #:upper16:.read_scratch
	ldr r2, [r2]
	mov r0, r2
	bl function
	movw r1, #0
	movw r0, #:lower16:.PRINTLN_FMT
	movt r0, #:upper16:.PRINTLN_FMT
	bl printf
	b .LU7
.LU7:
	movw r0, #0
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
