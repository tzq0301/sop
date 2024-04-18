# Vim

## 中文乱码

先查看文件的编码是否是 UTF-8：

```bash
file xxx.txt
```

修改 ~/.vimrc，加上一下内容：

```text
set encoding=utf-8
```
