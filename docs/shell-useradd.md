# 创建用户（同名用户组、配置密码、免密提权）

```bash
#!/usr/bin/env bash

set -xeuo pipefail

# 需要以 root 运行，或者 sudo
if [ `id -u` -ne 0 ]
  then echo Please run this script as root or using sudo!
  exit
fi

UserID=3001
UserName=hello
UserPwd=world

# -m        创建用户的 home 目录，默认为 /home/$UserName
# -s SHELL  指定用户的 login shell
# -u UID    指定用户的 User ID
# -U        创建用户组，默认创建于 UserName 同名的用户组
useradd \
  -m \
  -s /bin/bash \
  -u $UserID \
  -U \
  $UserName

id $UserName

# 配置密码
echo "$UserName:$UserPwd" | chpasswd

# 免密提权
echo "$UserName ALL=(ALL) NOPASSWD:ALL" | sudo tee -a /etc/sudoers > /dev/null
```