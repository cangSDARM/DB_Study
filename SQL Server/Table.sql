------------------表操作
--修改
alter table tableName
	alter column ColName text	--修改数据类型
	alter column ColName int not NULL	--修改为非空约束(需要加数据类型)
exec sp_rename 'tableName.ColName', 'ReName', 'COLUMN'	--修改列名
update tableName set ColName = 'xx' where ColName=1		--修改表值

--删除
drop table tableName 	--删除表
alter table tableName
	drop constraint PK_Name	--删除主键
	drop constraint FK_Name --删除外键
delete tableName where ColName = 1 --删除表值
truncate table tableName --不能添加条件, 彻底删除(清除自增列的记录但不触发触发器)

--增加
alter table tableName
	add constraint PK_Name PRIMARY KEY(ColName) --设置主键
	add ColName int DEFAULT 2	--添加列
	add constraint FK_Name FOREIGN KEY(ColName) references FK_Table(ColName)	--设置外键

--数据插入
insert into tableName(ColName, Col2) values (var1, var)	--一行数据
insert into tableName(ColName, Col2)	--多行数据
	select var1, var union all
	select var2, var union all
select * into newTable from tableName 			--从其它表copy数据(newTable之前不能存在. 且除标识列/非空外, 其它属性都不保留)
insert into tableName(ColName, Col2) select语句	--从其它表copy数据(除标识列/非空外, 其它属性都不保留)

--查询
select 数据 from 表名 where 元数据 group by 元数据 having 元数据 order by 结果集
--顺序: from -> where -> group by -> having -> select -> order by

select distinct * from tableName  --去重
select top 2 * from tableName 	--前2行数据
select top 10 percent * from tableName 	--前10%行数据(向上取整)

select Avg(1) from tableName   --聚合函数
--支持字符串/统计/随机/时间/类型转换/空值检查 等相关函数

select ColName+Col2 from tableName  --支持字符串拼接和运算

where ColName not like '%x%'	--模糊查询. 支持: [^] [] _ %
where ColName between 1 and 2	--范围查询. 支持: 字符串比较, 数值
where ColName in (1, 2, 3, 4)	--范围查询. 查询在集合里的值
where ColName is null   		--判断是否为空

select Col=a.ColName from tableName as a  	--对表和列取别名
where exists (sleect * from table2 as b where b.ColName = a.ColName) --子查询. 子表和父表有关联查询

select Case when ColName = 1 then '1'	--Case查询. 满足条件返回指定值
Case when Col2 >= 2 then '2'
Else '0'   	--Default值
End from tableName

having Avg(Col2)	--可以使用聚合函数的条件查询

group by ColName  	--分组查询. 先分组后查找

order by ColName, Col2 desc	 --排序查找. Desc: 倒序.(邻近原则)

--联合和连接
union	--联合结果集. 默认去重
union all --不去重联合. 全部union all才不去重

inner join table2 on tableName.ColName = table2.ColName  --内连表. 返回满足条件的两个表
left join table2 on tableName.ColName = table2.ColName   --左连表和右连表. 返回查询的A表和满足条件的B表
cross join table2 										 --返回AB表的笛卡儿积
full join table2 on tableName.ColName = table2.ColName   --左连表结合右连表