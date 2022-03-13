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
	mov r1, r0
	str r1, [sp, #4]
	movw r0, #8
	bl malloc
	mov r1, r0
	str r1, [sp, #8]
	movw r0, #8
	bl malloc
	mov r1, r0
	str r1, [sp, #12]
	movw r0, #8
	bl malloc
	mov r1, r0
	str r1, [sp, #16]
	movw r0, #8
	bl malloc
	mov r1, r0
	str r1, [sp, #20]
	movw r0, #8
	bl malloc
	mov r1, r0
	str r1, [sp, #24]
	ldr r1, [sp, #4]
	movw r0, #:lower16:.READ_FMT
	movt r0, #:upper16:.READ_FMT
	bl scanf
	ldr r1, [sp, #8]
	movw r0, #:lower16:.READ_FMT
	movt r0, #:upper16:.READ_FMT
	bl scanf
	ldr r1, [sp, #12]
	movw r0, #:lower16:.READ_FMT
	movt r0, #:upper16:.READ_FMT
	bl scanf
	ldr r1, [sp, #16]
	movw r0, #:lower16:.READ_FMT
	movt r0, #:upper16:.READ_FMT
	bl scanf
	ldr r1, [sp, #20]
	movw r0, #:lower16:.READ_FMT
	movt r0, #:upper16:.READ_FMT
	bl scanf
	ldr r1, [sp, #24]
	movw r0, #:lower16:.READ_FMT
	movt r0, #:upper16:.READ_FMT
	bl scanf
	ldr r1, [sp, #8]
	ldr r2, [sp, #4]
	add r2, r2, #4
	str r1, [r2]
	ldr r1, [sp, #12]
	ldr r2, [sp, #8]
	add r2, r2, #4
	str r1, [r2]
	ldr r1, [sp, #16]
	ldr r2, [sp, #12]
	add r2, r2, #4
	str r1, [r2]
	ldr r1, [sp, #20]
	ldr r2, [sp, #16]
	add r2, r2, #4
	str r1, [r2]
	ldr r1, [sp, #24]
	ldr r2, [sp, #20]
	add r2, r2, #4
	str r1, [r2]
	ldr r1, [sp, #24]
	add r2, r1, #4
	movw r1, #0
	str r1, [r2]
	ldr r1, [sp, #4]
	str r1, [sp, #0]
	b .LU0
.LU0:
	ldr r1, [sp, #0]
	mov r0, r1
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
	mov r1, r0
	str r1, [sp, #0]
	movw r1, #0
	str r1, [sp, #8]
	ldr r1, [sp, #0]
	str r1, [sp, #16]
	ldr r1, [sp, #16]
	ldr r1, [r1]
	str r1, [sp, #12]
	ldr r1, [sp, #16]
	add r1, r1, #4
	ldr r1, [r1]
	str r1, [sp, #16]
	ldr r2, [sp, #8]
	mov r1, #0
	cmp r2, #5
	movlt r1, #1
	cmp r1, #1
	beq .LU4
	b .LU5
.LU4:
	ldr r1, [sp, #12]
	ldr r2, [sp, #16]
	ldr r2, [r2]
	mul r1, r1, r2
	str r1, [sp, #12]
	ldr r1, [sp, #16]
	add r1, r1, #4
	ldr r1, [r1]
	str r1, [sp, #16]
	ldr r1, [sp, #12]
	movw r0, #:lower16:.PRINTLN_FMT
	movt r0, #:upper16:.PRINTLN_FMT
	bl printf
	ldr r1, [sp, #8]
	add r1, r1, #1
	str r1, [sp, #8]
	ldr r2, [sp, #8]
	mov r1, #0
	cmp r2, #5
	movlt r1, #1
	cmp r1, #1
	beq .LU4
	b .LU5
.LU5:
	ldr r1, [sp, #12]
	str r1, [sp, #4]
	b .LU2
.LU2:
	ldr r1, [sp, #4]
	mov r0, r1
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
	mov r1, r0
	str r1, [sp, #0]
	movw r1, #0
	str r1, [sp, #8]
	ldr r1, [sp, #0]
	str r1, [sp, #16]
	ldr r1, [sp, #16]
	ldr r1, [r1]
	str r1, [sp, #12]
	ldr r1, [sp, #16]
	add r1, r1, #4
	ldr r1, [r1]
	str r1, [sp, #16]
	ldr r1, [sp, #8]
	mov r2, #0
	cmp r1, #5
	movlt r2, #1
	cmp r2, #1
	beq .LU8
	b .LU9
.LU8:
	ldr r1, [sp, #12]
	ldr r2, [sp, #16]
	ldr r2, [r2]
	add r1, r1, r2
	str r1, [sp, #12]
	ldr r1, [sp, #16]
	add r1, r1, #4
	ldr r1, [r1]
	str r1, [sp, #16]
	ldr r1, [sp, #12]
	movw r0, #:lower16:.PRINTLN_FMT
	movt r0, #:upper16:.PRINTLN_FMT
	bl printf
	ldr r1, [sp, #8]
	add r1, r1, #1
	str r1, [sp, #8]
	ldr r1, [sp, #8]
	mov r2, #0
	cmp r1, #5
	movlt r2, #1
	cmp r2, #1
	beq .LU8
	b .LU9
.LU9:
	ldr r1, [sp, #12]
	str r1, [sp, #4]
	b .LU6
.LU6:
	ldr r1, [sp, #4]
	mov r0, r1
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
	mov r4, r0
	str r4, [sp, #0]
	ldr r4, [sp, #0]
	add r4, r4, #4
	ldr r1, [r4]
	mov r4, #0
	cmp r1, #0
	moveq r4, #1
	cmp r4, #1
	beq .LU12
	b .LU13
.LU12:
	ldr r4, [sp, #0]
	ldr r4, [r4]
	str r4, [sp, #4]
	b .LU10
.LU13:
	ldr r4, [sp, #0]
	ldr r4, [r4]
	ldr r1, [sp, #0]
	add r1, r1, #4
	ldr r1, [r1]
	mov r0, r1
	bl recurseList
	mov r1, r0
	mul r4, r4, r1
	str r4, [sp, #4]
	b .LU10
.LU14:
	b .LU10
.LU10:
	ldr r4, [sp, #4]
	mov r0, r4
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
	movw r1, #0
	str r1, [sp, #24]
	movw r1, #0
	str r1, [sp, #20]
	bl buildList
	mov r1, r0
	str r1, [sp, #4]
	ldr r1, [sp, #4]
	mov r0, r1
	bl multiple
	mov r1, r0
	str r1, [sp, #8]
	ldr r1, [sp, #4]
	mov r0, r1
	bl add
	mov r1, r0
	str r1, [sp, #12]
	ldr r4, [sp, #8]
	ldr r2, [sp, #12]
	movw r1, #2
	mov r0, r2
	bl __aeabi_idiv
	mov r1, r0
	sub r1, r4, r1
	str r1, [sp, #16]
	ldr r4, [sp, #24]
	mov r1, #0
	cmp r4, #2
	movlt r1, #1
	cmp r1, #1
	beq .LU17
	b .LU18
.LU17:
	ldr r4, [sp, #20]
	ldr r1, [sp, #4]
	mov r0, r1
	bl recurseList
	mov r1, r0
	add r1, r4, r1
	str r1, [sp, #20]
	ldr r1, [sp, #24]
	add r1, r1, #1
	str r1, [sp, #24]
	ldr r1, [sp, #24]
	mov r4, #0
	cmp r1, #2
	movlt r4, #1
	cmp r4, #1
	beq .LU17
	b .LU18
.LU18:
	ldr r1, [sp, #20]
	movw r0, #:lower16:.PRINTLN_FMT
	movt r0, #:upper16:.PRINTLN_FMT
	bl printf
	ldr r1, [sp, #20]
	mov r4, #0
	cmp r1, #0
	movne r4, #1
	cmp r4, #1
	beq .LU19
	b .LU20
.LU19:
	ldr r1, [sp, #20]
	sub r1, r1, #1
	str r1, [sp, #20]
	ldr r4, [sp, #20]
	mov r1, #0
	cmp r4, #0
	movne r1, #1
	cmp r1, #1
	beq .LU19
	b .LU20
.LU20:
	ldr r1, [sp, #16]
	movw r0, #:lower16:.PRINTLN_FMT
	movt r0, #:upper16:.PRINTLN_FMT
	bl printf
	ldr r1, [sp, #20]
	movw r0, #:lower16:.PRINTLN_FMT
	movt r0, #:upper16:.PRINTLN_FMT
	bl printf
	movw r1, #0
	str r1, [sp, #0]
	b .LU15
.LU15:
	ldr r1, [sp, #0]
	mov r0, r1
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
