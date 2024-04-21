# systemd

[Systemd 入门教程：命令篇 —— 阮一峰的网络日志](https://www.ruanyifeng.com/blog/2016/03/systemd-tutorial-commands.html)

```bash
systemctl list-units        # 列出正在运行的 Unit
systemctl list-units --all  # 列出所有 Unit，包括没有找到配置文件的或者启动失败的

systemctl is-active nginx.service          # 查看某个 Unit 是否正在运行，打印 active 并返回 0，或打印 inactive 并返回非零值
systemctl is-active nginx.service --quiet  # 查看某个 Unit 是否正在运行，返回 0，或返回非零值
systemctl is-active nginx.service --quiet || systemctl restart nginx.service

systemctl show httpd.service               # 显示某个 Unit 的所有底层参数
systemctl show httpd.service -p CPUShares  # 显示某个 Unit 的指定属性的值

systemctl cat nginx.service  # 查看指定服务的配置文件的内容

sudo journalctl -u nginx.service  # 查看某个 Unit 的日志
sudo journalctl -u nginx.service --since today

hostnamectl  # 查看当前主机的信息
localectl    # 查看本地化设置
timedatectl  # 查看当前时区设置
loginctl     # 查看当前登录的用户
```

## earlyoom

[earlyoom](https://github.com/rfjakob/earlyoom) 每秒最多检查 10 次可用内存和可用交换空间（如果有大量可用内存，则频率会降低）

默认情况下，如果两者都低于 10%，它将杀死最大的进程（最高 oom_score），百分比值可通过命令行参数进行配置

注意：以 non-root 运行的 earlyoom 没法 kill 掉以 root 运行的进程

### earlyoom 查看 log

```bash
sudo journalctl -u earlyoom | grep -iE "(sending|killing)"
```

### earlyoom 配置文件

默认位置为 /etc/default/earlyoom，参数参考 [Command Line Options](https://github.com/rfjakob/earlyoom?tab=readme-ov-file#command-line-options)，若修改了该文件，需要重启 earlyoom 服务：

```bash
systemctl restart earlyoom
```
