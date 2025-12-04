#!/bin/bash
# 使用 pig 用户创建表
# Docker 初始化时会执行此脚本
# SQL 语句在 /sql/02-create-tables.sql 文件中

mysql -upig -p123456 broker < /sql/02-create-tables.sql

