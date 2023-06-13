#!/bin/bash
# 基于Ubuntu 20.04.2 LTS 搭建开发环境

# vmware环境下需要先执行以下命令安装增强工具,然后就可以向vm拖入代码文件了：
# sudo apt update && sudo apt install -qy open-vm-tools open-vm-tools-desktop && reboot

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
deb http://mirrors.aliyun.com/ubuntu/ focal main restricted universe multiverse
deb-src http://mirrors.aliyun.com/ubuntu/ focal main restricted universe multiverse

deb http://mirrors.aliyun.com/ubuntu/ focal-security main restricted universe multiverse
deb-src http://mirrors.aliyun.com/ubuntu/ focal-security main restricted universe multiverse

deb http://mirrors.aliyun.com/ubuntu/ focal-updates main restricted universe multiverse
deb-src http://mirrors.aliyun.com/ubuntu/ focal-updates main restricted universe multiverse

deb http://mirrors.aliyun.com/ubuntu/ focal-proposed main restricted universe multiverse
deb-src http://mirrors.aliyun.com/ubuntu/ focal-proposed main restricted universe multiverse

deb http://mirrors.aliyun.com/ubuntu/ focal-backports main restricted universe multiverse
deb-src http://mirrors.aliyun.com/ubuntu/ focal-backports main restricted universe multiverse
EOF
echo "[OK] 替换apt源为ali源"

# 安装一些常用软件
sudo apt update
sudo apt install -y vim curl net-tools git traceroute
echo "[OK] 安装vim curl net-tools"

# 安装nodejs v16
cd /usr/local
wget https://registry.npmmirror.com/-/binary/node/latest-v16.x/node-v16.15.1-linux-x64.tar.gz
tar -xvf node-v16.15.1-linux-x64.tar.gz
rm node-v16.15.1-linux-x64.tar.gz
mv node-v16.15.1-linux-x64 nodejs_16
sudo ln -s $(pwd)/nodejs_16/bin/node /usr/local/bin
sudo ln -s $(pwd)/nodejs_16/bin/npm /usr/local/bin
sudo ln -s $(pwd)/nodejs_16/bin/npx /usr/local/bin
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
echo "set number" > /home/$SUDO_USER/.vimrc

# 设置go加速镜像及环境变量
echo "go env -w GO111MODULE=on" >> /home/$SUDO_USER/.bashrc
echo "go env -w GOPROXY=https://goproxy.cn,direct" >> /home/$SUDO_USER/.bashrc
echo 'export GOPATH="/home/jht/go"' >> /home/$SUDO_USER/.bashrc
echo 'export PATH=$PATH:$GOPATH/bin' >> /home/$SUDO_USER/.bashrc

# 安装go
wget https://go.dev/dl/go1.19.4.linux-amd64.tar.gz
sudo tar -zxf ./go1.19.4.linux-amd64.tar.gz -C /usr/local
rm ./go1.19.4.linux-amd64.tar.gz
sudo ln -s /usr/local/go/bin/go /usr/local/bin/go
sudo ln -s /usr/local/go/bin/gofmt /usr/local/bin/gofmt
