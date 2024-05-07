# Shell 命令

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

## mkdir

```bash
# -p 父目录不存在就自动创建
mkdir -p

# 在某个目录下，创建多个子目录
mkdir -p t/{a,b,c}
```

## tar 解压

```bash
# x  -> 解压
# v  -> verbose 输出日志
# f  -> 指定文件
# -C -> 解压到目标文件夹，并 cd 到目标文件夹
tar xvf /mnt/gentoo/portage-latest.tar.gz -C /mnt/gentoo/usr
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

## 传输文件

scp 对每个文件使用一个进程进行传输，而 rsync 只使用一个进程，因此一般 rsync 性能更高

rsync 只会传输修改的部分而不是整个文件，这使得 rsync 在需要更新或备份的情况下效率更高

```bash
# 将 source_folder 目录下的内容，copy 到 dest_folder 目录下
rsync -r source_folder/ dest_folder/ 

# 将 source_folder 目录，copy 到 dest_folder 目录下（以下若干种等价）
rsync -r source_folder  dest_folder/
rsync -r source_folder/ dest_folder/source_folder
```
