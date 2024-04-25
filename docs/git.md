# Git

## git config 配置

```bash
git config --global core.editor "vim"
git config --global user.name   "John Doe"
git config --global user.email  "johndoe@example.com"
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

## 示例：.gitignore

```text
.idea/
.fleat/
.vscode/
.settings/

.DS_Store
.AppleDouble
.LSOverride
Icon
.Spotlight-V100
.Trashes

Thumbs.db
ehthumbs.db
Desktop.ini

*.log

*.sqlite
*.db

*.war
*.jar
*.class
*.exe
*.exe~
*.out
*.o
*.so
*.ddl
*.dylib

*.7z
*.dmg
*.gz
*.iso
*.jar
*.rar
*.tar
*.zip

target/
out/
build/

go.work
*.test
*.prof
vendor/
*.out
```

添加后，gitignore 可能不会生效，此时运行以下命令：

```bash
git rm -rf --cached .
git add .
```
