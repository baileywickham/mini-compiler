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
	mov r3, r1
	add r2, r2, r3
	b .LU0
.LU0:
	mov r0, r2
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
	mov r3, #0
	cmp r4, #1
	moveq r3, #1
	mov r0, #0
	cmp r4, #0
	moveq r0, #1
	orr r3, r3, r0
	cmp r3, #1
	beq .LU4
	b .LU5
.LU4:
	movw r3, #1
	b .LU2
.LU5:
	b .LU6
.LU6:
	mov r3, #0
	cmp r4, #1
	movle r3, #1
	cmp r3, #1
	beq .LU7
	b .LU8
.LU7:
	movw r3, #0
	sub r3, r3, #1
	mul r3, r3, r4
	mov r0, r3
	bl fact
	mov r3, r0
	b .LU2
.LU8:
	b .LU9
.LU9:
	sub r3, r4, #1
	mov r0, r3
	bl fact
	mov r3, r0
	mul r3, r4, r3
	b .LU2
.LU2:
	mov r0, r3
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
	movw r3, #0
	sub r3, r3, #1
	movw r1, #0
	mov r0, #0
	cmp r1, r3
	movne r0, #1
	cmp r0, #1
	beq .LU12
	b .LU13
.LU12:
	movw r1, #:lower16:.read_scratch
	movt r1, #:upper16:.read_scratch
	movw r0, #:lower16:.READ_FMT
	movt r0, #:upper16:.READ_FMT
	bl scanf
	movw r3, #:lower16:.read_scratch
	movt r3, #:upper16:.read_scratch
	ldr r4, [r3]
	movw r1, #:lower16:.read_scratch
	movt r1, #:upper16:.read_scratch
	movw r0, #:lower16:.READ_FMT
	movt r0, #:upper16:.READ_FMT
	bl scanf
	movw r3, #:lower16:.read_scratch
	movt r3, #:upper16:.read_scratch
	ldr r5, [r3]
	mov r0, r4
	bl fact
	mov r4, r0
	mov r0, r5
	bl fact
	mov r3, r0
	mov r1, r3
	mov r0, r4
	bl sum
	mov r3, r0
	mov r1, r3
	movw r0, #:lower16:.PRINTLN_FMT
	movt r0, #:upper16:.PRINTLN_FMT
	bl printf
	movw r1, #:lower16:.read_scratch
	movt r1, #:upper16:.read_scratch
	movw r0, #:lower16:.READ_FMT
	movt r0, #:upper16:.READ_FMT
	bl scanf
	movw r3, #:lower16:.read_scratch
	movt r3, #:upper16:.read_scratch
	ldr r0, [r3]
	movw r3, #0
	sub r3, r3, #1
	mov r1, #0
	cmp r0, r3
	movne r1, #1
	cmp r1, #1
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
