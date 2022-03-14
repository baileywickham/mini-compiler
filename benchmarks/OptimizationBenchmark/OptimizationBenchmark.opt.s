	.arch armv7-a
	.comm	.read_scratch,4,4
	.comm	global1,4,4
	.comm	global2,4,4
	.comm	global3,4,4

	.text
	.align 2
	.global sum
sum:
.LU7:
	push {fp, lr}
	add fp, sp, #4
	mov r2, r0
	mov r3, #0
	cmp r2, #0
	movgt r3, #1
	movw r0, #0
	movw r1, #0
	cmp r3, #1
	beq .LU8
	b .LU9
.LU8:
	mov r0, r2
	add r1, r1, r0
	sub r2, r0, #1
	mov r3, #0
	cmp r2, #0
	movgt r3, #1
	mov r0, r1
	cmp r3, #1
	beq .LU8
	b .LU9
.LU9:
	pop {fp, pc}
	.size sum, .-sum
	.align 2
	.global interProceduralOptimization
interProceduralOptimization:
.LU13:
	push {fp, lr}
	add fp, sp, #4
	movw r1, #1
	movw r2, #:lower16:global1
	movt r2, #:upper16:global1
	str r1, [r2]
	movw r1, #0
	movw r2, #:lower16:global2
	movt r2, #:upper16:global2
	str r1, [r2]
	movw r2, #0
	movw r1, #:lower16:global3
	movt r1, #:upper16:global3
	str r2, [r1]
	movw r0, #100
	bl sum
	mov r1, r0
	movw r2, #:lower16:global1
	movt r2, #:upper16:global1
	ldr r0, [r2]
	mov r2, #0
	cmp r0, #1
	moveq r2, #1
	cmp r2, #1
	beq .LU14
	b .LU15
.LU14:
	movw r0, #10000
	bl sum
	mov r1, r0
	b .LU16
.LU15:
	movw r2, #:lower16:global2
	movt r2, #:upper16:global2
	ldr r2, [r2]
	mov r0, #0
	cmp r2, #2
	moveq r0, #1
	cmp r0, #1
	beq .LU17
	b .LU18
.LU17:
	movw r0, #20000
	bl sum
	mov r1, r0
	b .LU19
.LU18:
	b .LU19
.LU19:
	movw r2, #:lower16:global3
	movt r2, #:upper16:global3
	ldr r0, [r2]
	mov r2, #0
	cmp r0, #3
	moveq r2, #1
	cmp r2, #1
	beq .LU20
	b .LU21
.LU20:
	movw r0, #30000
	bl sum
	mov r1, r0
	b .LU22
.LU21:
	b .LU22
.LU22:
	b .LU16
.LU16:
	mov r0, r1
	pop {fp, pc}
	.size interProceduralOptimization, .-interProceduralOptimization
	.align 2
	.global tailRecursionHelper
tailRecursionHelper:
.LU42:
	push {fp, lr}
	add fp, sp, #4
	mov r2, #0
	cmp r0, #0
	moveq r2, #1
	cmp r2, #1
	beq .LU43
	b .LU44
.LU43:
	b .LU41
.LU44:
	sub r2, r0, #1
	add r1, r1, r0
	mov r0, r2
	bl tailRecursionHelper
	mov r1, r0
	b .LU41
.LU41:
	mov r0, r1
	pop {fp, pc}
	.size tailRecursionHelper, .-tailRecursionHelper
	.align 2
	.global tailRecursion
tailRecursion:
.LU47:
	push {fp, lr}
	add fp, sp, #4
	mov r2, r0
	movw r1, #0
	mov r0, r2
	bl tailRecursionHelper
	mov r1, r0
	mov r0, r1
	pop {fp, pc}
	.size tailRecursion, .-tailRecursion
	.align 2
	.global recursiveFibonacci
recursiveFibonacci:
.LU64:
	push {fp, lr}
	add fp, sp, #4
	push {r4, r5}
	mov r4, r0
	mov r0, #0
	cmp r4, #0
	movle r0, #1
	mov r5, #0
	cmp r4, #1
	moveq r5, #1
	orr r5, r0, r5
	cmp r5, #1
	beq .LU65
	b .LU66
.LU65:
	b .LU63
.LU66:
	sub r5, r4, #1
	mov r0, r5
	bl recursiveFibonacci
	mov r5, r0
	sub r4, r4, #2
	mov r0, r4
	bl recursiveFibonacci
	mov r4, r0
	add r4, r5, r4
	b .LU63
.LU63:
	mov r0, r4
	pop {r4, r5}
	pop {fp, pc}
	.size recursiveFibonacci, .-recursiveFibonacci
	.align 2
	.global main
main:
.LU69:
	push {fp, lr}
	add fp, sp, #4
	push {r4, r5, r6, r7, r8}
	movw r1, #:lower16:.read_scratch
	movt r1, #:upper16:.read_scratch
	movw r0, #:lower16:.READ_FMT
	movt r0, #:upper16:.READ_FMT
	bl scanf
	movw r4, #:lower16:.read_scratch
	movt r4, #:upper16:.read_scratch
	ldr r4, [r4]
	movw r6, #1
	mov r5, #0
	cmp r6, r4
	movlt r5, #1
	movw r6, #1
	cmp r5, #1
	beq .LU70
	b .LU71
.LU70:
	mov r5, r6
	movw r1, #226
	movw r0, #:lower16:.PRINTLN_FMT
	movt r0, #:upper16:.PRINTLN_FMT
	bl printf
	movw r1, #:lower16:-25457889
	movt r1, #:upper16:-25457889
	movw r0, #:lower16:.PRINTLN_FMT
	movt r0, #:upper16:.PRINTLN_FMT
	bl printf
	movw r7, #11
	movw r6, #:lower16:global1
	movt r6, #:upper16:global1
	str r7, [r6]
	movw r6, #5
	movw r7, #:lower16:global1
	movt r7, #:upper16:global1
	str r6, [r7]
	movw r6, #9
	movw r7, #:lower16:global1
	movt r7, #:upper16:global1
	str r6, [r7]
	movw r1, #38
	movw r0, #:lower16:.PRINTLN_FMT
	movt r0, #:upper16:.PRINTLN_FMT
	bl printf
	bl interProceduralOptimization
	mov r6, r0
	mov r1, r6
	movw r0, #:lower16:.PRINTLN_FMT
	movt r0, #:upper16:.PRINTLN_FMT
	bl printf
	movw r1, #:lower16:-48796
	movt r1, #:upper16:-48796
	movw r0, #:lower16:.PRINTLN_FMT
	movt r0, #:upper16:.PRINTLN_FMT
	bl printf
	movw r6, #2
	movw r7, #1
	movw r0, #2
	movw r8, #3
	movw r3, #4
	movw r2, #0
	movw r1, #1
	cmp r1, #1
	beq .inline4_LU27
	b .inline4_LU28
.inline4_LU27:
	mov r6, r2
	add r2, r6, #1
	movw r6, #:lower16:1000000
	movt r6, #:upper16:1000000
	mov r1, #0
	cmp r2, r6
	movlt r1, #1
	mov r6, r0
	cmp r1, #1
	beq .inline4_LU27
	b .inline4_LU28
.inline4_LU28:
	mov r1, r6
	movw r0, #:lower16:.PRINTLN_FMT
	movt r0, #:upper16:.PRINTLN_FMT
	bl printf
	movw r6, #1
	cmp r6, #1
	beq .inline5_LU31
	b .inline5_LU32
.inline5_LU31:
	movw r6, #1
	cmp r6, #1
	beq .inline5_LU34
	b .inline5_LU35
.inline5_LU34:
	b .inline5_LU36
.inline5_LU35:
	b .inline5_LU36
.inline5_LU36:
	movw r6, #50
	b .inline5_LU33
.inline5_LU32:
	movw r6, #0
	b .inline5_LU33
.inline5_LU33:
	mov r1, r6
	movw r0, #:lower16:.PRINTLN_FMT
	movt r0, #:upper16:.PRINTLN_FMT
	bl printf
	movw r1, #736
	movw r0, #:lower16:.PRINTLN_FMT
	movt r0, #:upper16:.PRINTLN_FMT
	bl printf
	movw r1, #10
	movw r0, #:lower16:.PRINTLN_FMT
	movt r0, #:upper16:.PRINTLN_FMT
	bl printf
	movw r1, #1000
	mov r0, r4
	bl __aeabi_idiv
	mov r6, r0
	mov r0, r6
	bl tailRecursion
	mov r6, r0
	mov r1, r6
	movw r0, #:lower16:.PRINTLN_FMT
	movt r0, #:upper16:.PRINTLN_FMT
	bl printf
	movw r6, #1
	movw r7, #2
	movw r2, #1
	movw r1, #1
	cmp r1, #1
	beq .inline8_LU50
	b .inline8_LU51
.inline8_LU50:
	mov r1, r2
	mov r6, r7
	mov r7, #0
	cmp r6, #2
	moveq r7, #1
	cmp r7, #1
	beq .inline8_LU52
	b .inline8_LU53
.inline8_LU52:
	add r7, r1, #1
	mov r1, r7
	b .inline8_LU54
.inline8_LU53:
	add r7, r1, #2
	mov r1, r7
	b .inline8_LU54
.inline8_LU54:
	mov r7, r6
	mov r2, r1
	movw r6, #:lower16:1000000
	movt r6, #:upper16:1000000
	mov r1, #0
	cmp r2, r6
	movlt r1, #1
	mov r6, r2
	cmp r1, #1
	beq .inline8_LU50
	b .inline8_LU51
.inline8_LU51:
	mov r1, r6
	movw r0, #:lower16:.PRINTLN_FMT
	movt r0, #:upper16:.PRINTLN_FMT
	bl printf
	movw r7, #0
	mov r6, #0
	cmp r7, r4
	movlt r6, #1
	movw r1, #0
	movw r7, #0
	movw r3, #0
	mov r0, r4
	cmp r6, #1
	beq .inline9_LU57
	b .inline9_LU58
.inline9_LU57:
	mov r6, r0
	mov r1, r3
	add r7, r7, #19
	movw r2, #2
	mul r2, r1, r2
	movw r1, #2
	mov r0, r2
	bl __aeabi_idiv
	mov r1, r0
	movw r2, #3
	mul r2, r2, r1
	movw r1, #3
	mov r0, r2
	bl __aeabi_idiv
	mov r2, r0
	movw r1, #4
	mul r2, r2, r1
	movw r1, #4
	mov r0, r2
	bl __aeabi_idiv
	mov r1, r0
	add r0, r1, #1
	mov r2, #0
	cmp r0, r6
	movlt r2, #1
	mov r1, r7
	mov r3, r0
	mov r0, r6
	cmp r2, #1
	beq .inline9_LU57
	b .inline9_LU58
.inline9_LU58:
	mov r6, r1
	mov r1, r6
	movw r0, #:lower16:.PRINTLN_FMT
	movt r0, #:upper16:.PRINTLN_FMT
	bl printf
	movw r1, #5
	mov r0, r4
	bl __aeabi_idiv
	movw r6, #0
	mov r1, #0
	cmp r6, r0
	movlt r1, #1
	movw r7, #1
	movw r6, #1
	movw r2, #:lower16:-1
	movt r2, #:upper16:-1
	movw r3, #0
	mov r8, r0
	cmp r1, #1
	beq .inline10_LU61
	b .inline10_LU62
.inline10_LU61:
	mov r1, r8
	mov r0, r3
	mov r7, r2
	mov r2, r6
	add r6, r2, r7
	add r3, r0, #1
	mov r0, #0
	cmp r3, r1
	movlt r0, #1
	mov r7, r6
	mov r8, r1
	cmp r0, #1
	beq .inline10_LU61
	b .inline10_LU62
.inline10_LU62:
	mov r6, r7
	mov r1, r6
	movw r0, #:lower16:.PRINTLN_FMT
	movt r0, #:upper16:.PRINTLN_FMT
	bl printf
	movw r1, #1000
	mov r0, r4
	bl __aeabi_idiv
	mov r6, r0
	mov r0, r6
	bl recursiveFibonacci
	mov r6, r0
	mov r1, r6
	movw r0, #:lower16:.PRINTLN_FMT
	movt r0, #:upper16:.PRINTLN_FMT
	bl printf
	add r6, r5, #1
	mov r5, #0
	cmp r6, r4
	movlt r5, #1
	cmp r5, #1
	beq .LU70
	b .LU71
.LU71:
	movw r1, #9999
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
