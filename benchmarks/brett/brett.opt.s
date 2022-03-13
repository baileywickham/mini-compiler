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
	.global main
main:
.LU36:
	push {fp, lr}
	add fp, sp, #4
	push {r4, r5, r6}
	movw r0, #0
	movw r3, #:lower16:counter
	movt r3, #:upper16:counter
	str r0, [r3]
	movw r0, #1
	bl printgroup
	movw r0, #0
	cmp r0, #1
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
	movw r0, #0
	cmp r0, #1
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
	movw r0, #0
	cmp r0, #1
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
	movw r0, #1
	cmp r0, #1
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
	movw r3, #0
	movw r0, #:lower16:counter
	movt r0, #:upper16:counter
	str r3, [r0]
	movw r0, #2
	bl printgroup
	movw r0, #1
	cmp r0, #1
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
	movw r0, #1
	cmp r0, #1
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
	movw r0, #1
	cmp r0, #1
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
	movw r0, #0
	cmp r0, #1
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
	movw r0, #1
	cmp r0, #1
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
	movw r0, #1
	cmp r0, #1
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
	movw r0, #0
	cmp r0, #1
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
	movw r0, #0
	cmp r0, #1
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
	movw r0, #0
	cmp r0, #1
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
	movw r0, #1
	cmp r0, #1
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
	movw r0, #1
	cmp r0, #1
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
	movw r0, #0
	cmp r0, #1
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
	movw r0, #0
	cmp r0, #1
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
	movw r0, #1
	cmp r0, #1
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
	movw r0, #1
	cmp r0, #1
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
	movw r0, #1
	cmp r0, #1
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
	movw r1, #5
	movw r0, #:lower16:.PRINTLN_FMT
	movt r0, #:upper16:.PRINTLN_FMT
	bl printf
	b .LU96
.LU96:
	movw r0, #1
	cmp r0, #1
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
	movw r1, #6
	movw r0, #:lower16:.PRINTLN_FMT
	movt r0, #:upper16:.PRINTLN_FMT
	bl printf
	b .LU99
.LU99:
	movw r0, #1
	cmp r0, #1
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
	movw r1, #1
	movw r0, #:lower16:.PRINTLN_FMT
	movt r0, #:upper16:.PRINTLN_FMT
	bl printf
	b .LU102
.LU102:
	movw r0, #1
	cmp r0, #1
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
	movw r1, #2
	movw r0, #:lower16:.PRINTLN_FMT
	movt r0, #:upper16:.PRINTLN_FMT
	bl printf
	b .LU105
.LU105:
	movw r0, #1
	cmp r0, #1
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
	movw r0, #1
	cmp r0, #1
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
	movw r0, #1
	cmp r0, #1
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
	movw r0, #1
	cmp r0, #1
	beq .LU115
	b .LU116
.LU115:
	movw r1, #1
	movw r0, #:lower16:.PRINTLN_FMT
	movt r0, #:upper16:.PRINTLN_FMT
	bl printf
	movw r0, #1
	b .LU117
.LU116:
	movw r1, #0
	movw r0, #:lower16:.PRINTLN_FMT
	movt r0, #:upper16:.PRINTLN_FMT
	bl printf
	movw r0, #1
	b .LU117
.LU117:
	movw r3, #1
	eor r0, r3, r0
	cmp r0, #1
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
	movw r0, #0
	cmp r0, #1
	beq .LU121
	b .LU122
.LU121:
	movw r1, #0
	movw r0, #:lower16:.PRINTLN_FMT
	movt r0, #:upper16:.PRINTLN_FMT
	bl printf
	movw r0, #0
	b .LU123
.LU122:
	movw r1, #1
	movw r0, #:lower16:.PRINTLN_FMT
	movt r0, #:upper16:.PRINTLN_FMT
	bl printf
	movw r0, #0
	b .LU123
.LU123:
	mov r4, r0
	mov r3, r4
	movw r0, #1
	eor r0, r0, r3
	cmp r0, #1
	beq .LU124
	b .LU125
.LU124:
	movw r1, #1
	movw r0, #:lower16:.PRINTLN_FMT
	movt r0, #:upper16:.PRINTLN_FMT
	bl printf
	mov r0, r4
	b .LU126
.LU125:
	movw r1, #0
	movw r0, #:lower16:.PRINTLN_FMT
	movt r0, #:upper16:.PRINTLN_FMT
	bl printf
	mov r0, r4
	b .LU126
.LU126:
	cmp r0, #1
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
	movw r1, #0
	movw r0, #0
	movw r3, #1
	cmp r3, #1
	beq .LU130
	b .LU131
.LU130:
	mov r4, r0
	mov r0, #0
	cmp r4, #5
	movge r0, #1
	cmp r0, #1
	beq .LU132
	b .LU133
.LU132:
	movw r1, #0
	movw r0, #:lower16:.PRINTLN_FMT
	movt r0, #:upper16:.PRINTLN_FMT
	bl printf
	mov r0, r4
	b .LU134
.LU133:
	mov r0, r4
	b .LU134
.LU134:
	add r0, r0, #5
	mov r3, #0
	cmp r0, #5
	movlt r3, #1
	mov r1, r0
	cmp r3, #1
	beq .LU130
	b .LU131
.LU131:
	mov r4, r1
	mov r0, #0
	cmp r4, #5
	moveq r0, #1
	cmp r0, #1
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
	mov r3, r4
	movw r0, #42
	str r0, [r3]
	add r3, r4, #4
	movw r0, #1
	str r0, [r3]
	mov r0, r4
	ldr r3, [r0]
	mov r0, #0
	cmp r3, #42
	moveq r0, #1
	cmp r0, #1
	beq .LU138
	b .LU139
.LU138:
	movw r1, #1
	movw r0, #:lower16:.PRINTLN_FMT
	movt r0, #:upper16:.PRINTLN_FMT
	bl printf
	mov r0, r4
	b .LU140
.LU139:
	movw r1, #0
	movw r0, #:lower16:.PRINT_FMT
	movt r0, #:upper16:.PRINT_FMT
	bl printf
	mov r0, r4
	ldr r0, [r0]
	mov r1, r0
	movw r0, #:lower16:.PRINTLN_FMT
	movt r0, #:upper16:.PRINTLN_FMT
	bl printf
	mov r0, r4
	b .LU140
.LU140:
	mov r4, r0
	add r0, r4, #4
	ldr r0, [r0]
	cmp r0, #1
	beq .LU141
	b .LU142
.LU141:
	movw r1, #1
	movw r0, #:lower16:.PRINTLN_FMT
	movt r0, #:upper16:.PRINTLN_FMT
	bl printf
	mov r0, r4
	b .LU143
.LU142:
	movw r1, #0
	movw r0, #:lower16:.PRINTLN_FMT
	movt r0, #:upper16:.PRINTLN_FMT
	bl printf
	mov r0, r4
	b .LU143
.LU143:
	mov r4, r0
	movw r0, #12
	bl malloc
	add r3, r4, #8
	str r0, [r3]
	add r0, r4, #8
	ldr r0, [r0]
	movw r3, #13
	str r3, [r0]
	add r0, r4, #8
	ldr r0, [r0]
	add r3, r0, #4
	movw r0, #0
	str r0, [r3]
	add r0, r4, #8
	ldr r0, [r0]
	ldr r0, [r0]
	mov r3, #0
	cmp r0, #13
	moveq r3, #1
	cmp r3, #1
	beq .LU144
	b .LU145
.LU144:
	movw r1, #1
	movw r0, #:lower16:.PRINTLN_FMT
	movt r0, #:upper16:.PRINTLN_FMT
	bl printf
	mov r0, r4
	b .LU146
.LU145:
	movw r1, #0
	movw r0, #:lower16:.PRINT_FMT
	movt r0, #:upper16:.PRINT_FMT
	bl printf
	add r0, r4, #8
	ldr r0, [r0]
	ldr r0, [r0]
	mov r1, r0
	movw r0, #:lower16:.PRINTLN_FMT
	movt r0, #:upper16:.PRINTLN_FMT
	bl printf
	mov r0, r4
	b .LU146
.LU146:
	mov r4, r0
	add r0, r4, #8
	ldr r0, [r0]
	add r0, r0, #4
	ldr r0, [r0]
	movw r3, #1
	eor r0, r3, r0
	cmp r0, #1
	beq .LU147
	b .LU148
.LU147:
	movw r1, #1
	movw r0, #:lower16:.PRINTLN_FMT
	movt r0, #:upper16:.PRINTLN_FMT
	bl printf
	mov r0, r4
	b .LU149
.LU148:
	movw r1, #0
	movw r0, #:lower16:.PRINTLN_FMT
	movt r0, #:upper16:.PRINTLN_FMT
	bl printf
	mov r0, r4
	b .LU149
.LU149:
	mov r4, r0
	mov r0, #0
	cmp r4, r4
	moveq r0, #1
	cmp r0, #1
	beq .LU150
	b .LU151
.LU150:
	movw r1, #1
	movw r0, #:lower16:.PRINTLN_FMT
	movt r0, #:upper16:.PRINTLN_FMT
	bl printf
	mov r0, r4
	b .LU152
.LU151:
	movw r1, #0
	movw r0, #:lower16:.PRINTLN_FMT
	movt r0, #:upper16:.PRINTLN_FMT
	bl printf
	mov r0, r4
	b .LU152
.LU152:
	mov r4, r0
	add r0, r4, #8
	ldr r0, [r0]
	mov r3, #0
	cmp r4, r0
	movne r3, #1
	cmp r3, #1
	beq .LU153
	b .LU154
.LU153:
	movw r1, #1
	movw r0, #:lower16:.PRINTLN_FMT
	movt r0, #:upper16:.PRINTLN_FMT
	bl printf
	mov r0, r4
	b .LU155
.LU154:
	movw r1, #0
	movw r0, #:lower16:.PRINTLN_FMT
	movt r0, #:upper16:.PRINTLN_FMT
	bl printf
	mov r0, r4
	b .LU155
.LU155:
	mov r4, r0
	add r0, r4, #8
	ldr r0, [r0]
	bl free
	mov r0, r4
	bl free
	movw r0, #8
	bl printgroup
	movw r0, #7
	movw r3, #:lower16:gi1
	movt r3, #:upper16:gi1
	str r0, [r3]
	movw r0, #:lower16:gi1
	movt r0, #:upper16:gi1
	ldr r0, [r0]
	mov r3, #0
	cmp r0, #7
	moveq r3, #1
	cmp r3, #1
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
	movw r0, #:lower16:gi1
	movt r0, #:upper16:gi1
	ldr r0, [r0]
	mov r1, r0
	movw r0, #:lower16:.PRINTLN_FMT
	movt r0, #:upper16:.PRINTLN_FMT
	bl printf
	b .LU158
.LU158:
	movw r3, #1
	movw r0, #:lower16:gb1
	movt r0, #:upper16:gb1
	str r3, [r0]
	movw r0, #:lower16:gb1
	movt r0, #:upper16:gb1
	ldr r0, [r0]
	cmp r0, #1
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
	mov r3, r0
	movw r0, #:lower16:gs1
	movt r0, #:upper16:gs1
	str r3, [r0]
	movw r0, #:lower16:gs1
	movt r0, #:upper16:gs1
	ldr r0, [r0]
	mov r3, r0
	movw r0, #34
	str r0, [r3]
	movw r0, #:lower16:gs1
	movt r0, #:upper16:gs1
	ldr r0, [r0]
	add r0, r0, #4
	movw r3, #0
	str r3, [r0]
	movw r0, #:lower16:gs1
	movt r0, #:upper16:gs1
	ldr r0, [r0]
	ldr r3, [r0]
	mov r0, #0
	cmp r3, #34
	moveq r0, #1
	cmp r0, #1
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
	movw r0, #:lower16:gs1
	movt r0, #:upper16:gs1
	ldr r0, [r0]
	ldr r0, [r0]
	mov r1, r0
	movw r0, #:lower16:.PRINTLN_FMT
	movt r0, #:upper16:.PRINTLN_FMT
	bl printf
	b .LU164
.LU164:
	movw r0, #:lower16:gs1
	movt r0, #:upper16:gs1
	ldr r0, [r0]
	add r0, r0, #4
	ldr r0, [r0]
	movw r3, #1
	eor r0, r3, r0
	cmp r0, #1
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
	mov r3, r0
	movw r0, #:lower16:gs1
	movt r0, #:upper16:gs1
	ldr r0, [r0]
	add r0, r0, #8
	str r3, [r0]
	movw r0, #:lower16:gs1
	movt r0, #:upper16:gs1
	ldr r0, [r0]
	add r0, r0, #8
	ldr r0, [r0]
	mov r3, r0
	movw r0, #16
	str r0, [r3]
	movw r0, #:lower16:gs1
	movt r0, #:upper16:gs1
	ldr r0, [r0]
	add r0, r0, #8
	ldr r0, [r0]
	add r3, r0, #4
	movw r0, #1
	str r0, [r3]
	movw r0, #:lower16:gs1
	movt r0, #:upper16:gs1
	ldr r0, [r0]
	add r0, r0, #8
	ldr r0, [r0]
	ldr r0, [r0]
	mov r3, #0
	cmp r0, #16
	moveq r3, #1
	cmp r3, #1
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
	movw r0, #:lower16:gs1
	movt r0, #:upper16:gs1
	ldr r0, [r0]
	add r0, r0, #8
	ldr r0, [r0]
	ldr r0, [r0]
	mov r1, r0
	movw r0, #:lower16:.PRINTLN_FMT
	movt r0, #:upper16:.PRINTLN_FMT
	bl printf
	b .LU170
.LU170:
	movw r0, #:lower16:gs1
	movt r0, #:upper16:gs1
	ldr r0, [r0]
	add r0, r0, #8
	ldr r0, [r0]
	add r0, r0, #4
	ldr r0, [r0]
	cmp r0, #1
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
	movw r0, #:lower16:gs1
	movt r0, #:upper16:gs1
	ldr r0, [r0]
	add r0, r0, #8
	ldr r0, [r0]
	bl free
	movw r0, #:lower16:gs1
	movt r0, #:upper16:gs1
	ldr r0, [r0]
	bl free
	movw r0, #9
	bl printgroup
	movw r0, #12
	bl malloc
	mov r4, r0
	add r3, r4, #4
	movw r0, #1
	str r0, [r3]
	b .inline0_LU5
.inline0_LU5:
	movw r0, #1
	cmp r0, #1
	beq .inline0_LU6
	b .inline0_LU7
.inline0_LU6:
	movw r1, #1
	movw r0, #:lower16:.PRINTLN_FMT
	movt r0, #:upper16:.PRINTLN_FMT
	bl printf
	movw r0, #1
	mov r3, r4
	b .inline0_LU8
.inline0_LU7:
	movw r1, #0
	movw r0, #:lower16:.PRINTLN_FMT
	movt r0, #:upper16:.PRINTLN_FMT
	bl printf
	movw r0, #1
	mov r3, r4
	b .inline0_LU8
.inline0_LU8:
	mov r4, r3
	cmp r0, #1
	beq .inline0_LU9
	b .inline0_LU10
.inline0_LU9:
	movw r1, #1
	movw r0, #:lower16:.PRINTLN_FMT
	movt r0, #:upper16:.PRINTLN_FMT
	bl printf
	mov r0, r4
	b .inline0_LU11
.inline0_LU10:
	movw r1, #0
	movw r0, #:lower16:.PRINTLN_FMT
	movt r0, #:upper16:.PRINTLN_FMT
	bl printf
	mov r0, r4
	b .inline0_LU11
.inline0_LU11:
	add r0, r0, #4
	ldr r0, [r0]
	cmp r0, #1
	beq .inline0_LU12
	b .inline0_LU13
.inline0_LU12:
	movw r1, #1
	movw r0, #:lower16:.PRINTLN_FMT
	movt r0, #:upper16:.PRINTLN_FMT
	bl printf
	b .inline0_LU14
.inline0_LU13:
	movw r1, #0
	movw r0, #:lower16:.PRINTLN_FMT
	movt r0, #:upper16:.PRINTLN_FMT
	bl printf
	b .inline0_LU14
.inline0_LU14:
	b .inline0_LU4
.inline0_LU4:
	b .next0
.next0:
	movw r1, #2
	movw r0, #:lower16:.PRINTLN_FMT
	movt r0, #:upper16:.PRINTLN_FMT
	bl printf
	b .inline1_LU16
.inline1_LU16:
	movw r0, #1
	cmp r0, #1
	beq .inline1_LU17
	b .inline1_LU18
.inline1_LU17:
	movw r1, #1
	movw r0, #:lower16:.PRINTLN_FMT
	movt r0, #:upper16:.PRINTLN_FMT
	bl printf
	movw r0, #6
	movw r3, #7
	movw r1, #8
	b .inline1_LU19
.inline1_LU18:
	movw r1, #0
	movw r0, #:lower16:.PRINT_FMT
	movt r0, #:upper16:.PRINT_FMT
	bl printf
	movw r1, #5
	movw r0, #:lower16:.PRINTLN_FMT
	movt r0, #:upper16:.PRINTLN_FMT
	bl printf
	movw r0, #6
	movw r3, #7
	movw r1, #8
	b .inline1_LU19
.inline1_LU19:
	mov r5, r1
	mov r6, r3
	mov r4, r0
	mov r0, #0
	cmp r4, #6
	moveq r0, #1
	cmp r0, #1
	beq .inline1_LU20
	b .inline1_LU21
.inline1_LU20:
	movw r1, #1
	movw r0, #:lower16:.PRINTLN_FMT
	movt r0, #:upper16:.PRINTLN_FMT
	bl printf
	mov r0, r6
	mov r3, r5
	b .inline1_LU22
.inline1_LU21:
	movw r1, #0
	movw r0, #:lower16:.PRINT_FMT
	movt r0, #:upper16:.PRINT_FMT
	bl printf
	mov r1, r4
	movw r0, #:lower16:.PRINTLN_FMT
	movt r0, #:upper16:.PRINTLN_FMT
	bl printf
	mov r0, r6
	mov r3, r5
	b .inline1_LU22
.inline1_LU22:
	mov r5, r3
	mov r4, r0
	mov r0, #0
	cmp r4, #7
	moveq r0, #1
	cmp r0, #1
	beq .inline1_LU23
	b .inline1_LU24
.inline1_LU23:
	movw r1, #1
	movw r0, #:lower16:.PRINTLN_FMT
	movt r0, #:upper16:.PRINTLN_FMT
	bl printf
	mov r0, r5
	b .inline1_LU25
.inline1_LU24:
	movw r1, #0
	movw r0, #:lower16:.PRINT_FMT
	movt r0, #:upper16:.PRINT_FMT
	bl printf
	mov r1, r4
	movw r0, #:lower16:.PRINTLN_FMT
	movt r0, #:upper16:.PRINTLN_FMT
	bl printf
	mov r0, r5
	b .inline1_LU25
.inline1_LU25:
	mov r4, r0
	mov r0, #0
	cmp r4, #8
	moveq r0, #1
	cmp r0, #1
	beq .inline1_LU26
	b .inline1_LU27
.inline1_LU26:
	movw r1, #1
	movw r0, #:lower16:.PRINTLN_FMT
	movt r0, #:upper16:.PRINTLN_FMT
	bl printf
	b .inline1_LU28
.inline1_LU27:
	movw r1, #0
	movw r0, #:lower16:.PRINT_FMT
	movt r0, #:upper16:.PRINT_FMT
	bl printf
	mov r1, r4
	movw r0, #:lower16:.PRINTLN_FMT
	movt r0, #:upper16:.PRINTLN_FMT
	bl printf
	b .inline1_LU28
.inline1_LU28:
	b .inline1_LU15
.inline1_LU15:
	b .next1
.next1:
	movw r1, #3
	movw r0, #:lower16:.PRINTLN_FMT
	movt r0, #:upper16:.PRINTLN_FMT
	bl printf
	b .inline2_LU30
.inline2_LU30:
	b .inline2_LU29
.inline2_LU29:
	b .next2
.next2:
	movw r0, #1
	cmp r0, #1
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
	movw r1, #3
	movw r0, #:lower16:.PRINTLN_FMT
	movt r0, #:upper16:.PRINTLN_FMT
	bl printf
	b .LU176
.LU176:
	b .inline3_LU32
.inline3_LU32:
	b .inline3_LU31
.inline3_LU31:
	b .next3
.next3:
	movw r0, #1
	cmp r0, #1
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
	b .inline4_LU34
.inline4_LU34:
	b .inline4_LU33
.inline4_LU33:
	b .next4
.next4:
	mov r3, #0
	cmp r0, r0
	moveq r3, #1
	cmp r3, #1
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
