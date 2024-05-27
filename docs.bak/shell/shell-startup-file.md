# .bashrc | .zshrc

## 【自定义】bak 备份文件

```shell
function bak() {
  cp "$1" "$1.bak"
}
```
