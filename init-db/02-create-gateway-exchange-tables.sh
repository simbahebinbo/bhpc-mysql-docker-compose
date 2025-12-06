#!/bin/bash
# 使用 pig 用户创建 gateway_exchange 数据库的表
# Docker 初始化时会执行此脚本
# SQL 语句在 sql/02-create-gateway-exchange-tables.sql 文件中

mysql -upig -p123456 < "/sql/02-create-gateway-exchange-tables.sql"

