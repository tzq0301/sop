# systemd

## earlyoom

[earlyoom](https://github.com/rfjakob/earlyoom) 每秒最多检查 10 次可用内存和可用交换空间（如果有大量可用内存，则频率会降低）

默认情况下，如果两者都低于 10%，它将杀死最大的进程（最高 oom_score），百分比值可通过命令行参数进行配置

注意：以 non-root 运行的 earlyoom 没法 kill 掉以 root 运行的进程

### 查看 earlyoom 的 log

```bash
sudo journalctl -u earlyoom | grep -iE "(sending|killing)"
```

### 配置文件

默认位置为 /etc/default/earlyoom，参数参考 [Command Line Options](https://github.com/rfjakob/earlyoom?tab=readme-ov-file#command-line-options)，若修改了该文件，需要重启 earlyoom 服务：

```bash
systemctl restart earlyoom
```
