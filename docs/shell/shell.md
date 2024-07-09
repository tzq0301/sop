# Shell

* [Bash 脚本教程 - WangDoc](https://wangdoc.com/bash/)
* [cron 表达式](https://crontab.guru/#)

## command

```bash
command -v $COMMAND  # 查看某个命令是否存在

if command -v $COMMAND > /dev/null; then
  # 执行命令...
fi
```

## cd

```bash
# 作用等同于 cd -，且不会打印路径
cd ~-
```

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

## grep

```bash
# 正则匹配
grep -e pattern
grep -E pattern  # -E 表示“扩展正则”
grep -P pattern  # -P 表示“Perl 正则”

grep -E 'a|w'  # OR 或匹配

# “排除”匹配模式
grep -v '#'  # 去掉包含 # 的行（可以用于过滤“注释行”等）

# 查看指定内容上下几行
grep -10         '123' app.log # 前后 10 行
grep -C 10       '123' app.log # 前后 10 行
grep -A 10 -B 10 '123' app.log # 前后 10 行
grep -A 10       '123' app.log # 后 10 行（After）
grep -B 10       '123' app.log # 前 10 行（Before）

# 显示行号
grep -n
```

## pgrep

根据用户给出的信息在当前运行进程中查找并列出符合条件的进程 ID（PID）

```bash
$ pgrep rsync
294664

$ pgrep rsync -a
294664 ./bin/rsync-x86_64-linux-musl --daemon --config=/tmp/registry-test/rsyncd.conf
```

## [hgrep](https://github.com/rhysd/hgrep): Human-friendly GREP

```bash
# Use built-in subset of ripgrep (optional)
hgrep pattern ./dir

# Read results of grep command via stdin
grep -nH pattern -R ./dir | hgrep
rg -nH pattern ./dir | hgrep
```

## [ripgrep (rg)](https://github.com/BurntSushi/ripgrep)

```bash
rg pattern        # 搜索当前目录及其子目录（忽略 .gitignore 包含的文件/目录）
rg pattern -i     # 忽略大小写
rg pattern -t py  # 匹配文件类型（可用 rg --type-list 查看）
                  # 例如：-t py 对应 *.py 和 *.pyi；-t yaml 对应 *.yaml 和 *.yml
rg pattern -c     # 统计行数
rg pattern -w     # 匹配单词
```

## [bat](https://github.com/sharkdp/bat): A cat(1) clone with syntax highlighting and Git integration.

```bash
bat README.md      # 查看单个文件
bat src/*.rs       # 查看多个文件
bat -A /etc/hosts  # 高亮 non-printable characters
```

## [fd](https://github.com/sharkdp/fd): A simple, fast and user-friendly alternative to 'find'

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

## sed

```bash
# s -> substitute
# g -> global
sed 's/C++/CPP/g'  # 将 C++ 替换为 CPP 后的内容输出到标准输出
sed 's#C++#CPP#g'
sed 's@C++@CPP@g'
sed 's|C++|CPP|g'
   
sed -i 's/C++/CPP/g'  # 原地更新，将文件中的 C++ 替换为 CPP，-i <=> --in-place

# 给文件的每一行加上一个井号
sed 's/^/#/' 文件名 > 新文件名
sed -i 's/^/#/' 文件名  # 原地修改

sed -i.bak 's/C++/CPP/g' $FILENAME  # 将文件 $FILENAME 拷贝一份为 $FILENAME.bak，再对文件 $FILENAME 进行原地更新

# 匹配“扩展正则”
sed -r pattern
```

## awk

```bash
# awk 选项 '条件1 {动作1} 条件2 {动作2} 条件3 {动作3} ...'
# 
# 内置变量：
# * FILENAME 文件名
# * FNR 该行在某个文件中的行号
# * NR (Number of Record) 该行在 awk 输出的所有行中的行号
# * NF（Number of Field）每行有多少列，因此 $NF 可以表示最后一列
# * $0 表示“整行”
# * FS（Field Splitter）列分隔符（可以在 BEGIN 时进行修改）
# * RS（Row   Splitter）行分隔符（可以在 BEGIN 时进行修改）

awk 'NR==1'               # 取第一行
awk 'NR==1{print $0}'     # 取第一行
awk 'NR >= 2 && NR <= 5'  # 取第二行到第五行
awk '/ssh|shell/'         # 取所有包含 ssh 或 shell 的行
awk '/mysql/,/shell/'     # 取从“包含 mysql 的第一行”到“包含 shell 的最后一行”范围内的所有行 

awk '{print $5, $(NF-1), $NF}'  # 打印第 5 列、倒数第二列、倒数第一列

awk '{$1=""; $2=""; print }'  # 去掉第一列和第二列

awk '{$1=$1; print}'  # 去掉每行开头的空格

awk '$1 ~ /system/'   # 输出第一列包含 system 的所有行
awk '$1 !~ /system/'  # 输出第一列不包含 system 的所有行

awk '{print "my-prefix: "$0}'  # 为每一行加上前缀

awk -F ':' '{print $1}'  # 指定分隔符

free | awk '/Swap/ && $3 == 0{print "异常系统开始占用 swap"}'      # 如果 Swap 行的第三列的值大于 0，则打印信息
cat /etc/passwd | awk -F ':' '$4 ~ /^[01]/ {print $1, $3, $4}'  # 过滤出 /etc/passwd 第 4 列以 0 或 1 开头的所有行，并输出第 1、3、4 列

awk '{print} BEGIN{print "开始"} END{print "结束"}'  # 特殊 pattern BEGIN 和 END

seq 10 | awk '{i=i+1}; END{print i}'   # 统计行数，并在最后打印
seq 10 | awk '{i=i+$1}; END{print i}'  # 计算第一列的总和

awk '/PATTERN/{print; for(i=1;i<=3;++i) { getline; print; } }'  # 打印所有匹配 PATTERN 的行，并打印其后 3 行
```

## column 对齐每一列

```bash
column -t         # 制表
column -t -s ','  # 指定分隔符来制表
```

## tr

```bash
tr ' ' '\n'  # 替换 space 为换行符
```

## paste 合并多行

```bash
# -s      将多行合并为一行
# -d ","  指定分隔符
# -       从标准输入中读
printf a\\nb\\nc | paste -sd "," -  # a,b,c
```

## tee 在终端输出时，同时输出到文件

```bash
ls -a | tee output
```

## tail

```bash
tail -n +2 "$FILE"  # 去掉第一行

tail -10   "$FILE"  # 文件最后 10 行
tail -n 10 "$FILE"  # 文件最后 10 行
```

## wc

```bash
wc -l  # 统计行数
```

## mkdir

```bash
# -p 父目录不存在就自动创建
mkdir -p

# 在某个目录下，创建多个子目录
mkdir -p t/{a,b,c}
```

## tar

```bash
# x  -> 解压
# v  -> verbose 输出日志
# f  -> 指定文件
# -C -> 解压到目标文件夹，并 cd 到目标文件夹
tar xvf /mnt/gentoo/portage-latest.tar.gz -C /mnt/gentoo/usr

# --strip-components 1 -> 解压时，去掉一层目录
mkdir PRETTY_NAME && tar xf UGLY_NAME.tar -C PRETTY_NAME --strip-components 1

# z -> 使用 gzip 进行压缩（不加 -z 即为“仅归档、不压缩”）
tar zcf $Folder.tar.gz $Folder/  # .tar.gz 是经过 gzip 命令压缩过的 .tar 文件
tar  cf $Folder.tar    $Folder/  # .tar 文件：tar 是 Tape Archive 的缩写，表示归档
```

macOS 上的 tar 命令，默认使用 BSD tar，而 Linux 默认使用 GNU tar；BSD tar 在创建归档文件的同时加入了一些 macOS 文件特有的扩展属性，如 xattr.com.apple.quarantine，这些信息不被 GNU tar 所识别，因此需要使用 --no-xattrs 选项来忽略这些属性：

```bash
# tar: Ignoring unknown extended header keyword 'LIBARCHIVE.xattr.com.apple.quarantine'
# tar: Ignoring unknown extended header keyword 'LIBARCHIVE.xattr.com.apple.provenance'
# tar: Ignoring unknown extended header keyword 'LIBARCHIVE.xattr.com.apple.metadata:kMDItemWhereFroms'
# tar: Ignoring unknown extended header keyword 'LIBARCHIVE.xattr.com.apple.macl'

tar --no-xattrs -zcvf <tar_file> <file>
```

## basename & dirname

```bash
basename a/b/ccc.gz      # ccc.gz
basename a/b/ccc.gz .gz  # ccc

basename -s .gz a/b/ccc.gz  # ccc

dirname a/b/ccc.gz  # a/b
```

## 展示当前时间

```bash
date '+%Y-%m-%d %H:%M:%S'  # 2024-04-28 08:04:14
date '+%Y%m%d%H%M%S'       # 20240428080414
```

## 查看文件大小

```bash
ls -lSh
du -h | sort -hr
```

## apt

```bash
# 安静模式（q 从 1 到 2，数量越多越安静）
# -qq 暗示了 -y
sudo apt update  -qq
sudo apt install -qq iptables

# 强制 apt install 不下载其“推荐”的软件包，以减少软件包的下载与安装
sudo apt install --no-install-recommends ...
```

## yum

```bash
# To see what particular versions are available to you via yum you can use the --showduplicates switch . It gives you a list like "package name.architecture version":
yum --showduplicates list httpd | expand

# If you're ever unsure that you're constructing the arguments right you can consult with repoquery too.
$ sudo yum install yum-utils  # (to get `repoquery`)
$ repoquery --show-duplicates httpd-2.4*
httpd-0:2.4.6-6.fc20.x86_64
httpd-0:2.4.10-1.fc20.x86_64
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

## 传输文件

scp 对每个文件使用一个进程进行传输，而 rsync 只使用一个进程，因此一般 rsync 性能更高

rsync 只会传输修改的部分而不是整个文件，这使得 rsync 在需要更新或备份的情况下效率更高

```bash
# 将 source_folder 目录下的内容，copy 到 dest_folder 目录下
rsync -r source_folder/ dest_folder/ 

# 将 source_folder 目录，copy 到 dest_folder 目录下（以下若干种等价）
rsync -r source_folder  dest_folder/
rsync -r source_folder/ dest_folder/source_folder

# -r 递归
# -v 输出更多信息
# -e "ssh -i ~/.ssh/id_rsa" 指定密钥
rsync -r -v -e "ssh -i ~/.ssh/id_rsa" tmp/ hello@192.168.1.1:/tmp/abc
```

## 下载文件 wget

```bash
wget -O 新名字    URL
wget -P 目标文件夹 URL

# -q    不打印信息
# -O -  输出到标准输出
wget -q -O - URL
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

## 使用 EOF 写入多行文本

NOTE: 若文本中包含 `$` 则会直接执行，因此需要加上反斜杠进行转义，例如 `\$UserName` 而不是 `$UserName`

```bash
cat <<EOF > hello.txt
foo
bar
EOF

sudo tee -a hello.txt <<EOF
foo
bar
EOF
```

## 用户输入 read

让用户输入 yes 再执行下一步：

```bash
read -r -p "Please type 'yes' to continue: " input 
if [ "$input" != "yes" ]; then 
    echo "You did not enter 'yes'. Exit..."
    exit 1
fi
```

让用户输入（但不关注内容）：

```bash
echo "请按回车键继续"
read -p ""
```

## mktemp

创建临时文件：

```bash
#!/bin/bash
TMPFILE=$(mktemp) || exit 1  # 确保临时文件创建成功
trap 'rm -rf $TMPFILE' EXIT  # 保证脚本退出时临时文件被删除

echo "Our temp file is $TMPFILE"
```

创建临时文件夹：

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

echo -e "I ${RED}love${NC} Stack Overflow"
# printf "I ${RED}love${NC} Stack Overflow\n"
```

## 参数解析

[How do I parse command line arguments in Bash?](https://stackoverflow.com/a/14203146/16189360)

```bash
#!/bin/bash

function usage() {
  echo "Usage: "
  echo "  -e|--extension <extension>:   File extension to search for"
  echo "  -s|--searchpath <searchpath>: Path to search for files"
  echo "  --default:                    Use default values"
}

while [[ $# -gt 0 ]]; do
  case $1 in
    -e|--extension)
      EXTENSION="$2"
      shift # past argument
      shift # past value
      ;;
    -s|--searchpath)
      SEARCHPATH="$2"
      shift # past argument
      shift # past value
      ;;
    --default)
      DEFAULT=YES
      shift # past argument
      ;;
    *)
      echo "Unknown option $1"
      usage
      exit 1
      ;;
  esac
done

echo "FILE EXTENSION  = ${EXTENSION}"
echo "SEARCH PATH     = ${SEARCHPATH}"
echo "DEFAULT         = ${DEFAULT}"
echo "Number files in SEARCH PATH with EXTENSION:" "$(ls -1 "${SEARCHPATH}"/*."${EXTENSION}" | wc -l)"

if [[ -n $1 ]]; then
    echo "Last line of file specified as non-opt/last argument:"
    tail -1 "$1"
fi
```

## 前置检查：某工具是否存在

```bash
RED='\033[0;31m'
NC='\033[0m' # No Color

jq --version >& /dev/null || (echo -e "${RED}jq${NC} not found" && exit 1)
ansible-playbook --version >& /dev/null || (echo -e "${RED}ansible-playbook${NC} not found" && exit 1)
```

## 查看文件是否存在

```bash
if [ ! -f /tmp/foo.txt ]; then
  echo "file not found!"
  exit 1
fi
```

## 要求 root 或 sudo 运行脚本

```bash
if [ `id -u` -ne 0 ]
  then echo Please run this script as root or using sudo!
  exit
fi
```

## 实现 sudo 免密提权

```bash
# UserName=$USER
UserName=
echo "$UserName ALL=(ALL) NOPASSWD:ALL" | sudo tee -a /etc/sudoers > /dev/null
```

## 示例：创建用户（并创建同名用户组、配置密码、免密提权）

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
