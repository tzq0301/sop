# Docker

* alpine: Alpine Linux 是一个轻量级的 Linux 发行版，它基于 musl libc 和 busybox，并且只包含了最基本的工具和库
* alpinelinux/build-base: 一个包含了构建和编译所需的工具和库的镜像，例如 GCC、G++、Make、libc-dev、binutils 等
* distroless: 不包含任何包管理工具或 shell，提高容器安全性
* busybox: 一个精简的 Linux 工具箱，包含了数百个常用的 Linux 命令，例如 ls、cp、cat、rm 等
* scratch: 一个空镜像，它不包含任何文件，因此无法运行任何应用程序，常用于作为基础镜像构建自己的镜像

```bash
# 快速启动 MySQL 实例
docker run -p 3306:3306 --name mysql -e MYSQL_ALLOW_EMPTY_PASSWORD=yes -d mysql

docker run --rm $(docker build . -q)

docker save -o helloworld.tar hello-world:1.0.0
docker load -i helloworld.tar

docker save hello-world:1.0.0 | gzip > helloworld.tar.gz  # gzip 压缩
docker load < helloworld.tar.gz

docker buildx build \
  --platform linux/amd64,linux/arm64 \  # 参考 https://github.com/docker-library/official-images#architectures-other-than-amd64
  -t YOUR_IMAGENAME:YOUT_IMAGE_TAG \
  --push \                              # 构建完就 push（如果只想 build、不想 push，就去掉 --push）
  $PWD                                  # Dockerfile 所在的文件夹
```
