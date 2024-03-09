#!/bin/bash
# 在装过docker的ubuntu中安装mongoDB 5.0-focal

# 拉取镜像
docker pull mongo:5.0-focal
echo "[OK] 已拉取镜像"

# 启动mongo服务
docker run -d -p 27017:27017 -v mongo_configdb:/data/configdb -v mongo_db:/data/db --name mongo mongo:5.0-focal
echo "[OK] 已启动mongo服务"

echo "可执行以下命令启动mongo shell:"
echo "  docker exec -it mongo mongo admin"
