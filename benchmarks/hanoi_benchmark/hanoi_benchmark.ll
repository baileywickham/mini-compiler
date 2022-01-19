target triple="i686"
%struct.plate = type {i32, %struct.plate*}

@peg1 = common global %struct.plate* null, align 4
@peg2 = common global %struct.plate* null, align 4
@peg3 = common global %struct.plate* null, align 4
@numMoves = common global i32 0, align 4

define void @move(i32 %from, i32 %to)
{
LU1:
	%_P_from = alloca i32
	%_P_to = alloca i32
	%plateToMove = alloca %struct.plate*
	store i32 %from, i32* %_P_from
	store i32 %to, i32* %_P_to
	%u2055 = load i32, i32* %_P_from
	%u2056 = icmp eq i32 %u2055, 1
	br i1 %u2056, label %LU2, label %LU3
LU2:
	%u2057 = load %struct.plate*, %struct.plate** @peg1
	store %struct.plate* %u2057, %struct.plate** %plateToMove
	%u2058 = load %struct.plate*, %struct.plate** @peg1
	%u2059 = getelementptr %struct.plate, %struct.plate* %u2058, i1 0, i32 1
	%u2060 = load %struct.plate*, %struct.plate** %u2059
	store %struct.plate* %u2060, %struct.plate** @peg1
	br label %LU4
LU3:
	%u2061 = load i32, i32* %_P_from
	%u2062 = icmp eq i32 %u2061, 2
	br i1 %u2062, label %LU11, label %LU12
LU11:
	%u2063 = load %struct.plate*, %struct.plate** @peg2
	store %struct.plate* %u2063, %struct.plate** %plateToMove
	%u2064 = load %struct.plate*, %struct.plate** @peg2
	%u2065 = getelementptr %struct.plate, %struct.plate* %u2064, i1 0, i32 1
	%u2066 = load %struct.plate*, %struct.plate** %u2065
	store %struct.plate* %u2066, %struct.plate** @peg2
	br label %LU13
LU12:
	%u2067 = load %struct.plate*, %struct.plate** @peg3
	store %struct.plate* %u2067, %struct.plate** %plateToMove
	%u2068 = load %struct.plate*, %struct.plate** @peg3
	%u2069 = getelementptr %struct.plate, %struct.plate* %u2068, i1 0, i32 1
	%u2070 = load %struct.plate*, %struct.plate** %u2069
	store %struct.plate* %u2070, %struct.plate** @peg3
	br label %LU13
LU13:
	br label %LU4
LU4:
	%u2071 = load i32, i32* %_P_to
	%u2072 = icmp eq i32 %u2071, 1
	br i1 %u2072, label %LU5, label %LU6
LU5:
	%u2073 = load %struct.plate*, %struct.plate** @peg1
	%u2074 = load %struct.plate*, %struct.plate** %plateToMove
	%u2075 = getelementptr %struct.plate, %struct.plate* %u2074, i1 0, i32 1
	store %struct.plate* %u2073, %struct.plate** %u2075
	%u2076 = load %struct.plate*, %struct.plate** %plateToMove
	store %struct.plate* %u2076, %struct.plate** @peg1
	br label %LU7
LU6:
	%u2077 = load i32, i32* %_P_to
	%u2078 = icmp eq i32 %u2077, 2
	br i1 %u2078, label %LU8, label %LU9
LU8:
	%u2079 = load %struct.plate*, %struct.plate** @peg2
	%u2080 = load %struct.plate*, %struct.plate** %plateToMove
	%u2081 = getelementptr %struct.plate, %struct.plate* %u2080, i1 0, i32 1
	store %struct.plate* %u2079, %struct.plate** %u2081
	%u2082 = load %struct.plate*, %struct.plate** %plateToMove
	store %struct.plate* %u2082, %struct.plate** @peg2
	br label %LU10
LU9:
	%u2083 = load %struct.plate*, %struct.plate** @peg3
	%u2084 = load %struct.plate*, %struct.plate** %plateToMove
	%u2085 = getelementptr %struct.plate, %struct.plate* %u2084, i1 0, i32 1
	store %struct.plate* %u2083, %struct.plate** %u2085
	%u2086 = load %struct.plate*, %struct.plate** %plateToMove
	store %struct.plate* %u2086, %struct.plate** @peg3
	br label %LU10
LU10:
	br label %LU7
LU7:
	%u2087 = load i32, i32* @numMoves
	%u2088 = add i32 %u2087, 1
	store i32 %u2088, i32* @numMoves
	br label %LU0
LU0:
	ret void
}

define void @hanoi(i32 %n, i32 %from, i32 %to, i32 %other)
{
LU15:
	%_P_n = alloca i32
	%_P_from = alloca i32
	%_P_to = alloca i32
	%_P_other = alloca i32
	store i32 %n, i32* %_P_n
	store i32 %from, i32* %_P_from
	store i32 %to, i32* %_P_to
	store i32 %other, i32* %_P_other
	%u2089 = load i32, i32* %_P_n
	%u2090 = icmp eq i32 %u2089, 1
	br i1 %u2090, label %LU16, label %LU17
LU16:
	%u2091 = load i32, i32* %_P_from
	%u2092 = load i32, i32* %_P_to
	call void @move(i32 %u2091, i32 %u2092)
	br label %LU18
LU17:
	%u2093 = load i32, i32* %_P_n
	%u2094 = sub i32 %u2093, 1
	%u2095 = load i32, i32* %_P_from
	%u2096 = load i32, i32* %_P_other
	%u2097 = load i32, i32* %_P_to
	call void @hanoi(i32 %u2094, i32 %u2095, i32 %u2096, i32 %u2097)
	%u2098 = load i32, i32* %_P_from
	%u2099 = load i32, i32* %_P_to
	call void @move(i32 %u2098, i32 %u2099)
	%u2100 = load i32, i32* %_P_n
	%u2101 = sub i32 %u2100, 1
	%u2102 = load i32, i32* %_P_other
	%u2103 = load i32, i32* %_P_to
	%u2104 = load i32, i32* %_P_from
	call void @hanoi(i32 %u2101, i32 %u2102, i32 %u2103, i32 %u2104)
	br label %LU18
LU18:
	br label %LU14
LU14:
	ret void
}

define void @printPeg(%struct.plate* %peg)
{
LU20:
	%_P_peg = alloca %struct.plate*
	%aPlate = alloca %struct.plate*
	store %struct.plate* %peg, %struct.plate** %_P_peg
	%u2105 = load %struct.plate*, %struct.plate** %_P_peg
	store %struct.plate* %u2105, %struct.plate** %aPlate
	%u2106 = load %struct.plate*, %struct.plate** %aPlate
	%u2107 = icmp ne %struct.plate* %u2106, null
	br i1 %u2107, label %LU21, label %LU22
LU21:
	%u2108 = load %struct.plate*, %struct.plate** %aPlate
	%u2109 = getelementptr %struct.plate, %struct.plate* %u2108, i1 0, i32 0
	%u2110 = load i32, i32* %u2109
	call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([6 x i8], [6 x i8]* @.println, i32 0, i32 0), i32 %u2110)
	%u2111 = load %struct.plate*, %struct.plate** %aPlate
	%u2112 = getelementptr %struct.plate, %struct.plate* %u2111, i1 0, i32 1
	%u2113 = load %struct.plate*, %struct.plate** %u2112
	store %struct.plate* %u2113, %struct.plate** %aPlate
	%u2114 = load %struct.plate*, %struct.plate** %aPlate
	%u2115 = icmp ne %struct.plate* %u2114, null
	br i1 %u2115, label %LU21, label %LU22
LU22:
	br label %LU19
LU19:
	ret void
}

define i32 @main()
{
LU24:
	%_retval_ = alloca i32
	%count = alloca i32
	%numPlates = alloca i32
	%aPlate = alloca %struct.plate*
	store %struct.plate* null, %struct.plate** @peg1
	store %struct.plate* null, %struct.plate** @peg2
	store %struct.plate* null, %struct.plate** @peg3
	store i32 0, i32* @numMoves
	call i32 (i8*, ...) @scanf(i8* getelementptr inbounds ([5 x i8], [5 x i8]* @.read, i32 0, i32 0), i32* %numPlates)
	%u2116 = load i32, i32* %numPlates
	%u2117 = icmp sge i32 %u2116, 1
	br i1 %u2117, label %LU25, label %LU26
LU25:
	%u2118 = load i32, i32* %numPlates
	store i32 %u2118, i32* %count
	%u2119 = load i32, i32* %count
	%u2120 = icmp ne i32 %u2119, 0
	br i1 %u2120, label %LU27, label %LU28
LU27:
	%u2121 = call i8* @malloc(i32 8)
	%u2122 = bitcast i8* %u2121 to %struct.plate*
	store %struct.plate* %u2122, %struct.plate** %aPlate
	%u2123 = load i32, i32* %count
	%u2124 = load %struct.plate*, %struct.plate** %aPlate
	%u2125 = getelementptr %struct.plate, %struct.plate* %u2124, i1 0, i32 0
	store i32 %u2123, i32* %u2125
	%u2126 = load %struct.plate*, %struct.plate** @peg1
	%u2127 = load %struct.plate*, %struct.plate** %aPlate
	%u2128 = getelementptr %struct.plate, %struct.plate* %u2127, i1 0, i32 1
	store %struct.plate* %u2126, %struct.plate** %u2128
	%u2129 = load %struct.plate*, %struct.plate** %aPlate
	store %struct.plate* %u2129, %struct.plate** @peg1
	%u2130 = load i32, i32* %count
	%u2131 = sub i32 %u2130, 1
	store i32 %u2131, i32* %count
	%u2132 = load i32, i32* %count
	%u2133 = icmp ne i32 %u2132, 0
	br i1 %u2133, label %LU27, label %LU28
LU28:
	call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([6 x i8], [6 x i8]* @.println, i32 0, i32 0), i32 1)
	%u2134 = load %struct.plate*, %struct.plate** @peg1
	call void @printPeg(%struct.plate* %u2134)
	call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([6 x i8], [6 x i8]* @.println, i32 0, i32 0), i32 2)
	%u2135 = load %struct.plate*, %struct.plate** @peg2
	call void @printPeg(%struct.plate* %u2135)
	call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([6 x i8], [6 x i8]* @.println, i32 0, i32 0), i32 3)
	%u2136 = load %struct.plate*, %struct.plate** @peg3
	call void @printPeg(%struct.plate* %u2136)
	%u2137 = load i32, i32* %numPlates
	call void @hanoi(i32 %u2137, i32 1, i32 3, i32 2)
	call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([6 x i8], [6 x i8]* @.println, i32 0, i32 0), i32 1)
	%u2138 = load %struct.plate*, %struct.plate** @peg1
	call void @printPeg(%struct.plate* %u2138)
	call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([6 x i8], [6 x i8]* @.println, i32 0, i32 0), i32 2)
	%u2139 = load %struct.plate*, %struct.plate** @peg2
	call void @printPeg(%struct.plate* %u2139)
	call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([6 x i8], [6 x i8]* @.println, i32 0, i32 0), i32 3)
	%u2140 = load %struct.plate*, %struct.plate** @peg3
	call void @printPeg(%struct.plate* %u2140)
	%u2141 = load i32, i32* @numMoves
	call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([6 x i8], [6 x i8]* @.println, i32 0, i32 0), i32 %u2141)
	%u2142 = load %struct.plate*, %struct.plate** @peg3
	%u2143 = icmp ne %struct.plate* %u2142, null
	br i1 %u2143, label %LU29, label %LU30
LU29:
	%u2144 = load %struct.plate*, %struct.plate** @peg3
	store %struct.plate* %u2144, %struct.plate** %aPlate
	%u2145 = load %struct.plate*, %struct.plate** @peg3
	%u2146 = getelementptr %struct.plate, %struct.plate* %u2145, i1 0, i32 1
	%u2147 = load %struct.plate*, %struct.plate** %u2146
	store %struct.plate* %u2147, %struct.plate** @peg3
	%u2148 = load %struct.plate*, %struct.plate** %aPlate
	%u2149 = bitcast %struct.plate* %u2148 to i8*
	call void @free(i8* %u2149)
	%u2150 = load %struct.plate*, %struct.plate** @peg3
	%u2151 = icmp ne %struct.plate* %u2150, null
	br i1 %u2151, label %LU29, label %LU30
LU30:
	br label %LU26
LU26:
	store i32 0, i32* %_retval_
	br label %LU23
LU23:
	%u2152 = load i32, i32* %_retval_
	ret i32 %u2152
}
declare i8* @malloc(i32)
declare void @free(i8*)
declare i32 @printf(i8*, ...)
declare i32 @scanf(i8*, ...)
@.println = private unnamed_addr constant [6 x i8] c"%ld\0A\00\00", align 1
@.print = private unnamed_addr constant [6 x i8] c"%ld \00\00", align 1
@.read = private unnamed_addr constant [5 x i8] c"%ld\00\00", align 1
@.read_scratch = common global i32 0, align 4
