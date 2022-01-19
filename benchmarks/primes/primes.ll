target triple="i686"




define i32 @isqrt(i32 %a)
{
LU1:
	%_P_a = alloca i32
	%_retval_ = alloca i32
	%square = alloca i32
	%delta = alloca i32
	store i32 %a, i32* %_P_a
	store i32 1, i32* %square
	store i32 3, i32* %delta
	%u2425 = load i32, i32* %square
	%u2426 = load i32, i32* %_P_a
	%u2427 = icmp sle i32 %u2425, %u2426
	br i1 %u2427, label %LU2, label %LU3
LU2:
	%u2428 = load i32, i32* %square
	%u2429 = load i32, i32* %delta
	%u2430 = add i32 %u2428, %u2429
	store i32 %u2430, i32* %square
	%u2431 = load i32, i32* %delta
	%u2432 = add i32 %u2431, 2
	store i32 %u2432, i32* %delta
	%u2433 = load i32, i32* %square
	%u2434 = load i32, i32* %_P_a
	%u2435 = icmp sle i32 %u2433, %u2434
	br i1 %u2435, label %LU2, label %LU3
LU3:
	%u2436 = load i32, i32* %delta
	%u2437 = sdiv i32 %u2436, 2
	%u2438 = sub i32 %u2437, 1
	store i32 %u2438, i32* %_retval_
	br label %LU0
LU0:
	%u2439 = load i32, i32* %_retval_
	ret i32 %u2439
}

define i32 @prime(i32 %a)
{
LU5:
	%_P_a = alloca i32
	%_retval_ = alloca i32
	%max = alloca i32
	%divisor = alloca i32
	%remainder = alloca i32
	store i32 %a, i32* %_P_a
	%u2440 = load i32, i32* %_P_a
	%u2441 = icmp slt i32 %u2440, 2
	br i1 %u2441, label %LU6, label %LU7
LU6:
	%u2442 = zext i1 false to i32
	store i32 %u2442, i32* %_retval_
	br label %LU4
LU7:
	%u2443 = load i32, i32* %_P_a
	%u2444 = call i32 @isqrt(i32 %u2443)
	store i32 %u2444, i32* %max
	store i32 2, i32* %divisor
	%u2445 = load i32, i32* %divisor
	%u2446 = load i32, i32* %max
	%u2447 = icmp sle i32 %u2445, %u2446
	br i1 %u2447, label %LU9, label %LU10
LU9:
	%u2448 = load i32, i32* %_P_a
	%u2449 = load i32, i32* %_P_a
	%u2450 = load i32, i32* %divisor
	%u2451 = sdiv i32 %u2449, %u2450
	%u2452 = load i32, i32* %divisor
	%u2453 = mul i32 %u2451, %u2452
	%u2454 = sub i32 %u2448, %u2453
	store i32 %u2454, i32* %remainder
	%u2455 = load i32, i32* %remainder
	%u2456 = icmp eq i32 %u2455, 0
	br i1 %u2456, label %LU11, label %LU12
LU11:
	%u2457 = zext i1 false to i32
	store i32 %u2457, i32* %_retval_
	br label %LU4
LU12:
	%u2458 = load i32, i32* %divisor
	%u2459 = add i32 %u2458, 1
	store i32 %u2459, i32* %divisor
	%u2460 = load i32, i32* %divisor
	%u2461 = load i32, i32* %max
	%u2462 = icmp sle i32 %u2460, %u2461
	br i1 %u2462, label %LU9, label %LU10
LU10:
	%u2463 = zext i1 true to i32
	store i32 %u2463, i32* %_retval_
	br label %LU4
LU8:
	br label %LU4
LU4:
	%u2464 = load i32, i32* %_retval_
	ret i32 %u2464
}

define i32 @main()
{
LU14:
	%_retval_ = alloca i32
	%limit = alloca i32
	%a = alloca i32
	call i32 (i8*, ...) @scanf(i8* getelementptr inbounds ([5 x i8], [5 x i8]* @.read, i32 0, i32 0), i32* %limit)
	store i32 0, i32* %a
	%u2465 = load i32, i32* %a
	%u2466 = load i32, i32* %limit
	%u2467 = icmp sle i32 %u2465, %u2466
	br i1 %u2467, label %LU15, label %LU16
LU15:
	%u2468 = load i32, i32* %a
	%u2469 = call i32 @prime(i32 %u2468)
	%u2470 = trunc i32 %u2469 to i1
	br i1 %u2470, label %LU17, label %LU18
LU17:
	%u2471 = load i32, i32* %a
	call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([6 x i8], [6 x i8]* @.println, i32 0, i32 0), i32 %u2471)
	br label %LU18
LU18:
	%u2472 = load i32, i32* %a
	%u2473 = add i32 %u2472, 1
	store i32 %u2473, i32* %a
	%u2474 = load i32, i32* %a
	%u2475 = load i32, i32* %limit
	%u2476 = icmp sle i32 %u2474, %u2475
	br i1 %u2476, label %LU15, label %LU16
LU16:
	store i32 0, i32* %_retval_
	br label %LU13
LU13:
	%u2477 = load i32, i32* %_retval_
	ret i32 %u2477
}
declare i8* @malloc(i32)
declare void @free(i8*)
declare i32 @printf(i8*, ...)
declare i32 @scanf(i8*, ...)
@.println = private unnamed_addr constant [6 x i8] c"%ld\0A\00\00", align 1
@.print = private unnamed_addr constant [6 x i8] c"%ld \00\00", align 1
@.read = private unnamed_addr constant [5 x i8] c"%ld\00\00", align 1
@.read_scratch = common global i32 0, align 4
