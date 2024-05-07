# Docker

## build & run 

```bash
docker run --rm $(docker build . -q)
```

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

docker export busybox > busybox.tar
docker import busybox.tar busybox:test
```

## buildx 构建多架构镜像

```bash
docker buildx build \
  --platform linux/amd64,linux/arm64 \  # 参考 https://github.com/docker-library/official-images#architectures-other-than-amd64
  -t YOUR_IMAGENAME:YOUT_IMAGE_TAG \
  --push \ # 构建完就 push（如果只想 build、不想 push，就去掉 --push）
  . # Dockerfile 所在的文件夹
```

## 删除空悬镜像

```bash
docker image prune
```

## 分析镜像

[dive](https://github.com/wagoodman/dive)

```bash
dive <your-image-tag>
```

## alpine vs distroless

Alpine 镜像的优点在于它的体积小且**包含了一个全功能的包管理器**：这意味着你可以轻易地在镜像中安装额外的软件包；但同时，这样可能会导致更大的攻击面，因为镜像中可能会包含一些并不需要的软件包

> 此外，Alpine 使用的是 musl libc 和 busybox，这可能会与一些 glibc 的应用产生不兼容问题

Distroless 镜像的设计理念是“**尽可能只包含应用运行所需的最小系统文件和依赖项**”，这可以降低镜像的攻击面，提高应用的安全性

Distroless **不包含任何包管理工具或 shell**，这意味着无法在运行时安装额外的软件包或在终端中运行命令，这对于需要提高容器安全性的应用来说是一个重大的优点

## busybox - Linux 瑞士军刀

集成了数百个 Linux 命令（例如 curl、grep、mount、telnet 等）的精简工具箱，只有几兆大小，可以用来做调试来查找生产环境中遇到的问题

```bash
docker pull busybox
```

## 快速启动 MySQL 实例

```bash
docker run -p 3306:3306 --name mysql -e MYSQL_ALLOW_EMPTY_PASSWORD=yes -d mysql
```

## 示例：Dockerfile - Go 语言

```dockerfile
# syntax=docker/dockerfile:1

# Build the application from source
FROM golang:1.22 AS build-stage

WORKDIR /app

COPY go.mod go.sum ./
RUN go mod download

COPY *.go ./

RUN CGO_ENABLED=0 GOOS=linux go build -o /main

# Run the tests in the container
FROM build-stage AS run-test-stage
RUN go test -v ./...

# Deploy the application binary into a lean image
FROM gcr.io/distroless/base-debian11 AS build-release-stage

WORKDIR /

COPY --from=build-stage /main /main

# Optional:
# To bind to a TCP port, runtime parameters must be supplied to the docker command.
# But we can document in the Dockerfile what ports
# the application is going to listen on by default.
# https://docs.docker.com/reference/dockerfile/#expose
EXPOSE 8080

USER nonroot:nonroot

ENTRYPOINT ["/main"]
```

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
