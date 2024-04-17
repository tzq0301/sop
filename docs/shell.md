# Shell

## ls

* -l 使用 long listing format
* -t 根据时间排序
* -S 根据文件大小排序
* -r 在排序时反转顺序
* -h 提高可读性 human readable

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
