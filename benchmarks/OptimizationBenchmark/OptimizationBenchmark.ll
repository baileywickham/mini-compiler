target triple="i686"


@global1 = common global i32 0, align 4
@global2 = common global i32 0, align 4
@global3 = common global i32 0, align 4

define i32 @constantFolding()
{
LU1:
	%_retval_ = alloca i32
	%a = alloca i32
	%u169 = mul i32 8, 9
	%u170 = sdiv i32 %u169, 4
	%u171 = add i32 %u170, 2
	%u172 = mul i32 5, 8
	%u173 = sub i32 %u171, %u172
	%u174 = add i32 %u173, 9
	%u175 = sub i32 %u174, 12
	%u176 = add i32 %u175, 6
	%u177 = sub i32 %u176, 9
	%u178 = sub i32 %u177, 18
	%u179 = mul i32 23, 3
	%u180 = sdiv i32 %u179, 23
	%u181 = mul i32 %u180, 90
	%u182 = add i32 %u178, %u181
	store i32 %u182, i32* %a
	%u183 = load i32, i32* %a
	store i32 %u183, i32* %_retval_
	br label %LU0
LU0:
	%u184 = load i32, i32* %_retval_
	ret i32 %u184
}

define i32 @constantPropagation()
{
LU3:
	%_retval_ = alloca i32
	%a = alloca i32
	%b = alloca i32
	%c = alloca i32
	%d = alloca i32
	%e = alloca i32
	%f = alloca i32
	%g = alloca i32
	%h = alloca i32
	%i = alloca i32
	%j = alloca i32
	%k = alloca i32
	%l = alloca i32
	%m = alloca i32
	%n = alloca i32
	%o = alloca i32
	%p = alloca i32
	%q = alloca i32
	%r = alloca i32
	%s = alloca i32
	%t = alloca i32
	%u = alloca i32
	%v = alloca i32
	%w = alloca i32
	%x = alloca i32
	%y = alloca i32
	%z = alloca i32
	store i32 4, i32* %a
	store i32 7, i32* %b
	store i32 8, i32* %c
	store i32 5, i32* %d
	store i32 11, i32* %e
	store i32 21, i32* %f
	%u185 = load i32, i32* %a
	%u186 = load i32, i32* %b
	%u187 = add i32 %u185, %u186
	store i32 %u187, i32* %g
	%u188 = load i32, i32* %c
	%u189 = load i32, i32* %d
	%u190 = add i32 %u188, %u189
	store i32 %u190, i32* %h
	%u191 = load i32, i32* %e
	%u192 = load i32, i32* %f
	%u193 = add i32 %u191, %u192
	store i32 %u193, i32* %i
	%u194 = load i32, i32* %g
	%u195 = load i32, i32* %h
	%u196 = add i32 %u194, %u195
	store i32 %u196, i32* %j
	%u197 = load i32, i32* %i
	%u198 = load i32, i32* %j
	%u199 = mul i32 %u197, %u198
	store i32 %u199, i32* %k
	%u200 = load i32, i32* %e
	%u201 = load i32, i32* %h
	%u202 = load i32, i32* %i
	%u203 = mul i32 %u201, %u202
	%u204 = add i32 %u200, %u203
	%u205 = load i32, i32* %k
	%u206 = sub i32 %u204, %u205
	store i32 %u206, i32* %l
	%u207 = load i32, i32* %h
	%u208 = load i32, i32* %i
	%u209 = load i32, i32* %j
	%u210 = mul i32 %u208, %u209
	%u211 = sub i32 %u207, %u210
	%u212 = load i32, i32* %k
	%u213 = load i32, i32* %l
	%u214 = sdiv i32 %u212, %u213
	%u215 = add i32 %u211, %u214
	store i32 %u215, i32* %m
	%u216 = load i32, i32* %e
	%u217 = load i32, i32* %f
	%u218 = add i32 %u216, %u217
	%u219 = load i32, i32* %g
	%u220 = add i32 %u218, %u219
	%u221 = load i32, i32* %h
	%u222 = add i32 %u220, %u221
	%u223 = load i32, i32* %i
	%u224 = add i32 %u222, %u223
	%u225 = load i32, i32* %j
	%u226 = sub i32 %u224, %u225
	store i32 %u226, i32* %n
	%u227 = load i32, i32* %n
	%u228 = load i32, i32* %m
	%u229 = sub i32 %u227, %u228
	%u230 = load i32, i32* %h
	%u231 = add i32 %u229, %u230
	%u232 = load i32, i32* %a
	%u233 = sub i32 %u231, %u232
	%u234 = load i32, i32* %b
	%u235 = sub i32 %u233, %u234
	store i32 %u235, i32* %o
	%u236 = load i32, i32* %k
	%u237 = load i32, i32* %l
	%u238 = add i32 %u236, %u237
	%u239 = load i32, i32* %g
	%u240 = sub i32 %u238, %u239
	%u241 = load i32, i32* %h
	%u242 = sub i32 %u240, %u241
	store i32 %u242, i32* %p
	%u243 = load i32, i32* %b
	%u244 = load i32, i32* %a
	%u245 = sub i32 %u243, %u244
	%u246 = load i32, i32* %d
	%u247 = mul i32 %u245, %u246
	%u248 = load i32, i32* %i
	%u249 = sub i32 %u247, %u248
	store i32 %u249, i32* %q
	%u250 = load i32, i32* %l
	%u251 = load i32, i32* %c
	%u252 = mul i32 %u250, %u251
	%u253 = load i32, i32* %d
	%u254 = mul i32 %u252, %u253
	%u255 = load i32, i32* %o
	%u256 = add i32 %u254, %u255
	store i32 %u256, i32* %r
	%u257 = load i32, i32* %b
	%u258 = load i32, i32* %a
	%u259 = mul i32 %u257, %u258
	%u260 = load i32, i32* %c
	%u261 = mul i32 %u259, %u260
	%u262 = load i32, i32* %e
	%u263 = sdiv i32 %u261, %u262
	%u264 = load i32, i32* %o
	%u265 = sub i32 %u263, %u264
	store i32 %u265, i32* %s
	%u266 = load i32, i32* %i
	%u267 = load i32, i32* %k
	%u268 = add i32 %u266, %u267
	%u269 = load i32, i32* %c
	%u270 = add i32 %u268, %u269
	%u271 = load i32, i32* %p
	%u272 = sub i32 %u270, %u271
	store i32 %u272, i32* %t
	%u273 = load i32, i32* %n
	%u274 = load i32, i32* %o
	%u275 = add i32 %u273, %u274
	%u276 = load i32, i32* %f
	%u277 = load i32, i32* %a
	%u278 = mul i32 %u276, %u277
	%u279 = sub i32 %u275, %u278
	store i32 %u279, i32* %u
	%u280 = load i32, i32* %a
	%u281 = load i32, i32* %b
	%u282 = mul i32 %u280, %u281
	%u283 = load i32, i32* %k
	%u284 = sub i32 %u282, %u283
	%u285 = load i32, i32* %l
	%u286 = sub i32 %u284, %u285
	store i32 %u286, i32* %v
	%u287 = load i32, i32* %v
	%u288 = load i32, i32* %s
	%u289 = sub i32 %u287, %u288
	%u290 = load i32, i32* %r
	%u291 = load i32, i32* %d
	%u292 = mul i32 %u290, %u291
	%u293 = sub i32 %u289, %u292
	store i32 %u293, i32* %w
	%u294 = load i32, i32* %o
	%u295 = load i32, i32* %w
	%u296 = sub i32 %u294, %u295
	%u297 = load i32, i32* %v
	%u298 = sub i32 %u296, %u297
	%u299 = load i32, i32* %n
	%u300 = sub i32 %u298, %u299
	store i32 %u300, i32* %x
	%u301 = load i32, i32* %p
	%u302 = load i32, i32* %x
	%u303 = mul i32 %u301, %u302
	%u304 = load i32, i32* %t
	%u305 = add i32 %u303, %u304
	%u306 = load i32, i32* %w
	%u307 = sub i32 %u305, %u306
	store i32 %u307, i32* %y
	%u308 = load i32, i32* %w
	%u309 = load i32, i32* %x
	%u310 = sub i32 %u308, %u309
	%u311 = load i32, i32* %y
	%u312 = add i32 %u310, %u311
	%u313 = load i32, i32* %k
	%u314 = add i32 %u312, %u313
	store i32 %u314, i32* %z
	%u315 = load i32, i32* %z
	store i32 %u315, i32* %_retval_
	br label %LU2
LU2:
	%u316 = load i32, i32* %_retval_
	ret i32 %u316
}

define i32 @deadCodeElimination()
{
LU5:
	%_retval_ = alloca i32
	%a = alloca i32
	%b = alloca i32
	%c = alloca i32
	%d = alloca i32
	%e = alloca i32
	store i32 4, i32* %a
	store i32 5, i32* %a
	store i32 7, i32* %a
	store i32 8, i32* %a
	store i32 6, i32* %b
	store i32 9, i32* %b
	store i32 12, i32* %b
	store i32 8, i32* %b
	store i32 10, i32* %c
	store i32 13, i32* %c
	store i32 9, i32* %c
	store i32 45, i32* %d
	store i32 12, i32* %d
	store i32 3, i32* %d
	store i32 23, i32* %e
	store i32 10, i32* %e
	store i32 11, i32* @global1
	store i32 5, i32* @global1
	store i32 9, i32* @global1
	%u317 = load i32, i32* %a
	%u318 = load i32, i32* %b
	%u319 = add i32 %u317, %u318
	%u320 = load i32, i32* %c
	%u321 = add i32 %u319, %u320
	%u322 = load i32, i32* %d
	%u323 = add i32 %u321, %u322
	%u324 = load i32, i32* %e
	%u325 = add i32 %u323, %u324
	store i32 %u325, i32* %_retval_
	br label %LU4
LU4:
	%u326 = load i32, i32* %_retval_
	ret i32 %u326
}

define i32 @sum(i32 %number)
{
LU7:
	%_P_number = alloca i32
	%_retval_ = alloca i32
	%total = alloca i32
	store i32 %number, i32* %_P_number
	store i32 0, i32* %total
	%u327 = load i32, i32* %_P_number
	%u328 = icmp sgt i32 %u327, 0
	br i1 %u328, label %LU8, label %LU9
LU8:
	%u329 = load i32, i32* %total
	%u330 = load i32, i32* %_P_number
	%u331 = add i32 %u329, %u330
	store i32 %u331, i32* %total
	%u332 = load i32, i32* %_P_number
	%u333 = sub i32 %u332, 1
	store i32 %u333, i32* %_P_number
	%u334 = load i32, i32* %_P_number
	%u335 = icmp sgt i32 %u334, 0
	br i1 %u335, label %LU8, label %LU9
LU9:
	%u336 = load i32, i32* %total
	store i32 %u336, i32* %_retval_
	br label %LU6
LU6:
	%u337 = load i32, i32* %_retval_
	ret i32 %u337
}

define i32 @doesntModifyGlobals()
{
LU11:
	%_retval_ = alloca i32
	%a = alloca i32
	%b = alloca i32
	store i32 1, i32* %a
	store i32 2, i32* %b
	%u338 = load i32, i32* %a
	%u339 = load i32, i32* %b
	%u340 = add i32 %u338, %u339
	store i32 %u340, i32* %_retval_
	br label %LU10
LU10:
	%u341 = load i32, i32* %_retval_
	ret i32 %u341
}

define i32 @interProceduralOptimization()
{
LU13:
	%_retval_ = alloca i32
	%a = alloca i32
	store i32 1, i32* @global1
	store i32 0, i32* @global2
	store i32 0, i32* @global3
	%u342 = call i32 @sum(i32 100)
	store i32 %u342, i32* %a
	%u343 = load i32, i32* @global1
	%u344 = icmp eq i32 %u343, 1
	br i1 %u344, label %LU14, label %LU15
LU14:
	%u345 = call i32 @sum(i32 10000)
	store i32 %u345, i32* %a
	br label %LU16
LU15:
	%u346 = load i32, i32* @global2
	%u347 = icmp eq i32 %u346, 2
	br i1 %u347, label %LU17, label %LU18
LU17:
	%u348 = call i32 @sum(i32 20000)
	store i32 %u348, i32* %a
	br label %LU18
LU18:
	%u349 = load i32, i32* @global3
	%u350 = icmp eq i32 %u349, 3
	br i1 %u350, label %LU19, label %LU20
LU19:
	%u351 = call i32 @sum(i32 30000)
	store i32 %u351, i32* %a
	br label %LU20
LU20:
	br label %LU16
LU16:
	%u352 = load i32, i32* %a
	store i32 %u352, i32* %_retval_
	br label %LU12
LU12:
	%u353 = load i32, i32* %_retval_
	ret i32 %u353
}

define i32 @commonSubexpressionElimination()
{
LU22:
	%_retval_ = alloca i32
	%a = alloca i32
	%b = alloca i32
	%c = alloca i32
	%d = alloca i32
	%e = alloca i32
	%f = alloca i32
	%g = alloca i32
	%h = alloca i32
	%i = alloca i32
	%j = alloca i32
	%k = alloca i32
	%l = alloca i32
	%m = alloca i32
	%n = alloca i32
	%o = alloca i32
	%p = alloca i32
	%q = alloca i32
	%r = alloca i32
	%s = alloca i32
	%t = alloca i32
	%u = alloca i32
	%v = alloca i32
	%w = alloca i32
	%x = alloca i32
	%y = alloca i32
	%z = alloca i32
	store i32 11, i32* %a
	store i32 22, i32* %b
	store i32 33, i32* %c
	store i32 44, i32* %d
	store i32 55, i32* %e
	store i32 66, i32* %f
	store i32 77, i32* %g
	%u354 = load i32, i32* %a
	%u355 = load i32, i32* %b
	%u356 = mul i32 %u354, %u355
	store i32 %u356, i32* %h
	%u357 = load i32, i32* %c
	%u358 = load i32, i32* %d
	%u359 = sdiv i32 %u357, %u358
	store i32 %u359, i32* %i
	%u360 = load i32, i32* %e
	%u361 = load i32, i32* %f
	%u362 = mul i32 %u360, %u361
	store i32 %u362, i32* %j
	%u363 = load i32, i32* %a
	%u364 = load i32, i32* %b
	%u365 = mul i32 %u363, %u364
	%u366 = load i32, i32* %c
	%u367 = load i32, i32* %d
	%u368 = sdiv i32 %u366, %u367
	%u369 = add i32 %u365, %u368
	%u370 = load i32, i32* %e
	%u371 = load i32, i32* %f
	%u372 = mul i32 %u370, %u371
	%u373 = sub i32 %u369, %u372
	%u374 = load i32, i32* %g
	%u375 = add i32 %u373, %u374
	store i32 %u375, i32* %k
	%u376 = load i32, i32* %a
	%u377 = load i32, i32* %b
	%u378 = mul i32 %u376, %u377
	%u379 = load i32, i32* %c
	%u380 = load i32, i32* %d
	%u381 = sdiv i32 %u379, %u380
	%u382 = add i32 %u378, %u381
	%u383 = load i32, i32* %e
	%u384 = load i32, i32* %f
	%u385 = mul i32 %u383, %u384
	%u386 = sub i32 %u382, %u385
	%u387 = load i32, i32* %g
	%u388 = add i32 %u386, %u387
	store i32 %u388, i32* %l
	%u389 = load i32, i32* %a
	%u390 = load i32, i32* %b
	%u391 = mul i32 %u389, %u390
	%u392 = load i32, i32* %c
	%u393 = load i32, i32* %d
	%u394 = sdiv i32 %u392, %u393
	%u395 = add i32 %u391, %u394
	%u396 = load i32, i32* %e
	%u397 = load i32, i32* %f
	%u398 = mul i32 %u396, %u397
	%u399 = sub i32 %u395, %u398
	%u400 = load i32, i32* %g
	%u401 = add i32 %u399, %u400
	store i32 %u401, i32* %m
	%u402 = load i32, i32* %a
	%u403 = load i32, i32* %b
	%u404 = mul i32 %u402, %u403
	%u405 = load i32, i32* %c
	%u406 = load i32, i32* %d
	%u407 = sdiv i32 %u405, %u406
	%u408 = add i32 %u404, %u407
	%u409 = load i32, i32* %e
	%u410 = load i32, i32* %f
	%u411 = mul i32 %u409, %u410
	%u412 = sub i32 %u408, %u411
	%u413 = load i32, i32* %g
	%u414 = add i32 %u412, %u413
	store i32 %u414, i32* %n
	%u415 = load i32, i32* %a
	%u416 = load i32, i32* %b
	%u417 = mul i32 %u415, %u416
	%u418 = load i32, i32* %c
	%u419 = load i32, i32* %d
	%u420 = sdiv i32 %u418, %u419
	%u421 = add i32 %u417, %u420
	%u422 = load i32, i32* %e
	%u423 = load i32, i32* %f
	%u424 = mul i32 %u422, %u423
	%u425 = sub i32 %u421, %u424
	%u426 = load i32, i32* %g
	%u427 = add i32 %u425, %u426
	store i32 %u427, i32* %o
	%u428 = load i32, i32* %a
	%u429 = load i32, i32* %b
	%u430 = mul i32 %u428, %u429
	%u431 = load i32, i32* %c
	%u432 = load i32, i32* %d
	%u433 = sdiv i32 %u431, %u432
	%u434 = add i32 %u430, %u433
	%u435 = load i32, i32* %e
	%u436 = load i32, i32* %f
	%u437 = mul i32 %u435, %u436
	%u438 = sub i32 %u434, %u437
	%u439 = load i32, i32* %g
	%u440 = add i32 %u438, %u439
	store i32 %u440, i32* %p
	%u441 = load i32, i32* %a
	%u442 = load i32, i32* %b
	%u443 = mul i32 %u441, %u442
	%u444 = load i32, i32* %c
	%u445 = load i32, i32* %d
	%u446 = sdiv i32 %u444, %u445
	%u447 = add i32 %u443, %u446
	%u448 = load i32, i32* %e
	%u449 = load i32, i32* %f
	%u450 = mul i32 %u448, %u449
	%u451 = sub i32 %u447, %u450
	%u452 = load i32, i32* %g
	%u453 = add i32 %u451, %u452
	store i32 %u453, i32* %q
	%u454 = load i32, i32* %a
	%u455 = load i32, i32* %b
	%u456 = mul i32 %u454, %u455
	%u457 = load i32, i32* %c
	%u458 = load i32, i32* %d
	%u459 = sdiv i32 %u457, %u458
	%u460 = add i32 %u456, %u459
	%u461 = load i32, i32* %e
	%u462 = load i32, i32* %f
	%u463 = mul i32 %u461, %u462
	%u464 = sub i32 %u460, %u463
	%u465 = load i32, i32* %g
	%u466 = add i32 %u464, %u465
	store i32 %u466, i32* %r
	%u467 = load i32, i32* %a
	%u468 = load i32, i32* %b
	%u469 = mul i32 %u467, %u468
	%u470 = load i32, i32* %c
	%u471 = load i32, i32* %d
	%u472 = sdiv i32 %u470, %u471
	%u473 = add i32 %u469, %u472
	%u474 = load i32, i32* %e
	%u475 = load i32, i32* %f
	%u476 = mul i32 %u474, %u475
	%u477 = sub i32 %u473, %u476
	%u478 = load i32, i32* %g
	%u479 = add i32 %u477, %u478
	store i32 %u479, i32* %s
	%u480 = load i32, i32* %a
	%u481 = load i32, i32* %b
	%u482 = mul i32 %u480, %u481
	%u483 = load i32, i32* %c
	%u484 = load i32, i32* %d
	%u485 = sdiv i32 %u483, %u484
	%u486 = add i32 %u482, %u485
	%u487 = load i32, i32* %e
	%u488 = load i32, i32* %f
	%u489 = mul i32 %u487, %u488
	%u490 = sub i32 %u486, %u489
	%u491 = load i32, i32* %g
	%u492 = add i32 %u490, %u491
	store i32 %u492, i32* %t
	%u493 = load i32, i32* %a
	%u494 = load i32, i32* %b
	%u495 = mul i32 %u493, %u494
	%u496 = load i32, i32* %c
	%u497 = load i32, i32* %d
	%u498 = sdiv i32 %u496, %u497
	%u499 = add i32 %u495, %u498
	%u500 = load i32, i32* %e
	%u501 = load i32, i32* %f
	%u502 = mul i32 %u500, %u501
	%u503 = sub i32 %u499, %u502
	%u504 = load i32, i32* %g
	%u505 = add i32 %u503, %u504
	store i32 %u505, i32* %u
	%u506 = load i32, i32* %b
	%u507 = load i32, i32* %a
	%u508 = mul i32 %u506, %u507
	%u509 = load i32, i32* %c
	%u510 = load i32, i32* %d
	%u511 = sdiv i32 %u509, %u510
	%u512 = add i32 %u508, %u511
	%u513 = load i32, i32* %e
	%u514 = load i32, i32* %f
	%u515 = mul i32 %u513, %u514
	%u516 = sub i32 %u512, %u515
	%u517 = load i32, i32* %g
	%u518 = add i32 %u516, %u517
	store i32 %u518, i32* %v
	%u519 = load i32, i32* %a
	%u520 = load i32, i32* %b
	%u521 = mul i32 %u519, %u520
	%u522 = load i32, i32* %c
	%u523 = load i32, i32* %d
	%u524 = sdiv i32 %u522, %u523
	%u525 = add i32 %u521, %u524
	%u526 = load i32, i32* %f
	%u527 = load i32, i32* %e
	%u528 = mul i32 %u526, %u527
	%u529 = sub i32 %u525, %u528
	%u530 = load i32, i32* %g
	%u531 = add i32 %u529, %u530
	store i32 %u531, i32* %w
	%u532 = load i32, i32* %g
	%u533 = load i32, i32* %a
	%u534 = load i32, i32* %b
	%u535 = mul i32 %u533, %u534
	%u536 = add i32 %u532, %u535
	%u537 = load i32, i32* %c
	%u538 = load i32, i32* %d
	%u539 = sdiv i32 %u537, %u538
	%u540 = add i32 %u536, %u539
	%u541 = load i32, i32* %e
	%u542 = load i32, i32* %f
	%u543 = mul i32 %u541, %u542
	%u544 = sub i32 %u540, %u543
	store i32 %u544, i32* %x
	%u545 = load i32, i32* %a
	%u546 = load i32, i32* %b
	%u547 = mul i32 %u545, %u546
	%u548 = load i32, i32* %c
	%u549 = load i32, i32* %d
	%u550 = sdiv i32 %u548, %u549
	%u551 = add i32 %u547, %u550
	%u552 = load i32, i32* %e
	%u553 = load i32, i32* %f
	%u554 = mul i32 %u552, %u553
	%u555 = sub i32 %u551, %u554
	%u556 = load i32, i32* %g
	%u557 = add i32 %u555, %u556
	store i32 %u557, i32* %y
	%u558 = load i32, i32* %c
	%u559 = load i32, i32* %d
	%u560 = sdiv i32 %u558, %u559
	%u561 = load i32, i32* %a
	%u562 = load i32, i32* %b
	%u563 = mul i32 %u561, %u562
	%u564 = add i32 %u560, %u563
	%u565 = load i32, i32* %e
	%u566 = load i32, i32* %f
	%u567 = mul i32 %u565, %u566
	%u568 = sub i32 %u564, %u567
	%u569 = load i32, i32* %g
	%u570 = add i32 %u568, %u569
	store i32 %u570, i32* %z
	%u571 = load i32, i32* %a
	%u572 = load i32, i32* %b
	%u573 = add i32 %u571, %u572
	%u574 = load i32, i32* %c
	%u575 = add i32 %u573, %u574
	%u576 = load i32, i32* %d
	%u577 = add i32 %u575, %u576
	%u578 = load i32, i32* %e
	%u579 = add i32 %u577, %u578
	%u580 = load i32, i32* %f
	%u581 = add i32 %u579, %u580
	%u582 = load i32, i32* %g
	%u583 = add i32 %u581, %u582
	%u584 = load i32, i32* %h
	%u585 = add i32 %u583, %u584
	%u586 = load i32, i32* %i
	%u587 = add i32 %u585, %u586
	%u588 = load i32, i32* %j
	%u589 = add i32 %u587, %u588
	%u590 = load i32, i32* %k
	%u591 = add i32 %u589, %u590
	%u592 = load i32, i32* %l
	%u593 = add i32 %u591, %u592
	%u594 = load i32, i32* %m
	%u595 = add i32 %u593, %u594
	%u596 = load i32, i32* %n
	%u597 = add i32 %u595, %u596
	%u598 = load i32, i32* %o
	%u599 = add i32 %u597, %u598
	%u600 = load i32, i32* %p
	%u601 = add i32 %u599, %u600
	%u602 = load i32, i32* %q
	%u603 = add i32 %u601, %u602
	%u604 = load i32, i32* %r
	%u605 = add i32 %u603, %u604
	%u606 = load i32, i32* %s
	%u607 = add i32 %u605, %u606
	%u608 = load i32, i32* %t
	%u609 = add i32 %u607, %u608
	%u610 = load i32, i32* %u
	%u611 = add i32 %u609, %u610
	%u612 = load i32, i32* %v
	%u613 = add i32 %u611, %u612
	%u614 = load i32, i32* %w
	%u615 = add i32 %u613, %u614
	%u616 = load i32, i32* %x
	%u617 = add i32 %u615, %u616
	%u618 = load i32, i32* %y
	%u619 = add i32 %u617, %u618
	%u620 = load i32, i32* %z
	%u621 = add i32 %u619, %u620
	store i32 %u621, i32* %_retval_
	br label %LU21
LU21:
	%u622 = load i32, i32* %_retval_
	ret i32 %u622
}

define i32 @hoisting()
{
LU24:
	%_retval_ = alloca i32
	%a = alloca i32
	%b = alloca i32
	%c = alloca i32
	%d = alloca i32
	%e = alloca i32
	%f = alloca i32
	%g = alloca i32
	%h = alloca i32
	%i = alloca i32
	store i32 1, i32* %a
	store i32 2, i32* %b
	store i32 3, i32* %c
	store i32 4, i32* %d
	store i32 0, i32* %i
	%u623 = load i32, i32* %i
	%u624 = icmp slt i32 %u623, 1000000
	br i1 %u624, label %LU25, label %LU26
LU25:
	store i32 5, i32* %e
	%u625 = load i32, i32* %a
	%u626 = load i32, i32* %b
	%u627 = add i32 %u625, %u626
	%u628 = load i32, i32* %c
	%u629 = add i32 %u627, %u628
	store i32 %u629, i32* %g
	%u630 = load i32, i32* %c
	%u631 = load i32, i32* %d
	%u632 = add i32 %u630, %u631
	%u633 = load i32, i32* %g
	%u634 = add i32 %u632, %u633
	store i32 %u634, i32* %h
	%u635 = load i32, i32* %i
	%u636 = add i32 %u635, 1
	store i32 %u636, i32* %i
	%u637 = load i32, i32* %i
	%u638 = icmp slt i32 %u637, 1000000
	br i1 %u638, label %LU25, label %LU26
LU26:
	%u639 = load i32, i32* %b
	store i32 %u639, i32* %_retval_
	br label %LU23
LU23:
	%u640 = load i32, i32* %_retval_
	ret i32 %u640
}

define i32 @doubleIf()
{
LU28:
	%_retval_ = alloca i32
	%a = alloca i32
	%b = alloca i32
	%c = alloca i32
	%d = alloca i32
	store i32 1, i32* %a
	store i32 2, i32* %b
	store i32 3, i32* %c
	store i32 0, i32* %d
	%u641 = load i32, i32* %a
	%u642 = icmp eq i32 %u641, 1
	br i1 %u642, label %LU29, label %LU30
LU29:
	store i32 20, i32* %b
	%u643 = load i32, i32* %a
	%u644 = icmp eq i32 %u643, 1
	br i1 %u644, label %LU31, label %LU32
LU31:
	store i32 200, i32* %b
	store i32 300, i32* %c
	br label %LU33
LU32:
	store i32 1, i32* %a
	store i32 2, i32* %b
	store i32 3, i32* %c
	br label %LU33
LU33:
	store i32 50, i32* %d
	br label %LU30
LU30:
	%u645 = load i32, i32* %d
	store i32 %u645, i32* %_retval_
	br label %LU27
LU27:
	%u646 = load i32, i32* %_retval_
	ret i32 %u646
}

define i32 @integerDivide()
{
LU35:
	%_retval_ = alloca i32
	%a = alloca i32
	store i32 3000, i32* %a
	%u647 = load i32, i32* %a
	%u648 = sdiv i32 %u647, 2
	store i32 %u648, i32* %a
	%u649 = load i32, i32* %a
	%u650 = mul i32 %u649, 4
	store i32 %u650, i32* %a
	%u651 = load i32, i32* %a
	%u652 = sdiv i32 %u651, 8
	store i32 %u652, i32* %a
	%u653 = load i32, i32* %a
	%u654 = sdiv i32 %u653, 16
	store i32 %u654, i32* %a
	%u655 = load i32, i32* %a
	%u656 = mul i32 %u655, 32
	store i32 %u656, i32* %a
	%u657 = load i32, i32* %a
	%u658 = sdiv i32 %u657, 64
	store i32 %u658, i32* %a
	%u659 = load i32, i32* %a
	%u660 = mul i32 %u659, 128
	store i32 %u660, i32* %a
	%u661 = load i32, i32* %a
	%u662 = sdiv i32 %u661, 4
	store i32 %u662, i32* %a
	%u663 = load i32, i32* %a
	store i32 %u663, i32* %_retval_
	br label %LU34
LU34:
	%u664 = load i32, i32* %_retval_
	ret i32 %u664
}

define i32 @association()
{
LU37:
	%_retval_ = alloca i32
	%a = alloca i32
	store i32 10, i32* %a
	%u665 = load i32, i32* %a
	%u666 = mul i32 %u665, 2
	store i32 %u666, i32* %a
	%u667 = load i32, i32* %a
	%u668 = sdiv i32 %u667, 2
	store i32 %u668, i32* %a
	%u669 = load i32, i32* %a
	%u670 = mul i32 3, %u669
	store i32 %u670, i32* %a
	%u671 = load i32, i32* %a
	%u672 = sdiv i32 %u671, 3
	store i32 %u672, i32* %a
	%u673 = load i32, i32* %a
	%u674 = mul i32 %u673, 4
	store i32 %u674, i32* %a
	%u675 = load i32, i32* %a
	%u676 = sdiv i32 %u675, 4
	store i32 %u676, i32* %a
	%u677 = load i32, i32* %a
	%u678 = add i32 %u677, 4
	store i32 %u678, i32* %a
	%u679 = load i32, i32* %a
	%u680 = sub i32 %u679, 4
	store i32 %u680, i32* %a
	%u681 = load i32, i32* %a
	%u682 = mul i32 %u681, 50
	store i32 %u682, i32* %a
	%u683 = load i32, i32* %a
	%u684 = sdiv i32 %u683, 50
	store i32 %u684, i32* %a
	%u685 = load i32, i32* %a
	store i32 %u685, i32* %_retval_
	br label %LU36
LU36:
	%u686 = load i32, i32* %_retval_
	ret i32 %u686
}

define i32 @tailRecursionHelper(i32 %value, i32 %sum)
{
LU39:
	%_P_value = alloca i32
	%_P_sum = alloca i32
	%_retval_ = alloca i32
	store i32 %value, i32* %_P_value
	store i32 %sum, i32* %_P_sum
	%u687 = load i32, i32* %_P_value
	%u688 = icmp eq i32 %u687, 0
	br i1 %u688, label %LU40, label %LU41
LU40:
	%u689 = load i32, i32* %_P_sum
	store i32 %u689, i32* %_retval_
	br label %LU38
LU41:
	%u690 = load i32, i32* %_P_value
	%u691 = sub i32 %u690, 1
	%u692 = load i32, i32* %_P_sum
	%u693 = load i32, i32* %_P_value
	%u694 = add i32 %u692, %u693
	%u695 = call i32 @tailRecursionHelper(i32 %u691, i32 %u694)
	store i32 %u695, i32* %_retval_
	br label %LU38
LU42:
	br label %LU38
LU38:
	%u696 = load i32, i32* %_retval_
	ret i32 %u696
}

define i32 @tailRecursion(i32 %value)
{
LU44:
	%_P_value = alloca i32
	%_retval_ = alloca i32
	store i32 %value, i32* %_P_value
	%u697 = load i32, i32* %_P_value
	%u698 = call i32 @tailRecursionHelper(i32 %u697, i32 0)
	store i32 %u698, i32* %_retval_
	br label %LU43
LU43:
	%u699 = load i32, i32* %_retval_
	ret i32 %u699
}

define i32 @unswitching()
{
LU46:
	%_retval_ = alloca i32
	%a = alloca i32
	%b = alloca i32
	store i32 1, i32* %a
	store i32 2, i32* %b
	%u700 = load i32, i32* %a
	%u701 = icmp slt i32 %u700, 1000000
	br i1 %u701, label %LU47, label %LU48
LU47:
	%u702 = load i32, i32* %b
	%u703 = icmp eq i32 %u702, 2
	br i1 %u703, label %LU49, label %LU50
LU49:
	%u704 = load i32, i32* %a
	%u705 = add i32 %u704, 1
	store i32 %u705, i32* %a
	br label %LU51
LU50:
	%u706 = load i32, i32* %a
	%u707 = add i32 %u706, 2
	store i32 %u707, i32* %a
	br label %LU51
LU51:
	%u708 = load i32, i32* %a
	%u709 = icmp slt i32 %u708, 1000000
	br i1 %u709, label %LU47, label %LU48
LU48:
	%u710 = load i32, i32* %a
	store i32 %u710, i32* %_retval_
	br label %LU45
LU45:
	%u711 = load i32, i32* %_retval_
	ret i32 %u711
}

define i32 @randomCalculation(i32 %number)
{
LU53:
	%_P_number = alloca i32
	%_retval_ = alloca i32
	%a = alloca i32
	%b = alloca i32
	%c = alloca i32
	%d = alloca i32
	%e = alloca i32
	%i = alloca i32
	%sum = alloca i32
	store i32 %number, i32* %_P_number
	store i32 0, i32* %i
	store i32 0, i32* %sum
	%u712 = load i32, i32* %i
	%u713 = load i32, i32* %_P_number
	%u714 = icmp slt i32 %u712, %u713
	br i1 %u714, label %LU54, label %LU55
LU54:
	store i32 4, i32* %a
	store i32 7, i32* %b
	store i32 8, i32* %c
	%u715 = load i32, i32* %a
	%u716 = load i32, i32* %b
	%u717 = add i32 %u715, %u716
	store i32 %u717, i32* %d
	%u718 = load i32, i32* %d
	%u719 = load i32, i32* %c
	%u720 = add i32 %u718, %u719
	store i32 %u720, i32* %e
	%u721 = load i32, i32* %sum
	%u722 = load i32, i32* %e
	%u723 = add i32 %u721, %u722
	store i32 %u723, i32* %sum
	%u724 = load i32, i32* %i
	%u725 = mul i32 %u724, 2
	store i32 %u725, i32* %i
	%u726 = load i32, i32* %i
	%u727 = sdiv i32 %u726, 2
	store i32 %u727, i32* %i
	%u728 = load i32, i32* %i
	%u729 = mul i32 3, %u728
	store i32 %u729, i32* %i
	%u730 = load i32, i32* %i
	%u731 = sdiv i32 %u730, 3
	store i32 %u731, i32* %i
	%u732 = load i32, i32* %i
	%u733 = mul i32 %u732, 4
	store i32 %u733, i32* %i
	%u734 = load i32, i32* %i
	%u735 = sdiv i32 %u734, 4
	store i32 %u735, i32* %i
	%u736 = load i32, i32* %i
	%u737 = add i32 %u736, 1
	store i32 %u737, i32* %i
	%u738 = load i32, i32* %i
	%u739 = load i32, i32* %_P_number
	%u740 = icmp slt i32 %u738, %u739
	br i1 %u740, label %LU54, label %LU55
LU55:
	%u741 = load i32, i32* %sum
	store i32 %u741, i32* %_retval_
	br label %LU52
LU52:
	%u742 = load i32, i32* %_retval_
	ret i32 %u742
}

define i32 @iterativeFibonacci(i32 %number)
{
LU57:
	%_P_number = alloca i32
	%_retval_ = alloca i32
	%previous = alloca i32
	%result = alloca i32
	%count = alloca i32
	%i = alloca i32
	%sum = alloca i32
	store i32 %number, i32* %_P_number
	%u743 = sub i32 0, 1
	store i32 %u743, i32* %previous
	store i32 1, i32* %result
	store i32 0, i32* %i
	%u744 = load i32, i32* %i
	%u745 = load i32, i32* %_P_number
	%u746 = icmp slt i32 %u744, %u745
	br i1 %u746, label %LU58, label %LU59
LU58:
	%u747 = load i32, i32* %result
	%u748 = load i32, i32* %previous
	%u749 = add i32 %u747, %u748
	store i32 %u749, i32* %sum
	%u750 = load i32, i32* %result
	store i32 %u750, i32* %previous
	%u751 = load i32, i32* %sum
	store i32 %u751, i32* %result
	%u752 = load i32, i32* %i
	%u753 = add i32 %u752, 1
	store i32 %u753, i32* %i
	%u754 = load i32, i32* %i
	%u755 = load i32, i32* %_P_number
	%u756 = icmp slt i32 %u754, %u755
	br i1 %u756, label %LU58, label %LU59
LU59:
	%u757 = load i32, i32* %result
	store i32 %u757, i32* %_retval_
	br label %LU56
LU56:
	%u758 = load i32, i32* %_retval_
	ret i32 %u758
}

define i32 @recursiveFibonacci(i32 %number)
{
LU61:
	%_P_number = alloca i32
	%_retval_ = alloca i32
	store i32 %number, i32* %_P_number
	%u759 = load i32, i32* %_P_number
	%u760 = icmp sle i32 %u759, 0
	%u761 = load i32, i32* %_P_number
	%u762 = icmp eq i32 %u761, 1
	%u763 = or i1 %u760, %u762
	br i1 %u763, label %LU62, label %LU63
LU62:
	%u764 = load i32, i32* %_P_number
	store i32 %u764, i32* %_retval_
	br label %LU60
LU63:
	%u765 = load i32, i32* %_P_number
	%u766 = sub i32 %u765, 1
	%u767 = call i32 @recursiveFibonacci(i32 %u766)
	%u768 = load i32, i32* %_P_number
	%u769 = sub i32 %u768, 2
	%u770 = call i32 @recursiveFibonacci(i32 %u769)
	%u771 = add i32 %u767, %u770
	store i32 %u771, i32* %_retval_
	br label %LU60
LU64:
	br label %LU60
LU60:
	%u772 = load i32, i32* %_retval_
	ret i32 %u772
}

define i32 @main()
{
LU66:
	%_retval_ = alloca i32
	%input = alloca i32
	%result = alloca i32
	%i = alloca i32
	call i32 (i8*, ...) @scanf(i8* getelementptr inbounds ([5 x i8], [5 x i8]* @.read, i32 0, i32 0), i32* %input)
	store i32 1, i32* %i
	%u773 = load i32, i32* %i
	%u774 = load i32, i32* %input
	%u775 = icmp slt i32 %u773, %u774
	br i1 %u775, label %LU67, label %LU68
LU67:
	%u776 = call i32 @constantFolding()
	store i32 %u776, i32* %result
	%u777 = load i32, i32* %result
	call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([6 x i8], [6 x i8]* @.println, i32 0, i32 0), i32 %u777)
	%u778 = call i32 @constantPropagation()
	store i32 %u778, i32* %result
	%u779 = load i32, i32* %result
	call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([6 x i8], [6 x i8]* @.println, i32 0, i32 0), i32 %u779)
	%u780 = call i32 @deadCodeElimination()
	store i32 %u780, i32* %result
	%u781 = load i32, i32* %result
	call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([6 x i8], [6 x i8]* @.println, i32 0, i32 0), i32 %u781)
	%u782 = call i32 @interProceduralOptimization()
	store i32 %u782, i32* %result
	%u783 = load i32, i32* %result
	call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([6 x i8], [6 x i8]* @.println, i32 0, i32 0), i32 %u783)
	%u784 = call i32 @commonSubexpressionElimination()
	store i32 %u784, i32* %result
	%u785 = load i32, i32* %result
	call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([6 x i8], [6 x i8]* @.println, i32 0, i32 0), i32 %u785)
	%u786 = call i32 @hoisting()
	store i32 %u786, i32* %result
	%u787 = load i32, i32* %result
	call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([6 x i8], [6 x i8]* @.println, i32 0, i32 0), i32 %u787)
	%u788 = call i32 @doubleIf()
	store i32 %u788, i32* %result
	%u789 = load i32, i32* %result
	call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([6 x i8], [6 x i8]* @.println, i32 0, i32 0), i32 %u789)
	%u790 = call i32 @integerDivide()
	store i32 %u790, i32* %result
	%u791 = load i32, i32* %result
	call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([6 x i8], [6 x i8]* @.println, i32 0, i32 0), i32 %u791)
	%u792 = call i32 @association()
	store i32 %u792, i32* %result
	%u793 = load i32, i32* %result
	call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([6 x i8], [6 x i8]* @.println, i32 0, i32 0), i32 %u793)
	%u794 = load i32, i32* %input
	%u795 = sdiv i32 %u794, 1000
	%u796 = call i32 @tailRecursion(i32 %u795)
	store i32 %u796, i32* %result
	%u797 = load i32, i32* %result
	call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([6 x i8], [6 x i8]* @.println, i32 0, i32 0), i32 %u797)
	%u798 = call i32 @unswitching()
	store i32 %u798, i32* %result
	%u799 = load i32, i32* %result
	call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([6 x i8], [6 x i8]* @.println, i32 0, i32 0), i32 %u799)
	%u800 = load i32, i32* %input
	%u801 = call i32 @randomCalculation(i32 %u800)
	store i32 %u801, i32* %result
	%u802 = load i32, i32* %result
	call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([6 x i8], [6 x i8]* @.println, i32 0, i32 0), i32 %u802)
	%u803 = load i32, i32* %input
	%u804 = sdiv i32 %u803, 5
	%u805 = call i32 @iterativeFibonacci(i32 %u804)
	store i32 %u805, i32* %result
	%u806 = load i32, i32* %result
	call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([6 x i8], [6 x i8]* @.println, i32 0, i32 0), i32 %u806)
	%u807 = load i32, i32* %input
	%u808 = sdiv i32 %u807, 1000
	%u809 = call i32 @recursiveFibonacci(i32 %u808)
	store i32 %u809, i32* %result
	%u810 = load i32, i32* %result
	call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([6 x i8], [6 x i8]* @.println, i32 0, i32 0), i32 %u810)
	%u811 = load i32, i32* %i
	%u812 = add i32 %u811, 1
	store i32 %u812, i32* %i
	%u813 = load i32, i32* %i
	%u814 = load i32, i32* %input
	%u815 = icmp slt i32 %u813, %u814
	br i1 %u815, label %LU67, label %LU68
LU68:
	call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([6 x i8], [6 x i8]* @.println, i32 0, i32 0), i32 9999)
	store i32 0, i32* %_retval_
	br label %LU65
LU65:
	%u816 = load i32, i32* %_retval_
	ret i32 %u816
}
declare i8* @malloc(i32)
declare void @free(i8*)
declare i32 @printf(i8*, ...)
declare i32 @scanf(i8*, ...)
@.println = private unnamed_addr constant [6 x i8] c"%ld\0A\00\00", align 1
@.print = private unnamed_addr constant [6 x i8] c"%ld \00\00", align 1
@.read = private unnamed_addr constant [5 x i8] c"%ld\00\00", align 1
@.read_scratch = common global i32 0, align 4
