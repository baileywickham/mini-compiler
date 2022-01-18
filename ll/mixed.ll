%struct.simple = type {i32}
%struct.foo = type {i32, i32, %struct.simple*}
@globalfoo = common global %struct.foo* null, align 4
define void @tailrecursive(i32 %num)
{
LU1:
	%_P_num = alloca i32
	store i32 %num, i32* %_P_num
	%u0 = load i32, i32* %_P_num
	%u1 = icmp sle i32 %u0, 0
	br i1 %u1, label %LU2, label %LU3
LU2:
	br label %LU0
LU3:
	%u2 = load i32, i32* %_P_num
	%u3 = sub i32 %u2, 1
	call void @tailrecursive(i32 %u3)
	br label %LU0
LU0:
	ret void
}

define i32 @add(i32 %x, i32 %y)
{
LU5:
	%_P_x = alloca i32
	%_P_y = alloca i32
	%_retval_ = alloca i32
	store i32 %x, i32* %_P_x
	store i32 %y, i32* %_P_y
	%u4 = load i32, i32* %_P_x
	%u5 = load i32, i32* %_P_y
	%u6 = add i32 %u4, %u5
	store i32 %u6, i32* %_retval_
	br label %LU4
LU4:
	%u7 = load i32, i32* %_retval_
	ret i32 %u7
}

define void @domath(i32 %num)
{
LU7:
	%_P_num = alloca i32
	%math1 = alloca %struct.foo*
	%math2 = alloca %struct.foo*
	%tmp = alloca i32
	store i32 %num, i32* %_P_num
	%u8 = call i8* @malloc(i32 12)
	%u9 = bitcast i8* %u8 to %struct.foo*
	store %struct.foo* %u9, %struct.foo** %math1
	%u10 = call i8* @malloc(i32 4)
	%u11 = bitcast i8* %u10 to %struct.simple*
	%u12 = load %struct.foo*, %struct.foo** %math1
	%u13 = getelementptr %struct.foo, %struct.foo* %u12, i1 0, i32 2
	store %struct.simple* %u11, %struct.simple** %u13
	%u14 = call i8* @malloc(i32 12)
	%u15 = bitcast i8* %u14 to %struct.foo*
	store %struct.foo* %u15, %struct.foo** %math2
	%u16 = call i8* @malloc(i32 4)
	%u17 = bitcast i8* %u16 to %struct.simple*
	%u18 = load %struct.foo*, %struct.foo** %math2
	%u19 = getelementptr %struct.foo, %struct.foo* %u18, i1 0, i32 2
	store %struct.simple* %u17, %struct.simple** %u19
	%u20 = load i32, i32* %_P_num
	%u21 = load %struct.foo*, %struct.foo** %math1
	%u22 = getelementptr %struct.foo, %struct.foo* %u21, i1 0, i32 0
	store i32 %u20, i32* %u22
	%u23 = load %struct.foo*, %struct.foo** %math2
	%u24 = getelementptr %struct.foo, %struct.foo* %u23, i1 0, i32 0
	store i32 3, i32* %u24
	%u25 = load %struct.foo*, %struct.foo** %math1
	%u26 = getelementptr %struct.foo, %struct.foo* %u25, i1 0, i32 0
	%u27 = load %struct.foo*, %struct.foo** %math1
	%u28 = getelementptr %struct.foo, %struct.foo* %u27, i1 0, i32 2
	%u29 = getelementptr %struct.simple, %struct.simple* %u28, i1 0, i32 0
	store i32 %u26, i32* %u29
	%u30 = load %struct.foo*, %struct.foo** %math2
	%u31 = getelementptr %struct.foo, %struct.foo* %u30, i1 0, i32 0
	%u32 = load %struct.foo*, %struct.foo** %math2
	%u33 = getelementptr %struct.foo, %struct.foo* %u32, i1 0, i32 2
	%u34 = getelementptr %struct.simple, %struct.simple* %u33, i1 0, i32 0
	store i32 %u31, i32* %u34
	%u35 = load i32, i32* %_P_num
	%u36 = icmp sgt i32 %u35, 0
	br i1 %u36, label %LU8, label %LU9
LU8:
	%u37 = load %struct.foo*, %struct.foo** %math1
	%u38 = getelementptr %struct.foo, %struct.foo* %u37, i1 0, i32 0
	%u39 = load %struct.foo*, %struct.foo** %math2
	%u40 = getelementptr %struct.foo, %struct.foo* %u39, i1 0, i32 0
	%u41 = mul i32 %u38, %u40
	store i32 %u41, i32* %tmp
	%u42 = load i32, i32* %tmp
	%u43 = load %struct.foo*, %struct.foo** %math1
	%u44 = getelementptr %struct.foo, %struct.foo* %u43, i1 0, i32 2
	%u45 = getelementptr %struct.simple, %struct.simple* %u44, i1 0, i32 0
	%u46 = mul i32 %u42, %u45
	%u47 = load %struct.foo*, %struct.foo** %math2
	%u48 = getelementptr %struct.foo, %struct.foo* %u47, i1 0, i32 0
	%u49 = sdiv i32 %u46, %u48
	store i32 %u49, i32* %tmp
	%u50 = load %struct.foo*, %struct.foo** %math2
	%u51 = getelementptr %struct.foo, %struct.foo* %u50, i1 0, i32 2
	%u52 = getelementptr %struct.simple, %struct.simple* %u51, i1 0, i32 0
	%u53 = load %struct.foo*, %struct.foo** %math1
	%u54 = getelementptr %struct.foo, %struct.foo* %u53, i1 0, i32 0
	%u55 = call i32 @add(i32 %u52, i32 %u54)
	store i32 %u55, i32* %tmp
	%u56 = load %struct.foo*, %struct.foo** %math2
	%u57 = getelementptr %struct.foo, %struct.foo* %u56, i1 0, i32 0
	%u58 = load %struct.foo*, %struct.foo** %math1
	%u59 = getelementptr %struct.foo, %struct.foo* %u58, i1 0, i32 0
	%u60 = sub i32 %u57, %u59
	store i32 %u60, i32* %tmp
	%u61 = load i32, i32* %_P_num
	%u62 = sub i32 %u61, 1
	store i32 %u62, i32* %_P_num
	%u63 = load i32, i32* %_P_num
	%u64 = icmp sgt i32 %u63, 0
	br i1 %u64, label %LU8, label %LU9
LU9:
	%u65 = load %struct.foo*, %struct.foo** %math1
	%u66 = bitcast %struct.foo* %u65 to i8*
	call void @free(i8* %u66)
	%u67 = load %struct.foo*, %struct.foo** %math2
	%u68 = bitcast %struct.foo* %u67 to i8*
	call void @free(i8* %u68)
	br label %LU6
LU6:
	ret void
}

define void @objinstantiation(i32 %num)
{
LU11:
	%_P_num = alloca i32
	%tmp = alloca %struct.foo*
	store i32 %num, i32* %_P_num
	%u69 = load i32, i32* %_P_num
	%u70 = icmp sgt i32 %u69, 0
	br i1 %u70, label %LU12, label %LU13
LU12:
	%u71 = call i8* @malloc(i32 12)
	%u72 = bitcast i8* %u71 to %struct.foo*
	store %struct.foo* %u72, %struct.foo** %tmp
	%u73 = load %struct.foo*, %struct.foo** %tmp
	%u74 = bitcast %struct.foo* %u73 to i8*
	call void @free(i8* %u74)
	%u75 = load i32, i32* %_P_num
	%u76 = sub i32 %u75, 1
	store i32 %u76, i32* %_P_num
	%u77 = load i32, i32* %_P_num
	%u78 = icmp sgt i32 %u77, 0
	br i1 %u78, label %LU12, label %LU13
LU13:
	br label %LU10
LU10:
	ret void
}

define i32 @ackermann(i32 %m, i32 %n)
{
LU15:
	%_P_m = alloca i32
	%_P_n = alloca i32
	%_retval_ = alloca i32
	store i32 %m, i32* %_P_m
	store i32 %n, i32* %_P_n
	%u79 = load i32, i32* %_P_m
	%u80 = icmp eq i32 %u79, 0
	br i1 %u80, label %LU16, label %LU17
LU16:
	%u81 = load i32, i32* %_P_n
	%u82 = add i32 %u81, 1
	store i32 %u82, i32* %_retval_
	br label %LU14
LU17:
	%u83 = load i32, i32* %_P_n
	%u84 = icmp eq i32 %u83, 0
	br i1 %u84, label %LU18, label %LU19
LU18:
	%u85 = load i32, i32* %_P_m
	%u86 = sub i32 %u85, 1
	%u87 = call i32 @ackermann(i32 %u86, i32 1)
	store i32 %u87, i32* %_retval_
	br label %LU14
LU19:
	%u88 = load i32, i32* %_P_m
	%u89 = sub i32 %u88, 1
	%u90 = load i32, i32* %_P_m
	%u91 = load i32, i32* %_P_n
	%u92 = sub i32 %u91, 1
	%u93 = call i32 @ackermann(i32 %u90, i32 %u92)
	%u94 = call i32 @ackermann(i32 %u89, i32 %u93)
	store i32 %u94, i32* %_retval_
	br label %LU14
LU20:
	br label %LU14
LU14:
	%u95 = load i32, i32* %_retval_
	ret i32 %u95
}

define i32 @main()
{
LU22:
	%_retval_ = alloca i32
	%a = alloca i32
	%b = alloca i32
	%c = alloca i32
	%d = alloca i32
	%e = alloca i32
	call i32 (i8*, ...) @scanf(i8* getelementptr inbounds ([4 x i8], [4 x i8]* @.read, i32 0, i32 0), i32* %a)
	call i32 (i8*, ...) @scanf(i8* getelementptr inbounds ([4 x i8], [4 x i8]* @.read, i32 0, i32 0), i32* %b)
	call i32 (i8*, ...) @scanf(i8* getelementptr inbounds ([4 x i8], [4 x i8]* @.read, i32 0, i32 0), i32* %c)
	call i32 (i8*, ...) @scanf(i8* getelementptr inbounds ([4 x i8], [4 x i8]* @.read, i32 0, i32 0), i32* %d)
	call i32 (i8*, ...) @scanf(i8* getelementptr inbounds ([4 x i8], [4 x i8]* @.read, i32 0, i32 0), i32* %e)
	%u96 = load i32, i32* %a
	call void @tailrecursive(i32 %u96)
	%u97 = load i32, i32* %a
	call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([5 x i8], [5 x i8]* @.println, i32 0, i32 0), i32 %u97)
	%u98 = load i32, i32* %b
	call void @domath(i32 %u98)
	%u99 = load i32, i32* %b
	call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([5 x i8], [5 x i8]* @.println, i32 0, i32 0), i32 %u99)
	%u100 = load i32, i32* %c
	call void @objinstantiation(i32 %u100)
	%u101 = load i32, i32* %c
	call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([5 x i8], [5 x i8]* @.println, i32 0, i32 0), i32 %u101)
	%u102 = load i32, i32* %d
	%u103 = load i32, i32* %e
	%u104 = call i32 @ackermann(i32 %u102, i32 %u103)
	call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([5 x i8], [5 x i8]* @.println, i32 0, i32 0), i32 %u104)
	store i32 0, i32* %_retval_
	br label %LU21
LU21:
	%u105 = load i32, i32* %_retval_
	ret i32 %u105
}

declare i8* @malloc(i32)
declare void @free(i8*)
declare i32 @printf(i8*, ...)
declare i32 @scanf(i8*, ...)
@.println = private unnamed_addr constant [5 x i8] c"%ld\0A\00\00", align 1
@.print = private unnamed_addr constant [5 x i8] c"%ld \00\00", align 1
@.read = private unnamed_addr constant [4 x i8] c"%ld\00\00", align 1
@.read_scratch = common global i32 0, align 4

