# Docker

## 使用 non-root user 管理 Docker

> The docker group grants root-level privileges to the user. For details on how this impacts security in your system, see Docker Daemon Attack Surface.

```bash
sudo groupadd docker
sudo usermod -aG docker $USER
newgrp docker  # or logout and log back to make sure that your group membership is re-evaluated
```

## Docker 导出/加载镜像

```bash
docker save -o helloworld.tar nju/hello-world:1.0.0
docker load -i helloworld.tar
```
