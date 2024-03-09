# 在ubuntu内安装docker
# 前置依赖：需先执行过 01-centos-init.sh

set -ex

# 安装docker-compose
cp ../file/docker-compose-linux-x86_64-2.7.0 /usr/local/bin/docker-compose

yum install -y yum-utils device-mapper-persistent-data lvm2
yum-config-manager --add-repo http://download.docker.com/linux/centos/docker-ce.repo
yum-config-manager --add-repo http://mirrors.aliyun.com/docker-ce/linux/centos/docker-ce.repo
yum install -y docker-ce-24.0.5-1.el7

# 启动, 并设为开机自启
systemctl start docker
systemctl enable docker