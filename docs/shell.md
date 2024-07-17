# Shell

* [SSH 教程 - WangDoc](https://wangdoc.com/ssh/client)

## 实用工具

* [bat](https://github.com/sharkdp/bat): `bat -pp` <=> `cat`
* [fd](https://github.com/sharkdp/fd)
* [fzf](https://github.com/junegunn/fzf)
* [glow](https://github.com/charmbracelet/glow): markdown renderer in terminal
* [httpie](https://github.com/httpie/cli)
* [Hurl](https://hurl.dev/)
* [ripgrep (rg)](https://github.com/BurntSushi/ripgrep)
* [yq](https://github.com/mikefarah/yq)

## 设置 alias

```bash
if [[ -z "${aliases[l]}" ]]; then
    alias l="ls -alFh"
fi
```

## 机器信息 & 操作系统信息

```bash
hostnamectl
```

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
echo -e "cat /proc/meminfo | grep MemTotal | awk '{print \\\$2}' (total memory)   = $(cat /proc/meminfo | grep MemTotal | awk '{print $2}')"
echo -e "df --total -h | grep -e total | awk '{print \\\$2}' (total disk space)   = $(df --total -h | grep -e total | awk '{print $2}')"
echo -e "echo \\\$LANG (the current locale)                                       = $(echo $LANG)"
echo -e "echo \\\$LANGUAGE (the current language)                                 = $(echo $LANGUAGE)"
echo -e "echo \\\$LC_ALL (the current locale)                                     = $(echo $LC_ALL)"
echo -e "umask (the current umask)                                             = $(umask)"
echo -e "getconf PAGESIZE (the page size)                                      = $(getconf PAGESIZE)"
echo
EOF
```

## 安装常用工具

```bash
sudo apt install -y build-essential cmake git
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

## ssh 执行脚本

```bash
ssh $UserName@$IP 'bash' < $SHELL_FILEPATH

# -s 后面可以跟 Shell 文件所需要的参数
ssh $UserName@$IP 'bash -s 1 2 abc' < $SHELL_FILEPATH

ssh $UserName@$IP 'bash' <<EOF
echo 1
echo 2
EOF
```

## 生成 ssh 密钥

默认会生成（1）公钥文件 ~/.ssh/id_rsa.pub（2）私钥文件 ~/.ssh/id_rsa

```bash
ssh-keygen -t rsa -N "" -C "user=$USER hostname=$HOSTNAME" -f "$HOME/.ssh/id_rsa"
```

生成密钥以后，建议修改它们的权限，防止其他人读取：

```bash
chmod 600 ~/.ssh/id_rsa
chmod 600 ~/.ssh/id_rsa.pub
```

## ssh 连接远程服务器

```bash
UserName=
UserPwd=
Host=
sshpass -p $UserPwd ssh $UserName@$Host
```

## 实现免密登录 - 将自己的 ssh 公钥 copy 到服务器上

将本机的 ~/.ssh/id_rsa.pub 公钥追加到远程服务器的 ~/.ssh/authorized_keys

```bash
UserName= && UserPwd= && IP=
sshpass -p $UserPwd ssh-copy-id $UserName@$IP
```

## 测试是否能 ssh 到服务器

```bash
host=
username=
(ssh "$username@$host" -o StrictHostKeyChecking=accept-new true &> /dev/null && echo "ssh connection ok for host: $host") || (echo "fail for host: $host" && exit 1)
```

## WARNING: REMOTE HOST IDENTIFICATION HAS CHANGED!

如果服务器的密钥发生变更（比如重装了 SSH 服务器、有人恶意冒充远程主机），客户端再次连接时，就会发生公钥指纹不吻合的情况，这时，客户端就会中断连接，并显示警告信息

如果新的公钥确认可以信任，需要继续执行连接，你可以执行下面的命令，将原来的公钥指纹从 `~/.ssh/known_hosts` 文件删除

```bash
HOSTNAME=发生公钥变更的主机名
ssh-keygen -R $HOSTNAME
```

## locale

`LC_CTYPE: cannot change locale (UTF-8)` 错误解决：

```bash
export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8
```

## Vim

执行 Unix 命令：按下 `Esc` 返回命令模式，`:!unix_command` 即可

处理中文乱码：

```bash
tee -a ~/.vimrc <<EOF
set encoding=utf-8
EOF
```

## zsh

安装 [zsh](https://github.com/ohmyzsh/ohmyzsh/wiki/Installing-ZSH)

```bash
sudo apt install zsh -y  # Debian
brew install zsh         # macOS
```

安装 [Oh My Zsh](https://ohmyz.sh/#install)

```bash
sh -c "$(curl -fsSL https://gitee.com/mirrors/oh-my-zsh/raw/master/tools/install.sh)"
# sh -c "$(wget -O- https://gitee.com/pocmon/mirrors/raw/master/tools/install.sh)"
# sh -c "$(curl -fsSL https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
# sh -c "$(wget https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh -O -)"
```

[zsh-syntax-highlighting](https://github.com/zsh-users/zsh-syntax-highlighting/blob/master/INSTALL.md) 语法高亮

[zsh-autosuggestions](https://github.com/zsh-users/zsh-autosuggestions/blob/master/INSTALL.md) 根据历史记录和完成情况进行提示

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
