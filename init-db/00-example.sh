#!/bin/bash
# 使用 pig 用户创建 example 数据库的表
# Docker 初始化时会执行此脚本
# SQL 语句在 /sql/00-example.sql 文件中

mysql -upig -p123456 example < /sql/00-example.sql

