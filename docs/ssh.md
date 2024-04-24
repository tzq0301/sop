# ssh

* [SSH 教程 - WangDoc](https://wangdoc.com/ssh/client)

## ssh 执行脚本

```bash
ssh $Username@$IP 'bash' < $SHELL_FILEPATH

# -s 后面可以跟 Shell 文件所需要的参数
ssh $Username@$IP 'bash -s 1 2 abc' < $SHELL_FILEPATH

ssh $Username@$IP 'bash' <<EOF
echo 1
echo 2
EOF
```

## 生成 ssh 密钥

所有交互都直接按回车的话，会生成（1）公钥文件 ~/.ssh/id_rsa.pub（2）私钥文件 ~/.ssh/id_rsa

```bash
ssh-keygen
```

生成密钥以后，建议修改它们的权限，防止其他人读取：

```bash
chmod 600 ~/.ssh/id_rsa
chmod 600 ~/.ssh/id_rsa.pub
```

## ssh 连接远程服务器

```bash
Username= && Password= && IP=
sshpass -p $Password ssh $Username@$IP
```

## 实现免密登录 - 将自己的 ssh 公钥 copy 到服务器上

将本机的 ~/.ssh/id_rsa.pub 公钥追加到远程服务器的 ~/.ssh/authorized_keys

```bash
Username= && Password= && IP=
sshpass -p $Password ssh-copy-id $Username@$IP
```

## ssh 连接流程

ssh 连接远程服务器后，首先有一个验证过程，验证远程服务器是否为陌生地址

如果是第一次连接某一台服务器，命令行会显示一段文字，表示不认识这台机器，提醒用户确认是否需要连接

```
The authenticity of host '192.168.0.110 (192.168.0.110)' can't be established.
RSA key fingerprint is a3:ca:ad:95:a1:45:d2:57:3a:e9:e7:75:a8:4c:1f:9f.
Are you sure you want to continue connecting (yes/no)?
```

ssh 会将本机连接过的所有服务器公钥的指纹，都储存在本机的 `~/.ssh/known_hosts` 文件中，每次连接服务器时，通过该文件判断是否为陌生主机（陌生公钥）

如果服务器的密钥发生变更（比如重装了 SSH 服务器、有人恶意冒充远程主机），客户端再次连接时，就会发生公钥指纹不吻合的情况，这时，客户端就会中断连接，并显示一段警告信息：

```
@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
@    WARNING: REMOTE HOST IDENTIFICATION HAS CHANGED!     @
@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
IT IS POSSIBLE THAT SOMEONE IS DOING SOMETHING NASTY!
Someone could be eavesdropping on you right now (man-in-the-middle attack)!
It is also possible that the RSA host key has just been changed.
The fingerprint for the RSA key sent by the remote host is
e9:0c:36:89:7f:3c:07:71:09:5a:9f:28:8c:44:e9:05.
Please contact your system administrator.
Add correct host key in /home/jiangxin/.ssh/known_hosts to get rid of this message.
Offending key in /home/jiangxin/.ssh/known_hosts:81
RSA host key for 192.168.0.110 has changed and you have requested strict checking.
Host key verification failed.
```

解决方案：

如果新的公钥确认可以信任，需要继续执行连接，你可以执行下面的命令，将原来的公钥指纹从 `~/.ssh/known_hosts` 文件删除

```bash
HOSTNAME=发生公钥变更的主机名
ssh-keygen -R $HOSTNAME
```

临时解决方案：

```bash
# ssh 加上参数
-o StrictHostKeyChecking=no
```

## sshd 查看当前生效的 ciphers

```bash
sudo sshd -T | grep cipher
```

## 查看 /etc/ssh/sshd_config 配置的 cipher

```bash
cat /etc/ssh/sshd_config | grep Ciphers
```
