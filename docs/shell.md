# Shell

## ls

* **-l 使用 long listing format**
* -t 根据时间排序
* **-S 根据文件大小排序**
* -r 在排序时反转顺序
* **-h 提高可读性 human readable**

```bash
~ ls -lSh # 根据文件大小排序
total 81M
-rw-r--r--  1 minibase minibase  81M Mar 27 10:32 minibase-titan-2.16.0.tar.gz
drwxr-xr-x  3 minibase minibase 4.0K Mar 27 11:17 MiniBase
drwxr-xr-x  3 minibase minibase 4.0K Mar 27 11:17 pyenv
drwxrwxr-x  9 minibase minibase 4.0K Mar 27 18:12 rke-tools
drwxr-xr-x 17 minibase minibase 4.0K Mar 27 16:27 titan
-rw-------  1 minibase minibase  513 Mar 27 11:15 Deploy.key
-rw-rw-r--  1 minibase minibase  393 Mar 28 14:09 mysql-validate.yaml
-rw-r--r--  1 minibase minibase  183 Mar 27 11:15 Deploy.key.pub
```

## grep “或”匹配

```bash
$ cat demo.txt | grep a
bar
```

```bash
$ cat demo.txt | grep w
world
wow
```

```bash
$ cat demo.txt | grep -E 'a|w' # OR 或
bar
world
wow
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

## tr 替换 space 为换行符

```bash
tr ' ' '\n'
```

## tee 在终端输出时，同时输出到文件

```bash
ls -a | tee output
```

## mkdir 父目录不存在就自动创建

```bash
mkdir -p
```

## 查看 Linux 发行版

```bash
hostnamectl
```

## 获取内存大小（纯数字）

```bash
cat /proc/meminfo | grep MemTotal | awk '{print $2}'
# 16152104 即为 16G
```

## 强制 apt install 不下载其“推荐”的软件包，以减少软件包的下载与安装

```bash
sudo apt install --no-install-recommends ...
```

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

```bash
cat <<EOF > hello.txt
foo
bar
EOF
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

## Shell 脚本设置执行模式

```bash
set -x  # 启用跟踪模式，即 shell 会在执行每个命令之前将该命令打印出来，然后再执行它
set -e  # 设置错误退出模式，当任何命令返回非零退出状态码时，shell 将会立即终止执行，并退出脚本
set -u  # 启用参数检查，如果尝试使用一个未定义的变量，shell 将会引发错误并终止脚本的执行
```
