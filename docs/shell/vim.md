# Vim

## 执行 Unix 命令

按下 `Esc` 返回命令模式，`:!unix_command` 即可

## 中文乱码

```bash
tee -a ~/.vimrc <<EOF
set encoding=utf-8
EOF
```

---

先查看文件的编码是否是 UTF-8：

```bash
file xxx.txt
```

修改 ~/.vimrc

```bash
vim ~/.vimrc
```

加上一下内容：

```text
set encoding=utf-8
```
