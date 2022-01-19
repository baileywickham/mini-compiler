target triple="i686"
%struct.linkedNums = type {i32, %struct.linkedNums*}



define %struct.linkedNums* @getRands(i32 %seed, i32 %num)
{
LU1:
	%_P_seed = alloca i32
	%_P_num = alloca i32
	%_retval_ = alloca %struct.linkedNums*
	%cur = alloca i32
	%prev = alloca i32
	%curNode = alloca %struct.linkedNums*
	%prevNode = alloca %struct.linkedNums*
	store i32 %seed, i32* %_P_seed
	store i32 %num, i32* %_P_num
	store %struct.linkedNums* null, %struct.linkedNums** %curNode
	%u2520 = load i32, i32* %_P_seed
	%u2521 = load i32, i32* %_P_seed
	%u2522 = mul i32 %u2520, %u2521
	store i32 %u2522, i32* %cur
	%u2523 = call i8* @malloc(i32 8)
	%u2524 = bitcast i8* %u2523 to %struct.linkedNums*
	store %struct.linkedNums* %u2524, %struct.linkedNums** %prevNode
	%u2525 = load i32, i32* %cur
	%u2526 = load %struct.linkedNums*, %struct.linkedNums** %prevNode
	%u2527 = getelementptr %struct.linkedNums, %struct.linkedNums* %u2526, i1 0, i32 0
	store i32 %u2525, i32* %u2527
	%u2528 = load %struct.linkedNums*, %struct.linkedNums** %prevNode
	%u2529 = getelementptr %struct.linkedNums, %struct.linkedNums* %u2528, i1 0, i32 1
	store %struct.linkedNums* null, %struct.linkedNums** %u2529
	%u2530 = load i32, i32* %_P_num
	%u2531 = sub i32 %u2530, 1
	store i32 %u2531, i32* %_P_num
	%u2532 = load i32, i32* %cur
	store i32 %u2532, i32* %prev
	%u2533 = load i32, i32* %_P_num
	%u2534 = icmp sgt i32 %u2533, 0
	br i1 %u2534, label %LU2, label %LU3
LU2:
	%u2535 = load i32, i32* %prev
	%u2536 = load i32, i32* %prev
	%u2537 = mul i32 %u2535, %u2536
	%u2538 = load i32, i32* %_P_seed
	%u2539 = sdiv i32 %u2537, %u2538
	%u2540 = load i32, i32* %_P_seed
	%u2541 = sdiv i32 %u2540, 2
	%u2542 = mul i32 %u2539, %u2541
	%u2543 = add i32 %u2542, 1
	store i32 %u2543, i32* %cur
	%u2544 = load i32, i32* %cur
	%u2545 = load i32, i32* %cur
	%u2546 = sdiv i32 %u2545, 1000000000
	%u2547 = mul i32 %u2546, 1000000000
	%u2548 = sub i32 %u2544, %u2547
	store i32 %u2548, i32* %cur
	%u2549 = call i8* @malloc(i32 8)
	%u2550 = bitcast i8* %u2549 to %struct.linkedNums*
	store %struct.linkedNums* %u2550, %struct.linkedNums** %curNode
	%u2551 = load i32, i32* %cur
	%u2552 = load %struct.linkedNums*, %struct.linkedNums** %curNode
	%u2553 = getelementptr %struct.linkedNums, %struct.linkedNums* %u2552, i1 0, i32 0
	store i32 %u2551, i32* %u2553
	%u2554 = load %struct.linkedNums*, %struct.linkedNums** %prevNode
	%u2555 = load %struct.linkedNums*, %struct.linkedNums** %curNode
	%u2556 = getelementptr %struct.linkedNums, %struct.linkedNums* %u2555, i1 0, i32 1
	store %struct.linkedNums* %u2554, %struct.linkedNums** %u2556
	%u2557 = load %struct.linkedNums*, %struct.linkedNums** %curNode
	store %struct.linkedNums* %u2557, %struct.linkedNums** %prevNode
	%u2558 = load i32, i32* %_P_num
	%u2559 = sub i32 %u2558, 1
	store i32 %u2559, i32* %_P_num
	%u2560 = load i32, i32* %cur
	store i32 %u2560, i32* %prev
	%u2561 = load i32, i32* %_P_num
	%u2562 = icmp sgt i32 %u2561, 0
	br i1 %u2562, label %LU2, label %LU3
LU3:
	%u2563 = load %struct.linkedNums*, %struct.linkedNums** %curNode
	store %struct.linkedNums* %u2563, %struct.linkedNums** %_retval_
	br label %LU0
LU0:
	%u2564 = load %struct.linkedNums*, %struct.linkedNums** %_retval_
	ret %struct.linkedNums* %u2564
}

define i32 @calcMean(%struct.linkedNums* %nums)
{
LU5:
	%_P_nums = alloca %struct.linkedNums*
	%_retval_ = alloca i32
	%sum = alloca i32
	%num = alloca i32
	%mean = alloca i32
	store %struct.linkedNums* %nums, %struct.linkedNums** %_P_nums
	store i32 0, i32* %sum
	store i32 0, i32* %num
	store i32 0, i32* %mean
	%u2565 = load %struct.linkedNums*, %struct.linkedNums** %_P_nums
	%u2566 = icmp ne %struct.linkedNums* %u2565, null
	br i1 %u2566, label %LU6, label %LU7
LU6:
	%u2567 = load i32, i32* %num
	%u2568 = add i32 %u2567, 1
	store i32 %u2568, i32* %num
	%u2569 = load i32, i32* %sum
	%u2570 = load %struct.linkedNums*, %struct.linkedNums** %_P_nums
	%u2571 = getelementptr %struct.linkedNums, %struct.linkedNums* %u2570, i1 0, i32 0
	%u2572 = load i32, i32* %u2571
	%u2573 = add i32 %u2569, %u2572
	store i32 %u2573, i32* %sum
	%u2574 = load %struct.linkedNums*, %struct.linkedNums** %_P_nums
	%u2575 = getelementptr %struct.linkedNums, %struct.linkedNums* %u2574, i1 0, i32 1
	%u2576 = load %struct.linkedNums*, %struct.linkedNums** %u2575
	store %struct.linkedNums* %u2576, %struct.linkedNums** %_P_nums
	%u2577 = load %struct.linkedNums*, %struct.linkedNums** %_P_nums
	%u2578 = icmp ne %struct.linkedNums* %u2577, null
	br i1 %u2578, label %LU6, label %LU7
LU7:
	%u2579 = load i32, i32* %num
	%u2580 = icmp ne i32 %u2579, 0
	br i1 %u2580, label %LU8, label %LU9
LU8:
	%u2581 = load i32, i32* %sum
	%u2582 = load i32, i32* %num
	%u2583 = sdiv i32 %u2581, %u2582
	store i32 %u2583, i32* %mean
	br label %LU9
LU9:
	%u2584 = load i32, i32* %mean
	store i32 %u2584, i32* %_retval_
	br label %LU4
LU4:
	%u2585 = load i32, i32* %_retval_
	ret i32 %u2585
}

define i32 @approxSqrt(i32 %num)
{
LU11:
	%_P_num = alloca i32
	%_retval_ = alloca i32
	%guess = alloca i32
	%result = alloca i32
	%prev = alloca i32
	store i32 %num, i32* %_P_num
	store i32 1, i32* %guess
	%u2586 = load i32, i32* %guess
	store i32 %u2586, i32* %prev
	store i32 0, i32* %result
	%u2587 = load i32, i32* %result
	%u2588 = load i32, i32* %_P_num
	%u2589 = icmp slt i32 %u2587, %u2588
	br i1 %u2589, label %LU12, label %LU13
LU12:
	%u2590 = load i32, i32* %guess
	%u2591 = load i32, i32* %guess
	%u2592 = mul i32 %u2590, %u2591
	store i32 %u2592, i32* %result
	%u2593 = load i32, i32* %guess
	store i32 %u2593, i32* %prev
	%u2594 = load i32, i32* %guess
	%u2595 = add i32 %u2594, 1
	store i32 %u2595, i32* %guess
	%u2596 = load i32, i32* %result
	%u2597 = load i32, i32* %_P_num
	%u2598 = icmp slt i32 %u2596, %u2597
	br i1 %u2598, label %LU12, label %LU13
LU13:
	%u2599 = load i32, i32* %prev
	store i32 %u2599, i32* %_retval_
	br label %LU10
LU10:
	%u2600 = load i32, i32* %_retval_
	ret i32 %u2600
}

define void @approxSqrtAll(%struct.linkedNums* %nums)
{
LU15:
	%_P_nums = alloca %struct.linkedNums*
	store %struct.linkedNums* %nums, %struct.linkedNums** %_P_nums
	%u2601 = load %struct.linkedNums*, %struct.linkedNums** %_P_nums
	%u2602 = icmp ne %struct.linkedNums* %u2601, null
	br i1 %u2602, label %LU16, label %LU17
LU16:
	%u2603 = load %struct.linkedNums*, %struct.linkedNums** %_P_nums
	%u2604 = getelementptr %struct.linkedNums, %struct.linkedNums* %u2603, i1 0, i32 0
	%u2605 = load i32, i32* %u2604
	%u2606 = call i32 @approxSqrt(i32 %u2605)
	call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([6 x i8], [6 x i8]* @.println, i32 0, i32 0), i32 %u2606)
	%u2607 = load %struct.linkedNums*, %struct.linkedNums** %_P_nums
	%u2608 = getelementptr %struct.linkedNums, %struct.linkedNums* %u2607, i1 0, i32 1
	%u2609 = load %struct.linkedNums*, %struct.linkedNums** %u2608
	store %struct.linkedNums* %u2609, %struct.linkedNums** %_P_nums
	%u2610 = load %struct.linkedNums*, %struct.linkedNums** %_P_nums
	%u2611 = icmp ne %struct.linkedNums* %u2610, null
	br i1 %u2611, label %LU16, label %LU17
LU17:
	br label %LU14
LU14:
	ret void
}

define void @range(%struct.linkedNums* %nums)
{
LU19:
	%_P_nums = alloca %struct.linkedNums*
	%min = alloca i32
	%max = alloca i32
	%first = alloca i32
	store %struct.linkedNums* %nums, %struct.linkedNums** %_P_nums
	store i32 0, i32* %min
	store i32 0, i32* %max
	%u2612 = zext i1 true to i32
	store i32 %u2612, i32* %first
	%u2613 = load %struct.linkedNums*, %struct.linkedNums** %_P_nums
	%u2614 = icmp ne %struct.linkedNums* %u2613, null
	br i1 %u2614, label %LU20, label %LU21
LU20:
	%u2615 = load i32, i32* %first
	%u2616 = trunc i32 %u2615 to i1
	br i1 %u2616, label %LU22, label %LU23
LU22:
	%u2617 = load %struct.linkedNums*, %struct.linkedNums** %_P_nums
	%u2618 = getelementptr %struct.linkedNums, %struct.linkedNums* %u2617, i1 0, i32 0
	%u2619 = load i32, i32* %u2618
	store i32 %u2619, i32* %min
	%u2620 = load %struct.linkedNums*, %struct.linkedNums** %_P_nums
	%u2621 = getelementptr %struct.linkedNums, %struct.linkedNums* %u2620, i1 0, i32 0
	%u2622 = load i32, i32* %u2621
	store i32 %u2622, i32* %max
	%u2623 = zext i1 false to i32
	store i32 %u2623, i32* %first
	br label %LU24
LU23:
	%u2624 = load %struct.linkedNums*, %struct.linkedNums** %_P_nums
	%u2625 = getelementptr %struct.linkedNums, %struct.linkedNums* %u2624, i1 0, i32 0
	%u2626 = load i32, i32* %u2625
	%u2627 = load i32, i32* %min
	%u2628 = icmp slt i32 %u2626, %u2627
	br i1 %u2628, label %LU25, label %LU26
LU25:
	%u2629 = load %struct.linkedNums*, %struct.linkedNums** %_P_nums
	%u2630 = getelementptr %struct.linkedNums, %struct.linkedNums* %u2629, i1 0, i32 0
	%u2631 = load i32, i32* %u2630
	store i32 %u2631, i32* %min
	br label %LU27
LU26:
	%u2632 = load %struct.linkedNums*, %struct.linkedNums** %_P_nums
	%u2633 = getelementptr %struct.linkedNums, %struct.linkedNums* %u2632, i1 0, i32 0
	%u2634 = load i32, i32* %u2633
	%u2635 = load i32, i32* %max
	%u2636 = icmp sgt i32 %u2634, %u2635
	br i1 %u2636, label %LU28, label %LU29
LU28:
	%u2637 = load %struct.linkedNums*, %struct.linkedNums** %_P_nums
	%u2638 = getelementptr %struct.linkedNums, %struct.linkedNums* %u2637, i1 0, i32 0
	%u2639 = load i32, i32* %u2638
	store i32 %u2639, i32* %max
	br label %LU29
LU29:
	br label %LU27
LU27:
	br label %LU24
LU24:
	%u2640 = load %struct.linkedNums*, %struct.linkedNums** %_P_nums
	%u2641 = getelementptr %struct.linkedNums, %struct.linkedNums* %u2640, i1 0, i32 1
	%u2642 = load %struct.linkedNums*, %struct.linkedNums** %u2641
	store %struct.linkedNums* %u2642, %struct.linkedNums** %_P_nums
	%u2643 = load %struct.linkedNums*, %struct.linkedNums** %_P_nums
	%u2644 = icmp ne %struct.linkedNums* %u2643, null
	br i1 %u2644, label %LU20, label %LU21
LU21:
	%u2645 = load i32, i32* %min
	call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([6 x i8], [6 x i8]* @.println, i32 0, i32 0), i32 %u2645)
	%u2646 = load i32, i32* %max
	call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([6 x i8], [6 x i8]* @.println, i32 0, i32 0), i32 %u2646)
	br label %LU18
LU18:
	ret void
}

define i32 @main()
{
LU31:
	%_retval_ = alloca i32
	%seed = alloca i32
	%num = alloca i32
	%mean = alloca i32
	%nums = alloca %struct.linkedNums*
	call i32 (i8*, ...) @scanf(i8* getelementptr inbounds ([5 x i8], [5 x i8]* @.read, i32 0, i32 0), i32* %seed)
	call i32 (i8*, ...) @scanf(i8* getelementptr inbounds ([5 x i8], [5 x i8]* @.read, i32 0, i32 0), i32* %num)
	%u2647 = load i32, i32* %seed
	%u2648 = load i32, i32* %num
	%u2649 = call %struct.linkedNums* @getRands(i32 %u2647, i32 %u2648)
	store %struct.linkedNums* %u2649, %struct.linkedNums** %nums
	%u2650 = load %struct.linkedNums*, %struct.linkedNums** %nums
	%u2651 = call i32 @calcMean(%struct.linkedNums* %u2650)
	store i32 %u2651, i32* %mean
	%u2652 = load i32, i32* %mean
	call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([6 x i8], [6 x i8]* @.println, i32 0, i32 0), i32 %u2652)
	%u2653 = load %struct.linkedNums*, %struct.linkedNums** %nums
	call void @range(%struct.linkedNums* %u2653)
	%u2654 = load %struct.linkedNums*, %struct.linkedNums** %nums
	call void @approxSqrtAll(%struct.linkedNums* %u2654)
	store i32 0, i32* %_retval_
	br label %LU30
LU30:
	%u2655 = load i32, i32* %_retval_
	ret i32 %u2655
}
declare i8* @malloc(i32)
declare void @free(i8*)
declare i32 @printf(i8*, ...)
declare i32 @scanf(i8*, ...)
@.println = private unnamed_addr constant [6 x i8] c"%ld\0A\00\00", align 1
@.print = private unnamed_addr constant [6 x i8] c"%ld \00\00", align 1
@.read = private unnamed_addr constant [5 x i8] c"%ld\00\00", align 1
@.read_scratch = common global i32 0, align 4
