	.arch armv7-a
	.comm	.read_scratch,4,4
	.comm	gi1,4,4
	.comm	gb1,4,4
	.comm	gs1,4,4
	.comm	counter,4,4

	.text
	.align 2
	.global printgroup
printgroup:
.LU1:
	push {fp, lr}
	add fp, sp, #4
	push {r4}
	mov r4, r0
	movw r1, #1
	movw r0, #:lower16:.PRINT_FMT
	movt r0, #:upper16:.PRINT_FMT
	bl printf
	movw r1, #0
	movw r0, #:lower16:.PRINT_FMT
	movt r0, #:upper16:.PRINT_FMT
	bl printf
	movw r1, #1
	movw r0, #:lower16:.PRINT_FMT
	movt r0, #:upper16:.PRINT_FMT
	bl printf
	movw r1, #0
	movw r0, #:lower16:.PRINT_FMT
	movt r0, #:upper16:.PRINT_FMT
	bl printf
	movw r1, #1
	movw r0, #:lower16:.PRINT_FMT
	movt r0, #:upper16:.PRINT_FMT
	bl printf
	movw r1, #0
	movw r0, #:lower16:.PRINT_FMT
	movt r0, #:upper16:.PRINT_FMT
	bl printf
	mov r1, r4
	movw r0, #:lower16:.PRINTLN_FMT
	movt r0, #:upper16:.PRINTLN_FMT
	bl printf
	b .LU0
.LU0:
	pop {r4}
	pop {fp, pc}
	.size printgroup, .-printgroup
	.align 2
	.global setcounter
setcounter:
.LU3:
	push {fp, lr}
	add fp, sp, #4
	movw r2, #:lower16:counter
	movt r2, #:upper16:counter
	str r0, [r2]
	movw r2, #1
	b .LU2
.LU2:
	mov r0, r2
	pop {fp, pc}
	.size setcounter, .-setcounter
	.align 2
	.global takealltypes
takealltypes:
.LU5:
	push {fp, lr}
	add fp, sp, #4
	push {r4, r5}
	mov r5, r1
	mov r4, r2
	mov r1, #0
	cmp r0, #3
	moveq r1, #1
	cmp r1, #1
	beq .LU6
	b .LU7
.LU6:
	movw r1, #1
	movw r0, #:lower16:.PRINTLN_FMT
	movt r0, #:upper16:.PRINTLN_FMT
	bl printf
	b .LU8
.LU7:
	movw r1, #0
	movw r0, #:lower16:.PRINTLN_FMT
	movt r0, #:upper16:.PRINTLN_FMT
	bl printf
	b .LU8
.LU8:
	cmp r5, #1
	beq .LU9
	b .LU10
.LU9:
	movw r1, #1
	movw r0, #:lower16:.PRINTLN_FMT
	movt r0, #:upper16:.PRINTLN_FMT
	bl printf
	b .LU11
.LU10:
	movw r1, #0
	movw r0, #:lower16:.PRINTLN_FMT
	movt r0, #:upper16:.PRINTLN_FMT
	bl printf
	b .LU11
.LU11:
	add r4, r4, #4
	ldr r4, [r4]
	cmp r4, #1
	beq .LU12
	b .LU13
.LU12:
	movw r1, #1
	movw r0, #:lower16:.PRINTLN_FMT
	movt r0, #:upper16:.PRINTLN_FMT
	bl printf
	b .LU14
.LU13:
	movw r1, #0
	movw r0, #:lower16:.PRINTLN_FMT
	movt r0, #:upper16:.PRINTLN_FMT
	bl printf
	b .LU14
.LU14:
	b .LU4
.LU4:
	pop {r4, r5}
	pop {fp, pc}
	.size takealltypes, .-takealltypes
	.align 2
	.global tonofargs
tonofargs:
.LU16:
	push {fp, lr}
	add fp, sp, #4
	push {r4, r5, r6, r7}
	ldr r7, [fp, #4]
	ldr r5, [fp, #8]
	ldr r6, [fp, #12]
	ldr r4, [fp, #16]
	mov r1, #0
	cmp r7, #5
	moveq r1, #1
	cmp r1, #1
	beq .LU17
	b .LU18
.LU17:
	movw r1, #1
	movw r0, #:lower16:.PRINTLN_FMT
	movt r0, #:upper16:.PRINTLN_FMT
	bl printf
	mov r1, r5
	mov r0, r6
	mov r2, r4
	b .LU19
.LU18:
	movw r1, #0
	movw r0, #:lower16:.PRINT_FMT
	movt r0, #:upper16:.PRINT_FMT
	bl printf
	mov r1, r7
	movw r0, #:lower16:.PRINTLN_FMT
	movt r0, #:upper16:.PRINTLN_FMT
	bl printf
	mov r1, r5
	mov r0, r6
	mov r2, r4
	b .LU19
.LU19:
	mov r4, r2
	mov r6, r0
	mov r5, r1
	mov r1, #0
	cmp r5, #6
	moveq r1, #1
	cmp r1, #1
	beq .LU20
	b .LU21
.LU20:
	movw r1, #1
	movw r0, #:lower16:.PRINTLN_FMT
	movt r0, #:upper16:.PRINTLN_FMT
	bl printf
	mov r2, r6
	mov r1, r4
	b .LU22
.LU21:
	movw r1, #0
	movw r0, #:lower16:.PRINT_FMT
	movt r0, #:upper16:.PRINT_FMT
	bl printf
	mov r1, r5
	movw r0, #:lower16:.PRINTLN_FMT
	movt r0, #:upper16:.PRINTLN_FMT
	bl printf
	mov r2, r6
	mov r1, r4
	b .LU22
.LU22:
	mov r4, r1
	mov r5, r2
	mov r1, #0
	cmp r5, #7
	moveq r1, #1
	cmp r1, #1
	beq .LU23
	b .LU24
.LU23:
	movw r1, #1
	movw r0, #:lower16:.PRINTLN_FMT
	movt r0, #:upper16:.PRINTLN_FMT
	bl printf
	mov r1, r4
	b .LU25
.LU24:
	movw r1, #0
	movw r0, #:lower16:.PRINT_FMT
	movt r0, #:upper16:.PRINT_FMT
	bl printf
	mov r1, r5
	movw r0, #:lower16:.PRINTLN_FMT
	movt r0, #:upper16:.PRINTLN_FMT
	bl printf
	mov r1, r4
	b .LU25
.LU25:
	mov r4, r1
	mov r1, #0
	cmp r4, #8
	moveq r1, #1
	cmp r1, #1
	beq .LU26
	b .LU27
.LU26:
	movw r1, #1
	movw r0, #:lower16:.PRINTLN_FMT
	movt r0, #:upper16:.PRINTLN_FMT
	bl printf
	b .LU28
.LU27:
	movw r1, #0
	movw r0, #:lower16:.PRINT_FMT
	movt r0, #:upper16:.PRINT_FMT
	bl printf
	mov r1, r4
	movw r0, #:lower16:.PRINTLN_FMT
	movt r0, #:upper16:.PRINTLN_FMT
	bl printf
	b .LU28
.LU28:
	b .LU15
.LU15:
	pop {r4, r5, r6, r7}
	pop {fp, pc}
	.size tonofargs, .-tonofargs
	.align 2
	.global returnint
returnint:
.LU30:
	push {fp, lr}
	add fp, sp, #4
	mov r2, r0
	b .LU29
.LU29:
	mov r0, r2
	pop {fp, pc}
	.size returnint, .-returnint
	.align 2
	.global returnbool
returnbool:
.LU32:
	push {fp, lr}
	add fp, sp, #4
	mov r2, r0
	b .LU31
.LU31:
	mov r0, r2
	pop {fp, pc}
	.size returnbool, .-returnbool
	.align 2
	.global returnstruct
returnstruct:
.LU34:
	push {fp, lr}
	add fp, sp, #4
	mov r2, r0
	b .LU33
.LU33:
	mov r0, r2
	pop {fp, pc}
	.size returnstruct, .-returnstruct
	.align 2
	.global main
main:
.LU36:
	push {fp, lr}
	add fp, sp, #4
	push {r4, r5}
	sub sp, sp, #16
	movw r2, #0
	movw r4, #:lower16:counter
	movt r4, #:upper16:counter
	str r2, [r4]
	movw r0, #1
	bl printgroup
	movw r2, #0
	movw r4, #0
	and r4, r2, r4
	cmp r4, #1
	beq .LU37
	b .LU38
.LU37:
	movw r1, #0
	movw r0, #:lower16:.PRINTLN_FMT
	movt r0, #:upper16:.PRINTLN_FMT
	bl printf
	b .LU39
.LU38:
	movw r1, #1
	movw r0, #:lower16:.PRINTLN_FMT
	movt r0, #:upper16:.PRINTLN_FMT
	bl printf
	b .LU39
.LU39:
	movw r2, #1
	movw r4, #0
	and r4, r2, r4
	cmp r4, #1
	beq .LU40
	b .LU41
.LU40:
	movw r1, #0
	movw r0, #:lower16:.PRINTLN_FMT
	movt r0, #:upper16:.PRINTLN_FMT
	bl printf
	b .LU42
.LU41:
	movw r1, #1
	movw r0, #:lower16:.PRINTLN_FMT
	movt r0, #:upper16:.PRINTLN_FMT
	bl printf
	b .LU42
.LU42:
	movw r2, #0
	movw r4, #1
	and r4, r2, r4
	cmp r4, #1
	beq .LU43
	b .LU44
.LU43:
	movw r1, #0
	movw r0, #:lower16:.PRINTLN_FMT
	movt r0, #:upper16:.PRINTLN_FMT
	bl printf
	b .LU45
.LU44:
	movw r1, #1
	movw r0, #:lower16:.PRINTLN_FMT
	movt r0, #:upper16:.PRINTLN_FMT
	bl printf
	b .LU45
.LU45:
	movw r2, #1
	movw r4, #1
	and r4, r2, r4
	cmp r4, #1
	beq .LU46
	b .LU47
.LU46:
	movw r1, #1
	movw r0, #:lower16:.PRINTLN_FMT
	movt r0, #:upper16:.PRINTLN_FMT
	bl printf
	b .LU48
.LU47:
	movw r1, #0
	movw r0, #:lower16:.PRINTLN_FMT
	movt r0, #:upper16:.PRINTLN_FMT
	bl printf
	b .LU48
.LU48:
	movw r4, #0
	movw r2, #:lower16:counter
	movt r2, #:upper16:counter
	str r4, [r2]
	movw r0, #2
	bl printgroup
	movw r4, #1
	movw r2, #1
	orr r4, r4, r2
	cmp r4, #1
	beq .LU49
	b .LU50
.LU49:
	movw r1, #1
	movw r0, #:lower16:.PRINTLN_FMT
	movt r0, #:upper16:.PRINTLN_FMT
	bl printf
	b .LU51
.LU50:
	movw r1, #0
	movw r0, #:lower16:.PRINTLN_FMT
	movt r0, #:upper16:.PRINTLN_FMT
	bl printf
	b .LU51
.LU51:
	movw r2, #1
	movw r4, #0
	orr r4, r2, r4
	cmp r4, #1
	beq .LU52
	b .LU53
.LU52:
	movw r1, #1
	movw r0, #:lower16:.PRINTLN_FMT
	movt r0, #:upper16:.PRINTLN_FMT
	bl printf
	b .LU54
.LU53:
	movw r1, #0
	movw r0, #:lower16:.PRINTLN_FMT
	movt r0, #:upper16:.PRINTLN_FMT
	bl printf
	b .LU54
.LU54:
	movw r2, #0
	movw r4, #1
	orr r4, r2, r4
	cmp r4, #1
	beq .LU55
	b .LU56
.LU55:
	movw r1, #1
	movw r0, #:lower16:.PRINTLN_FMT
	movt r0, #:upper16:.PRINTLN_FMT
	bl printf
	b .LU57
.LU56:
	movw r1, #0
	movw r0, #:lower16:.PRINTLN_FMT
	movt r0, #:upper16:.PRINTLN_FMT
	bl printf
	b .LU57
.LU57:
	movw r2, #0
	movw r4, #0
	orr r4, r2, r4
	cmp r4, #1
	beq .LU58
	b .LU59
.LU58:
	movw r1, #0
	movw r0, #:lower16:.PRINTLN_FMT
	movt r0, #:upper16:.PRINTLN_FMT
	bl printf
	b .LU60
.LU59:
	movw r1, #1
	movw r0, #:lower16:.PRINTLN_FMT
	movt r0, #:upper16:.PRINTLN_FMT
	bl printf
	b .LU60
.LU60:
	movw r0, #3
	bl printgroup
	movw r4, #42
	mov r2, #0
	cmp r4, #1
	movgt r2, #1
	cmp r2, #1
	beq .LU61
	b .LU62
.LU61:
	movw r1, #1
	movw r0, #:lower16:.PRINTLN_FMT
	movt r0, #:upper16:.PRINTLN_FMT
	bl printf
	b .LU63
.LU62:
	movw r1, #0
	movw r0, #:lower16:.PRINTLN_FMT
	movt r0, #:upper16:.PRINTLN_FMT
	bl printf
	b .LU63
.LU63:
	movw r4, #42
	mov r2, #0
	cmp r4, #1
	movge r2, #1
	cmp r2, #1
	beq .LU64
	b .LU65
.LU64:
	movw r1, #1
	movw r0, #:lower16:.PRINTLN_FMT
	movt r0, #:upper16:.PRINTLN_FMT
	bl printf
	b .LU66
.LU65:
	movw r1, #0
	movw r0, #:lower16:.PRINTLN_FMT
	movt r0, #:upper16:.PRINTLN_FMT
	bl printf
	b .LU66
.LU66:
	movw r2, #42
	mov r4, #0
	cmp r2, #1
	movlt r4, #1
	cmp r4, #1
	beq .LU67
	b .LU68
.LU67:
	movw r1, #0
	movw r0, #:lower16:.PRINTLN_FMT
	movt r0, #:upper16:.PRINTLN_FMT
	bl printf
	b .LU69
.LU68:
	movw r1, #1
	movw r0, #:lower16:.PRINTLN_FMT
	movt r0, #:upper16:.PRINTLN_FMT
	bl printf
	b .LU69
.LU69:
	movw r4, #42
	mov r2, #0
	cmp r4, #1
	movle r2, #1
	cmp r2, #1
	beq .LU70
	b .LU71
.LU70:
	movw r1, #0
	movw r0, #:lower16:.PRINTLN_FMT
	movt r0, #:upper16:.PRINTLN_FMT
	bl printf
	b .LU72
.LU71:
	movw r1, #1
	movw r0, #:lower16:.PRINTLN_FMT
	movt r0, #:upper16:.PRINTLN_FMT
	bl printf
	b .LU72
.LU72:
	movw r2, #42
	mov r4, #0
	cmp r2, #1
	moveq r4, #1
	cmp r4, #1
	beq .LU73
	b .LU74
.LU73:
	movw r1, #0
	movw r0, #:lower16:.PRINTLN_FMT
	movt r0, #:upper16:.PRINTLN_FMT
	bl printf
	b .LU75
.LU74:
	movw r1, #1
	movw r0, #:lower16:.PRINTLN_FMT
	movt r0, #:upper16:.PRINTLN_FMT
	bl printf
	b .LU75
.LU75:
	movw r4, #42
	mov r2, #0
	cmp r4, #1
	movne r2, #1
	cmp r2, #1
	beq .LU76
	b .LU77
.LU76:
	movw r1, #1
	movw r0, #:lower16:.PRINTLN_FMT
	movt r0, #:upper16:.PRINTLN_FMT
	bl printf
	b .LU78
.LU77:
	movw r1, #0
	movw r0, #:lower16:.PRINTLN_FMT
	movt r0, #:upper16:.PRINTLN_FMT
	bl printf
	b .LU78
.LU78:
	movw r4, #1
	cmp r4, #1
	beq .LU79
	b .LU80
.LU79:
	movw r1, #1
	movw r0, #:lower16:.PRINTLN_FMT
	movt r0, #:upper16:.PRINTLN_FMT
	bl printf
	b .LU81
.LU80:
	movw r1, #0
	movw r0, #:lower16:.PRINTLN_FMT
	movt r0, #:upper16:.PRINTLN_FMT
	bl printf
	b .LU81
.LU81:
	movw r4, #1
	eor r4, r4, #1
	cmp r4, #1
	beq .LU82
	b .LU83
.LU82:
	movw r1, #0
	movw r0, #:lower16:.PRINTLN_FMT
	movt r0, #:upper16:.PRINTLN_FMT
	bl printf
	b .LU84
.LU83:
	movw r1, #1
	movw r0, #:lower16:.PRINTLN_FMT
	movt r0, #:upper16:.PRINTLN_FMT
	bl printf
	b .LU84
.LU84:
	movw r4, #0
	cmp r4, #1
	beq .LU85
	b .LU86
.LU85:
	movw r1, #0
	movw r0, #:lower16:.PRINTLN_FMT
	movt r0, #:upper16:.PRINTLN_FMT
	bl printf
	b .LU87
.LU86:
	movw r1, #1
	movw r0, #:lower16:.PRINTLN_FMT
	movt r0, #:upper16:.PRINTLN_FMT
	bl printf
	b .LU87
.LU87:
	movw r4, #1
	eor r4, r4, #0
	cmp r4, #1
	beq .LU88
	b .LU89
.LU88:
	movw r1, #1
	movw r0, #:lower16:.PRINTLN_FMT
	movt r0, #:upper16:.PRINTLN_FMT
	bl printf
	b .LU90
.LU89:
	movw r1, #0
	movw r0, #:lower16:.PRINTLN_FMT
	movt r0, #:upper16:.PRINTLN_FMT
	bl printf
	b .LU90
.LU90:
	movw r4, #1
	eor r4, r4, #0
	cmp r4, #1
	beq .LU91
	b .LU92
.LU91:
	movw r1, #1
	movw r0, #:lower16:.PRINTLN_FMT
	movt r0, #:upper16:.PRINTLN_FMT
	bl printf
	b .LU93
.LU92:
	movw r1, #0
	movw r0, #:lower16:.PRINTLN_FMT
	movt r0, #:upper16:.PRINTLN_FMT
	bl printf
	b .LU93
.LU93:
	movw r0, #4
	bl printgroup
	movw r4, #2
	add r4, r4, #3
	mov r2, #0
	cmp r4, #5
	moveq r2, #1
	cmp r2, #1
	beq .LU94
	b .LU95
.LU94:
	movw r1, #1
	movw r0, #:lower16:.PRINTLN_FMT
	movt r0, #:upper16:.PRINTLN_FMT
	bl printf
	b .LU96
.LU95:
	movw r1, #0
	movw r0, #:lower16:.PRINT_FMT
	movt r0, #:upper16:.PRINT_FMT
	bl printf
	movw r4, #2
	add r4, r4, #3
	mov r1, r4
	movw r0, #:lower16:.PRINTLN_FMT
	movt r0, #:upper16:.PRINTLN_FMT
	bl printf
	b .LU96
.LU96:
	movw r4, #2
	movw r2, #3
	mul r4, r4, r2
	mov r2, #0
	cmp r4, #6
	moveq r2, #1
	cmp r2, #1
	beq .LU97
	b .LU98
.LU97:
	movw r1, #1
	movw r0, #:lower16:.PRINTLN_FMT
	movt r0, #:upper16:.PRINTLN_FMT
	bl printf
	b .LU99
.LU98:
	movw r1, #0
	movw r0, #:lower16:.PRINT_FMT
	movt r0, #:upper16:.PRINT_FMT
	bl printf
	movw r2, #2
	movw r4, #3
	mul r4, r2, r4
	mov r1, r4
	movw r0, #:lower16:.PRINTLN_FMT
	movt r0, #:upper16:.PRINTLN_FMT
	bl printf
	b .LU99
.LU99:
	movw r4, #3
	sub r2, r4, #2
	mov r4, #0
	cmp r2, #1
	moveq r4, #1
	cmp r4, #1
	beq .LU100
	b .LU101
.LU100:
	movw r1, #1
	movw r0, #:lower16:.PRINTLN_FMT
	movt r0, #:upper16:.PRINTLN_FMT
	bl printf
	b .LU102
.LU101:
	movw r1, #0
	movw r0, #:lower16:.PRINT_FMT
	movt r0, #:upper16:.PRINT_FMT
	bl printf
	movw r4, #3
	sub r4, r4, #2
	mov r1, r4
	movw r0, #:lower16:.PRINTLN_FMT
	movt r0, #:upper16:.PRINTLN_FMT
	bl printf
	b .LU102
.LU102:
	movw r1, #3
	movw r0, #6
	bl __aeabi_idiv
	mov r2, r0
	mov r4, #0
	cmp r2, #2
	moveq r4, #1
	cmp r4, #1
	beq .LU103
	b .LU104
.LU103:
	movw r1, #1
	movw r0, #:lower16:.PRINTLN_FMT
	movt r0, #:upper16:.PRINTLN_FMT
	bl printf
	b .LU105
.LU104:
	movw r1, #0
	movw r0, #:lower16:.PRINT_FMT
	movt r0, #:upper16:.PRINT_FMT
	bl printf
	movw r1, #3
	movw r0, #6
	bl __aeabi_idiv
	mov r4, r0
	mov r1, r4
	movw r0, #:lower16:.PRINTLN_FMT
	movt r0, #:upper16:.PRINTLN_FMT
	bl printf
	b .LU105
.LU105:
	movw r4, #0
	sub r4, r4, #6
	mov r2, #0
	cmp r4, #0
	movlt r2, #1
	cmp r2, #1
	beq .LU106
	b .LU107
.LU106:
	movw r1, #1
	movw r0, #:lower16:.PRINTLN_FMT
	movt r0, #:upper16:.PRINTLN_FMT
	bl printf
	b .LU108
.LU107:
	movw r1, #0
	movw r0, #:lower16:.PRINTLN_FMT
	movt r0, #:upper16:.PRINTLN_FMT
	bl printf
	b .LU108
.LU108:
	movw r0, #5
	bl printgroup
	movw r4, #42
	mov r2, #0
	cmp r4, #42
	moveq r2, #1
	cmp r2, #1
	beq .LU109
	b .LU110
.LU109:
	movw r1, #1
	movw r0, #:lower16:.PRINTLN_FMT
	movt r0, #:upper16:.PRINTLN_FMT
	bl printf
	b .LU111
.LU110:
	movw r1, #0
	movw r0, #:lower16:.PRINTLN_FMT
	movt r0, #:upper16:.PRINTLN_FMT
	bl printf
	b .LU111
.LU111:
	movw r4, #3
	add r2, r4, #2
	mov r4, #0
	cmp r2, #5
	moveq r4, #1
	cmp r4, #1
	beq .LU112
	b .LU113
.LU112:
	movw r1, #1
	movw r0, #:lower16:.PRINTLN_FMT
	movt r0, #:upper16:.PRINTLN_FMT
	bl printf
	b .LU114
.LU113:
	movw r1, #0
	movw r0, #:lower16:.PRINTLN_FMT
	movt r0, #:upper16:.PRINTLN_FMT
	bl printf
	b .LU114
.LU114:
	movw r5, #1
	mov r4, r5
	cmp r4, #1
	beq .LU115
	b .LU116
.LU115:
	movw r1, #1
	movw r0, #:lower16:.PRINTLN_FMT
	movt r0, #:upper16:.PRINTLN_FMT
	bl printf
	mov r4, r5
	b .LU117
.LU116:
	movw r1, #0
	movw r0, #:lower16:.PRINTLN_FMT
	movt r0, #:upper16:.PRINTLN_FMT
	bl printf
	mov r4, r5
	b .LU117
.LU117:
	mov r2, r4
	movw r4, #1
	eor r4, r4, r2
	cmp r4, #1
	beq .LU118
	b .LU119
.LU118:
	movw r1, #0
	movw r0, #:lower16:.PRINTLN_FMT
	movt r0, #:upper16:.PRINTLN_FMT
	bl printf
	b .LU120
.LU119:
	movw r1, #1
	movw r0, #:lower16:.PRINTLN_FMT
	movt r0, #:upper16:.PRINTLN_FMT
	bl printf
	b .LU120
.LU120:
	movw r4, #0
	mov r2, r4
	cmp r2, #1
	beq .LU121
	b .LU122
.LU121:
	movw r1, #0
	movw r0, #:lower16:.PRINTLN_FMT
	movt r0, #:upper16:.PRINTLN_FMT
	bl printf
	b .LU123
.LU122:
	movw r1, #1
	movw r0, #:lower16:.PRINTLN_FMT
	movt r0, #:upper16:.PRINTLN_FMT
	bl printf
	b .LU123
.LU123:
	mov r3, r4
	movw r2, #1
	eor r2, r2, r3
	cmp r2, #1
	beq .LU124
	b .LU125
.LU124:
	movw r1, #1
	movw r0, #:lower16:.PRINTLN_FMT
	movt r0, #:upper16:.PRINTLN_FMT
	bl printf
	b .LU126
.LU125:
	movw r1, #0
	movw r0, #:lower16:.PRINTLN_FMT
	movt r0, #:upper16:.PRINTLN_FMT
	bl printf
	b .LU126
.LU126:
	cmp r4, #1
	beq .LU127
	b .LU128
.LU127:
	movw r1, #0
	movw r0, #:lower16:.PRINTLN_FMT
	movt r0, #:upper16:.PRINTLN_FMT
	bl printf
	b .LU129
.LU128:
	movw r1, #1
	movw r0, #:lower16:.PRINTLN_FMT
	movt r0, #:upper16:.PRINTLN_FMT
	bl printf
	b .LU129
.LU129:
	movw r0, #6
	bl printgroup
	movw r4, #0
	mov r2, #0
	cmp r4, #5
	movlt r2, #1
	movw r4, #0
	movw r3, #0
	cmp r2, #1
	beq .LU130
	b .LU131
.LU130:
	mov r5, r3
	mov r4, #0
	cmp r5, #5
	movge r4, #1
	cmp r4, #1
	beq .LU132
	b .LU133
.LU132:
	movw r1, #0
	movw r0, #:lower16:.PRINTLN_FMT
	movt r0, #:upper16:.PRINTLN_FMT
	bl printf
	mov r4, r5
	b .LU134
.LU133:
	mov r4, r5
	b .LU134
.LU134:
	add r3, r4, #5
	mov r2, #0
	cmp r3, #5
	movlt r2, #1
	mov r4, r3
	cmp r2, #1
	beq .LU130
	b .LU131
.LU131:
	mov r2, #0
	cmp r4, #5
	moveq r2, #1
	cmp r2, #1
	beq .LU135
	b .LU136
.LU135:
	movw r1, #1
	movw r0, #:lower16:.PRINTLN_FMT
	movt r0, #:upper16:.PRINTLN_FMT
	bl printf
	b .LU137
.LU136:
	movw r1, #0
	movw r0, #:lower16:.PRINT_FMT
	movt r0, #:upper16:.PRINT_FMT
	bl printf
	mov r1, r4
	movw r0, #:lower16:.PRINTLN_FMT
	movt r0, #:upper16:.PRINTLN_FMT
	bl printf
	b .LU137
.LU137:
	movw r0, #7
	bl printgroup
	movw r0, #12
	bl malloc
	mov r4, r0
	mov r2, r4
	movw r3, #42
	str r3, [r2]
	movw r2, #1
	add r3, r4, #4
	str r2, [r3]
	mov r2, r4
	ldr r3, [r2]
	mov r2, #0
	cmp r3, #42
	moveq r2, #1
	cmp r2, #1
	beq .LU138
	b .LU139
.LU138:
	movw r1, #1
	movw r0, #:lower16:.PRINTLN_FMT
	movt r0, #:upper16:.PRINTLN_FMT
	bl printf
	b .LU140
.LU139:
	movw r1, #0
	movw r0, #:lower16:.PRINT_FMT
	movt r0, #:upper16:.PRINT_FMT
	bl printf
	mov r2, r4
	ldr r2, [r2]
	mov r1, r2
	movw r0, #:lower16:.PRINTLN_FMT
	movt r0, #:upper16:.PRINTLN_FMT
	bl printf
	b .LU140
.LU140:
	add r2, r4, #4
	ldr r2, [r2]
	cmp r2, #1
	beq .LU141
	b .LU142
.LU141:
	movw r1, #1
	movw r0, #:lower16:.PRINTLN_FMT
	movt r0, #:upper16:.PRINTLN_FMT
	bl printf
	b .LU143
.LU142:
	movw r1, #0
	movw r0, #:lower16:.PRINTLN_FMT
	movt r0, #:upper16:.PRINTLN_FMT
	bl printf
	b .LU143
.LU143:
	movw r0, #12
	bl malloc
	mov r2, r0
	add r3, r4, #8
	str r2, [r3]
	add r2, r4, #8
	ldr r2, [r2]
	mov r3, r2
	movw r2, #13
	str r2, [r3]
	movw r2, #0
	add r3, r4, #8
	ldr r3, [r3]
	add r3, r3, #4
	str r2, [r3]
	add r2, r4, #8
	ldr r2, [r2]
	ldr r3, [r2]
	mov r2, #0
	cmp r3, #13
	moveq r2, #1
	cmp r2, #1
	beq .LU144
	b .LU145
.LU144:
	movw r1, #1
	movw r0, #:lower16:.PRINTLN_FMT
	movt r0, #:upper16:.PRINTLN_FMT
	bl printf
	b .LU146
.LU145:
	movw r1, #0
	movw r0, #:lower16:.PRINT_FMT
	movt r0, #:upper16:.PRINT_FMT
	bl printf
	add r2, r4, #8
	ldr r2, [r2]
	ldr r2, [r2]
	mov r1, r2
	movw r0, #:lower16:.PRINTLN_FMT
	movt r0, #:upper16:.PRINTLN_FMT
	bl printf
	b .LU146
.LU146:
	add r2, r4, #8
	ldr r2, [r2]
	add r2, r2, #4
	ldr r2, [r2]
	mov r3, r2
	movw r2, #1
	eor r2, r2, r3
	cmp r2, #1
	beq .LU147
	b .LU148
.LU147:
	movw r1, #1
	movw r0, #:lower16:.PRINTLN_FMT
	movt r0, #:upper16:.PRINTLN_FMT
	bl printf
	b .LU149
.LU148:
	movw r1, #0
	movw r0, #:lower16:.PRINTLN_FMT
	movt r0, #:upper16:.PRINTLN_FMT
	bl printf
	b .LU149
.LU149:
	mov r2, #0
	cmp r4, r4
	moveq r2, #1
	cmp r2, #1
	beq .LU150
	b .LU151
.LU150:
	movw r1, #1
	movw r0, #:lower16:.PRINTLN_FMT
	movt r0, #:upper16:.PRINTLN_FMT
	bl printf
	b .LU152
.LU151:
	movw r1, #0
	movw r0, #:lower16:.PRINTLN_FMT
	movt r0, #:upper16:.PRINTLN_FMT
	bl printf
	b .LU152
.LU152:
	add r2, r4, #8
	ldr r2, [r2]
	mov r3, #0
	cmp r4, r2
	movne r3, #1
	cmp r3, #1
	beq .LU153
	b .LU154
.LU153:
	movw r1, #1
	movw r0, #:lower16:.PRINTLN_FMT
	movt r0, #:upper16:.PRINTLN_FMT
	bl printf
	b .LU155
.LU154:
	movw r1, #0
	movw r0, #:lower16:.PRINTLN_FMT
	movt r0, #:upper16:.PRINTLN_FMT
	bl printf
	b .LU155
.LU155:
	add r2, r4, #8
	ldr r2, [r2]
	mov r0, r2
	bl free
	mov r0, r4
	bl free
	movw r0, #8
	bl printgroup
	movw r4, #7
	movw r2, #:lower16:gi1
	movt r2, #:upper16:gi1
	str r4, [r2]
	movw r4, #:lower16:gi1
	movt r4, #:upper16:gi1
	ldr r4, [r4]
	mov r2, #0
	cmp r4, #7
	moveq r2, #1
	cmp r2, #1
	beq .LU156
	b .LU157
.LU156:
	movw r1, #1
	movw r0, #:lower16:.PRINTLN_FMT
	movt r0, #:upper16:.PRINTLN_FMT
	bl printf
	b .LU158
.LU157:
	movw r1, #0
	movw r0, #:lower16:.PRINT_FMT
	movt r0, #:upper16:.PRINT_FMT
	bl printf
	movw r4, #:lower16:gi1
	movt r4, #:upper16:gi1
	ldr r4, [r4]
	mov r1, r4
	movw r0, #:lower16:.PRINTLN_FMT
	movt r0, #:upper16:.PRINTLN_FMT
	bl printf
	b .LU158
.LU158:
	movw r2, #1
	movw r4, #:lower16:gb1
	movt r4, #:upper16:gb1
	str r2, [r4]
	movw r4, #:lower16:gb1
	movt r4, #:upper16:gb1
	ldr r4, [r4]
	cmp r4, #1
	beq .LU159
	b .LU160
.LU159:
	movw r1, #1
	movw r0, #:lower16:.PRINTLN_FMT
	movt r0, #:upper16:.PRINTLN_FMT
	bl printf
	b .LU161
.LU160:
	movw r1, #0
	movw r0, #:lower16:.PRINTLN_FMT
	movt r0, #:upper16:.PRINTLN_FMT
	bl printf
	b .LU161
.LU161:
	movw r0, #12
	bl malloc
	mov r4, r0
	movw r2, #:lower16:gs1
	movt r2, #:upper16:gs1
	str r4, [r2]
	movw r4, #:lower16:gs1
	movt r4, #:upper16:gs1
	ldr r4, [r4]
	mov r2, r4
	movw r4, #34
	str r4, [r2]
	movw r4, #0
	movw r2, #:lower16:gs1
	movt r2, #:upper16:gs1
	ldr r2, [r2]
	add r2, r2, #4
	str r4, [r2]
	movw r4, #:lower16:gs1
	movt r4, #:upper16:gs1
	ldr r4, [r4]
	ldr r4, [r4]
	mov r2, #0
	cmp r4, #34
	moveq r2, #1
	cmp r2, #1
	beq .LU162
	b .LU163
.LU162:
	movw r1, #1
	movw r0, #:lower16:.PRINTLN_FMT
	movt r0, #:upper16:.PRINTLN_FMT
	bl printf
	b .LU164
.LU163:
	movw r1, #0
	movw r0, #:lower16:.PRINT_FMT
	movt r0, #:upper16:.PRINT_FMT
	bl printf
	movw r4, #:lower16:gs1
	movt r4, #:upper16:gs1
	ldr r4, [r4]
	ldr r4, [r4]
	mov r1, r4
	movw r0, #:lower16:.PRINTLN_FMT
	movt r0, #:upper16:.PRINTLN_FMT
	bl printf
	b .LU164
.LU164:
	movw r4, #:lower16:gs1
	movt r4, #:upper16:gs1
	ldr r4, [r4]
	add r4, r4, #4
	ldr r4, [r4]
	mov r2, r4
	movw r4, #1
	eor r4, r4, r2
	cmp r4, #1
	beq .LU165
	b .LU166
.LU165:
	movw r1, #1
	movw r0, #:lower16:.PRINTLN_FMT
	movt r0, #:upper16:.PRINTLN_FMT
	bl printf
	b .LU167
.LU166:
	movw r1, #0
	movw r0, #:lower16:.PRINTLN_FMT
	movt r0, #:upper16:.PRINTLN_FMT
	bl printf
	b .LU167
.LU167:
	movw r0, #12
	bl malloc
	mov r4, r0
	movw r2, #:lower16:gs1
	movt r2, #:upper16:gs1
	ldr r2, [r2]
	add r2, r2, #8
	str r4, [r2]
	movw r4, #:lower16:gs1
	movt r4, #:upper16:gs1
	ldr r4, [r4]
	add r4, r4, #8
	ldr r4, [r4]
	mov r2, r4
	movw r4, #16
	str r4, [r2]
	movw r4, #1
	movw r2, #:lower16:gs1
	movt r2, #:upper16:gs1
	ldr r2, [r2]
	add r2, r2, #8
	ldr r2, [r2]
	add r2, r2, #4
	str r4, [r2]
	movw r4, #:lower16:gs1
	movt r4, #:upper16:gs1
	ldr r4, [r4]
	add r4, r4, #8
	ldr r4, [r4]
	ldr r4, [r4]
	mov r2, #0
	cmp r4, #16
	moveq r2, #1
	cmp r2, #1
	beq .LU168
	b .LU169
.LU168:
	movw r1, #1
	movw r0, #:lower16:.PRINTLN_FMT
	movt r0, #:upper16:.PRINTLN_FMT
	bl printf
	b .LU170
.LU169:
	movw r1, #0
	movw r0, #:lower16:.PRINT_FMT
	movt r0, #:upper16:.PRINT_FMT
	bl printf
	movw r4, #:lower16:gs1
	movt r4, #:upper16:gs1
	ldr r4, [r4]
	add r4, r4, #8
	ldr r4, [r4]
	ldr r4, [r4]
	mov r1, r4
	movw r0, #:lower16:.PRINTLN_FMT
	movt r0, #:upper16:.PRINTLN_FMT
	bl printf
	b .LU170
.LU170:
	movw r4, #:lower16:gs1
	movt r4, #:upper16:gs1
	ldr r4, [r4]
	add r4, r4, #8
	ldr r4, [r4]
	add r4, r4, #4
	ldr r4, [r4]
	cmp r4, #1
	beq .LU171
	b .LU172
.LU171:
	movw r1, #1
	movw r0, #:lower16:.PRINTLN_FMT
	movt r0, #:upper16:.PRINTLN_FMT
	bl printf
	b .LU173
.LU172:
	movw r1, #0
	movw r0, #:lower16:.PRINTLN_FMT
	movt r0, #:upper16:.PRINTLN_FMT
	bl printf
	b .LU173
.LU173:
	movw r4, #:lower16:gs1
	movt r4, #:upper16:gs1
	ldr r4, [r4]
	add r4, r4, #8
	ldr r4, [r4]
	mov r0, r4
	bl free
	movw r4, #:lower16:gs1
	movt r4, #:upper16:gs1
	ldr r4, [r4]
	mov r0, r4
	bl free
	movw r0, #9
	bl printgroup
	movw r0, #12
	bl malloc
	mov r4, r0
	movw r3, #1
	add r2, r4, #4
	str r3, [r2]
	movw r3, #1
	mov r2, r4
	mov r1, r3
	movw r0, #3
	bl takealltypes
	movw r1, #2
	movw r0, #:lower16:.PRINTLN_FMT
	movt r0, #:upper16:.PRINTLN_FMT
	bl printf
	movw r4, #8
	str r4, [sp, #12]
	movw r4, #7
	str r4, [sp, #8]
	movw r4, #6
	str r4, [sp, #4]
	movw r4, #5
	str r4, [sp, #0]
	movw r3, #4
	movw r2, #3
	movw r1, #2
	movw r0, #1
	bl tonofargs
	movw r1, #3
	movw r0, #:lower16:.PRINTLN_FMT
	movt r0, #:upper16:.PRINTLN_FMT
	bl printf
	movw r0, #3
	bl returnint
	mov r4, r0
	mov r2, #0
	cmp r4, #3
	moveq r2, #1
	cmp r2, #1
	beq .LU174
	b .LU175
.LU174:
	movw r1, #1
	movw r0, #:lower16:.PRINTLN_FMT
	movt r0, #:upper16:.PRINTLN_FMT
	bl printf
	b .LU176
.LU175:
	movw r1, #0
	movw r0, #:lower16:.PRINT_FMT
	movt r0, #:upper16:.PRINT_FMT
	bl printf
	mov r1, r4
	movw r0, #:lower16:.PRINTLN_FMT
	movt r0, #:upper16:.PRINTLN_FMT
	bl printf
	b .LU176
.LU176:
	movw r4, #1
	mov r0, r4
	bl returnbool
	mov r4, r0
	cmp r4, #1
	beq .LU177
	b .LU178
.LU177:
	movw r1, #1
	movw r0, #:lower16:.PRINTLN_FMT
	movt r0, #:upper16:.PRINTLN_FMT
	bl printf
	b .LU179
.LU178:
	movw r1, #0
	movw r0, #:lower16:.PRINTLN_FMT
	movt r0, #:upper16:.PRINTLN_FMT
	bl printf
	b .LU179
.LU179:
	movw r0, #12
	bl malloc
	mov r4, r0
	mov r5, r4
	mov r0, r5
	bl returnstruct
	mov r4, r0
	mov r2, #0
	cmp r5, r4
	moveq r2, #1
	cmp r2, #1
	beq .LU180
	b .LU181
.LU180:
	movw r1, #1
	movw r0, #:lower16:.PRINTLN_FMT
	movt r0, #:upper16:.PRINTLN_FMT
	bl printf
	b .LU182
.LU181:
	movw r1, #0
	movw r0, #:lower16:.PRINTLN_FMT
	movt r0, #:upper16:.PRINTLN_FMT
	bl printf
	b .LU182
.LU182:
	movw r0, #10
	bl printgroup
	b .LU35
.LU35:
	movw r0, #0
	add sp, sp, #16
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
