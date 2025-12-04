#!/bin/bash
# 使用 pig 用户创建数据库
# Docker 初始化时会执行此脚本
# SQL 语句在 /sql/01-init-databases.sql 文件中

mysql -upig -p123456 < /sql/01-init-databases.sql

