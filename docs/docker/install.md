# Docker 安装

## 配置镜像源

若无 `/etc/docker/daemon.json` 文件，则执行以下命令（若存在该命令，则照猫画虎，修改对应 json 属性即可）：

```bash
sudo tee /etc/docker/daemon.json <<EOF
{
  "registry-mirrors": [
    "https://hub-mirror.c.163.com",
    "https://mirror.baidubce.com"
  ]
}
EOF
```

重新启动服务即可：

```bash
sudo systemctl daemon-reload
sudo systemctl restart docker
```
