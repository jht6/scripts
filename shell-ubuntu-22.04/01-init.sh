#!/bin/bash

# 基于Ubuntu 22.04.4 LTS 搭建开发环境

# vmware环境下需要先修改以下配置文件,然后就可以向vm拖入代码文件了：
# sudo gedit /etc/gdm3/custom.conf
# 将 WaylandEnable=false 前面的#删除
# 重启后即可
# 参考: https://www.bilibili.com/read/cv22976086/

# ############### IMPORTANT ###############
# 必须进入到 shell 目录，用 sudo bash 执行
# #########################################

set -ex

echo "init-ubuntu.sh starts..."

exec_dir=$(pwd)

# 备份sources.list
sudo cp /etc/apt/sources.list /etc/apt/sources.list.bak
echo "[OK] 备份/etc/apt/sources.list -> /etc/apt/sources.list.bak"

# 把apt源替换为ali源，加快国内访问速度
# https://developer.aliyun.com/mirror/ubuntu
sudo cat>/etc/apt/sources.list<<EOF
deb https://mirrors.aliyun.com/ubuntu/ jammy main restricted universe multiverse
deb-src https://mirrors.aliyun.com/ubuntu/ jammy main restricted universe multiverse

deb https://mirrors.aliyun.com/ubuntu/ jammy-security main restricted universe multiverse
deb-src https://mirrors.aliyun.com/ubuntu/ jammy-security main restricted universe multiverse

deb https://mirrors.aliyun.com/ubuntu/ jammy-updates main restricted universe multiverse
deb-src https://mirrors.aliyun.com/ubuntu/ jammy-updates main restricted universe multiverse

# deb https://mirrors.aliyun.com/ubuntu/ jammy-proposed main restricted universe multiverse
# deb-src https://mirrors.aliyun.com/ubuntu/ jammy-proposed main restricted universe multiverse

deb https://mirrors.aliyun.com/ubuntu/ jammy-backports main restricted universe multiverse
deb-src https://mirrors.aliyun.com/ubuntu/ jammy-backports main restricted universe multiverse
EOF
echo "[OK] 替换apt源为ali源"

# 安装一些常用软件
sudo apt update
sudo apt install -y vim curl net-tools git traceroute
echo "[OK] 安装 vim curl net-tools git 等"

# 安装nodejs v20
cd /usr/local
wget https://registry.npmmirror.com/-/binary/node/latest-v20.x/node-v20.11.1-linux-x64.tar.gz
tar -xvf node-v20.11.1-linux-x64.tar.gz
rm node-v20.11.1-linux-x64.tar.gz
mv node-v20.11.1-linux-x64 nodejs_v20
sudo ln -s $(pwd)/nodejs_v20/bin/node /usr/local/bin
sudo ln -s $(pwd)/nodejs_v20/bin/npm /usr/local/bin
sudo ln -s $(pwd)/nodejs_v20/bin/npx /usr/local/bin
cd $exec_dir

# 设置npm源
npm config set registry https://npmmirror.com/mirrors/node/

# 安装启用ssh
sudo apt update
sudo apt install -qy openssh-server
sudo ufw allow ssh # 防火墙放通

# 设置常用别名
echo "alias l='ls -lha'" >> /home/$SUDO_USER/.bashrc
echo "alias ll='ls -lha'" >> /home/$SUDO_USER/.bashrc
echo "alias dk='docker'" >> /home/$SUDO_USER/.bashrc
echo "alias dkc='docker container'" >> /home/$SUDO_USER/.bashrc
echo "alias dki='docker image'" >> /home/$SUDO_USER/.bashrc
echo "alias ggco='git checkout'" >> /home/$SUDO_USER/.bashrc
echo "alias ggci='git commit'" >> /home/$SUDO_USER/.bashrc
echo "alias ggst='git status'" >> /home/$SUDO_USER/.bashrc
echo "alias ggps='git push'" >> /home/$SUDO_USER/.bashrc
echo "alias ggpl='git pull'" >> /home/$SUDO_USER/.bashrc
echo "alias ggad='git add'" >> /home/$SUDO_USER/.bashrc
echo "alias gglo='git log --oneline'" >> /home/$SUDO_USER/.bashrc
echo "alias gglg='git log'" >> /home/$SUDO_USER/.bashrc
echo "set number" > /home/$SUDO_USER/.vimrc

# 设置go加速镜像及环境变量
echo "go env -w GO111MODULE=on" >> /home/$SUDO_USER/.bashrc
echo "go env -w GOPROXY=https://goproxy.cn,direct" >> /home/$SUDO_USER/.bashrc
echo 'export GOPATH="/home/jht/go"' >> /home/$SUDO_USER/.bashrc
echo 'export PATH=$PATH:$GOPATH/bin' >> /home/$SUDO_USER/.bashrc

# 安装go
wget --no-check-certificate https://studygolang.com/dl/golang/go1.22.0.linux-amd64.tar.gz
sudo tar -zxf ./go1.22.0.linux-amd64.tar.gz -C /usr/local
rm ./go1.22.0.linux-amd64.tar.gz
sudo ln -s /usr/local/go/bin/go /usr/local/bin/go
sudo ln -s /usr/local/go/bin/gofmt /usr/local/bin/gofmt

# 安装 nginx
sudo apt install -y curl gnupg2 ca-certificates lsb-release ubuntu-keyring
curl https://nginx.org/keys/nginx_signing.key | gpg --dearmor \
    | sudo tee /usr/share/keyrings/nginx-archive-keyring.gpg >/dev/null
echo "deb [signed-by=/usr/share/keyrings/nginx-archive-keyring.gpg] \
http://nginx.org/packages/ubuntu `lsb_release -cs` nginx" \
    | sudo tee /etc/apt/sources.list.d/nginx.list
sudo apt update
sudo apt install nginx