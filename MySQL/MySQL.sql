数据库管理系统DBMS
    SqlSever, Oracle, SQLite, MySQL
    操作几乎相同toor
分为: 服务端,客户端. 实质是socket

<可选>

MySQL
	默认端口号:3306
	初始化: 
		1. 添加进path变量
		2. 添加windows服务：cd进mysql的bin目录，mysqld.exe --install
		3. databases初始化：mysqld --initialize-insecure
	慢日志:	set global slow_query_log='ON'	//用于优化, 否则将拖慢速度, 用到再查
	启动
		1. net start mysql
		2. mysql -u root -p <-h hostIP><-P port>
	停止
		1. exit
		2. net stop mysql
	用户管理:
		创建:create user "userName"@"Ipdress"<or localhost> identified by 'password';
		删除:drop user "userName"@"Ipdress"<or localhost>;
		修改:rename user "userName"@"Ipdress"<or localhost>; to "newUserName"@"newIpdress";;
		修改密码:set password for "userName"@"Ipdress" = Password('newPassword');
		查权限:show grants for "userName"@"Ipdress";
		授权:grant Power on databaseName.tableName to "userName"@"Ipdress";
			Power-List:
				https://blog.csdn.net/zhangliangzi/article/details/51882710
		取消授权:revoke Power on databaseName.tableName from "userName"@"Ipdress";
	注释:
		-- 注释
	导出: 
		结构+数据: mysqldump -u userName -p password databaseName > fileLocation;
		结构: mysqldump -u userName -p password -d databaseName > fileLocation;
	导入:
		mysqldump -u userName -p password databaseName < fileLocation;
	切换MySQL终止符: delimiter $	//将MySQL终止符;换成$
概念
	数据库，文件夹
		参考配置文件: show variables;
		显示: show databases;
		创建: create database databaseName <defalut charset utf8 collate utf8_general_ci>;
		进入: use databaseName;
		删除: drop database databaseName;
	数据表，文件
		显示: show tables;
		创建:create table tableName(
				linName type
					<hasSigned>/*默认有符号,必须跟在type后*/
					<canNull>
					<defalutValue>
					<auto_increment keyType key>//自增列.自动自增,无需设置,一个表只有一个,必须是key
				,
				name int unsigned not null defalut 2 auto_increment primary key,
				sex varchar(20) null
			)<engine=innodb/*支持回滚*/ defalut charset=utf8>;
		查看列: desc tableName;
		删除: drop table tableName;
		清空: delete from tableName;	//自增列数据从清空前开始
			  truncate table tableName;	//彻底清空
		更新(UPDATE): update tableName + SET + CONDITION;
		统一设置(SET): set colName=value,colName=value;
		修改(ALTER): alter table tableName
			添加列: ALTER + add colName type;
			删除列: ALTER + drop column colName;
			修改列:
				类型: ALTER + modify column colName type;
				列名+类型: ALTER + change colName colNewName type;
			修改默认值: ALTER + alter colName set defalut defalutValue;
			删除默认值: ALTER + alter colName drop defalut;
			主键:	//一张表只能有一个主键,唯一不可重复,不能为null.一般为自增列
				添加: ALTER + add primary key(colName);	//最多两列
				删除: ALTER + drop primary key;
					  ALTER + modify colName int, drop primary key;
			外键:	//减少主要表的内存开销,通过新建表索引主要表的值
				添加: ALTER + add constraint foreignKeyName foreign key constraintTable(constraintCol) references foreignTable(foreignCol);
				删除: ALTER + drop foreign key foreignKeyName;
	数据行，文件中的一行
		插入(INSERT):insert into tableName(nid, name, ...)
			数据: INSERT + values(1, 'ex', ...),(2,'se', ...);
			其它表: INSERT + SELECT + CONDITION;
		查看(SELECT):select * from tableName;	// *:列名
			子查询: select s1 from table1 where s1 > any(select s2 from table2)	//子查询可以在: select中/from 后/where中/group by/order by 中
				any:	any(SELECT)		//对子查询所有结果比较, 如果成功立即返回True
				in/not in:	in(SELECT)	//是否在这个集合中, 是则返回True
				all:	all(SELECT)		//必须与比较操作符一起使用. 对于子查询的所有值, 如果全部满足才返回True
			通配符: like 'ale%';	// %多个; _一个
			限制行: limit 5;	// 5前五行; 4,5/5 offset 4从第四行开始的五行
			排序: order by colName asc;	// asc从小到大; desc从大到小;
			分组: group by colName;	//同一组的合并显示.必须在where后,order前
			组合: SELECT + union + SELECT;	//将两个表组合为一个显示.union去重,union all不去重
			连表: select * from foreignTable,constraintTable where constraintTable.constraintCol=foreignTable.foreignCol	//配合外链使用
				  select * from constraintTable left join foreignTable on constraintTable.constraintCol=foreignTable.foreignCol	//from后的为主表,完全显示.有right join.inner join不含null数据
			临时表: select * from (SELECT) as T;	//将SELECT作为T表,保存在tempdb中的实际的表
			去重: select distinct colName from tableName;
				  select distinctrow colName from tableName;
			查看所有(包括NULL): select all colName from tableName;
			视图:	//类似于临时表,但只是一条SQL语句的宏,有较高安全性
				创建: create view viewerName(colName, colName...) as select(colName, colName...) from tableName;
				修改: create or replace view viewerName as SELECT;
					  alter view viewerName as SELECT;
				删除: drop view viewerName;
				查看: desc viewerName;
					  show fields from viewerName;
		指定条件(CONDITION): where nid>=2;
			有函数时: having nid>=2;
				>,=,<,!=,>=,<=,between A and B,in(values),not in(values),and/or
		删除: delete from tableName + CONDITION;
		函数: max(colName), min(colName), sum(colName), count(colName), avg(colName)
		判断: case when rules then results else anthorResults end	//相当于 rules?results:anthorResults
		引用: colName as referenceName	//colName取别名
		
数据类型:
	数值:
			M表示显示长度,对数据范围无限制除bit
		bit<(M)>:二进制位.M表示长度(1~64),默认1
		tinyint<(M)>:1字节.MySQL的boolen:tinyint(1).
		smallint<(M)>:2字节.
		mediumint<(M)>:3字节.
		int<(M)>:4字节.
		bigint<(M)>:8字节.
		decimal<(M,D)>:如果M>D为M+2否则为D+2.绝对精确.M表示总长度(max:65).D表示小数后位数(max:30)
		float<(M,D)>:4字节.M表示长度.D表示小数后位数
		double<(M,D)>:8字节.M表示长度.D表示小数后位数
	时间:
		date:3字节.YYYY-MM-DD.1000-01-01~9999-12-31
		time:3字节.HH:MM:SS.-838:59:59~838:59:59
		year:1字节.YYYY.1901~2155
		datetime:8字节.YYYY-MM-DD HH:MM:SS.1000-01-01 00:00:00~9999-12-31 23:59:59
		timestamp:4字节.YYYYMMDD HHMMSS.1970-01-01 00:00:00~2038-1-19 03:14:07(第 2147483647 秒)
	字符串:
			blob:二进制形式字符
		char(Y):0-255字节.定长字符串.总是长Y
		varchar(Y):0-255字节.变长字符串.最长Y
		tinyblob:0-255字节.
		tinytext:0-255字节.
		blob:0-65,535字节.
		text:0-65,535字节.
		mediumblob:	0-16,777,215字节.
		mediumtext:0-16,777,215字节.
		longblob:0-4,294,967,295字节.
		longtext:0-4,294,967,295字节.
	枚举:
		enum:同Java枚举
	组合:
		set:类似enum，但插入可以元素组合后插入
		
索引:	//约束,加速查找. 通过创建索引文件, 一般用B+树索引
		//如果是 CHAR,VARCHAR类型,length可以小于字段实际长度;如果是BLOB和TEXT类型,必须指定length,下同
	删除: drop indexName on tableName;
	查看: show index from tableName;
	普通索引:
		创建: index indexName(colName)	//在创建表时就创建索引
		      create index indexName on tableName(colName)
	唯一索引:	//约束列数据不能重复
		//和普通索引语法类似,将index换为unique就是唯一索引
	主键索引:	//约束列数据不能重复, 不能为null
	组合索引:	//组合多列组建索引, 就是将多列建到一个索引里
		查找:	//最左匹配, 不是最左边的列不会走索引
	情形:
		覆盖索引:	//只需要在索引中就能满足查询需要时
		合并索引:	//对多个索引通过AND,OR进行条件扫描时
	检测:	explain + SELECT	//查看是否走索引搜索
		不会走索引:	!=、>、模糊匹配%开头、内置函数、类型不一致
		table: //显示这一行的数据是关于哪张表的
		type: //显示连接使用了何种类型. 从最好到最差为system>const>eq_ref>ref>fulltext>ref_or_null>index_merge>unique_subquery>index_subquery>range>index>ALL
		possible_keys: //显示可能应用在这张表中的索引
		key_len: //使用的索引的长度. 在不损失精确性的情况下,长度越短越好
		key:  //实际使用的索引. 如果为NULL,则没有使用索引
		ref:  //显示索引的哪一列被使用了,如果可能的话,是一个常数
		rows: //MYSQL认为必须检查的用来返回请求数据的行数
		Extra: //关于MYSQL如何解析查询的额外信息
		
自定义函数:		//不能操作SQL语句
	调用: functionName(parameters);
	内置函数: http://blog.csdn.net/wwp231/article/details/52833612
	
	delimiter $
	create function f1(i1 int, se int)returns int
	begin
		declare nms int;
		select nid into nms from tableName CONDITION;	//可以将nid赋值给nms
		return(nms);
	end $
	delimiter ;
	
存储过程:	//类似于函数,SQL语句集
	查看所有: show procedure status;
	查看具体: show create procedure procedureName;
	删除: drop procedure procedureName;
	调用: call procedureName(parameters);
	注释: -- 注释内容
		  /*注释内容*/
	
	delimiter $
	set @il = 123;	//全局变量
	create procedure procedureName(
		IN parameter int,	//形参parameter为int
		OUT returner int, 	//返回值returner为int,引用传递
		INOUT selx int		//可传入和传出
	)
	begin
		declare var int defalut 100;	//声明var为int,默认值100
		set var = parameter+1;	//var赋值
		
		declare p1 int defalut 2;
		set @p1 = p1;		//下一句必须为@开头变量才能使用
		prepare prod from "select * from tab2 where nid > ?";	//动态执行SQL语句
		execute prod using @p1;		//将上一句?替换为@p1
		deallocate prepare prod;	//执行prod
		
		if var=0 then	//if else语句
			pass
		elseif var=2 then
			pass
		else
			pass
		end if;
		
		case var	//switch语句
		when 0 then
			pass
		when 1 then
			pass
		else
			pass
		end case;
		
		while var<6 do	//while语句
			pass
		end while;
		
		repeat		//do-while语句
			pass
		until var>5 end repeat;
		
		loopName:loop	//死循环
			pass
			if var>5 then
				leave loopName;	//跳出
			else
				iterate loopName;	//continue
			end if;
		end loop;
		
		begin
			//代码块
		end
		
		//触发器.用户操作表时,触发器工作
		create trigger triggerName before insert on tableName for each row	//after和before,增/删/改/更新
		begin
			new.nid		//new里面保存用户更改的数据
			old.nid		//old里面保存原来的值
		end $
		drop trigger triggerName;
	
		//代码执行出错时执行
		declare exits handler for sqlexception
		begin
			rollback;	//回滚操作
		end
	
		//代码执行警告时执行
		declare exit handler for sqlwarning
		begin
			pass
		end
		
		//事务.使得几条SQL语句可以同时保证执行,否则捕获异常
		start transaction:
			pass
		commit;
		
	end $
	delimiter ;
	
	运算符:
		算术运算符:
			+ - * /
			DIV		//整除 SET var5=10 DIV 3; 3
			%		//取模 SET var6=10%3 ;     1
		比较运算符:
			> < <= >= =
			BETWEEN		//在两值之间 5 BETWEEN 1 AND 10 True
			NOT BETWEEN	//不在两值之间 5 NOT BETWEEN 1 AND 10 False
			IN			//在集合中 5 IN (1,2,3,4) False
			NOT IN		//不在集合中 5 NOT IN (1,2,3,4) True
			<>, != 		//不等于 2<>3 False
			<=>			//严格比较两个NULL值是否相等 NULL<=>NULL True
			LIKE		//简单模式匹配 "Guy Harrison" LIKE "Guy%" True
			REGEXP		//正则式匹配 "Guy Harrison" REGEXP "[Gg]reg" False
			IS NULL		//为空 0 IS NULL False
			IS NOT NULL		//不为空 0 IS NOT NULL True
		逻辑运算符:
			AND OR XOR
		位运算符:
			|	//或
			&	//与
			~	//按位取反
			<<	//左移位
			>>	//右移位