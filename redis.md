#Redis

## Redis是: 基于内存, 分布式架构, key-value结构的数据库.

服务启动: redis-server
命令行操作启动: redis-cli -h 127.0.0.1 -p 6379 -a passwd --raw

## 数据类型
- string(字符串): 
	+ 是二进制安全的. 可存储任意二进制文件 < 512MB
	+ 增删改查
		= SET name "runoob"		//增加 key: name, value: runoob
		= GET name				//查询
- hash(哈希表):
	+ string类型的映射表.
	+ 增删改查
		= HMSET table key1 "value1" key2 "value2"...	//增加table表, 以及内部的key1:"value1"等键值对
		= HGET table key1		//查询table的key1
- list(列表):
	+ 简单的字符串列表，按照插入顺序排序
	+ 增删改查
		= LPUSH listN redis		//将"redis"push进列表listN
		= LRANGE listN 0 10		//查询listN中0-10的数据
- set(集合):
	+ 是非重复string的无序集合
	+ 增删改查
		= SADD setN redis		//将"redis"add进集合setN
		= SMEMBERS setN			//查询setN的所有内容
- zset
	+ 是非重复string的有序集合
	+ 增删改查
		= ZADD zsetN score redis	//将"redis"以score的得分add进zsetN. 若在集合中则更新对应score
		= ZRANGEBYSCORE zsetN 0 1000	//将0-1000得分的数据按从小到大排序显示
		
### 通用操作

#### 数据库
//redis 默认初始化16个数据库.
	
flushdb			//清空数据库
keys *			//该数据库所有的key
#### 单独key
DEL table			//删除key ? 1 : 0
EXISTS table		//检查key存在? 1 : 0
RANDOMKEY			//从当前数据库中随机返回一个key
RENAME key newkey 	//修改 key 的名称
TYPE key 			//返回 key 所储存的值的类型