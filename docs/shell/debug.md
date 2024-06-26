# Debug

```bash
cat <<EOF | bash
echo
echo -e "uname -s (the name of the OS implementation)                          = $(uname -s)"
echo -e "uname -r (the current release level of the OS)                        = $(uname -r)"
echo -e "uname -n (the name of the host)                                       = $(uname -n)"
echo -e "hostname (the name of the host)                                       = $(hostname)"
echo -e "uname -m (the type of current hardware platform)                      = $(uname -m)"
echo -e "uname -p (the machine processor architecture)                         = $(uname -p)"
echo -e "getconf _NPROCESSORS_CONF (number of processors, containing disabled) = $(getconf _NPROCESSORS_ONLN)"
echo -e "getconf _NPROCESSORS_ONLN (number of online processors)               = $(getconf _NPROCESSORS_ONLN)"
echo -e "nproc --all (number of processors)                                    = $(type nproc &> /dev/null && nproc --all || echo "[WARN] nproc not found")"
echo -e "echo \\\$LANG (the current locale)                                       = $(echo $LANG)"
echo -e "echo \\\$LANGUAGE (the current language)                                 = $(echo $LANGUAGE)"
echo -e "echo \\\$LC_ALL (the current locale)                                     = $(echo $LC_ALL)"
echo -e "umask (the current umask)                                             = $(umask)"
echo -e "getconf PAGESIZE (the page size)                                      = $(getconf PAGESIZE)"
echo
EOF
```

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

## tcpdump

```shell
# -i any       ->  在所有网络接口上捕获数据包
# -n           ->  直接显示 IP 地址，不将其解析为主机名
# 'port 5000'  ->  只捕获目标或源端口为 5000 的数据包
sudo tcpdump -i any -n 'port 5000'
```

## 查看机器重启的历史记录

```bash
last reboot -n 5  # Displays the last 5 system reboots
last reboot -F    # Displays the full date and time in the output
```

## 配置机器

```bash
sudo apt install build-essential -y
```

## locale

`LC_CTYPE: cannot change locale (UTF-8)` 错误解决：

```bash
export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8
```

## Debian 配置 apt 镜像源

一般情况下，将 `/etc/apt/sources.list` 文件中 Debian 默认的源地址 http://deb.debian.org/ 替换为镜像地址即可

> https://mirrors.tuna.tsinghua.edu.cn/help/debian/

```bash
sudo sed -i 's/^/#/' /etc/apt/sources.list

sudo tee -a /etc/apt/sources.list <<EOF
# 默认注释了源码镜像以提高 apt update 速度，如有需要可自行取消注释
deb https://mirrors.tuna.tsinghua.edu.cn/debian/ bookworm main contrib non-free non-free-firmware
# deb-src https://mirrors.tuna.tsinghua.edu.cn/debian/ bookworm main contrib non-free non-free-firmware
deb https://mirrors.tuna.tsinghua.edu.cn/debian/ bookworm-updates main contrib non-free non-free-firmware
# deb-src https://mirrors.tuna.tsinghua.edu.cn/debian/ bookworm-updates main contrib non-free non-free-firmware
deb https://mirrors.tuna.tsinghua.edu.cn/debian/ bookworm-backports main contrib non-free non-free-firmware
# deb-src https://mirrors.tuna.tsinghua.edu.cn/debian/ bookworm-backports main contrib non-free non-free-firmware
deb https://security.debian.org/debian-security bookworm-security main contrib non-free non-free-firmware
# deb-src https://security.debian.org/debian-security bookworm-security main contrib non-free non-free-firmware
EOF

sudo apt update
```

## Debian 12 配置 static IP

通过以下命令，找到一个网卡名称（例如 `enp0s1`，`inet 192.168.64.3 ... dynamic ...`）

```bash
ip addr
```

然后，编辑 `/etc/network/interfaces` 文件：

```bash
sudo vim /etc/network/interfaces
```

加入以下内容：

```bash
auto enp0s1               # enp0s1 从 ip addr 查出来
iface enp0s1 inet static  # enp0s1 从 ip addr 查出来
address 192.168.64.100    # 自己选的静态 IP
netmask 255.255.255.0
gateway 192.168.64.1
dns-nameservers 8.8.8.8   # 一定要配这个，不要忽略
```

重启 networking 服务即可：

```bash
sudo systemctl restart networking.server
```

再次 `ip addr` 查看是否配置生效
