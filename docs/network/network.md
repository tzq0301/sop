# 网络

## Google HK 服务器无法访问

访问 [www.google.com/ncr](www.google.com/ncr) 即可

原理：Google 有一个基于国家和地区的自动重定向功能，默认情况我们访问时会被重定向到 .hk 服务器，但是发现 .hk 有时会没有响应，/ncr 可以强制不使用地区重定向，直接访问 Google 原服务器，这个操作在下一次清理浏览器 Cookie 之前都是生效的

## Clash Linux 设置为 systemd

[/etc/systemd/system/clash.service](https://gist.github.com/mayocream/8d7a01440f59e4d85771f74e23ad4744)
