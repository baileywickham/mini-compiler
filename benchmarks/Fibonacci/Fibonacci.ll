target triple="i686"




define i32 @computeFib(i32 %input)
{
LU1:
	%_P_input = alloca i32
	%_retval_ = alloca i32
	store i32 %input, i32* %_P_input
	%u69 = load i32, i32* %_P_input
	%u70 = icmp eq i32 %u69, 0
	br i1 %u70, label %LU2, label %LU3
LU2:
	store i32 0, i32* %_retval_
	br label %LU0
LU3:
	%u71 = load i32, i32* %_P_input
	%u72 = icmp sle i32 %u71, 2
	br i1 %u72, label %LU5, label %LU6
LU5:
	store i32 1, i32* %_retval_
	br label %LU0
LU6:
	%u73 = load i32, i32* %_P_input
	%u74 = sub i32 %u73, 1
	%u75 = call i32 @computeFib(i32 %u74)
	%u76 = load i32, i32* %_P_input
	%u77 = sub i32 %u76, 2
	%u78 = call i32 @computeFib(i32 %u77)
	%u79 = add i32 %u75, %u78
	store i32 %u79, i32* %_retval_
	br label %LU0
LU7:
	br label %LU4
LU4:
	br label %LU0
LU0:
	%u80 = load i32, i32* %_retval_
	ret i32 %u80
}

define i32 @main()
{
LU9:
	%_retval_ = alloca i32
	%input = alloca i32
	call i32 (i8*, ...) @scanf(i8* getelementptr inbounds ([5 x i8], [5 x i8]* @.read, i32 0, i32 0), i32* %input)
	%u81 = load i32, i32* %input
	%u82 = call i32 @computeFib(i32 %u81)
	call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([6 x i8], [6 x i8]* @.println, i32 0, i32 0), i32 %u82)
	store i32 0, i32* %_retval_
	br label %LU8
LU8:
	%u83 = load i32, i32* %_retval_
	ret i32 %u83
}
declare i8* @malloc(i32)
declare void @free(i8*)
declare i32 @printf(i8*, ...)
declare i32 @scanf(i8*, ...)
@.println = private unnamed_addr constant [6 x i8] c"%ld\0A\00\00", align 1
@.print = private unnamed_addr constant [6 x i8] c"%ld \00\00", align 1
@.read = private unnamed_addr constant [5 x i8] c"%ld\00\00", align 1
@.read_scratch = common global i32 0, align 4
