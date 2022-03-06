	.arch armv7-a
	.comm	.read_scratch,4,4
	.comm	global1,4,4
	.comm	global2,4,4
	.comm	global3,4,4

	.text
	.align 2
	.global constantFolding
constantFolding:
.LU1:
	push {fp, lr}
	add fp, sp, #4
	b .LU0
.LU0:
	movw r0, #226
	pop {fp, pc}
	.size constantFolding, .-constantFolding
	.align 2
	.global constantPropagation
constantPropagation:
.LU3:
	push {fp, lr}
	add fp, sp, #4
	b .LU2
.LU2:
	movw r0, #:lower16:-25457889
	movt r0, #:upper16:-25457889
	pop {fp, pc}
	.size constantPropagation, .-constantPropagation
	.align 2
	.global deadCodeElimination
deadCodeElimination:
.LU5:
	push {fp, lr}
	add fp, sp, #4
	movw r3, #11
	movw r0, #:lower16:global1
	movt r0, #:upper16:global1
	str r3, [r0]
	movw r3, #5
	movw r0, #:lower16:global1
	movt r0, #:upper16:global1
	str r3, [r0]
	movw r3, #9
	movw r0, #:lower16:global1
	movt r0, #:upper16:global1
	str r3, [r0]
	b .LU4
.LU4:
	movw r0, #38
	pop {fp, pc}
	.size deadCodeElimination, .-deadCodeElimination
	.align 2
	.global sum
sum:
.LU7:
	push {fp, lr}
	add fp, sp, #4
	mov r2, r0
	mov r1, #0
	cmp r2, #0
	movgt r1, #1
	movw r3, #0
	movw r0, #0
	cmp r1, #1
	beq .LU8
	b .LU9
.LU8:
	mov r3, r0
	add r0, r3, r2
	sub r2, r2, #1
	mov r1, #0
	cmp r2, #0
	movgt r1, #1
	mov r3, r0
	cmp r1, #1
	beq .LU8
	b .LU9
.LU9:
	mov r2, r3
	b .LU6
.LU6:
	mov r0, r2
	pop {fp, pc}
	.size sum, .-sum
	.align 2
	.global doesntModifyGlobals
doesntModifyGlobals:
.LU11:
	push {fp, lr}
	add fp, sp, #4
	b .LU10
.LU10:
	movw r0, #3
	pop {fp, pc}
	.size doesntModifyGlobals, .-doesntModifyGlobals
	.align 2
	.global interProceduralOptimization
interProceduralOptimization:
.LU13:
	push {fp, lr}
	add fp, sp, #4
	movw r2, #1
	movw r3, #:lower16:global1
	movt r3, #:upper16:global1
	str r2, [r3]
	movw r3, #0
	movw r2, #:lower16:global2
	movt r2, #:upper16:global2
	str r3, [r2]
	movw r3, #0
	movw r2, #:lower16:global3
	movt r2, #:upper16:global3
	str r3, [r2]
	movw r0, #100
	bl sum
	mov r3, r0
	movw r2, #:lower16:global1
	movt r2, #:upper16:global1
	ldr r2, [r2]
	mov r1, #0
	cmp r2, #1
	moveq r1, #1
	cmp r1, #1
	beq .LU14
	b .LU15
.LU14:
	movw r0, #10000
	bl sum
	mov r2, r0
	b .LU16
.LU15:
	movw r2, #:lower16:global2
	movt r2, #:upper16:global2
	ldr r2, [r2]
	mov r1, #0
	cmp r2, #2
	moveq r1, #1
	cmp r1, #1
	beq .LU17
	b .LU18
.LU17:
	movw r0, #20000
	bl sum
	mov r2, r0
	b .LU19
.LU18:
	mov r2, r3
	b .LU19
.LU19:
	mov r3, r2
	movw r2, #:lower16:global3
	movt r2, #:upper16:global3
	ldr r1, [r2]
	mov r2, #0
	cmp r1, #3
	moveq r2, #1
	cmp r2, #1
	beq .LU20
	b .LU21
.LU20:
	movw r0, #30000
	bl sum
	mov r2, r0
	b .LU22
.LU21:
	mov r2, r3
	b .LU22
.LU22:
	b .LU16
.LU16:
	b .LU12
.LU12:
	mov r0, r2
	pop {fp, pc}
	.size interProceduralOptimization, .-interProceduralOptimization
	.align 2
	.global commonSubexpressionElimination
commonSubexpressionElimination:
.LU24:
	push {fp, lr}
	add fp, sp, #4
	b .LU23
.LU23:
	movw r0, #:lower16:-48796
	movt r0, #:upper16:-48796
	pop {fp, pc}
	.size commonSubexpressionElimination, .-commonSubexpressionElimination
	.align 2
	.global hoisting
hoisting:
.LU26:
	push {fp, lr}
	add fp, sp, #4
	push {r4, r5, r6}
	movw r3, #2
	movw r4, #1
	movw r1, #2
	movw r2, #3
	movw r0, #4
	movw r5, #0
	movw r6, #1
	cmp r6, #1
	beq .LU27
	b .LU28
.LU27:
	mov r3, r5
	add r5, r3, #1
	movw r3, #:lower16:1000000
	movt r3, #:upper16:1000000
	mov r6, #0
	cmp r5, r3
	movlt r6, #1
	mov r3, r1
	cmp r6, #1
	beq .LU27
	b .LU28
.LU28:
	mov r2, r3
	b .LU25
.LU25:
	mov r0, r2
	pop {r4, r5, r6}
	pop {fp, pc}
	.size hoisting, .-hoisting
	.align 2
	.global doubleIf
doubleIf:
.LU30:
	push {fp, lr}
	add fp, sp, #4
	movw r2, #1
	cmp r2, #1
	beq .LU31
	b .LU32
.LU31:
	movw r2, #1
	cmp r2, #1
	beq .LU34
	b .LU35
.LU34:
	b .LU36
.LU35:
	b .LU36
.LU36:
	movw r2, #50
	b .LU33
.LU32:
	movw r2, #0
	b .LU33
.LU33:
	b .LU29
.LU29:
	mov r0, r2
	pop {fp, pc}
	.size doubleIf, .-doubleIf
	.align 2
	.global integerDivide
integerDivide:
.LU38:
	push {fp, lr}
	add fp, sp, #4
	b .LU37
.LU37:
	movw r0, #736
	pop {fp, pc}
	.size integerDivide, .-integerDivide
	.align 2
	.global association
association:
.LU40:
	push {fp, lr}
	add fp, sp, #4
	b .LU39
.LU39:
	movw r0, #10
	pop {fp, pc}
	.size association, .-association
	.align 2
	.global tailRecursionHelper
tailRecursionHelper:
.LU42:
	push {fp, lr}
	add fp, sp, #4
	mov r2, r1
	mov r3, #0
	cmp r0, #0
	moveq r3, #1
	cmp r3, #1
	beq .LU43
	b .LU44
.LU43:
	mov r3, r2
	b .LU41
.LU44:
	sub r3, r0, #1
	add r0, r2, r0
	mov r1, r0
	mov r0, r3
	bl tailRecursionHelper
	mov r3, r0
	b .LU41
.LU41:
	mov r0, r3
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
	mov r2, r0
	b .LU46
.LU46:
	mov r0, r2
	pop {fp, pc}
	.size tailRecursion, .-tailRecursion
	.align 2
	.global unswitching
unswitching:
.LU49:
	push {fp, lr}
	add fp, sp, #4
	movw r2, #1
	movw r3, #2
	movw r1, #1
	movw r0, #1
	cmp r0, #1
	beq .LU50
	b .LU51
.LU50:
	mov r0, r1
	mov r2, #0
	cmp r3, #2
	moveq r2, #1
	cmp r2, #1
	beq .LU52
	b .LU53
.LU52:
	add r0, r0, #1
	b .LU54
.LU53:
	add r0, r0, #2
	b .LU54
.LU54:
	mov r1, r0
	movw r2, #:lower16:1000000
	movt r2, #:upper16:1000000
	mov r0, #0
	cmp r1, r2
	movlt r0, #1
	mov r2, r1
	cmp r0, #1
	beq .LU50
	b .LU51
.LU51:
	mov r3, r2
	b .LU48
.LU48:
	mov r0, r3
	pop {fp, pc}
	.size unswitching, .-unswitching
	.align 2
	.global randomCalculation
randomCalculation:
.LU56:
	push {fp, lr}
	add fp, sp, #4
	push {r4, r5}
	mov r4, r0
	movw r0, #0
	mov r2, #0
	cmp r0, r4
	movlt r2, #1
	movw r1, #0
	movw r3, #0
	movw r0, #0
	cmp r2, #1
	beq .LU57
	b .LU58
.LU57:
	mov r2, r0
	mov r0, r3
	add r5, r0, #19
	movw r0, #2
	mul r2, r2, r0
	movw r1, #2
	mov r0, r2
	bl __aeabi_idiv
	mov r2, r0
	movw r0, #3
	mul r2, r0, r2
	movw r1, #3
	mov r0, r2
	bl __aeabi_idiv
	mov r2, r0
	movw r0, #4
	mul r2, r2, r0
	movw r1, #4
	mov r0, r2
	bl __aeabi_idiv
	mov r2, r0
	add r0, r2, #1
	mov r2, #0
	cmp r0, r4
	movlt r2, #1
	mov r1, r5
	mov r3, r5
	cmp r2, #1
	beq .LU57
	b .LU58
.LU58:
	mov r2, r1
	b .LU55
.LU55:
	mov r0, r2
	pop {r4, r5}
	pop {fp, pc}
	.size randomCalculation, .-randomCalculation
	.align 2
	.global iterativeFibonacci
iterativeFibonacci:
.LU60:
	push {fp, lr}
	add fp, sp, #4
	push {r4, r5}
	mov r3, r0
	movw r2, #0
	mov r0, #0
	cmp r2, r3
	movlt r0, #1
	movw r5, #1
	movw r2, #1
	movw r1, #:lower16:-1
	movt r1, #:upper16:-1
	movw r4, #0
	cmp r0, #1
	beq .LU61
	b .LU62
.LU61:
	mov r0, r4
	mov r4, r1
	mov r1, r2
	add r2, r1, r4
	add r4, r0, #1
	mov r0, #0
	cmp r4, r3
	movlt r0, #1
	mov r5, r2
	cmp r0, #1
	beq .LU61
	b .LU62
.LU62:
	mov r2, r5
	b .LU59
.LU59:
	mov r0, r2
	pop {r4, r5}
	pop {fp, pc}
	.size iterativeFibonacci, .-iterativeFibonacci
	.align 2
	.global recursiveFibonacci
recursiveFibonacci:
.LU64:
	push {fp, lr}
	add fp, sp, #4
	push {r4, r5}
	mov r5, r0
	mov r3, #0
	cmp r5, #0
	movle r3, #1
	mov r2, #0
	cmp r5, #1
	moveq r2, #1
	orr r2, r3, r2
	cmp r2, #1
	beq .LU65
	b .LU66
.LU65:
	mov r2, r5
	b .LU63
.LU66:
	sub r2, r5, #1
	mov r0, r2
	bl recursiveFibonacci
	mov r4, r0
	sub r2, r5, #2
	mov r0, r2
	bl recursiveFibonacci
	mov r2, r0
	add r2, r4, r2
	b .LU63
.LU63:
	mov r0, r2
	pop {r4, r5}
	pop {fp, pc}
	.size recursiveFibonacci, .-recursiveFibonacci
	.align 2
	.global main
main:
.LU69:
	push {fp, lr}
	add fp, sp, #4
	push {r4, r5}
	movw r1, #:lower16:.read_scratch
	movt r1, #:upper16:.read_scratch
	movw r0, #:lower16:.READ_FMT
	movt r0, #:upper16:.READ_FMT
	bl scanf
	movw r2, #:lower16:.read_scratch
	movt r2, #:upper16:.read_scratch
	ldr r1, [r2]
	movw r3, #1
	mov r2, #0
	cmp r3, r1
	movlt r2, #1
	movw r3, #1
	cmp r2, #1
	beq .LU70
	b .LU71
.LU70:
	mov r5, r3
	mov r4, r1
	bl constantFolding
	mov r2, r0
	mov r1, r2
	movw r0, #:lower16:.PRINTLN_FMT
	movt r0, #:upper16:.PRINTLN_FMT
	bl printf
	bl constantPropagation
	mov r2, r0
	mov r1, r2
	movw r0, #:lower16:.PRINTLN_FMT
	movt r0, #:upper16:.PRINTLN_FMT
	bl printf
	bl deadCodeElimination
	mov r2, r0
	mov r1, r2
	movw r0, #:lower16:.PRINTLN_FMT
	movt r0, #:upper16:.PRINTLN_FMT
	bl printf
	bl interProceduralOptimization
	mov r2, r0
	mov r1, r2
	movw r0, #:lower16:.PRINTLN_FMT
	movt r0, #:upper16:.PRINTLN_FMT
	bl printf
	bl commonSubexpressionElimination
	mov r2, r0
	mov r1, r2
	movw r0, #:lower16:.PRINTLN_FMT
	movt r0, #:upper16:.PRINTLN_FMT
	bl printf
	bl hoisting
	mov r2, r0
	mov r1, r2
	movw r0, #:lower16:.PRINTLN_FMT
	movt r0, #:upper16:.PRINTLN_FMT
	bl printf
	bl doubleIf
	mov r2, r0
	mov r1, r2
	movw r0, #:lower16:.PRINTLN_FMT
	movt r0, #:upper16:.PRINTLN_FMT
	bl printf
	bl integerDivide
	mov r2, r0
	mov r1, r2
	movw r0, #:lower16:.PRINTLN_FMT
	movt r0, #:upper16:.PRINTLN_FMT
	bl printf
	bl association
	mov r2, r0
	mov r1, r2
	movw r0, #:lower16:.PRINTLN_FMT
	movt r0, #:upper16:.PRINTLN_FMT
	bl printf
	movw r1, #1000
	mov r0, r4
	bl __aeabi_idiv
	mov r2, r0
	mov r0, r2
	bl tailRecursion
	mov r2, r0
	mov r1, r2
	movw r0, #:lower16:.PRINTLN_FMT
	movt r0, #:upper16:.PRINTLN_FMT
	bl printf
	bl unswitching
	mov r2, r0
	mov r1, r2
	movw r0, #:lower16:.PRINTLN_FMT
	movt r0, #:upper16:.PRINTLN_FMT
	bl printf
	mov r0, r4
	bl randomCalculation
	mov r2, r0
	mov r1, r2
	movw r0, #:lower16:.PRINTLN_FMT
	movt r0, #:upper16:.PRINTLN_FMT
	bl printf
	movw r1, #5
	mov r0, r4
	bl __aeabi_idiv
	mov r2, r0
	mov r0, r2
	bl iterativeFibonacci
	mov r2, r0
	mov r1, r2
	movw r0, #:lower16:.PRINTLN_FMT
	movt r0, #:upper16:.PRINTLN_FMT
	bl printf
	movw r1, #1000
	mov r0, r4
	bl __aeabi_idiv
	mov r2, r0
	mov r0, r2
	bl recursiveFibonacci
	mov r2, r0
	mov r1, r2
	movw r0, #:lower16:.PRINTLN_FMT
	movt r0, #:upper16:.PRINTLN_FMT
	bl printf
	add r3, r5, #1
	mov r2, #0
	cmp r3, r4
	movlt r2, #1
	mov r1, r4
	cmp r2, #1
	beq .LU70
	b .LU71
.LU71:
	movw r1, #9999
	movw r0, #:lower16:.PRINTLN_FMT
	movt r0, #:upper16:.PRINTLN_FMT
	bl printf
	b .LU68
.LU68:
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
