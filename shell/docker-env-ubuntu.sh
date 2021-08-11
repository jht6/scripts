#!/bin/bash
# 在ubuntu内安装docker

echo "start.."

# 备份sources.list
cp /etc/apt/sources.list /etc/apt/sources.list.bak
echo "[OK] 复制/etc/apt/sources.list -> /etc/apt/sources.list.bak"

# 把apt源替换为ali源，加快国内访问速度
# https://developer.aliyun.com/mirror/ubuntu
cat>/etc/apt/sources.list<<EOF
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

# 安装必要依赖
apt-get -q update
apt-get -qy install \
  apt-transport-https \
  ca-certificates \
  curl \
  gnupg \
  lsb-release
echo "[OK] 安装前置依赖库"

# 添加docker阿里源的GPG key
curl -fsSL https://mirrors.aliyun.com/docker-ce/linux/ubuntu/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg
echo "[OK] 添加gpg key"

# 设置docker源为阿里源
echo \
  "deb [arch=amd64 signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://mirrors.aliyun.com/docker-ce/linux/ubuntu/ \
  $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
echo "[OK] 设置docker源"

# 安装docker
apt-get -q update
apt-get -qy install docker-ce docker-ce-cli containerd.io

# 将用户名加入docker组
usermod -aG docker $USER
newgrp docker

echo "All Done"
