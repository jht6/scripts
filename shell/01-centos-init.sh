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

# 设置ali源
mv  /etc/yum.repos.d/CentOS-Base.repo /etc/yum.repos.d/CentOS-Base.repo.bak
wget -O /etc/yum.repos.d/CentOS-Base.repo http://mirrors.aliyun.com/repo/Centos-7.repo
yum makecache

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

# 移除旧版git, 安装新git
yum -y remove git
yum -y install curl-devel expat-devel gettext-devel openssl-devel zlib-devel asciidoc
yum -y install  gcc perl-ExtUtils-MakeMaker
wget --no-check-certificate https://mirrors.edge.kernel.org/pub/software/scm/git/git-2.23.0.tar.xz
tar -xvf git-2.23.0.tar.xz
cd git-2.23.0
make prefix=/usr/local/git all
make prefix=/usr/local/git install
echo "export PATH=\$PATH:/usr/local/git/bin" >> ~/.bashrc
source ~/.bashrc
cd $exec_dir
rm -rf git-2.23.0
rm git-2.23.0.tar.xz

# TODO install nginx

# 关闭防火墙
systemctl stop firewalld.service
systemctl disable firewalld.service
