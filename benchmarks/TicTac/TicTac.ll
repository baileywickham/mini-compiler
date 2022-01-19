target triple="i686"
%struct.gameBoard = type {i32, i32, i32, i32, i32, i32, i32, i32, i32}



define void @cleanBoard(%struct.gameBoard* %board)
{
LU1:
	%_P_board = alloca %struct.gameBoard*
	store %struct.gameBoard* %board, %struct.gameBoard** %_P_board
	%u817 = load %struct.gameBoard*, %struct.gameBoard** %_P_board
	%u818 = getelementptr %struct.gameBoard, %struct.gameBoard* %u817, i1 0, i32 0
	store i32 0, i32* %u818
	%u819 = load %struct.gameBoard*, %struct.gameBoard** %_P_board
	%u820 = getelementptr %struct.gameBoard, %struct.gameBoard* %u819, i1 0, i32 1
	store i32 0, i32* %u820
	%u821 = load %struct.gameBoard*, %struct.gameBoard** %_P_board
	%u822 = getelementptr %struct.gameBoard, %struct.gameBoard* %u821, i1 0, i32 2
	store i32 0, i32* %u822
	%u823 = load %struct.gameBoard*, %struct.gameBoard** %_P_board
	%u824 = getelementptr %struct.gameBoard, %struct.gameBoard* %u823, i1 0, i32 3
	store i32 0, i32* %u824
	%u825 = load %struct.gameBoard*, %struct.gameBoard** %_P_board
	%u826 = getelementptr %struct.gameBoard, %struct.gameBoard* %u825, i1 0, i32 4
	store i32 0, i32* %u826
	%u827 = load %struct.gameBoard*, %struct.gameBoard** %_P_board
	%u828 = getelementptr %struct.gameBoard, %struct.gameBoard* %u827, i1 0, i32 5
	store i32 0, i32* %u828
	%u829 = load %struct.gameBoard*, %struct.gameBoard** %_P_board
	%u830 = getelementptr %struct.gameBoard, %struct.gameBoard* %u829, i1 0, i32 6
	store i32 0, i32* %u830
	%u831 = load %struct.gameBoard*, %struct.gameBoard** %_P_board
	%u832 = getelementptr %struct.gameBoard, %struct.gameBoard* %u831, i1 0, i32 7
	store i32 0, i32* %u832
	%u833 = load %struct.gameBoard*, %struct.gameBoard** %_P_board
	%u834 = getelementptr %struct.gameBoard, %struct.gameBoard* %u833, i1 0, i32 8
	store i32 0, i32* %u834
	br label %LU0
LU0:
	ret void
}

define void @printBoard(%struct.gameBoard* %board)
{
LU3:
	%_P_board = alloca %struct.gameBoard*
	store %struct.gameBoard* %board, %struct.gameBoard** %_P_board
	%u835 = load %struct.gameBoard*, %struct.gameBoard** %_P_board
	%u836 = getelementptr %struct.gameBoard, %struct.gameBoard* %u835, i1 0, i32 0
	%u837 = load i32, i32* %u836
	call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([6 x i8], [6 x i8]* @.print, i32 0, i32 0), i32 %u837)
	%u838 = load %struct.gameBoard*, %struct.gameBoard** %_P_board
	%u839 = getelementptr %struct.gameBoard, %struct.gameBoard* %u838, i1 0, i32 1
	%u840 = load i32, i32* %u839
	call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([6 x i8], [6 x i8]* @.print, i32 0, i32 0), i32 %u840)
	%u841 = load %struct.gameBoard*, %struct.gameBoard** %_P_board
	%u842 = getelementptr %struct.gameBoard, %struct.gameBoard* %u841, i1 0, i32 2
	%u843 = load i32, i32* %u842
	call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([6 x i8], [6 x i8]* @.println, i32 0, i32 0), i32 %u843)
	%u844 = load %struct.gameBoard*, %struct.gameBoard** %_P_board
	%u845 = getelementptr %struct.gameBoard, %struct.gameBoard* %u844, i1 0, i32 3
	%u846 = load i32, i32* %u845
	call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([6 x i8], [6 x i8]* @.print, i32 0, i32 0), i32 %u846)
	%u847 = load %struct.gameBoard*, %struct.gameBoard** %_P_board
	%u848 = getelementptr %struct.gameBoard, %struct.gameBoard* %u847, i1 0, i32 4
	%u849 = load i32, i32* %u848
	call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([6 x i8], [6 x i8]* @.print, i32 0, i32 0), i32 %u849)
	%u850 = load %struct.gameBoard*, %struct.gameBoard** %_P_board
	%u851 = getelementptr %struct.gameBoard, %struct.gameBoard* %u850, i1 0, i32 5
	%u852 = load i32, i32* %u851
	call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([6 x i8], [6 x i8]* @.println, i32 0, i32 0), i32 %u852)
	%u853 = load %struct.gameBoard*, %struct.gameBoard** %_P_board
	%u854 = getelementptr %struct.gameBoard, %struct.gameBoard* %u853, i1 0, i32 6
	%u855 = load i32, i32* %u854
	call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([6 x i8], [6 x i8]* @.print, i32 0, i32 0), i32 %u855)
	%u856 = load %struct.gameBoard*, %struct.gameBoard** %_P_board
	%u857 = getelementptr %struct.gameBoard, %struct.gameBoard* %u856, i1 0, i32 7
	%u858 = load i32, i32* %u857
	call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([6 x i8], [6 x i8]* @.print, i32 0, i32 0), i32 %u858)
	%u859 = load %struct.gameBoard*, %struct.gameBoard** %_P_board
	%u860 = getelementptr %struct.gameBoard, %struct.gameBoard* %u859, i1 0, i32 8
	%u861 = load i32, i32* %u860
	call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([6 x i8], [6 x i8]* @.println, i32 0, i32 0), i32 %u861)
	br label %LU2
LU2:
	ret void
}

define void @printMoveBoard()
{
LU5:
	call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([6 x i8], [6 x i8]* @.println, i32 0, i32 0), i32 123)
	call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([6 x i8], [6 x i8]* @.println, i32 0, i32 0), i32 456)
	call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([6 x i8], [6 x i8]* @.println, i32 0, i32 0), i32 789)
	br label %LU4
LU4:
	ret void
}

define void @placePiece(%struct.gameBoard* %board, i32 %turn, i32 %placement)
{
LU7:
	%_P_board = alloca %struct.gameBoard*
	%_P_turn = alloca i32
	%_P_placement = alloca i32
	store %struct.gameBoard* %board, %struct.gameBoard** %_P_board
	store i32 %turn, i32* %_P_turn
	store i32 %placement, i32* %_P_placement
	%u862 = load i32, i32* %_P_placement
	%u863 = icmp eq i32 %u862, 1
	br i1 %u863, label %LU8, label %LU9
LU8:
	%u864 = load i32, i32* %_P_turn
	%u865 = load %struct.gameBoard*, %struct.gameBoard** %_P_board
	%u866 = getelementptr %struct.gameBoard, %struct.gameBoard* %u865, i1 0, i32 0
	store i32 %u864, i32* %u866
	br label %LU10
LU9:
	%u867 = load i32, i32* %_P_placement
	%u868 = icmp eq i32 %u867, 2
	br i1 %u868, label %LU11, label %LU12
LU11:
	%u869 = load i32, i32* %_P_turn
	%u870 = load %struct.gameBoard*, %struct.gameBoard** %_P_board
	%u871 = getelementptr %struct.gameBoard, %struct.gameBoard* %u870, i1 0, i32 1
	store i32 %u869, i32* %u871
	br label %LU13
LU12:
	%u872 = load i32, i32* %_P_placement
	%u873 = icmp eq i32 %u872, 3
	br i1 %u873, label %LU14, label %LU15
LU14:
	%u874 = load i32, i32* %_P_turn
	%u875 = load %struct.gameBoard*, %struct.gameBoard** %_P_board
	%u876 = getelementptr %struct.gameBoard, %struct.gameBoard* %u875, i1 0, i32 2
	store i32 %u874, i32* %u876
	br label %LU16
LU15:
	%u877 = load i32, i32* %_P_placement
	%u878 = icmp eq i32 %u877, 4
	br i1 %u878, label %LU17, label %LU18
LU17:
	%u879 = load i32, i32* %_P_turn
	%u880 = load %struct.gameBoard*, %struct.gameBoard** %_P_board
	%u881 = getelementptr %struct.gameBoard, %struct.gameBoard* %u880, i1 0, i32 3
	store i32 %u879, i32* %u881
	br label %LU19
LU18:
	%u882 = load i32, i32* %_P_placement
	%u883 = icmp eq i32 %u882, 5
	br i1 %u883, label %LU20, label %LU21
LU20:
	%u884 = load i32, i32* %_P_turn
	%u885 = load %struct.gameBoard*, %struct.gameBoard** %_P_board
	%u886 = getelementptr %struct.gameBoard, %struct.gameBoard* %u885, i1 0, i32 4
	store i32 %u884, i32* %u886
	br label %LU22
LU21:
	%u887 = load i32, i32* %_P_placement
	%u888 = icmp eq i32 %u887, 6
	br i1 %u888, label %LU23, label %LU24
LU23:
	%u889 = load i32, i32* %_P_turn
	%u890 = load %struct.gameBoard*, %struct.gameBoard** %_P_board
	%u891 = getelementptr %struct.gameBoard, %struct.gameBoard* %u890, i1 0, i32 5
	store i32 %u889, i32* %u891
	br label %LU25
LU24:
	%u892 = load i32, i32* %_P_placement
	%u893 = icmp eq i32 %u892, 7
	br i1 %u893, label %LU26, label %LU27
LU26:
	%u894 = load i32, i32* %_P_turn
	%u895 = load %struct.gameBoard*, %struct.gameBoard** %_P_board
	%u896 = getelementptr %struct.gameBoard, %struct.gameBoard* %u895, i1 0, i32 6
	store i32 %u894, i32* %u896
	br label %LU28
LU27:
	%u897 = load i32, i32* %_P_placement
	%u898 = icmp eq i32 %u897, 8
	br i1 %u898, label %LU29, label %LU30
LU29:
	%u899 = load i32, i32* %_P_turn
	%u900 = load %struct.gameBoard*, %struct.gameBoard** %_P_board
	%u901 = getelementptr %struct.gameBoard, %struct.gameBoard* %u900, i1 0, i32 7
	store i32 %u899, i32* %u901
	br label %LU31
LU30:
	%u902 = load i32, i32* %_P_placement
	%u903 = icmp eq i32 %u902, 9
	br i1 %u903, label %LU32, label %LU33
LU32:
	%u904 = load i32, i32* %_P_turn
	%u905 = load %struct.gameBoard*, %struct.gameBoard** %_P_board
	%u906 = getelementptr %struct.gameBoard, %struct.gameBoard* %u905, i1 0, i32 8
	store i32 %u904, i32* %u906
	br label %LU33
LU33:
	br label %LU31
LU31:
	br label %LU28
LU28:
	br label %LU25
LU25:
	br label %LU22
LU22:
	br label %LU19
LU19:
	br label %LU16
LU16:
	br label %LU13
LU13:
	br label %LU10
LU10:
	br label %LU6
LU6:
	ret void
}

define i32 @checkWinner(%struct.gameBoard* %board)
{
LU35:
	%_P_board = alloca %struct.gameBoard*
	%_retval_ = alloca i32
	store %struct.gameBoard* %board, %struct.gameBoard** %_P_board
	%u907 = load %struct.gameBoard*, %struct.gameBoard** %_P_board
	%u908 = getelementptr %struct.gameBoard, %struct.gameBoard* %u907, i1 0, i32 0
	%u909 = load i32, i32* %u908
	%u910 = icmp eq i32 %u909, 1
	br i1 %u910, label %LU36, label %LU37
LU36:
	%u911 = load %struct.gameBoard*, %struct.gameBoard** %_P_board
	%u912 = getelementptr %struct.gameBoard, %struct.gameBoard* %u911, i1 0, i32 1
	%u913 = load i32, i32* %u912
	%u914 = icmp eq i32 %u913, 1
	br i1 %u914, label %LU104, label %LU105
LU104:
	%u915 = load %struct.gameBoard*, %struct.gameBoard** %_P_board
	%u916 = getelementptr %struct.gameBoard, %struct.gameBoard* %u915, i1 0, i32 2
	%u917 = load i32, i32* %u916
	%u918 = icmp eq i32 %u917, 1
	br i1 %u918, label %LU106, label %LU107
LU106:
	store i32 0, i32* %_retval_
	br label %LU34
LU107:
	br label %LU105
LU105:
	br label %LU37
LU37:
	%u919 = load %struct.gameBoard*, %struct.gameBoard** %_P_board
	%u920 = getelementptr %struct.gameBoard, %struct.gameBoard* %u919, i1 0, i32 0
	%u921 = load i32, i32* %u920
	%u922 = icmp eq i32 %u921, 2
	br i1 %u922, label %LU38, label %LU39
LU38:
	%u923 = load %struct.gameBoard*, %struct.gameBoard** %_P_board
	%u924 = getelementptr %struct.gameBoard, %struct.gameBoard* %u923, i1 0, i32 1
	%u925 = load i32, i32* %u924
	%u926 = icmp eq i32 %u925, 2
	br i1 %u926, label %LU100, label %LU101
LU100:
	%u927 = load %struct.gameBoard*, %struct.gameBoard** %_P_board
	%u928 = getelementptr %struct.gameBoard, %struct.gameBoard* %u927, i1 0, i32 2
	%u929 = load i32, i32* %u928
	%u930 = icmp eq i32 %u929, 2
	br i1 %u930, label %LU102, label %LU103
LU102:
	store i32 1, i32* %_retval_
	br label %LU34
LU103:
	br label %LU101
LU101:
	br label %LU39
LU39:
	%u931 = load %struct.gameBoard*, %struct.gameBoard** %_P_board
	%u932 = getelementptr %struct.gameBoard, %struct.gameBoard* %u931, i1 0, i32 3
	%u933 = load i32, i32* %u932
	%u934 = icmp eq i32 %u933, 1
	br i1 %u934, label %LU40, label %LU41
LU40:
	%u935 = load %struct.gameBoard*, %struct.gameBoard** %_P_board
	%u936 = getelementptr %struct.gameBoard, %struct.gameBoard* %u935, i1 0, i32 4
	%u937 = load i32, i32* %u936
	%u938 = icmp eq i32 %u937, 1
	br i1 %u938, label %LU96, label %LU97
LU96:
	%u939 = load %struct.gameBoard*, %struct.gameBoard** %_P_board
	%u940 = getelementptr %struct.gameBoard, %struct.gameBoard* %u939, i1 0, i32 5
	%u941 = load i32, i32* %u940
	%u942 = icmp eq i32 %u941, 1
	br i1 %u942, label %LU98, label %LU99
LU98:
	store i32 0, i32* %_retval_
	br label %LU34
LU99:
	br label %LU97
LU97:
	br label %LU41
LU41:
	%u943 = load %struct.gameBoard*, %struct.gameBoard** %_P_board
	%u944 = getelementptr %struct.gameBoard, %struct.gameBoard* %u943, i1 0, i32 3
	%u945 = load i32, i32* %u944
	%u946 = icmp eq i32 %u945, 2
	br i1 %u946, label %LU42, label %LU43
LU42:
	%u947 = load %struct.gameBoard*, %struct.gameBoard** %_P_board
	%u948 = getelementptr %struct.gameBoard, %struct.gameBoard* %u947, i1 0, i32 4
	%u949 = load i32, i32* %u948
	%u950 = icmp eq i32 %u949, 2
	br i1 %u950, label %LU92, label %LU93
LU92:
	%u951 = load %struct.gameBoard*, %struct.gameBoard** %_P_board
	%u952 = getelementptr %struct.gameBoard, %struct.gameBoard* %u951, i1 0, i32 5
	%u953 = load i32, i32* %u952
	%u954 = icmp eq i32 %u953, 2
	br i1 %u954, label %LU94, label %LU95
LU94:
	store i32 1, i32* %_retval_
	br label %LU34
LU95:
	br label %LU93
LU93:
	br label %LU43
LU43:
	%u955 = load %struct.gameBoard*, %struct.gameBoard** %_P_board
	%u956 = getelementptr %struct.gameBoard, %struct.gameBoard* %u955, i1 0, i32 6
	%u957 = load i32, i32* %u956
	%u958 = icmp eq i32 %u957, 1
	br i1 %u958, label %LU44, label %LU45
LU44:
	%u959 = load %struct.gameBoard*, %struct.gameBoard** %_P_board
	%u960 = getelementptr %struct.gameBoard, %struct.gameBoard* %u959, i1 0, i32 7
	%u961 = load i32, i32* %u960
	%u962 = icmp eq i32 %u961, 1
	br i1 %u962, label %LU88, label %LU89
LU88:
	%u963 = load %struct.gameBoard*, %struct.gameBoard** %_P_board
	%u964 = getelementptr %struct.gameBoard, %struct.gameBoard* %u963, i1 0, i32 8
	%u965 = load i32, i32* %u964
	%u966 = icmp eq i32 %u965, 1
	br i1 %u966, label %LU90, label %LU91
LU90:
	store i32 0, i32* %_retval_
	br label %LU34
LU91:
	br label %LU89
LU89:
	br label %LU45
LU45:
	%u967 = load %struct.gameBoard*, %struct.gameBoard** %_P_board
	%u968 = getelementptr %struct.gameBoard, %struct.gameBoard* %u967, i1 0, i32 6
	%u969 = load i32, i32* %u968
	%u970 = icmp eq i32 %u969, 2
	br i1 %u970, label %LU46, label %LU47
LU46:
	%u971 = load %struct.gameBoard*, %struct.gameBoard** %_P_board
	%u972 = getelementptr %struct.gameBoard, %struct.gameBoard* %u971, i1 0, i32 7
	%u973 = load i32, i32* %u972
	%u974 = icmp eq i32 %u973, 2
	br i1 %u974, label %LU84, label %LU85
LU84:
	%u975 = load %struct.gameBoard*, %struct.gameBoard** %_P_board
	%u976 = getelementptr %struct.gameBoard, %struct.gameBoard* %u975, i1 0, i32 8
	%u977 = load i32, i32* %u976
	%u978 = icmp eq i32 %u977, 2
	br i1 %u978, label %LU86, label %LU87
LU86:
	store i32 1, i32* %_retval_
	br label %LU34
LU87:
	br label %LU85
LU85:
	br label %LU47
LU47:
	%u979 = load %struct.gameBoard*, %struct.gameBoard** %_P_board
	%u980 = getelementptr %struct.gameBoard, %struct.gameBoard* %u979, i1 0, i32 0
	%u981 = load i32, i32* %u980
	%u982 = icmp eq i32 %u981, 1
	br i1 %u982, label %LU48, label %LU49
LU48:
	%u983 = load %struct.gameBoard*, %struct.gameBoard** %_P_board
	%u984 = getelementptr %struct.gameBoard, %struct.gameBoard* %u983, i1 0, i32 3
	%u985 = load i32, i32* %u984
	%u986 = icmp eq i32 %u985, 1
	br i1 %u986, label %LU80, label %LU81
LU80:
	%u987 = load %struct.gameBoard*, %struct.gameBoard** %_P_board
	%u988 = getelementptr %struct.gameBoard, %struct.gameBoard* %u987, i1 0, i32 6
	%u989 = load i32, i32* %u988
	%u990 = icmp eq i32 %u989, 1
	br i1 %u990, label %LU82, label %LU83
LU82:
	store i32 0, i32* %_retval_
	br label %LU34
LU83:
	br label %LU81
LU81:
	br label %LU49
LU49:
	%u991 = load %struct.gameBoard*, %struct.gameBoard** %_P_board
	%u992 = getelementptr %struct.gameBoard, %struct.gameBoard* %u991, i1 0, i32 0
	%u993 = load i32, i32* %u992
	%u994 = icmp eq i32 %u993, 2
	br i1 %u994, label %LU50, label %LU51
LU50:
	%u995 = load %struct.gameBoard*, %struct.gameBoard** %_P_board
	%u996 = getelementptr %struct.gameBoard, %struct.gameBoard* %u995, i1 0, i32 3
	%u997 = load i32, i32* %u996
	%u998 = icmp eq i32 %u997, 2
	br i1 %u998, label %LU76, label %LU77
LU76:
	%u999 = load %struct.gameBoard*, %struct.gameBoard** %_P_board
	%u1000 = getelementptr %struct.gameBoard, %struct.gameBoard* %u999, i1 0, i32 6
	%u1001 = load i32, i32* %u1000
	%u1002 = icmp eq i32 %u1001, 2
	br i1 %u1002, label %LU78, label %LU79
LU78:
	store i32 1, i32* %_retval_
	br label %LU34
LU79:
	br label %LU77
LU77:
	br label %LU51
LU51:
	%u1003 = load %struct.gameBoard*, %struct.gameBoard** %_P_board
	%u1004 = getelementptr %struct.gameBoard, %struct.gameBoard* %u1003, i1 0, i32 1
	%u1005 = load i32, i32* %u1004
	%u1006 = icmp eq i32 %u1005, 1
	br i1 %u1006, label %LU52, label %LU53
LU52:
	%u1007 = load %struct.gameBoard*, %struct.gameBoard** %_P_board
	%u1008 = getelementptr %struct.gameBoard, %struct.gameBoard* %u1007, i1 0, i32 4
	%u1009 = load i32, i32* %u1008
	%u1010 = icmp eq i32 %u1009, 1
	br i1 %u1010, label %LU72, label %LU73
LU72:
	%u1011 = load %struct.gameBoard*, %struct.gameBoard** %_P_board
	%u1012 = getelementptr %struct.gameBoard, %struct.gameBoard* %u1011, i1 0, i32 7
	%u1013 = load i32, i32* %u1012
	%u1014 = icmp eq i32 %u1013, 1
	br i1 %u1014, label %LU74, label %LU75
LU74:
	store i32 0, i32* %_retval_
	br label %LU34
LU75:
	br label %LU73
LU73:
	br label %LU53
LU53:
	%u1015 = load %struct.gameBoard*, %struct.gameBoard** %_P_board
	%u1016 = getelementptr %struct.gameBoard, %struct.gameBoard* %u1015, i1 0, i32 1
	%u1017 = load i32, i32* %u1016
	%u1018 = icmp eq i32 %u1017, 2
	br i1 %u1018, label %LU54, label %LU55
LU54:
	%u1019 = load %struct.gameBoard*, %struct.gameBoard** %_P_board
	%u1020 = getelementptr %struct.gameBoard, %struct.gameBoard* %u1019, i1 0, i32 4
	%u1021 = load i32, i32* %u1020
	%u1022 = icmp eq i32 %u1021, 2
	br i1 %u1022, label %LU68, label %LU69
LU68:
	%u1023 = load %struct.gameBoard*, %struct.gameBoard** %_P_board
	%u1024 = getelementptr %struct.gameBoard, %struct.gameBoard* %u1023, i1 0, i32 7
	%u1025 = load i32, i32* %u1024
	%u1026 = icmp eq i32 %u1025, 2
	br i1 %u1026, label %LU70, label %LU71
LU70:
	store i32 1, i32* %_retval_
	br label %LU34
LU71:
	br label %LU69
LU69:
	br label %LU55
LU55:
	%u1027 = load %struct.gameBoard*, %struct.gameBoard** %_P_board
	%u1028 = getelementptr %struct.gameBoard, %struct.gameBoard* %u1027, i1 0, i32 2
	%u1029 = load i32, i32* %u1028
	%u1030 = icmp eq i32 %u1029, 1
	br i1 %u1030, label %LU56, label %LU57
LU56:
	%u1031 = load %struct.gameBoard*, %struct.gameBoard** %_P_board
	%u1032 = getelementptr %struct.gameBoard, %struct.gameBoard* %u1031, i1 0, i32 5
	%u1033 = load i32, i32* %u1032
	%u1034 = icmp eq i32 %u1033, 1
	br i1 %u1034, label %LU64, label %LU65
LU64:
	%u1035 = load %struct.gameBoard*, %struct.gameBoard** %_P_board
	%u1036 = getelementptr %struct.gameBoard, %struct.gameBoard* %u1035, i1 0, i32 8
	%u1037 = load i32, i32* %u1036
	%u1038 = icmp eq i32 %u1037, 1
	br i1 %u1038, label %LU66, label %LU67
LU66:
	store i32 0, i32* %_retval_
	br label %LU34
LU67:
	br label %LU65
LU65:
	br label %LU57
LU57:
	%u1039 = load %struct.gameBoard*, %struct.gameBoard** %_P_board
	%u1040 = getelementptr %struct.gameBoard, %struct.gameBoard* %u1039, i1 0, i32 2
	%u1041 = load i32, i32* %u1040
	%u1042 = icmp eq i32 %u1041, 2
	br i1 %u1042, label %LU58, label %LU59
LU58:
	%u1043 = load %struct.gameBoard*, %struct.gameBoard** %_P_board
	%u1044 = getelementptr %struct.gameBoard, %struct.gameBoard* %u1043, i1 0, i32 5
	%u1045 = load i32, i32* %u1044
	%u1046 = icmp eq i32 %u1045, 2
	br i1 %u1046, label %LU60, label %LU61
LU60:
	%u1047 = load %struct.gameBoard*, %struct.gameBoard** %_P_board
	%u1048 = getelementptr %struct.gameBoard, %struct.gameBoard* %u1047, i1 0, i32 8
	%u1049 = load i32, i32* %u1048
	%u1050 = icmp eq i32 %u1049, 2
	br i1 %u1050, label %LU62, label %LU63
LU62:
	store i32 1, i32* %_retval_
	br label %LU34
LU63:
	br label %LU61
LU61:
	br label %LU59
LU59:
	%u1051 = sub i32 0, 1
	store i32 %u1051, i32* %_retval_
	br label %LU34
LU34:
	%u1052 = load i32, i32* %_retval_
	ret i32 %u1052
}

define i32 @main()
{
LU109:
	%_retval_ = alloca i32
	%turn = alloca i32
	%space1 = alloca i32
	%space2 = alloca i32
	%winner = alloca i32
	%i = alloca i32
	%board = alloca %struct.gameBoard*
	store i32 0, i32* %i
	store i32 0, i32* %turn
	store i32 0, i32* %space1
	store i32 0, i32* %space2
	%u1053 = sub i32 0, 1
	store i32 %u1053, i32* %winner
	%u1054 = call i8* @malloc(i32 36)
	%u1055 = bitcast i8* %u1054 to %struct.gameBoard*
	store %struct.gameBoard* %u1055, %struct.gameBoard** %board
	%u1056 = load %struct.gameBoard*, %struct.gameBoard** %board
	call void @cleanBoard(%struct.gameBoard* %u1056)
	%u1057 = load i32, i32* %winner
	%u1058 = icmp slt i32 %u1057, 0
	%u1059 = load i32, i32* %i
	%u1060 = icmp ne i32 %u1059, 8
	%u1061 = and i1 %u1058, %u1060
	br i1 %u1061, label %LU110, label %LU111
LU110:
	%u1062 = load %struct.gameBoard*, %struct.gameBoard** %board
	call void @printBoard(%struct.gameBoard* %u1062)
	%u1063 = load i32, i32* %turn
	%u1064 = icmp eq i32 %u1063, 0
	br i1 %u1064, label %LU112, label %LU113
LU112:
	%u1065 = load i32, i32* %turn
	%u1066 = add i32 %u1065, 1
	store i32 %u1066, i32* %turn
	call i32 (i8*, ...) @scanf(i8* getelementptr inbounds ([5 x i8], [5 x i8]* @.read, i32 0, i32 0), i32* %space1)
	%u1067 = load %struct.gameBoard*, %struct.gameBoard** %board
	%u1068 = load i32, i32* %space1
	call void @placePiece(%struct.gameBoard* %u1067, i32 1, i32 %u1068)
	br label %LU114
LU113:
	%u1069 = load i32, i32* %turn
	%u1070 = sub i32 %u1069, 1
	store i32 %u1070, i32* %turn
	call i32 (i8*, ...) @scanf(i8* getelementptr inbounds ([5 x i8], [5 x i8]* @.read, i32 0, i32 0), i32* %space2)
	%u1071 = load %struct.gameBoard*, %struct.gameBoard** %board
	%u1072 = load i32, i32* %space2
	call void @placePiece(%struct.gameBoard* %u1071, i32 2, i32 %u1072)
	br label %LU114
LU114:
	%u1073 = load %struct.gameBoard*, %struct.gameBoard** %board
	%u1074 = call i32 @checkWinner(%struct.gameBoard* %u1073)
	store i32 %u1074, i32* %winner
	%u1075 = load i32, i32* %i
	%u1076 = add i32 %u1075, 1
	store i32 %u1076, i32* %i
	%u1077 = load i32, i32* %winner
	%u1078 = icmp slt i32 %u1077, 0
	%u1079 = load i32, i32* %i
	%u1080 = icmp ne i32 %u1079, 8
	%u1081 = and i1 %u1078, %u1080
	br i1 %u1081, label %LU110, label %LU111
LU111:
	%u1082 = load i32, i32* %winner
	%u1083 = add i32 %u1082, 1
	call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([6 x i8], [6 x i8]* @.println, i32 0, i32 0), i32 %u1083)
	store i32 0, i32* %_retval_
	br label %LU108
LU108:
	%u1084 = load i32, i32* %_retval_
	ret i32 %u1084
}
declare i8* @malloc(i32)
declare void @free(i8*)
declare i32 @printf(i8*, ...)
declare i32 @scanf(i8*, ...)
@.println = private unnamed_addr constant [6 x i8] c"%ld\0A\00\00", align 1
@.print = private unnamed_addr constant [6 x i8] c"%ld \00\00", align 1
@.read = private unnamed_addr constant [5 x i8] c"%ld\00\00", align 1
@.read_scratch = common global i32 0, align 4
