# MySQL Cluster

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

> 在主库中执行 `SHOW MASTER STATUS` 或 `SHOW BINARY LOG STATUS`，结果中的 File 与 Position 的值，就是 master_log_file 与 master_log_pos 的值

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
