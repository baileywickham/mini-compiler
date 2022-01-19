target triple="i686"




define i32 @sum(i32 %a, i32 %b)
{
LU1:
	%_P_a = alloca i32
	%_P_b = alloca i32
	%_retval_ = alloca i32
	store i32 %a, i32* %_P_a
	store i32 %b, i32* %_P_b
	%u1997 = load i32, i32* %_P_a
	%u1998 = load i32, i32* %_P_b
	%u1999 = add i32 %u1997, %u1998
	store i32 %u1999, i32* %_retval_
	br label %LU0
LU0:
	%u2000 = load i32, i32* %_retval_
	ret i32 %u2000
}

define i32 @fact(i32 %n)
{
LU3:
	%_P_n = alloca i32
	%_retval_ = alloca i32
	%t = alloca i32
	store i32 %n, i32* %_P_n
	%u2001 = load i32, i32* %_P_n
	%u2002 = icmp eq i32 %u2001, 1
	%u2003 = load i32, i32* %_P_n
	%u2004 = icmp eq i32 %u2003, 0
	%u2005 = or i1 %u2002, %u2004
	br i1 %u2005, label %LU4, label %LU5
LU4:
	store i32 1, i32* %_retval_
	br label %LU2
LU5:
	%u2006 = load i32, i32* %_P_n
	%u2007 = icmp sle i32 %u2006, 1
	br i1 %u2007, label %LU6, label %LU7
LU6:
	%u2008 = sub i32 0, 1
	%u2009 = load i32, i32* %_P_n
	%u2010 = mul i32 %u2008, %u2009
	%u2011 = call i32 @fact(i32 %u2010)
	store i32 %u2011, i32* %_retval_
	br label %LU2
LU7:
	%u2012 = load i32, i32* %_P_n
	%u2013 = load i32, i32* %_P_n
	%u2014 = sub i32 %u2013, 1
	%u2015 = call i32 @fact(i32 %u2014)
	%u2016 = mul i32 %u2012, %u2015
	store i32 %u2016, i32* %t
	%u2017 = load i32, i32* %t
	store i32 %u2017, i32* %_retval_
	br label %LU2
LU2:
	%u2018 = load i32, i32* %_retval_
	ret i32 %u2018
}

define i32 @main()
{
LU9:
	%_retval_ = alloca i32
	%num1 = alloca i32
	%num2 = alloca i32
	%flag = alloca i32
	store i32 0, i32* %flag
	%u2019 = load i32, i32* %flag
	%u2020 = sub i32 0, 1
	%u2021 = icmp ne i32 %u2019, %u2020
	br i1 %u2021, label %LU10, label %LU11
LU10:
	call i32 (i8*, ...) @scanf(i8* getelementptr inbounds ([5 x i8], [5 x i8]* @.read, i32 0, i32 0), i32* %num1)
	call i32 (i8*, ...) @scanf(i8* getelementptr inbounds ([5 x i8], [5 x i8]* @.read, i32 0, i32 0), i32* %num2)
	%u2022 = load i32, i32* %num1
	%u2023 = call i32 @fact(i32 %u2022)
	store i32 %u2023, i32* %num1
	%u2024 = load i32, i32* %num2
	%u2025 = call i32 @fact(i32 %u2024)
	store i32 %u2025, i32* %num2
	%u2026 = load i32, i32* %num1
	%u2027 = load i32, i32* %num2
	%u2028 = call i32 @sum(i32 %u2026, i32 %u2027)
	call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([6 x i8], [6 x i8]* @.println, i32 0, i32 0), i32 %u2028)
	call i32 (i8*, ...) @scanf(i8* getelementptr inbounds ([5 x i8], [5 x i8]* @.read, i32 0, i32 0), i32* %flag)
	%u2029 = load i32, i32* %flag
	%u2030 = sub i32 0, 1
	%u2031 = icmp ne i32 %u2029, %u2030
	br i1 %u2031, label %LU10, label %LU11
LU11:
	store i32 0, i32* %_retval_
	br label %LU8
LU8:
	%u2032 = load i32, i32* %_retval_
	ret i32 %u2032
}
declare i8* @malloc(i32)
declare void @free(i8*)
declare i32 @printf(i8*, ...)
declare i32 @scanf(i8*, ...)
@.println = private unnamed_addr constant [6 x i8] c"%ld\0A\00\00", align 1
@.print = private unnamed_addr constant [6 x i8] c"%ld \00\00", align 1
@.read = private unnamed_addr constant [5 x i8] c"%ld\00\00", align 1
@.read_scratch = common global i32 0, align 4
