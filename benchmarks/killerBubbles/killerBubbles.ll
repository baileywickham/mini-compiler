target triple="i686"
%struct.Node = type {i32, %struct.Node*, %struct.Node*}

@swapped = common global i32 0, align 4

define i32 @compare(%struct.Node* %a, %struct.Node* %b)
{
LU1:
	%_P_a = alloca %struct.Node*
	%_P_b = alloca %struct.Node*
	%_retval_ = alloca i32
	store %struct.Node* %a, %struct.Node** %_P_a
	store %struct.Node* %b, %struct.Node** %_P_b
	%u2153 = load %struct.Node*, %struct.Node** %_P_a
	%u2154 = getelementptr %struct.Node, %struct.Node* %u2153, i1 0, i32 0
	%u2155 = load i32, i32* %u2154
	%u2156 = load %struct.Node*, %struct.Node** %_P_b
	%u2157 = getelementptr %struct.Node, %struct.Node* %u2156, i1 0, i32 0
	%u2158 = load i32, i32* %u2157
	%u2159 = sub i32 %u2155, %u2158
	store i32 %u2159, i32* %_retval_
	br label %LU0
LU0:
	%u2160 = load i32, i32* %_retval_
	ret i32 %u2160
}

define void @deathSort(%struct.Node* %head)
{
LU3:
	%_P_head = alloca %struct.Node*
	%swapped = alloca i32
	%swap = alloca i32
	%currNode = alloca %struct.Node*
	store %struct.Node* %head, %struct.Node** %_P_head
	store i32 1, i32* %swapped
	%u2161 = load i32, i32* %swapped
	%u2162 = icmp eq i32 %u2161, 1
	br i1 %u2162, label %LU4, label %LU5
LU4:
	store i32 0, i32* %swapped
	%u2163 = load %struct.Node*, %struct.Node** %_P_head
	store %struct.Node* %u2163, %struct.Node** %currNode
	%u2164 = load %struct.Node*, %struct.Node** %currNode
	%u2165 = getelementptr %struct.Node, %struct.Node* %u2164, i1 0, i32 2
	%u2166 = load %struct.Node*, %struct.Node** %u2165
	%u2167 = load %struct.Node*, %struct.Node** %_P_head
	%u2168 = icmp ne %struct.Node* %u2166, %u2167
	br i1 %u2168, label %LU6, label %LU7
LU6:
	%u2169 = load %struct.Node*, %struct.Node** %currNode
	%u2170 = load %struct.Node*, %struct.Node** %currNode
	%u2171 = getelementptr %struct.Node, %struct.Node* %u2170, i1 0, i32 2
	%u2172 = load %struct.Node*, %struct.Node** %u2171
	%u2173 = call i32 @compare(%struct.Node* %u2169, %struct.Node* %u2172)
	%u2174 = icmp sgt i32 %u2173, 0
	br i1 %u2174, label %LU8, label %LU9
LU8:
	%u2175 = load %struct.Node*, %struct.Node** %currNode
	%u2176 = getelementptr %struct.Node, %struct.Node* %u2175, i1 0, i32 0
	%u2177 = load i32, i32* %u2176
	store i32 %u2177, i32* %swap
	%u2178 = load %struct.Node*, %struct.Node** %currNode
	%u2179 = getelementptr %struct.Node, %struct.Node* %u2178, i1 0, i32 2
	%u2180 = load %struct.Node*, %struct.Node** %u2179
	%u2181 = getelementptr %struct.Node, %struct.Node* %u2180, i1 0, i32 0
	%u2182 = load i32, i32* %u2181
	%u2183 = load %struct.Node*, %struct.Node** %currNode
	%u2184 = getelementptr %struct.Node, %struct.Node* %u2183, i1 0, i32 0
	store i32 %u2182, i32* %u2184
	%u2185 = load i32, i32* %swap
	%u2186 = load %struct.Node*, %struct.Node** %currNode
	%u2187 = getelementptr %struct.Node, %struct.Node* %u2186, i1 0, i32 2
	%u2188 = load %struct.Node*, %struct.Node** %u2187
	%u2189 = getelementptr %struct.Node, %struct.Node* %u2188, i1 0, i32 0
	store i32 %u2185, i32* %u2189
	store i32 1, i32* %swapped
	br label %LU9
LU9:
	%u2190 = load %struct.Node*, %struct.Node** %currNode
	%u2191 = getelementptr %struct.Node, %struct.Node* %u2190, i1 0, i32 2
	%u2192 = load %struct.Node*, %struct.Node** %u2191
	store %struct.Node* %u2192, %struct.Node** %currNode
	%u2193 = load %struct.Node*, %struct.Node** %currNode
	%u2194 = getelementptr %struct.Node, %struct.Node* %u2193, i1 0, i32 2
	%u2195 = load %struct.Node*, %struct.Node** %u2194
	%u2196 = load %struct.Node*, %struct.Node** %_P_head
	%u2197 = icmp ne %struct.Node* %u2195, %u2196
	br i1 %u2197, label %LU6, label %LU7
LU7:
	%u2198 = load i32, i32* %swapped
	%u2199 = icmp eq i32 %u2198, 1
	br i1 %u2199, label %LU4, label %LU5
LU5:
	br label %LU2
LU2:
	ret void
}

define void @printEVILList(%struct.Node* %head)
{
LU11:
	%_P_head = alloca %struct.Node*
	%currNode = alloca %struct.Node*
	%toFree = alloca %struct.Node*
	store %struct.Node* %head, %struct.Node** %_P_head
	%u2200 = load %struct.Node*, %struct.Node** %_P_head
	%u2201 = getelementptr %struct.Node, %struct.Node* %u2200, i1 0, i32 2
	%u2202 = load %struct.Node*, %struct.Node** %u2201
	store %struct.Node* %u2202, %struct.Node** %currNode
	%u2203 = load %struct.Node*, %struct.Node** %_P_head
	%u2204 = getelementptr %struct.Node, %struct.Node* %u2203, i1 0, i32 0
	%u2205 = load i32, i32* %u2204
	call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([6 x i8], [6 x i8]* @.println, i32 0, i32 0), i32 %u2205)
	%u2206 = load %struct.Node*, %struct.Node** %_P_head
	%u2207 = bitcast %struct.Node* %u2206 to i8*
	call void @free(i8* %u2207)
	%u2208 = load %struct.Node*, %struct.Node** %currNode
	%u2209 = load %struct.Node*, %struct.Node** %_P_head
	%u2210 = icmp ne %struct.Node* %u2208, %u2209
	br i1 %u2210, label %LU12, label %LU13
LU12:
	%u2211 = load %struct.Node*, %struct.Node** %currNode
	store %struct.Node* %u2211, %struct.Node** %toFree
	%u2212 = load %struct.Node*, %struct.Node** %currNode
	%u2213 = getelementptr %struct.Node, %struct.Node* %u2212, i1 0, i32 0
	%u2214 = load i32, i32* %u2213
	call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([6 x i8], [6 x i8]* @.println, i32 0, i32 0), i32 %u2214)
	%u2215 = load %struct.Node*, %struct.Node** %currNode
	%u2216 = getelementptr %struct.Node, %struct.Node* %u2215, i1 0, i32 2
	%u2217 = load %struct.Node*, %struct.Node** %u2216
	store %struct.Node* %u2217, %struct.Node** %currNode
	%u2218 = load %struct.Node*, %struct.Node** %toFree
	%u2219 = bitcast %struct.Node* %u2218 to i8*
	call void @free(i8* %u2219)
	%u2220 = load %struct.Node*, %struct.Node** %currNode
	%u2221 = load %struct.Node*, %struct.Node** %_P_head
	%u2222 = icmp ne %struct.Node* %u2220, %u2221
	br i1 %u2222, label %LU12, label %LU13
LU13:
	br label %LU10
LU10:
	ret void
}

define i32 @main()
{
LU15:
	%_retval_ = alloca i32
	%numNodes = alloca i32
	%counter = alloca i32
	%currNode = alloca %struct.Node*
	%head = alloca %struct.Node*
	%previous = alloca %struct.Node*
	store i32 666, i32* @swapped
	call i32 (i8*, ...) @scanf(i8* getelementptr inbounds ([5 x i8], [5 x i8]* @.read, i32 0, i32 0), i32* %numNodes)
	%u2223 = load i32, i32* %numNodes
	%u2224 = icmp sle i32 %u2223, 0
	br i1 %u2224, label %LU16, label %LU17
LU16:
	%u2225 = sub i32 0, 1
	call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([6 x i8], [6 x i8]* @.println, i32 0, i32 0), i32 %u2225)
	%u2226 = sub i32 0, 1
	store i32 %u2226, i32* %_retval_
	br label %LU14
LU17:
	%u2227 = load i32, i32* %numNodes
	%u2228 = mul i32 %u2227, 1000
	store i32 %u2228, i32* %numNodes
	%u2229 = load i32, i32* %numNodes
	store i32 %u2229, i32* %counter
	%u2230 = call i8* @malloc(i32 12)
	%u2231 = bitcast i8* %u2230 to %struct.Node*
	store %struct.Node* %u2231, %struct.Node** %head
	%u2232 = load i32, i32* %counter
	%u2233 = load %struct.Node*, %struct.Node** %head
	%u2234 = getelementptr %struct.Node, %struct.Node* %u2233, i1 0, i32 0
	store i32 %u2232, i32* %u2234
	%u2235 = load %struct.Node*, %struct.Node** %head
	%u2236 = load %struct.Node*, %struct.Node** %head
	%u2237 = getelementptr %struct.Node, %struct.Node* %u2236, i1 0, i32 1
	store %struct.Node* %u2235, %struct.Node** %u2237
	%u2238 = load %struct.Node*, %struct.Node** %head
	%u2239 = load %struct.Node*, %struct.Node** %head
	%u2240 = getelementptr %struct.Node, %struct.Node* %u2239, i1 0, i32 2
	store %struct.Node* %u2238, %struct.Node** %u2240
	%u2241 = load i32, i32* %counter
	%u2242 = sub i32 %u2241, 1
	store i32 %u2242, i32* %counter
	%u2243 = load %struct.Node*, %struct.Node** %head
	store %struct.Node* %u2243, %struct.Node** %previous
	%u2244 = load i32, i32* %counter
	%u2245 = icmp sgt i32 %u2244, 0
	br i1 %u2245, label %LU18, label %LU19
LU18:
	%u2246 = call i8* @malloc(i32 12)
	%u2247 = bitcast i8* %u2246 to %struct.Node*
	store %struct.Node* %u2247, %struct.Node** %currNode
	%u2248 = load i32, i32* %counter
	%u2249 = load %struct.Node*, %struct.Node** %currNode
	%u2250 = getelementptr %struct.Node, %struct.Node* %u2249, i1 0, i32 0
	store i32 %u2248, i32* %u2250
	%u2251 = load %struct.Node*, %struct.Node** %previous
	%u2252 = load %struct.Node*, %struct.Node** %currNode
	%u2253 = getelementptr %struct.Node, %struct.Node* %u2252, i1 0, i32 1
	store %struct.Node* %u2251, %struct.Node** %u2253
	%u2254 = load %struct.Node*, %struct.Node** %head
	%u2255 = load %struct.Node*, %struct.Node** %currNode
	%u2256 = getelementptr %struct.Node, %struct.Node* %u2255, i1 0, i32 2
	store %struct.Node* %u2254, %struct.Node** %u2256
	%u2257 = load %struct.Node*, %struct.Node** %currNode
	%u2258 = load %struct.Node*, %struct.Node** %previous
	%u2259 = getelementptr %struct.Node, %struct.Node* %u2258, i1 0, i32 2
	store %struct.Node* %u2257, %struct.Node** %u2259
	%u2260 = load %struct.Node*, %struct.Node** %currNode
	store %struct.Node* %u2260, %struct.Node** %previous
	%u2261 = load i32, i32* %counter
	%u2262 = sub i32 %u2261, 1
	store i32 %u2262, i32* %counter
	%u2263 = load i32, i32* %counter
	%u2264 = icmp sgt i32 %u2263, 0
	br i1 %u2264, label %LU18, label %LU19
LU19:
	%u2265 = load %struct.Node*, %struct.Node** %head
	call void @deathSort(%struct.Node* %u2265)
	%u2266 = load %struct.Node*, %struct.Node** %head
	call void @printEVILList(%struct.Node* %u2266)
	store i32 0, i32* %_retval_
	br label %LU14
LU14:
	%u2267 = load i32, i32* %_retval_
	ret i32 %u2267
}
declare i8* @malloc(i32)
declare void @free(i8*)
declare i32 @printf(i8*, ...)
declare i32 @scanf(i8*, ...)
@.println = private unnamed_addr constant [6 x i8] c"%ld\0A\00\00", align 1
@.print = private unnamed_addr constant [6 x i8] c"%ld \00\00", align 1
@.read = private unnamed_addr constant [5 x i8] c"%ld\00\00", align 1
@.read_scratch = common global i32 0, align 4
