	.arch armv7-a
	.comm	.read_scratch,4,4

	.text
	.align 2
	.global mod
mod:
.LU1:
	push {fp, lr}
	add fp, sp, #4
	push {r4, r5}
	mov r4, r0
	mov r5, r1
	mov r1, r5
	mov r0, r4
	bl __aeabi_idiv
	mul r5, r0, r5
	sub r4, r4, r5
	b .LU0
.LU0:
	mov r0, r4
	pop {r4, r5}
	pop {fp, pc}
	.size mod, .-mod
	.align 2
	.global hailstone
hailstone:
.LU3:
	push {fp, lr}
	add fp, sp, #4
	push {r4}
	mov r4, r0
	movw r1, #1
	cmp r1, #1
	beq .LU4
	b .LU5
.LU4:
	mov r1, r4
	movw r0, #:lower16:.PRINT_FMT
	movt r0, #:upper16:.PRINT_FMT
	bl printf
	movw r1, #2
	mov r0, r4
	bl mod
	mov r1, r0
	mov r2, #0
	cmp r1, #1
	moveq r2, #1
	cmp r2, #1
	beq .LU6
	b .LU7
.LU6:
	movw r1, #3
	mul r4, r1, r4
	add r4, r4, #1
	b .LU8
.LU7:
	movw r1, #2
	mov r0, r4
	bl __aeabi_idiv
	mov r4, r0
	b .LU8
.LU8:
	mov r1, r4
	mov r4, #0
	cmp r1, #1
	movle r4, #1
	cmp r4, #1
	beq .LU9
	b .LU10
.LU9:
	movw r0, #:lower16:.PRINTLN_FMT
	movt r0, #:upper16:.PRINTLN_FMT
	bl printf
	b .LU2
.LU10:
	b .LU11
.LU11:
	mov r4, r1
	movw r1, #1
	cmp r1, #1
	beq .LU4
	b .LU5
.LU5:
	b .LU2
.LU2:
	pop {r4}
	pop {fp, pc}
	.size hailstone, .-hailstone
	.align 2
	.global main
main:
.LU13:
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
	bl hailstone
	b .LU12
.LU12:
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
