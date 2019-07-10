# 关系表
## <font color=#0099ff face="黑体">三种类型</font>
#### &emsp;基本表
&emsp;&emsp;&emsp;&emsp;** 实际保存的表 **
> ** 要求 **   
> > 1. 列同质homogeneous: 分量 同类型, 同域
> > 2. 不同属性(列)可同域但不同名
> > 3. 行列次序可任意交换
> > 4. 候选码不重复
> > 5. 分量不可分normalization (Normal Form, NF, 量子化)
#### &emsp;查询表
&emsp;&emsp;&emsp;&emsp;** 通过show table查询得到的表 **
#### &emsp;视图表
&emsp;&emsp;&emsp;&emsp;** left join等方式的连表 **
## <font color=#0099ff face="黑体">关系模式</font>
#### &emsp;&emsp;对关系的描述化语言
&emsp;&emsp;&emsp;&emsp;** R(U, D, DOM, F) **    
&emsp;&emsp;&emsp;&emsp;** 表名(属性名集合, 域集合, U->D的映射集合, 连表数据依赖集合)**
#### &emsp;&emsp;表操作
> ** 操作的对象和结果都是集合 **   
> > ** 增insert **   
> > ** 删delete **  
> > ** 改update **         
> > ** 查query **          
> > > |   命令  |    解释  |      
> > > | :-----: | :-----: |
> > > |选择select[ σ ]|通过where查表|   
> > > |投影project[ ∏ ]|通过select查表|     
> > > |并union[ ∪ ]|并集|
> > > |差except[ - ]|差集|
> > > |笛卡儿积[ × ]|笛卡儿积|
> > > |连接join[ ▷◁ ]|连表|     
> > > ||等值连接: 非去重连表|
> > > ||自然连接: 去重连表|
> > > |除divide[ ÷ ]|查询满足外链表条件的主键|
> > > |交intersection[ ∩ ]|交集|
#### &emsp;&emsp;完整性
> 实体完整性entity integrity
> > 每一行的数据就是一个实体.
> > 每一行的数据必须不一样
> > (主键/标识列/唯一键)
>       
> 参照完整性referential integrity
> > 引用的字段类型和意义必须一致
> > 被引用的称为主表, 应用的称为从表或外键表
> > 主表中该字段必须是主键或唯一键
>     
> 域完整性:
> > 每个字段就是域
> > 每个数据必须是合理的
> > (Check/Default/非空/外键 ...)
>      
> 自定义完整性user-defined integrity
> > 用户定义的
> > (Check/存储过程/触发器)
#### &emsp;&emsp;数据语言
					  ┌-------关系代数语言(ISBL)
					  |					   ┌-------元祖关系演算语言(ALPHA, QUEL)
		关系数据语言 --|-------关系演算语言--|
					  |					   └-------域关系演算语言(QBE)
					  └-------集成化且标准化语言(SQL)