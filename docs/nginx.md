# Nginx

## Install

```bash
sudo apt update
sudo apt install nginx -y
```

```bash
sudo yum install gcc openssl openssl-devel pcre pcre-devel zlib zlib-devel -y
sudo yum install nginx -y
```

## systemctl

```bash
sudo systemctl start nginx   # 启动
sudo systemctl status nginx  # 查看运行状态
sudo systemctl stop nginx    # 停止
sudo systemctl restart nginx # 重启
sudo systemctl reload nginx  # 修改配置文件后的重新加载
sudo systemctl enable nginx  # 设置开机自启动
sudo systemctl disable nginx # 取消开机自启动
```

## 校验 Nginx 配置文件正确性

```bash
nginx -t
```

## 重新加载 Nginx 配置文件

```bash
nginx -s reload
```

## 配置文件 nginx.conf 示例

```nginx
# 限制 Nginx 进程的权限，从而减少系统遭受恶意攻击的风险
# 通常，出于安全考虑，推荐不使用 root 用户运行网络服务
# user <username> [groupname];

# 设置 Nginx 将启动的工作进程数目
# worker_processes 5;     # 可以设置为数字
# worker_processes auto;  # 也可以设置为 auto，即 CPU 核数

events {
    # 应当根据系统的文件描述符限制来配置
    # 每个工作进程的最大连接数不应超过系统允许单个进程打开的文件描述符数量
    # 可以通过 ulimit -n 命令查看或设置这个限制
    worker_connections 1000;
}

http {
    # include /etc/nginx/mime.types; # 能根据文件的扩展名来设置 HTTP 的 Content-Type

    # 引入所有 .conf 文件
    # .conf 文件包含 server 块，可以用于文件的分离
    # include /etc/nginx/conf.d/*.conf;

    # upstream 用于配制服务器集群的【负载均衡】
    # backend-servers 可以替换为别的名字，该配置将在 server 块的 proxy_pass 中被使用
    upstream backend-servers {
        # ip_hash;

        server localhost:3000;
        server localhost:3001;

        # 可以为不同性能的服务器设置不同的权重
        # server localhost:3000 weight=3;
        # server localhost:3001 weight=7;
    }

    server {
        listen 80;
        server_name localhost;

        # 配置 HTTPS的 默认访问端口为 443
        # 如果未在此处配置 HTTPS 的默认访问端口，可能会造成 Nginx 无法启动
        # 如果您使用 Nginx 1.15.0 及以上版本，请使用 listen 443 ssl 代替 listen 443 和 ssl on
        # listen 443 ssl;
        # ssl_certificate     cert/cert-file-name.pem;  # 替换成上传的证书文件的位置
        # ssl_certificate_key cert/cert-file-name.key;  # 替换成上传的证书私钥文件的位置
        # ssl_session_timeout 5m;
        # 表示使用的加密套件的类型
        # ssl_ciphers ECDHE-RSA-AES128-GCM-SHA256:ECDHE:ECDH:AES:HIGH:!NULL:!aNULL:!MD5:!ADH:!RC4;
        # 表示使用的 TLS 协议的类型，您需要自行评估是否配置 TLSv1.1 协议
        # ssl_protocols TLSv1.1 TLSv1.2 TLSv1.3;
        # ssl_prefer_server_ciphers on;

        # 静态文件的根目录
        # root /var/www/html;

        # 设置默认的 index 页
        # index index.html;

        location / {
            # proxy_pass 配置【反向代理】
            proxy_pass http://backend-servers; # backend-servers 为上面配置的一个 upstream 服务器集群的名字
        }

        # 域名解析
        # resolver 8.8.8.8;          # Google 公司提供的 DNS，该地址是全球通用的，相对来说，更适合国外以及访问国外网站的用户使用
        # resolver 114.114.114.114;  # 国内移动、电信和联通通用的 DNS，手机和电脑端都可以使用，干净无广告，解析成功率相对来说更高，国内用户使用的比较多，而且速度相对快、稳定，是国内用户上网常用的 DNS
    }
}
```

## docker-compose.yaml 示例

```yaml
version: "3"

services:
  gateway:
    image: nginx:latest
    entrypoint:
      - sh
      - -euc
      - |
        cat <<EOF > /etc/nginx/nginx.conf
        user  nginx;
        worker_processes  5;  ## Default: 1

        events {
          worker_connections   1000;
        }

        http {
          resolver 127.0.0.11;

          server {
            listen 3100;

            location = / {
              return 200 'OK';
              auth_basic off;
            }
          }
        }
        EOF
        /docker-entrypoint.sh nginx -g "daemon off;"
    ports:
      - "3100:3100"
    healthcheck:
      test: ["CMD", "service", "nginx", "status"]
      interval: 10s
      timeout: 5s
      retries: 5
```
