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
	push {r4}
	movw r4, #8
	movw r1, #9
	mul r4, r4, r1
	movw r1, #4
	mov r0, r4
	bl __aeabi_idiv
	mov r4, r0
	add r4, r4, #2
	movw r1, #5
	movw r2, #8
	mul r1, r1, r2
	sub r4, r4, r1
	add r4, r4, #9
	sub r4, r4, #12
	add r4, r4, #6
	sub r4, r4, #9
	sub r4, r4, #18
	movw r2, #23
	movw r1, #3
	mul r2, r2, r1
	movw r1, #23
	mov r0, r2
	bl __aeabi_idiv
	mov r2, r0
	movw r1, #90
	mul r1, r2, r1
	add r4, r4, r1
	b .LU0
.LU0:
	mov r0, r4
	pop {r4}
	pop {fp, pc}
	.size constantFolding, .-constantFolding
	.align 2
	.global constantPropagation
constantPropagation:
.LU3:
	push {fp, lr}
	add fp, sp, #4
	push {r4, r5, r6, r7, r8, r9, r10}
	movw r4, #4
	add r9, r4, #7
	movw r4, #8
	add r10, r4, #5
	movw r4, #11
	add r8, r4, #21
	add r6, r9, r10
	mul r4, r8, r6
	mul r5, r10, r8
	movw r7, #11
	add r5, r7, r5
	sub r5, r5, r4
	mul r7, r8, r6
	sub r7, r10, r7
	mov r1, r5
	mov r0, r4
	bl __aeabi_idiv
	mov r1, r0
	add r7, r7, r1
	movw r1, #11
	add r1, r1, #21
	add r1, r1, r9
	add r1, r1, r10
	add r1, r1, r8
	sub r6, r1, r6
	sub r7, r6, r7
	add r7, r7, r10
	sub r7, r7, #4
	sub r7, r7, #7
	add r1, r4, r5
	sub r9, r1, r9
	sub r9, r9, r10
	movw r10, #7
	sub r1, r10, #4
	movw r10, #5
	mul r10, r1, r10
	movw r10, #8
	mul r10, r5, r10
	movw r1, #5
	mul r10, r10, r1
	add r10, r10, r7
	movw r2, #7
	movw r1, #4
	mul r2, r2, r1
	movw r1, #8
	mul r2, r2, r1
	movw r1, #11
	mov r0, r2
	bl __aeabi_idiv
	mov r1, r0
	sub r1, r1, r7
	add r8, r8, r4
	add r8, r8, #8
	sub r8, r8, r9
	add r2, r6, r7
	movw r3, #21
	movw r0, #4
	mul r0, r3, r0
	movw r0, #4
	movw r2, #7
	mul r2, r0, r2
	sub r2, r2, r4
	sub r2, r2, r5
	sub r5, r2, r1
	movw r1, #5
	mul r10, r10, r1
	sub r5, r5, r10
	sub r7, r7, r5
	sub r7, r7, r2
	sub r6, r7, r6
	mul r7, r9, r6
	add r7, r7, r8
	sub r7, r7, r5
	sub r5, r5, r6
	add r5, r5, r7
	add r4, r5, r4
	b .LU2
.LU2:
	mov r0, r4
	pop {r4, r5, r6, r7, r8, r9, r10}
	pop {fp, pc}
	.size constantPropagation, .-constantPropagation
	.align 2
	.global deadCodeElimination
deadCodeElimination:
.LU5:
	push {fp, lr}
	add fp, sp, #4
	movw r0, #11
	movw r1, #:lower16:global1
	movt r1, #:upper16:global1
	str r0, [r1]
	movw r0, #5
	movw r1, #:lower16:global1
	movt r1, #:upper16:global1
	str r0, [r1]
	movw r0, #9
	movw r1, #:lower16:global1
	movt r1, #:upper16:global1
	str r0, [r1]
	movw r0, #8
	add r0, r0, #8
	add r0, r0, #9
	add r0, r0, #3
	add r0, r0, #10
	b .LU4
.LU4:
	pop {fp, pc}
	.size deadCodeElimination, .-deadCodeElimination
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
	b .LU6
.LU6:
	pop {fp, pc}
	.size sum, .-sum
	.align 2
	.global doesntModifyGlobals
doesntModifyGlobals:
.LU11:
	push {fp, lr}
	add fp, sp, #4
	movw r2, #1
	add r2, r2, #2
	b .LU10
.LU10:
	mov r0, r2
	pop {fp, pc}
	.size doesntModifyGlobals, .-doesntModifyGlobals
	.align 2
	.global interProceduralOptimization
interProceduralOptimization:
.LU13:
	push {fp, lr}
	add fp, sp, #4
	movw r2, #1
	movw r1, #:lower16:global1
	movt r1, #:upper16:global1
	str r2, [r1]
	movw r1, #0
	movw r2, #:lower16:global2
	movt r2, #:upper16:global2
	str r1, [r2]
	movw r1, #0
	movw r2, #:lower16:global3
	movt r2, #:upper16:global3
	str r1, [r2]
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
	b .LU12
.LU12:
	mov r0, r1
	pop {fp, pc}
	.size interProceduralOptimization, .-interProceduralOptimization
	.align 2
	.global commonSubexpressionElimination
commonSubexpressionElimination:
.LU24:
	push {fp, lr}
	add fp, sp, #4
	push {r4, r5, r6, r7, r8, r9, r10, r11}
	sub sp, sp, #48
	movw r4, #11
	movw r5, #22
	mul r6, r4, r5
	movw r1, #44
	movw r0, #33
	bl __aeabi_idiv
	mov r4, r0
	movw r7, #55
	movw r5, #66
	mul r5, r7, r5
	movw r8, #11
	movw r7, #22
	mul r8, r8, r7
	movw r1, #44
	movw r0, #33
	bl __aeabi_idiv
	mov r7, r0
	add r7, r8, r7
	movw r9, #55
	movw r8, #66
	mul r8, r9, r8
	sub r7, r7, r8
	add r7, r7, #77
	movw r8, #11
	movw r9, #22
	mul r8, r8, r9
	movw r1, #44
	movw r0, #33
	bl __aeabi_idiv
	mov r9, r0
	add r8, r8, r9
	movw r9, #55
	movw r10, #66
	str r10, [sp, #0]
	ldr r11, [sp, #0]
	mul r9, r9, r11
	sub r8, r8, r9
	add r8, r8, #77
	movw r9, #11
	movw r10, #22
	str r10, [sp, #0]
	ldr r11, [sp, #0]
	mul r9, r9, r11
	movw r1, #44
	movw r0, #33
	bl __aeabi_idiv
	mov r10, r0
	str r10, [sp, #0]
	ldr r11, [sp, #0]
	add r9, r9, r11
	movw r10, #55
	str r10, [sp, #0]
	movw r10, #66
	str r10, [sp, #4]
	ldr r10, [sp, #0]
	ldr r11, [sp, #4]
	mul r10, r10, r11
	str r10, [sp, #0]
	ldr r11, [sp, #0]
	sub r9, r9, r11
	add r9, r9, #77
	movw r10, #11
	str r10, [sp, #0]
	movw r10, #22
	str r10, [sp, #4]
	ldr r10, [sp, #0]
	ldr r11, [sp, #4]
	mul r10, r10, r11
	str r10, [sp, #0]
	movw r1, #44
	movw r0, #33
	bl __aeabi_idiv
	mov r10, r0
	str r10, [sp, #4]
	ldr r10, [sp, #0]
	ldr r11, [sp, #4]
	add r10, r10, r11
	str r10, [sp, #0]
	movw r10, #55
	str r10, [sp, #4]
	movw r10, #66
	str r10, [sp, #8]
	ldr r10, [sp, #4]
	ldr r11, [sp, #8]
	mul r10, r10, r11
	str r10, [sp, #4]
	ldr r10, [sp, #0]
	ldr r11, [sp, #4]
	sub r10, r10, r11
	str r10, [sp, #0]
	ldr r10, [sp, #0]
	add r10, r10, #77
	str r10, [sp, #0]
	movw r10, #11
	str r10, [sp, #8]
	movw r10, #22
	str r10, [sp, #4]
	ldr r10, [sp, #8]
	ldr r11, [sp, #4]
	mul r10, r10, r11
	str r10, [sp, #4]
	movw r1, #44
	movw r0, #33
	bl __aeabi_idiv
	mov r10, r0
	str r10, [sp, #8]
	ldr r10, [sp, #4]
	ldr r11, [sp, #8]
	add r10, r10, r11
	str r10, [sp, #4]
	movw r10, #55
	str r10, [sp, #12]
	movw r10, #66
	str r10, [sp, #8]
	ldr r10, [sp, #12]
	ldr r11, [sp, #8]
	mul r10, r10, r11
	str r10, [sp, #8]
	ldr r10, [sp, #4]
	ldr r11, [sp, #8]
	sub r10, r10, r11
	str r10, [sp, #4]
	ldr r10, [sp, #4]
	add r10, r10, #77
	str r10, [sp, #4]
	movw r10, #11
	str r10, [sp, #8]
	movw r10, #22
	str r10, [sp, #12]
	ldr r10, [sp, #8]
	ldr r11, [sp, #12]
	mul r10, r10, r11
	str r10, [sp, #8]
	movw r1, #44
	movw r0, #33
	bl __aeabi_idiv
	mov r10, r0
	str r10, [sp, #12]
	ldr r10, [sp, #8]
	ldr r11, [sp, #12]
	add r10, r10, r11
	str r10, [sp, #8]
	movw r10, #55
	str r10, [sp, #16]
	movw r10, #66
	str r10, [sp, #12]
	ldr r10, [sp, #16]
	ldr r11, [sp, #12]
	mul r10, r10, r11
	str r10, [sp, #12]
	ldr r10, [sp, #8]
	ldr r11, [sp, #12]
	sub r10, r10, r11
	str r10, [sp, #8]
	ldr r10, [sp, #8]
	add r10, r10, #77
	str r10, [sp, #8]
	movw r10, #11
	str r10, [sp, #16]
	movw r10, #22
	str r10, [sp, #12]
	ldr r10, [sp, #16]
	ldr r11, [sp, #12]
	mul r10, r10, r11
	str r10, [sp, #16]
	movw r1, #44
	movw r0, #33
	bl __aeabi_idiv
	mov r10, r0
	str r10, [sp, #12]
	ldr r10, [sp, #16]
	ldr r11, [sp, #12]
	add r10, r10, r11
	str r10, [sp, #12]
	movw r10, #55
	str r10, [sp, #20]
	movw r10, #66
	str r10, [sp, #16]
	ldr r10, [sp, #20]
	ldr r11, [sp, #16]
	mul r10, r10, r11
	str r10, [sp, #16]
	ldr r10, [sp, #12]
	ldr r11, [sp, #16]
	sub r10, r10, r11
	str r10, [sp, #12]
	ldr r10, [sp, #12]
	add r10, r10, #77
	str r10, [sp, #12]
	movw r10, #11
	str r10, [sp, #20]
	movw r10, #22
	str r10, [sp, #16]
	ldr r10, [sp, #20]
	ldr r11, [sp, #16]
	mul r10, r10, r11
	str r10, [sp, #16]
	movw r1, #44
	movw r0, #33
	bl __aeabi_idiv
	mov r10, r0
	str r10, [sp, #20]
	ldr r10, [sp, #16]
	ldr r11, [sp, #20]
	add r10, r10, r11
	str r10, [sp, #16]
	movw r10, #55
	str r10, [sp, #20]
	movw r10, #66
	str r10, [sp, #24]
	ldr r10, [sp, #20]
	ldr r11, [sp, #24]
	mul r10, r10, r11
	str r10, [sp, #20]
	ldr r10, [sp, #16]
	ldr r11, [sp, #20]
	sub r10, r10, r11
	str r10, [sp, #16]
	ldr r10, [sp, #16]
	add r10, r10, #77
	str r10, [sp, #16]
	movw r10, #11
	str r10, [sp, #24]
	movw r10, #22
	str r10, [sp, #20]
	ldr r10, [sp, #24]
	ldr r11, [sp, #20]
	mul r10, r10, r11
	str r10, [sp, #24]
	movw r1, #44
	movw r0, #33
	bl __aeabi_idiv
	mov r10, r0
	str r10, [sp, #20]
	ldr r10, [sp, #24]
	ldr r11, [sp, #20]
	add r10, r10, r11
	str r10, [sp, #20]
	movw r10, #55
	str r10, [sp, #28]
	movw r10, #66
	str r10, [sp, #24]
	ldr r10, [sp, #28]
	ldr r11, [sp, #24]
	mul r10, r10, r11
	str r10, [sp, #24]
	ldr r10, [sp, #20]
	ldr r11, [sp, #24]
	sub r10, r10, r11
	str r10, [sp, #20]
	ldr r10, [sp, #20]
	add r10, r10, #77
	str r10, [sp, #20]
	movw r10, #11
	str r10, [sp, #24]
	movw r10, #22
	str r10, [sp, #28]
	ldr r10, [sp, #24]
	ldr r11, [sp, #28]
	mul r10, r10, r11
	str r10, [sp, #28]
	movw r1, #44
	movw r0, #33
	bl __aeabi_idiv
	mov r10, r0
	str r10, [sp, #24]
	ldr r10, [sp, #28]
	ldr r11, [sp, #24]
	add r10, r10, r11
	str r10, [sp, #24]
	movw r10, #55
	str r10, [sp, #32]
	movw r10, #66
	str r10, [sp, #28]
	ldr r10, [sp, #32]
	ldr r11, [sp, #28]
	mul r10, r10, r11
	str r10, [sp, #28]
	ldr r10, [sp, #24]
	ldr r11, [sp, #28]
	sub r10, r10, r11
	str r10, [sp, #24]
	ldr r10, [sp, #24]
	add r10, r10, #77
	str r10, [sp, #24]
	movw r10, #11
	str r10, [sp, #28]
	movw r10, #22
	str r10, [sp, #32]
	ldr r10, [sp, #28]
	ldr r11, [sp, #32]
	mul r10, r10, r11
	str r10, [sp, #32]
	movw r1, #44
	movw r0, #33
	bl __aeabi_idiv
	mov r10, r0
	str r10, [sp, #28]
	ldr r10, [sp, #32]
	ldr r11, [sp, #28]
	add r10, r10, r11
	str r10, [sp, #28]
	movw r10, #55
	str r10, [sp, #36]
	movw r10, #66
	str r10, [sp, #32]
	ldr r10, [sp, #36]
	ldr r11, [sp, #32]
	mul r10, r10, r11
	str r10, [sp, #32]
	ldr r10, [sp, #28]
	ldr r11, [sp, #32]
	sub r10, r10, r11
	str r10, [sp, #28]
	ldr r10, [sp, #28]
	add r10, r10, #77
	str r10, [sp, #28]
	movw r10, #22
	str r10, [sp, #36]
	movw r10, #11
	str r10, [sp, #32]
	ldr r10, [sp, #36]
	ldr r11, [sp, #32]
	mul r10, r10, r11
	str r10, [sp, #32]
	movw r1, #44
	movw r0, #33
	bl __aeabi_idiv
	mov r10, r0
	str r10, [sp, #36]
	ldr r10, [sp, #32]
	ldr r11, [sp, #36]
	add r10, r10, r11
	str r10, [sp, #32]
	movw r10, #55
	str r10, [sp, #36]
	movw r10, #66
	str r10, [sp, #40]
	ldr r10, [sp, #36]
	ldr r11, [sp, #40]
	mul r10, r10, r11
	str r10, [sp, #36]
	ldr r10, [sp, #32]
	ldr r11, [sp, #36]
	sub r10, r10, r11
	str r10, [sp, #32]
	ldr r10, [sp, #32]
	add r10, r10, #77
	str r10, [sp, #32]
	movw r10, #11
	str r10, [sp, #36]
	movw r10, #22
	str r10, [sp, #40]
	ldr r10, [sp, #36]
	ldr r11, [sp, #40]
	mul r10, r10, r11
	str r10, [sp, #40]
	movw r1, #44
	movw r0, #33
	bl __aeabi_idiv
	mov r10, r0
	str r10, [sp, #36]
	ldr r10, [sp, #40]
	ldr r11, [sp, #36]
	add r10, r10, r11
	str r10, [sp, #36]
	movw r10, #66
	str r10, [sp, #40]
	movw r10, #55
	str r10, [sp, #44]
	ldr r10, [sp, #40]
	ldr r11, [sp, #44]
	mul r10, r10, r11
	str r10, [sp, #40]
	ldr r10, [sp, #36]
	ldr r11, [sp, #40]
	sub r10, r10, r11
	str r10, [sp, #36]
	ldr r10, [sp, #36]
	add r10, r10, #77
	str r10, [sp, #36]
	movw r10, #11
	str r10, [sp, #40]
	movw r10, #22
	str r10, [sp, #44]
	ldr r10, [sp, #40]
	ldr r11, [sp, #44]
	mul r10, r10, r11
	str r10, [sp, #44]
	movw r10, #77
	str r10, [sp, #40]
	ldr r10, [sp, #40]
	ldr r11, [sp, #44]
	add r10, r10, r11
	str r10, [sp, #40]
	movw r1, #44
	movw r0, #33
	bl __aeabi_idiv
	mov r10, r0
	str r10, [sp, #44]
	ldr r10, [sp, #40]
	ldr r11, [sp, #44]
	add r10, r10, r11
	str r10, [sp, #40]
	movw r2, #55
	movw r10, #66
	str r10, [sp, #44]
	ldr r11, [sp, #44]
	mul r10, r2, r11
	str r10, [sp, #44]
	ldr r10, [sp, #40]
	ldr r11, [sp, #44]
	sub r10, r10, r11
	str r10, [sp, #40]
	movw r2, #11
	movw r10, #22
	str r10, [sp, #44]
	ldr r11, [sp, #44]
	mul r10, r2, r11
	str r10, [sp, #44]
	movw r1, #44
	movw r0, #33
	bl __aeabi_idiv
	mov r2, r0
	ldr r10, [sp, #44]
	add r10, r10, r2
	str r10, [sp, #44]
	movw r2, #55
	movw r3, #66
	mul r2, r2, r3
	ldr r10, [sp, #44]
	sub r10, r10, r2
	str r10, [sp, #44]
	ldr r10, [sp, #44]
	add r10, r10, #77
	str r10, [sp, #44]
	movw r1, #44
	movw r0, #33
	bl __aeabi_idiv
	mov r2, r0
	movw r3, #11
	movw r1, #22
	mul r3, r3, r1
	add r2, r2, r3
	movw r1, #55
	movw r3, #66
	mul r3, r1, r3
	sub r2, r2, r3
	add r2, r2, #77
	movw r3, #11
	add r3, r3, #22
	add r3, r3, #33
	add r3, r3, #44
	add r3, r3, #55
	add r3, r3, #66
	add r3, r3, #77
	add r6, r3, r6
	add r4, r6, r4
	add r4, r4, r5
	add r4, r4, r7
	add r4, r4, r8
	add r4, r4, r9
	ldr r11, [sp, #0]
	add r4, r4, r11
	ldr r11, [sp, #4]
	add r4, r4, r11
	ldr r11, [sp, #8]
	add r4, r4, r11
	ldr r11, [sp, #12]
	add r4, r4, r11
	ldr r11, [sp, #16]
	add r4, r4, r11
	ldr r11, [sp, #20]
	add r4, r4, r11
	ldr r11, [sp, #24]
	add r4, r4, r11
	ldr r11, [sp, #28]
	add r4, r4, r11
	ldr r11, [sp, #32]
	add r4, r4, r11
	ldr r11, [sp, #36]
	add r4, r4, r11
	ldr r11, [sp, #40]
	add r4, r4, r11
	ldr r11, [sp, #44]
	add r4, r4, r11
	add r4, r4, r2
	b .LU23
.LU23:
	mov r0, r4
	add sp, sp, #48
	pop {r4, r5, r6, r7, r8, r9, r10, r11}
	pop {fp, pc}
	.size commonSubexpressionElimination, .-commonSubexpressionElimination
	.align 2
	.global hoisting
hoisting:
.LU26:
	push {fp, lr}
	add fp, sp, #4
	push {r4, r5, r6, r7, r8}
	movw r0, #0
	movw r2, #:lower16:1000000
	movt r2, #:upper16:1000000
	mov r1, #0
	cmp r0, r2
	movlt r1, #1
	movw r0, #2
	movw r6, #1
	movw r7, #2
	movw r5, #3
	movw r8, #4
	movw r2, #0
	cmp r1, #1
	beq .LU27
	b .LU28
.LU27:
	mov r0, r2
	mov r1, r8
	mov r2, r5
	mov r5, r7
	add r3, r6, r5
	add r3, r3, r2
	add r4, r2, r1
	add r4, r0, #1
	movw r0, #:lower16:1000000
	movt r0, #:upper16:1000000
	mov r3, #0
	cmp r4, r0
	movlt r3, #1
	mov r0, r5
	mov r7, r5
	mov r5, r2
	mov r8, r1
	mov r2, r4
	cmp r3, #1
	beq .LU27
	b .LU28
.LU28:
	mov r1, r0
	b .LU25
.LU25:
	mov r0, r1
	pop {r4, r5, r6, r7, r8}
	pop {fp, pc}
	.size hoisting, .-hoisting
	.align 2
	.global doubleIf
doubleIf:
.LU30:
	push {fp, lr}
	add fp, sp, #4
	movw r0, #1
	mov r1, #0
	cmp r0, #1
	moveq r1, #1
	cmp r1, #1
	beq .LU31
	b .LU32
.LU31:
	movw r0, #1
	mov r1, #0
	cmp r0, #1
	moveq r1, #1
	cmp r1, #1
	beq .LU34
	b .LU35
.LU34:
	b .LU36
.LU35:
	b .LU36
.LU36:
	movw r0, #50
	b .LU33
.LU32:
	movw r0, #0
	b .LU33
.LU33:
	b .LU29
.LU29:
	pop {fp, pc}
	.size doubleIf, .-doubleIf
	.align 2
	.global integerDivide
integerDivide:
.LU38:
	push {fp, lr}
	add fp, sp, #4
	movw r1, #2
	movw r0, #3000
	bl __aeabi_idiv
	mov r1, r0
	movw r0, #4
	mul r0, r1, r0
	movw r1, #8
	bl __aeabi_idiv
	movw r1, #16
	bl __aeabi_idiv
	movw r1, #32
	mul r0, r0, r1
	movw r1, #64
	bl __aeabi_idiv
	movw r1, #128
	mul r0, r0, r1
	movw r1, #4
	bl __aeabi_idiv
	mov r1, r0
	b .LU37
.LU37:
	mov r0, r1
	pop {fp, pc}
	.size integerDivide, .-integerDivide
	.align 2
	.global association
association:
.LU40:
	push {fp, lr}
	add fp, sp, #4
	movw r1, #10
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
	mov r1, r0
	movw r2, #4
	mul r2, r1, r2
	movw r1, #4
	mov r0, r2
	bl __aeabi_idiv
	mov r1, r0
	add r1, r1, #4
	sub r1, r1, #4
	movw r2, #50
	mul r2, r1, r2
	movw r1, #50
	mov r0, r2
	bl __aeabi_idiv
	mov r1, r0
	b .LU39
.LU39:
	mov r0, r1
	pop {fp, pc}
	.size association, .-association
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
	b .LU46
.LU46:
	mov r0, r1
	pop {fp, pc}
	.size tailRecursion, .-tailRecursion
	.align 2
	.global unswitching
unswitching:
.LU49:
	push {fp, lr}
	add fp, sp, #4
	movw r0, #1
	movw r2, #:lower16:1000000
	movt r2, #:upper16:1000000
	mov r1, #0
	cmp r0, r2
	movlt r1, #1
	movw r2, #1
	movw r0, #2
	movw r3, #1
	cmp r1, #1
	beq .LU50
	b .LU51
.LU50:
	mov r2, r3
	mov r1, r0
	mov r0, #0
	cmp r1, #2
	moveq r0, #1
	cmp r0, #1
	beq .LU52
	b .LU53
.LU52:
	add r2, r2, #1
	b .LU54
.LU53:
	add r2, r2, #2
	b .LU54
.LU54:
	mov r0, r1
	mov r3, r2
	movw r2, #:lower16:1000000
	movt r2, #:upper16:1000000
	mov r1, #0
	cmp r3, r2
	movlt r1, #1
	mov r2, r3
	cmp r1, #1
	beq .LU50
	b .LU51
.LU51:
	mov r1, r2
	b .LU48
.LU48:
	mov r0, r1
	pop {fp, pc}
	.size unswitching, .-unswitching
	.align 2
	.global randomCalculation
randomCalculation:
.LU56:
	push {fp, lr}
	add fp, sp, #4
	push {r4, r5}
	movw r5, #0
	mov r4, #0
	cmp r5, r0
	movlt r4, #1
	movw r1, #0
	movw r5, #0
	movw r2, #0
	mov r3, r0
	cmp r4, #1
	beq .LU57
	b .LU58
.LU57:
	mov r4, r3
	mov r1, r2
	movw r2, #4
	add r2, r2, #7
	add r2, r2, #8
	add r5, r5, r2
	movw r2, #2
	mul r2, r1, r2
	movw r1, #2
	mov r0, r2
	bl __aeabi_idiv
	mov r2, r0
	movw r1, #3
	mul r2, r1, r2
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
	add r2, r1, #1
	mov r0, #0
	cmp r2, r4
	movlt r0, #1
	mov r1, r5
	mov r3, r4
	cmp r0, #1
	beq .LU57
	b .LU58
.LU58:
	mov r4, r1
	b .LU55
.LU55:
	mov r0, r4
	pop {r4, r5}
	pop {fp, pc}
	.size randomCalculation, .-randomCalculation
	.align 2
	.global iterativeFibonacci
iterativeFibonacci:
.LU60:
	push {fp, lr}
	add fp, sp, #4
	push {r4, r5, r6}
	mov r4, r0
	movw r1, #0
	sub r3, r1, #1
	movw r1, #0
	mov r0, #0
	cmp r1, r4
	movlt r0, #1
	movw r2, #1
	movw r1, #1
	movw r5, #0
	mov r6, r4
	cmp r0, #1
	beq .LU61
	b .LU62
.LU61:
	mov r0, r6
	mov r2, r5
	mov r4, r3
	mov r3, r1
	add r1, r3, r4
	add r5, r2, #1
	mov r4, #0
	cmp r5, r0
	movlt r4, #1
	mov r2, r1
	mov r6, r0
	cmp r4, #1
	beq .LU61
	b .LU62
.LU62:
	mov r1, r2
	b .LU59
.LU59:
	mov r0, r1
	pop {r4, r5, r6}
	pop {fp, pc}
	.size iterativeFibonacci, .-iterativeFibonacci
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
	push {r4, r5}
	movw r1, #:lower16:.read_scratch
	movt r1, #:upper16:.read_scratch
	movw r0, #:lower16:.READ_FMT
	movt r0, #:upper16:.READ_FMT
	bl scanf
	movw r4, #:lower16:.read_scratch
	movt r4, #:upper16:.read_scratch
	ldr r4, [r4]
	movw r1, #1
	mov r5, #0
	cmp r1, r4
	movlt r5, #1
	movw r1, #1
	cmp r5, #1
	beq .LU70
	b .LU71
.LU70:
	mov r5, r1
	bl constantFolding
	mov r1, r0
	movw r0, #:lower16:.PRINTLN_FMT
	movt r0, #:upper16:.PRINTLN_FMT
	bl printf
	bl constantPropagation
	mov r1, r0
	movw r0, #:lower16:.PRINTLN_FMT
	movt r0, #:upper16:.PRINTLN_FMT
	bl printf
	bl deadCodeElimination
	mov r1, r0
	movw r0, #:lower16:.PRINTLN_FMT
	movt r0, #:upper16:.PRINTLN_FMT
	bl printf
	bl interProceduralOptimization
	mov r1, r0
	movw r0, #:lower16:.PRINTLN_FMT
	movt r0, #:upper16:.PRINTLN_FMT
	bl printf
	bl commonSubexpressionElimination
	mov r1, r0
	movw r0, #:lower16:.PRINTLN_FMT
	movt r0, #:upper16:.PRINTLN_FMT
	bl printf
	bl hoisting
	mov r1, r0
	movw r0, #:lower16:.PRINTLN_FMT
	movt r0, #:upper16:.PRINTLN_FMT
	bl printf
	bl doubleIf
	mov r1, r0
	movw r0, #:lower16:.PRINTLN_FMT
	movt r0, #:upper16:.PRINTLN_FMT
	bl printf
	bl integerDivide
	mov r1, r0
	movw r0, #:lower16:.PRINTLN_FMT
	movt r0, #:upper16:.PRINTLN_FMT
	bl printf
	bl association
	mov r1, r0
	movw r0, #:lower16:.PRINTLN_FMT
	movt r0, #:upper16:.PRINTLN_FMT
	bl printf
	movw r1, #1000
	mov r0, r4
	bl __aeabi_idiv
	mov r1, r0
	mov r0, r1
	bl tailRecursion
	mov r1, r0
	movw r0, #:lower16:.PRINTLN_FMT
	movt r0, #:upper16:.PRINTLN_FMT
	bl printf
	bl unswitching
	mov r1, r0
	movw r0, #:lower16:.PRINTLN_FMT
	movt r0, #:upper16:.PRINTLN_FMT
	bl printf
	mov r0, r4
	bl randomCalculation
	mov r1, r0
	movw r0, #:lower16:.PRINTLN_FMT
	movt r0, #:upper16:.PRINTLN_FMT
	bl printf
	movw r1, #5
	mov r0, r4
	bl __aeabi_idiv
	mov r1, r0
	mov r0, r1
	bl iterativeFibonacci
	mov r1, r0
	movw r0, #:lower16:.PRINTLN_FMT
	movt r0, #:upper16:.PRINTLN_FMT
	bl printf
	movw r1, #1000
	mov r0, r4
	bl __aeabi_idiv
	mov r1, r0
	mov r0, r1
	bl recursiveFibonacci
	mov r1, r0
	movw r0, #:lower16:.PRINTLN_FMT
	movt r0, #:upper16:.PRINTLN_FMT
	bl printf
	add r1, r5, #1
	mov r5, #0
	cmp r1, r4
	movlt r5, #1
	cmp r5, #1
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
