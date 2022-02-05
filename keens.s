	.arch armv7-a
	.comm	globalfoo,4,4

	.text
	.align 2
	.global tailrecursive
tailrecursive:
.LU1:
	push {fp, lr}
	add fp, sp, #4
	mov %num, r0
	mov %_u0, #0
	cmp %num, #0
	movle %_u0, #1
	cmp %_u0, #1
	beq .LU2
	b .LU3
.LU2:
	b .LU0
.LU3:
	b .LU4
.LU4:
	sub %_u1, %num, #1
	mov r0, %_u1
	bl tailrecursive
	b .LU0
.LU0:
	pop {fp, pc}
	.size tailrecursive, .-tailrecursive
	.align 2
	.global add
add:
.LU6:
	push {fp, lr}
	add fp, sp, #4
	mov %x, r0
	mov %y, r1
	add %_u3, %x, %y
	b .LU5
.LU5:
	mov r0, %_u3
	pop {fp, pc}
	.size add, .-add
	.align 2
	.global domath
domath:
.LU8:
	push {fp, lr}
	add fp, sp, #4
	mov %num, r0
	movw r0, #12
	bl malloc
	mov %_u4, r0
	mov %_u5, %_u4
	movw r0, #4
	bl malloc
	mov %_u6, r0
	mov %_u7, %_u6
	add %_u8, %_u5, #8
	str %_u7, [%_u8]
	movw r0, #12
	bl malloc
	mov %_u9, r0
	mov %_u10, %_u9
	movw r0, #4
	bl malloc
	mov %_u11, r0
	mov %_u12, %_u11
	add %_u13, %_u10, #8
	str %_u12, [%_u13]
	mov %_u14, %_u5
	str %num, [%_u14]
	mov %_u15, %_u10
	movw %t0, #3
	str %t0, [%_u15]
	mov %_u16, %_u5
	ldr %_u17, [%_u16]
	add %_u18, %_u5, #8
	ldr %_u19, [%_u18]
	mov %_u20, %_u19
	str %_u17, [%_u20]
	mov %_u21, %_u10
	ldr %_u22, [%_u21]
	add %_u23, %_u10, #8
	ldr %_u24, [%_u23]
	mov %_u25, %_u24
	str %_u22, [%_u25]
	mov %_phi0, %num
	mov %_phi1, %_u10
	mov %_phi2, %_u5
	mov %_phi3, %_u10
	mov %_phi4, %_u5
	mov %_u26, #0
	cmp %num, #0
	movgt %_u26, #1
	cmp %_u26, #1
	beq .LU9
	b .LU10
.LU9:
	mov %num0, %_phi0
	mov %math20, %_phi1
	mov %math10, %_phi2
	mov %_u27, %math10
	ldr %_u28, [%_u27]
	mov %_u29, %math20
	ldr %_u30, [%_u29]
	mul %_u31, %_u28, %_u30
	add %_u32, %math10, #8
	ldr %_u33, [%_u32]
	mov %_u34, %_u33
	ldr %_u35, [%_u34]
	mul %_u36, %_u31, %_u35
	mov %_u37, %math20
	ldr %_u38, [%_u37]
	mov r1, %_u38
	mov r0, %_u36
	bl __aeabi_idiv
	mov %_u39, r0
	add %_u40, %math20, #8
	ldr %_u41, [%_u40]
	mov %_u42, %_u41
	ldr %_u43, [%_u42]
	mov %_u44, %math10
	ldr %_u45, [%_u44]
	mov r1, %_u45
	mov r0, %_u43
	bl add
	mov %_u46, r0
	mov %_u47, %math20
	ldr %_u48, [%_u47]
	mov %_u49, %math10
	ldr %_u50, [%_u49]
	sub %_u51, %_u48, %_u50
	sub %_u52, %num0, #1
	mov %_phi0, %_u52
	mov %_phi1, %math20
	mov %_phi2, %math10
	mov %_phi3, %math20
	mov %_phi4, %math10
	mov %_u53, #0
	cmp %_u52, #0
	movgt %_u53, #1
	cmp %_u53, #1
	beq .LU9
	b .LU10
.LU10:
	mov %math21, %_phi3
	mov %math11, %_phi4
	mov %_u54, %math11
	mov r0, %_u54
	bl free
	mov %_u55, %math21
	mov r0, %_u55
	bl free
	b .LU7
.LU7:
	pop {fp, pc}
	.size domath, .-domath
	.align 2
	.global objinstantiation
objinstantiation:
.LU12:
	push {fp, lr}
	add fp, sp, #4
	mov %num, r0
	mov %_phi5, %num
	mov %_u56, #0
	cmp %num, #0
	movgt %_u56, #1
	cmp %_u56, #1
	beq .LU13
	b .LU14
.LU13:
	mov %num0, %_phi5
	movw r0, #12
	bl malloc
	mov %_u57, r0
	mov %_u58, %_u57
	mov %_u59, %_u58
	mov r0, %_u59
	bl free
	sub %_u60, %num0, #1
	mov %_phi5, %_u60
	mov %_u61, #0
	cmp %_u60, #0
	movgt %_u61, #1
	cmp %_u61, #1
	beq .LU13
	b .LU14
.LU14:
	b .LU11
.LU11:
	pop {fp, pc}
	.size objinstantiation, .-objinstantiation
	.align 2
	.global ackermann
ackermann:
.LU16:
	push {fp, lr}
	add fp, sp, #4
	mov %m, r0
	mov %n, r1
	mov %_u62, #0
	cmp %m, #0
	moveq %_u62, #1
	cmp %_u62, #1
	beq .LU17
	b .LU18
.LU17:
	add %_u63, %n, #1
	mov %_phi6, %_u63
	b .LU15
.LU18:
	b .LU19
.LU19:
	mov %_u64, #0
	cmp %n, #0
	moveq %_u64, #1
	cmp %_u64, #1
	beq .LU20
	b .LU21
.LU20:
	sub %_u65, %m, #1
	movw r1, #1
	mov r0, %_u65
	bl ackermann
	mov %_u66, r0
	mov %_phi6, %_u66
	b .LU15
.LU21:
	sub %_u67, %m, #1
	sub %_u68, %n, #1
	mov r1, %_u68
	mov r0, %m
	bl ackermann
	mov %_u69, r0
	mov r1, %_u69
	mov r0, %_u67
	bl ackermann
	mov %_u70, r0
	mov %_phi6, %_u70
	b .LU15
.LU15:
	mov %_retval_0, %_phi6
	mov r0, %_retval_0
	pop {fp, pc}
	.size ackermann, .-ackermann
	.align 2
	.global main
main:
.LU23:
	push {fp, lr}
	add fp, sp, #4
	movw r1, #:lower16:.read_scratch
	movt r1, #:upper16:.read_scratch
	movw r0, #:lower16:.READ_FMT
	movt r0, #:upper16:.READ_FMT
	bl scanf
	movw %_u71, #:lower16:.read_scratch
	movt %_u71, #:upper16:.read_scratch
	ldr %_u71, [%_u71]
	movw r1, #:lower16:.read_scratch
	movt r1, #:upper16:.read_scratch
	movw r0, #:lower16:.READ_FMT
	movt r0, #:upper16:.READ_FMT
	bl scanf
	movw %_u72, #:lower16:.read_scratch
	movt %_u72, #:upper16:.read_scratch
	ldr %_u72, [%_u72]
	movw r1, #:lower16:.read_scratch
	movt r1, #:upper16:.read_scratch
	movw r0, #:lower16:.READ_FMT
	movt r0, #:upper16:.READ_FMT
	bl scanf
	movw %_u73, #:lower16:.read_scratch
	movt %_u73, #:upper16:.read_scratch
	ldr %_u73, [%_u73]
	movw r1, #:lower16:.read_scratch
	movt r1, #:upper16:.read_scratch
	movw r0, #:lower16:.READ_FMT
	movt r0, #:upper16:.READ_FMT
	bl scanf
	movw %_u74, #:lower16:.read_scratch
	movt %_u74, #:upper16:.read_scratch
	ldr %_u74, [%_u74]
	movw r1, #:lower16:.read_scratch
	movt r1, #:upper16:.read_scratch
	movw r0, #:lower16:.READ_FMT
	movt r0, #:upper16:.READ_FMT
	bl scanf
	movw %_u75, #:lower16:.read_scratch
	movt %_u75, #:upper16:.read_scratch
	ldr %_u75, [%_u75]
	mov r0, %_u71
	bl tailrecursive
	mov r1, %_u71
	movw r0, #:lower16:.PRINTLN_FMT
	movt r0, #:upper16:.PRINTLN_FMT
	bl printf
	mov r0, %_u72
	bl domath
	mov r1, %_u72
	movw r0, #:lower16:.PRINTLN_FMT
	movt r0, #:upper16:.PRINTLN_FMT
	bl printf
	mov r0, %_u73
	bl objinstantiation
	mov r1, %_u73
	movw r0, #:lower16:.PRINTLN_FMT
	movt r0, #:upper16:.PRINTLN_FMT
	bl printf
	mov r1, %_u75
	mov r0, %_u74
	bl ackermann
	mov %_u79, r0
	mov r1, %_u79
	movw r0, #:lower16:.PRINTLN_FMT
	movt r0, #:upper16:.PRINTLN_FMT
	bl printf
	b .LU22
.LU22:
	movw r0, #0
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
	.comm	.read_scratch,4,4
	.global	__aeabi_idiv
