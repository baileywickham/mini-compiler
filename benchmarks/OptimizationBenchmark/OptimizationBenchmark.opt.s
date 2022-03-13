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
	.global interProceduralOptimization
interProceduralOptimization:
.LU13:
	push {fp, lr}
	add fp, sp, #4
	movw r2, #1
	movw r3, #:lower16:global1
	movt r3, #:upper16:global1
	str r2, [r3]
	movw r2, #0
	movw r3, #:lower16:global2
	movt r3, #:upper16:global2
	str r2, [r3]
	movw r3, #0
	movw r2, #:lower16:global3
	movt r2, #:upper16:global3
	str r3, [r2]
	movw r0, #100
	bl sum
	movw r2, #:lower16:global1
	movt r2, #:upper16:global1
	ldr r2, [r2]
	mov r3, #0
	cmp r2, #1
	moveq r3, #1
	cmp r3, #1
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
	ldr r3, [r2]
	mov r2, #0
	cmp r3, #2
	moveq r2, #1
	cmp r2, #1
	beq .LU17
	b .LU18
.LU17:
	movw r0, #20000
	bl sum
	mov r2, r0
	b .LU19
.LU18:
	mov r2, r0
	b .LU19
.LU19:
	mov r0, r2
	movw r2, #:lower16:global3
	movt r2, #:upper16:global3
	ldr r3, [r2]
	mov r2, #0
	cmp r3, #3
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
	mov r2, r0
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
	.global tailRecursionHelper
tailRecursionHelper:
.LU42:
	push {fp, lr}
	add fp, sp, #4
	mov r3, r0
	mov r2, #0
	cmp r3, #0
	moveq r2, #1
	cmp r2, #1
	beq .LU43
	b .LU44
.LU43:
	mov r2, r1
	b .LU41
.LU44:
	sub r2, r3, #1
	add r3, r1, r3
	mov r1, r3
	mov r0, r2
	bl tailRecursionHelper
	mov r2, r0
	b .LU41
.LU41:
	mov r0, r2
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
	.global recursiveFibonacci
recursiveFibonacci:
.LU64:
	push {fp, lr}
	add fp, sp, #4
	push {r4, r5}
	mov r5, r0
	mov r2, #0
	cmp r5, #0
	movle r2, #1
	mov r3, #0
	cmp r5, #1
	moveq r3, #1
	orr r2, r2, r3
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
	push {r4, r5, r6, r7, r8}
	movw r1, #:lower16:.read_scratch
	movt r1, #:upper16:.read_scratch
	movw r0, #:lower16:.READ_FMT
	movt r0, #:upper16:.READ_FMT
	bl scanf
	movw r2, #:lower16:.read_scratch
	movt r2, #:upper16:.read_scratch
	ldr r2, [r2]
	movw r1, #1
	mov r3, #0
	cmp r1, r2
	movlt r3, #1
	mov r1, r2
	movw r2, #1
	cmp r3, #1
	beq .LU70
	b .LU71
.LU70:
	mov r7, r2
	mov r8, r1
	b .inline0_LU1
.inline0_LU1:
	b .inline0_LU0
.inline0_LU0:
	b .next0
.next0:
	movw r1, #226
	movw r0, #:lower16:.PRINTLN_FMT
	movt r0, #:upper16:.PRINTLN_FMT
	bl printf
	b .inline1_LU3
.inline1_LU3:
	b .inline1_LU2
.inline1_LU2:
	b .next1
.next1:
	movw r1, #:lower16:-25457889
	movt r1, #:upper16:-25457889
	movw r0, #:lower16:.PRINTLN_FMT
	movt r0, #:upper16:.PRINTLN_FMT
	bl printf
	b .inline2_LU5
.inline2_LU5:
	movw r2, #11
	movw r3, #:lower16:global1
	movt r3, #:upper16:global1
	str r2, [r3]
	movw r2, #5
	movw r3, #:lower16:global1
	movt r3, #:upper16:global1
	str r2, [r3]
	movw r3, #9
	movw r2, #:lower16:global1
	movt r2, #:upper16:global1
	str r3, [r2]
	b .inline2_LU4
.inline2_LU4:
	b .next2
.next2:
	movw r1, #38
	movw r0, #:lower16:.PRINTLN_FMT
	movt r0, #:upper16:.PRINTLN_FMT
	bl printf
	bl interProceduralOptimization
	mov r2, r0
	mov r1, r2
	movw r0, #:lower16:.PRINTLN_FMT
	movt r0, #:upper16:.PRINTLN_FMT
	bl printf
	b .inline3_LU24
.inline3_LU24:
	b .inline3_LU23
.inline3_LU23:
	b .next3
.next3:
	movw r1, #:lower16:-48796
	movt r1, #:upper16:-48796
	movw r0, #:lower16:.PRINTLN_FMT
	movt r0, #:upper16:.PRINTLN_FMT
	bl printf
	b .inline4_LU26
.inline4_LU26:
	movw r3, #2
	movw r5, #1
	movw r4, #2
	movw r2, #3
	movw r1, #4
	movw r6, #0
	movw r0, #1
	cmp r0, #1
	beq .inline4_LU27
	b .inline4_LU28
.inline4_LU27:
	mov r3, r6
	add r6, r3, #1
	movw r3, #:lower16:1000000
	movt r3, #:upper16:1000000
	mov r0, #0
	cmp r6, r3
	movlt r0, #1
	mov r3, r4
	cmp r0, #1
	beq .inline4_LU27
	b .inline4_LU28
.inline4_LU28:
	mov r2, r3
	b .inline4_LU25
.inline4_LU25:
	b .next4
.next4:
	mov r1, r2
	movw r0, #:lower16:.PRINTLN_FMT
	movt r0, #:upper16:.PRINTLN_FMT
	bl printf
	b .inline5_LU30
.inline5_LU30:
	movw r2, #1
	cmp r2, #1
	beq .inline5_LU31
	b .inline5_LU32
.inline5_LU31:
	movw r2, #1
	cmp r2, #1
	beq .inline5_LU34
	b .inline5_LU35
.inline5_LU34:
	b .inline5_LU36
.inline5_LU35:
	b .inline5_LU36
.inline5_LU36:
	movw r2, #50
	b .inline5_LU33
.inline5_LU32:
	movw r2, #0
	b .inline5_LU33
.inline5_LU33:
	b .inline5_LU29
.inline5_LU29:
	b .next5
.next5:
	mov r1, r2
	movw r0, #:lower16:.PRINTLN_FMT
	movt r0, #:upper16:.PRINTLN_FMT
	bl printf
	b .inline6_LU38
.inline6_LU38:
	b .inline6_LU37
.inline6_LU37:
	b .next6
.next6:
	movw r1, #736
	movw r0, #:lower16:.PRINTLN_FMT
	movt r0, #:upper16:.PRINTLN_FMT
	bl printf
	b .inline7_LU40
.inline7_LU40:
	b .inline7_LU39
.inline7_LU39:
	b .next7
.next7:
	movw r1, #10
	movw r0, #:lower16:.PRINTLN_FMT
	movt r0, #:upper16:.PRINTLN_FMT
	bl printf
	movw r1, #1000
	mov r0, r8
	bl __aeabi_idiv
	mov r2, r0
	mov r0, r2
	bl tailRecursion
	mov r2, r0
	mov r1, r2
	movw r0, #:lower16:.PRINTLN_FMT
	movt r0, #:upper16:.PRINTLN_FMT
	bl printf
	b .inline8_LU49
.inline8_LU49:
	movw r3, #1
	movw r0, #2
	movw r2, #1
	movw r1, #1
	cmp r1, #1
	beq .inline8_LU50
	b .inline8_LU51
.inline8_LU50:
	mov r1, r0
	mov r3, #0
	cmp r1, #2
	moveq r3, #1
	cmp r3, #1
	beq .inline8_LU52
	b .inline8_LU53
.inline8_LU52:
	add r2, r2, #1
	mov r3, r1
	b .inline8_LU54
.inline8_LU53:
	add r2, r2, #2
	mov r3, r1
	b .inline8_LU54
.inline8_LU54:
	mov r0, r3
	movw r3, #:lower16:1000000
	movt r3, #:upper16:1000000
	mov r1, #0
	cmp r2, r3
	movlt r1, #1
	mov r3, r2
	cmp r1, #1
	beq .inline8_LU50
	b .inline8_LU51
.inline8_LU51:
	mov r2, r3
	b .inline8_LU48
.inline8_LU48:
	b .next8
.next8:
	mov r1, r2
	movw r0, #:lower16:.PRINTLN_FMT
	movt r0, #:upper16:.PRINTLN_FMT
	bl printf
	b .inline9_LU56
.inline9_LU56:
	movw r2, #0
	mov r1, #0
	cmp r2, r8
	movlt r1, #1
	movw r3, #0
	movw r0, #0
	movw r2, #0
	mov r4, r8
	cmp r1, #1
	beq .inline9_LU57
	b .inline9_LU58
.inline9_LU57:
	mov r5, r4
	mov r3, r0
	add r4, r3, #19
	movw r3, #2
	mul r2, r2, r3
	movw r1, #2
	mov r0, r2
	bl __aeabi_idiv
	mov r2, r0
	movw r3, #3
	mul r2, r3, r2
	movw r1, #3
	mov r0, r2
	bl __aeabi_idiv
	mov r2, r0
	movw r3, #4
	mul r2, r2, r3
	movw r1, #4
	mov r0, r2
	bl __aeabi_idiv
	mov r2, r0
	add r2, r2, #1
	mov r1, #0
	cmp r2, r5
	movlt r1, #1
	mov r3, r4
	mov r0, r4
	mov r4, r5
	cmp r1, #1
	beq .inline9_LU57
	b .inline9_LU58
.inline9_LU58:
	mov r2, r3
	b .inline9_LU55
.inline9_LU55:
	b .next9
.next9:
	mov r1, r2
	movw r0, #:lower16:.PRINTLN_FMT
	movt r0, #:upper16:.PRINTLN_FMT
	bl printf
	movw r1, #5
	mov r0, r8
	bl __aeabi_idiv
	mov r3, r0
	b .inline10_LU60
.inline10_LU60:
	movw r2, #0
	mov r1, #0
	cmp r2, r3
	movlt r1, #1
	movw r4, #1
	movw r5, #1
	movw r0, #:lower16:-1
	movt r0, #:upper16:-1
	movw r2, #0
	cmp r1, #1
	beq .inline10_LU61
	b .inline10_LU62
.inline10_LU61:
	mov r1, r0
	mov r0, r5
	add r5, r0, r1
	add r2, r2, #1
	mov r1, #0
	cmp r2, r3
	movlt r1, #1
	mov r4, r5
	cmp r1, #1
	beq .inline10_LU61
	b .inline10_LU62
.inline10_LU62:
	mov r2, r4
	b .inline10_LU59
.inline10_LU59:
	b .next10
.next10:
	mov r1, r2
	movw r0, #:lower16:.PRINTLN_FMT
	movt r0, #:upper16:.PRINTLN_FMT
	bl printf
	movw r1, #1000
	mov r0, r8
	bl __aeabi_idiv
	mov r2, r0
	mov r0, r2
	bl recursiveFibonacci
	mov r2, r0
	mov r1, r2
	movw r0, #:lower16:.PRINTLN_FMT
	movt r0, #:upper16:.PRINTLN_FMT
	bl printf
	add r2, r7, #1
	mov r3, #0
	cmp r2, r8
	movlt r3, #1
	mov r1, r8
	cmp r3, #1
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
