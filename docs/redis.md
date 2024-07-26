# Redis

## 编译 Redis 源码

```bash
URL=https://download.redis.io/redis-stable.tar.gz

wget "$URL"

tar xf "$(basename "$URL")"

cd "$(basename -s .tar.gz "$URL")"

make
# make CFLAGS="-static" LDFLAGS="-static"

sudo make install
```
