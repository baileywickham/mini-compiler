target triple="i686"
%struct.simple = type {i32}
%struct.foo = type {i32, i32, %struct.simple*}

@globalfoo = common global %struct.foo* null, align 4

define void @tailrecursive(i32 %num)
{
LU1:
	%_P_num = alloca i32
	store i32 %num, i32* %_P_num
	%u2305 = load i32, i32* %_P_num
	%u2306 = icmp sle i32 %u2305, 0
	br i1 %u2306, label %LU2, label %LU3
LU2:
	br label %LU0
LU3:
	%u2307 = load i32, i32* %_P_num
	%u2308 = sub i32 %u2307, 1
	call void @tailrecursive(i32 %u2308)
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
	%u2309 = load i32, i32* %_P_x
	%u2310 = load i32, i32* %_P_y
	%u2311 = add i32 %u2309, %u2310
	store i32 %u2311, i32* %_retval_
	br label %LU4
LU4:
	%u2312 = load i32, i32* %_retval_
	ret i32 %u2312
}

define void @domath(i32 %num)
{
LU7:
	%_P_num = alloca i32
	%math1 = alloca %struct.foo*
	%math2 = alloca %struct.foo*
	%tmp = alloca i32
	store i32 %num, i32* %_P_num
	%u2313 = call i8* @malloc(i32 12)
	%u2314 = bitcast i8* %u2313 to %struct.foo*
	store %struct.foo* %u2314, %struct.foo** %math1
	%u2315 = call i8* @malloc(i32 4)
	%u2316 = bitcast i8* %u2315 to %struct.simple*
	%u2317 = load %struct.foo*, %struct.foo** %math1
	%u2318 = getelementptr %struct.foo, %struct.foo* %u2317, i1 0, i32 2
	store %struct.simple* %u2316, %struct.simple** %u2318
	%u2319 = call i8* @malloc(i32 12)
	%u2320 = bitcast i8* %u2319 to %struct.foo*
	store %struct.foo* %u2320, %struct.foo** %math2
	%u2321 = call i8* @malloc(i32 4)
	%u2322 = bitcast i8* %u2321 to %struct.simple*
	%u2323 = load %struct.foo*, %struct.foo** %math2
	%u2324 = getelementptr %struct.foo, %struct.foo* %u2323, i1 0, i32 2
	store %struct.simple* %u2322, %struct.simple** %u2324
	%u2325 = load i32, i32* %_P_num
	%u2326 = load %struct.foo*, %struct.foo** %math1
	%u2327 = getelementptr %struct.foo, %struct.foo* %u2326, i1 0, i32 0
	store i32 %u2325, i32* %u2327
	%u2328 = load %struct.foo*, %struct.foo** %math2
	%u2329 = getelementptr %struct.foo, %struct.foo* %u2328, i1 0, i32 0
	store i32 3, i32* %u2329
	%u2330 = load %struct.foo*, %struct.foo** %math1
	%u2331 = getelementptr %struct.foo, %struct.foo* %u2330, i1 0, i32 0
	%u2332 = load i32, i32* %u2331
	%u2333 = load %struct.foo*, %struct.foo** %math1
	%u2334 = getelementptr %struct.foo, %struct.foo* %u2333, i1 0, i32 2
	%u2335 = load %struct.simple*, %struct.simple** %u2334
	%u2336 = getelementptr %struct.simple, %struct.simple* %u2335, i1 0, i32 0
	store i32 %u2332, i32* %u2336
	%u2337 = load %struct.foo*, %struct.foo** %math2
	%u2338 = getelementptr %struct.foo, %struct.foo* %u2337, i1 0, i32 0
	%u2339 = load i32, i32* %u2338
	%u2340 = load %struct.foo*, %struct.foo** %math2
	%u2341 = getelementptr %struct.foo, %struct.foo* %u2340, i1 0, i32 2
	%u2342 = load %struct.simple*, %struct.simple** %u2341
	%u2343 = getelementptr %struct.simple, %struct.simple* %u2342, i1 0, i32 0
	store i32 %u2339, i32* %u2343
	%u2344 = load i32, i32* %_P_num
	%u2345 = icmp sgt i32 %u2344, 0
	br i1 %u2345, label %LU8, label %LU9
LU8:
	%u2346 = load %struct.foo*, %struct.foo** %math1
	%u2347 = getelementptr %struct.foo, %struct.foo* %u2346, i1 0, i32 0
	%u2348 = load i32, i32* %u2347
	%u2349 = load %struct.foo*, %struct.foo** %math2
	%u2350 = getelementptr %struct.foo, %struct.foo* %u2349, i1 0, i32 0
	%u2351 = load i32, i32* %u2350
	%u2352 = mul i32 %u2348, %u2351
	store i32 %u2352, i32* %tmp
	%u2353 = load i32, i32* %tmp
	%u2354 = load %struct.foo*, %struct.foo** %math1
	%u2355 = getelementptr %struct.foo, %struct.foo* %u2354, i1 0, i32 2
	%u2356 = load %struct.simple*, %struct.simple** %u2355
	%u2357 = getelementptr %struct.simple, %struct.simple* %u2356, i1 0, i32 0
	%u2358 = load i32, i32* %u2357
	%u2359 = mul i32 %u2353, %u2358
	%u2360 = load %struct.foo*, %struct.foo** %math2
	%u2361 = getelementptr %struct.foo, %struct.foo* %u2360, i1 0, i32 0
	%u2362 = load i32, i32* %u2361
	%u2363 = sdiv i32 %u2359, %u2362
	store i32 %u2363, i32* %tmp
	%u2364 = load %struct.foo*, %struct.foo** %math2
	%u2365 = getelementptr %struct.foo, %struct.foo* %u2364, i1 0, i32 2
	%u2366 = load %struct.simple*, %struct.simple** %u2365
	%u2367 = getelementptr %struct.simple, %struct.simple* %u2366, i1 0, i32 0
	%u2368 = load i32, i32* %u2367
	%u2369 = load %struct.foo*, %struct.foo** %math1
	%u2370 = getelementptr %struct.foo, %struct.foo* %u2369, i1 0, i32 0
	%u2371 = load i32, i32* %u2370
	%u2372 = call i32 @add(i32 %u2368, i32 %u2371)
	store i32 %u2372, i32* %tmp
	%u2373 = load %struct.foo*, %struct.foo** %math2
	%u2374 = getelementptr %struct.foo, %struct.foo* %u2373, i1 0, i32 0
	%u2375 = load i32, i32* %u2374
	%u2376 = load %struct.foo*, %struct.foo** %math1
	%u2377 = getelementptr %struct.foo, %struct.foo* %u2376, i1 0, i32 0
	%u2378 = load i32, i32* %u2377
	%u2379 = sub i32 %u2375, %u2378
	store i32 %u2379, i32* %tmp
	%u2380 = load i32, i32* %_P_num
	%u2381 = sub i32 %u2380, 1
	store i32 %u2381, i32* %_P_num
	%u2382 = load i32, i32* %_P_num
	%u2383 = icmp sgt i32 %u2382, 0
	br i1 %u2383, label %LU8, label %LU9
LU9:
	%u2384 = load %struct.foo*, %struct.foo** %math1
	%u2385 = bitcast %struct.foo* %u2384 to i8*
	call void @free(i8* %u2385)
	%u2386 = load %struct.foo*, %struct.foo** %math2
	%u2387 = bitcast %struct.foo* %u2386 to i8*
	call void @free(i8* %u2387)
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
	%u2388 = load i32, i32* %_P_num
	%u2389 = icmp sgt i32 %u2388, 0
	br i1 %u2389, label %LU12, label %LU13
LU12:
	%u2390 = call i8* @malloc(i32 12)
	%u2391 = bitcast i8* %u2390 to %struct.foo*
	store %struct.foo* %u2391, %struct.foo** %tmp
	%u2392 = load %struct.foo*, %struct.foo** %tmp
	%u2393 = bitcast %struct.foo* %u2392 to i8*
	call void @free(i8* %u2393)
	%u2394 = load i32, i32* %_P_num
	%u2395 = sub i32 %u2394, 1
	store i32 %u2395, i32* %_P_num
	%u2396 = load i32, i32* %_P_num
	%u2397 = icmp sgt i32 %u2396, 0
	br i1 %u2397, label %LU12, label %LU13
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
	%u2398 = load i32, i32* %_P_m
	%u2399 = icmp eq i32 %u2398, 0
	br i1 %u2399, label %LU16, label %LU17
LU16:
	%u2400 = load i32, i32* %_P_n
	%u2401 = add i32 %u2400, 1
	store i32 %u2401, i32* %_retval_
	br label %LU14
LU17:
	%u2402 = load i32, i32* %_P_n
	%u2403 = icmp eq i32 %u2402, 0
	br i1 %u2403, label %LU18, label %LU19
LU18:
	%u2404 = load i32, i32* %_P_m
	%u2405 = sub i32 %u2404, 1
	%u2406 = call i32 @ackermann(i32 %u2405, i32 1)
	store i32 %u2406, i32* %_retval_
	br label %LU14
LU19:
	%u2407 = load i32, i32* %_P_m
	%u2408 = sub i32 %u2407, 1
	%u2409 = load i32, i32* %_P_m
	%u2410 = load i32, i32* %_P_n
	%u2411 = sub i32 %u2410, 1
	%u2412 = call i32 @ackermann(i32 %u2409, i32 %u2411)
	%u2413 = call i32 @ackermann(i32 %u2408, i32 %u2412)
	store i32 %u2413, i32* %_retval_
	br label %LU14
LU20:
	br label %LU14
LU14:
	%u2414 = load i32, i32* %_retval_
	ret i32 %u2414
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
	call i32 (i8*, ...) @scanf(i8* getelementptr inbounds ([5 x i8], [5 x i8]* @.read, i32 0, i32 0), i32* %a)
	call i32 (i8*, ...) @scanf(i8* getelementptr inbounds ([5 x i8], [5 x i8]* @.read, i32 0, i32 0), i32* %b)
	call i32 (i8*, ...) @scanf(i8* getelementptr inbounds ([5 x i8], [5 x i8]* @.read, i32 0, i32 0), i32* %c)
	call i32 (i8*, ...) @scanf(i8* getelementptr inbounds ([5 x i8], [5 x i8]* @.read, i32 0, i32 0), i32* %d)
	call i32 (i8*, ...) @scanf(i8* getelementptr inbounds ([5 x i8], [5 x i8]* @.read, i32 0, i32 0), i32* %e)
	%u2415 = load i32, i32* %a
	call void @tailrecursive(i32 %u2415)
	%u2416 = load i32, i32* %a
	call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([6 x i8], [6 x i8]* @.println, i32 0, i32 0), i32 %u2416)
	%u2417 = load i32, i32* %b
	call void @domath(i32 %u2417)
	%u2418 = load i32, i32* %b
	call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([6 x i8], [6 x i8]* @.println, i32 0, i32 0), i32 %u2418)
	%u2419 = load i32, i32* %c
	call void @objinstantiation(i32 %u2419)
	%u2420 = load i32, i32* %c
	call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([6 x i8], [6 x i8]* @.println, i32 0, i32 0), i32 %u2420)
	%u2421 = load i32, i32* %d
	%u2422 = load i32, i32* %e
	%u2423 = call i32 @ackermann(i32 %u2421, i32 %u2422)
	call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([6 x i8], [6 x i8]* @.println, i32 0, i32 0), i32 %u2423)
	store i32 0, i32* %_retval_
	br label %LU21
LU21:
	%u2424 = load i32, i32* %_retval_
	ret i32 %u2424
}
declare i8* @malloc(i32)
declare void @free(i8*)
declare i32 @printf(i8*, ...)
declare i32 @scanf(i8*, ...)
@.println = private unnamed_addr constant [6 x i8] c"%ld\0A\00\00", align 1
@.print = private unnamed_addr constant [6 x i8] c"%ld \00\00", align 1
@.read = private unnamed_addr constant [5 x i8] c"%ld\00\00", align 1
@.read_scratch = common global i32 0, align 4
