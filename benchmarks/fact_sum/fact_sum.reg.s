	.arch armv7-a
	.comm	.read_scratch,4,4

	.text
	.align 2
	.global sum
sum:
.LU1:
	push {fp, lr}
	add fp, sp, #4
	mov r2, r0
	add r1, r2, r1
	b .LU0
.LU0:
	mov r0, r1
	pop {fp, pc}
	.size sum, .-sum
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
	b .LU6
.LU6:
	mov r1, #0
	cmp r4, #1
	movle r1, #1
	cmp r1, #1
	beq .LU7
	b .LU8
.LU7:
	movw r1, #0
	sub r1, r1, #1
	mul r4, r1, r4
	mov r0, r4
	bl fact
	mov r4, r0
	b .LU2
.LU8:
	b .LU9
.LU9:
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
	movw r1, #0
	sub r1, r1, #1
	movw r2, #0
	mov r4, #0
	cmp r2, r1
	movne r4, #1
	cmp r4, #1
	beq .LU12
	b .LU13
.LU12:
	movw r1, #:lower16:.read_scratch
	movt r1, #:upper16:.read_scratch
	movw r0, #:lower16:.READ_FMT
	movt r0, #:upper16:.READ_FMT
	bl scanf
	movw r1, #:lower16:.read_scratch
	movt r1, #:upper16:.read_scratch
	ldr r4, [r1]
	movw r1, #:lower16:.read_scratch
	movt r1, #:upper16:.read_scratch
	movw r0, #:lower16:.READ_FMT
	movt r0, #:upper16:.READ_FMT
	bl scanf
	movw r1, #:lower16:.read_scratch
	movt r1, #:upper16:.read_scratch
	ldr r5, [r1]
	mov r0, r4
	bl fact
	mov r4, r0
	mov r0, r5
	bl fact
	mov r1, r0
	mov r0, r4
	bl sum
	mov r1, r0
	movw r0, #:lower16:.PRINTLN_FMT
	movt r0, #:upper16:.PRINTLN_FMT
	bl printf
	movw r1, #:lower16:.read_scratch
	movt r1, #:upper16:.read_scratch
	movw r0, #:lower16:.READ_FMT
	movt r0, #:upper16:.READ_FMT
	bl scanf
	movw r1, #:lower16:.read_scratch
	movt r1, #:upper16:.read_scratch
	ldr r1, [r1]
	movw r2, #0
	sub r2, r2, #1
	mov r4, #0
	cmp r1, r2
	movne r4, #1
	cmp r4, #1
	beq .LU12
	b .LU13
.LU13:
	b .LU10
.LU10:
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
