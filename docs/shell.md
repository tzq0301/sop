# Shell

## Vim

执行 Unix 命令：按下 `Esc` 返回命令模式，`:!unix_command` 即可

处理中文乱码：

```bash
tee -a ~/.vimrc <<EOF
set encoding=utf-8
EOF
```

## zsh

安装 [zsh](https://github.com/ohmyzsh/ohmyzsh/wiki/Installing-ZSH)

```bash
sudo apt install zsh -y  # Debian
brew install zsh         # macOS
```

安装 [Oh My Zsh](https://ohmyz.sh/#install)

```bash
sh -c "$(curl -fsSL https://gitee.com/mirrors/oh-my-zsh/raw/master/tools/install.sh)"
# sh -c "$(wget -O- https://gitee.com/pocmon/mirrors/raw/master/tools/install.sh)"
# sh -c "$(curl -fsSL https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
# sh -c "$(wget https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh -O -)"
```

[zsh-syntax-highlighting](https://github.com/zsh-users/zsh-syntax-highlighting/blob/master/INSTALL.md) 语法高亮

[zsh-autosuggestions](https://github.com/zsh-users/zsh-autosuggestions/blob/master/INSTALL.md) 根据历史记录和完成情况进行提示
