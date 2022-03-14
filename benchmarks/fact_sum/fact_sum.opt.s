	.arch armv7-a
	.comm	.read_scratch,4,4

	.text
	.align 2
	.global fact
fact:
.LU3:
	push {fp, lr}
	add fp, sp, #4
	push {r4}
	mov r4, r0
	mov r2, #0
	cmp r4, #1
	moveq r2, #1
	mov r1, #0
	cmp r4, #0
	moveq r1, #1
	orr r1, r2, r1
	cmp r1, #1
	beq .LU4
	b .LU5
.LU4:
	movw r4, #1
	b .LU2
.LU5:
	mov r1, #0
	cmp r4, #1
	movle r1, #1
	cmp r1, #1
	beq .LU7
	b .LU8
.LU7:
	movw r1, #:lower16:-1
	movt r1, #:upper16:-1
	mul r4, r1, r4
	mov r0, r4
	bl fact
	mov r4, r0
	b .LU2
.LU8:
	sub r1, r4, #1
	mov r0, r1
	bl fact
	mov r1, r0
	mul r4, r4, r1
	b .LU2
.LU2:
	mov r0, r4
	pop {r4}
	pop {fp, pc}
	.size fact, .-fact
	.align 2
	.global main
main:
.LU11:
	push {fp, lr}
	add fp, sp, #4
	push {r4, r5}
	movw r0, #1
	cmp r0, #1
	beq .LU12
	b .LU13
.LU12:
	movw r1, #:lower16:.read_scratch
	movt r1, #:upper16:.read_scratch
	movw r0, #:lower16:.READ_FMT
	movt r0, #:upper16:.READ_FMT
	bl scanf
	movw r0, #:lower16:.read_scratch
	movt r0, #:upper16:.read_scratch
	ldr r5, [r0]
	movw r1, #:lower16:.read_scratch
	movt r1, #:upper16:.read_scratch
	movw r0, #:lower16:.READ_FMT
	movt r0, #:upper16:.READ_FMT
	bl scanf
	movw r0, #:lower16:.read_scratch
	movt r0, #:upper16:.read_scratch
	ldr r4, [r0]
	mov r0, r5
	bl fact
	mov r5, r0
	mov r0, r4
	bl fact
	add r0, r5, r0
	mov r1, r0
	movw r0, #:lower16:.PRINTLN_FMT
	movt r0, #:upper16:.PRINTLN_FMT
	bl printf
	movw r1, #:lower16:.read_scratch
	movt r1, #:upper16:.read_scratch
	movw r0, #:lower16:.READ_FMT
	movt r0, #:upper16:.READ_FMT
	bl scanf
	movw r0, #:lower16:.read_scratch
	movt r0, #:upper16:.read_scratch
	ldr r0, [r0]
	movw r2, #:lower16:-1
	movt r2, #:upper16:-1
	mov r1, #0
	cmp r0, r2
	movne r1, #1
	cmp r1, #1
	beq .LU12
	b .LU13
.LU13:
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
