# MySQL

## 命令行 cli 执行 MySQL 命令（不进入交互模式）

```bash
mysql -e "SELECT VERSION();"
```

## 查看当前的 connections 连接数

```bash
mysql -e "SHOW PROCESSLIST;" | tail -n +2 | wc -l
```

## 查看是否开启了慢查询日志 & 查看慢查询日志的文件位置

```bash
mysql -e "SHOW VARIABLES LIKE '%slow_query_log%';
```

## 查看 innodb_buffer_pool_size 内存大小

```bash
mysql -e "SELECT  @@innodb_buffer_pool_size/1024/1024/1024;"  # 以 G 为单位
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
