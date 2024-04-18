# Docker

## build & run 

```bash
docker run --rm $(docker build . -q)
```

## 删除空悬镜像

```bash
docker image prune
```

## 快速启动 MySQL 实例

```bash
docker run -p 3306:3306 --name mysql -e MYSQL_ALLOW_EMPTY_PASSWORD=yes -d mysql
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
```

## buildx 构建多架构镜像

```bash
docker buildx build \
  --platform linux/amd64,linux/arm64 \  # 参考 https://github.com/docker-library/official-images#architectures-other-than-amd64
  -t YOUR_IMAGENAME:YOUT_IMAGE_TAG \
  --push \ # 构建完就 push（如果只想 build、不想 push，就去掉 --push）
  . # Dockerfile 所在的文件夹
```

## 分析镜像

[dive](https://github.com/wagoodman/dive)

```bash
dive <your-image-tag>
```

## docker-compose.yaml 示例 - Go 语言

```yaml
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
