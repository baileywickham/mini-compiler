target triple="i686"
%struct.Power = type {i32, i32}



define i32 @calcPower(i32 %base, i32 %exp)
{
LU1:
	%_P_base = alloca i32
	%_P_exp = alloca i32
	%_retval_ = alloca i32
	%result = alloca i32
	store i32 %base, i32* %_P_base
	store i32 %exp, i32* %_P_exp
	store i32 1, i32* %result
	%u2268 = load i32, i32* %_P_exp
	%u2269 = icmp sgt i32 %u2268, 0
	br i1 %u2269, label %LU2, label %LU3
LU2:
	%u2270 = load i32, i32* %result
	%u2271 = load i32, i32* %_P_base
	%u2272 = mul i32 %u2270, %u2271
	store i32 %u2272, i32* %result
	%u2273 = load i32, i32* %_P_exp
	%u2274 = sub i32 %u2273, 1
	store i32 %u2274, i32* %_P_exp
	%u2275 = load i32, i32* %_P_exp
	%u2276 = icmp sgt i32 %u2275, 0
	br i1 %u2276, label %LU2, label %LU3
LU3:
	%u2277 = load i32, i32* %result
	store i32 %u2277, i32* %_retval_
	br label %LU0
LU0:
	%u2278 = load i32, i32* %_retval_
	ret i32 %u2278
}

define i32 @main()
{
LU5:
	%_retval_ = alloca i32
	%power = alloca %struct.Power*
	%input = alloca i32
	%result = alloca i32
	%exp = alloca i32
	%i = alloca i32
	store i32 0, i32* %result
	%u2279 = call i8* @malloc(i32 8)
	%u2280 = bitcast i8* %u2279 to %struct.Power*
	store %struct.Power* %u2280, %struct.Power** %power
	call i32 (i8*, ...) @scanf(i8* getelementptr inbounds ([5 x i8], [5 x i8]* @.read, i32 0, i32 0), i32* %input)
	%u2281 = load i32, i32* %input
	%u2282 = load %struct.Power*, %struct.Power** %power
	%u2283 = getelementptr %struct.Power, %struct.Power* %u2282, i1 0, i32 0
	store i32 %u2281, i32* %u2283
	call i32 (i8*, ...) @scanf(i8* getelementptr inbounds ([5 x i8], [5 x i8]* @.read, i32 0, i32 0), i32* %input)
	%u2284 = load i32, i32* %input
	%u2285 = icmp slt i32 %u2284, 0
	br i1 %u2285, label %LU6, label %LU7
LU6:
	%u2286 = sub i32 0, 1
	store i32 %u2286, i32* %_retval_
	br label %LU4
LU7:
	%u2287 = load i32, i32* %input
	%u2288 = load %struct.Power*, %struct.Power** %power
	%u2289 = getelementptr %struct.Power, %struct.Power* %u2288, i1 0, i32 1
	store i32 %u2287, i32* %u2289
	store i32 0, i32* %i
	%u2290 = load i32, i32* %i
	%u2291 = icmp slt i32 %u2290, 1000000
	br i1 %u2291, label %LU8, label %LU9
LU8:
	%u2292 = load i32, i32* %i
	%u2293 = add i32 %u2292, 1
	store i32 %u2293, i32* %i
	%u2294 = load %struct.Power*, %struct.Power** %power
	%u2295 = getelementptr %struct.Power, %struct.Power* %u2294, i1 0, i32 0
	%u2296 = load i32, i32* %u2295
	%u2297 = load %struct.Power*, %struct.Power** %power
	%u2298 = getelementptr %struct.Power, %struct.Power* %u2297, i1 0, i32 1
	%u2299 = load i32, i32* %u2298
	%u2300 = call i32 @calcPower(i32 %u2296, i32 %u2299)
	store i32 %u2300, i32* %result
	%u2301 = load i32, i32* %i
	%u2302 = icmp slt i32 %u2301, 1000000
	br i1 %u2302, label %LU8, label %LU9
LU9:
	%u2303 = load i32, i32* %result
	call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([6 x i8], [6 x i8]* @.println, i32 0, i32 0), i32 %u2303)
	store i32 1, i32* %_retval_
	br label %LU4
LU4:
	%u2304 = load i32, i32* %_retval_
	ret i32 %u2304
}
declare i8* @malloc(i32)
declare void @free(i8*)
declare i32 @printf(i8*, ...)
declare i32 @scanf(i8*, ...)
@.println = private unnamed_addr constant [6 x i8] c"%ld\0A\00\00", align 1
@.print = private unnamed_addr constant [6 x i8] c"%ld \00\00", align 1
@.read = private unnamed_addr constant [5 x i8] c"%ld\00\00", align 1
@.read_scratch = common global i32 0, align 4
