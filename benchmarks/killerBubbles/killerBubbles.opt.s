	.arch armv7-a
	.comm	.read_scratch,4,4
	.comm	swapped,4,4

	.text
	.align 2
	.global compare
compare:
.LU1:
	push {fp, lr}
	add fp, sp, #4
	mov r2, r0
	mov r3, r1
	ldr r2, [r2]
	ldr r3, [r3]
	sub r2, r2, r3
	b .LU0
.LU0:
	mov r0, r2
	pop {fp, pc}
	.size compare, .-compare
	.align 2
	.global deathSort
deathSort:
.LU3:
	push {fp, lr}
	add fp, sp, #4
	push {r4, r5, r6}
	mov r2, r0
	movw r3, #1
	cmp r3, #1
	beq .LU4
	b .LU5
.LU4:
	mov r3, r2
	add r2, r3, #8
	ldr r2, [r2]
	mov r1, #0
	cmp r2, r3
	movne r1, #1
	movw r0, #0
	mov r4, r3
	mov r2, r3
	movw r5, #0
	cmp r1, #1
	beq .LU6
	b .LU7
.LU6:
	mov r4, r3
	mov r6, r2
	add r2, r6, #8
	ldr r2, [r2]
	mov r1, r2
	mov r0, r6
	bl compare
	mov r2, r0
	mov r3, #0
	cmp r2, #0
	movgt r3, #1
	cmp r3, #1
	beq .LU8
	b .LU9
.LU8:
	mov r2, r6
	ldr r1, [r2]
	add r2, r6, #8
	ldr r2, [r2]
	ldr r2, [r2]
	mov r3, r6
	str r2, [r3]
	add r2, r6, #8
	ldr r2, [r2]
	str r1, [r2]
	mov r2, r6
	mov r3, r4
	movw r1, #1
	b .LU10
.LU9:
	mov r2, r6
	mov r3, r4
	mov r1, r5
	b .LU10
.LU10:
	mov r5, r1
	add r2, r2, #8
	ldr r2, [r2]
	add r1, r2, #8
	ldr r0, [r1]
	mov r1, #0
	cmp r0, r3
	movne r1, #1
	mov r0, r5
	mov r4, r3
	cmp r1, #1
	beq .LU6
	b .LU7
.LU7:
	mov r2, r4
	mov r3, r0
	mov r1, #0
	cmp r3, #1
	moveq r1, #1
	cmp r1, #1
	beq .LU4
	b .LU5
.LU5:
	b .LU2
.LU2:
	pop {r4, r5, r6}
	pop {fp, pc}
	.size deathSort, .-deathSort
	.align 2
	.global printEVILList
printEVILList:
.LU12:
	push {fp, lr}
	add fp, sp, #4
	push {r4, r5, r6}
	mov r4, r0
	add r3, r4, #8
	ldr r5, [r3]
	mov r3, r4
	ldr r3, [r3]
	mov r1, r3
	movw r0, #:lower16:.PRINTLN_FMT
	movt r0, #:upper16:.PRINTLN_FMT
	bl printf
	mov r3, r4
	mov r0, r3
	bl free
	mov r2, #0
	cmp r5, r4
	movne r2, #1
	mov r3, r5
	cmp r2, #1
	beq .LU13
	b .LU14
.LU13:
	mov r6, r3
	mov r3, r6
	ldr r3, [r3]
	mov r1, r3
	movw r0, #:lower16:.PRINTLN_FMT
	movt r0, #:upper16:.PRINTLN_FMT
	bl printf
	add r3, r6, #8
	ldr r5, [r3]
	mov r3, r6
	mov r0, r3
	bl free
	mov r2, #0
	cmp r5, r4
	movne r2, #1
	mov r3, r5
	cmp r2, #1
	beq .LU13
	b .LU14
.LU14:
	b .LU11
.LU11:
	pop {r4, r5, r6}
	pop {fp, pc}
	.size printEVILList, .-printEVILList
	.align 2
	.global main
main:
.LU16:
	push {fp, lr}
	add fp, sp, #4
	push {r4, r5, r6}
	movw r2, #666
	movw r3, #:lower16:swapped
	movt r3, #:upper16:swapped
	str r2, [r3]
	movw r1, #:lower16:.read_scratch
	movt r1, #:upper16:.read_scratch
	movw r0, #:lower16:.READ_FMT
	movt r0, #:upper16:.READ_FMT
	bl scanf
	movw r2, #:lower16:.read_scratch
	movt r2, #:upper16:.read_scratch
	ldr r3, [r2]
	mov r2, #0
	cmp r3, #0
	movle r2, #1
	cmp r2, #1
	beq .LU17
	b .LU18
.LU17:
	movw r1, #:lower16:-1
	movt r1, #:upper16:-1
	movw r0, #:lower16:.PRINTLN_FMT
	movt r0, #:upper16:.PRINTLN_FMT
	bl printf
	movw r2, #:lower16:-1
	movt r2, #:upper16:-1
	b .LU15
.LU18:
	b .LU19
.LU19:
	movw r2, #1000
	mul r5, r3, r2
	movw r0, #12
	bl malloc
	mov r2, r0
	mov r4, r2
	mov r2, r4
	str r5, [r2]
	add r2, r4, #4
	str r4, [r2]
	add r2, r4, #8
	str r4, [r2]
	sub r2, r5, #1
	mov r0, #0
	cmp r2, #0
	movgt r0, #1
	mov r1, r4
	mov r3, r2
	mov r2, r4
	cmp r0, #1
	beq .LU20
	b .LU21
.LU20:
	mov r5, r4
	mov r6, r2
	mov r4, r3
	movw r0, #12
	bl malloc
	mov r2, r0
	mov r3, r2
	str r4, [r3]
	add r3, r2, #4
	str r6, [r3]
	add r3, r2, #8
	str r5, [r3]
	add r3, r6, #8
	str r2, [r3]
	sub r3, r4, #1
	mov r0, #0
	cmp r3, #0
	movgt r0, #1
	mov r1, r5
	mov r4, r5
	cmp r0, #1
	beq .LU20
	b .LU21
.LU21:
	mov r4, r1
	mov r0, r4
	bl deathSort
	mov r0, r4
	bl printEVILList
	movw r2, #0
	b .LU15
.LU15:
	mov r0, r2
	pop {r4, r5, r6}
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
