	.arch armv7-a
	.comm	.read_scratch,4,4
	.comm	interval,4,4
	.comm	end,4,4

	.text
	.align 2
	.global multBy4xTimes
multBy4xTimes:
.LU1:
	push {fp, lr}
	add fp, sp, #4
	push {r4}
	mov r4, r0
	mov r2, #0
	cmp r1, #0
	movle r2, #1
	cmp r2, #1
	beq .LU2
	b .LU3
.LU2:
	ldr r4, [r4]
	b .LU0
.LU3:
	mov r2, r4
	ldr r0, [r2]
	movw r2, #4
	mul r0, r2, r0
	mov r2, r4
	str r0, [r2]
	sub r1, r1, #1
	mov r0, r4
	bl multBy4xTimes
	ldr r4, [r4]
	b .LU0
.LU0:
	mov r0, r4
	pop {r4}
	pop {fp, pc}
	.size multBy4xTimes, .-multBy4xTimes
	.align 2
	.global main
main:
.LU8:
	push {fp, lr}
	add fp, sp, #4
	push {r4, r5, r6, r7, r8}
	movw r0, #4
	bl malloc
	mov r4, r0
	movw r5, #:lower16:1000000
	movt r5, #:upper16:1000000
	movw r6, #:lower16:end
	movt r6, #:upper16:end
	str r5, [r6]
	movw r1, #:lower16:.read_scratch
	movt r1, #:upper16:.read_scratch
	movw r0, #:lower16:.READ_FMT
	movt r0, #:upper16:.READ_FMT
	bl scanf
	movw r5, #:lower16:.read_scratch
	movt r5, #:upper16:.read_scratch
	ldr r5, [r5]
	movw r1, #:lower16:.read_scratch
	movt r1, #:upper16:.read_scratch
	movw r0, #:lower16:.READ_FMT
	movt r0, #:upper16:.READ_FMT
	bl scanf
	movw r6, #:lower16:.read_scratch
	movt r6, #:upper16:.read_scratch
	ldr r6, [r6]
	movw r1, #:lower16:interval
	movt r1, #:upper16:interval
	str r6, [r1]
	mov r1, r5
	movw r0, #:lower16:.PRINTLN_FMT
	movt r0, #:upper16:.PRINTLN_FMT
	bl printf
	movw r5, #:lower16:interval
	movt r5, #:upper16:interval
	ldr r5, [r5]
	mov r1, r5
	movw r0, #:lower16:.PRINTLN_FMT
	movt r0, #:upper16:.PRINTLN_FMT
	bl printf
	movw r5, #0
	movw r2, #0
	movw r1, #0
	movw r0, #0
	mov r6, r4
	movw r4, #1
	cmp r4, #1
	beq .LU9
	b .LU10
.LU9:
	movw r4, #:lower16:end
	movt r4, #:upper16:end
	ldr r4, [r4]
	movw r5, #0
	mov r2, #0
	cmp r5, r4
	movle r2, #1
	mov r4, r1
	movw r5, #0
	mov r3, r0
	mov r7, r6
	movw r8, #0
	cmp r2, #1
	beq .LU11
	b .LU12
.LU11:
	mov r5, r1
	mov r4, r6
	mov r6, r8
	add r6, r6, #1
	mov r1, r4
	str r6, [r1]
	movw r1, #2
	mov r0, r4
	bl multBy4xTimes
	mov r1, r4
	ldr r2, [r1]
	movw r1, #2
	mov r0, r2
	bl __aeabi_idiv
	mov r2, r0
	mov r1, r4
	str r2, [r1]
	mov r1, r4
	ldr r2, [r1]
	movw r1, #2
	mov r0, r2
	bl __aeabi_idiv
	mov r1, r0
	mov r2, r4
	str r1, [r2]
	mov r1, r4
	ldr r2, [r1]
	movw r1, #2
	mov r0, r2
	bl __aeabi_idiv
	mov r1, r0
	mov r2, r4
	str r1, [r2]
	movw r1, #:lower16:interval
	movt r1, #:upper16:interval
	ldr r1, [r1]
	sub r2, r1, #1
	mov r1, #0
	cmp r2, #0
	movle r1, #1
	cmp r1, #1
	beq .LU13
	b .LU14
.LU13:
	mov r0, r6
	movw r3, #1
	movw r1, #:lower16:39916800
	movt r1, #:upper16:39916800
	b .LU15
.LU14:
	mov r0, r6
	mov r3, r2
	movw r1, #:lower16:39916800
	movt r1, #:upper16:39916800
	b .LU15
.LU15:
	mov r6, r4
	mov r2, r1
	mov r1, r5
	mov r5, r3
	mov r4, r0
	add r8, r4, r5
	movw r4, #:lower16:end
	movt r4, #:upper16:end
	ldr r4, [r4]
	mov r0, #0
	cmp r8, r4
	movle r0, #1
	mov r4, r1
	mov r5, r8
	mov r3, r2
	mov r7, r6
	cmp r0, #1
	beq .LU11
	b .LU12
.LU12:
	mov r6, r7
	mov r0, r3
	add r1, r4, #1
	mov r4, #0
	cmp r1, #50
	movlt r4, #1
	mov r2, r0
	cmp r4, #1
	beq .LU9
	b .LU10
.LU10:
	mov r4, r2
	mov r1, r5
	movw r0, #:lower16:.PRINTLN_FMT
	movt r0, #:upper16:.PRINTLN_FMT
	bl printf
	mov r1, r4
	movw r0, #:lower16:.PRINTLN_FMT
	movt r0, #:upper16:.PRINTLN_FMT
	bl printf
	movw r0, #0
	pop {r4, r5, r6, r7, r8}
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
