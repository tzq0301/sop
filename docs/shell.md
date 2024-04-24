# Shell

* [Bash 脚本教程 - WangDoc](https://wangdoc.com/bash/)

## ls

* **-l 使用 long listing format**
* -t 根据时间排序
* **-S 根据文件大小排序**
* -r 在排序时反转顺序
* **-h 提高可读性 human readable**

```bash
~ ls -lSh # 根据文件大小排序
total 81M
total 52K
-rw-rw-rw- 1 codespace codespace 4.8K Apr 20 14:21 shell.md
-rw-rw-rw- 1 codespace codespace 4.4K Apr 18 03:26 nginx.md
-rw-rw-rw- 1 codespace codespace 4.0K Apr 19 06:53 mysql.md
-rw-rw-rw- 1 codespace codespace 2.2K Apr 20 09:40 ssh.md
-rw-rw-rw- 1 codespace codespace 2.0K Apr 18 05:10 docker.md
-rw-rw-rw- 1 codespace codespace 1.3K Apr 20 10:47 regexp.md
-rw-rw-rw- 1 codespace codespace  862 Apr 18 04:51 git.md
-rw-rw-rw- 1 codespace codespace  772 Apr 18 05:26 earlyoom.md
-rw-rw-rw- 1 codespace codespace  661 Apr 18 04:23 cpp.md
-rw-rw-rw- 1 codespace codespace  201 Apr 18 05:00 javascript.md
-rw-rw-rw- 1 codespace codespace  166 Apr 18 02:56 vim.md
```

## grep 正则匹配

```bash
grep -e pattern
grep -E pattern  # -E 表示“扩展正则”
grep -P pattern  # -P 表示“Perl 正则”

# 例如 OR 或匹配
grep -E 'a|w' 
```

## grep “排除”匹配模式

```bash
grep -v '#'  # 去掉包含 # 的行（可以用于过滤“注释行”等）
```

## grep 查看指定内容上下几行

```bash
grep -10         '123' app.log # 前后 10 行
grep -C 10       '123' app.log # 前后 10 行
grep -A 10 -B 10 '123' app.log # 前后 10 行
grep -A 10       '123' app.log # 后 10 行（After）
grep -B 10       '123' app.log # 前 10 行（Before）
```

## grep 显示行号

```bash
grep -n
```

## sed 获取指定行

```bash
# -n 静默模式，防止输出文件全部内容

sed -n '3p'     # 获取第 3 行
sed -n '2p;5p'  # 获取第 2 行和第 5 行
sed -n '2,5p'   # 获取第 2 ~ 5 行
sed -n '2,$p'   # 获取第 2 ~ 最后一行
sed -n '1~3p'   # 从第 1 行开始获取，step 为 3
                # seq 20 | sed -n '1~3p' | tr '\n' ' ' 的输出结果是 1 4 7 10 13 16 19

sed -n '/pattern/p'      # 获取与 pattern 相匹配的所有行
sed -n '/2017/,/2024/p'  # 范围获取“最先的包含字符串 2017 的行”到“最后的包含字符串 2024 的行”
```

## sed 替换内容

```bash
# s -> substitute
# g -> global
sed 's/C++/CPP/g'  # 将 C++ 替换为 CPP 后的内容输出到标准输出
sed 's#C++#CPP#g'
sed 's@C++@CPP@g'
sed 's|C++|CPP|g'
   
sed -i 's/C++/CPP/g'  # 原地更新，将文件中的 C++ 替换为 CPP，-i <=> --in-place

sed -i.bak 's/C++/CPP/g' $FILENAME  # 将文件 $FILENAME 拷贝一份为 $FILENAME.bak，再对文件 $FILENAME 进行原地更新
```

## sed “扩展正则”匹配

```bash
sed -r pattern
```

## awk

```bash
# awk 选项 '条件{动作}'
# * NR (Number of Record) 行号
# * NF（Number of Field）每行有多少列，因此 $NF 可以表示最后一列
# * $0 表示“整行”

awk 'NR==1'               # 取第一行
awk 'NR==1{print $0}'     # 取第一行
awk 'NR >= 2 && NR <= 5'  # 取第二行到第五行
awk '/ssh|shell/'         # 取所有包含 ssh 或 shell 的行
awk '/mysql/,/shell/'     # 取从“包含 mysql 的第一行”到“包含 shell 的最后一行”范围内的所有行 

awk '{print $5, $(NF-1), $NF}'  # 打印第 5 列、倒数第二列、倒数第一列

awk '$1 ~ /system/'   # 输出第一列包含 system 的所有行
awk '$1 !~ /system/'  # 输出第一列不包含 system 的所有行

awk -F ':' '{print $1}'  # 指定分隔符

free | awk '/Swap/ && $3 == 0{print "异常系统开始占用 swap"}'      # 如果 Swap 行的第三列的值大于 0，则打印信息
cat /etc/passwd | awk -F ':' '$4 ~ /^[01]/ {print $1, $3, $4}'  # 过滤出 /etc/passwd 第 4 列以 0 或 1 开头的所有行，并输出第 1、3、4 列

seq 10 | awk -F ':' '{i=i+1}; END{print i}'   # 统计行数，并在最后打印
seq 10 | awk -F ':' '{i=i+$1}; END{print i}'  # 计算第一列的总和
```

## column 对齐每一列

```bash
column -t         # 制表
column -t -s ','  # 指定分隔符来制表
```

## tr 替换 space 为换行符

```bash
tr ' ' '\n'
```

## tee 在终端输出时，同时输出到文件

```bash
ls -a | tee output
```

## tail 去掉第一行

```bash
tail -n +2 "$FILE"
```

## wc 统计行数

```bash
wc -l
```

## mkdir 父目录不存在就自动创建

```bash
mkdir -p
```

## tar 解压

```bash
# x -> 解压
# v  -> verbose 输出日志
# f  -> 指定文件
# -C -> 解压到目标文件夹，并 cd 到目标文件夹
tar xvf /mnt/gentoo/portage-latest.tar.gz -C /mnt/gentoo/usr
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

## 强制 apt install 不下载其“推荐”的软件包，以减少软件包的下载与安装

```bash
sudo apt install --no-install-recommends ...
```

## 输入输出重定向

Shell 中，总有三个文件处于打开状态 —— 标准输入（键盘输入）、标准输出（输出到屏幕）、标准错误（输出到屏幕），分别对应的文件描述符（file description）为 0、1、2

* `>` 等价于 `1>`，即为“标准输出”重定向
* `2>&1` 把“标准错误”重定向到“标准输出”
* `&> file` 将“标准输出”和“标准错误”都重定向到文件 file 中
* `/dev/null` 是一个特殊文件，所有重定向到该文件的内容都会被丢弃掉，即当不想看到“输出”时可以使用 `> /dev/null` 或 `&> /dev/null`

## 清空一个文件的内容

```bash
:> $FILE
# or
truncate -s 0 $FILE  # "-s 0" to specify the size
# or
cat /dev/null > $FILE
# or
dd if=/dev/null of=$FILE
```

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

trap 'rm -f "$TMPFILE"' EXIT  # 保证脚本退出时临时文件被删除

TMPFILE=$(mktemp) || exit 1   # 确保临时文件创建成功
echo "Our temp file is $TMPFILE"
```

## 终端文本颜色

参考 [How to change the output color of echo in Linux](https://stackoverflow.com/questions/5947742/how-to-change-the-output-color-of-echo-in-linux)

```bash
RED='\033[0;31m'
NC='\033[0m' # No Color
echo "I ${RED}love${NC} Stack Overflow\n"
```

## Shell 要求 root 或 sudo 运行脚本

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
