#!/bin/bash
# 使用 pig 用户创建 margin-server 服务相关的表
# Docker 初始化时会执行此脚本
# SQL 语句在 /sql/03-create-margin-server-tables.sql 文件中

mysql -upig -p123456 < "/sql/03-create-margin-server-tables.sql"

