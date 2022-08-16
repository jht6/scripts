#!/bin/bash
# 将刚安装的ubuntu初始化为好用的状态
# vmware环境下需要先执行：
# sudo apt update && sudo apt install -qy open-vm-tools open-vm-tools-desktop && reboot

set -ex

echo "init-ubuntu.sh starts..."

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
sudo apt install -qy vim curl net-tools git traceroute
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

# 安装启用ssh
sudo apt update
sudo apt install -qy openssh-server
sudo ufw allow ssh # 防火墙放通