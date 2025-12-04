#!/bin/bash

# 查看容器日志

# 当前项目的主要容器名
containers=("mysql-server")

for container_name in "${containers[@]}"; do
  docker logs -f $container_name
done
