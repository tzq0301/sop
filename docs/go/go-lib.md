# Go Library

## [uber-go/automaxprocs](https://github.com/uber-go/automaxprocs)

在 Docker Container 容器中，`runtime.GOMAXPROCS()` 获取的是**宿主机的 CPU 核数**，那么当使用 cgroups 对容器的 CPU 进行限制、但 Go 程序仍使用宿主机核数时，就会造成【 P 值设置过大，导致生成线程过多，会增加上线文切换的负担，造成严重的上下文切换，浪费 CPU 】的问题

因此，需要使用 [uber-go/automaxprocs](https://github.com/uber-go/automaxprocs) 来读取 CGroup 值，以识别容器的 CPU quota，计算得到实际核心数，并自动设置 `GOMAXPROCS` 线程数量

```go
package main

import (
	"runtime"
	
	"go.uber.org/automaxprocs/maxprocs"
)

// docker run --rm            $(docker build . -q)
// docker run --rm --cpus="2" $(docker build . -q)

func main() {
	maxprocs.Set()  // <- here 

	println("GOMAXPROCS: ", runtime.GOMAXPROCS(0))
	println("NumCPU:     ", runtime.NumCPU())
}
```

## 安全加强库

* [google/safetext](https://github.com/google/safetext) 防止 yaml 注入和 shell 注入，用于替代 `text/template`
* [google/safeopen](https://github.com/google/safeopen) 防止路径遍历攻击（例如：指定一个受信任的根目录后，文件操作不能超过该目录）
* [google/safearchive](https://github.com/google/safearchive) 防止路径遍历攻击和处理归档文件相关的攻击（例如 `./././././etc/cron.daily/cronjob`），支持跳过特殊文件、净化文件名、防止通过符号链接进行遍历等
