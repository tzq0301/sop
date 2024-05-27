# Docker in Action

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
