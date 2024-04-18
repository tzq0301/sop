# MySQL

## 命令行 cli 执行 MySQL 命令（不进入交互模式）

```bash
mysql -e "SELECT VERSION();"
```

## 查看 server id

```sql
SELECT @@server_id;
```

## 查看当前的 connections 连接数

```bash
mysql -e "SHOW PROCESSLIST;" | tail -n +2 | wc -l
```

## 查看是否开启了慢查询日志 & 查看慢查询日志的文件位置

```sql
SHOW VARIABLES LIKE '%slow_query_log%';
```

## 查看 innodb_buffer_pool_size 内存大小

```sql
SELECT  @@innodb_buffer_pool_size/1024/1024/1024;  -- 以 G 为单位
```

## 查看实例当前拥有的 binlog

```sql
SHOW BINARY LOGS;
```

## 在线查看 binlog 内容

```sql
SHOW BINLOG EVENTS [IN 'log_name'] [FROM pos] [LIMIT [offset,], row_count];
```

## 搭建主从连接

|              | IP             | server-id |
|--------------|----------------|-----------|
| 主库 source  | 192.168.244.10 | 1         |
| 从库 replica | 192.168.244.20 | 2         |

在 source 端（主库），创建复制用户：

```sql
mysql> CREATE USER 'repl'@'192.168.244.20' IDENTIFIED BY 'repl123';
Query OK, 0 rows affected (0.01 sec)

mysql> GRANT REPLICATION SLAVE ON *.* TO 'repl'@'192.168.244.20';
Query OK, 0 rows affected (0.01 sec)
```

在 replica 端（从库），测试是否能连接到主库：

```bash
mysql -h 192.168.244.10 -urepl -prepl123
```

在 replica 端（从库），执行 `CHANGE MASTER TO` 命令：

> 在主库中执行 `SHOW MASTER STATUS` ，结果中的 File 与 Position 的值，就是 master_log_file 与 master_log_pos 的值

```sql
CHANGE MASTER TO 
    master_host='192.168.244.10', 
    master_user='repl', 
    master_password='repl123', 
    master_log_file='binlog.000002', 
    master_log_pos=1988;
```

在 replica 端（从库），执行 `START SLAVE` 或 `START REPLICA` 命令，开启主从复制，并使用 `SHOW SLAVE STATUS\G` 或 `SHOW REPLICA STATUS\G` 进行检查：若 `Slave_IO_Running` 与 `Slave_SQL_Running` 的值均为 `Yes`，或 `Replica_IO_Running` 与 `Replica_SQL_Running` 的值均为 `Yes`，那么说明主从复制搭建成功

（可选）最后，在 source 随意执行一些 SQL，然后到 replica 查看数据是否已复制过来了

## 从库开启主从复制

```sql
START SLAVE;
-- or
START REPLICA;
```

## 从库停止主从复制

会同时停止 IO Thread 和 SQL Thread

```sql
STOP SLAVE; 
-- or
STOP REPLICA;
```

## 在主库查看从库 IP 和端口

```sql
SHOW SLAVE HOSTS;
-- or
SHOW REPLICAS;
```

## 时间类型与 INT、VARCHAR 等类型相互转换

```sql
-- NOW() -> VARCHAR
SELECT DATE_FORMAT(NOW(6), '%Y-%m-%d %H:%m:%s.%f');

-- CURRENT_TIMESTAMP -> VARCHAR
SELECT DATE_FORMAT(CURRENT_TIMESTAMP, '%Y-%m-%d %H:%m:%s.%f');

-- VARCHAR -> DATETIME
--   %W: Weekday name from Sunday to Saturday.
--   %d: Day of the month as a numeric value from 01 to 31.
--   %m: Month as a numeric value from 01 to 12.
--   %Y: Year as a 4-digit numeric value (yyyy).
--   %T: Time in the 24-hour format (hh:mm:ss).
SELECT STR_TO_DATE('2023-07-13 03:49:11', '%Y-%m-%d %T');

-- BIGINT -> DATETIME
SELECT FROM_UNIXTIME(1680873114);           -- 毫秒
SELECT FROM_UNIXTIME(1680873114000 / 1000); -- 微秒
```
