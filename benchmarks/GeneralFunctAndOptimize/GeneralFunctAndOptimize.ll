target triple="i686"
%struct.IntHolder = type {i32}

@interval = common global i32 0, align 4
@end = common global i32 0, align 4

define i32 @multBy4xTimes(%struct.IntHolder* %num, i32 %timesLeft)
{
LU1:
	%_P_num = alloca %struct.IntHolder*
	%_P_timesLeft = alloca i32
	%_retval_ = alloca i32
	store %struct.IntHolder* %num, %struct.IntHolder** %_P_num
	store i32 %timesLeft, i32* %_P_timesLeft
	%u84 = load i32, i32* %_P_timesLeft
	%u85 = icmp sle i32 %u84, 0
	br i1 %u85, label %LU2, label %LU3
LU2:
	%u86 = load %struct.IntHolder*, %struct.IntHolder** %_P_num
	%u87 = getelementptr %struct.IntHolder, %struct.IntHolder* %u86, i1 0, i32 0
	%u88 = load i32, i32* %u87
	store i32 %u88, i32* %_retval_
	br label %LU0
LU3:
	%u89 = load %struct.IntHolder*, %struct.IntHolder** %_P_num
	%u90 = getelementptr %struct.IntHolder, %struct.IntHolder* %u89, i1 0, i32 0
	%u91 = load i32, i32* %u90
	%u92 = mul i32 4, %u91
	%u93 = load %struct.IntHolder*, %struct.IntHolder** %_P_num
	%u94 = getelementptr %struct.IntHolder, %struct.IntHolder* %u93, i1 0, i32 0
	store i32 %u92, i32* %u94
	%u95 = load %struct.IntHolder*, %struct.IntHolder** %_P_num
	%u96 = load i32, i32* %_P_timesLeft
	%u97 = sub i32 %u96, 1
	call i32 @multBy4xTimes(%struct.IntHolder* %u95, i32 %u97)
	%u98 = load %struct.IntHolder*, %struct.IntHolder** %_P_num
	%u99 = getelementptr %struct.IntHolder, %struct.IntHolder* %u98, i1 0, i32 0
	%u100 = load i32, i32* %u99
	store i32 %u100, i32* %_retval_
	br label %LU0
LU0:
	%u101 = load i32, i32* %_retval_
	ret i32 %u101
}

define void @divideBy8(%struct.IntHolder* %num)
{
LU5:
	%_P_num = alloca %struct.IntHolder*
	store %struct.IntHolder* %num, %struct.IntHolder** %_P_num
	%u102 = load %struct.IntHolder*, %struct.IntHolder** %_P_num
	%u103 = getelementptr %struct.IntHolder, %struct.IntHolder* %u102, i1 0, i32 0
	%u104 = load i32, i32* %u103
	%u105 = sdiv i32 %u104, 2
	%u106 = load %struct.IntHolder*, %struct.IntHolder** %_P_num
	%u107 = getelementptr %struct.IntHolder, %struct.IntHolder* %u106, i1 0, i32 0
	store i32 %u105, i32* %u107
	%u108 = load %struct.IntHolder*, %struct.IntHolder** %_P_num
	%u109 = getelementptr %struct.IntHolder, %struct.IntHolder* %u108, i1 0, i32 0
	%u110 = load i32, i32* %u109
	%u111 = sdiv i32 %u110, 2
	%u112 = load %struct.IntHolder*, %struct.IntHolder** %_P_num
	%u113 = getelementptr %struct.IntHolder, %struct.IntHolder* %u112, i1 0, i32 0
	store i32 %u111, i32* %u113
	%u114 = load %struct.IntHolder*, %struct.IntHolder** %_P_num
	%u115 = getelementptr %struct.IntHolder, %struct.IntHolder* %u114, i1 0, i32 0
	%u116 = load i32, i32* %u115
	%u117 = sdiv i32 %u116, 2
	%u118 = load %struct.IntHolder*, %struct.IntHolder** %_P_num
	%u119 = getelementptr %struct.IntHolder, %struct.IntHolder* %u118, i1 0, i32 0
	store i32 %u117, i32* %u119
	br label %LU4
LU4:
	ret void
}

define i32 @main()
{
LU7:
	%_retval_ = alloca i32
	%start = alloca i32
	%countOuter = alloca i32
	%countInner = alloca i32
	%calc = alloca i32
	%tempAnswer = alloca i32
	%tempInterval = alloca i32
	%x = alloca %struct.IntHolder*
	%uselessVar = alloca i32
	%uselessVar2 = alloca i32
	%u120 = call i8* @malloc(i32 4)
	%u121 = bitcast i8* %u120 to %struct.IntHolder*
	store %struct.IntHolder* %u121, %struct.IntHolder** %x
	store i32 1000000, i32* @end
	call i32 (i8*, ...) @scanf(i8* getelementptr inbounds ([5 x i8], [5 x i8]* @.read, i32 0, i32 0), i32* %start)
	call i32 (i8*, ...) @scanf(i8* getelementptr inbounds ([5 x i8], [5 x i8]* @.read, i32 0, i32 0), i32* @interval)
	%u122 = load i32, i32* %start
	call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([6 x i8], [6 x i8]* @.println, i32 0, i32 0), i32 %u122)
	%u123 = load i32, i32* @interval
	call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([6 x i8], [6 x i8]* @.println, i32 0, i32 0), i32 %u123)
	store i32 0, i32* %countOuter
	store i32 0, i32* %countInner
	store i32 0, i32* %calc
	%u124 = load i32, i32* %countOuter
	%u125 = icmp slt i32 %u124, 50
	br i1 %u125, label %LU8, label %LU9
LU8:
	store i32 0, i32* %countInner
	%u126 = load i32, i32* %countInner
	%u127 = load i32, i32* @end
	%u128 = icmp sle i32 %u126, %u127
	br i1 %u128, label %LU10, label %LU11
LU10:
	%u129 = mul i32 1, 2
	%u130 = mul i32 %u129, 3
	%u131 = mul i32 %u130, 4
	%u132 = mul i32 %u131, 5
	%u133 = mul i32 %u132, 6
	%u134 = mul i32 %u133, 7
	%u135 = mul i32 %u134, 8
	%u136 = mul i32 %u135, 9
	%u137 = mul i32 %u136, 10
	%u138 = mul i32 %u137, 11
	store i32 %u138, i32* %calc
	%u139 = load i32, i32* %countInner
	%u140 = add i32 %u139, 1
	store i32 %u140, i32* %countInner
	%u141 = load i32, i32* %countInner
	%u142 = load %struct.IntHolder*, %struct.IntHolder** %x
	%u143 = getelementptr %struct.IntHolder, %struct.IntHolder* %u142, i1 0, i32 0
	store i32 %u141, i32* %u143
	%u144 = load %struct.IntHolder*, %struct.IntHolder** %x
	%u145 = getelementptr %struct.IntHolder, %struct.IntHolder* %u144, i1 0, i32 0
	%u146 = load i32, i32* %u145
	store i32 %u146, i32* %tempAnswer
	%u147 = load %struct.IntHolder*, %struct.IntHolder** %x
	call i32 @multBy4xTimes(%struct.IntHolder* %u147, i32 2)
	%u148 = load %struct.IntHolder*, %struct.IntHolder** %x
	call void @divideBy8(%struct.IntHolder* %u148)
	%u149 = load i32, i32* @interval
	%u150 = sub i32 %u149, 1
	store i32 %u150, i32* %tempInterval
	%u151 = load i32, i32* %tempInterval
	%u152 = icmp sle i32 %u151, 0
	%u153 = zext i1 %u152 to i32
	store i32 %u153, i32* %uselessVar
	%u154 = load i32, i32* %tempInterval
	%u155 = icmp sle i32 %u154, 0
	br i1 %u155, label %LU12, label %LU13
LU12:
	store i32 1, i32* %tempInterval
	br label %LU13
LU13:
	%u156 = load i32, i32* %countInner
	%u157 = load i32, i32* %tempInterval
	%u158 = add i32 %u156, %u157
	store i32 %u158, i32* %countInner
	%u159 = load i32, i32* %countInner
	%u160 = load i32, i32* @end
	%u161 = icmp sle i32 %u159, %u160
	br i1 %u161, label %LU10, label %LU11
LU11:
	%u162 = load i32, i32* %countOuter
	%u163 = add i32 %u162, 1
	store i32 %u163, i32* %countOuter
	%u164 = load i32, i32* %countOuter
	%u165 = icmp slt i32 %u164, 50
	br i1 %u165, label %LU8, label %LU9
LU9:
	%u166 = load i32, i32* %countInner
	call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([6 x i8], [6 x i8]* @.println, i32 0, i32 0), i32 %u166)
	%u167 = load i32, i32* %calc
	call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([6 x i8], [6 x i8]* @.println, i32 0, i32 0), i32 %u167)
	store i32 0, i32* %_retval_
	br label %LU6
LU6:
	%u168 = load i32, i32* %_retval_
	ret i32 %u168
}
declare i8* @malloc(i32)
declare void @free(i8*)
declare i32 @printf(i8*, ...)
declare i32 @scanf(i8*, ...)
@.println = private unnamed_addr constant [6 x i8] c"%ld\0A\00\00", align 1
@.print = private unnamed_addr constant [6 x i8] c"%ld \00\00", align 1
@.read = private unnamed_addr constant [5 x i8] c"%ld\00\00", align 1
@.read_scratch = common global i32 0, align 4
