	.arch armv7-a
	.comm	.read_scratch,4,4

	.text
	.align 2
	.global placePiece
placePiece:
.LU7:
	push {fp, lr}
	add fp, sp, #4
	mov r3, #0
	cmp r2, #1
	moveq r3, #1
	cmp r3, #1
	beq .LU8
	b .LU9
.LU8:
	mov r2, r0
	str r1, [r2]
	b .LU10
.LU9:
	mov r3, #0
	cmp r2, #2
	moveq r3, #1
	cmp r3, #1
	beq .LU11
	b .LU12
.LU11:
	add r2, r0, #4
	str r1, [r2]
	b .LU13
.LU12:
	mov r3, #0
	cmp r2, #3
	moveq r3, #1
	cmp r3, #1
	beq .LU14
	b .LU15
.LU14:
	add r2, r0, #8
	str r1, [r2]
	b .LU16
.LU15:
	mov r3, #0
	cmp r2, #4
	moveq r3, #1
	cmp r3, #1
	beq .LU17
	b .LU18
.LU17:
	add r2, r0, #12
	str r1, [r2]
	b .LU19
.LU18:
	mov r3, #0
	cmp r2, #5
	moveq r3, #1
	cmp r3, #1
	beq .LU20
	b .LU21
.LU20:
	add r2, r0, #16
	str r1, [r2]
	b .LU22
.LU21:
	mov r3, #0
	cmp r2, #6
	moveq r3, #1
	cmp r3, #1
	beq .LU23
	b .LU24
.LU23:
	add r2, r0, #20
	str r1, [r2]
	b .LU25
.LU24:
	mov r3, #0
	cmp r2, #7
	moveq r3, #1
	cmp r3, #1
	beq .LU26
	b .LU27
.LU26:
	add r2, r0, #24
	str r1, [r2]
	b .LU28
.LU27:
	mov r3, #0
	cmp r2, #8
	moveq r3, #1
	cmp r3, #1
	beq .LU29
	b .LU30
.LU29:
	add r2, r0, #28
	str r1, [r2]
	b .LU31
.LU30:
	mov r3, #0
	cmp r2, #9
	moveq r3, #1
	cmp r3, #1
	beq .LU32
	b .LU33
.LU32:
	add r2, r0, #32
	str r1, [r2]
	b .LU34
.LU33:
	b .LU34
.LU34:
	b .LU31
.LU31:
	b .LU28
.LU28:
	b .LU25
.LU25:
	b .LU22
.LU22:
	b .LU19
.LU19:
	b .LU16
.LU16:
	b .LU13
.LU13:
	b .LU10
.LU10:
	b .LU6
.LU6:
	pop {fp, pc}
	.size placePiece, .-placePiece
	.align 2
	.global main
main:
.LU146:
	push {fp, lr}
	add fp, sp, #4
	push {r4, r5, r6}
	movw r0, #36
	bl malloc
	mov r2, r0
	b .inline0_LU1
.inline0_LU1:
	mov r0, r2
	movw r1, #0
	str r1, [r0]
	add r1, r2, #4
	movw r0, #0
	str r0, [r1]
	add r0, r2, #8
	movw r1, #0
	str r1, [r0]
	add r1, r2, #12
	movw r0, #0
	str r0, [r1]
	add r0, r2, #16
	movw r1, #0
	str r1, [r0]
	add r1, r2, #20
	movw r0, #0
	str r0, [r1]
	add r0, r2, #24
	movw r1, #0
	str r1, [r0]
	add r0, r2, #28
	movw r1, #0
	str r1, [r0]
	add r1, r2, #32
	movw r0, #0
	str r0, [r1]
	b .inline0_LU0
.inline0_LU0:
	b .next0
.next0:
	movw r5, #:lower16:-1
	movt r5, #:upper16:-1
	movw r6, #0
	movw r1, #0
	movw r0, #1
	cmp r0, #1
	beq .LU147
	b .LU148
.LU147:
	mov r4, r1
	mov r5, r2
	b .inline1_LU3
.inline1_LU3:
	mov r2, r5
	ldr r2, [r2]
	mov r1, r2
	movw r0, #:lower16:.PRINT_FMT
	movt r0, #:upper16:.PRINT_FMT
	bl printf
	add r2, r5, #4
	ldr r2, [r2]
	mov r1, r2
	movw r0, #:lower16:.PRINT_FMT
	movt r0, #:upper16:.PRINT_FMT
	bl printf
	add r2, r5, #8
	ldr r2, [r2]
	mov r1, r2
	movw r0, #:lower16:.PRINTLN_FMT
	movt r0, #:upper16:.PRINTLN_FMT
	bl printf
	add r2, r5, #12
	ldr r2, [r2]
	mov r1, r2
	movw r0, #:lower16:.PRINT_FMT
	movt r0, #:upper16:.PRINT_FMT
	bl printf
	add r2, r5, #16
	ldr r2, [r2]
	mov r1, r2
	movw r0, #:lower16:.PRINT_FMT
	movt r0, #:upper16:.PRINT_FMT
	bl printf
	add r2, r5, #20
	ldr r2, [r2]
	mov r1, r2
	movw r0, #:lower16:.PRINTLN_FMT
	movt r0, #:upper16:.PRINTLN_FMT
	bl printf
	add r2, r5, #24
	ldr r2, [r2]
	mov r1, r2
	movw r0, #:lower16:.PRINT_FMT
	movt r0, #:upper16:.PRINT_FMT
	bl printf
	add r2, r5, #28
	ldr r2, [r2]
	mov r1, r2
	movw r0, #:lower16:.PRINT_FMT
	movt r0, #:upper16:.PRINT_FMT
	bl printf
	add r2, r5, #32
	ldr r2, [r2]
	mov r1, r2
	movw r0, #:lower16:.PRINTLN_FMT
	movt r0, #:upper16:.PRINTLN_FMT
	bl printf
	b .inline1_LU2
.inline1_LU2:
	b .next1
.next1:
	mov r2, #0
	cmp r6, #0
	moveq r2, #1
	cmp r2, #1
	beq .LU149
	b .LU150
.LU149:
	add r6, r6, #1
	movw r1, #:lower16:.read_scratch
	movt r1, #:upper16:.read_scratch
	movw r0, #:lower16:.READ_FMT
	movt r0, #:upper16:.READ_FMT
	bl scanf
	movw r2, #:lower16:.read_scratch
	movt r2, #:upper16:.read_scratch
	ldr r2, [r2]
	movw r1, #1
	mov r0, r5
	bl placePiece
	mov r2, r5
	mov r0, r4
	mov r1, r6
	b .LU151
.LU150:
	sub r6, r6, #1
	movw r1, #:lower16:.read_scratch
	movt r1, #:upper16:.read_scratch
	movw r0, #:lower16:.READ_FMT
	movt r0, #:upper16:.READ_FMT
	bl scanf
	movw r2, #:lower16:.read_scratch
	movt r2, #:upper16:.read_scratch
	ldr r2, [r2]
	movw r1, #2
	mov r0, r5
	bl placePiece
	mov r2, r5
	mov r0, r4
	mov r1, r6
	b .LU151
.LU151:
	mov r4, r1
	mov r5, r0
	mov r6, r2
	b .inline2_LU36
.inline2_LU36:
	mov r2, r6
	ldr r0, [r2]
	mov r2, #0
	cmp r0, #1
	moveq r2, #1
	cmp r2, #1
	beq .inline2_LU37
	b .inline2_LU38
.inline2_LU37:
	add r2, r6, #4
	ldr r0, [r2]
	mov r2, #0
	cmp r0, #1
	moveq r2, #1
	cmp r2, #1
	beq .inline2_LU40
	b .inline2_LU41
.inline2_LU40:
	add r2, r6, #8
	ldr r0, [r2]
	mov r2, #0
	cmp r0, #1
	moveq r2, #1
	cmp r2, #1
	beq .inline2_LU43
	b .inline2_LU44
.inline2_LU43:
	movw r2, #0
	b .inline2_LU35
.inline2_LU44:
	b .inline2_LU45
.inline2_LU45:
	mov r2, r6
	b .inline2_LU42
.inline2_LU41:
	mov r2, r6
	b .inline2_LU42
.inline2_LU42:
	b .inline2_LU39
.inline2_LU38:
	mov r2, r6
	b .inline2_LU39
.inline2_LU39:
	mov r0, r2
	ldr r0, [r0]
	mov r1, #0
	cmp r0, #2
	moveq r1, #1
	cmp r1, #1
	beq .inline2_LU46
	b .inline2_LU47
.inline2_LU46:
	add r0, r2, #4
	ldr r0, [r0]
	mov r1, #0
	cmp r0, #2
	moveq r1, #1
	cmp r1, #1
	beq .inline2_LU49
	b .inline2_LU50
.inline2_LU49:
	add r0, r2, #8
	ldr r1, [r0]
	mov r0, #0
	cmp r1, #2
	moveq r0, #1
	cmp r0, #1
	beq .inline2_LU52
	b .inline2_LU53
.inline2_LU52:
	movw r2, #1
	b .inline2_LU35
.inline2_LU53:
	b .inline2_LU54
.inline2_LU54:
	b .inline2_LU51
.inline2_LU50:
	b .inline2_LU51
.inline2_LU51:
	b .inline2_LU48
.inline2_LU47:
	b .inline2_LU48
.inline2_LU48:
	mov r1, r2
	add r2, r1, #12
	ldr r2, [r2]
	mov r0, #0
	cmp r2, #1
	moveq r0, #1
	cmp r0, #1
	beq .inline2_LU55
	b .inline2_LU56
.inline2_LU55:
	add r2, r1, #16
	ldr r0, [r2]
	mov r2, #0
	cmp r0, #1
	moveq r2, #1
	cmp r2, #1
	beq .inline2_LU58
	b .inline2_LU59
.inline2_LU58:
	add r2, r1, #20
	ldr r2, [r2]
	mov r0, #0
	cmp r2, #1
	moveq r0, #1
	cmp r0, #1
	beq .inline2_LU61
	b .inline2_LU62
.inline2_LU61:
	movw r2, #0
	b .inline2_LU35
.inline2_LU62:
	b .inline2_LU63
.inline2_LU63:
	mov r2, r1
	b .inline2_LU60
.inline2_LU59:
	mov r2, r1
	b .inline2_LU60
.inline2_LU60:
	b .inline2_LU57
.inline2_LU56:
	mov r2, r1
	b .inline2_LU57
.inline2_LU57:
	mov r1, r2
	add r2, r1, #12
	ldr r0, [r2]
	mov r2, #0
	cmp r0, #2
	moveq r2, #1
	cmp r2, #1
	beq .inline2_LU64
	b .inline2_LU65
.inline2_LU64:
	add r2, r1, #16
	ldr r2, [r2]
	mov r0, #0
	cmp r2, #2
	moveq r0, #1
	cmp r0, #1
	beq .inline2_LU67
	b .inline2_LU68
.inline2_LU67:
	add r2, r1, #20
	ldr r2, [r2]
	mov r0, #0
	cmp r2, #2
	moveq r0, #1
	cmp r0, #1
	beq .inline2_LU70
	b .inline2_LU71
.inline2_LU70:
	movw r2, #1
	b .inline2_LU35
.inline2_LU71:
	b .inline2_LU72
.inline2_LU72:
	mov r2, r1
	b .inline2_LU69
.inline2_LU68:
	mov r2, r1
	b .inline2_LU69
.inline2_LU69:
	b .inline2_LU66
.inline2_LU65:
	mov r2, r1
	b .inline2_LU66
.inline2_LU66:
	mov r1, r2
	add r2, r1, #24
	ldr r0, [r2]
	mov r2, #0
	cmp r0, #1
	moveq r2, #1
	cmp r2, #1
	beq .inline2_LU73
	b .inline2_LU74
.inline2_LU73:
	add r2, r1, #28
	ldr r2, [r2]
	mov r0, #0
	cmp r2, #1
	moveq r0, #1
	cmp r0, #1
	beq .inline2_LU76
	b .inline2_LU77
.inline2_LU76:
	add r2, r1, #32
	ldr r2, [r2]
	mov r0, #0
	cmp r2, #1
	moveq r0, #1
	cmp r0, #1
	beq .inline2_LU79
	b .inline2_LU80
.inline2_LU79:
	movw r2, #0
	b .inline2_LU35
.inline2_LU80:
	b .inline2_LU81
.inline2_LU81:
	mov r2, r1
	b .inline2_LU78
.inline2_LU77:
	mov r2, r1
	b .inline2_LU78
.inline2_LU78:
	b .inline2_LU75
.inline2_LU74:
	mov r2, r1
	b .inline2_LU75
.inline2_LU75:
	mov r0, r2
	add r2, r0, #24
	ldr r1, [r2]
	mov r2, #0
	cmp r1, #2
	moveq r2, #1
	cmp r2, #1
	beq .inline2_LU82
	b .inline2_LU83
.inline2_LU82:
	add r2, r0, #28
	ldr r1, [r2]
	mov r2, #0
	cmp r1, #2
	moveq r2, #1
	cmp r2, #1
	beq .inline2_LU85
	b .inline2_LU86
.inline2_LU85:
	add r2, r0, #32
	ldr r2, [r2]
	mov r1, #0
	cmp r2, #2
	moveq r1, #1
	cmp r1, #1
	beq .inline2_LU88
	b .inline2_LU89
.inline2_LU88:
	movw r2, #1
	b .inline2_LU35
.inline2_LU89:
	b .inline2_LU90
.inline2_LU90:
	mov r2, r0
	b .inline2_LU87
.inline2_LU86:
	mov r2, r0
	b .inline2_LU87
.inline2_LU87:
	b .inline2_LU84
.inline2_LU83:
	mov r2, r0
	b .inline2_LU84
.inline2_LU84:
	mov r0, r2
	mov r2, r0
	ldr r2, [r2]
	mov r1, #0
	cmp r2, #1
	moveq r1, #1
	cmp r1, #1
	beq .inline2_LU91
	b .inline2_LU92
.inline2_LU91:
	add r2, r0, #12
	ldr r2, [r2]
	mov r1, #0
	cmp r2, #1
	moveq r1, #1
	cmp r1, #1
	beq .inline2_LU94
	b .inline2_LU95
.inline2_LU94:
	add r2, r0, #24
	ldr r1, [r2]
	mov r2, #0
	cmp r1, #1
	moveq r2, #1
	cmp r2, #1
	beq .inline2_LU97
	b .inline2_LU98
.inline2_LU97:
	movw r2, #0
	b .inline2_LU35
.inline2_LU98:
	b .inline2_LU99
.inline2_LU99:
	mov r2, r0
	b .inline2_LU96
.inline2_LU95:
	mov r2, r0
	b .inline2_LU96
.inline2_LU96:
	b .inline2_LU93
.inline2_LU92:
	mov r2, r0
	b .inline2_LU93
.inline2_LU93:
	mov r0, r2
	mov r2, r0
	ldr r2, [r2]
	mov r1, #0
	cmp r2, #2
	moveq r1, #1
	cmp r1, #1
	beq .inline2_LU100
	b .inline2_LU101
.inline2_LU100:
	add r2, r0, #12
	ldr r2, [r2]
	mov r1, #0
	cmp r2, #2
	moveq r1, #1
	cmp r1, #1
	beq .inline2_LU103
	b .inline2_LU104
.inline2_LU103:
	add r2, r0, #24
	ldr r1, [r2]
	mov r2, #0
	cmp r1, #2
	moveq r2, #1
	cmp r2, #1
	beq .inline2_LU106
	b .inline2_LU107
.inline2_LU106:
	movw r2, #1
	b .inline2_LU35
.inline2_LU107:
	b .inline2_LU108
.inline2_LU108:
	mov r2, r0
	b .inline2_LU105
.inline2_LU104:
	mov r2, r0
	b .inline2_LU105
.inline2_LU105:
	b .inline2_LU102
.inline2_LU101:
	mov r2, r0
	b .inline2_LU102
.inline2_LU102:
	mov r1, r2
	add r2, r1, #4
	ldr r0, [r2]
	mov r2, #0
	cmp r0, #1
	moveq r2, #1
	cmp r2, #1
	beq .inline2_LU109
	b .inline2_LU110
.inline2_LU109:
	add r2, r1, #16
	ldr r0, [r2]
	mov r2, #0
	cmp r0, #1
	moveq r2, #1
	cmp r2, #1
	beq .inline2_LU112
	b .inline2_LU113
.inline2_LU112:
	add r2, r1, #28
	ldr r2, [r2]
	mov r0, #0
	cmp r2, #1
	moveq r0, #1
	cmp r0, #1
	beq .inline2_LU115
	b .inline2_LU116
.inline2_LU115:
	movw r2, #0
	b .inline2_LU35
.inline2_LU116:
	b .inline2_LU117
.inline2_LU117:
	mov r2, r1
	b .inline2_LU114
.inline2_LU113:
	mov r2, r1
	b .inline2_LU114
.inline2_LU114:
	b .inline2_LU111
.inline2_LU110:
	mov r2, r1
	b .inline2_LU111
.inline2_LU111:
	mov r1, r2
	add r2, r1, #4
	ldr r2, [r2]
	mov r0, #0
	cmp r2, #2
	moveq r0, #1
	cmp r0, #1
	beq .inline2_LU118
	b .inline2_LU119
.inline2_LU118:
	add r2, r1, #16
	ldr r0, [r2]
	mov r2, #0
	cmp r0, #2
	moveq r2, #1
	cmp r2, #1
	beq .inline2_LU121
	b .inline2_LU122
.inline2_LU121:
	add r2, r1, #28
	ldr r2, [r2]
	mov r0, #0
	cmp r2, #2
	moveq r0, #1
	cmp r0, #1
	beq .inline2_LU124
	b .inline2_LU125
.inline2_LU124:
	movw r2, #1
	b .inline2_LU35
.inline2_LU125:
	b .inline2_LU126
.inline2_LU126:
	mov r2, r1
	b .inline2_LU123
.inline2_LU122:
	mov r2, r1
	b .inline2_LU123
.inline2_LU123:
	b .inline2_LU120
.inline2_LU119:
	mov r2, r1
	b .inline2_LU120
.inline2_LU120:
	mov r1, r2
	add r2, r1, #8
	ldr r2, [r2]
	mov r0, #0
	cmp r2, #1
	moveq r0, #1
	cmp r0, #1
	beq .inline2_LU127
	b .inline2_LU128
.inline2_LU127:
	add r2, r1, #20
	ldr r2, [r2]
	mov r0, #0
	cmp r2, #1
	moveq r0, #1
	cmp r0, #1
	beq .inline2_LU130
	b .inline2_LU131
.inline2_LU130:
	add r2, r1, #32
	ldr r2, [r2]
	mov r0, #0
	cmp r2, #1
	moveq r0, #1
	cmp r0, #1
	beq .inline2_LU133
	b .inline2_LU134
.inline2_LU133:
	movw r2, #0
	b .inline2_LU35
.inline2_LU134:
	b .inline2_LU135
.inline2_LU135:
	mov r2, r1
	b .inline2_LU132
.inline2_LU131:
	mov r2, r1
	b .inline2_LU132
.inline2_LU132:
	b .inline2_LU129
.inline2_LU128:
	mov r2, r1
	b .inline2_LU129
.inline2_LU129:
	mov r1, r2
	add r2, r1, #8
	ldr r0, [r2]
	mov r2, #0
	cmp r0, #2
	moveq r2, #1
	cmp r2, #1
	beq .inline2_LU136
	b .inline2_LU137
.inline2_LU136:
	add r2, r1, #20
	ldr r0, [r2]
	mov r2, #0
	cmp r0, #2
	moveq r2, #1
	cmp r2, #1
	beq .inline2_LU139
	b .inline2_LU140
.inline2_LU139:
	add r2, r1, #32
	ldr r2, [r2]
	mov r0, #0
	cmp r2, #2
	moveq r0, #1
	cmp r0, #1
	beq .inline2_LU142
	b .inline2_LU143
.inline2_LU142:
	movw r2, #1
	b .inline2_LU35
.inline2_LU143:
	b .inline2_LU144
.inline2_LU144:
	b .inline2_LU141
.inline2_LU140:
	b .inline2_LU141
.inline2_LU141:
	b .inline2_LU138
.inline2_LU137:
	b .inline2_LU138
.inline2_LU138:
	movw r2, #:lower16:-1
	movt r2, #:upper16:-1
	b .inline2_LU35
.inline2_LU35:
	b .next2
.next2:
	add r1, r5, #1
	mov r5, #0
	cmp r2, #0
	movlt r5, #1
	mov r0, #0
	cmp r1, #8
	movne r0, #1
	and r0, r5, r0
	mov r5, r2
	mov r2, r6
	mov r6, r4
	cmp r0, #1
	beq .LU147
	b .LU148
.LU148:
	mov r2, r5
	add r2, r2, #1
	mov r1, r2
	movw r0, #:lower16:.PRINTLN_FMT
	movt r0, #:upper16:.PRINTLN_FMT
	bl printf
	b .LU145
.LU145:
	movw r0, #0
	pop {r4, r5, r6}
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
