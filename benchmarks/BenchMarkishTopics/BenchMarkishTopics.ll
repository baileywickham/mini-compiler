target triple="i686"
%struct.intList = type {i32, %struct.intList*}

@intList = common global i32 0, align 4

define i32 @length(%struct.intList* %list)
{
LU1:
	%_P_list = alloca %struct.intList*
	%_retval_ = alloca i32
	store %struct.intList* %list, %struct.intList** %_P_list
	%u0 = load %struct.intList*, %struct.intList** %_P_list
	%u1 = icmp eq %struct.intList* %u0, null
	br i1 %u1, label %LU2, label %LU3
LU2:
	store i32 0, i32* %_retval_
	br label %LU0
LU3:
	%u2 = load %struct.intList*, %struct.intList** %_P_list
	%u3 = getelementptr %struct.intList, %struct.intList* %u2, i1 0, i32 1
	%u4 = load %struct.intList*, %struct.intList** %u3
	%u5 = call i32 @length(%struct.intList* %u4)
	%u6 = add i32 1, %u5
	store i32 %u6, i32* %_retval_
	br label %LU0
LU0:
	%u7 = load i32, i32* %_retval_
	ret i32 %u7
}

define %struct.intList* @addToFront(%struct.intList* %list, i32 %element)
{
LU5:
	%_P_list = alloca %struct.intList*
	%_P_element = alloca i32
	%_retval_ = alloca %struct.intList*
	%front = alloca %struct.intList*
	store %struct.intList* %list, %struct.intList** %_P_list
	store i32 %element, i32* %_P_element
	%u8 = load %struct.intList*, %struct.intList** %_P_list
	%u9 = icmp eq %struct.intList* %u8, null
	br i1 %u9, label %LU6, label %LU7
LU6:
	%u10 = call i8* @malloc(i32 8)
	%u11 = bitcast i8* %u10 to %struct.intList*
	store %struct.intList* %u11, %struct.intList** %_P_list
	%u12 = load i32, i32* %_P_element
	%u13 = load %struct.intList*, %struct.intList** %_P_list
	%u14 = getelementptr %struct.intList, %struct.intList* %u13, i1 0, i32 0
	store i32 %u12, i32* %u14
	%u15 = load %struct.intList*, %struct.intList** %_P_list
	%u16 = getelementptr %struct.intList, %struct.intList* %u15, i1 0, i32 1
	store %struct.intList* null, %struct.intList** %u16
	%u17 = load %struct.intList*, %struct.intList** %_P_list
	store %struct.intList* %u17, %struct.intList** %_retval_
	br label %LU4
LU7:
	%u18 = call i8* @malloc(i32 8)
	%u19 = bitcast i8* %u18 to %struct.intList*
	store %struct.intList* %u19, %struct.intList** %front
	%u20 = load i32, i32* %_P_element
	%u21 = load %struct.intList*, %struct.intList** %front
	%u22 = getelementptr %struct.intList, %struct.intList* %u21, i1 0, i32 0
	store i32 %u20, i32* %u22
	%u23 = load %struct.intList*, %struct.intList** %_P_list
	%u24 = load %struct.intList*, %struct.intList** %front
	%u25 = getelementptr %struct.intList, %struct.intList* %u24, i1 0, i32 1
	store %struct.intList* %u23, %struct.intList** %u25
	%u26 = load %struct.intList*, %struct.intList** %front
	store %struct.intList* %u26, %struct.intList** %_retval_
	br label %LU4
LU4:
	%u27 = load %struct.intList*, %struct.intList** %_retval_
	ret %struct.intList* %u27
}

define %struct.intList* @deleteFirst(%struct.intList* %list)
{
LU9:
	%_P_list = alloca %struct.intList*
	%_retval_ = alloca %struct.intList*
	%first = alloca %struct.intList*
	store %struct.intList* %list, %struct.intList** %_P_list
	%u28 = load %struct.intList*, %struct.intList** %_P_list
	%u29 = icmp eq %struct.intList* %u28, null
	br i1 %u29, label %LU10, label %LU11
LU10:
	store %struct.intList* null, %struct.intList** %_retval_
	br label %LU8
LU11:
	%u30 = load %struct.intList*, %struct.intList** %_P_list
	store %struct.intList* %u30, %struct.intList** %first
	%u31 = load %struct.intList*, %struct.intList** %_P_list
	%u32 = getelementptr %struct.intList, %struct.intList* %u31, i1 0, i32 1
	%u33 = load %struct.intList*, %struct.intList** %u32
	store %struct.intList* %u33, %struct.intList** %_P_list
	%u34 = load %struct.intList*, %struct.intList** %first
	%u35 = bitcast %struct.intList* %u34 to i8*
	call void @free(i8* %u35)
	%u36 = load %struct.intList*, %struct.intList** %_P_list
	store %struct.intList* %u36, %struct.intList** %_retval_
	br label %LU8
LU8:
	%u37 = load %struct.intList*, %struct.intList** %_retval_
	ret %struct.intList* %u37
}

define i32 @main()
{
LU13:
	%_retval_ = alloca i32
	%list = alloca %struct.intList*
	%sum = alloca i32
	call i32 (i8*, ...) @scanf(i8* getelementptr inbounds ([5 x i8], [5 x i8]* @.read, i32 0, i32 0), i32* @intList)
	store i32 0, i32* %sum
	store %struct.intList* null, %struct.intList** %list
	%u38 = load i32, i32* @intList
	%u39 = icmp sgt i32 %u38, 0
	br i1 %u39, label %LU14, label %LU15
LU14:
	%u40 = load %struct.intList*, %struct.intList** %list
	%u41 = load i32, i32* @intList
	%u42 = call %struct.intList* @addToFront(%struct.intList* %u40, i32 %u41)
	store %struct.intList* %u42, %struct.intList** %list
	%u43 = load %struct.intList*, %struct.intList** %list
	%u44 = getelementptr %struct.intList, %struct.intList* %u43, i1 0, i32 0
	%u45 = load i32, i32* %u44
	call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([6 x i8], [6 x i8]* @.print, i32 0, i32 0), i32 %u45)
	%u46 = load i32, i32* @intList
	%u47 = sub i32 %u46, 1
	store i32 %u47, i32* @intList
	%u48 = load i32, i32* @intList
	%u49 = icmp sgt i32 %u48, 0
	br i1 %u49, label %LU14, label %LU15
LU15:
	%u50 = load %struct.intList*, %struct.intList** %list
	%u51 = call i32 @length(%struct.intList* %u50)
	call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([6 x i8], [6 x i8]* @.print, i32 0, i32 0), i32 %u51)
	%u52 = load %struct.intList*, %struct.intList** %list
	%u53 = call i32 @length(%struct.intList* %u52)
	%u54 = icmp sgt i32 %u53, 0
	br i1 %u54, label %LU16, label %LU17
LU16:
	%u55 = load i32, i32* %sum
	%u56 = load %struct.intList*, %struct.intList** %list
	%u57 = getelementptr %struct.intList, %struct.intList* %u56, i1 0, i32 0
	%u58 = load i32, i32* %u57
	%u59 = add i32 %u55, %u58
	store i32 %u59, i32* %sum
	%u60 = load %struct.intList*, %struct.intList** %list
	%u61 = call i32 @length(%struct.intList* %u60)
	call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([6 x i8], [6 x i8]* @.print, i32 0, i32 0), i32 %u61)
	%u62 = load %struct.intList*, %struct.intList** %list
	%u63 = call %struct.intList* @deleteFirst(%struct.intList* %u62)
	store %struct.intList* %u63, %struct.intList** %list
	%u64 = load %struct.intList*, %struct.intList** %list
	%u65 = call i32 @length(%struct.intList* %u64)
	%u66 = icmp sgt i32 %u65, 0
	br i1 %u66, label %LU16, label %LU17
LU17:
	%u67 = load i32, i32* %sum
	call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([6 x i8], [6 x i8]* @.println, i32 0, i32 0), i32 %u67)
	store i32 0, i32* %_retval_
	br label %LU12
LU12:
	%u68 = load i32, i32* %_retval_
	ret i32 %u68
}
declare i8* @malloc(i32)
declare void @free(i8*)
declare i32 @printf(i8*, ...)
declare i32 @scanf(i8*, ...)
@.println = private unnamed_addr constant [6 x i8] c"%ld\0A\00\00", align 1
@.print = private unnamed_addr constant [6 x i8] c"%ld \00\00", align 1
@.read = private unnamed_addr constant [5 x i8] c"%ld\00\00", align 1
@.read_scratch = common global i32 0, align 4
