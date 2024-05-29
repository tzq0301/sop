# Docker

## build & run 

```bash
docker run --rm $(docker build . -q)
```

## copy

```bash
docker cp <local-src-path> <container>:<dest-path>
docker cp <container>:<src-path> <local-dest-path> 
```
