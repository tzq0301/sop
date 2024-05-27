# Ansible

## Install

[Installing Ansible](https://docs.ansible.com/ansible/latest/installation_guide/intro_installation.html)

```bash
python3 -m pip -V                      # 查看 pip 是否可用（使用 pip 安装 Ansible）
python3 -m pip install --user ansible  # 安装 Ansible（若出问题，可参考 Python 配置国内镜像源）

# 安装完可能会有黄色的 WARNING，提示 /home/用户名/.local/bin 不在 PATH 中
# 此时，我们需要进行一下配置，否则无法直接使用 ansible
echo "export PATH=/home/$(whoami)/.local/bin:\$PATH" >> ~/.bashrc && echo source ~/.bashrc && echo "OK"

ansible --version
ansible-playbook --version
```

## Ansible Ad-hoc Commands

```bash
ansible pattern -m [module] -a "[module options]"

# /etc/ansible/hosts        默认的 inventory 文件
# /etc/ansible/ansible.cfg  默认的配置文件
# ~/.ansible.cfg            如果存在，就 override 默认的配置文件
```

## 兼容 CPU 架构

```yaml
- name: this is x86_64
  debug:
    msg: "Hello {{ ansible_architecture }}"
  when: ansible_architecture == 'x86_64'
- name: this is aarch64
  debug:
    msg: "Hello {{ ansible_architecture }}"
  when: ansible_architecture == 'aarch64'
```
