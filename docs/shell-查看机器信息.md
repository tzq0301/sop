# 查看机器信息

## 查看 Linux 发行版

```bash
hostnamectl
```

## 查看 CPU 核数

```bash
lscpu | grep '^CPU(s)' | awk '{print $2}'
```

## 查看内存大小

```bash
cat /proc/meminfo | grep MemTotal | awk '{print $2}'  # 16152104 即为 16G
```

## 查看硬盘空间

```bash
df --total -h | grep -e total -e Filesystem
```

## top

* `id` - Time spent in idle operations
* `wa` - Time spent on waiting on IO peripherals (eg. disk)
  * 例如：若 MySQL 服务器上 top 的 `wa` 值较高，说明 I/O 压力比较大，排查慢查询等

## 查看机器重启的历史记录

```bash
last reboot -n 5  # Displays the last 5 system reboots
last reboot -F    # Displays the full date and time in the output
```
