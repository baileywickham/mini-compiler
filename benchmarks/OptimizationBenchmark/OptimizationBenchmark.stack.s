	.arch armv7-a
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
	sub sp, sp, #8
	movw r0, #8
	movw r2, #9
	mul r2, r0, r2
	movw r1, #4
	mov r0, r2
	bl __aeabi_idiv
	mov r2, r0
	add r2, r2, #2
	movw r1, #5
	movw r0, #8
	mul r0, r1, r0
	sub r2, r2, r0
	add r2, r2, #9
	sub r2, r2, #12
	add r2, r2, #6
	sub r2, r2, #9
	sub r4, r2, #18
	movw r2, #23
	movw r0, #3
	mul r2, r2, r0
	movw r1, #23
	mov r0, r2
	bl __aeabi_idiv
	movw r2, #90
	mul r2, r0, r2
	add r2, r4, r2
	str r2, [sp, #4]
	ldr r2, [sp, #4]
	str r2, [sp, #0]
	b .LU0
.LU0:
	ldr r2, [sp, #0]
	mov r0, r2
	add sp, sp, #8
	pop {r4}
	pop {fp, pc}
	.size constantFolding, .-constantFolding
	.align 2
	.global constantPropagation
constantPropagation:
.LU3:
	push {fp, lr}
	add fp, sp, #4
	push {r4}
	sub sp, sp, #108
	movw r2, #4
	str r2, [sp, #4]
	movw r2, #7
	str r2, [sp, #8]
	movw r2, #8
	str r2, [sp, #12]
	movw r2, #5
	str r2, [sp, #16]
	movw r2, #11
	str r2, [sp, #20]
	movw r2, #21
	str r2, [sp, #24]
	ldr r2, [sp, #4]
	ldr r0, [sp, #8]
	add r2, r2, r0
	str r2, [sp, #28]
	ldr r0, [sp, #12]
	ldr r2, [sp, #16]
	add r2, r0, r2
	str r2, [sp, #32]
	ldr r0, [sp, #20]
	ldr r2, [sp, #24]
	add r2, r0, r2
	str r2, [sp, #36]
	ldr r2, [sp, #28]
	ldr r0, [sp, #32]
	add r2, r2, r0
	str r2, [sp, #40]
	ldr r2, [sp, #36]
	ldr r0, [sp, #40]
	mul r2, r2, r0
	str r2, [sp, #44]
	ldr r2, [sp, #20]
	ldr r0, [sp, #32]
	ldr r3, [sp, #36]
	mul r0, r0, r3
	add r0, r2, r0
	ldr r2, [sp, #44]
	sub r2, r0, r2
	str r2, [sp, #48]
	ldr r2, [sp, #32]
	ldr r0, [sp, #36]
	ldr r3, [sp, #40]
	mul r0, r0, r3
	sub r4, r2, r0
	ldr r2, [sp, #44]
	ldr r0, [sp, #48]
	mov r1, r0
	mov r0, r2
	bl __aeabi_idiv
	mov r2, r0
	add r2, r4, r2
	str r2, [sp, #52]
	ldr r2, [sp, #20]
	ldr r0, [sp, #24]
	add r2, r2, r0
	ldr r0, [sp, #28]
	add r0, r2, r0
	ldr r2, [sp, #32]
	add r2, r0, r2
	ldr r0, [sp, #36]
	add r2, r2, r0
	ldr r0, [sp, #40]
	sub r2, r2, r0
	str r2, [sp, #56]
	ldr r2, [sp, #56]
	ldr r0, [sp, #52]
	sub r2, r2, r0
	ldr r0, [sp, #32]
	add r2, r2, r0
	ldr r0, [sp, #4]
	sub r2, r2, r0
	ldr r0, [sp, #8]
	sub r2, r2, r0
	str r2, [sp, #60]
	ldr r2, [sp, #44]
	ldr r0, [sp, #48]
	add r2, r2, r0
	ldr r0, [sp, #28]
	sub r2, r2, r0
	ldr r0, [sp, #32]
	sub r2, r2, r0
	str r2, [sp, #64]
	ldr r2, [sp, #8]
	ldr r0, [sp, #4]
	sub r0, r2, r0
	ldr r2, [sp, #16]
	mul r0, r0, r2
	ldr r2, [sp, #36]
	sub r2, r0, r2
	str r2, [sp, #68]
	ldr r0, [sp, #48]
	ldr r2, [sp, #12]
	mul r2, r0, r2
	ldr r0, [sp, #16]
	mul r0, r2, r0
	ldr r2, [sp, #60]
	add r2, r0, r2
	str r2, [sp, #72]
	ldr r0, [sp, #8]
	ldr r2, [sp, #4]
	mul r0, r0, r2
	ldr r2, [sp, #12]
	mul r2, r0, r2
	ldr r0, [sp, #20]
	mov r1, r0
	mov r0, r2
	bl __aeabi_idiv
	ldr r2, [sp, #60]
	sub r2, r0, r2
	str r2, [sp, #76]
	ldr r2, [sp, #36]
	ldr r0, [sp, #44]
	add r2, r2, r0
	ldr r0, [sp, #12]
	add r2, r2, r0
	ldr r0, [sp, #64]
	sub r2, r2, r0
	str r2, [sp, #80]
	ldr r0, [sp, #56]
	ldr r2, [sp, #60]
	add r3, r0, r2
	ldr r0, [sp, #24]
	ldr r2, [sp, #4]
	mul r2, r0, r2
	sub r2, r3, r2
	str r2, [sp, #84]
	ldr r2, [sp, #4]
	ldr r0, [sp, #8]
	mul r0, r2, r0
	ldr r2, [sp, #44]
	sub r2, r0, r2
	ldr r0, [sp, #48]
	sub r2, r2, r0
	str r2, [sp, #88]
	ldr r0, [sp, #88]
	ldr r2, [sp, #76]
	sub r3, r0, r2
	ldr r0, [sp, #72]
	ldr r2, [sp, #16]
	mul r2, r0, r2
	sub r2, r3, r2
	str r2, [sp, #92]
	ldr r0, [sp, #60]
	ldr r2, [sp, #92]
	sub r0, r0, r2
	ldr r2, [sp, #88]
	sub r2, r0, r2
	ldr r0, [sp, #56]
	sub r2, r2, r0
	str r2, [sp, #96]
	ldr r0, [sp, #64]
	ldr r2, [sp, #96]
	mul r2, r0, r2
	ldr r0, [sp, #80]
	add r2, r2, r0
	ldr r0, [sp, #92]
	sub r2, r2, r0
	str r2, [sp, #100]
	ldr r2, [sp, #92]
	ldr r0, [sp, #96]
	sub r0, r2, r0
	ldr r2, [sp, #100]
	add r2, r0, r2
	ldr r0, [sp, #44]
	add r2, r2, r0
	str r2, [sp, #104]
	ldr r2, [sp, #104]
	str r2, [sp, #0]
	b .LU2
.LU2:
	ldr r2, [sp, #0]
	mov r0, r2
	add sp, sp, #108
	pop {r4}
	pop {fp, pc}
	.size constantPropagation, .-constantPropagation
	.align 2
	.global deadCodeElimination
deadCodeElimination:
.LU5:
	push {fp, lr}
	add fp, sp, #4
	sub sp, sp, #24
	movw r2, #4
	str r2, [sp, #4]
	movw r2, #5
	str r2, [sp, #4]
	movw r2, #7
	str r2, [sp, #4]
	movw r2, #8
	str r2, [sp, #4]
	movw r2, #6
	str r2, [sp, #8]
	movw r2, #9
	str r2, [sp, #8]
	movw r2, #12
	str r2, [sp, #8]
	movw r2, #8
	str r2, [sp, #8]
	movw r2, #10
	str r2, [sp, #12]
	movw r2, #13
	str r2, [sp, #12]
	movw r2, #9
	str r2, [sp, #12]
	movw r2, #45
	str r2, [sp, #16]
	movw r2, #12
	str r2, [sp, #16]
	movw r2, #3
	str r2, [sp, #16]
	movw r2, #23
	str r2, [sp, #20]
	movw r2, #10
	str r2, [sp, #20]
	movw r2, #11
	movw r0, #:lower16:global1
	movt r0, #:upper16:global1
	str r2, [r0]
	movw r0, #5
	movw r2, #:lower16:global1
	movt r2, #:upper16:global1
	str r0, [r2]
	movw r2, #9
	movw r0, #:lower16:global1
	movt r0, #:upper16:global1
	str r2, [r0]
	ldr r2, [sp, #4]
	ldr r0, [sp, #8]
	add r0, r2, r0
	ldr r2, [sp, #12]
	add r2, r0, r2
	ldr r0, [sp, #16]
	add r2, r2, r0
	ldr r0, [sp, #20]
	add r2, r2, r0
	str r2, [sp, #0]
	b .LU4
.LU4:
	ldr r2, [sp, #0]
	mov r0, r2
	add sp, sp, #24
	pop {fp, pc}
	.size deadCodeElimination, .-deadCodeElimination
	.align 2
	.global sum
sum:
.LU7:
	push {fp, lr}
	add fp, sp, #4
	sub sp, sp, #12
	mov r2, r0
	str r2, [sp, #0]
	movw r2, #0
	str r2, [sp, #8]
	ldr r2, [sp, #0]
	mov r0, #0
	cmp r2, #0
	movgt r0, #1
	cmp r0, #1
	beq .LU8
	b .LU9
.LU8:
	ldr r0, [sp, #8]
	ldr r2, [sp, #0]
	add r2, r0, r2
	str r2, [sp, #8]
	ldr r2, [sp, #0]
	sub r2, r2, #1
	str r2, [sp, #0]
	ldr r0, [sp, #0]
	mov r2, #0
	cmp r0, #0
	movgt r2, #1
	cmp r2, #1
	beq .LU8
	b .LU9
.LU9:
	ldr r2, [sp, #8]
	str r2, [sp, #4]
	b .LU6
.LU6:
	ldr r2, [sp, #4]
	mov r0, r2
	add sp, sp, #12
	pop {fp, pc}
	.size sum, .-sum
	.align 2
	.global doesntModifyGlobals
doesntModifyGlobals:
.LU11:
	push {fp, lr}
	add fp, sp, #4
	sub sp, sp, #12
	movw r2, #1
	str r2, [sp, #4]
	movw r2, #2
	str r2, [sp, #8]
	ldr r3, [sp, #4]
	ldr r2, [sp, #8]
	add r2, r3, r2
	str r2, [sp, #0]
	b .LU10
.LU10:
	ldr r2, [sp, #0]
	mov r0, r2
	add sp, sp, #12
	pop {fp, pc}
	.size doesntModifyGlobals, .-doesntModifyGlobals
	.align 2
	.global interProceduralOptimization
interProceduralOptimization:
.LU13:
	push {fp, lr}
	add fp, sp, #4
	sub sp, sp, #8
	movw r2, #1
	movw r0, #:lower16:global1
	movt r0, #:upper16:global1
	str r2, [r0]
	movw r2, #0
	movw r0, #:lower16:global2
	movt r0, #:upper16:global2
	str r2, [r0]
	movw r2, #0
	movw r0, #:lower16:global3
	movt r0, #:upper16:global3
	str r2, [r0]
	movw r0, #100
	bl sum
	mov r2, r0
	str r2, [sp, #4]
	movw r2, #:lower16:global1
	movt r2, #:upper16:global1
	ldr r2, [r2]
	mov r0, #0
	cmp r2, #1
	moveq r0, #1
	cmp r0, #1
	beq .LU14
	b .LU15
.LU14:
	movw r0, #10000
	bl sum
	mov r2, r0
	str r2, [sp, #4]
	b .LU16
.LU15:
	movw r2, #:lower16:global2
	movt r2, #:upper16:global2
	ldr r0, [r2]
	mov r2, #0
	cmp r0, #2
	moveq r2, #1
	cmp r2, #1
	beq .LU17
	b .LU18
.LU17:
	movw r0, #20000
	bl sum
	mov r2, r0
	str r2, [sp, #4]
	b .LU18
.LU18:
	movw r2, #:lower16:global3
	movt r2, #:upper16:global3
	ldr r2, [r2]
	mov r0, #0
	cmp r2, #3
	moveq r0, #1
	cmp r0, #1
	beq .LU19
	b .LU20
.LU19:
	movw r0, #30000
	bl sum
	mov r2, r0
	str r2, [sp, #4]
	b .LU20
.LU20:
	b .LU16
.LU16:
	ldr r2, [sp, #4]
	str r2, [sp, #0]
	b .LU12
.LU12:
	ldr r2, [sp, #0]
	mov r0, r2
	add sp, sp, #8
	pop {fp, pc}
	.size interProceduralOptimization, .-interProceduralOptimization
	.align 2
	.global commonSubexpressionElimination
commonSubexpressionElimination:
.LU22:
	push {fp, lr}
	add fp, sp, #4
	push {r4}
	sub sp, sp, #108
	movw r4, #11
	str r4, [sp, #4]
	movw r4, #22
	str r4, [sp, #8]
	movw r4, #33
	str r4, [sp, #12]
	movw r4, #44
	str r4, [sp, #16]
	movw r4, #55
	str r4, [sp, #20]
	movw r4, #66
	str r4, [sp, #24]
	movw r4, #77
	str r4, [sp, #28]
	ldr r0, [sp, #4]
	ldr r4, [sp, #8]
	mul r4, r0, r4
	str r4, [sp, #32]
	ldr r4, [sp, #12]
	ldr r0, [sp, #16]
	mov r1, r0
	mov r0, r4
	bl __aeabi_idiv
	mov r4, r0
	str r4, [sp, #36]
	ldr r4, [sp, #20]
	ldr r0, [sp, #24]
	mul r4, r4, r0
	str r4, [sp, #40]
	ldr r0, [sp, #4]
	ldr r4, [sp, #8]
	mul r4, r0, r4
	ldr r0, [sp, #12]
	ldr r3, [sp, #16]
	mov r1, r3
	bl __aeabi_idiv
	add r3, r4, r0
	ldr r4, [sp, #20]
	ldr r0, [sp, #24]
	mul r4, r4, r0
	sub r0, r3, r4
	ldr r4, [sp, #28]
	add r4, r0, r4
	str r4, [sp, #44]
	ldr r0, [sp, #4]
	ldr r4, [sp, #8]
	mul r4, r0, r4
	ldr r0, [sp, #12]
	ldr r3, [sp, #16]
	mov r1, r3
	bl __aeabi_idiv
	add r3, r4, r0
	ldr r0, [sp, #20]
	ldr r4, [sp, #24]
	mul r4, r0, r4
	sub r4, r3, r4
	ldr r0, [sp, #28]
	add r4, r4, r0
	str r4, [sp, #48]
	ldr r4, [sp, #4]
	ldr r0, [sp, #8]
	mul r4, r4, r0
	ldr r0, [sp, #12]
	ldr r3, [sp, #16]
	mov r1, r3
	bl __aeabi_idiv
	add r4, r4, r0
	ldr r0, [sp, #20]
	ldr r3, [sp, #24]
	mul r0, r0, r3
	sub r0, r4, r0
	ldr r4, [sp, #28]
	add r4, r0, r4
	str r4, [sp, #52]
	ldr r0, [sp, #4]
	ldr r4, [sp, #8]
	mul r4, r0, r4
	ldr r0, [sp, #12]
	ldr r3, [sp, #16]
	mov r1, r3
	bl __aeabi_idiv
	add r3, r4, r0
	ldr r4, [sp, #20]
	ldr r0, [sp, #24]
	mul r4, r4, r0
	sub r0, r3, r4
	ldr r4, [sp, #28]
	add r4, r0, r4
	str r4, [sp, #56]
	ldr r0, [sp, #4]
	ldr r4, [sp, #8]
	mul r4, r0, r4
	ldr r0, [sp, #12]
	ldr r3, [sp, #16]
	mov r1, r3
	bl __aeabi_idiv
	add r3, r4, r0
	ldr r0, [sp, #20]
	ldr r4, [sp, #24]
	mul r4, r0, r4
	sub r0, r3, r4
	ldr r4, [sp, #28]
	add r4, r0, r4
	str r4, [sp, #60]
	ldr r0, [sp, #4]
	ldr r4, [sp, #8]
	mul r4, r0, r4
	ldr r0, [sp, #12]
	ldr r3, [sp, #16]
	mov r1, r3
	bl __aeabi_idiv
	add r3, r4, r0
	ldr r4, [sp, #20]
	ldr r0, [sp, #24]
	mul r4, r4, r0
	sub r0, r3, r4
	ldr r4, [sp, #28]
	add r4, r0, r4
	str r4, [sp, #64]
	ldr r0, [sp, #4]
	ldr r4, [sp, #8]
	mul r4, r0, r4
	ldr r0, [sp, #12]
	ldr r3, [sp, #16]
	mov r1, r3
	bl __aeabi_idiv
	add r3, r4, r0
	ldr r4, [sp, #20]
	ldr r0, [sp, #24]
	mul r4, r4, r0
	sub r0, r3, r4
	ldr r4, [sp, #28]
	add r4, r0, r4
	str r4, [sp, #68]
	ldr r0, [sp, #4]
	ldr r4, [sp, #8]
	mul r4, r0, r4
	ldr r0, [sp, #12]
	ldr r3, [sp, #16]
	mov r1, r3
	bl __aeabi_idiv
	add r3, r4, r0
	ldr r0, [sp, #20]
	ldr r4, [sp, #24]
	mul r4, r0, r4
	sub r4, r3, r4
	ldr r0, [sp, #28]
	add r4, r4, r0
	str r4, [sp, #72]
	ldr r0, [sp, #4]
	ldr r4, [sp, #8]
	mul r4, r0, r4
	ldr r0, [sp, #12]
	ldr r3, [sp, #16]
	mov r1, r3
	bl __aeabi_idiv
	add r0, r4, r0
	ldr r4, [sp, #20]
	ldr r3, [sp, #24]
	mul r4, r4, r3
	sub r4, r0, r4
	ldr r0, [sp, #28]
	add r4, r4, r0
	str r4, [sp, #76]
	ldr r0, [sp, #4]
	ldr r4, [sp, #8]
	mul r4, r0, r4
	ldr r0, [sp, #12]
	ldr r3, [sp, #16]
	mov r1, r3
	bl __aeabi_idiv
	add r4, r4, r0
	ldr r0, [sp, #20]
	ldr r3, [sp, #24]
	mul r0, r0, r3
	sub r0, r4, r0
	ldr r4, [sp, #28]
	add r4, r0, r4
	str r4, [sp, #80]
	ldr r0, [sp, #4]
	ldr r4, [sp, #8]
	mul r4, r0, r4
	ldr r0, [sp, #12]
	ldr r3, [sp, #16]
	mov r1, r3
	bl __aeabi_idiv
	add r3, r4, r0
	ldr r4, [sp, #20]
	ldr r0, [sp, #24]
	mul r4, r4, r0
	sub r0, r3, r4
	ldr r4, [sp, #28]
	add r4, r0, r4
	str r4, [sp, #84]
	ldr r0, [sp, #8]
	ldr r4, [sp, #4]
	mul r4, r0, r4
	ldr r0, [sp, #12]
	ldr r3, [sp, #16]
	mov r1, r3
	bl __aeabi_idiv
	add r3, r4, r0
	ldr r0, [sp, #20]
	ldr r4, [sp, #24]
	mul r4, r0, r4
	sub r0, r3, r4
	ldr r4, [sp, #28]
	add r4, r0, r4
	str r4, [sp, #88]
	ldr r0, [sp, #4]
	ldr r4, [sp, #8]
	mul r4, r0, r4
	ldr r0, [sp, #12]
	ldr r3, [sp, #16]
	mov r1, r3
	bl __aeabi_idiv
	add r3, r4, r0
	ldr r0, [sp, #24]
	ldr r4, [sp, #20]
	mul r4, r0, r4
	sub r0, r3, r4
	ldr r4, [sp, #28]
	add r4, r0, r4
	str r4, [sp, #92]
	ldr r3, [sp, #28]
	ldr r0, [sp, #4]
	ldr r4, [sp, #8]
	mul r4, r0, r4
	add r4, r3, r4
	ldr r0, [sp, #12]
	ldr r3, [sp, #16]
	mov r1, r3
	bl __aeabi_idiv
	add r3, r4, r0
	ldr r0, [sp, #20]
	ldr r4, [sp, #24]
	mul r4, r0, r4
	sub r4, r3, r4
	str r4, [sp, #96]
	ldr r4, [sp, #4]
	ldr r0, [sp, #8]
	mul r4, r4, r0
	ldr r0, [sp, #12]
	ldr r3, [sp, #16]
	mov r1, r3
	bl __aeabi_idiv
	add r0, r4, r0
	ldr r4, [sp, #20]
	ldr r3, [sp, #24]
	mul r4, r4, r3
	sub r0, r0, r4
	ldr r4, [sp, #28]
	add r4, r0, r4
	str r4, [sp, #100]
	ldr r4, [sp, #12]
	ldr r0, [sp, #16]
	mov r1, r0
	mov r0, r4
	bl __aeabi_idiv
	mov r3, r0
	ldr r0, [sp, #4]
	ldr r4, [sp, #8]
	mul r4, r0, r4
	add r3, r3, r4
	ldr r4, [sp, #20]
	ldr r0, [sp, #24]
	mul r4, r4, r0
	sub r4, r3, r4
	ldr r0, [sp, #28]
	add r4, r4, r0
	str r4, [sp, #104]
	ldr r0, [sp, #4]
	ldr r4, [sp, #8]
	add r4, r0, r4
	ldr r0, [sp, #12]
	add r4, r4, r0
	ldr r0, [sp, #16]
	add r0, r4, r0
	ldr r4, [sp, #20]
	add r4, r0, r4
	ldr r0, [sp, #24]
	add r0, r4, r0
	ldr r4, [sp, #28]
	add r4, r0, r4
	ldr r0, [sp, #32]
	add r0, r4, r0
	ldr r4, [sp, #36]
	add r4, r0, r4
	ldr r0, [sp, #40]
	add r0, r4, r0
	ldr r4, [sp, #44]
	add r4, r0, r4
	ldr r0, [sp, #48]
	add r0, r4, r0
	ldr r4, [sp, #52]
	add r0, r0, r4
	ldr r4, [sp, #56]
	add r4, r0, r4
	ldr r0, [sp, #60]
	add r4, r4, r0
	ldr r0, [sp, #64]
	add r4, r4, r0
	ldr r0, [sp, #68]
	add r0, r4, r0
	ldr r4, [sp, #72]
	add r4, r0, r4
	ldr r0, [sp, #76]
	add r0, r4, r0
	ldr r4, [sp, #80]
	add r0, r0, r4
	ldr r4, [sp, #84]
	add r0, r0, r4
	ldr r4, [sp, #88]
	add r4, r0, r4
	ldr r0, [sp, #92]
	add r4, r4, r0
	ldr r0, [sp, #96]
	add r0, r4, r0
	ldr r4, [sp, #100]
	add r0, r0, r4
	ldr r4, [sp, #104]
	add r4, r0, r4
	str r4, [sp, #0]
	b .LU21
.LU21:
	ldr r4, [sp, #0]
	mov r0, r4
	add sp, sp, #108
	pop {r4}
	pop {fp, pc}
	.size commonSubexpressionElimination, .-commonSubexpressionElimination
	.align 2
	.global hoisting
hoisting:
.LU24:
	push {fp, lr}
	add fp, sp, #4
	sub sp, sp, #36
	movw r2, #1
	str r2, [sp, #4]
	movw r2, #2
	str r2, [sp, #8]
	movw r2, #3
	str r2, [sp, #12]
	movw r2, #4
	str r2, [sp, #16]
	movw r2, #0
	str r2, [sp, #32]
	ldr r3, [sp, #32]
	movw r1, #:lower16:1000000
	movt r1, #:upper16:1000000
	mov r2, #0
	cmp r3, r1
	movlt r2, #1
	cmp r2, #1
	beq .LU25
	b .LU26
.LU25:
	movw r2, #5
	str r2, [sp, #20]
	ldr r2, [sp, #4]
	ldr r3, [sp, #8]
	add r3, r2, r3
	ldr r2, [sp, #12]
	add r2, r3, r2
	str r2, [sp, #24]
	ldr r2, [sp, #12]
	ldr r3, [sp, #16]
	add r2, r2, r3
	ldr r3, [sp, #24]
	add r2, r2, r3
	str r2, [sp, #28]
	ldr r2, [sp, #32]
	add r2, r2, #1
	str r2, [sp, #32]
	ldr r3, [sp, #32]
	movw r1, #:lower16:1000000
	movt r1, #:upper16:1000000
	mov r2, #0
	cmp r3, r1
	movlt r2, #1
	cmp r2, #1
	beq .LU25
	b .LU26
.LU26:
	ldr r2, [sp, #8]
	str r2, [sp, #0]
	b .LU23
.LU23:
	ldr r2, [sp, #0]
	mov r0, r2
	add sp, sp, #36
	pop {fp, pc}
	.size hoisting, .-hoisting
	.align 2
	.global doubleIf
doubleIf:
.LU28:
	push {fp, lr}
	add fp, sp, #4
	sub sp, sp, #20
	movw r2, #1
	str r2, [sp, #4]
	movw r2, #2
	str r2, [sp, #8]
	movw r2, #3
	str r2, [sp, #12]
	movw r2, #0
	str r2, [sp, #16]
	ldr r3, [sp, #4]
	mov r2, #0
	cmp r3, #1
	moveq r2, #1
	cmp r2, #1
	beq .LU29
	b .LU30
.LU29:
	movw r2, #20
	str r2, [sp, #8]
	ldr r2, [sp, #4]
	mov r3, #0
	cmp r2, #1
	moveq r3, #1
	cmp r3, #1
	beq .LU31
	b .LU32
.LU31:
	movw r2, #200
	str r2, [sp, #8]
	movw r2, #300
	str r2, [sp, #12]
	b .LU33
.LU32:
	movw r2, #1
	str r2, [sp, #4]
	movw r2, #2
	str r2, [sp, #8]
	movw r2, #3
	str r2, [sp, #12]
	b .LU33
.LU33:
	movw r2, #50
	str r2, [sp, #16]
	b .LU30
.LU30:
	ldr r2, [sp, #16]
	str r2, [sp, #0]
	b .LU27
.LU27:
	ldr r2, [sp, #0]
	mov r0, r2
	add sp, sp, #20
	pop {fp, pc}
	.size doubleIf, .-doubleIf
	.align 2
	.global integerDivide
integerDivide:
.LU35:
	push {fp, lr}
	add fp, sp, #4
	sub sp, sp, #8
	movw r2, #3000
	str r2, [sp, #4]
	ldr r2, [sp, #4]
	movw r1, #2
	mov r0, r2
	bl __aeabi_idiv
	mov r2, r0
	str r2, [sp, #4]
	ldr r3, [sp, #4]
	movw r2, #4
	mul r2, r3, r2
	str r2, [sp, #4]
	ldr r2, [sp, #4]
	movw r1, #8
	mov r0, r2
	bl __aeabi_idiv
	mov r2, r0
	str r2, [sp, #4]
	ldr r2, [sp, #4]
	movw r1, #16
	mov r0, r2
	bl __aeabi_idiv
	mov r2, r0
	str r2, [sp, #4]
	ldr r2, [sp, #4]
	movw r3, #32
	mul r2, r2, r3
	str r2, [sp, #4]
	ldr r2, [sp, #4]
	movw r1, #64
	mov r0, r2
	bl __aeabi_idiv
	mov r2, r0
	str r2, [sp, #4]
	ldr r3, [sp, #4]
	movw r2, #128
	mul r2, r3, r2
	str r2, [sp, #4]
	ldr r2, [sp, #4]
	movw r1, #4
	mov r0, r2
	bl __aeabi_idiv
	mov r2, r0
	str r2, [sp, #4]
	ldr r2, [sp, #4]
	str r2, [sp, #0]
	b .LU34
.LU34:
	ldr r2, [sp, #0]
	mov r0, r2
	add sp, sp, #8
	pop {fp, pc}
	.size integerDivide, .-integerDivide
	.align 2
	.global association
association:
.LU37:
	push {fp, lr}
	add fp, sp, #4
	sub sp, sp, #8
	movw r2, #10
	str r2, [sp, #4]
	ldr r2, [sp, #4]
	movw r0, #2
	mul r2, r2, r0
	str r2, [sp, #4]
	ldr r2, [sp, #4]
	movw r1, #2
	mov r0, r2
	bl __aeabi_idiv
	mov r2, r0
	str r2, [sp, #4]
	ldr r2, [sp, #4]
	movw r0, #3
	mul r2, r0, r2
	str r2, [sp, #4]
	ldr r2, [sp, #4]
	movw r1, #3
	mov r0, r2
	bl __aeabi_idiv
	mov r2, r0
	str r2, [sp, #4]
	ldr r0, [sp, #4]
	movw r2, #4
	mul r2, r0, r2
	str r2, [sp, #4]
	ldr r2, [sp, #4]
	movw r1, #4
	mov r0, r2
	bl __aeabi_idiv
	mov r2, r0
	str r2, [sp, #4]
	ldr r2, [sp, #4]
	add r2, r2, #4
	str r2, [sp, #4]
	ldr r2, [sp, #4]
	sub r2, r2, #4
	str r2, [sp, #4]
	ldr r0, [sp, #4]
	movw r2, #50
	mul r2, r0, r2
	str r2, [sp, #4]
	ldr r2, [sp, #4]
	movw r1, #50
	mov r0, r2
	bl __aeabi_idiv
	mov r2, r0
	str r2, [sp, #4]
	ldr r2, [sp, #4]
	str r2, [sp, #0]
	b .LU36
.LU36:
	ldr r2, [sp, #0]
	mov r0, r2
	add sp, sp, #8
	pop {fp, pc}
	.size association, .-association
	.align 2
	.global tailRecursionHelper
tailRecursionHelper:
.LU39:
	push {fp, lr}
	add fp, sp, #4
	sub sp, sp, #12
	mov r3, r0
	mov r0, r1
	str r3, [sp, #0]
	str r0, [sp, #4]
	ldr r0, [sp, #0]
	mov r3, #0
	cmp r0, #0
	moveq r3, #1
	cmp r3, #1
	beq .LU40
	b .LU41
.LU40:
	ldr r3, [sp, #4]
	str r3, [sp, #8]
	b .LU38
.LU41:
	ldr r3, [sp, #0]
	sub r3, r3, #1
	ldr r0, [sp, #4]
	ldr r2, [sp, #0]
	add r0, r0, r2
	mov r1, r0
	mov r0, r3
	bl tailRecursionHelper
	mov r3, r0
	str r3, [sp, #8]
	b .LU38
.LU42:
	b .LU38
.LU38:
	ldr r3, [sp, #8]
	mov r0, r3
	add sp, sp, #12
	pop {fp, pc}
	.size tailRecursionHelper, .-tailRecursionHelper
	.align 2
	.global tailRecursion
tailRecursion:
.LU44:
	push {fp, lr}
	add fp, sp, #4
	sub sp, sp, #8
	mov r2, r0
	str r2, [sp, #0]
	ldr r2, [sp, #0]
	movw r1, #0
	mov r0, r2
	bl tailRecursionHelper
	mov r2, r0
	str r2, [sp, #4]
	b .LU43
.LU43:
	ldr r2, [sp, #4]
	mov r0, r2
	add sp, sp, #8
	pop {fp, pc}
	.size tailRecursion, .-tailRecursion
	.align 2
	.global unswitching
unswitching:
.LU46:
	push {fp, lr}
	add fp, sp, #4
	sub sp, sp, #12
	movw r2, #1
	str r2, [sp, #4]
	movw r2, #2
	str r2, [sp, #8]
	ldr r2, [sp, #4]
	movw r1, #:lower16:1000000
	movt r1, #:upper16:1000000
	mov r0, #0
	cmp r2, r1
	movlt r0, #1
	cmp r0, #1
	beq .LU47
	b .LU48
.LU47:
	ldr r0, [sp, #8]
	mov r2, #0
	cmp r0, #2
	moveq r2, #1
	cmp r2, #1
	beq .LU49
	b .LU50
.LU49:
	ldr r2, [sp, #4]
	add r2, r2, #1
	str r2, [sp, #4]
	b .LU51
.LU50:
	ldr r2, [sp, #4]
	add r2, r2, #2
	str r2, [sp, #4]
	b .LU51
.LU51:
	ldr r1, [sp, #4]
	movw r0, #:lower16:1000000
	movt r0, #:upper16:1000000
	mov r2, #0
	cmp r1, r0
	movlt r2, #1
	cmp r2, #1
	beq .LU47
	b .LU48
.LU48:
	ldr r2, [sp, #4]
	str r2, [sp, #0]
	b .LU45
.LU45:
	ldr r2, [sp, #0]
	mov r0, r2
	add sp, sp, #12
	pop {fp, pc}
	.size unswitching, .-unswitching
	.align 2
	.global randomCalculation
randomCalculation:
.LU53:
	push {fp, lr}
	add fp, sp, #4
	sub sp, sp, #36
	mov r2, r0
	str r2, [sp, #0]
	movw r2, #0
	str r2, [sp, #28]
	movw r2, #0
	str r2, [sp, #32]
	ldr r2, [sp, #28]
	ldr r0, [sp, #0]
	mov r3, #0
	cmp r2, r0
	movlt r3, #1
	cmp r3, #1
	beq .LU54
	b .LU55
.LU54:
	movw r2, #4
	str r2, [sp, #8]
	movw r2, #7
	str r2, [sp, #12]
	movw r2, #8
	str r2, [sp, #16]
	ldr r2, [sp, #8]
	ldr r0, [sp, #12]
	add r2, r2, r0
	str r2, [sp, #20]
	ldr r2, [sp, #20]
	ldr r0, [sp, #16]
	add r2, r2, r0
	str r2, [sp, #24]
	ldr r0, [sp, #32]
	ldr r2, [sp, #24]
	add r2, r0, r2
	str r2, [sp, #32]
	ldr r0, [sp, #28]
	movw r2, #2
	mul r2, r0, r2
	str r2, [sp, #28]
	ldr r2, [sp, #28]
	movw r1, #2
	mov r0, r2
	bl __aeabi_idiv
	mov r2, r0
	str r2, [sp, #28]
	ldr r0, [sp, #28]
	movw r2, #3
	mul r2, r2, r0
	str r2, [sp, #28]
	ldr r2, [sp, #28]
	movw r1, #3
	mov r0, r2
	bl __aeabi_idiv
	mov r2, r0
	str r2, [sp, #28]
	ldr r0, [sp, #28]
	movw r2, #4
	mul r2, r0, r2
	str r2, [sp, #28]
	ldr r2, [sp, #28]
	movw r1, #4
	mov r0, r2
	bl __aeabi_idiv
	mov r2, r0
	str r2, [sp, #28]
	ldr r2, [sp, #28]
	add r2, r2, #1
	str r2, [sp, #28]
	ldr r0, [sp, #28]
	ldr r3, [sp, #0]
	mov r2, #0
	cmp r0, r3
	movlt r2, #1
	cmp r2, #1
	beq .LU54
	b .LU55
.LU55:
	ldr r2, [sp, #32]
	str r2, [sp, #4]
	b .LU52
.LU52:
	ldr r2, [sp, #4]
	mov r0, r2
	add sp, sp, #36
	pop {fp, pc}
	.size randomCalculation, .-randomCalculation
	.align 2
	.global iterativeFibonacci
iterativeFibonacci:
.LU57:
	push {fp, lr}
	add fp, sp, #4
	sub sp, sp, #24
	mov r2, r0
	str r2, [sp, #0]
	movw r2, #0
	sub r2, r2, #1
	str r2, [sp, #8]
	movw r2, #1
	str r2, [sp, #12]
	movw r2, #0
	str r2, [sp, #16]
	ldr r0, [sp, #16]
	ldr r2, [sp, #0]
	mov r1, #0
	cmp r0, r2
	movlt r1, #1
	cmp r1, #1
	beq .LU58
	b .LU59
.LU58:
	ldr r0, [sp, #12]
	ldr r2, [sp, #8]
	add r2, r0, r2
	str r2, [sp, #20]
	ldr r2, [sp, #12]
	str r2, [sp, #8]
	ldr r2, [sp, #20]
	str r2, [sp, #12]
	ldr r2, [sp, #16]
	add r2, r2, #1
	str r2, [sp, #16]
	ldr r1, [sp, #16]
	ldr r0, [sp, #0]
	mov r2, #0
	cmp r1, r0
	movlt r2, #1
	cmp r2, #1
	beq .LU58
	b .LU59
.LU59:
	ldr r2, [sp, #12]
	str r2, [sp, #4]
	b .LU56
.LU56:
	ldr r2, [sp, #4]
	mov r0, r2
	add sp, sp, #24
	pop {fp, pc}
	.size iterativeFibonacci, .-iterativeFibonacci
	.align 2
	.global recursiveFibonacci
recursiveFibonacci:
.LU61:
	push {fp, lr}
	add fp, sp, #4
	push {r4}
	sub sp, sp, #8
	mov r2, r0
	str r2, [sp, #0]
	ldr r2, [sp, #0]
	mov r0, #0
	cmp r2, #0
	movle r0, #1
	ldr r3, [sp, #0]
	mov r2, #0
	cmp r3, #1
	moveq r2, #1
	orr r2, r0, r2
	cmp r2, #1
	beq .LU62
	b .LU63
.LU62:
	ldr r2, [sp, #0]
	str r2, [sp, #4]
	b .LU60
.LU63:
	ldr r2, [sp, #0]
	sub r2, r2, #1
	mov r0, r2
	bl recursiveFibonacci
	mov r4, r0
	ldr r2, [sp, #0]
	sub r2, r2, #2
	mov r0, r2
	bl recursiveFibonacci
	mov r2, r0
	add r2, r4, r2
	str r2, [sp, #4]
	b .LU60
.LU64:
	b .LU60
.LU60:
	ldr r2, [sp, #4]
	mov r0, r2
	add sp, sp, #8
	pop {r4}
	pop {fp, pc}
	.size recursiveFibonacci, .-recursiveFibonacci
	.align 2
	.global main
main:
.LU66:
	push {fp, lr}
	add fp, sp, #4
	sub sp, sp, #16
	add r1, sp, #4
	movw r0, #:lower16:.READ_FMT
	movt r0, #:upper16:.READ_FMT
	bl scanf
	movw r0, #1
	str r0, [sp, #12]
	ldr r0, [sp, #12]
	ldr r1, [sp, #4]
	mov r2, #0
	cmp r0, r1
	movlt r2, #1
	cmp r2, #1
	beq .LU67
	b .LU68
.LU67:
	bl constantFolding
	str r0, [sp, #8]
	ldr r0, [sp, #8]
	mov r1, r0
	movw r0, #:lower16:.PRINTLN_FMT
	movt r0, #:upper16:.PRINTLN_FMT
	bl printf
	bl constantPropagation
	str r0, [sp, #8]
	ldr r0, [sp, #8]
	mov r1, r0
	movw r0, #:lower16:.PRINTLN_FMT
	movt r0, #:upper16:.PRINTLN_FMT
	bl printf
	bl deadCodeElimination
	str r0, [sp, #8]
	ldr r0, [sp, #8]
	mov r1, r0
	movw r0, #:lower16:.PRINTLN_FMT
	movt r0, #:upper16:.PRINTLN_FMT
	bl printf
	bl interProceduralOptimization
	str r0, [sp, #8]
	ldr r0, [sp, #8]
	mov r1, r0
	movw r0, #:lower16:.PRINTLN_FMT
	movt r0, #:upper16:.PRINTLN_FMT
	bl printf
	bl commonSubexpressionElimination
	str r0, [sp, #8]
	ldr r0, [sp, #8]
	mov r1, r0
	movw r0, #:lower16:.PRINTLN_FMT
	movt r0, #:upper16:.PRINTLN_FMT
	bl printf
	bl hoisting
	str r0, [sp, #8]
	ldr r0, [sp, #8]
	mov r1, r0
	movw r0, #:lower16:.PRINTLN_FMT
	movt r0, #:upper16:.PRINTLN_FMT
	bl printf
	bl doubleIf
	str r0, [sp, #8]
	ldr r0, [sp, #8]
	mov r1, r0
	movw r0, #:lower16:.PRINTLN_FMT
	movt r0, #:upper16:.PRINTLN_FMT
	bl printf
	bl integerDivide
	str r0, [sp, #8]
	ldr r0, [sp, #8]
	mov r1, r0
	movw r0, #:lower16:.PRINTLN_FMT
	movt r0, #:upper16:.PRINTLN_FMT
	bl printf
	bl association
	str r0, [sp, #8]
	ldr r0, [sp, #8]
	mov r1, r0
	movw r0, #:lower16:.PRINTLN_FMT
	movt r0, #:upper16:.PRINTLN_FMT
	bl printf
	ldr r0, [sp, #4]
	movw r1, #1000
	bl __aeabi_idiv
	bl tailRecursion
	str r0, [sp, #8]
	ldr r0, [sp, #8]
	mov r1, r0
	movw r0, #:lower16:.PRINTLN_FMT
	movt r0, #:upper16:.PRINTLN_FMT
	bl printf
	bl unswitching
	str r0, [sp, #8]
	ldr r0, [sp, #8]
	mov r1, r0
	movw r0, #:lower16:.PRINTLN_FMT
	movt r0, #:upper16:.PRINTLN_FMT
	bl printf
	ldr r0, [sp, #4]
	bl randomCalculation
	str r0, [sp, #8]
	ldr r0, [sp, #8]
	mov r1, r0
	movw r0, #:lower16:.PRINTLN_FMT
	movt r0, #:upper16:.PRINTLN_FMT
	bl printf
	ldr r0, [sp, #4]
	movw r1, #5
	bl __aeabi_idiv
	bl iterativeFibonacci
	str r0, [sp, #8]
	ldr r0, [sp, #8]
	mov r1, r0
	movw r0, #:lower16:.PRINTLN_FMT
	movt r0, #:upper16:.PRINTLN_FMT
	bl printf
	ldr r0, [sp, #4]
	movw r1, #1000
	bl __aeabi_idiv
	bl recursiveFibonacci
	str r0, [sp, #8]
	ldr r0, [sp, #8]
	mov r1, r0
	movw r0, #:lower16:.PRINTLN_FMT
	movt r0, #:upper16:.PRINTLN_FMT
	bl printf
	ldr r0, [sp, #12]
	add r0, r0, #1
	str r0, [sp, #12]
	ldr r2, [sp, #12]
	ldr r0, [sp, #4]
	mov r1, #0
	cmp r2, r0
	movlt r1, #1
	cmp r1, #1
	beq .LU67
	b .LU68
.LU68:
	movw r1, #9999
	movw r0, #:lower16:.PRINTLN_FMT
	movt r0, #:upper16:.PRINTLN_FMT
	bl printf
	movw r0, #0
	str r0, [sp, #0]
	b .LU65
.LU65:
	ldr r0, [sp, #0]
	add sp, sp, #16
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
