target triple="i686"




define i32 @function(i32 %n)
{
LU1:
	%_P_n = alloca i32
	%_retval_ = alloca i32
	%i = alloca i32
	%j = alloca i32
	store i32 %n, i32* %_P_n
	%u2656 = load i32, i32* %_P_n
	%u2657 = icmp sle i32 %u2656, 0
	br i1 %u2657, label %LU2, label %LU3
LU2:
	store i32 0, i32* %_retval_
	br label %LU0
LU3:
	store i32 0, i32* %i
	%u2658 = load i32, i32* %i
	%u2659 = load i32, i32* %_P_n
	%u2660 = load i32, i32* %_P_n
	%u2661 = mul i32 %u2659, %u2660
	%u2662 = icmp slt i32 %u2658, %u2661
	br i1 %u2662, label %LU4, label %LU5
LU4:
	%u2663 = load i32, i32* %i
	%u2664 = load i32, i32* %_P_n
	%u2665 = add i32 %u2663, %u2664
	store i32 %u2665, i32* %j
	%u2666 = load i32, i32* %j
	call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([6 x i8], [6 x i8]* @.print, i32 0, i32 0), i32 %u2666)
	%u2667 = load i32, i32* %i
	%u2668 = add i32 %u2667, 1
	store i32 %u2668, i32* %i
	%u2669 = load i32, i32* %i
	%u2670 = load i32, i32* %_P_n
	%u2671 = load i32, i32* %_P_n
	%u2672 = mul i32 %u2670, %u2671
	%u2673 = icmp slt i32 %u2669, %u2672
	br i1 %u2673, label %LU4, label %LU5
LU5:
	%u2674 = load i32, i32* %_P_n
	%u2675 = sub i32 %u2674, 1
	%u2676 = call i32 @function(i32 %u2675)
	store i32 %u2676, i32* %_retval_
	br label %LU0
LU0:
	%u2677 = load i32, i32* %_retval_
	ret i32 %u2677
}

define i32 @main()
{
LU7:
	%_retval_ = alloca i32
	%num = alloca i32
	call i32 (i8*, ...) @scanf(i8* getelementptr inbounds ([5 x i8], [5 x i8]* @.read, i32 0, i32 0), i32* %num)
	%u2678 = load i32, i32* %num
	call i32 @function(i32 %u2678)
	call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([6 x i8], [6 x i8]* @.println, i32 0, i32 0), i32 0)
	store i32 0, i32* %_retval_
	br label %LU6
LU6:
	%u2679 = load i32, i32* %_retval_
	ret i32 %u2679
}
declare i8* @malloc(i32)
declare void @free(i8*)
declare i32 @printf(i8*, ...)
declare i32 @scanf(i8*, ...)
@.println = private unnamed_addr constant [6 x i8] c"%ld\0A\00\00", align 1
@.print = private unnamed_addr constant [6 x i8] c"%ld \00\00", align 1
@.read = private unnamed_addr constant [5 x i8] c"%ld\00\00", align 1
@.read_scratch = common global i32 0, align 4
