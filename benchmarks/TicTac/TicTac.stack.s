	.arch armv7-a


	.text
	.align 2
	.global cleanBoard
cleanBoard:
.LU1:
	push {fp, lr}
	add fp, sp, #4
	sub sp, sp, #4
	mov r1, r0
	str r1, [sp, #0]
	ldr r1, [sp, #0]
	mov r2, r1
	movw r1, #0
	str r1, [r2]
	ldr r1, [sp, #0]
	add r1, r1, #4
	movw r2, #0
	str r2, [r1]
	ldr r1, [sp, #0]
	add r2, r1, #8
	movw r1, #0
	str r1, [r2]
	ldr r1, [sp, #0]
	add r2, r1, #12
	movw r1, #0
	str r1, [r2]
	ldr r1, [sp, #0]
	add r2, r1, #16
	movw r1, #0
	str r1, [r2]
	ldr r1, [sp, #0]
	add r2, r1, #20
	movw r1, #0
	str r1, [r2]
	ldr r1, [sp, #0]
	add r2, r1, #24
	movw r1, #0
	str r1, [r2]
	ldr r1, [sp, #0]
	add r1, r1, #28
	movw r2, #0
	str r2, [r1]
	ldr r1, [sp, #0]
	add r2, r1, #32
	movw r1, #0
	str r1, [r2]
	b .LU0
.LU0:
	add sp, sp, #4
	pop {fp, pc}
	.size cleanBoard, .-cleanBoard
	.align 2
	.global printBoard
printBoard:
.LU3:
	push {fp, lr}
	add fp, sp, #4
	sub sp, sp, #4
	mov r1, r0
	str r1, [sp, #0]
	ldr r1, [sp, #0]
	ldr r1, [r1]
	movw r0, #:lower16:.PRINT_FMT
	movt r0, #:upper16:.PRINT_FMT
	bl printf
	ldr r1, [sp, #0]
	add r1, r1, #4
	ldr r1, [r1]
	movw r0, #:lower16:.PRINT_FMT
	movt r0, #:upper16:.PRINT_FMT
	bl printf
	ldr r1, [sp, #0]
	add r1, r1, #8
	ldr r1, [r1]
	movw r0, #:lower16:.PRINTLN_FMT
	movt r0, #:upper16:.PRINTLN_FMT
	bl printf
	ldr r1, [sp, #0]
	add r1, r1, #12
	ldr r1, [r1]
	movw r0, #:lower16:.PRINT_FMT
	movt r0, #:upper16:.PRINT_FMT
	bl printf
	ldr r1, [sp, #0]
	add r1, r1, #16
	ldr r1, [r1]
	movw r0, #:lower16:.PRINT_FMT
	movt r0, #:upper16:.PRINT_FMT
	bl printf
	ldr r1, [sp, #0]
	add r1, r1, #20
	ldr r1, [r1]
	movw r0, #:lower16:.PRINTLN_FMT
	movt r0, #:upper16:.PRINTLN_FMT
	bl printf
	ldr r1, [sp, #0]
	add r1, r1, #24
	ldr r1, [r1]
	movw r0, #:lower16:.PRINT_FMT
	movt r0, #:upper16:.PRINT_FMT
	bl printf
	ldr r1, [sp, #0]
	add r1, r1, #28
	ldr r1, [r1]
	movw r0, #:lower16:.PRINT_FMT
	movt r0, #:upper16:.PRINT_FMT
	bl printf
	ldr r1, [sp, #0]
	add r1, r1, #32
	ldr r1, [r1]
	movw r0, #:lower16:.PRINTLN_FMT
	movt r0, #:upper16:.PRINTLN_FMT
	bl printf
	b .LU2
.LU2:
	add sp, sp, #4
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
	sub sp, sp, #12
	str r0, [sp, #0]
	str r1, [sp, #4]
	str r2, [sp, #8]
	ldr r0, [sp, #8]
	mov r2, #0
	cmp r0, #1
	moveq r2, #1
	cmp r2, #1
	beq .LU8
	b .LU9
.LU8:
	ldr r2, [sp, #4]
	ldr r0, [sp, #0]
	str r2, [r0]
	b .LU10
.LU9:
	ldr r0, [sp, #8]
	mov r2, #0
	cmp r0, #2
	moveq r2, #1
	cmp r2, #1
	beq .LU11
	b .LU12
.LU11:
	ldr r2, [sp, #4]
	ldr r0, [sp, #0]
	add r0, r0, #4
	str r2, [r0]
	b .LU13
.LU12:
	ldr r2, [sp, #8]
	mov r0, #0
	cmp r2, #3
	moveq r0, #1
	cmp r0, #1
	beq .LU14
	b .LU15
.LU14:
	ldr r2, [sp, #4]
	ldr r0, [sp, #0]
	add r0, r0, #8
	str r2, [r0]
	b .LU16
.LU15:
	ldr r0, [sp, #8]
	mov r2, #0
	cmp r0, #4
	moveq r2, #1
	cmp r2, #1
	beq .LU17
	b .LU18
.LU17:
	ldr r2, [sp, #4]
	ldr r0, [sp, #0]
	add r0, r0, #12
	str r2, [r0]
	b .LU19
.LU18:
	ldr r0, [sp, #8]
	mov r2, #0
	cmp r0, #5
	moveq r2, #1
	cmp r2, #1
	beq .LU20
	b .LU21
.LU20:
	ldr r2, [sp, #4]
	ldr r0, [sp, #0]
	add r0, r0, #16
	str r2, [r0]
	b .LU22
.LU21:
	ldr r0, [sp, #8]
	mov r2, #0
	cmp r0, #6
	moveq r2, #1
	cmp r2, #1
	beq .LU23
	b .LU24
.LU23:
	ldr r2, [sp, #4]
	ldr r0, [sp, #0]
	add r0, r0, #20
	str r2, [r0]
	b .LU25
.LU24:
	ldr r2, [sp, #8]
	mov r0, #0
	cmp r2, #7
	moveq r0, #1
	cmp r0, #1
	beq .LU26
	b .LU27
.LU26:
	ldr r2, [sp, #4]
	ldr r0, [sp, #0]
	add r0, r0, #24
	str r2, [r0]
	b .LU28
.LU27:
	ldr r0, [sp, #8]
	mov r2, #0
	cmp r0, #8
	moveq r2, #1
	cmp r2, #1
	beq .LU29
	b .LU30
.LU29:
	ldr r2, [sp, #4]
	ldr r0, [sp, #0]
	add r0, r0, #28
	str r2, [r0]
	b .LU31
.LU30:
	ldr r0, [sp, #8]
	mov r2, #0
	cmp r0, #9
	moveq r2, #1
	cmp r2, #1
	beq .LU32
	b .LU33
.LU32:
	ldr r2, [sp, #4]
	ldr r0, [sp, #0]
	add r0, r0, #32
	str r2, [r0]
	b .LU33
.LU33:
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
	add sp, sp, #12
	pop {fp, pc}
	.size placePiece, .-placePiece
	.align 2
	.global checkWinner
checkWinner:
.LU35:
	push {fp, lr}
	add fp, sp, #4
	sub sp, sp, #8
	mov r2, r0
	str r2, [sp, #0]
	ldr r2, [sp, #0]
	ldr r3, [r2]
	mov r2, #0
	cmp r3, #1
	moveq r2, #1
	cmp r2, #1
	beq .LU36
	b .LU37
.LU36:
	ldr r2, [sp, #0]
	add r2, r2, #4
	ldr r2, [r2]
	mov r3, #0
	cmp r2, #1
	moveq r3, #1
	cmp r3, #1
	beq .LU104
	b .LU105
.LU104:
	ldr r2, [sp, #0]
	add r2, r2, #8
	ldr r3, [r2]
	mov r2, #0
	cmp r3, #1
	moveq r2, #1
	cmp r2, #1
	beq .LU106
	b .LU107
.LU106:
	movw r2, #0
	str r2, [sp, #4]
	b .LU34
.LU107:
	b .LU105
.LU105:
	b .LU37
.LU37:
	ldr r2, [sp, #0]
	ldr r2, [r2]
	mov r3, #0
	cmp r2, #2
	moveq r3, #1
	cmp r3, #1
	beq .LU38
	b .LU39
.LU38:
	ldr r2, [sp, #0]
	add r2, r2, #4
	ldr r3, [r2]
	mov r2, #0
	cmp r3, #2
	moveq r2, #1
	cmp r2, #1
	beq .LU100
	b .LU101
.LU100:
	ldr r2, [sp, #0]
	add r2, r2, #8
	ldr r3, [r2]
	mov r2, #0
	cmp r3, #2
	moveq r2, #1
	cmp r2, #1
	beq .LU102
	b .LU103
.LU102:
	movw r2, #1
	str r2, [sp, #4]
	b .LU34
.LU103:
	b .LU101
.LU101:
	b .LU39
.LU39:
	ldr r2, [sp, #0]
	add r2, r2, #12
	ldr r2, [r2]
	mov r3, #0
	cmp r2, #1
	moveq r3, #1
	cmp r3, #1
	beq .LU40
	b .LU41
.LU40:
	ldr r2, [sp, #0]
	add r2, r2, #16
	ldr r3, [r2]
	mov r2, #0
	cmp r3, #1
	moveq r2, #1
	cmp r2, #1
	beq .LU96
	b .LU97
.LU96:
	ldr r2, [sp, #0]
	add r2, r2, #20
	ldr r2, [r2]
	mov r3, #0
	cmp r2, #1
	moveq r3, #1
	cmp r3, #1
	beq .LU98
	b .LU99
.LU98:
	movw r2, #0
	str r2, [sp, #4]
	b .LU34
.LU99:
	b .LU97
.LU97:
	b .LU41
.LU41:
	ldr r2, [sp, #0]
	add r2, r2, #12
	ldr r2, [r2]
	mov r3, #0
	cmp r2, #2
	moveq r3, #1
	cmp r3, #1
	beq .LU42
	b .LU43
.LU42:
	ldr r2, [sp, #0]
	add r2, r2, #16
	ldr r3, [r2]
	mov r2, #0
	cmp r3, #2
	moveq r2, #1
	cmp r2, #1
	beq .LU92
	b .LU93
.LU92:
	ldr r2, [sp, #0]
	add r2, r2, #20
	ldr r2, [r2]
	mov r3, #0
	cmp r2, #2
	moveq r3, #1
	cmp r3, #1
	beq .LU94
	b .LU95
.LU94:
	movw r2, #1
	str r2, [sp, #4]
	b .LU34
.LU95:
	b .LU93
.LU93:
	b .LU43
.LU43:
	ldr r2, [sp, #0]
	add r2, r2, #24
	ldr r3, [r2]
	mov r2, #0
	cmp r3, #1
	moveq r2, #1
	cmp r2, #1
	beq .LU44
	b .LU45
.LU44:
	ldr r2, [sp, #0]
	add r2, r2, #28
	ldr r3, [r2]
	mov r2, #0
	cmp r3, #1
	moveq r2, #1
	cmp r2, #1
	beq .LU88
	b .LU89
.LU88:
	ldr r2, [sp, #0]
	add r2, r2, #32
	ldr r2, [r2]
	mov r3, #0
	cmp r2, #1
	moveq r3, #1
	cmp r3, #1
	beq .LU90
	b .LU91
.LU90:
	movw r2, #0
	str r2, [sp, #4]
	b .LU34
.LU91:
	b .LU89
.LU89:
	b .LU45
.LU45:
	ldr r2, [sp, #0]
	add r2, r2, #24
	ldr r3, [r2]
	mov r2, #0
	cmp r3, #2
	moveq r2, #1
	cmp r2, #1
	beq .LU46
	b .LU47
.LU46:
	ldr r2, [sp, #0]
	add r2, r2, #28
	ldr r3, [r2]
	mov r2, #0
	cmp r3, #2
	moveq r2, #1
	cmp r2, #1
	beq .LU84
	b .LU85
.LU84:
	ldr r2, [sp, #0]
	add r2, r2, #32
	ldr r2, [r2]
	mov r3, #0
	cmp r2, #2
	moveq r3, #1
	cmp r3, #1
	beq .LU86
	b .LU87
.LU86:
	movw r2, #1
	str r2, [sp, #4]
	b .LU34
.LU87:
	b .LU85
.LU85:
	b .LU47
.LU47:
	ldr r2, [sp, #0]
	ldr r2, [r2]
	mov r3, #0
	cmp r2, #1
	moveq r3, #1
	cmp r3, #1
	beq .LU48
	b .LU49
.LU48:
	ldr r2, [sp, #0]
	add r2, r2, #12
	ldr r3, [r2]
	mov r2, #0
	cmp r3, #1
	moveq r2, #1
	cmp r2, #1
	beq .LU80
	b .LU81
.LU80:
	ldr r2, [sp, #0]
	add r2, r2, #24
	ldr r2, [r2]
	mov r3, #0
	cmp r2, #1
	moveq r3, #1
	cmp r3, #1
	beq .LU82
	b .LU83
.LU82:
	movw r2, #0
	str r2, [sp, #4]
	b .LU34
.LU83:
	b .LU81
.LU81:
	b .LU49
.LU49:
	ldr r2, [sp, #0]
	ldr r2, [r2]
	mov r3, #0
	cmp r2, #2
	moveq r3, #1
	cmp r3, #1
	beq .LU50
	b .LU51
.LU50:
	ldr r2, [sp, #0]
	add r2, r2, #12
	ldr r2, [r2]
	mov r3, #0
	cmp r2, #2
	moveq r3, #1
	cmp r3, #1
	beq .LU76
	b .LU77
.LU76:
	ldr r2, [sp, #0]
	add r2, r2, #24
	ldr r2, [r2]
	mov r3, #0
	cmp r2, #2
	moveq r3, #1
	cmp r3, #1
	beq .LU78
	b .LU79
.LU78:
	movw r2, #1
	str r2, [sp, #4]
	b .LU34
.LU79:
	b .LU77
.LU77:
	b .LU51
.LU51:
	ldr r2, [sp, #0]
	add r2, r2, #4
	ldr r2, [r2]
	mov r3, #0
	cmp r2, #1
	moveq r3, #1
	cmp r3, #1
	beq .LU52
	b .LU53
.LU52:
	ldr r2, [sp, #0]
	add r2, r2, #16
	ldr r3, [r2]
	mov r2, #0
	cmp r3, #1
	moveq r2, #1
	cmp r2, #1
	beq .LU72
	b .LU73
.LU72:
	ldr r2, [sp, #0]
	add r2, r2, #28
	ldr r2, [r2]
	mov r3, #0
	cmp r2, #1
	moveq r3, #1
	cmp r3, #1
	beq .LU74
	b .LU75
.LU74:
	movw r2, #0
	str r2, [sp, #4]
	b .LU34
.LU75:
	b .LU73
.LU73:
	b .LU53
.LU53:
	ldr r2, [sp, #0]
	add r2, r2, #4
	ldr r3, [r2]
	mov r2, #0
	cmp r3, #2
	moveq r2, #1
	cmp r2, #1
	beq .LU54
	b .LU55
.LU54:
	ldr r2, [sp, #0]
	add r2, r2, #16
	ldr r3, [r2]
	mov r2, #0
	cmp r3, #2
	moveq r2, #1
	cmp r2, #1
	beq .LU68
	b .LU69
.LU68:
	ldr r2, [sp, #0]
	add r2, r2, #28
	ldr r2, [r2]
	mov r3, #0
	cmp r2, #2
	moveq r3, #1
	cmp r3, #1
	beq .LU70
	b .LU71
.LU70:
	movw r2, #1
	str r2, [sp, #4]
	b .LU34
.LU71:
	b .LU69
.LU69:
	b .LU55
.LU55:
	ldr r2, [sp, #0]
	add r2, r2, #8
	ldr r3, [r2]
	mov r2, #0
	cmp r3, #1
	moveq r2, #1
	cmp r2, #1
	beq .LU56
	b .LU57
.LU56:
	ldr r2, [sp, #0]
	add r2, r2, #20
	ldr r3, [r2]
	mov r2, #0
	cmp r3, #1
	moveq r2, #1
	cmp r2, #1
	beq .LU64
	b .LU65
.LU64:
	ldr r2, [sp, #0]
	add r2, r2, #32
	ldr r3, [r2]
	mov r2, #0
	cmp r3, #1
	moveq r2, #1
	cmp r2, #1
	beq .LU66
	b .LU67
.LU66:
	movw r2, #0
	str r2, [sp, #4]
	b .LU34
.LU67:
	b .LU65
.LU65:
	b .LU57
.LU57:
	ldr r2, [sp, #0]
	add r2, r2, #8
	ldr r3, [r2]
	mov r2, #0
	cmp r3, #2
	moveq r2, #1
	cmp r2, #1
	beq .LU58
	b .LU59
.LU58:
	ldr r2, [sp, #0]
	add r2, r2, #20
	ldr r3, [r2]
	mov r2, #0
	cmp r3, #2
	moveq r2, #1
	cmp r2, #1
	beq .LU60
	b .LU61
.LU60:
	ldr r2, [sp, #0]
	add r2, r2, #32
	ldr r2, [r2]
	mov r3, #0
	cmp r2, #2
	moveq r3, #1
	cmp r3, #1
	beq .LU62
	b .LU63
.LU62:
	movw r2, #1
	str r2, [sp, #4]
	b .LU34
.LU63:
	b .LU61
.LU61:
	b .LU59
.LU59:
	movw r2, #0
	sub r2, r2, #1
	str r2, [sp, #4]
	b .LU34
.LU34:
	ldr r2, [sp, #4]
	mov r0, r2
	add sp, sp, #8
	pop {fp, pc}
	.size checkWinner, .-checkWinner
	.align 2
	.global main
main:
.LU109:
	push {fp, lr}
	add fp, sp, #4
	sub sp, sp, #28
	movw r1, #0
	str r1, [sp, #20]
	movw r1, #0
	str r1, [sp, #4]
	movw r1, #0
	str r1, [sp, #8]
	movw r1, #0
	str r1, [sp, #12]
	movw r1, #0
	sub r1, r1, #1
	str r1, [sp, #16]
	movw r0, #36
	bl malloc
	mov r1, r0
	str r1, [sp, #24]
	ldr r1, [sp, #24]
	mov r0, r1
	bl cleanBoard
	ldr r2, [sp, #16]
	mov r1, #0
	cmp r2, #0
	movlt r1, #1
	ldr r0, [sp, #20]
	mov r2, #0
	cmp r0, #8
	movne r2, #1
	and r1, r1, r2
	cmp r1, #1
	beq .LU110
	b .LU111
.LU110:
	ldr r1, [sp, #24]
	mov r0, r1
	bl printBoard
	ldr r2, [sp, #4]
	mov r1, #0
	cmp r2, #0
	moveq r1, #1
	cmp r1, #1
	beq .LU112
	b .LU113
.LU112:
	ldr r1, [sp, #4]
	add r1, r1, #1
	str r1, [sp, #4]
	add r1, sp, #8
	movw r0, #:lower16:.READ_FMT
	movt r0, #:upper16:.READ_FMT
	bl scanf
	ldr r0, [sp, #24]
	ldr r1, [sp, #8]
	mov r2, r1
	movw r1, #1
	bl placePiece
	b .LU114
.LU113:
	ldr r1, [sp, #4]
	sub r1, r1, #1
	str r1, [sp, #4]
	add r1, sp, #12
	movw r0, #:lower16:.READ_FMT
	movt r0, #:upper16:.READ_FMT
	bl scanf
	ldr r0, [sp, #24]
	ldr r1, [sp, #12]
	mov r2, r1
	movw r1, #2
	bl placePiece
	b .LU114
.LU114:
	ldr r1, [sp, #24]
	mov r0, r1
	bl checkWinner
	mov r1, r0
	str r1, [sp, #16]
	ldr r1, [sp, #20]
	add r1, r1, #1
	str r1, [sp, #20]
	ldr r2, [sp, #16]
	mov r1, #0
	cmp r2, #0
	movlt r1, #1
	ldr r2, [sp, #20]
	mov r0, #0
	cmp r2, #8
	movne r0, #1
	and r1, r1, r0
	cmp r1, #1
	beq .LU110
	b .LU111
.LU111:
	ldr r1, [sp, #16]
	add r1, r1, #1
	movw r0, #:lower16:.PRINTLN_FMT
	movt r0, #:upper16:.PRINTLN_FMT
	bl printf
	movw r1, #0
	str r1, [sp, #0]
	b .LU108
.LU108:
	ldr r1, [sp, #0]
	mov r0, r1
	add sp, sp, #28
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
