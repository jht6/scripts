# scripts

测试环境：
- ubuntu 20.04
- Oracle VirtualBox 6.0.8

## init-ubuntu.sh

```sh
wget -O- https://gitee.com/jht6/scripts/raw/main/shell/init-ubuntu.sh | bash
```


## docker-env-ubuntu.sh

一键搭建docker环境，使用方法：

1. 执行 `sudo ls`并输入密码
2. 执行以下命令
```sh
wget -O - https://gitee.com/jht6/scripts/raw/main/shell/docker-env-ubuntu.sh | sudo bash
```


一键搭建mongodb服务：

```sh
wget -O - https://gitee.com/jht6/scripts/raw/main/shell/docker-mongo-ubuntu.sh | sudo bash
```
