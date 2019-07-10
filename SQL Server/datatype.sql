-- 数字
bigint 		-- 8 byte
int 		-- 4 byte
smallint	-- 2 byte
tinyint		-- 1 byte
float		-- 8 byte
bit 		-- only 1 or 0

-- 字符
char(n)		-- fixed char. n where between 0 to 8000
varchar(n)	-- float char. n where between 0 to 8000
nchar(n)	-- fixed unicode char. n where between 0 to 4000
nvarchar(n)	-- float unicode char. n where between 0 to 4000

-- 时间
time		-- 12:30:03.1234567
date		-- 2018-10-10
samlldatetime-- 2018-10-10 12:30:03
datetime	-- 2018-10-10 10:20:30.123
datetime2	-- 2018-10-10 12:23:39.1234567

-- more
https://docs.microsoft.com/zh-cn/sql/t-sql/data-types/data-types-transact-sql?view=sql-server-2017