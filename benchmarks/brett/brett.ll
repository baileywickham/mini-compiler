target triple="i686"
%struct.thing = type {i32, i32, %struct.thing*}

@gi1 = common global i32 0, align 4
@gb1 = common global i32 0, align 4
@gs1 = common global %struct.thing* null, align 4
@counter = common global i32 0, align 4

define void @printgroup(i32 %groupnum)
{
LU1:
	%_P_groupnum = alloca i32
	store i32 %groupnum, i32* %_P_groupnum
	call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([6 x i8], [6 x i8]* @.print, i32 0, i32 0), i32 1)
	call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([6 x i8], [6 x i8]* @.print, i32 0, i32 0), i32 0)
	call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([6 x i8], [6 x i8]* @.print, i32 0, i32 0), i32 1)
	call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([6 x i8], [6 x i8]* @.print, i32 0, i32 0), i32 0)
	call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([6 x i8], [6 x i8]* @.print, i32 0, i32 0), i32 1)
	call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([6 x i8], [6 x i8]* @.print, i32 0, i32 0), i32 0)
	%u1573 = load i32, i32* %_P_groupnum
	call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([6 x i8], [6 x i8]* @.println, i32 0, i32 0), i32 %u1573)
	br label %LU0
LU0:
	ret void
}

define i32 @setcounter(i32 %val)
{
LU3:
	%_P_val = alloca i32
	%_retval_ = alloca i32
	store i32 %val, i32* %_P_val
	%u1574 = load i32, i32* %_P_val
	store i32 %u1574, i32* @counter
	%u1575 = zext i1 true to i32
	store i32 %u1575, i32* %_retval_
	br label %LU2
LU2:
	%u1576 = load i32, i32* %_retval_
	ret i32 %u1576
}

define void @takealltypes(i32 %i, i32 %b, %struct.thing* %s)
{
LU5:
	%_P_i = alloca i32
	%_P_b = alloca i32
	%_P_s = alloca %struct.thing*
	store i32 %i, i32* %_P_i
	store i32 %b, i32* %_P_b
	store %struct.thing* %s, %struct.thing** %_P_s
	%u1577 = load i32, i32* %_P_i
	%u1578 = icmp eq i32 %u1577, 3
	br i1 %u1578, label %LU6, label %LU7
LU6:
	call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([6 x i8], [6 x i8]* @.println, i32 0, i32 0), i32 1)
	br label %LU8
LU7:
	call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([6 x i8], [6 x i8]* @.println, i32 0, i32 0), i32 0)
	br label %LU8
LU8:
	%u1579 = load i32, i32* %_P_b
	%u1580 = trunc i32 %u1579 to i1
	br i1 %u1580, label %LU9, label %LU10
LU9:
	call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([6 x i8], [6 x i8]* @.println, i32 0, i32 0), i32 1)
	br label %LU11
LU10:
	call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([6 x i8], [6 x i8]* @.println, i32 0, i32 0), i32 0)
	br label %LU11
LU11:
	%u1581 = load %struct.thing*, %struct.thing** %_P_s
	%u1582 = getelementptr %struct.thing, %struct.thing* %u1581, i1 0, i32 1
	%u1583 = load i32, i32* %u1582
	%u1584 = trunc i32 %u1583 to i1
	br i1 %u1584, label %LU12, label %LU13
LU12:
	call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([6 x i8], [6 x i8]* @.println, i32 0, i32 0), i32 1)
	br label %LU14
LU13:
	call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([6 x i8], [6 x i8]* @.println, i32 0, i32 0), i32 0)
	br label %LU14
LU14:
	br label %LU4
LU4:
	ret void
}

define void @tonofargs(i32 %a1, i32 %a2, i32 %a3, i32 %a4, i32 %a5, i32 %a6, i32 %a7, i32 %a8)
{
LU16:
	%_P_a1 = alloca i32
	%_P_a2 = alloca i32
	%_P_a3 = alloca i32
	%_P_a4 = alloca i32
	%_P_a5 = alloca i32
	%_P_a6 = alloca i32
	%_P_a7 = alloca i32
	%_P_a8 = alloca i32
	store i32 %a1, i32* %_P_a1
	store i32 %a2, i32* %_P_a2
	store i32 %a3, i32* %_P_a3
	store i32 %a4, i32* %_P_a4
	store i32 %a5, i32* %_P_a5
	store i32 %a6, i32* %_P_a6
	store i32 %a7, i32* %_P_a7
	store i32 %a8, i32* %_P_a8
	%u1585 = load i32, i32* %_P_a5
	%u1586 = icmp eq i32 %u1585, 5
	br i1 %u1586, label %LU17, label %LU18
LU17:
	call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([6 x i8], [6 x i8]* @.println, i32 0, i32 0), i32 1)
	br label %LU19
LU18:
	call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([6 x i8], [6 x i8]* @.print, i32 0, i32 0), i32 0)
	%u1587 = load i32, i32* %_P_a5
	call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([6 x i8], [6 x i8]* @.println, i32 0, i32 0), i32 %u1587)
	br label %LU19
LU19:
	%u1588 = load i32, i32* %_P_a6
	%u1589 = icmp eq i32 %u1588, 6
	br i1 %u1589, label %LU20, label %LU21
LU20:
	call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([6 x i8], [6 x i8]* @.println, i32 0, i32 0), i32 1)
	br label %LU22
LU21:
	call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([6 x i8], [6 x i8]* @.print, i32 0, i32 0), i32 0)
	%u1590 = load i32, i32* %_P_a6
	call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([6 x i8], [6 x i8]* @.println, i32 0, i32 0), i32 %u1590)
	br label %LU22
LU22:
	%u1591 = load i32, i32* %_P_a7
	%u1592 = icmp eq i32 %u1591, 7
	br i1 %u1592, label %LU23, label %LU24
LU23:
	call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([6 x i8], [6 x i8]* @.println, i32 0, i32 0), i32 1)
	br label %LU25
LU24:
	call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([6 x i8], [6 x i8]* @.print, i32 0, i32 0), i32 0)
	%u1593 = load i32, i32* %_P_a7
	call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([6 x i8], [6 x i8]* @.println, i32 0, i32 0), i32 %u1593)
	br label %LU25
LU25:
	%u1594 = load i32, i32* %_P_a8
	%u1595 = icmp eq i32 %u1594, 8
	br i1 %u1595, label %LU26, label %LU27
LU26:
	call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([6 x i8], [6 x i8]* @.println, i32 0, i32 0), i32 1)
	br label %LU28
LU27:
	call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([6 x i8], [6 x i8]* @.print, i32 0, i32 0), i32 0)
	%u1596 = load i32, i32* %_P_a8
	call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([6 x i8], [6 x i8]* @.println, i32 0, i32 0), i32 %u1596)
	br label %LU28
LU28:
	br label %LU15
LU15:
	ret void
}

define i32 @returnint(i32 %ret)
{
LU30:
	%_P_ret = alloca i32
	%_retval_ = alloca i32
	store i32 %ret, i32* %_P_ret
	%u1597 = load i32, i32* %_P_ret
	store i32 %u1597, i32* %_retval_
	br label %LU29
LU29:
	%u1598 = load i32, i32* %_retval_
	ret i32 %u1598
}

define i32 @returnbool(i32 %ret)
{
LU32:
	%_P_ret = alloca i32
	%_retval_ = alloca i32
	store i32 %ret, i32* %_P_ret
	%u1599 = load i32, i32* %_P_ret
	store i32 %u1599, i32* %_retval_
	br label %LU31
LU31:
	%u1600 = load i32, i32* %_retval_
	ret i32 %u1600
}

define %struct.thing* @returnstruct(%struct.thing* %ret)
{
LU34:
	%_P_ret = alloca %struct.thing*
	%_retval_ = alloca %struct.thing*
	store %struct.thing* %ret, %struct.thing** %_P_ret
	%u1601 = load %struct.thing*, %struct.thing** %_P_ret
	store %struct.thing* %u1601, %struct.thing** %_retval_
	br label %LU33
LU33:
	%u1602 = load %struct.thing*, %struct.thing** %_retval_
	ret %struct.thing* %u1602
}

define i32 @main()
{
LU36:
	%_retval_ = alloca i32
	%b1 = alloca i32
	%b2 = alloca i32
	%i1 = alloca i32
	%i2 = alloca i32
	%i3 = alloca i32
	%s1 = alloca %struct.thing*
	%s2 = alloca %struct.thing*
	store i32 0, i32* @counter
	call void @printgroup(i32 1)
	%u1603 = zext i1 false to i32
	store i32 %u1603, i32* %b1
	%u1604 = zext i1 false to i32
	store i32 %u1604, i32* %b2
	%u1605 = load i32, i32* %b1
	%u1606 = trunc i32 %u1605 to i1
	%u1607 = load i32, i32* %b2
	%u1608 = trunc i32 %u1607 to i1
	%u1609 = and i1 %u1606, %u1608
	br i1 %u1609, label %LU37, label %LU38
LU37:
	call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([6 x i8], [6 x i8]* @.println, i32 0, i32 0), i32 0)
	br label %LU39
LU38:
	call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([6 x i8], [6 x i8]* @.println, i32 0, i32 0), i32 1)
	br label %LU39
LU39:
	%u1610 = zext i1 true to i32
	store i32 %u1610, i32* %b1
	%u1611 = zext i1 false to i32
	store i32 %u1611, i32* %b2
	%u1612 = load i32, i32* %b1
	%u1613 = trunc i32 %u1612 to i1
	%u1614 = load i32, i32* %b2
	%u1615 = trunc i32 %u1614 to i1
	%u1616 = and i1 %u1613, %u1615
	br i1 %u1616, label %LU40, label %LU41
LU40:
	call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([6 x i8], [6 x i8]* @.println, i32 0, i32 0), i32 0)
	br label %LU42
LU41:
	call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([6 x i8], [6 x i8]* @.println, i32 0, i32 0), i32 1)
	br label %LU42
LU42:
	%u1617 = zext i1 false to i32
	store i32 %u1617, i32* %b1
	%u1618 = zext i1 true to i32
	store i32 %u1618, i32* %b2
	%u1619 = load i32, i32* %b1
	%u1620 = trunc i32 %u1619 to i1
	%u1621 = load i32, i32* %b2
	%u1622 = trunc i32 %u1621 to i1
	%u1623 = and i1 %u1620, %u1622
	br i1 %u1623, label %LU43, label %LU44
LU43:
	call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([6 x i8], [6 x i8]* @.println, i32 0, i32 0), i32 0)
	br label %LU45
LU44:
	call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([6 x i8], [6 x i8]* @.println, i32 0, i32 0), i32 1)
	br label %LU45
LU45:
	%u1624 = zext i1 true to i32
	store i32 %u1624, i32* %b1
	%u1625 = zext i1 true to i32
	store i32 %u1625, i32* %b2
	%u1626 = load i32, i32* %b1
	%u1627 = trunc i32 %u1626 to i1
	%u1628 = load i32, i32* %b2
	%u1629 = trunc i32 %u1628 to i1
	%u1630 = and i1 %u1627, %u1629
	br i1 %u1630, label %LU46, label %LU47
LU46:
	call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([6 x i8], [6 x i8]* @.println, i32 0, i32 0), i32 1)
	br label %LU48
LU47:
	call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([6 x i8], [6 x i8]* @.println, i32 0, i32 0), i32 0)
	br label %LU48
LU48:
	store i32 0, i32* @counter
	call void @printgroup(i32 2)
	%u1631 = zext i1 true to i32
	store i32 %u1631, i32* %b1
	%u1632 = zext i1 true to i32
	store i32 %u1632, i32* %b2
	%u1633 = load i32, i32* %b1
	%u1634 = trunc i32 %u1633 to i1
	%u1635 = load i32, i32* %b2
	%u1636 = trunc i32 %u1635 to i1
	%u1637 = or i1 %u1634, %u1636
	br i1 %u1637, label %LU49, label %LU50
LU49:
	call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([6 x i8], [6 x i8]* @.println, i32 0, i32 0), i32 1)
	br label %LU51
LU50:
	call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([6 x i8], [6 x i8]* @.println, i32 0, i32 0), i32 0)
	br label %LU51
LU51:
	%u1638 = zext i1 true to i32
	store i32 %u1638, i32* %b1
	%u1639 = zext i1 false to i32
	store i32 %u1639, i32* %b2
	%u1640 = load i32, i32* %b1
	%u1641 = trunc i32 %u1640 to i1
	%u1642 = load i32, i32* %b2
	%u1643 = trunc i32 %u1642 to i1
	%u1644 = or i1 %u1641, %u1643
	br i1 %u1644, label %LU52, label %LU53
LU52:
	call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([6 x i8], [6 x i8]* @.println, i32 0, i32 0), i32 1)
	br label %LU54
LU53:
	call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([6 x i8], [6 x i8]* @.println, i32 0, i32 0), i32 0)
	br label %LU54
LU54:
	%u1645 = zext i1 false to i32
	store i32 %u1645, i32* %b1
	%u1646 = zext i1 true to i32
	store i32 %u1646, i32* %b2
	%u1647 = load i32, i32* %b1
	%u1648 = trunc i32 %u1647 to i1
	%u1649 = load i32, i32* %b2
	%u1650 = trunc i32 %u1649 to i1
	%u1651 = or i1 %u1648, %u1650
	br i1 %u1651, label %LU55, label %LU56
LU55:
	call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([6 x i8], [6 x i8]* @.println, i32 0, i32 0), i32 1)
	br label %LU57
LU56:
	call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([6 x i8], [6 x i8]* @.println, i32 0, i32 0), i32 0)
	br label %LU57
LU57:
	%u1652 = zext i1 false to i32
	store i32 %u1652, i32* %b1
	%u1653 = zext i1 false to i32
	store i32 %u1653, i32* %b2
	%u1654 = load i32, i32* %b1
	%u1655 = trunc i32 %u1654 to i1
	%u1656 = load i32, i32* %b2
	%u1657 = trunc i32 %u1656 to i1
	%u1658 = or i1 %u1655, %u1657
	br i1 %u1658, label %LU58, label %LU59
LU58:
	call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([6 x i8], [6 x i8]* @.println, i32 0, i32 0), i32 0)
	br label %LU60
LU59:
	call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([6 x i8], [6 x i8]* @.println, i32 0, i32 0), i32 1)
	br label %LU60
LU60:
	call void @printgroup(i32 3)
	%u1659 = icmp sgt i32 42, 1
	br i1 %u1659, label %LU61, label %LU62
LU61:
	call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([6 x i8], [6 x i8]* @.println, i32 0, i32 0), i32 1)
	br label %LU63
LU62:
	call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([6 x i8], [6 x i8]* @.println, i32 0, i32 0), i32 0)
	br label %LU63
LU63:
	%u1660 = icmp sge i32 42, 1
	br i1 %u1660, label %LU64, label %LU65
LU64:
	call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([6 x i8], [6 x i8]* @.println, i32 0, i32 0), i32 1)
	br label %LU66
LU65:
	call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([6 x i8], [6 x i8]* @.println, i32 0, i32 0), i32 0)
	br label %LU66
LU66:
	%u1661 = icmp slt i32 42, 1
	br i1 %u1661, label %LU67, label %LU68
LU67:
	call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([6 x i8], [6 x i8]* @.println, i32 0, i32 0), i32 0)
	br label %LU69
LU68:
	call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([6 x i8], [6 x i8]* @.println, i32 0, i32 0), i32 1)
	br label %LU69
LU69:
	%u1662 = icmp sle i32 42, 1
	br i1 %u1662, label %LU70, label %LU71
LU70:
	call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([6 x i8], [6 x i8]* @.println, i32 0, i32 0), i32 0)
	br label %LU72
LU71:
	call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([6 x i8], [6 x i8]* @.println, i32 0, i32 0), i32 1)
	br label %LU72
LU72:
	%u1663 = icmp eq i32 42, 1
	br i1 %u1663, label %LU73, label %LU74
LU73:
	call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([6 x i8], [6 x i8]* @.println, i32 0, i32 0), i32 0)
	br label %LU75
LU74:
	call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([6 x i8], [6 x i8]* @.println, i32 0, i32 0), i32 1)
	br label %LU75
LU75:
	%u1664 = icmp ne i32 42, 1
	br i1 %u1664, label %LU76, label %LU77
LU76:
	call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([6 x i8], [6 x i8]* @.println, i32 0, i32 0), i32 1)
	br label %LU78
LU77:
	call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([6 x i8], [6 x i8]* @.println, i32 0, i32 0), i32 0)
	br label %LU78
LU78:
	br i1 true, label %LU79, label %LU80
LU79:
	call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([6 x i8], [6 x i8]* @.println, i32 0, i32 0), i32 1)
	br label %LU81
LU80:
	call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([6 x i8], [6 x i8]* @.println, i32 0, i32 0), i32 0)
	br label %LU81
LU81:
	%u1665 = xor i1 true, true
	br i1 %u1665, label %LU82, label %LU83
LU82:
	call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([6 x i8], [6 x i8]* @.println, i32 0, i32 0), i32 0)
	br label %LU84
LU83:
	call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([6 x i8], [6 x i8]* @.println, i32 0, i32 0), i32 1)
	br label %LU84
LU84:
	br i1 false, label %LU85, label %LU86
LU85:
	call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([6 x i8], [6 x i8]* @.println, i32 0, i32 0), i32 0)
	br label %LU87
LU86:
	call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([6 x i8], [6 x i8]* @.println, i32 0, i32 0), i32 1)
	br label %LU87
LU87:
	%u1666 = xor i1 true, false
	br i1 %u1666, label %LU88, label %LU89
LU88:
	call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([6 x i8], [6 x i8]* @.println, i32 0, i32 0), i32 1)
	br label %LU90
LU89:
	call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([6 x i8], [6 x i8]* @.println, i32 0, i32 0), i32 0)
	br label %LU90
LU90:
	%u1667 = xor i1 true, false
	br i1 %u1667, label %LU91, label %LU92
LU91:
	call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([6 x i8], [6 x i8]* @.println, i32 0, i32 0), i32 1)
	br label %LU93
LU92:
	call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([6 x i8], [6 x i8]* @.println, i32 0, i32 0), i32 0)
	br label %LU93
LU93:
	call void @printgroup(i32 4)
	%u1668 = add i32 2, 3
	%u1669 = icmp eq i32 %u1668, 5
	br i1 %u1669, label %LU94, label %LU95
LU94:
	call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([6 x i8], [6 x i8]* @.println, i32 0, i32 0), i32 1)
	br label %LU96
LU95:
	call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([6 x i8], [6 x i8]* @.print, i32 0, i32 0), i32 0)
	%u1670 = add i32 2, 3
	call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([6 x i8], [6 x i8]* @.println, i32 0, i32 0), i32 %u1670)
	br label %LU96
LU96:
	%u1671 = mul i32 2, 3
	%u1672 = icmp eq i32 %u1671, 6
	br i1 %u1672, label %LU97, label %LU98
LU97:
	call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([6 x i8], [6 x i8]* @.println, i32 0, i32 0), i32 1)
	br label %LU99
LU98:
	call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([6 x i8], [6 x i8]* @.print, i32 0, i32 0), i32 0)
	%u1673 = mul i32 2, 3
	call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([6 x i8], [6 x i8]* @.println, i32 0, i32 0), i32 %u1673)
	br label %LU99
LU99:
	%u1674 = sub i32 3, 2
	%u1675 = icmp eq i32 %u1674, 1
	br i1 %u1675, label %LU100, label %LU101
LU100:
	call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([6 x i8], [6 x i8]* @.println, i32 0, i32 0), i32 1)
	br label %LU102
LU101:
	call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([6 x i8], [6 x i8]* @.print, i32 0, i32 0), i32 0)
	%u1676 = sub i32 3, 2
	call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([6 x i8], [6 x i8]* @.println, i32 0, i32 0), i32 %u1676)
	br label %LU102
LU102:
	%u1677 = sdiv i32 6, 3
	%u1678 = icmp eq i32 %u1677, 2
	br i1 %u1678, label %LU103, label %LU104
LU103:
	call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([6 x i8], [6 x i8]* @.println, i32 0, i32 0), i32 1)
	br label %LU105
LU104:
	call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([6 x i8], [6 x i8]* @.print, i32 0, i32 0), i32 0)
	%u1679 = sdiv i32 6, 3
	call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([6 x i8], [6 x i8]* @.println, i32 0, i32 0), i32 %u1679)
	br label %LU105
LU105:
	%u1680 = sub i32 0, 6
	%u1681 = icmp slt i32 %u1680, 0
	br i1 %u1681, label %LU106, label %LU107
LU106:
	call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([6 x i8], [6 x i8]* @.println, i32 0, i32 0), i32 1)
	br label %LU108
LU107:
	call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([6 x i8], [6 x i8]* @.println, i32 0, i32 0), i32 0)
	br label %LU108
LU108:
	call void @printgroup(i32 5)
	store i32 42, i32* %i1
	%u1682 = load i32, i32* %i1
	%u1683 = icmp eq i32 %u1682, 42
	br i1 %u1683, label %LU109, label %LU110
LU109:
	call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([6 x i8], [6 x i8]* @.println, i32 0, i32 0), i32 1)
	br label %LU111
LU110:
	call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([6 x i8], [6 x i8]* @.println, i32 0, i32 0), i32 0)
	br label %LU111
LU111:
	store i32 3, i32* %i1
	store i32 2, i32* %i2
	%u1684 = load i32, i32* %i1
	%u1685 = load i32, i32* %i2
	%u1686 = add i32 %u1684, %u1685
	store i32 %u1686, i32* %i3
	%u1687 = load i32, i32* %i3
	%u1688 = icmp eq i32 %u1687, 5
	br i1 %u1688, label %LU112, label %LU113
LU112:
	call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([6 x i8], [6 x i8]* @.println, i32 0, i32 0), i32 1)
	br label %LU114
LU113:
	call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([6 x i8], [6 x i8]* @.println, i32 0, i32 0), i32 0)
	br label %LU114
LU114:
	%u1689 = zext i1 true to i32
	store i32 %u1689, i32* %b1
	%u1690 = load i32, i32* %b1
	%u1691 = trunc i32 %u1690 to i1
	br i1 %u1691, label %LU115, label %LU116
LU115:
	call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([6 x i8], [6 x i8]* @.println, i32 0, i32 0), i32 1)
	br label %LU117
LU116:
	call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([6 x i8], [6 x i8]* @.println, i32 0, i32 0), i32 0)
	br label %LU117
LU117:
	%u1692 = load i32, i32* %b1
	%u1693 = trunc i32 %u1692 to i1
	%u1694 = xor i1 true, %u1693
	br i1 %u1694, label %LU118, label %LU119
LU118:
	call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([6 x i8], [6 x i8]* @.println, i32 0, i32 0), i32 0)
	br label %LU120
LU119:
	call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([6 x i8], [6 x i8]* @.println, i32 0, i32 0), i32 1)
	br label %LU120
LU120:
	%u1695 = zext i1 false to i32
	store i32 %u1695, i32* %b1
	%u1696 = load i32, i32* %b1
	%u1697 = trunc i32 %u1696 to i1
	br i1 %u1697, label %LU121, label %LU122
LU121:
	call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([6 x i8], [6 x i8]* @.println, i32 0, i32 0), i32 0)
	br label %LU123
LU122:
	call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([6 x i8], [6 x i8]* @.println, i32 0, i32 0), i32 1)
	br label %LU123
LU123:
	%u1698 = load i32, i32* %b1
	%u1699 = trunc i32 %u1698 to i1
	%u1700 = xor i1 true, %u1699
	br i1 %u1700, label %LU124, label %LU125
LU124:
	call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([6 x i8], [6 x i8]* @.println, i32 0, i32 0), i32 1)
	br label %LU126
LU125:
	call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([6 x i8], [6 x i8]* @.println, i32 0, i32 0), i32 0)
	br label %LU126
LU126:
	%u1701 = load i32, i32* %b1
	%u1702 = trunc i32 %u1701 to i1
	br i1 %u1702, label %LU127, label %LU128
LU127:
	call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([6 x i8], [6 x i8]* @.println, i32 0, i32 0), i32 0)
	br label %LU129
LU128:
	call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([6 x i8], [6 x i8]* @.println, i32 0, i32 0), i32 1)
	br label %LU129
LU129:
	call void @printgroup(i32 6)
	store i32 0, i32* %i1
	%u1703 = load i32, i32* %i1
	%u1704 = icmp slt i32 %u1703, 5
	br i1 %u1704, label %LU130, label %LU131
LU130:
	%u1705 = load i32, i32* %i1
	%u1706 = icmp sge i32 %u1705, 5
	br i1 %u1706, label %LU180, label %LU181
LU180:
	call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([6 x i8], [6 x i8]* @.println, i32 0, i32 0), i32 0)
	br label %LU181
LU181:
	%u1707 = load i32, i32* %i1
	%u1708 = add i32 %u1707, 5
	store i32 %u1708, i32* %i1
	%u1709 = load i32, i32* %i1
	%u1710 = icmp slt i32 %u1709, 5
	br i1 %u1710, label %LU130, label %LU131
LU131:
	%u1711 = load i32, i32* %i1
	%u1712 = icmp eq i32 %u1711, 5
	br i1 %u1712, label %LU132, label %LU133
LU132:
	call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([6 x i8], [6 x i8]* @.println, i32 0, i32 0), i32 1)
	br label %LU134
LU133:
	call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([6 x i8], [6 x i8]* @.print, i32 0, i32 0), i32 0)
	%u1713 = load i32, i32* %i1
	call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([6 x i8], [6 x i8]* @.println, i32 0, i32 0), i32 %u1713)
	br label %LU134
LU134:
	call void @printgroup(i32 7)
	%u1714 = call i8* @malloc(i32 12)
	%u1715 = bitcast i8* %u1714 to %struct.thing*
	store %struct.thing* %u1715, %struct.thing** %s1
	%u1716 = load %struct.thing*, %struct.thing** %s1
	%u1717 = getelementptr %struct.thing, %struct.thing* %u1716, i1 0, i32 0
	store i32 42, i32* %u1717
	%u1718 = zext i1 true to i32
	%u1719 = load %struct.thing*, %struct.thing** %s1
	%u1720 = getelementptr %struct.thing, %struct.thing* %u1719, i1 0, i32 1
	store i32 %u1718, i32* %u1720
	%u1721 = load %struct.thing*, %struct.thing** %s1
	%u1722 = getelementptr %struct.thing, %struct.thing* %u1721, i1 0, i32 0
	%u1723 = load i32, i32* %u1722
	%u1724 = icmp eq i32 %u1723, 42
	br i1 %u1724, label %LU135, label %LU136
LU135:
	call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([6 x i8], [6 x i8]* @.println, i32 0, i32 0), i32 1)
	br label %LU137
LU136:
	call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([6 x i8], [6 x i8]* @.print, i32 0, i32 0), i32 0)
	%u1725 = load %struct.thing*, %struct.thing** %s1
	%u1726 = getelementptr %struct.thing, %struct.thing* %u1725, i1 0, i32 0
	%u1727 = load i32, i32* %u1726
	call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([6 x i8], [6 x i8]* @.println, i32 0, i32 0), i32 %u1727)
	br label %LU137
LU137:
	%u1728 = load %struct.thing*, %struct.thing** %s1
	%u1729 = getelementptr %struct.thing, %struct.thing* %u1728, i1 0, i32 1
	%u1730 = load i32, i32* %u1729
	%u1731 = trunc i32 %u1730 to i1
	br i1 %u1731, label %LU138, label %LU139
LU138:
	call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([6 x i8], [6 x i8]* @.println, i32 0, i32 0), i32 1)
	br label %LU140
LU139:
	call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([6 x i8], [6 x i8]* @.println, i32 0, i32 0), i32 0)
	br label %LU140
LU140:
	%u1732 = call i8* @malloc(i32 12)
	%u1733 = bitcast i8* %u1732 to %struct.thing*
	%u1734 = load %struct.thing*, %struct.thing** %s1
	%u1735 = getelementptr %struct.thing, %struct.thing* %u1734, i1 0, i32 2
	store %struct.thing* %u1733, %struct.thing** %u1735
	%u1736 = load %struct.thing*, %struct.thing** %s1
	%u1737 = getelementptr %struct.thing, %struct.thing* %u1736, i1 0, i32 2
	%u1738 = load %struct.thing*, %struct.thing** %u1737
	%u1739 = getelementptr %struct.thing, %struct.thing* %u1738, i1 0, i32 0
	store i32 13, i32* %u1739
	%u1740 = zext i1 false to i32
	%u1741 = load %struct.thing*, %struct.thing** %s1
	%u1742 = getelementptr %struct.thing, %struct.thing* %u1741, i1 0, i32 2
	%u1743 = load %struct.thing*, %struct.thing** %u1742
	%u1744 = getelementptr %struct.thing, %struct.thing* %u1743, i1 0, i32 1
	store i32 %u1740, i32* %u1744
	%u1745 = load %struct.thing*, %struct.thing** %s1
	%u1746 = getelementptr %struct.thing, %struct.thing* %u1745, i1 0, i32 2
	%u1747 = load %struct.thing*, %struct.thing** %u1746
	%u1748 = getelementptr %struct.thing, %struct.thing* %u1747, i1 0, i32 0
	%u1749 = load i32, i32* %u1748
	%u1750 = icmp eq i32 %u1749, 13
	br i1 %u1750, label %LU141, label %LU142
LU141:
	call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([6 x i8], [6 x i8]* @.println, i32 0, i32 0), i32 1)
	br label %LU143
LU142:
	call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([6 x i8], [6 x i8]* @.print, i32 0, i32 0), i32 0)
	%u1751 = load %struct.thing*, %struct.thing** %s1
	%u1752 = getelementptr %struct.thing, %struct.thing* %u1751, i1 0, i32 2
	%u1753 = load %struct.thing*, %struct.thing** %u1752
	%u1754 = getelementptr %struct.thing, %struct.thing* %u1753, i1 0, i32 0
	%u1755 = load i32, i32* %u1754
	call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([6 x i8], [6 x i8]* @.println, i32 0, i32 0), i32 %u1755)
	br label %LU143
LU143:
	%u1756 = load %struct.thing*, %struct.thing** %s1
	%u1757 = getelementptr %struct.thing, %struct.thing* %u1756, i1 0, i32 2
	%u1758 = load %struct.thing*, %struct.thing** %u1757
	%u1759 = getelementptr %struct.thing, %struct.thing* %u1758, i1 0, i32 1
	%u1760 = load i32, i32* %u1759
	%u1761 = trunc i32 %u1760 to i1
	%u1762 = xor i1 true, %u1761
	br i1 %u1762, label %LU144, label %LU145
LU144:
	call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([6 x i8], [6 x i8]* @.println, i32 0, i32 0), i32 1)
	br label %LU146
LU145:
	call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([6 x i8], [6 x i8]* @.println, i32 0, i32 0), i32 0)
	br label %LU146
LU146:
	%u1763 = load %struct.thing*, %struct.thing** %s1
	%u1764 = load %struct.thing*, %struct.thing** %s1
	%u1765 = icmp eq %struct.thing* %u1763, %u1764
	br i1 %u1765, label %LU147, label %LU148
LU147:
	call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([6 x i8], [6 x i8]* @.println, i32 0, i32 0), i32 1)
	br label %LU149
LU148:
	call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([6 x i8], [6 x i8]* @.println, i32 0, i32 0), i32 0)
	br label %LU149
LU149:
	%u1766 = load %struct.thing*, %struct.thing** %s1
	%u1767 = load %struct.thing*, %struct.thing** %s1
	%u1768 = getelementptr %struct.thing, %struct.thing* %u1767, i1 0, i32 2
	%u1769 = load %struct.thing*, %struct.thing** %u1768
	%u1770 = icmp ne %struct.thing* %u1766, %u1769
	br i1 %u1770, label %LU150, label %LU151
LU150:
	call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([6 x i8], [6 x i8]* @.println, i32 0, i32 0), i32 1)
	br label %LU152
LU151:
	call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([6 x i8], [6 x i8]* @.println, i32 0, i32 0), i32 0)
	br label %LU152
LU152:
	%u1771 = load %struct.thing*, %struct.thing** %s1
	%u1772 = getelementptr %struct.thing, %struct.thing* %u1771, i1 0, i32 2
	%u1773 = load %struct.thing*, %struct.thing** %u1772
	%u1774 = bitcast %struct.thing* %u1773 to i8*
	call void @free(i8* %u1774)
	%u1775 = load %struct.thing*, %struct.thing** %s1
	%u1776 = bitcast %struct.thing* %u1775 to i8*
	call void @free(i8* %u1776)
	call void @printgroup(i32 8)
	store i32 7, i32* @gi1
	%u1777 = load i32, i32* @gi1
	%u1778 = icmp eq i32 %u1777, 7
	br i1 %u1778, label %LU153, label %LU154
LU153:
	call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([6 x i8], [6 x i8]* @.println, i32 0, i32 0), i32 1)
	br label %LU155
LU154:
	call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([6 x i8], [6 x i8]* @.print, i32 0, i32 0), i32 0)
	%u1779 = load i32, i32* @gi1
	call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([6 x i8], [6 x i8]* @.println, i32 0, i32 0), i32 %u1779)
	br label %LU155
LU155:
	%u1780 = zext i1 true to i32
	store i32 %u1780, i32* @gb1
	%u1781 = load i32, i32* @gb1
	%u1782 = trunc i32 %u1781 to i1
	br i1 %u1782, label %LU156, label %LU157
LU156:
	call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([6 x i8], [6 x i8]* @.println, i32 0, i32 0), i32 1)
	br label %LU158
LU157:
	call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([6 x i8], [6 x i8]* @.println, i32 0, i32 0), i32 0)
	br label %LU158
LU158:
	%u1783 = call i8* @malloc(i32 12)
	%u1784 = bitcast i8* %u1783 to %struct.thing*
	store %struct.thing* %u1784, %struct.thing** @gs1
	%u1785 = load %struct.thing*, %struct.thing** @gs1
	%u1786 = getelementptr %struct.thing, %struct.thing* %u1785, i1 0, i32 0
	store i32 34, i32* %u1786
	%u1787 = zext i1 false to i32
	%u1788 = load %struct.thing*, %struct.thing** @gs1
	%u1789 = getelementptr %struct.thing, %struct.thing* %u1788, i1 0, i32 1
	store i32 %u1787, i32* %u1789
	%u1790 = load %struct.thing*, %struct.thing** @gs1
	%u1791 = getelementptr %struct.thing, %struct.thing* %u1790, i1 0, i32 0
	%u1792 = load i32, i32* %u1791
	%u1793 = icmp eq i32 %u1792, 34
	br i1 %u1793, label %LU159, label %LU160
LU159:
	call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([6 x i8], [6 x i8]* @.println, i32 0, i32 0), i32 1)
	br label %LU161
LU160:
	call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([6 x i8], [6 x i8]* @.print, i32 0, i32 0), i32 0)
	%u1794 = load %struct.thing*, %struct.thing** @gs1
	%u1795 = getelementptr %struct.thing, %struct.thing* %u1794, i1 0, i32 0
	%u1796 = load i32, i32* %u1795
	call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([6 x i8], [6 x i8]* @.println, i32 0, i32 0), i32 %u1796)
	br label %LU161
LU161:
	%u1797 = load %struct.thing*, %struct.thing** @gs1
	%u1798 = getelementptr %struct.thing, %struct.thing* %u1797, i1 0, i32 1
	%u1799 = load i32, i32* %u1798
	%u1800 = trunc i32 %u1799 to i1
	%u1801 = xor i1 true, %u1800
	br i1 %u1801, label %LU162, label %LU163
LU162:
	call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([6 x i8], [6 x i8]* @.println, i32 0, i32 0), i32 1)
	br label %LU164
LU163:
	call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([6 x i8], [6 x i8]* @.println, i32 0, i32 0), i32 0)
	br label %LU164
LU164:
	%u1802 = call i8* @malloc(i32 12)
	%u1803 = bitcast i8* %u1802 to %struct.thing*
	%u1804 = load %struct.thing*, %struct.thing** @gs1
	%u1805 = getelementptr %struct.thing, %struct.thing* %u1804, i1 0, i32 2
	store %struct.thing* %u1803, %struct.thing** %u1805
	%u1806 = load %struct.thing*, %struct.thing** @gs1
	%u1807 = getelementptr %struct.thing, %struct.thing* %u1806, i1 0, i32 2
	%u1808 = load %struct.thing*, %struct.thing** %u1807
	%u1809 = getelementptr %struct.thing, %struct.thing* %u1808, i1 0, i32 0
	store i32 16, i32* %u1809
	%u1810 = zext i1 true to i32
	%u1811 = load %struct.thing*, %struct.thing** @gs1
	%u1812 = getelementptr %struct.thing, %struct.thing* %u1811, i1 0, i32 2
	%u1813 = load %struct.thing*, %struct.thing** %u1812
	%u1814 = getelementptr %struct.thing, %struct.thing* %u1813, i1 0, i32 1
	store i32 %u1810, i32* %u1814
	%u1815 = load %struct.thing*, %struct.thing** @gs1
	%u1816 = getelementptr %struct.thing, %struct.thing* %u1815, i1 0, i32 2
	%u1817 = load %struct.thing*, %struct.thing** %u1816
	%u1818 = getelementptr %struct.thing, %struct.thing* %u1817, i1 0, i32 0
	%u1819 = load i32, i32* %u1818
	%u1820 = icmp eq i32 %u1819, 16
	br i1 %u1820, label %LU165, label %LU166
LU165:
	call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([6 x i8], [6 x i8]* @.println, i32 0, i32 0), i32 1)
	br label %LU167
LU166:
	call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([6 x i8], [6 x i8]* @.print, i32 0, i32 0), i32 0)
	%u1821 = load %struct.thing*, %struct.thing** @gs1
	%u1822 = getelementptr %struct.thing, %struct.thing* %u1821, i1 0, i32 2
	%u1823 = load %struct.thing*, %struct.thing** %u1822
	%u1824 = getelementptr %struct.thing, %struct.thing* %u1823, i1 0, i32 0
	%u1825 = load i32, i32* %u1824
	call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([6 x i8], [6 x i8]* @.println, i32 0, i32 0), i32 %u1825)
	br label %LU167
LU167:
	%u1826 = load %struct.thing*, %struct.thing** @gs1
	%u1827 = getelementptr %struct.thing, %struct.thing* %u1826, i1 0, i32 2
	%u1828 = load %struct.thing*, %struct.thing** %u1827
	%u1829 = getelementptr %struct.thing, %struct.thing* %u1828, i1 0, i32 1
	%u1830 = load i32, i32* %u1829
	%u1831 = trunc i32 %u1830 to i1
	br i1 %u1831, label %LU168, label %LU169
LU168:
	call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([6 x i8], [6 x i8]* @.println, i32 0, i32 0), i32 1)
	br label %LU170
LU169:
	call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([6 x i8], [6 x i8]* @.println, i32 0, i32 0), i32 0)
	br label %LU170
LU170:
	%u1832 = load %struct.thing*, %struct.thing** @gs1
	%u1833 = getelementptr %struct.thing, %struct.thing* %u1832, i1 0, i32 2
	%u1834 = load %struct.thing*, %struct.thing** %u1833
	%u1835 = bitcast %struct.thing* %u1834 to i8*
	call void @free(i8* %u1835)
	%u1836 = load %struct.thing*, %struct.thing** @gs1
	%u1837 = bitcast %struct.thing* %u1836 to i8*
	call void @free(i8* %u1837)
	call void @printgroup(i32 9)
	%u1838 = call i8* @malloc(i32 12)
	%u1839 = bitcast i8* %u1838 to %struct.thing*
	store %struct.thing* %u1839, %struct.thing** %s1
	%u1840 = zext i1 true to i32
	%u1841 = load %struct.thing*, %struct.thing** %s1
	%u1842 = getelementptr %struct.thing, %struct.thing* %u1841, i1 0, i32 1
	store i32 %u1840, i32* %u1842
	%u1843 = zext i1 true to i32
	%u1844 = load %struct.thing*, %struct.thing** %s1
	call void @takealltypes(i32 3, i32 %u1843, %struct.thing* %u1844)
	call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([6 x i8], [6 x i8]* @.println, i32 0, i32 0), i32 2)
	call void @tonofargs(i32 1, i32 2, i32 3, i32 4, i32 5, i32 6, i32 7, i32 8)
	call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([6 x i8], [6 x i8]* @.println, i32 0, i32 0), i32 3)
	%u1845 = call i32 @returnint(i32 3)
	store i32 %u1845, i32* %i1
	%u1846 = load i32, i32* %i1
	%u1847 = icmp eq i32 %u1846, 3
	br i1 %u1847, label %LU171, label %LU172
LU171:
	call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([6 x i8], [6 x i8]* @.println, i32 0, i32 0), i32 1)
	br label %LU173
LU172:
	call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([6 x i8], [6 x i8]* @.print, i32 0, i32 0), i32 0)
	%u1848 = load i32, i32* %i1
	call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([6 x i8], [6 x i8]* @.println, i32 0, i32 0), i32 %u1848)
	br label %LU173
LU173:
	%u1849 = zext i1 true to i32
	%u1850 = call i32 @returnbool(i32 %u1849)
	store i32 %u1850, i32* %b1
	%u1851 = load i32, i32* %b1
	%u1852 = trunc i32 %u1851 to i1
	br i1 %u1852, label %LU174, label %LU175
LU174:
	call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([6 x i8], [6 x i8]* @.println, i32 0, i32 0), i32 1)
	br label %LU176
LU175:
	call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([6 x i8], [6 x i8]* @.println, i32 0, i32 0), i32 0)
	br label %LU176
LU176:
	%u1853 = call i8* @malloc(i32 12)
	%u1854 = bitcast i8* %u1853 to %struct.thing*
	store %struct.thing* %u1854, %struct.thing** %s1
	%u1855 = load %struct.thing*, %struct.thing** %s1
	%u1856 = call %struct.thing* @returnstruct(%struct.thing* %u1855)
	store %struct.thing* %u1856, %struct.thing** %s2
	%u1857 = load %struct.thing*, %struct.thing** %s1
	%u1858 = load %struct.thing*, %struct.thing** %s2
	%u1859 = icmp eq %struct.thing* %u1857, %u1858
	br i1 %u1859, label %LU177, label %LU178
LU177:
	call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([6 x i8], [6 x i8]* @.println, i32 0, i32 0), i32 1)
	br label %LU179
LU178:
	call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([6 x i8], [6 x i8]* @.println, i32 0, i32 0), i32 0)
	br label %LU179
LU179:
	call void @printgroup(i32 10)
	store i32 0, i32* %_retval_
	br label %LU35
LU35:
	%u1860 = load i32, i32* %_retval_
	ret i32 %u1860
}
declare i8* @malloc(i32)
declare void @free(i8*)
declare i32 @printf(i8*, ...)
declare i32 @scanf(i8*, ...)
@.println = private unnamed_addr constant [6 x i8] c"%ld\0A\00\00", align 1
@.print = private unnamed_addr constant [6 x i8] c"%ld \00\00", align 1
@.read = private unnamed_addr constant [5 x i8] c"%ld\00\00", align 1
@.read_scratch = common global i32 0, align 4
