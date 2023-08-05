#!/bin/bash

# 基于 CentOS 7 搭建开发环境
#
# 首先确保已安装 vmware-tools, 可以方便地向vm拖入文件
#
# 必须进入到 shell 目录, 以 root 身份执行

set -ex

echo "start"

exec_dir=$(pwd)

cat ../file/bashrc >> ~/.bashrc

# 安装 nodejs v16
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

echo "set number" > ~/.vimrc

# 安装 go v1.19
wget --no-check-certificate https://studygolang.com/dl/golang/go1.19.10.linux-amd64.tar.gz
sudo tar -zxf ./go1.19.10.linux-amd64.tar.gz -C /usr/local
rm ./go1.19.10.linux-amd64.tar.gz
sudo ln -s /usr/local/go/bin/go /usr/local/bin/go
sudo ln -s /usr/local/go/bin/gofmt /usr/local/bin/gofmt