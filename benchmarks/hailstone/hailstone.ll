target triple="i686"




define i32 @mod(i32 %a, i32 %b)
{
LU1:
	%_P_a = alloca i32
	%_P_b = alloca i32
	%_retval_ = alloca i32
	store i32 %a, i32* %_P_a
	store i32 %b, i32* %_P_b
	%u2033 = load i32, i32* %_P_a
	%u2034 = load i32, i32* %_P_a
	%u2035 = load i32, i32* %_P_b
	%u2036 = sdiv i32 %u2034, %u2035
	%u2037 = load i32, i32* %_P_b
	%u2038 = mul i32 %u2036, %u2037
	%u2039 = sub i32 %u2033, %u2038
	store i32 %u2039, i32* %_retval_
	br label %LU0
LU0:
	%u2040 = load i32, i32* %_retval_
	ret i32 %u2040
}

define void @hailstone(i32 %n)
{
LU3:
	%_P_n = alloca i32
	store i32 %n, i32* %_P_n
	br i1 true, label %LU4, label %LU5
LU4:
	%u2041 = load i32, i32* %_P_n
	call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([6 x i8], [6 x i8]* @.print, i32 0, i32 0), i32 %u2041)
	%u2042 = load i32, i32* %_P_n
	%u2043 = call i32 @mod(i32 %u2042, i32 2)
	%u2044 = icmp eq i32 %u2043, 1
	br i1 %u2044, label %LU6, label %LU7
LU6:
	%u2045 = load i32, i32* %_P_n
	%u2046 = mul i32 3, %u2045
	%u2047 = add i32 %u2046, 1
	store i32 %u2047, i32* %_P_n
	br label %LU8
LU7:
	%u2048 = load i32, i32* %_P_n
	%u2049 = sdiv i32 %u2048, 2
	store i32 %u2049, i32* %_P_n
	br label %LU8
LU8:
	%u2050 = load i32, i32* %_P_n
	%u2051 = icmp sle i32 %u2050, 1
	br i1 %u2051, label %LU9, label %LU10
LU9:
	%u2052 = load i32, i32* %_P_n
	call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([6 x i8], [6 x i8]* @.println, i32 0, i32 0), i32 %u2052)
	br label %LU2
LU10:
	br i1 true, label %LU4, label %LU5
LU5:
	br label %LU2
LU2:
	ret void
}

define i32 @main()
{
LU12:
	%_retval_ = alloca i32
	%num = alloca i32
	call i32 (i8*, ...) @scanf(i8* getelementptr inbounds ([5 x i8], [5 x i8]* @.read, i32 0, i32 0), i32* %num)
	%u2053 = load i32, i32* %num
	call void @hailstone(i32 %u2053)
	store i32 0, i32* %_retval_
	br label %LU11
LU11:
	%u2054 = load i32, i32* %_retval_
	ret i32 %u2054
}
declare i8* @malloc(i32)
declare void @free(i8*)
declare i32 @printf(i8*, ...)
declare i32 @scanf(i8*, ...)
@.println = private unnamed_addr constant [6 x i8] c"%ld\0A\00\00", align 1
@.print = private unnamed_addr constant [6 x i8] c"%ld \00\00", align 1
@.read = private unnamed_addr constant [5 x i8] c"%ld\00\00", align 1
@.read_scratch = common global i32 0, align 4
