#!/bin/bash
# 将刚安装的ubuntu初始化为好用的状态

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
sudo apt-get install -qy vim curl net-tools
echo "[OK] 安装vim curl net-tools"

# 安装nvm
# wget -O- https://raw.githubusercontent.com/nvm-sh/nvm/v0.38.0/install.sh | bash
# source ~/.bashrc
# echo "[OK] 安装nvm"

# 安装node
# nvm install 14
# echo "[OK] 安装Node v14"