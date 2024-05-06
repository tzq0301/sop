# Shell Scripts

## 使用 EOF 写入多行文本

NOTE: 若文本中包含 `$` 则会直接执行，因此需要加上反斜杠进行转义，例如 `\$UserName` 而不是 `$UserName`

```bash
cat <<EOF > hello.txt
foo
bar
EOF
```

## Shell 脚本设置执行模式

```bash
set -x           # 启用跟踪模式，即 shell 会在执行每个命令之前将该命令打印出来，然后再执行它
set -e           # 设置错误退出模式，当任何命令返回非零退出状态码时，shell 将会立即终止执行，并退出脚本
set -u           # 启用参数检查，如果尝试使用一个未定义的变量，shell 将会引发错误并终止脚本的执行
set -o pipefail  # 当管道中的某个命令失败时，终止整个管道的执行
```

## Bash 环境变量

* `HOME`：用户的主目录
* `HOST`：当前主机的名称
* `PWD`：当前工作目录
* `RANDOM`：返回一个 0 到 32767 之间的随机数
* `SHELL`：Shell 的名字
* `UID`：当前用户的 ID 编号
* `USER`：当前用户的用户名
* `$?`：上一个命令的退出码，用来判断上一个命令是否执行成功（返回值是 0，表示上一个命令执行成功；如果不是 0，表示上一个命令执行失败）
* `$$`：当前 Shell 的进程 ID，这个特殊变量可以用来命名临时文件，例如：`LOGFILE=/tmp/output_log.$$`
* `$!`：最近一个后台执行的异步命令的进程 ID（用 `&` 执行的）
* `$0`：当前 Shell 的名称（在命令行直接执行时）或者脚本名（在脚本中执行时）
* `$#`：脚本的参数数量
* `$@`：脚本的参数值
* 设置默认值
  * `${varname:-word}`：如果 `varname` 存在且不为空，则返回它的值；否则，返回我们指定的默认值 `word`
  * `${varname:=word}`：如果 `varname` 存在且不为空，则返回它的值；否则，将 `varname` 设定为我们指定的默认值 `word`
  * `${varname:+word}`：如果 `varname` 存在且不为空，则返回我们指定的默认值 `word`；否则，返回空值
  * `${varname:?message}`：如果 `varname` 存在且不为空，则返回它的值；否则，打印 `message` 并中断脚本执行（用于防止变量未定义）
* `readonly foo=1` 将 `foo` 设置为只读变量

## Shell 整数运算、进制转换

```bash
echo $((2*3))  # 6

# echo $((N#xx)) 将其他进制转成十进制数
# N 为进制，xx 为该进制下某个数值，命令执行后可以得到该进制数转成十进制后的值
echo $((2#110))  # 6
echo $((16#2a))  # 42
```

## Shell 脚本中让用户输入 yes

场景：让用户输入 yes 再执行下一步

```bash
read -p "Please type 'yes' to continue: " input 
if [ "$input" != "yes" ]; then 
    echo "You did not enter 'yes'. Exit..."
    exit 1
fi
```

## mktemp 创建临时文件

```bash
#!/bin/bash
TMPFILE=$(mktemp) || exit 1  # 确保临时文件创建成功
trap 'rm -rf $TMPFILE' EXIT  # 保证脚本退出时临时文件被删除

echo "Our temp file is $TMPFILE"
```

## mktemp 创建临时文件夹

```bash
#!/bin/bash
TMPDIR=$(mktemp -d) || exit 1  # 确保临时文件夹创建成功
trap 'rm -rf $TMPDIR' EXIT     # 保证脚本退出时临时文件夹被删除

echo "Our temp dir is $TMPDIR"
```

## 终端文本颜色

参考 [How to change the output color of echo in Linux](https://stackoverflow.com/questions/5947742/how-to-change-the-output-color-of-echo-in-linux)

```bash
RED='\033[0;31m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
GREEN='\033[0;32m'
NC='\033[0m' # No Color
printf "I ${RED}love${NC} Stack Overflow\n"
```

## Shell Script 查看文件是否存在

```bash
if [ ! -f /tmp/foo.txt ]; then
  echo "file not found!"
  exit 1
fi
```

## Shell Script 要求 root 或 sudo 运行脚本

```bash
if [ `id -u` -ne 0 ]
  then echo Please run this script as root or using sudo!
  exit
fi
```

## 实现 sudo 免密提权

```bash
UserName=
echo "$UserName ALL=(ALL) NOPASSWD:ALL" | sudo tee -a /etc/sudoers > /dev/null
```

## 示例：Shell Script 创建用户（同名用户组、配置密码、免密提权）

```bash
#!/usr/bin/env bash

set -xeuo pipefail

# 需要以 root 运行，或者 sudo
if [ `id -u` -ne 0 ]
  then echo Please run this script as root or using sudo!
  exit
fi

UserID=3001
UserName=hello
UserPwd=world

# -m        创建用户的 home 目录，默认为 /home/$UserName
# -s SHELL  指定用户的 login shell
# -u UID    指定用户的 User ID
# -U        创建用户组，默认创建于 UserName 同名的用户组
useradd \
  -m \
  -s /bin/bash \
  -u $UserID \
  -U \
  $UserName

id $UserName

# 配置密码
echo "$UserName:$UserPwd" | chpasswd

# 免密提权
echo "$UserName ALL=(ALL) NOPASSWD:ALL" | sudo tee -a /etc/sudoers > /dev/null
```