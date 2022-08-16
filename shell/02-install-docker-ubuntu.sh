#!/bin/bash
# 在ubuntu内安装docker
# 前置依赖：需先执行过 init-ubuntu.sh

set -ex

# 安装docker-compose
sudo cp ../file/docker-compose-linux-x86_64-2.7.0 /usr/local/bin/docker-compose
sudo chmod +x /usr/local/bin/docker-compose
echo "[OK] 安装docker-compose";

# 安装必要依赖
apt -q update
apt -qy install \
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
apt -q update
apt -qy install docker-ce docker-ce-cli containerd.io

# 将用户名加入docker组
usermod -aG docker $SUDO_USER # 因为是sudo执行，$USER是root
newgrp docker



echo ""
echo "All Done ^_^"
echo "Tips: 重启设备后即可省略docker命令的sudo"
