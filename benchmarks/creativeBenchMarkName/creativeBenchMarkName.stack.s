	.arch armv7-a


	.text
	.align 2
	.global buildList
buildList:
.LU1:
	push {fp, lr}
	add fp, sp, #4
	sub sp, sp, #28
	movw r0, #8
	bl malloc
	mov r2, r0
	str r2, [sp, #4]
	movw r0, #8
	bl malloc
	mov r2, r0
	str r2, [sp, #8]
	movw r0, #8
	bl malloc
	mov r2, r0
	str r2, [sp, #12]
	movw r0, #8
	bl malloc
	mov r2, r0
	str r2, [sp, #16]
	movw r0, #8
	bl malloc
	mov r2, r0
	str r2, [sp, #20]
	movw r0, #8
	bl malloc
	mov r2, r0
	str r2, [sp, #24]
	ldr r2, [sp, #4]
	mov r1, r2
	movw r0, #:lower16:.READ_FMT
	movt r0, #:upper16:.READ_FMT
	bl scanf
	ldr r2, [sp, #8]
	mov r1, r2
	movw r0, #:lower16:.READ_FMT
	movt r0, #:upper16:.READ_FMT
	bl scanf
	ldr r2, [sp, #12]
	mov r1, r2
	movw r0, #:lower16:.READ_FMT
	movt r0, #:upper16:.READ_FMT
	bl scanf
	ldr r2, [sp, #16]
	mov r1, r2
	movw r0, #:lower16:.READ_FMT
	movt r0, #:upper16:.READ_FMT
	bl scanf
	ldr r2, [sp, #20]
	mov r1, r2
	movw r0, #:lower16:.READ_FMT
	movt r0, #:upper16:.READ_FMT
	bl scanf
	ldr r2, [sp, #24]
	mov r1, r2
	movw r0, #:lower16:.READ_FMT
	movt r0, #:upper16:.READ_FMT
	bl scanf
	ldr r3, [sp, #8]
	ldr r2, [sp, #4]
	add r2, r2, #4
	str r3, [r2]
	ldr r3, [sp, #12]
	ldr r2, [sp, #8]
	add r2, r2, #4
	str r3, [r2]
	ldr r3, [sp, #16]
	ldr r2, [sp, #12]
	add r2, r2, #4
	str r3, [r2]
	ldr r3, [sp, #20]
	ldr r2, [sp, #16]
	add r2, r2, #4
	str r3, [r2]
	ldr r3, [sp, #24]
	ldr r2, [sp, #20]
	add r2, r2, #4
	str r3, [r2]
	ldr r2, [sp, #24]
	add r3, r2, #4
	movw r2, #0
	str r2, [r3]
	ldr r2, [sp, #4]
	str r2, [sp, #0]
	b .LU0
.LU0:
	ldr r2, [sp, #0]
	mov r0, r2
	add sp, sp, #28
	pop {fp, pc}
	.size buildList, .-buildList
	.align 2
	.global multiple
multiple:
.LU3:
	push {fp, lr}
	add fp, sp, #4
	sub sp, sp, #20
	mov r3, r0
	str r3, [sp, #0]
	movw r3, #0
	str r3, [sp, #8]
	ldr r3, [sp, #0]
	str r3, [sp, #16]
	ldr r3, [sp, #16]
	ldr r3, [r3]
	str r3, [sp, #12]
	ldr r3, [sp, #16]
	add r3, r3, #4
	ldr r3, [r3]
	str r3, [sp, #16]
	ldr r3, [sp, #8]
	mov r0, #0
	cmp r3, #5
	movlt r0, #1
	cmp r0, #1
	beq .LU4
	b .LU5
.LU4:
	ldr r0, [sp, #12]
	ldr r3, [sp, #16]
	ldr r3, [r3]
	mul r3, r0, r3
	str r3, [sp, #12]
	ldr r3, [sp, #16]
	add r3, r3, #4
	ldr r3, [r3]
	str r3, [sp, #16]
	ldr r3, [sp, #12]
	mov r1, r3
	movw r0, #:lower16:.PRINTLN_FMT
	movt r0, #:upper16:.PRINTLN_FMT
	bl printf
	ldr r3, [sp, #8]
	add r3, r3, #1
	str r3, [sp, #8]
	ldr r3, [sp, #8]
	mov r0, #0
	cmp r3, #5
	movlt r0, #1
	cmp r0, #1
	beq .LU4
	b .LU5
.LU5:
	ldr r3, [sp, #12]
	str r3, [sp, #4]
	b .LU2
.LU2:
	ldr r3, [sp, #4]
	mov r0, r3
	add sp, sp, #20
	pop {fp, pc}
	.size multiple, .-multiple
	.align 2
	.global add
add:
.LU7:
	push {fp, lr}
	add fp, sp, #4
	sub sp, sp, #20
	mov r2, r0
	str r2, [sp, #0]
	movw r2, #0
	str r2, [sp, #8]
	ldr r2, [sp, #0]
	str r2, [sp, #16]
	ldr r2, [sp, #16]
	ldr r2, [r2]
	str r2, [sp, #12]
	ldr r2, [sp, #16]
	add r2, r2, #4
	ldr r2, [r2]
	str r2, [sp, #16]
	ldr r3, [sp, #8]
	mov r2, #0
	cmp r3, #5
	movlt r2, #1
	cmp r2, #1
	beq .LU8
	b .LU9
.LU8:
	ldr r3, [sp, #12]
	ldr r2, [sp, #16]
	ldr r2, [r2]
	add r2, r3, r2
	str r2, [sp, #12]
	ldr r2, [sp, #16]
	add r2, r2, #4
	ldr r2, [r2]
	str r2, [sp, #16]
	ldr r2, [sp, #12]
	mov r1, r2
	movw r0, #:lower16:.PRINTLN_FMT
	movt r0, #:upper16:.PRINTLN_FMT
	bl printf
	ldr r2, [sp, #8]
	add r2, r2, #1
	str r2, [sp, #8]
	ldr r3, [sp, #8]
	mov r2, #0
	cmp r3, #5
	movlt r2, #1
	cmp r2, #1
	beq .LU8
	b .LU9
.LU9:
	ldr r2, [sp, #12]
	str r2, [sp, #4]
	b .LU6
.LU6:
	ldr r2, [sp, #4]
	mov r0, r2
	add sp, sp, #20
	pop {fp, pc}
	.size add, .-add
	.align 2
	.global recurseList
recurseList:
.LU11:
	push {fp, lr}
	add fp, sp, #4
	push {r4}
	sub sp, sp, #8
	mov r2, r0
	str r2, [sp, #0]
	ldr r2, [sp, #0]
	add r2, r2, #4
	ldr r2, [r2]
	mov r0, #0
	cmp r2, #0
	moveq r0, #1
	cmp r0, #1
	beq .LU12
	b .LU13
.LU12:
	ldr r2, [sp, #0]
	ldr r2, [r2]
	str r2, [sp, #4]
	b .LU10
.LU13:
	ldr r2, [sp, #0]
	ldr r4, [r2]
	ldr r2, [sp, #0]
	add r2, r2, #4
	ldr r2, [r2]
	mov r0, r2
	bl recurseList
	mov r2, r0
	mul r2, r4, r2
	str r2, [sp, #4]
	b .LU10
.LU14:
	b .LU10
.LU10:
	ldr r2, [sp, #4]
	mov r0, r2
	add sp, sp, #8
	pop {r4}
	pop {fp, pc}
	.size recurseList, .-recurseList
	.align 2
	.global main
main:
.LU16:
	push {fp, lr}
	add fp, sp, #4
	push {r4}
	sub sp, sp, #28
	movw r0, #0
	str r0, [sp, #24]
	movw r0, #0
	str r0, [sp, #20]
	bl buildList
	str r0, [sp, #4]
	ldr r0, [sp, #4]
	bl multiple
	str r0, [sp, #8]
	ldr r0, [sp, #4]
	bl add
	str r0, [sp, #12]
	ldr r4, [sp, #8]
	ldr r0, [sp, #12]
	movw r1, #2
	bl __aeabi_idiv
	sub r0, r4, r0
	str r0, [sp, #16]
	ldr r3, [sp, #24]
	mov r0, #0
	cmp r3, #2
	movlt r0, #1
	cmp r0, #1
	beq .LU17
	b .LU18
.LU17:
	ldr r4, [sp, #20]
	ldr r0, [sp, #4]
	bl recurseList
	add r0, r4, r0
	str r0, [sp, #20]
	ldr r0, [sp, #24]
	add r0, r0, #1
	str r0, [sp, #24]
	ldr r3, [sp, #24]
	mov r0, #0
	cmp r3, #2
	movlt r0, #1
	cmp r0, #1
	beq .LU17
	b .LU18
.LU18:
	ldr r0, [sp, #20]
	mov r1, r0
	movw r0, #:lower16:.PRINTLN_FMT
	movt r0, #:upper16:.PRINTLN_FMT
	bl printf
	ldr r0, [sp, #20]
	mov r3, #0
	cmp r0, #0
	movne r3, #1
	cmp r3, #1
	beq .LU19
	b .LU20
.LU19:
	ldr r0, [sp, #20]
	sub r0, r0, #1
	str r0, [sp, #20]
	ldr r3, [sp, #20]
	mov r0, #0
	cmp r3, #0
	movne r0, #1
	cmp r0, #1
	beq .LU19
	b .LU20
.LU20:
	ldr r0, [sp, #16]
	mov r1, r0
	movw r0, #:lower16:.PRINTLN_FMT
	movt r0, #:upper16:.PRINTLN_FMT
	bl printf
	ldr r0, [sp, #20]
	mov r1, r0
	movw r0, #:lower16:.PRINTLN_FMT
	movt r0, #:upper16:.PRINTLN_FMT
	bl printf
	movw r0, #0
	str r0, [sp, #0]
	b .LU15
.LU15:
	ldr r0, [sp, #0]
	add sp, sp, #28
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
