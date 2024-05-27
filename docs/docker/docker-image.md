# Docker 镜像操作

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

