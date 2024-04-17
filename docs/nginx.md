# Nginx

## 校验 Nginx 配置文件正确性

```bash
nginx -t
```

## 重新加载 Nginx 配置文件

```bash
nginx -s reload
```

## 配置文件 demo

```nginx
events {}

http {
    include /etc/nginx/mime.types; # 能根据文件的扩展名来设置 HTTP 的 Content-Type

    # 引入所有 .conf 文件
    # .conf 文件包含 server 块，可以用于文件的分离
    # include /etc/nginx/conf.d/*.conf;

    # upstream 用于配制服务器集群
    # backend-servers 可以替换为别的名字，该配置将在 server 块的 proxy_pass 中被使用
    upstream backend-servers {
        server localhost:3000;
        server localhost:3001;

        # 可以为不同性能的服务器设置不同的权重
        # server localhost:3000 weight=3;
        # server localhost:3001 weight=7;
    }

    server {
        listen 80;
        server_name localhost;

        # 静态文件的根目录
        # root /var/www/localhost; 

        # 设置默认的 index 页
        # index index.html;

        location / {
            proxy_pass http://backend-servers; # backend-servers 为上面配置的一个 upstream 服务器集群的名字
        }
    }
}
```