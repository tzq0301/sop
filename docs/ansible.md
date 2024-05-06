# Ansible

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
