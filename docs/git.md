# Git

## git config 配置

```bash
git config --global core.editor "vim"
git config --global user.name "John Doe"
git config --global user.email johndoe@example.com
```

检查配置：

```bash
git config --list
```

## git commit --amend 不修改 commit message

```bash
git commit --amend --no-edit
```

## git log 一个 commit 在一行内显示

```bash
git log --online
```