	.arch armv7-a
	.comm	.read_scratch,4,4

	.text
	.align 2
	.global buildList
buildList:
.LU1:
	push {fp, lr}
	add fp, sp, #4
	push {r4, r5, r6, r7, r8, r9}
	movw r0, #8
	bl malloc
	mov r4, r0
	movw r0, #8
	bl malloc
	mov r5, r0
	movw r0, #8
	bl malloc
	mov r6, r0
	movw r0, #8
	bl malloc
	mov r7, r0
	mov r9, r7
	movw r0, #8
	bl malloc
	mov r7, r0
	movw r0, #8
	bl malloc
	mov r8, r0
	movw r1, #:lower16:.read_scratch
	movt r1, #:upper16:.read_scratch
	movw r0, #:lower16:.READ_FMT
	movt r0, #:upper16:.READ_FMT
	bl scanf
	movw r1, #:lower16:.read_scratch
	movt r1, #:upper16:.read_scratch
	ldr r2, [r1]
	mov r1, r4
	str r2, [r1]
	movw r1, #:lower16:.read_scratch
	movt r1, #:upper16:.read_scratch
	movw r0, #:lower16:.READ_FMT
	movt r0, #:upper16:.READ_FMT
	bl scanf
	movw r1, #:lower16:.read_scratch
	movt r1, #:upper16:.read_scratch
	ldr r1, [r1]
	mov r2, r5
	str r1, [r2]
	movw r1, #:lower16:.read_scratch
	movt r1, #:upper16:.read_scratch
	movw r0, #:lower16:.READ_FMT
	movt r0, #:upper16:.READ_FMT
	bl scanf
	movw r1, #:lower16:.read_scratch
	movt r1, #:upper16:.read_scratch
	ldr r2, [r1]
	mov r1, r6
	str r2, [r1]
	movw r1, #:lower16:.read_scratch
	movt r1, #:upper16:.read_scratch
	movw r0, #:lower16:.READ_FMT
	movt r0, #:upper16:.READ_FMT
	bl scanf
	movw r1, #:lower16:.read_scratch
	movt r1, #:upper16:.read_scratch
	ldr r2, [r1]
	mov r1, r9
	str r2, [r1]
	movw r1, #:lower16:.read_scratch
	movt r1, #:upper16:.read_scratch
	movw r0, #:lower16:.READ_FMT
	movt r0, #:upper16:.READ_FMT
	bl scanf
	movw r1, #:lower16:.read_scratch
	movt r1, #:upper16:.read_scratch
	ldr r2, [r1]
	mov r1, r7
	str r2, [r1]
	movw r1, #:lower16:.read_scratch
	movt r1, #:upper16:.read_scratch
	movw r0, #:lower16:.READ_FMT
	movt r0, #:upper16:.READ_FMT
	bl scanf
	movw r1, #:lower16:.read_scratch
	movt r1, #:upper16:.read_scratch
	ldr r1, [r1]
	mov r2, r8
	str r1, [r2]
	add r1, r4, #4
	str r5, [r1]
	add r5, r5, #4
	str r6, [r5]
	add r5, r6, #4
	str r9, [r5]
	add r5, r9, #4
	str r7, [r5]
	add r5, r7, #4
	str r8, [r5]
	add r6, r8, #4
	movw r5, #0
	str r5, [r6]
	b .LU0
.LU0:
	mov r0, r4
	pop {r4, r5, r6, r7, r8, r9}
	pop {fp, pc}
	.size buildList, .-buildList
	.align 2
	.global multiple
multiple:
.LU3:
	push {fp, lr}
	add fp, sp, #4
	push {r4, r5, r6}
	mov r6, r0
	mov r4, r6
	ldr r5, [r4]
	add r4, r6, #4
	ldr r1, [r4]
	movw r4, #0
	mov r6, #0
	cmp r4, #5
	movlt r6, #1
	mov r4, r5
	mov r2, r1
	movw r0, #0
	cmp r6, #1
	beq .LU4
	b .LU5
.LU4:
	mov r4, r0
	mov r6, r2
	mov r1, r6
	ldr r1, [r1]
	mul r5, r5, r1
	add r6, r6, #4
	ldr r6, [r6]
	mov r1, r5
	movw r0, #:lower16:.PRINTLN_FMT
	movt r0, #:upper16:.PRINTLN_FMT
	bl printf
	add r0, r4, #1
	mov r1, #0
	cmp r0, #5
	movlt r1, #1
	mov r4, r5
	mov r2, r6
	cmp r1, #1
	beq .LU4
	b .LU5
.LU5:
	b .LU2
.LU2:
	mov r0, r4
	pop {r4, r5, r6}
	pop {fp, pc}
	.size multiple, .-multiple
	.align 2
	.global add
add:
.LU7:
	push {fp, lr}
	add fp, sp, #4
	push {r4, r5, r6}
	mov r6, r0
	mov r4, r6
	ldr r5, [r4]
	add r4, r6, #4
	ldr r1, [r4]
	movw r4, #0
	mov r6, #0
	cmp r4, #5
	movlt r6, #1
	mov r4, r5
	mov r2, r1
	movw r0, #0
	cmp r6, #1
	beq .LU8
	b .LU9
.LU8:
	mov r4, r0
	mov r6, r2
	mov r1, r6
	ldr r1, [r1]
	add r5, r5, r1
	add r6, r6, #4
	ldr r6, [r6]
	mov r1, r5
	movw r0, #:lower16:.PRINTLN_FMT
	movt r0, #:upper16:.PRINTLN_FMT
	bl printf
	add r0, r4, #1
	mov r1, #0
	cmp r0, #5
	movlt r1, #1
	mov r4, r5
	mov r2, r6
	cmp r1, #1
	beq .LU8
	b .LU9
.LU9:
	b .LU6
.LU6:
	mov r0, r4
	pop {r4, r5, r6}
	pop {fp, pc}
	.size add, .-add
	.align 2
	.global recurseList
recurseList:
.LU11:
	push {fp, lr}
	add fp, sp, #4
	push {r4}
	mov r1, r0
	add r4, r1, #4
	ldr r4, [r4]
	mov r2, #0
	cmp r4, #0
	moveq r2, #1
	cmp r2, #1
	beq .LU12
	b .LU13
.LU12:
	mov r4, r1
	ldr r4, [r4]
	b .LU10
.LU13:
	mov r4, r1
	ldr r4, [r4]
	add r1, r1, #4
	ldr r1, [r1]
	mov r0, r1
	bl recurseList
	mov r1, r0
	mul r4, r4, r1
	b .LU10
.LU10:
	mov r0, r4
	pop {r4}
	pop {fp, pc}
	.size recurseList, .-recurseList
	.align 2
	.global main
main:
.LU16:
	push {fp, lr}
	add fp, sp, #4
	push {r4, r5, r6, r7}
	bl buildList
	mov r4, r0
	mov r0, r4
	bl multiple
	mov r5, r0
	mov r0, r4
	bl add
	mov r6, r0
	movw r1, #2
	mov r0, r6
	bl __aeabi_idiv
	mov r1, r0
	sub r3, r5, r1
	movw r1, #0
	mov r0, #0
	cmp r1, #2
	movlt r0, #1
	movw r1, #0
	mov r6, r3
	movw r2, #0
	mov r5, r4
	movw r7, #0
	mov r4, r3
	cmp r0, #1
	beq .LU17
	b .LU18
.LU17:
	mov r6, r7
	mov r7, r2
	mov r0, r5
	bl recurseList
	mov r1, r0
	add r2, r7, r1
	add r3, r6, #1
	mov r0, #0
	cmp r3, #2
	movlt r0, #1
	mov r1, r2
	mov r6, r4
	mov r7, r3
	cmp r0, #1
	beq .LU17
	b .LU18
.LU18:
	mov r7, r6
	mov r5, r1
	mov r1, r5
	movw r0, #:lower16:.PRINTLN_FMT
	movt r0, #:upper16:.PRINTLN_FMT
	bl printf
	mov r6, #0
	cmp r5, #0
	movne r6, #1
	mov r4, r7
	mov r1, r5
	mov r2, r7
	cmp r6, #1
	beq .LU19
	b .LU20
.LU19:
	mov r4, r5
	sub r5, r4, #1
	mov r6, #0
	cmp r5, #0
	movne r6, #1
	mov r4, r2
	mov r1, r5
	cmp r6, #1
	beq .LU19
	b .LU20
.LU20:
	mov r5, r1
	mov r1, r4
	movw r0, #:lower16:.PRINTLN_FMT
	movt r0, #:upper16:.PRINTLN_FMT
	bl printf
	mov r1, r5
	movw r0, #:lower16:.PRINTLN_FMT
	movt r0, #:upper16:.PRINTLN_FMT
	bl printf
	b .LU15
.LU15:
	movw r0, #0
	pop {r4, r5, r6, r7}
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
