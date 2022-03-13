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
	mov r0, r1
	mov r3, #0
	cmp r0, #0
	movle r3, #1
	cmp r3, #1
	beq .LU2
	b .LU3
.LU2:
	mov r3, r4
	ldr r3, [r3]
	b .LU0
.LU3:
	b .LU4
.LU4:
	mov r3, r4
	ldr r1, [r3]
	movw r3, #4
	mul r3, r3, r1
	mov r1, r4
	str r3, [r1]
	sub r3, r0, #1
	mov r1, r3
	mov r0, r4
	bl multBy4xTimes
	mov r3, r4
	ldr r3, [r3]
	b .LU0
.LU0:
	mov r0, r3
	pop {r4}
	pop {fp, pc}
	.size multBy4xTimes, .-multBy4xTimes
	.align 2
	.global main
main:
.LU8:
	push {fp, lr}
	add fp, sp, #4
	push {r4, r5, r6, r7}
	movw r0, #4
	bl malloc
	mov r4, r0
	mov r5, r4
	movw r4, #:lower16:1000000
	movt r4, #:upper16:1000000
	movw r2, #:lower16:end
	movt r2, #:upper16:end
	str r4, [r2]
	movw r1, #:lower16:.read_scratch
	movt r1, #:upper16:.read_scratch
	movw r0, #:lower16:.READ_FMT
	movt r0, #:upper16:.READ_FMT
	bl scanf
	movw r4, #:lower16:.read_scratch
	movt r4, #:upper16:.read_scratch
	ldr r4, [r4]
	movw r1, #:lower16:.read_scratch
	movt r1, #:upper16:.read_scratch
	movw r0, #:lower16:.READ_FMT
	movt r0, #:upper16:.READ_FMT
	bl scanf
	movw r2, #:lower16:.read_scratch
	movt r2, #:upper16:.read_scratch
	ldr r3, [r2]
	movw r2, #:lower16:interval
	movt r2, #:upper16:interval
	str r3, [r2]
	mov r1, r4
	movw r0, #:lower16:.PRINTLN_FMT
	movt r0, #:upper16:.PRINTLN_FMT
	bl printf
	movw r4, #:lower16:interval
	movt r4, #:upper16:interval
	ldr r4, [r4]
	mov r1, r4
	movw r0, #:lower16:.PRINTLN_FMT
	movt r0, #:upper16:.PRINTLN_FMT
	bl printf
	movw r1, #0
	movw r3, #0
	movw r2, #0
	movw r4, #0
	movw r0, #1
	cmp r0, #1
	beq .LU9
	b .LU10
.LU9:
	mov r3, r2
	movw r2, #:lower16:end
	movt r2, #:upper16:end
	ldr r0, [r2]
	movw r2, #0
	mov r7, #0
	cmp r2, r0
	movle r7, #1
	mov r1, r3
	movw r2, #0
	mov r6, r5
	movw r0, #0
	cmp r7, #1
	beq .LU11
	b .LU12
.LU11:
	mov r4, r3
	mov r2, r0
	add r6, r2, #1
	mov r2, r5
	str r6, [r2]
	movw r1, #2
	mov r0, r5
	bl multBy4xTimes
	b .inline0_LU6
.inline0_LU6:
	mov r2, r5
	ldr r2, [r2]
	movw r1, #2
	mov r0, r2
	bl __aeabi_idiv
	mov r2, r0
	mov r3, r5
	str r2, [r3]
	mov r2, r5
	ldr r2, [r2]
	movw r1, #2
	mov r0, r2
	bl __aeabi_idiv
	mov r2, r0
	mov r3, r5
	str r2, [r3]
	mov r2, r5
	ldr r2, [r2]
	movw r1, #2
	mov r0, r2
	bl __aeabi_idiv
	mov r2, r0
	mov r3, r5
	str r2, [r3]
	b .inline0_LU5
.inline0_LU5:
	b .next0
.next0:
	movw r2, #:lower16:interval
	movt r2, #:upper16:interval
	ldr r2, [r2]
	sub r2, r2, #1
	mov r3, #0
	cmp r2, #0
	movle r3, #1
	cmp r3, #1
	beq .LU13
	b .LU14
.LU13:
	mov r0, r6
	movw r2, #1
	mov r3, r4
	movw r4, #:lower16:39916800
	movt r4, #:upper16:39916800
	b .LU15
.LU14:
	mov r0, r6
	mov r3, r4
	movw r4, #:lower16:39916800
	movt r4, #:upper16:39916800
	b .LU15
.LU15:
	add r0, r0, r2
	movw r2, #:lower16:end
	movt r2, #:upper16:end
	ldr r2, [r2]
	mov r7, #0
	cmp r0, r2
	movle r7, #1
	mov r1, r3
	mov r2, r0
	mov r6, r5
	cmp r7, #1
	beq .LU11
	b .LU12
.LU12:
	mov r5, r6
	mov r3, r2
	mov r2, r1
	add r2, r2, #1
	mov r0, #0
	cmp r2, #50
	movlt r0, #1
	mov r1, r3
	mov r3, r4
	cmp r0, #1
	beq .LU9
	b .LU10
.LU10:
	mov r4, r3
	mov r5, r1
	mov r1, r5
	movw r0, #:lower16:.PRINTLN_FMT
	movt r0, #:upper16:.PRINTLN_FMT
	bl printf
	mov r1, r4
	movw r0, #:lower16:.PRINTLN_FMT
	movt r0, #:upper16:.PRINTLN_FMT
	bl printf
	b .LU7
.LU7:
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
