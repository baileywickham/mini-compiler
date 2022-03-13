	.arch armv7-a
	.comm	.read_scratch,4,4

	.text
	.align 2
	.global cleanBoard
cleanBoard:
.LU1:
	push {fp, lr}
	add fp, sp, #4
	mov r1, r0
	mov r2, r1
	movw r0, #0
	str r0, [r2]
	add r0, r1, #4
	movw r2, #0
	str r2, [r0]
	add r2, r1, #8
	movw r0, #0
	str r0, [r2]
	add r2, r1, #12
	movw r0, #0
	str r0, [r2]
	add r0, r1, #16
	movw r2, #0
	str r2, [r0]
	add r0, r1, #20
	movw r2, #0
	str r2, [r0]
	add r2, r1, #24
	movw r0, #0
	str r0, [r2]
	add r0, r1, #28
	movw r2, #0
	str r2, [r0]
	add r1, r1, #32
	movw r2, #0
	str r2, [r1]
	b .LU0
.LU0:
	pop {fp, pc}
	.size cleanBoard, .-cleanBoard
	.align 2
	.global printBoard
printBoard:
.LU3:
	push {fp, lr}
	add fp, sp, #4
	push {r4}
	mov r4, r0
	mov r1, r4
	ldr r1, [r1]
	movw r0, #:lower16:.PRINT_FMT
	movt r0, #:upper16:.PRINT_FMT
	bl printf
	add r1, r4, #4
	ldr r1, [r1]
	movw r0, #:lower16:.PRINT_FMT
	movt r0, #:upper16:.PRINT_FMT
	bl printf
	add r1, r4, #8
	ldr r1, [r1]
	movw r0, #:lower16:.PRINTLN_FMT
	movt r0, #:upper16:.PRINTLN_FMT
	bl printf
	add r1, r4, #12
	ldr r1, [r1]
	movw r0, #:lower16:.PRINT_FMT
	movt r0, #:upper16:.PRINT_FMT
	bl printf
	add r1, r4, #16
	ldr r1, [r1]
	movw r0, #:lower16:.PRINT_FMT
	movt r0, #:upper16:.PRINT_FMT
	bl printf
	add r1, r4, #20
	ldr r1, [r1]
	movw r0, #:lower16:.PRINTLN_FMT
	movt r0, #:upper16:.PRINTLN_FMT
	bl printf
	add r1, r4, #24
	ldr r1, [r1]
	movw r0, #:lower16:.PRINT_FMT
	movt r0, #:upper16:.PRINT_FMT
	bl printf
	add r1, r4, #28
	ldr r1, [r1]
	movw r0, #:lower16:.PRINT_FMT
	movt r0, #:upper16:.PRINT_FMT
	bl printf
	add r4, r4, #32
	ldr r4, [r4]
	mov r1, r4
	movw r0, #:lower16:.PRINTLN_FMT
	movt r0, #:upper16:.PRINTLN_FMT
	bl printf
	b .LU2
.LU2:
	pop {r4}
	pop {fp, pc}
	.size printBoard, .-printBoard
	.align 2
	.global printMoveBoard
printMoveBoard:
.LU5:
	push {fp, lr}
	add fp, sp, #4
	movw r1, #123
	movw r0, #:lower16:.PRINTLN_FMT
	movt r0, #:upper16:.PRINTLN_FMT
	bl printf
	movw r1, #456
	movw r0, #:lower16:.PRINTLN_FMT
	movt r0, #:upper16:.PRINTLN_FMT
	bl printf
	movw r1, #789
	movw r0, #:lower16:.PRINTLN_FMT
	movt r0, #:upper16:.PRINTLN_FMT
	bl printf
	b .LU4
.LU4:
	pop {fp, pc}
	.size printMoveBoard, .-printMoveBoard
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
	str r1, [r0]
	b .LU10
.LU9:
	mov r3, #0
	cmp r2, #2
	moveq r3, #1
	cmp r3, #1
	beq .LU11
	b .LU12
.LU11:
	add r0, r0, #4
	str r1, [r0]
	b .LU13
.LU12:
	mov r3, #0
	cmp r2, #3
	moveq r3, #1
	cmp r3, #1
	beq .LU14
	b .LU15
.LU14:
	add r0, r0, #8
	str r1, [r0]
	b .LU16
.LU15:
	mov r3, #0
	cmp r2, #4
	moveq r3, #1
	cmp r3, #1
	beq .LU17
	b .LU18
.LU17:
	add r0, r0, #12
	str r1, [r0]
	b .LU19
.LU18:
	mov r3, #0
	cmp r2, #5
	moveq r3, #1
	cmp r3, #1
	beq .LU20
	b .LU21
.LU20:
	add r0, r0, #16
	str r1, [r0]
	b .LU22
.LU21:
	mov r3, #0
	cmp r2, #6
	moveq r3, #1
	cmp r3, #1
	beq .LU23
	b .LU24
.LU23:
	add r0, r0, #20
	str r1, [r0]
	b .LU25
.LU24:
	mov r3, #0
	cmp r2, #7
	moveq r3, #1
	cmp r3, #1
	beq .LU26
	b .LU27
.LU26:
	add r0, r0, #24
	str r1, [r0]
	b .LU28
.LU27:
	mov r3, #0
	cmp r2, #8
	moveq r3, #1
	cmp r3, #1
	beq .LU29
	b .LU30
.LU29:
	add r0, r0, #28
	str r1, [r0]
	b .LU31
.LU30:
	mov r3, #0
	cmp r2, #9
	moveq r3, #1
	cmp r3, #1
	beq .LU32
	b .LU33
.LU32:
	add r0, r0, #32
	str r1, [r0]
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
	.global checkWinner
checkWinner:
.LU36:
	push {fp, lr}
	add fp, sp, #4
	mov r2, r0
	mov r3, r2
	ldr r3, [r3]
	mov r1, #0
	cmp r3, #1
	moveq r1, #1
	cmp r1, #1
	beq .LU37
	b .LU38
.LU37:
	add r3, r2, #4
	ldr r3, [r3]
	mov r1, #0
	cmp r3, #1
	moveq r1, #1
	cmp r1, #1
	beq .LU40
	b .LU41
.LU40:
	add r3, r2, #8
	ldr r1, [r3]
	mov r3, #0
	cmp r1, #1
	moveq r3, #1
	cmp r3, #1
	beq .LU43
	b .LU44
.LU43:
	movw r2, #0
	b .LU35
.LU44:
	b .LU45
.LU45:
	b .LU42
.LU41:
	b .LU42
.LU42:
	b .LU39
.LU38:
	b .LU39
.LU39:
	mov r3, r2
	ldr r3, [r3]
	mov r1, #0
	cmp r3, #2
	moveq r1, #1
	cmp r1, #1
	beq .LU46
	b .LU47
.LU46:
	add r3, r2, #4
	ldr r3, [r3]
	mov r1, #0
	cmp r3, #2
	moveq r1, #1
	cmp r1, #1
	beq .LU49
	b .LU50
.LU49:
	add r3, r2, #8
	ldr r1, [r3]
	mov r3, #0
	cmp r1, #2
	moveq r3, #1
	cmp r3, #1
	beq .LU52
	b .LU53
.LU52:
	movw r2, #1
	b .LU35
.LU53:
	b .LU54
.LU54:
	b .LU51
.LU50:
	b .LU51
.LU51:
	b .LU48
.LU47:
	b .LU48
.LU48:
	add r3, r2, #12
	ldr r3, [r3]
	mov r1, #0
	cmp r3, #1
	moveq r1, #1
	cmp r1, #1
	beq .LU55
	b .LU56
.LU55:
	add r3, r2, #16
	ldr r1, [r3]
	mov r3, #0
	cmp r1, #1
	moveq r3, #1
	cmp r3, #1
	beq .LU58
	b .LU59
.LU58:
	add r3, r2, #20
	ldr r1, [r3]
	mov r3, #0
	cmp r1, #1
	moveq r3, #1
	cmp r3, #1
	beq .LU61
	b .LU62
.LU61:
	movw r2, #0
	b .LU35
.LU62:
	b .LU63
.LU63:
	b .LU60
.LU59:
	b .LU60
.LU60:
	b .LU57
.LU56:
	b .LU57
.LU57:
	add r3, r2, #12
	ldr r3, [r3]
	mov r1, #0
	cmp r3, #2
	moveq r1, #1
	cmp r1, #1
	beq .LU64
	b .LU65
.LU64:
	add r3, r2, #16
	ldr r1, [r3]
	mov r3, #0
	cmp r1, #2
	moveq r3, #1
	cmp r3, #1
	beq .LU67
	b .LU68
.LU67:
	add r3, r2, #20
	ldr r1, [r3]
	mov r3, #0
	cmp r1, #2
	moveq r3, #1
	cmp r3, #1
	beq .LU70
	b .LU71
.LU70:
	movw r2, #1
	b .LU35
.LU71:
	b .LU72
.LU72:
	b .LU69
.LU68:
	b .LU69
.LU69:
	b .LU66
.LU65:
	b .LU66
.LU66:
	add r3, r2, #24
	ldr r1, [r3]
	mov r3, #0
	cmp r1, #1
	moveq r3, #1
	cmp r3, #1
	beq .LU73
	b .LU74
.LU73:
	add r3, r2, #28
	ldr r3, [r3]
	mov r1, #0
	cmp r3, #1
	moveq r1, #1
	cmp r1, #1
	beq .LU76
	b .LU77
.LU76:
	add r3, r2, #32
	ldr r3, [r3]
	mov r1, #0
	cmp r3, #1
	moveq r1, #1
	cmp r1, #1
	beq .LU79
	b .LU80
.LU79:
	movw r2, #0
	b .LU35
.LU80:
	b .LU81
.LU81:
	b .LU78
.LU77:
	b .LU78
.LU78:
	b .LU75
.LU74:
	b .LU75
.LU75:
	add r3, r2, #24
	ldr r1, [r3]
	mov r3, #0
	cmp r1, #2
	moveq r3, #1
	cmp r3, #1
	beq .LU82
	b .LU83
.LU82:
	add r3, r2, #28
	ldr r1, [r3]
	mov r3, #0
	cmp r1, #2
	moveq r3, #1
	cmp r3, #1
	beq .LU85
	b .LU86
.LU85:
	add r3, r2, #32
	ldr r3, [r3]
	mov r1, #0
	cmp r3, #2
	moveq r1, #1
	cmp r1, #1
	beq .LU88
	b .LU89
.LU88:
	movw r2, #1
	b .LU35
.LU89:
	b .LU90
.LU90:
	b .LU87
.LU86:
	b .LU87
.LU87:
	b .LU84
.LU83:
	b .LU84
.LU84:
	mov r3, r2
	ldr r1, [r3]
	mov r3, #0
	cmp r1, #1
	moveq r3, #1
	cmp r3, #1
	beq .LU91
	b .LU92
.LU91:
	add r3, r2, #12
	ldr r3, [r3]
	mov r1, #0
	cmp r3, #1
	moveq r1, #1
	cmp r1, #1
	beq .LU94
	b .LU95
.LU94:
	add r3, r2, #24
	ldr r3, [r3]
	mov r1, #0
	cmp r3, #1
	moveq r1, #1
	cmp r1, #1
	beq .LU97
	b .LU98
.LU97:
	movw r2, #0
	b .LU35
.LU98:
	b .LU99
.LU99:
	b .LU96
.LU95:
	b .LU96
.LU96:
	b .LU93
.LU92:
	b .LU93
.LU93:
	mov r3, r2
	ldr r3, [r3]
	mov r1, #0
	cmp r3, #2
	moveq r1, #1
	cmp r1, #1
	beq .LU100
	b .LU101
.LU100:
	add r3, r2, #12
	ldr r1, [r3]
	mov r3, #0
	cmp r1, #2
	moveq r3, #1
	cmp r3, #1
	beq .LU103
	b .LU104
.LU103:
	add r3, r2, #24
	ldr r3, [r3]
	mov r1, #0
	cmp r3, #2
	moveq r1, #1
	cmp r1, #1
	beq .LU106
	b .LU107
.LU106:
	movw r2, #1
	b .LU35
.LU107:
	b .LU108
.LU108:
	b .LU105
.LU104:
	b .LU105
.LU105:
	b .LU102
.LU101:
	b .LU102
.LU102:
	add r3, r2, #4
	ldr r1, [r3]
	mov r3, #0
	cmp r1, #1
	moveq r3, #1
	cmp r3, #1
	beq .LU109
	b .LU110
.LU109:
	add r3, r2, #16
	ldr r3, [r3]
	mov r1, #0
	cmp r3, #1
	moveq r1, #1
	cmp r1, #1
	beq .LU112
	b .LU113
.LU112:
	add r3, r2, #28
	ldr r3, [r3]
	mov r1, #0
	cmp r3, #1
	moveq r1, #1
	cmp r1, #1
	beq .LU115
	b .LU116
.LU115:
	movw r2, #0
	b .LU35
.LU116:
	b .LU117
.LU117:
	b .LU114
.LU113:
	b .LU114
.LU114:
	b .LU111
.LU110:
	b .LU111
.LU111:
	add r3, r2, #4
	ldr r1, [r3]
	mov r3, #0
	cmp r1, #2
	moveq r3, #1
	cmp r3, #1
	beq .LU118
	b .LU119
.LU118:
	add r3, r2, #16
	ldr r3, [r3]
	mov r1, #0
	cmp r3, #2
	moveq r1, #1
	cmp r1, #1
	beq .LU121
	b .LU122
.LU121:
	add r3, r2, #28
	ldr r3, [r3]
	mov r1, #0
	cmp r3, #2
	moveq r1, #1
	cmp r1, #1
	beq .LU124
	b .LU125
.LU124:
	movw r2, #1
	b .LU35
.LU125:
	b .LU126
.LU126:
	b .LU123
.LU122:
	b .LU123
.LU123:
	b .LU120
.LU119:
	b .LU120
.LU120:
	add r3, r2, #8
	ldr r3, [r3]
	mov r1, #0
	cmp r3, #1
	moveq r1, #1
	cmp r1, #1
	beq .LU127
	b .LU128
.LU127:
	add r3, r2, #20
	ldr r1, [r3]
	mov r3, #0
	cmp r1, #1
	moveq r3, #1
	cmp r3, #1
	beq .LU130
	b .LU131
.LU130:
	add r3, r2, #32
	ldr r3, [r3]
	mov r1, #0
	cmp r3, #1
	moveq r1, #1
	cmp r1, #1
	beq .LU133
	b .LU134
.LU133:
	movw r2, #0
	b .LU35
.LU134:
	b .LU135
.LU135:
	b .LU132
.LU131:
	b .LU132
.LU132:
	b .LU129
.LU128:
	b .LU129
.LU129:
	add r3, r2, #8
	ldr r1, [r3]
	mov r3, #0
	cmp r1, #2
	moveq r3, #1
	cmp r3, #1
	beq .LU136
	b .LU137
.LU136:
	add r3, r2, #20
	ldr r3, [r3]
	mov r1, #0
	cmp r3, #2
	moveq r1, #1
	cmp r1, #1
	beq .LU139
	b .LU140
.LU139:
	add r2, r2, #32
	ldr r3, [r2]
	mov r2, #0
	cmp r3, #2
	moveq r2, #1
	cmp r2, #1
	beq .LU142
	b .LU143
.LU142:
	movw r2, #1
	b .LU35
.LU143:
	b .LU144
.LU144:
	b .LU141
.LU140:
	b .LU141
.LU141:
	b .LU138
.LU137:
	b .LU138
.LU138:
	movw r2, #0
	sub r2, r2, #1
	b .LU35
.LU35:
	mov r0, r2
	pop {fp, pc}
	.size checkWinner, .-checkWinner
	.align 2
	.global main
main:
.LU146:
	push {fp, lr}
	add fp, sp, #4
	push {r4, r5, r6}
	movw r4, #0
	sub r4, r4, #1
	movw r0, #36
	bl malloc
	mov r5, r0
	mov r0, r5
	bl cleanBoard
	mov r2, #0
	cmp r4, #0
	movlt r2, #1
	movw r6, #0
	mov r1, #0
	cmp r6, #8
	movne r1, #1
	and r6, r2, r1
	mov r2, r4
	movw r1, #0
	movw r4, #0
	cmp r6, #1
	beq .LU147
	b .LU148
.LU147:
	mov r6, r1
	mov r0, r5
	bl printBoard
	mov r1, #0
	cmp r6, #0
	moveq r1, #1
	cmp r1, #1
	beq .LU149
	b .LU150
.LU149:
	add r6, r6, #1
	movw r1, #:lower16:.read_scratch
	movt r1, #:upper16:.read_scratch
	movw r0, #:lower16:.READ_FMT
	movt r0, #:upper16:.READ_FMT
	bl scanf
	movw r1, #:lower16:.read_scratch
	movt r1, #:upper16:.read_scratch
	ldr r1, [r1]
	mov r2, r1
	movw r1, #1
	mov r0, r5
	bl placePiece
	mov r1, r4
	mov r4, r6
	b .LU151
.LU150:
	sub r6, r6, #1
	movw r1, #:lower16:.read_scratch
	movt r1, #:upper16:.read_scratch
	movw r0, #:lower16:.READ_FMT
	movt r0, #:upper16:.READ_FMT
	bl scanf
	movw r1, #:lower16:.read_scratch
	movt r1, #:upper16:.read_scratch
	ldr r1, [r1]
	mov r2, r1
	movw r1, #2
	mov r0, r5
	bl placePiece
	mov r1, r4
	mov r4, r6
	b .LU151
.LU151:
	mov r6, r1
	mov r0, r5
	bl checkWinner
	mov r1, r0
	add r6, r6, #1
	mov r0, #0
	cmp r1, #0
	movlt r0, #1
	mov r2, #0
	cmp r6, #8
	movne r2, #1
	and r0, r0, r2
	mov r2, r1
	mov r1, r4
	mov r4, r6
	cmp r0, #1
	beq .LU147
	b .LU148
.LU148:
	mov r4, r2
	add r4, r4, #1
	mov r1, r4
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
