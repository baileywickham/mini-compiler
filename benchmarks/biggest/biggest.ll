target triple="i686"
%struct.IntList = type {i32, %struct.IntList*}



define %struct.IntList* @getIntList()
{
LU1:
	%_retval_ = alloca %struct.IntList*
	%list = alloca %struct.IntList*
	%next = alloca i32
	%u1462 = call i8* @malloc(i32 8)
	%u1463 = bitcast i8* %u1462 to %struct.IntList*
	store %struct.IntList* %u1463, %struct.IntList** %list
	call i32 (i8*, ...) @scanf(i8* getelementptr inbounds ([5 x i8], [5 x i8]* @.read, i32 0, i32 0), i32* %next)
	%u1464 = load i32, i32* %next
	%u1465 = sub i32 0, 1
	%u1466 = icmp eq i32 %u1464, %u1465
	br i1 %u1466, label %LU2, label %LU3
LU2:
	%u1467 = load i32, i32* %next
	%u1468 = load %struct.IntList*, %struct.IntList** %list
	%u1469 = getelementptr %struct.IntList, %struct.IntList* %u1468, i1 0, i32 0
	store i32 %u1467, i32* %u1469
	%u1470 = load %struct.IntList*, %struct.IntList** %list
	%u1471 = getelementptr %struct.IntList, %struct.IntList* %u1470, i1 0, i32 1
	store %struct.IntList* null, %struct.IntList** %u1471
	%u1472 = load %struct.IntList*, %struct.IntList** %list
	store %struct.IntList* %u1472, %struct.IntList** %_retval_
	br label %LU0
LU3:
	%u1473 = load i32, i32* %next
	%u1474 = load %struct.IntList*, %struct.IntList** %list
	%u1475 = getelementptr %struct.IntList, %struct.IntList* %u1474, i1 0, i32 0
	store i32 %u1473, i32* %u1475
	%u1476 = call %struct.IntList* @getIntList()
	%u1477 = load %struct.IntList*, %struct.IntList** %list
	%u1478 = getelementptr %struct.IntList, %struct.IntList* %u1477, i1 0, i32 1
	store %struct.IntList* %u1476, %struct.IntList** %u1478
	%u1479 = load %struct.IntList*, %struct.IntList** %list
	store %struct.IntList* %u1479, %struct.IntList** %_retval_
	br label %LU0
LU4:
	br label %LU0
LU0:
	%u1480 = load %struct.IntList*, %struct.IntList** %_retval_
	ret %struct.IntList* %u1480
}

define i32 @biggest(i32 %num1, i32 %num2)
{
LU6:
	%_P_num1 = alloca i32
	%_P_num2 = alloca i32
	%_retval_ = alloca i32
	store i32 %num1, i32* %_P_num1
	store i32 %num2, i32* %_P_num2
	%u1481 = load i32, i32* %_P_num1
	%u1482 = load i32, i32* %_P_num2
	%u1483 = icmp sgt i32 %u1481, %u1482
	br i1 %u1483, label %LU7, label %LU8
LU7:
	%u1484 = load i32, i32* %_P_num1
	store i32 %u1484, i32* %_retval_
	br label %LU5
LU8:
	%u1485 = load i32, i32* %_P_num2
	store i32 %u1485, i32* %_retval_
	br label %LU5
LU9:
	br label %LU5
LU5:
	%u1486 = load i32, i32* %_retval_
	ret i32 %u1486
}

define i32 @biggestInList(%struct.IntList* %list)
{
LU11:
	%_P_list = alloca %struct.IntList*
	%_retval_ = alloca i32
	%big = alloca i32
	store %struct.IntList* %list, %struct.IntList** %_P_list
	%u1487 = load %struct.IntList*, %struct.IntList** %_P_list
	%u1488 = getelementptr %struct.IntList, %struct.IntList* %u1487, i1 0, i32 0
	%u1489 = load i32, i32* %u1488
	store i32 %u1489, i32* %big
	%u1490 = load %struct.IntList*, %struct.IntList** %_P_list
	%u1491 = getelementptr %struct.IntList, %struct.IntList* %u1490, i1 0, i32 1
	%u1492 = load %struct.IntList*, %struct.IntList** %u1491
	%u1493 = icmp ne %struct.IntList* %u1492, null
	br i1 %u1493, label %LU12, label %LU13
LU12:
	%u1494 = load i32, i32* %big
	%u1495 = load %struct.IntList*, %struct.IntList** %_P_list
	%u1496 = getelementptr %struct.IntList, %struct.IntList* %u1495, i1 0, i32 0
	%u1497 = load i32, i32* %u1496
	%u1498 = call i32 @biggest(i32 %u1494, i32 %u1497)
	store i32 %u1498, i32* %big
	%u1499 = load %struct.IntList*, %struct.IntList** %_P_list
	%u1500 = getelementptr %struct.IntList, %struct.IntList* %u1499, i1 0, i32 1
	%u1501 = load %struct.IntList*, %struct.IntList** %u1500
	store %struct.IntList* %u1501, %struct.IntList** %_P_list
	%u1502 = load %struct.IntList*, %struct.IntList** %_P_list
	%u1503 = getelementptr %struct.IntList, %struct.IntList* %u1502, i1 0, i32 1
	%u1504 = load %struct.IntList*, %struct.IntList** %u1503
	%u1505 = icmp ne %struct.IntList* %u1504, null
	br i1 %u1505, label %LU12, label %LU13
LU13:
	%u1506 = load i32, i32* %big
	store i32 %u1506, i32* %_retval_
	br label %LU10
LU10:
	%u1507 = load i32, i32* %_retval_
	ret i32 %u1507
}

define i32 @main()
{
LU15:
	%_retval_ = alloca i32
	%list = alloca %struct.IntList*
	%u1508 = call %struct.IntList* @getIntList()
	store %struct.IntList* %u1508, %struct.IntList** %list
	%u1509 = load %struct.IntList*, %struct.IntList** %list
	%u1510 = call i32 @biggestInList(%struct.IntList* %u1509)
	call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([6 x i8], [6 x i8]* @.println, i32 0, i32 0), i32 %u1510)
	store i32 0, i32* %_retval_
	br label %LU14
LU14:
	%u1511 = load i32, i32* %_retval_
	ret i32 %u1511
}
declare i8* @malloc(i32)
declare void @free(i8*)
declare i32 @printf(i8*, ...)
declare i32 @scanf(i8*, ...)
@.println = private unnamed_addr constant [6 x i8] c"%ld\0A\00\00", align 1
@.print = private unnamed_addr constant [6 x i8] c"%ld \00\00", align 1
@.read = private unnamed_addr constant [5 x i8] c"%ld\00\00", align 1
@.read_scratch = common global i32 0, align 4
