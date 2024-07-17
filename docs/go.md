# Go

## Library

* [google/safetext](https://github.com/google/safetext) 防止 yaml 注入和 shell 注入，用于替代 `text/template`
* [google/safeopen](https://github.com/google/safeopen) 防止路径遍历攻击（例如：指定一个受信任的根目录后，文件操作不能超过该目录）
* [google/safearchive](https://github.com/google/safearchive) 防止路径遍历攻击和处理归档文件相关的攻击（例如 `./././././etc/cron.daily/cronjob`），支持跳过特殊文件、净化文件名、防止通过符号链接进行遍历等
* [uber-go/automaxprocs](https://github.com/uber-go/automaxprocs) 读取 CGroup 值，以识别容器的 CPU quota，计算得到实际核心数，并自动设置 `GOMAXPROCS` 的值
