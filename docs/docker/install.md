# Docker 安装

## Post Steps

```bash
sudo groupadd docker  # 这步一般会报“group 已存在”的错误，忽视即可，该报错符合预期

sudo usermod -aG docker $USER

# 打开一个新的终端，即可使用 docker 命令而无需 sudo
```

## 安装 buildx 插件，支持多架构构建

根据 https://docs.docker.com/engine/install/ 安装 docker-buildx-plugin

```bash
docker buildx create --name multiarch --platform linux/amd64,linux/arm64 --use --bootstrap
```

## 配置镜像源

* https://do.nark.eu.org

若无 `/etc/docker/daemon.json` 文件，则执行以下命令（若存在该命令，则照猫画虎，修改对应 json 属性即可）：

```bash
sudo tee /etc/docker/daemon.json <<EOF
{
  "registry-mirrors": [
    "https://do.nark.eu.org"
  ]
}
EOF
```

或者：

```bash
sudo yq -i '.registry-mirrors += ["https://do.nark.eu.org"]' /etc/docker/daemon.json
```

重新启动服务即可：

```bash
sudo systemctl daemon-reload
sudo systemctl restart docker
```
