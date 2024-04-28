# Go

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
