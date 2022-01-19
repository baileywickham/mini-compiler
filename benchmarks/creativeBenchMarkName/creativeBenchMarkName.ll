target triple="i686"
%struct.node = type {i32, %struct.node*}



define %struct.node* @buildList()
{
LU1:
	%_retval_ = alloca %struct.node*
	%input = alloca i32
	%i = alloca i32
	%n0 = alloca %struct.node*
	%n1 = alloca %struct.node*
	%n2 = alloca %struct.node*
	%n3 = alloca %struct.node*
	%n4 = alloca %struct.node*
	%n5 = alloca %struct.node*
	%u1861 = call i8* @malloc(i32 8)
	%u1862 = bitcast i8* %u1861 to %struct.node*
	store %struct.node* %u1862, %struct.node** %n0
	%u1863 = call i8* @malloc(i32 8)
	%u1864 = bitcast i8* %u1863 to %struct.node*
	store %struct.node* %u1864, %struct.node** %n1
	%u1865 = call i8* @malloc(i32 8)
	%u1866 = bitcast i8* %u1865 to %struct.node*
	store %struct.node* %u1866, %struct.node** %n2
	%u1867 = call i8* @malloc(i32 8)
	%u1868 = bitcast i8* %u1867 to %struct.node*
	store %struct.node* %u1868, %struct.node** %n3
	%u1869 = call i8* @malloc(i32 8)
	%u1870 = bitcast i8* %u1869 to %struct.node*
	store %struct.node* %u1870, %struct.node** %n4
	%u1871 = call i8* @malloc(i32 8)
	%u1872 = bitcast i8* %u1871 to %struct.node*
	store %struct.node* %u1872, %struct.node** %n5
	%u1873 = load %struct.node*, %struct.node** %n0
	%u1874 = getelementptr %struct.node, %struct.node* %u1873, i1 0, i32 0
	call i32 (i8*, ...) @scanf(i8* getelementptr inbounds ([5 x i8], [5 x i8]* @.read, i32 0, i32 0), i32* %u1874)
	%u1875 = load %struct.node*, %struct.node** %n1
	%u1876 = getelementptr %struct.node, %struct.node* %u1875, i1 0, i32 0
	call i32 (i8*, ...) @scanf(i8* getelementptr inbounds ([5 x i8], [5 x i8]* @.read, i32 0, i32 0), i32* %u1876)
	%u1877 = load %struct.node*, %struct.node** %n2
	%u1878 = getelementptr %struct.node, %struct.node* %u1877, i1 0, i32 0
	call i32 (i8*, ...) @scanf(i8* getelementptr inbounds ([5 x i8], [5 x i8]* @.read, i32 0, i32 0), i32* %u1878)
	%u1879 = load %struct.node*, %struct.node** %n3
	%u1880 = getelementptr %struct.node, %struct.node* %u1879, i1 0, i32 0
	call i32 (i8*, ...) @scanf(i8* getelementptr inbounds ([5 x i8], [5 x i8]* @.read, i32 0, i32 0), i32* %u1880)
	%u1881 = load %struct.node*, %struct.node** %n4
	%u1882 = getelementptr %struct.node, %struct.node* %u1881, i1 0, i32 0
	call i32 (i8*, ...) @scanf(i8* getelementptr inbounds ([5 x i8], [5 x i8]* @.read, i32 0, i32 0), i32* %u1882)
	%u1883 = load %struct.node*, %struct.node** %n5
	%u1884 = getelementptr %struct.node, %struct.node* %u1883, i1 0, i32 0
	call i32 (i8*, ...) @scanf(i8* getelementptr inbounds ([5 x i8], [5 x i8]* @.read, i32 0, i32 0), i32* %u1884)
	%u1885 = load %struct.node*, %struct.node** %n1
	%u1886 = load %struct.node*, %struct.node** %n0
	%u1887 = getelementptr %struct.node, %struct.node* %u1886, i1 0, i32 1
	store %struct.node* %u1885, %struct.node** %u1887
	%u1888 = load %struct.node*, %struct.node** %n2
	%u1889 = load %struct.node*, %struct.node** %n1
	%u1890 = getelementptr %struct.node, %struct.node* %u1889, i1 0, i32 1
	store %struct.node* %u1888, %struct.node** %u1890
	%u1891 = load %struct.node*, %struct.node** %n3
	%u1892 = load %struct.node*, %struct.node** %n2
	%u1893 = getelementptr %struct.node, %struct.node* %u1892, i1 0, i32 1
	store %struct.node* %u1891, %struct.node** %u1893
	%u1894 = load %struct.node*, %struct.node** %n4
	%u1895 = load %struct.node*, %struct.node** %n3
	%u1896 = getelementptr %struct.node, %struct.node* %u1895, i1 0, i32 1
	store %struct.node* %u1894, %struct.node** %u1896
	%u1897 = load %struct.node*, %struct.node** %n5
	%u1898 = load %struct.node*, %struct.node** %n4
	%u1899 = getelementptr %struct.node, %struct.node* %u1898, i1 0, i32 1
	store %struct.node* %u1897, %struct.node** %u1899
	%u1900 = load %struct.node*, %struct.node** %n5
	%u1901 = getelementptr %struct.node, %struct.node* %u1900, i1 0, i32 1
	store %struct.node* null, %struct.node** %u1901
	%u1902 = load %struct.node*, %struct.node** %n0
	store %struct.node* %u1902, %struct.node** %_retval_
	br label %LU0
LU0:
	%u1903 = load %struct.node*, %struct.node** %_retval_
	ret %struct.node* %u1903
}

define i32 @multiple(%struct.node* %list)
{
LU3:
	%_P_list = alloca %struct.node*
	%_retval_ = alloca i32
	%i = alloca i32
	%product = alloca i32
	%cur = alloca %struct.node*
	store %struct.node* %list, %struct.node** %_P_list
	store i32 0, i32* %i
	%u1904 = load %struct.node*, %struct.node** %_P_list
	store %struct.node* %u1904, %struct.node** %cur
	%u1905 = load %struct.node*, %struct.node** %cur
	%u1906 = getelementptr %struct.node, %struct.node* %u1905, i1 0, i32 0
	%u1907 = load i32, i32* %u1906
	store i32 %u1907, i32* %product
	%u1908 = load %struct.node*, %struct.node** %cur
	%u1909 = getelementptr %struct.node, %struct.node* %u1908, i1 0, i32 1
	%u1910 = load %struct.node*, %struct.node** %u1909
	store %struct.node* %u1910, %struct.node** %cur
	%u1911 = load i32, i32* %i
	%u1912 = icmp slt i32 %u1911, 5
	br i1 %u1912, label %LU4, label %LU5
LU4:
	%u1913 = load i32, i32* %product
	%u1914 = load %struct.node*, %struct.node** %cur
	%u1915 = getelementptr %struct.node, %struct.node* %u1914, i1 0, i32 0
	%u1916 = load i32, i32* %u1915
	%u1917 = mul i32 %u1913, %u1916
	store i32 %u1917, i32* %product
	%u1918 = load %struct.node*, %struct.node** %cur
	%u1919 = getelementptr %struct.node, %struct.node* %u1918, i1 0, i32 1
	%u1920 = load %struct.node*, %struct.node** %u1919
	store %struct.node* %u1920, %struct.node** %cur
	%u1921 = load i32, i32* %product
	call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([6 x i8], [6 x i8]* @.println, i32 0, i32 0), i32 %u1921)
	%u1922 = load i32, i32* %i
	%u1923 = add i32 %u1922, 1
	store i32 %u1923, i32* %i
	%u1924 = load i32, i32* %i
	%u1925 = icmp slt i32 %u1924, 5
	br i1 %u1925, label %LU4, label %LU5
LU5:
	%u1926 = load i32, i32* %product
	store i32 %u1926, i32* %_retval_
	br label %LU2
LU2:
	%u1927 = load i32, i32* %_retval_
	ret i32 %u1927
}

define i32 @add(%struct.node* %list)
{
LU7:
	%_P_list = alloca %struct.node*
	%_retval_ = alloca i32
	%i = alloca i32
	%sum = alloca i32
	%cur = alloca %struct.node*
	store %struct.node* %list, %struct.node** %_P_list
	store i32 0, i32* %i
	%u1928 = load %struct.node*, %struct.node** %_P_list
	store %struct.node* %u1928, %struct.node** %cur
	%u1929 = load %struct.node*, %struct.node** %cur
	%u1930 = getelementptr %struct.node, %struct.node* %u1929, i1 0, i32 0
	%u1931 = load i32, i32* %u1930
	store i32 %u1931, i32* %sum
	%u1932 = load %struct.node*, %struct.node** %cur
	%u1933 = getelementptr %struct.node, %struct.node* %u1932, i1 0, i32 1
	%u1934 = load %struct.node*, %struct.node** %u1933
	store %struct.node* %u1934, %struct.node** %cur
	%u1935 = load i32, i32* %i
	%u1936 = icmp slt i32 %u1935, 5
	br i1 %u1936, label %LU8, label %LU9
LU8:
	%u1937 = load i32, i32* %sum
	%u1938 = load %struct.node*, %struct.node** %cur
	%u1939 = getelementptr %struct.node, %struct.node* %u1938, i1 0, i32 0
	%u1940 = load i32, i32* %u1939
	%u1941 = add i32 %u1937, %u1940
	store i32 %u1941, i32* %sum
	%u1942 = load %struct.node*, %struct.node** %cur
	%u1943 = getelementptr %struct.node, %struct.node* %u1942, i1 0, i32 1
	%u1944 = load %struct.node*, %struct.node** %u1943
	store %struct.node* %u1944, %struct.node** %cur
	%u1945 = load i32, i32* %sum
	call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([6 x i8], [6 x i8]* @.println, i32 0, i32 0), i32 %u1945)
	%u1946 = load i32, i32* %i
	%u1947 = add i32 %u1946, 1
	store i32 %u1947, i32* %i
	%u1948 = load i32, i32* %i
	%u1949 = icmp slt i32 %u1948, 5
	br i1 %u1949, label %LU8, label %LU9
LU9:
	%u1950 = load i32, i32* %sum
	store i32 %u1950, i32* %_retval_
	br label %LU6
LU6:
	%u1951 = load i32, i32* %_retval_
	ret i32 %u1951
}

define i32 @recurseList(%struct.node* %list)
{
LU11:
	%_P_list = alloca %struct.node*
	%_retval_ = alloca i32
	store %struct.node* %list, %struct.node** %_P_list
	%u1952 = load %struct.node*, %struct.node** %_P_list
	%u1953 = getelementptr %struct.node, %struct.node* %u1952, i1 0, i32 1
	%u1954 = load %struct.node*, %struct.node** %u1953
	%u1955 = icmp eq %struct.node* %u1954, null
	br i1 %u1955, label %LU12, label %LU13
LU12:
	%u1956 = load %struct.node*, %struct.node** %_P_list
	%u1957 = getelementptr %struct.node, %struct.node* %u1956, i1 0, i32 0
	%u1958 = load i32, i32* %u1957
	store i32 %u1958, i32* %_retval_
	br label %LU10
LU13:
	%u1959 = load %struct.node*, %struct.node** %_P_list
	%u1960 = getelementptr %struct.node, %struct.node* %u1959, i1 0, i32 0
	%u1961 = load i32, i32* %u1960
	%u1962 = load %struct.node*, %struct.node** %_P_list
	%u1963 = getelementptr %struct.node, %struct.node* %u1962, i1 0, i32 1
	%u1964 = load %struct.node*, %struct.node** %u1963
	%u1965 = call i32 @recurseList(%struct.node* %u1964)
	%u1966 = mul i32 %u1961, %u1965
	store i32 %u1966, i32* %_retval_
	br label %LU10
LU14:
	br label %LU10
LU10:
	%u1967 = load i32, i32* %_retval_
	ret i32 %u1967
}

define i32 @main()
{
LU16:
	%_retval_ = alloca i32
	%list = alloca %struct.node*
	%product = alloca i32
	%sum = alloca i32
	%result = alloca i32
	%bigProduct = alloca i32
	%i = alloca i32
	store i32 0, i32* %i
	store i32 0, i32* %bigProduct
	%u1968 = call %struct.node* @buildList()
	store %struct.node* %u1968, %struct.node** %list
	%u1969 = load %struct.node*, %struct.node** %list
	%u1970 = call i32 @multiple(%struct.node* %u1969)
	store i32 %u1970, i32* %product
	%u1971 = load %struct.node*, %struct.node** %list
	%u1972 = call i32 @add(%struct.node* %u1971)
	store i32 %u1972, i32* %sum
	%u1973 = load i32, i32* %product
	%u1974 = load i32, i32* %sum
	%u1975 = sdiv i32 %u1974, 2
	%u1976 = sub i32 %u1973, %u1975
	store i32 %u1976, i32* %result
	%u1977 = load i32, i32* %i
	%u1978 = icmp slt i32 %u1977, 2
	br i1 %u1978, label %LU17, label %LU18
LU17:
	%u1979 = load i32, i32* %bigProduct
	%u1980 = load %struct.node*, %struct.node** %list
	%u1981 = call i32 @recurseList(%struct.node* %u1980)
	%u1982 = add i32 %u1979, %u1981
	store i32 %u1982, i32* %bigProduct
	%u1983 = load i32, i32* %i
	%u1984 = add i32 %u1983, 1
	store i32 %u1984, i32* %i
	%u1985 = load i32, i32* %i
	%u1986 = icmp slt i32 %u1985, 2
	br i1 %u1986, label %LU17, label %LU18
LU18:
	%u1987 = load i32, i32* %bigProduct
	call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([6 x i8], [6 x i8]* @.println, i32 0, i32 0), i32 %u1987)
	%u1988 = load i32, i32* %bigProduct
	%u1989 = icmp ne i32 %u1988, 0
	br i1 %u1989, label %LU19, label %LU20
LU19:
	%u1990 = load i32, i32* %bigProduct
	%u1991 = sub i32 %u1990, 1
	store i32 %u1991, i32* %bigProduct
	%u1992 = load i32, i32* %bigProduct
	%u1993 = icmp ne i32 %u1992, 0
	br i1 %u1993, label %LU19, label %LU20
LU20:
	%u1994 = load i32, i32* %result
	call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([6 x i8], [6 x i8]* @.println, i32 0, i32 0), i32 %u1994)
	%u1995 = load i32, i32* %bigProduct
	call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([6 x i8], [6 x i8]* @.println, i32 0, i32 0), i32 %u1995)
	store i32 0, i32* %_retval_
	br label %LU15
LU15:
	%u1996 = load i32, i32* %_retval_
	ret i32 %u1996
}
declare i8* @malloc(i32)
declare void @free(i8*)
declare i32 @printf(i8*, ...)
declare i32 @scanf(i8*, ...)
@.println = private unnamed_addr constant [6 x i8] c"%ld\0A\00\00", align 1
@.print = private unnamed_addr constant [6 x i8] c"%ld \00\00", align 1
@.read = private unnamed_addr constant [5 x i8] c"%ld\00\00", align 1
@.read_scratch = common global i32 0, align 4
