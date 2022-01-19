target triple="i686"




define i32 @wait(i32 %waitTime)
{
LU1:
	%_P_waitTime = alloca i32
	%_retval_ = alloca i32
	store i32 %waitTime, i32* %_P_waitTime
	%u1512 = load i32, i32* %_P_waitTime
	%u1513 = icmp sgt i32 %u1512, 0
	br i1 %u1513, label %LU2, label %LU3
LU2:
	%u1514 = load i32, i32* %_P_waitTime
	%u1515 = sub i32 %u1514, 1
	store i32 %u1515, i32* %_P_waitTime
	%u1516 = load i32, i32* %_P_waitTime
	%u1517 = icmp sgt i32 %u1516, 0
	br i1 %u1517, label %LU2, label %LU3
LU3:
	store i32 0, i32* %_retval_
	br label %LU0
LU0:
	%u1518 = load i32, i32* %_retval_
	ret i32 %u1518
}

define i32 @power(i32 %base, i32 %exponent)
{
LU5:
	%_P_base = alloca i32
	%_P_exponent = alloca i32
	%_retval_ = alloca i32
	%product = alloca i32
	store i32 %base, i32* %_P_base
	store i32 %exponent, i32* %_P_exponent
	store i32 1, i32* %product
	%u1519 = load i32, i32* %_P_exponent
	%u1520 = icmp sgt i32 %u1519, 0
	br i1 %u1520, label %LU6, label %LU7
LU6:
	%u1521 = load i32, i32* %product
	%u1522 = load i32, i32* %_P_base
	%u1523 = mul i32 %u1521, %u1522
	store i32 %u1523, i32* %product
	%u1524 = load i32, i32* %_P_exponent
	%u1525 = sub i32 %u1524, 1
	store i32 %u1525, i32* %_P_exponent
	%u1526 = load i32, i32* %_P_exponent
	%u1527 = icmp sgt i32 %u1526, 0
	br i1 %u1527, label %LU6, label %LU7
LU7:
	%u1528 = load i32, i32* %product
	store i32 %u1528, i32* %_retval_
	br label %LU4
LU4:
	%u1529 = load i32, i32* %_retval_
	ret i32 %u1529
}

define i32 @recursiveDecimalSum(i32 %binaryNum, i32 %decimalSum, i32 %recursiveDepth)
{
LU9:
	%_P_binaryNum = alloca i32
	%_P_decimalSum = alloca i32
	%_P_recursiveDepth = alloca i32
	%_retval_ = alloca i32
	%tempNum = alloca i32
	%base = alloca i32
	%remainder = alloca i32
	store i32 %binaryNum, i32* %_P_binaryNum
	store i32 %decimalSum, i32* %_P_decimalSum
	store i32 %recursiveDepth, i32* %_P_recursiveDepth
	%u1530 = load i32, i32* %_P_binaryNum
	%u1531 = icmp sgt i32 %u1530, 0
	br i1 %u1531, label %LU10, label %LU11
LU10:
	store i32 2, i32* %base
	%u1532 = load i32, i32* %_P_binaryNum
	%u1533 = sdiv i32 %u1532, 10
	store i32 %u1533, i32* %tempNum
	%u1534 = load i32, i32* %tempNum
	%u1535 = mul i32 %u1534, 10
	store i32 %u1535, i32* %tempNum
	%u1536 = load i32, i32* %_P_binaryNum
	%u1537 = load i32, i32* %tempNum
	%u1538 = sub i32 %u1536, %u1537
	store i32 %u1538, i32* %tempNum
	%u1539 = load i32, i32* %tempNum
	%u1540 = icmp eq i32 %u1539, 1
	br i1 %u1540, label %LU12, label %LU13
LU12:
	%u1541 = load i32, i32* %_P_decimalSum
	%u1542 = load i32, i32* %base
	%u1543 = load i32, i32* %_P_recursiveDepth
	%u1544 = call i32 @power(i32 %u1542, i32 %u1543)
	%u1545 = add i32 %u1541, %u1544
	store i32 %u1545, i32* %_P_decimalSum
	br label %LU13
LU13:
	%u1546 = load i32, i32* %_P_binaryNum
	%u1547 = sdiv i32 %u1546, 10
	%u1548 = load i32, i32* %_P_decimalSum
	%u1549 = load i32, i32* %_P_recursiveDepth
	%u1550 = add i32 %u1549, 1
	%u1551 = call i32 @recursiveDecimalSum(i32 %u1547, i32 %u1548, i32 %u1550)
	store i32 %u1551, i32* %_retval_
	br label %LU8
LU11:
	%u1552 = load i32, i32* %_P_decimalSum
	store i32 %u1552, i32* %_retval_
	br label %LU8
LU8:
	%u1553 = load i32, i32* %_retval_
	ret i32 %u1553
}

define i32 @convertToDecimal(i32 %binaryNum)
{
LU15:
	%_P_binaryNum = alloca i32
	%_retval_ = alloca i32
	%recursiveDepth = alloca i32
	%decimalSum = alloca i32
	store i32 %binaryNum, i32* %_P_binaryNum
	store i32 0, i32* %recursiveDepth
	store i32 0, i32* %decimalSum
	%u1554 = load i32, i32* %_P_binaryNum
	%u1555 = load i32, i32* %decimalSum
	%u1556 = load i32, i32* %recursiveDepth
	%u1557 = call i32 @recursiveDecimalSum(i32 %u1554, i32 %u1555, i32 %u1556)
	store i32 %u1557, i32* %_retval_
	br label %LU14
LU14:
	%u1558 = load i32, i32* %_retval_
	ret i32 %u1558
}

define i32 @main()
{
LU17:
	%_retval_ = alloca i32
	%number = alloca i32
	%waitTime = alloca i32
	call i32 (i8*, ...) @scanf(i8* getelementptr inbounds ([5 x i8], [5 x i8]* @.read, i32 0, i32 0), i32* %number)
	%u1559 = load i32, i32* %number
	%u1560 = call i32 @convertToDecimal(i32 %u1559)
	store i32 %u1560, i32* %number
	%u1561 = load i32, i32* %number
	%u1562 = load i32, i32* %number
	%u1563 = mul i32 %u1561, %u1562
	store i32 %u1563, i32* %waitTime
	%u1564 = load i32, i32* %waitTime
	%u1565 = icmp sgt i32 %u1564, 0
	br i1 %u1565, label %LU18, label %LU19
LU18:
	%u1566 = load i32, i32* %waitTime
	call i32 @wait(i32 %u1566)
	%u1567 = load i32, i32* %waitTime
	%u1568 = sub i32 %u1567, 1
	store i32 %u1568, i32* %waitTime
	%u1569 = load i32, i32* %waitTime
	%u1570 = icmp sgt i32 %u1569, 0
	br i1 %u1570, label %LU18, label %LU19
LU19:
	%u1571 = load i32, i32* %number
	call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([6 x i8], [6 x i8]* @.println, i32 0, i32 0), i32 %u1571)
	store i32 0, i32* %_retval_
	br label %LU16
LU16:
	%u1572 = load i32, i32* %_retval_
	ret i32 %u1572
}
declare i8* @malloc(i32)
declare void @free(i8*)
declare i32 @printf(i8*, ...)
declare i32 @scanf(i8*, ...)
@.println = private unnamed_addr constant [6 x i8] c"%ld\0A\00\00", align 1
@.print = private unnamed_addr constant [6 x i8] c"%ld \00\00", align 1
@.read = private unnamed_addr constant [5 x i8] c"%ld\00\00", align 1
@.read_scratch = common global i32 0, align 4
