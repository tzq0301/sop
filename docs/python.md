# Python

## 安装 Python 3，并配置为默认 Python Interpreter

> 自动版：`sudo apt update && sudo apt upgrade python3`

安装编译 Python 源码所需要的组件

```bash
apt-get install wget build-essential libreadline-gplv2-dev libncursesw5-dev libssl-dev libsqlite3-dev tk-dev libgdbm-dev libc6-dev libbz2-dev libffi-dev zlib1g-dev liblzma-dev -y
```

在 [Python 官方下载页面](https://www.python.org/downloads/source/) 中，找一个 Gzipped source tarball 的 Python 发行版，并“复制链接地址”（或者在 [华为云镜像站](https://mirrors.huaweicloud.com/python/) 找一个），进行下载

```bash
# 下载 Python 源码（找 .tgz 后缀的）
URL=你的链接  # URL=https://mirrors.huaweicloud.com/python/3.12.3/Python-3.12.3.tgz
wget $URL

# 解压下载的压缩包
tar zxvf $(basename "$URL")

# 进入目录
cd $(basename "$URL" .tgz)

# 编译源码，并进行安装
./configure --enable-optimizations
sudo make altinstall  # 默认安装在 /usr/bin；如果不想覆盖默认的 Python，可以使用 altinstall 将 Python 安装在 /usr/local/bin
```

查看 `/usr/local/bin` 目录下的 Python 解释器，选择一个，将其设置为默认的 Python 解释器

```bash
ls /usr/local/bin/python*  # 查看可选的 Python 解释器
PY=                        # 从上一步显示的若干个 Python 解释器中，选择一个，设置为 PY 临时环境变量，例如 PY=/usr/local/bin/python3.12

sudo update-alternatives --install /usr/bin/python  python  $PY 1  # 设置为默认的 Python 解释器
sudo update-alternatives --install /usr/bin/python3 python3 $PY 1  # 设置为默认的 Python 3 解释器

# 校验是否配置成功
python -V
python3 -V
python3 -m pip -V  # pip3 -V
```

## pip 配置国内镜像源

```bash
mkdir ~/.pip

cat <<EOF >~/.pip/pip.conf
[global]
index-url = https://pypi.tuna.tsinghua.edu.cn/simple
[install]
trusted-host = https://pypi.tuna.tsinghua.edu.cn
EOF

pip3 config list  # 查看镜像地址，验证是否已经成功修改镜像
```

| 镜像站 | 链接 |
| ---- | ---- |
| 华为镜像源 | [https://mirrors.huaweicloud.com/](https://mirrors.huaweicloud.com/) |
| 阿里云 | [http://mirrors.aliyun.com/pypi/simple/](http://mirrors.aliyun.com/pypi/simple/) |
| 中国科学技术大学 | [http://pypi.mirrors.ustc.edu.cn/simple/](http://pypi.mirrors.ustc.edu.cn/simple/) |
| 清华大学 | [https://pypi.tuna.tsinghua.edu.cn/simple/](https://pypi.tuna.tsinghua.edu.cn/simple/) |
| 浙江大学开源镜像站 | [http://mirrors.zju.edu.cn/](http://mirrors.zju.edu.cn/) |
| 腾讯开源镜像站 | [http://mirrors.cloud.tencent.com/pypi/simple](http://mirrors.cloud.tencent.com/pypi/simple) |
| 豆瓣 | [http://pypi.douban.com/simple/](http://pypi.douban.com/simple/) |
| 网易开源镜像站 | [http://mirrors.163.com/](http://mirrors.163.com/) |
| 搜狐开源镜像 | [http://mirrors.sohu.com/](http://mirrors.sohu.com/) |
