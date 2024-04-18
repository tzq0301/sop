# MySQL

## 命令行 cli 执行 MySQL 命令（不进入交互模式）

```bash
mysql -e "SELECT VERSION();"
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
