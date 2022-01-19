target triple="i686"
%struct.node = type {i32, %struct.node*}
%struct.tnode = type {i32, %struct.tnode*, %struct.tnode*}
%struct.i = type {i32}
%struct.myCopy = type {i32}

@a = common global i32 0, align 4
@b = common global i32 0, align 4
@i = common global %struct.i* null, align 4

define %struct.node* @concatLists(%struct.node* %first, %struct.node* %second)
{
LU1:
	%_P_first = alloca %struct.node*
	%_P_second = alloca %struct.node*
	%_retval_ = alloca %struct.node*
	%temp = alloca %struct.node*
	store %struct.node* %first, %struct.node** %_P_first
	store %struct.node* %second, %struct.node** %_P_second
	%u1085 = load %struct.node*, %struct.node** %_P_first
	store %struct.node* %u1085, %struct.node** %temp
	%u1086 = load %struct.node*, %struct.node** %_P_first
	%u1087 = icmp eq %struct.node* %u1086, null
	br i1 %u1087, label %LU2, label %LU3
LU2:
	%u1088 = load %struct.node*, %struct.node** %_P_second
	store %struct.node* %u1088, %struct.node** %_retval_
	br label %LU0
LU3:
	%u1089 = load %struct.node*, %struct.node** %temp
	%u1090 = getelementptr %struct.node, %struct.node* %u1089, i1 0, i32 1
	%u1091 = load %struct.node*, %struct.node** %u1090
	%u1092 = icmp ne %struct.node* %u1091, null
	br i1 %u1092, label %LU4, label %LU5
LU4:
	%u1093 = load %struct.node*, %struct.node** %temp
	%u1094 = getelementptr %struct.node, %struct.node* %u1093, i1 0, i32 1
	%u1095 = load %struct.node*, %struct.node** %u1094
	store %struct.node* %u1095, %struct.node** %temp
	%u1096 = load %struct.node*, %struct.node** %temp
	%u1097 = getelementptr %struct.node, %struct.node* %u1096, i1 0, i32 1
	%u1098 = load %struct.node*, %struct.node** %u1097
	%u1099 = icmp ne %struct.node* %u1098, null
	br i1 %u1099, label %LU4, label %LU5
LU5:
	%u1100 = load %struct.node*, %struct.node** %_P_second
	%u1101 = load %struct.node*, %struct.node** %temp
	%u1102 = getelementptr %struct.node, %struct.node* %u1101, i1 0, i32 1
	store %struct.node* %u1100, %struct.node** %u1102
	%u1103 = load %struct.node*, %struct.node** %_P_first
	store %struct.node* %u1103, %struct.node** %_retval_
	br label %LU0
LU0:
	%u1104 = load %struct.node*, %struct.node** %_retval_
	ret %struct.node* %u1104
}

define %struct.node* @add(%struct.node* %list, i32 %toAdd)
{
LU7:
	%_P_list = alloca %struct.node*
	%_P_toAdd = alloca i32
	%_retval_ = alloca %struct.node*
	%newNode = alloca %struct.node*
	store %struct.node* %list, %struct.node** %_P_list
	store i32 %toAdd, i32* %_P_toAdd
	%u1105 = call i8* @malloc(i32 8)
	%u1106 = bitcast i8* %u1105 to %struct.node*
	store %struct.node* %u1106, %struct.node** %newNode
	%u1107 = load i32, i32* %_P_toAdd
	%u1108 = load %struct.node*, %struct.node** %newNode
	%u1109 = getelementptr %struct.node, %struct.node* %u1108, i1 0, i32 0
	store i32 %u1107, i32* %u1109
	%u1110 = load %struct.node*, %struct.node** %_P_list
	%u1111 = load %struct.node*, %struct.node** %newNode
	%u1112 = getelementptr %struct.node, %struct.node* %u1111, i1 0, i32 1
	store %struct.node* %u1110, %struct.node** %u1112
	%u1113 = load %struct.node*, %struct.node** %newNode
	store %struct.node* %u1113, %struct.node** %_retval_
	br label %LU6
LU6:
	%u1114 = load %struct.node*, %struct.node** %_retval_
	ret %struct.node* %u1114
}

define i32 @size(%struct.node* %list)
{
LU9:
	%_P_list = alloca %struct.node*
	%_retval_ = alloca i32
	store %struct.node* %list, %struct.node** %_P_list
	%u1115 = load %struct.node*, %struct.node** %_P_list
	%u1116 = icmp eq %struct.node* %u1115, null
	br i1 %u1116, label %LU10, label %LU11
LU10:
	store i32 0, i32* %_retval_
	br label %LU8
LU11:
	%u1117 = load %struct.node*, %struct.node** %_P_list
	%u1118 = getelementptr %struct.node, %struct.node* %u1117, i1 0, i32 1
	%u1119 = load %struct.node*, %struct.node** %u1118
	%u1120 = call i32 @size(%struct.node* %u1119)
	%u1121 = add i32 1, %u1120
	store i32 %u1121, i32* %_retval_
	br label %LU8
LU8:
	%u1122 = load i32, i32* %_retval_
	ret i32 %u1122
}

define i32 @get(%struct.node* %list, i32 %index)
{
LU13:
	%_P_list = alloca %struct.node*
	%_P_index = alloca i32
	%_retval_ = alloca i32
	store %struct.node* %list, %struct.node** %_P_list
	store i32 %index, i32* %_P_index
	%u1123 = load i32, i32* %_P_index
	%u1124 = icmp eq i32 %u1123, 0
	br i1 %u1124, label %LU14, label %LU15
LU14:
	%u1125 = load %struct.node*, %struct.node** %_P_list
	%u1126 = getelementptr %struct.node, %struct.node* %u1125, i1 0, i32 0
	%u1127 = load i32, i32* %u1126
	store i32 %u1127, i32* %_retval_
	br label %LU12
LU15:
	%u1128 = load %struct.node*, %struct.node** %_P_list
	%u1129 = getelementptr %struct.node, %struct.node* %u1128, i1 0, i32 1
	%u1130 = load %struct.node*, %struct.node** %u1129
	%u1131 = load i32, i32* %_P_index
	%u1132 = sub i32 %u1131, 1
	%u1133 = call i32 @get(%struct.node* %u1130, i32 %u1132)
	store i32 %u1133, i32* %_retval_
	br label %LU12
LU12:
	%u1134 = load i32, i32* %_retval_
	ret i32 %u1134
}

define %struct.node* @pop(%struct.node* %list)
{
LU17:
	%_P_list = alloca %struct.node*
	%_retval_ = alloca %struct.node*
	store %struct.node* %list, %struct.node** %_P_list
	%u1135 = load %struct.node*, %struct.node** %_P_list
	%u1136 = getelementptr %struct.node, %struct.node* %u1135, i1 0, i32 1
	%u1137 = load %struct.node*, %struct.node** %u1136
	store %struct.node* %u1137, %struct.node** %_P_list
	%u1138 = load %struct.node*, %struct.node** %_P_list
	store %struct.node* %u1138, %struct.node** %_retval_
	br label %LU16
LU16:
	%u1139 = load %struct.node*, %struct.node** %_retval_
	ret %struct.node* %u1139
}

define void @printList(%struct.node* %list)
{
LU19:
	%_P_list = alloca %struct.node*
	store %struct.node* %list, %struct.node** %_P_list
	%u1140 = load %struct.node*, %struct.node** %_P_list
	%u1141 = icmp ne %struct.node* %u1140, null
	br i1 %u1141, label %LU20, label %LU21
LU20:
	%u1142 = load %struct.node*, %struct.node** %_P_list
	%u1143 = getelementptr %struct.node, %struct.node* %u1142, i1 0, i32 0
	%u1144 = load i32, i32* %u1143
	call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([6 x i8], [6 x i8]* @.println, i32 0, i32 0), i32 %u1144)
	%u1145 = load %struct.node*, %struct.node** %_P_list
	%u1146 = getelementptr %struct.node, %struct.node* %u1145, i1 0, i32 1
	%u1147 = load %struct.node*, %struct.node** %u1146
	call void @printList(%struct.node* %u1147)
	br label %LU21
LU21:
	br label %LU18
LU18:
	ret void
}

define void @treeprint(%struct.tnode* %root)
{
LU23:
	%_P_root = alloca %struct.tnode*
	store %struct.tnode* %root, %struct.tnode** %_P_root
	%u1148 = load %struct.tnode*, %struct.tnode** %_P_root
	%u1149 = icmp ne %struct.tnode* %u1148, null
	br i1 %u1149, label %LU24, label %LU25
LU24:
	%u1150 = load %struct.tnode*, %struct.tnode** %_P_root
	%u1151 = getelementptr %struct.tnode, %struct.tnode* %u1150, i1 0, i32 1
	%u1152 = load %struct.tnode*, %struct.tnode** %u1151
	call void @treeprint(%struct.tnode* %u1152)
	%u1153 = load %struct.tnode*, %struct.tnode** %_P_root
	%u1154 = getelementptr %struct.tnode, %struct.tnode* %u1153, i1 0, i32 0
	%u1155 = load i32, i32* %u1154
	call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([6 x i8], [6 x i8]* @.println, i32 0, i32 0), i32 %u1155)
	%u1156 = load %struct.tnode*, %struct.tnode** %_P_root
	%u1157 = getelementptr %struct.tnode, %struct.tnode* %u1156, i1 0, i32 2
	%u1158 = load %struct.tnode*, %struct.tnode** %u1157
	call void @treeprint(%struct.tnode* %u1158)
	br label %LU25
LU25:
	br label %LU22
LU22:
	ret void
}

define void @freeList(%struct.node* %list)
{
LU27:
	%_P_list = alloca %struct.node*
	store %struct.node* %list, %struct.node** %_P_list
	%u1159 = load %struct.node*, %struct.node** %_P_list
	%u1160 = icmp ne %struct.node* %u1159, null
	br i1 %u1160, label %LU28, label %LU29
LU28:
	%u1161 = load %struct.node*, %struct.node** %_P_list
	%u1162 = getelementptr %struct.node, %struct.node* %u1161, i1 0, i32 1
	%u1163 = load %struct.node*, %struct.node** %u1162
	call void @freeList(%struct.node* %u1163)
	%u1164 = load %struct.node*, %struct.node** %_P_list
	%u1165 = bitcast %struct.node* %u1164 to i8*
	call void @free(i8* %u1165)
	br label %LU29
LU29:
	br label %LU26
LU26:
	ret void
}

define void @freeTree(%struct.tnode* %root)
{
LU31:
	%_P_root = alloca %struct.tnode*
	store %struct.tnode* %root, %struct.tnode** %_P_root
	%u1166 = load %struct.tnode*, %struct.tnode** %_P_root
	%u1167 = icmp eq %struct.tnode* %u1166, null
	%u1168 = xor i1 true, %u1167
	br i1 %u1168, label %LU32, label %LU33
LU32:
	%u1169 = load %struct.tnode*, %struct.tnode** %_P_root
	%u1170 = getelementptr %struct.tnode, %struct.tnode* %u1169, i1 0, i32 1
	%u1171 = load %struct.tnode*, %struct.tnode** %u1170
	call void @freeTree(%struct.tnode* %u1171)
	%u1172 = load %struct.tnode*, %struct.tnode** %_P_root
	%u1173 = getelementptr %struct.tnode, %struct.tnode* %u1172, i1 0, i32 2
	%u1174 = load %struct.tnode*, %struct.tnode** %u1173
	call void @freeTree(%struct.tnode* %u1174)
	%u1175 = load %struct.tnode*, %struct.tnode** %_P_root
	%u1176 = bitcast %struct.tnode* %u1175 to i8*
	call void @free(i8* %u1176)
	br label %LU33
LU33:
	br label %LU30
LU30:
	ret void
}

define %struct.node* @postOrder(%struct.tnode* %root)
{
LU35:
	%_P_root = alloca %struct.tnode*
	%_retval_ = alloca %struct.node*
	%temp = alloca %struct.node*
	store %struct.tnode* %root, %struct.tnode** %_P_root
	%u1177 = load %struct.tnode*, %struct.tnode** %_P_root
	%u1178 = icmp ne %struct.tnode* %u1177, null
	br i1 %u1178, label %LU36, label %LU37
LU36:
	%u1179 = call i8* @malloc(i32 8)
	%u1180 = bitcast i8* %u1179 to %struct.node*
	store %struct.node* %u1180, %struct.node** %temp
	%u1181 = load %struct.tnode*, %struct.tnode** %_P_root
	%u1182 = getelementptr %struct.tnode, %struct.tnode* %u1181, i1 0, i32 0
	%u1183 = load i32, i32* %u1182
	%u1184 = load %struct.node*, %struct.node** %temp
	%u1185 = getelementptr %struct.node, %struct.node* %u1184, i1 0, i32 0
	store i32 %u1183, i32* %u1185
	%u1186 = load %struct.node*, %struct.node** %temp
	%u1187 = getelementptr %struct.node, %struct.node* %u1186, i1 0, i32 1
	store %struct.node* null, %struct.node** %u1187
	%u1188 = load %struct.tnode*, %struct.tnode** %_P_root
	%u1189 = getelementptr %struct.tnode, %struct.tnode* %u1188, i1 0, i32 1
	%u1190 = load %struct.tnode*, %struct.tnode** %u1189
	%u1191 = call %struct.node* @postOrder(%struct.tnode* %u1190)
	%u1192 = load %struct.tnode*, %struct.tnode** %_P_root
	%u1193 = getelementptr %struct.tnode, %struct.tnode* %u1192, i1 0, i32 2
	%u1194 = load %struct.tnode*, %struct.tnode** %u1193
	%u1195 = call %struct.node* @postOrder(%struct.tnode* %u1194)
	%u1196 = call %struct.node* @concatLists(%struct.node* %u1191, %struct.node* %u1195)
	%u1197 = load %struct.node*, %struct.node** %temp
	%u1198 = call %struct.node* @concatLists(%struct.node* %u1196, %struct.node* %u1197)
	store %struct.node* %u1198, %struct.node** %_retval_
	br label %LU34
LU37:
	store %struct.node* null, %struct.node** %_retval_
	br label %LU34
LU34:
	%u1199 = load %struct.node*, %struct.node** %_retval_
	ret %struct.node* %u1199
}

define %struct.tnode* @treeadd(%struct.tnode* %root, i32 %toAdd)
{
LU39:
	%_P_root = alloca %struct.tnode*
	%_P_toAdd = alloca i32
	%_retval_ = alloca %struct.tnode*
	%temp = alloca %struct.tnode*
	store %struct.tnode* %root, %struct.tnode** %_P_root
	store i32 %toAdd, i32* %_P_toAdd
	%u1200 = load %struct.tnode*, %struct.tnode** %_P_root
	%u1201 = icmp eq %struct.tnode* %u1200, null
	br i1 %u1201, label %LU40, label %LU41
LU40:
	%u1202 = call i8* @malloc(i32 12)
	%u1203 = bitcast i8* %u1202 to %struct.tnode*
	store %struct.tnode* %u1203, %struct.tnode** %temp
	%u1204 = load i32, i32* %_P_toAdd
	%u1205 = load %struct.tnode*, %struct.tnode** %temp
	%u1206 = getelementptr %struct.tnode, %struct.tnode* %u1205, i1 0, i32 0
	store i32 %u1204, i32* %u1206
	%u1207 = load %struct.tnode*, %struct.tnode** %temp
	%u1208 = getelementptr %struct.tnode, %struct.tnode* %u1207, i1 0, i32 1
	store %struct.tnode* null, %struct.tnode** %u1208
	%u1209 = load %struct.tnode*, %struct.tnode** %temp
	%u1210 = getelementptr %struct.tnode, %struct.tnode* %u1209, i1 0, i32 2
	store %struct.tnode* null, %struct.tnode** %u1210
	%u1211 = load %struct.tnode*, %struct.tnode** %temp
	store %struct.tnode* %u1211, %struct.tnode** %_retval_
	br label %LU38
LU41:
	%u1212 = load i32, i32* %_P_toAdd
	%u1213 = load %struct.tnode*, %struct.tnode** %_P_root
	%u1214 = getelementptr %struct.tnode, %struct.tnode* %u1213, i1 0, i32 0
	%u1215 = load i32, i32* %u1214
	%u1216 = icmp slt i32 %u1212, %u1215
	br i1 %u1216, label %LU42, label %LU43
LU42:
	%u1217 = load %struct.tnode*, %struct.tnode** %_P_root
	%u1218 = getelementptr %struct.tnode, %struct.tnode* %u1217, i1 0, i32 1
	%u1219 = load %struct.tnode*, %struct.tnode** %u1218
	%u1220 = load i32, i32* %_P_toAdd
	%u1221 = call %struct.tnode* @treeadd(%struct.tnode* %u1219, i32 %u1220)
	%u1222 = load %struct.tnode*, %struct.tnode** %_P_root
	%u1223 = getelementptr %struct.tnode, %struct.tnode* %u1222, i1 0, i32 1
	store %struct.tnode* %u1221, %struct.tnode** %u1223
	br label %LU44
LU43:
	%u1224 = load %struct.tnode*, %struct.tnode** %_P_root
	%u1225 = getelementptr %struct.tnode, %struct.tnode* %u1224, i1 0, i32 2
	%u1226 = load %struct.tnode*, %struct.tnode** %u1225
	%u1227 = load i32, i32* %_P_toAdd
	%u1228 = call %struct.tnode* @treeadd(%struct.tnode* %u1226, i32 %u1227)
	%u1229 = load %struct.tnode*, %struct.tnode** %_P_root
	%u1230 = getelementptr %struct.tnode, %struct.tnode* %u1229, i1 0, i32 2
	store %struct.tnode* %u1228, %struct.tnode** %u1230
	br label %LU44
LU44:
	%u1231 = load %struct.tnode*, %struct.tnode** %_P_root
	store %struct.tnode* %u1231, %struct.tnode** %_retval_
	br label %LU38
LU38:
	%u1232 = load %struct.tnode*, %struct.tnode** %_retval_
	ret %struct.tnode* %u1232
}

define %struct.node* @quickSort(%struct.node* %list)
{
LU46:
	%_P_list = alloca %struct.node*
	%_retval_ = alloca %struct.node*
	%pivot = alloca i32
	%i = alloca i32
	%less = alloca %struct.node*
	%greater = alloca %struct.node*
	%temp = alloca %struct.node*
	store %struct.node* %list, %struct.node** %_P_list
	store %struct.node* null, %struct.node** %less
	store %struct.node* null, %struct.node** %greater
	%u1233 = load %struct.node*, %struct.node** %_P_list
	%u1234 = call i32 @size(%struct.node* %u1233)
	%u1235 = icmp sle i32 %u1234, 1
	br i1 %u1235, label %LU47, label %LU48
LU47:
	%u1236 = load %struct.node*, %struct.node** %_P_list
	store %struct.node* %u1236, %struct.node** %_retval_
	br label %LU45
LU48:
	%u1237 = load %struct.node*, %struct.node** %_P_list
	%u1238 = call i32 @get(%struct.node* %u1237, i32 0)
	%u1239 = load %struct.node*, %struct.node** %_P_list
	%u1240 = load %struct.node*, %struct.node** %_P_list
	%u1241 = call i32 @size(%struct.node* %u1240)
	%u1242 = sub i32 %u1241, 1
	%u1243 = call i32 @get(%struct.node* %u1239, i32 %u1242)
	%u1244 = add i32 %u1238, %u1243
	%u1245 = sdiv i32 %u1244, 2
	store i32 %u1245, i32* %pivot
	%u1246 = load %struct.node*, %struct.node** %_P_list
	store %struct.node* %u1246, %struct.node** %temp
	store i32 0, i32* %i
	%u1247 = load %struct.node*, %struct.node** %temp
	%u1248 = icmp ne %struct.node* %u1247, null
	br i1 %u1248, label %LU49, label %LU50
LU49:
	%u1249 = load %struct.node*, %struct.node** %_P_list
	%u1250 = load i32, i32* %i
	%u1251 = call i32 @get(%struct.node* %u1249, i32 %u1250)
	%u1252 = load i32, i32* %pivot
	%u1253 = icmp sgt i32 %u1251, %u1252
	br i1 %u1253, label %LU51, label %LU52
LU51:
	%u1254 = load %struct.node*, %struct.node** %greater
	%u1255 = load %struct.node*, %struct.node** %_P_list
	%u1256 = load i32, i32* %i
	%u1257 = call i32 @get(%struct.node* %u1255, i32 %u1256)
	%u1258 = call %struct.node* @add(%struct.node* %u1254, i32 %u1257)
	store %struct.node* %u1258, %struct.node** %greater
	br label %LU53
LU52:
	%u1259 = load %struct.node*, %struct.node** %less
	%u1260 = load %struct.node*, %struct.node** %_P_list
	%u1261 = load i32, i32* %i
	%u1262 = call i32 @get(%struct.node* %u1260, i32 %u1261)
	%u1263 = call %struct.node* @add(%struct.node* %u1259, i32 %u1262)
	store %struct.node* %u1263, %struct.node** %less
	br label %LU53
LU53:
	%u1264 = load %struct.node*, %struct.node** %temp
	%u1265 = getelementptr %struct.node, %struct.node* %u1264, i1 0, i32 1
	%u1266 = load %struct.node*, %struct.node** %u1265
	store %struct.node* %u1266, %struct.node** %temp
	%u1267 = load i32, i32* %i
	%u1268 = add i32 %u1267, 1
	store i32 %u1268, i32* %i
	%u1269 = load %struct.node*, %struct.node** %temp
	%u1270 = icmp ne %struct.node* %u1269, null
	br i1 %u1270, label %LU49, label %LU50
LU50:
	%u1271 = load %struct.node*, %struct.node** %_P_list
	call void @freeList(%struct.node* %u1271)
	%u1272 = load %struct.node*, %struct.node** %less
	%u1273 = call %struct.node* @quickSort(%struct.node* %u1272)
	%u1274 = load %struct.node*, %struct.node** %greater
	%u1275 = call %struct.node* @quickSort(%struct.node* %u1274)
	%u1276 = call %struct.node* @concatLists(%struct.node* %u1273, %struct.node* %u1275)
	store %struct.node* %u1276, %struct.node** %_retval_
	br label %LU45
LU45:
	%u1277 = load %struct.node*, %struct.node** %_retval_
	ret %struct.node* %u1277
}

define %struct.node* @quickSortMain(%struct.node* %list)
{
LU55:
	%_P_list = alloca %struct.node*
	%_retval_ = alloca %struct.node*
	store %struct.node* %list, %struct.node** %_P_list
	%u1278 = load %struct.node*, %struct.node** %_P_list
	call void @printList(%struct.node* %u1278)
	%u1279 = sub i32 0, 999
	call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([6 x i8], [6 x i8]* @.println, i32 0, i32 0), i32 %u1279)
	%u1280 = load %struct.node*, %struct.node** %_P_list
	call void @printList(%struct.node* %u1280)
	%u1281 = sub i32 0, 999
	call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([6 x i8], [6 x i8]* @.println, i32 0, i32 0), i32 %u1281)
	%u1282 = load %struct.node*, %struct.node** %_P_list
	call void @printList(%struct.node* %u1282)
	%u1283 = sub i32 0, 999
	call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([6 x i8], [6 x i8]* @.println, i32 0, i32 0), i32 %u1283)
	store %struct.node* null, %struct.node** %_retval_
	br label %LU54
LU54:
	%u1284 = load %struct.node*, %struct.node** %_retval_
	ret %struct.node* %u1284
}

define i32 @treesearch(%struct.tnode* %root, i32 %target)
{
LU57:
	%_P_root = alloca %struct.tnode*
	%_P_target = alloca i32
	%_retval_ = alloca i32
	store %struct.tnode* %root, %struct.tnode** %_P_root
	store i32 %target, i32* %_P_target
	%u1285 = sub i32 0, 1
	call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([6 x i8], [6 x i8]* @.println, i32 0, i32 0), i32 %u1285)
	%u1286 = load %struct.tnode*, %struct.tnode** %_P_root
	%u1287 = icmp ne %struct.tnode* %u1286, null
	br i1 %u1287, label %LU58, label %LU59
LU58:
	%u1288 = load %struct.tnode*, %struct.tnode** %_P_root
	%u1289 = getelementptr %struct.tnode, %struct.tnode* %u1288, i1 0, i32 0
	%u1290 = load i32, i32* %u1289
	%u1291 = load i32, i32* %_P_target
	%u1292 = icmp eq i32 %u1290, %u1291
	br i1 %u1292, label %LU60, label %LU61
LU60:
	store i32 1, i32* %_retval_
	br label %LU56
LU61:
	%u1293 = load %struct.tnode*, %struct.tnode** %_P_root
	%u1294 = getelementptr %struct.tnode, %struct.tnode* %u1293, i1 0, i32 1
	%u1295 = load %struct.tnode*, %struct.tnode** %u1294
	%u1296 = load i32, i32* %_P_target
	%u1297 = call i32 @treesearch(%struct.tnode* %u1295, i32 %u1296)
	%u1298 = icmp eq i32 %u1297, 1
	br i1 %u1298, label %LU62, label %LU63
LU62:
	store i32 1, i32* %_retval_
	br label %LU56
LU63:
	%u1299 = load %struct.tnode*, %struct.tnode** %_P_root
	%u1300 = getelementptr %struct.tnode, %struct.tnode* %u1299, i1 0, i32 2
	%u1301 = load %struct.tnode*, %struct.tnode** %u1300
	%u1302 = load i32, i32* %_P_target
	%u1303 = call i32 @treesearch(%struct.tnode* %u1301, i32 %u1302)
	%u1304 = icmp eq i32 %u1303, 1
	br i1 %u1304, label %LU64, label %LU65
LU64:
	store i32 1, i32* %_retval_
	br label %LU56
LU65:
	store i32 0, i32* %_retval_
	br label %LU56
LU66:
	br label %LU59
LU59:
	store i32 0, i32* %_retval_
	br label %LU56
LU56:
	%u1305 = load i32, i32* %_retval_
	ret i32 %u1305
}

define %struct.node* @inOrder(%struct.tnode* %root)
{
LU68:
	%_P_root = alloca %struct.tnode*
	%_retval_ = alloca %struct.node*
	%temp = alloca %struct.node*
	store %struct.tnode* %root, %struct.tnode** %_P_root
	%u1306 = load %struct.tnode*, %struct.tnode** %_P_root
	%u1307 = icmp ne %struct.tnode* %u1306, null
	br i1 %u1307, label %LU69, label %LU70
LU69:
	%u1308 = call i8* @malloc(i32 8)
	%u1309 = bitcast i8* %u1308 to %struct.node*
	store %struct.node* %u1309, %struct.node** %temp
	%u1310 = load %struct.tnode*, %struct.tnode** %_P_root
	%u1311 = getelementptr %struct.tnode, %struct.tnode* %u1310, i1 0, i32 0
	%u1312 = load i32, i32* %u1311
	%u1313 = load %struct.node*, %struct.node** %temp
	%u1314 = getelementptr %struct.node, %struct.node* %u1313, i1 0, i32 0
	store i32 %u1312, i32* %u1314
	%u1315 = load %struct.node*, %struct.node** %temp
	%u1316 = getelementptr %struct.node, %struct.node* %u1315, i1 0, i32 1
	store %struct.node* null, %struct.node** %u1316
	%u1317 = load %struct.tnode*, %struct.tnode** %_P_root
	%u1318 = getelementptr %struct.tnode, %struct.tnode* %u1317, i1 0, i32 1
	%u1319 = load %struct.tnode*, %struct.tnode** %u1318
	%u1320 = call %struct.node* @inOrder(%struct.tnode* %u1319)
	%u1321 = load %struct.node*, %struct.node** %temp
	%u1322 = load %struct.tnode*, %struct.tnode** %_P_root
	%u1323 = getelementptr %struct.tnode, %struct.tnode* %u1322, i1 0, i32 2
	%u1324 = load %struct.tnode*, %struct.tnode** %u1323
	%u1325 = call %struct.node* @inOrder(%struct.tnode* %u1324)
	%u1326 = call %struct.node* @concatLists(%struct.node* %u1321, %struct.node* %u1325)
	%u1327 = call %struct.node* @concatLists(%struct.node* %u1320, %struct.node* %u1326)
	store %struct.node* %u1327, %struct.node** %_retval_
	br label %LU67
LU70:
	store %struct.node* null, %struct.node** %_retval_
	br label %LU67
LU71:
	br label %LU67
LU67:
	%u1328 = load %struct.node*, %struct.node** %_retval_
	ret %struct.node* %u1328
}

define i32 @bintreesearch(%struct.tnode* %root, i32 %target)
{
LU73:
	%_P_root = alloca %struct.tnode*
	%_P_target = alloca i32
	%_retval_ = alloca i32
	store %struct.tnode* %root, %struct.tnode** %_P_root
	store i32 %target, i32* %_P_target
	%u1329 = sub i32 0, 1
	call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([6 x i8], [6 x i8]* @.println, i32 0, i32 0), i32 %u1329)
	%u1330 = load %struct.tnode*, %struct.tnode** %_P_root
	%u1331 = icmp ne %struct.tnode* %u1330, null
	br i1 %u1331, label %LU74, label %LU75
LU74:
	%u1332 = load %struct.tnode*, %struct.tnode** %_P_root
	%u1333 = getelementptr %struct.tnode, %struct.tnode* %u1332, i1 0, i32 0
	%u1334 = load i32, i32* %u1333
	%u1335 = load i32, i32* %_P_target
	%u1336 = icmp eq i32 %u1334, %u1335
	br i1 %u1336, label %LU76, label %LU77
LU76:
	store i32 1, i32* %_retval_
	br label %LU72
LU77:
	%u1337 = load i32, i32* %_P_target
	%u1338 = load %struct.tnode*, %struct.tnode** %_P_root
	%u1339 = getelementptr %struct.tnode, %struct.tnode* %u1338, i1 0, i32 0
	%u1340 = load i32, i32* %u1339
	%u1341 = icmp slt i32 %u1337, %u1340
	br i1 %u1341, label %LU78, label %LU79
LU78:
	%u1342 = load %struct.tnode*, %struct.tnode** %_P_root
	%u1343 = getelementptr %struct.tnode, %struct.tnode* %u1342, i1 0, i32 1
	%u1344 = load %struct.tnode*, %struct.tnode** %u1343
	%u1345 = load i32, i32* %_P_target
	%u1346 = call i32 @bintreesearch(%struct.tnode* %u1344, i32 %u1345)
	store i32 %u1346, i32* %_retval_
	br label %LU72
LU79:
	%u1347 = load %struct.tnode*, %struct.tnode** %_P_root
	%u1348 = getelementptr %struct.tnode, %struct.tnode* %u1347, i1 0, i32 2
	%u1349 = load %struct.tnode*, %struct.tnode** %u1348
	%u1350 = load i32, i32* %_P_target
	%u1351 = call i32 @bintreesearch(%struct.tnode* %u1349, i32 %u1350)
	store i32 %u1351, i32* %_retval_
	br label %LU72
LU80:
	br label %LU75
LU75:
	store i32 0, i32* %_retval_
	br label %LU72
LU72:
	%u1352 = load i32, i32* %_retval_
	ret i32 %u1352
}

define %struct.tnode* @buildTree(%struct.node* %list)
{
LU82:
	%_P_list = alloca %struct.node*
	%_retval_ = alloca %struct.tnode*
	%i = alloca i32
	%root = alloca %struct.tnode*
	store %struct.node* %list, %struct.node** %_P_list
	store %struct.tnode* null, %struct.tnode** %root
	store i32 0, i32* %i
	%u1353 = load i32, i32* %i
	%u1354 = load %struct.node*, %struct.node** %_P_list
	%u1355 = call i32 @size(%struct.node* %u1354)
	%u1356 = icmp slt i32 %u1353, %u1355
	br i1 %u1356, label %LU83, label %LU84
LU83:
	%u1357 = load %struct.tnode*, %struct.tnode** %root
	%u1358 = load %struct.node*, %struct.node** %_P_list
	%u1359 = load i32, i32* %i
	%u1360 = call i32 @get(%struct.node* %u1358, i32 %u1359)
	%u1361 = call %struct.tnode* @treeadd(%struct.tnode* %u1357, i32 %u1360)
	store %struct.tnode* %u1361, %struct.tnode** %root
	%u1362 = load i32, i32* %i
	%u1363 = add i32 %u1362, 1
	store i32 %u1363, i32* %i
	%u1364 = load i32, i32* %i
	%u1365 = load %struct.node*, %struct.node** %_P_list
	%u1366 = call i32 @size(%struct.node* %u1365)
	%u1367 = icmp slt i32 %u1364, %u1366
	br i1 %u1367, label %LU83, label %LU84
LU84:
	%u1368 = load %struct.tnode*, %struct.tnode** %root
	store %struct.tnode* %u1368, %struct.tnode** %_retval_
	br label %LU81
LU81:
	%u1369 = load %struct.tnode*, %struct.tnode** %_retval_
	ret %struct.tnode* %u1369
}

define void @treeMain(%struct.node* %list)
{
LU86:
	%_P_list = alloca %struct.node*
	%root = alloca %struct.tnode*
	%inList = alloca %struct.node*
	%postList = alloca %struct.node*
	store %struct.node* %list, %struct.node** %_P_list
	%u1370 = load %struct.node*, %struct.node** %_P_list
	%u1371 = call %struct.tnode* @buildTree(%struct.node* %u1370)
	store %struct.tnode* %u1371, %struct.tnode** %root
	%u1372 = load %struct.tnode*, %struct.tnode** %root
	call void @treeprint(%struct.tnode* %u1372)
	%u1373 = sub i32 0, 999
	call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([6 x i8], [6 x i8]* @.println, i32 0, i32 0), i32 %u1373)
	%u1374 = load %struct.tnode*, %struct.tnode** %root
	%u1375 = call %struct.node* @inOrder(%struct.tnode* %u1374)
	store %struct.node* %u1375, %struct.node** %inList
	%u1376 = load %struct.node*, %struct.node** %inList
	call void @printList(%struct.node* %u1376)
	%u1377 = sub i32 0, 999
	call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([6 x i8], [6 x i8]* @.println, i32 0, i32 0), i32 %u1377)
	%u1378 = load %struct.node*, %struct.node** %inList
	call void @freeList(%struct.node* %u1378)
	%u1379 = load %struct.tnode*, %struct.tnode** %root
	%u1380 = call %struct.node* @postOrder(%struct.tnode* %u1379)
	store %struct.node* %u1380, %struct.node** %postList
	%u1381 = load %struct.node*, %struct.node** %postList
	call void @printList(%struct.node* %u1381)
	%u1382 = sub i32 0, 999
	call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([6 x i8], [6 x i8]* @.println, i32 0, i32 0), i32 %u1382)
	%u1383 = load %struct.node*, %struct.node** %postList
	call void @freeList(%struct.node* %u1383)
	%u1384 = load %struct.tnode*, %struct.tnode** %root
	%u1385 = call i32 @treesearch(%struct.tnode* %u1384, i32 0)
	call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([6 x i8], [6 x i8]* @.println, i32 0, i32 0), i32 %u1385)
	%u1386 = sub i32 0, 999
	call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([6 x i8], [6 x i8]* @.println, i32 0, i32 0), i32 %u1386)
	%u1387 = load %struct.tnode*, %struct.tnode** %root
	%u1388 = call i32 @treesearch(%struct.tnode* %u1387, i32 10)
	call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([6 x i8], [6 x i8]* @.println, i32 0, i32 0), i32 %u1388)
	%u1389 = sub i32 0, 999
	call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([6 x i8], [6 x i8]* @.println, i32 0, i32 0), i32 %u1389)
	%u1390 = load %struct.tnode*, %struct.tnode** %root
	%u1391 = sub i32 0, 2
	%u1392 = call i32 @treesearch(%struct.tnode* %u1390, i32 %u1391)
	call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([6 x i8], [6 x i8]* @.println, i32 0, i32 0), i32 %u1392)
	%u1393 = sub i32 0, 999
	call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([6 x i8], [6 x i8]* @.println, i32 0, i32 0), i32 %u1393)
	%u1394 = load %struct.tnode*, %struct.tnode** %root
	%u1395 = call i32 @treesearch(%struct.tnode* %u1394, i32 2)
	call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([6 x i8], [6 x i8]* @.println, i32 0, i32 0), i32 %u1395)
	%u1396 = sub i32 0, 999
	call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([6 x i8], [6 x i8]* @.println, i32 0, i32 0), i32 %u1396)
	%u1397 = load %struct.tnode*, %struct.tnode** %root
	%u1398 = call i32 @treesearch(%struct.tnode* %u1397, i32 3)
	call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([6 x i8], [6 x i8]* @.println, i32 0, i32 0), i32 %u1398)
	%u1399 = sub i32 0, 999
	call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([6 x i8], [6 x i8]* @.println, i32 0, i32 0), i32 %u1399)
	%u1400 = load %struct.tnode*, %struct.tnode** %root
	%u1401 = call i32 @treesearch(%struct.tnode* %u1400, i32 9)
	call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([6 x i8], [6 x i8]* @.println, i32 0, i32 0), i32 %u1401)
	%u1402 = sub i32 0, 999
	call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([6 x i8], [6 x i8]* @.println, i32 0, i32 0), i32 %u1402)
	%u1403 = load %struct.tnode*, %struct.tnode** %root
	%u1404 = call i32 @treesearch(%struct.tnode* %u1403, i32 1)
	call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([6 x i8], [6 x i8]* @.println, i32 0, i32 0), i32 %u1404)
	%u1405 = sub i32 0, 999
	call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([6 x i8], [6 x i8]* @.println, i32 0, i32 0), i32 %u1405)
	%u1406 = load %struct.tnode*, %struct.tnode** %root
	%u1407 = call i32 @bintreesearch(%struct.tnode* %u1406, i32 0)
	call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([6 x i8], [6 x i8]* @.println, i32 0, i32 0), i32 %u1407)
	%u1408 = sub i32 0, 999
	call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([6 x i8], [6 x i8]* @.println, i32 0, i32 0), i32 %u1408)
	%u1409 = load %struct.tnode*, %struct.tnode** %root
	%u1410 = call i32 @bintreesearch(%struct.tnode* %u1409, i32 10)
	call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([6 x i8], [6 x i8]* @.println, i32 0, i32 0), i32 %u1410)
	%u1411 = sub i32 0, 999
	call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([6 x i8], [6 x i8]* @.println, i32 0, i32 0), i32 %u1411)
	%u1412 = load %struct.tnode*, %struct.tnode** %root
	%u1413 = sub i32 0, 2
	%u1414 = call i32 @bintreesearch(%struct.tnode* %u1412, i32 %u1413)
	call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([6 x i8], [6 x i8]* @.println, i32 0, i32 0), i32 %u1414)
	%u1415 = sub i32 0, 999
	call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([6 x i8], [6 x i8]* @.println, i32 0, i32 0), i32 %u1415)
	%u1416 = load %struct.tnode*, %struct.tnode** %root
	%u1417 = call i32 @bintreesearch(%struct.tnode* %u1416, i32 2)
	call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([6 x i8], [6 x i8]* @.println, i32 0, i32 0), i32 %u1417)
	%u1418 = sub i32 0, 999
	call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([6 x i8], [6 x i8]* @.println, i32 0, i32 0), i32 %u1418)
	%u1419 = load %struct.tnode*, %struct.tnode** %root
	%u1420 = call i32 @bintreesearch(%struct.tnode* %u1419, i32 3)
	call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([6 x i8], [6 x i8]* @.println, i32 0, i32 0), i32 %u1420)
	%u1421 = sub i32 0, 999
	call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([6 x i8], [6 x i8]* @.println, i32 0, i32 0), i32 %u1421)
	%u1422 = load %struct.tnode*, %struct.tnode** %root
	%u1423 = call i32 @bintreesearch(%struct.tnode* %u1422, i32 9)
	call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([6 x i8], [6 x i8]* @.println, i32 0, i32 0), i32 %u1423)
	%u1424 = sub i32 0, 999
	call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([6 x i8], [6 x i8]* @.println, i32 0, i32 0), i32 %u1424)
	%u1425 = load %struct.tnode*, %struct.tnode** %root
	%u1426 = call i32 @bintreesearch(%struct.tnode* %u1425, i32 1)
	call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([6 x i8], [6 x i8]* @.println, i32 0, i32 0), i32 %u1426)
	%u1427 = sub i32 0, 999
	call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([6 x i8], [6 x i8]* @.println, i32 0, i32 0), i32 %u1427)
	%u1428 = load %struct.tnode*, %struct.tnode** %root
	call void @freeTree(%struct.tnode* %u1428)
	br label %LU85
LU85:
	ret void
}

define %struct.node* @myCopy(%struct.node* %src)
{
LU88:
	%_P_src = alloca %struct.node*
	%_retval_ = alloca %struct.node*
	store %struct.node* %src, %struct.node** %_P_src
	%u1429 = load %struct.node*, %struct.node** %_P_src
	%u1430 = icmp eq %struct.node* %u1429, null
	br i1 %u1430, label %LU89, label %LU90
LU89:
	store %struct.node* null, %struct.node** %_retval_
	br label %LU87
LU90:
	%u1431 = load %struct.node*, %struct.node** %_P_src
	%u1432 = getelementptr %struct.node, %struct.node* %u1431, i1 0, i32 0
	%u1433 = load i32, i32* %u1432
	%u1434 = call %struct.node* @add(%struct.node* null, i32 %u1433)
	%u1435 = load %struct.node*, %struct.node** %_P_src
	%u1436 = getelementptr %struct.node, %struct.node* %u1435, i1 0, i32 1
	%u1437 = load %struct.node*, %struct.node** %u1436
	%u1438 = call %struct.node* @myCopy(%struct.node* %u1437)
	%u1439 = call %struct.node* @concatLists(%struct.node* %u1434, %struct.node* %u1438)
	store %struct.node* %u1439, %struct.node** %_retval_
	br label %LU87
LU87:
	%u1440 = load %struct.node*, %struct.node** %_retval_
	ret %struct.node* %u1440
}

define i32 @main()
{
LU92:
	%_retval_ = alloca i32
	%i = alloca i32
	%element = alloca i32
	%myList = alloca %struct.node*
	%copyList1 = alloca %struct.node*
	%copyList2 = alloca %struct.node*
	%sortedList = alloca %struct.node*
	store %struct.node* null, %struct.node** %myList
	store %struct.node* null, %struct.node** %copyList1
	store %struct.node* null, %struct.node** %copyList2
	store i32 0, i32* %i
	%u1441 = load i32, i32* %i
	%u1442 = icmp slt i32 %u1441, 10
	br i1 %u1442, label %LU93, label %LU94
LU93:
	call i32 (i8*, ...) @scanf(i8* getelementptr inbounds ([5 x i8], [5 x i8]* @.read, i32 0, i32 0), i32* %element)
	%u1443 = load %struct.node*, %struct.node** %myList
	%u1444 = load i32, i32* %element
	%u1445 = call %struct.node* @add(%struct.node* %u1443, i32 %u1444)
	store %struct.node* %u1445, %struct.node** %myList
	%u1446 = load %struct.node*, %struct.node** %myList
	%u1447 = call %struct.node* @myCopy(%struct.node* %u1446)
	store %struct.node* %u1447, %struct.node** %copyList1
	%u1448 = load %struct.node*, %struct.node** %myList
	%u1449 = call %struct.node* @myCopy(%struct.node* %u1448)
	store %struct.node* %u1449, %struct.node** %copyList2
	%u1450 = load %struct.node*, %struct.node** %copyList1
	%u1451 = call %struct.node* @quickSortMain(%struct.node* %u1450)
	store %struct.node* %u1451, %struct.node** %sortedList
	%u1452 = load %struct.node*, %struct.node** %sortedList
	call void @freeList(%struct.node* %u1452)
	%u1453 = load %struct.node*, %struct.node** %copyList2
	call void @treeMain(%struct.node* %u1453)
	%u1454 = load i32, i32* %i
	%u1455 = add i32 %u1454, 1
	store i32 %u1455, i32* %i
	%u1456 = load i32, i32* %i
	%u1457 = icmp slt i32 %u1456, 10
	br i1 %u1457, label %LU93, label %LU94
LU94:
	%u1458 = load %struct.node*, %struct.node** %myList
	call void @freeList(%struct.node* %u1458)
	%u1459 = load %struct.node*, %struct.node** %copyList1
	call void @freeList(%struct.node* %u1459)
	%u1460 = load %struct.node*, %struct.node** %copyList2
	call void @freeList(%struct.node* %u1460)
	store i32 0, i32* %_retval_
	br label %LU91
LU91:
	%u1461 = load i32, i32* %_retval_
	ret i32 %u1461
}
declare i8* @malloc(i32)
declare void @free(i8*)
declare i32 @printf(i8*, ...)
declare i32 @scanf(i8*, ...)
@.println = private unnamed_addr constant [6 x i8] c"%ld\0A\00\00", align 1
@.print = private unnamed_addr constant [6 x i8] c"%ld \00\00", align 1
@.read = private unnamed_addr constant [5 x i8] c"%ld\00\00", align 1
@.read_scratch = common global i32 0, align 4
