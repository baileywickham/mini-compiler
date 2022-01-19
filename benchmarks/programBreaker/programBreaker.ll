target triple="i686"


@GLOBAL = common global i32 0, align 4
@count = common global i32 0, align 4

define i32 @fun2(i32 %x, i32 %y)
{
LU1:
	%_P_x = alloca i32
	%_P_y = alloca i32
	%_retval_ = alloca i32
	store i32 %x, i32* %_P_x
	store i32 %y, i32* %_P_y
	%u2478 = load i32, i32* %_P_x
	%u2479 = icmp eq i32 %u2478, 0
	br i1 %u2479, label %LU2, label %LU3
LU2:
	%u2480 = load i32, i32* %_P_y
	store i32 %u2480, i32* %_retval_
	br label %LU0
LU3:
	%u2481 = load i32, i32* %_P_x
	%u2482 = sub i32 %u2481, 1
	%u2483 = load i32, i32* %_P_y
	%u2484 = call i32 @fun2(i32 %u2482, i32 %u2483)
	store i32 %u2484, i32* %_retval_
	br label %LU0
LU4:
	br label %LU0
LU0:
	%u2485 = load i32, i32* %_retval_
	ret i32 %u2485
}

define i32 @fun1(i32 %x, i32 %y, i32 %z)
{
LU6:
	%_P_x = alloca i32
	%_P_y = alloca i32
	%_P_z = alloca i32
	%_retval_ = alloca i32
	%retVal = alloca i32
	store i32 %x, i32* %_P_x
	store i32 %y, i32* %_P_y
	store i32 %z, i32* %_P_z
	%u2486 = add i32 5, 6
	%u2487 = load i32, i32* %_P_x
	%u2488 = mul i32 %u2487, 2
	%u2489 = sub i32 %u2486, %u2488
	%u2490 = load i32, i32* %_P_y
	%u2491 = sdiv i32 4, %u2490
	%u2492 = add i32 %u2489, %u2491
	%u2493 = load i32, i32* %_P_z
	%u2494 = add i32 %u2492, %u2493
	store i32 %u2494, i32* %retVal
	%u2495 = load i32, i32* %retVal
	%u2496 = load i32, i32* %_P_y
	%u2497 = icmp sgt i32 %u2495, %u2496
	br i1 %u2497, label %LU7, label %LU8
LU7:
	%u2498 = load i32, i32* %retVal
	%u2499 = load i32, i32* %_P_x
	%u2500 = call i32 @fun2(i32 %u2498, i32 %u2499)
	store i32 %u2500, i32* %_retval_
	br label %LU5
LU8:
	%u2501 = icmp slt i32 5, 6
	%u2502 = load i32, i32* %retVal
	%u2503 = load i32, i32* %_P_y
	%u2504 = icmp sle i32 %u2502, %u2503
	%u2505 = and i1 %u2501, %u2504
	br i1 %u2505, label %LU10, label %LU11
LU10:
	%u2506 = load i32, i32* %retVal
	%u2507 = load i32, i32* %_P_y
	%u2508 = call i32 @fun2(i32 %u2506, i32 %u2507)
	store i32 %u2508, i32* %_retval_
	br label %LU5
LU11:
	br label %LU9
LU9:
	%u2509 = load i32, i32* %retVal
	store i32 %u2509, i32* %_retval_
	br label %LU5
LU5:
	%u2510 = load i32, i32* %_retval_
	ret i32 %u2510
}

define i32 @main()
{
LU13:
	%_retval_ = alloca i32
	%i = alloca i32
	store i32 0, i32* %i
	call i32 (i8*, ...) @scanf(i8* getelementptr inbounds ([5 x i8], [5 x i8]* @.read, i32 0, i32 0), i32* %i)
	%u2511 = load i32, i32* %i
	%u2512 = icmp slt i32 %u2511, 10000
	br i1 %u2512, label %LU14, label %LU15
LU14:
	%u2513 = load i32, i32* %i
	%u2514 = call i32 @fun1(i32 3, i32 %u2513, i32 5)
	call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([6 x i8], [6 x i8]* @.println, i32 0, i32 0), i32 %u2514)
	%u2515 = load i32, i32* %i
	%u2516 = add i32 %u2515, 1
	store i32 %u2516, i32* %i
	%u2517 = load i32, i32* %i
	%u2518 = icmp slt i32 %u2517, 10000
	br i1 %u2518, label %LU14, label %LU15
LU15:
	store i32 0, i32* %_retval_
	br label %LU12
LU12:
	%u2519 = load i32, i32* %_retval_
	ret i32 %u2519
}
declare i8* @malloc(i32)
declare void @free(i8*)
declare i32 @printf(i8*, ...)
declare i32 @scanf(i8*, ...)
@.println = private unnamed_addr constant [6 x i8] c"%ld\0A\00\00", align 1
@.print = private unnamed_addr constant [6 x i8] c"%ld \00\00", align 1
@.read = private unnamed_addr constant [5 x i8] c"%ld\00\00", align 1
@.read_scratch = common global i32 0, align 4
